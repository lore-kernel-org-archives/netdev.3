Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EB348C55;
	Fri,  3 Jul 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063666; cv=none; b=KD/f/akkkaOhFjedo8/Q6HH8h4Yg7G4RpYNS0KBOnGKT97ggiJXMJfyFYaSifQBKLLLrAc7cQGFixvD1mO9c3EJ2lwJ8qvDIV3/81A00QX8ddI/syMqGjSt3nPPscRho581eQNcgp2fGsshl/jDCz7Dt/eObGah5ZQFe+LrvbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063666; c=relaxed/simple;
	bh=Ol2r02z849sHO076/l5rhr6sDWIOhUOJQgfcHd2d/Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYFB1SU+usID316waVhxXWCexjus1LDkMhWhrEUmvhYjhWKQIiFXKgVTZXBRoGjaeja0G6cBoH+bXfnXNp5jzrtiQP5rwkt9eu8PgHMLRMMRiMBsPxRsLP0dzWZWchO4vVpE0YFyjwdFTscjkj+ye5FBz4ZD1UQQqj3VARp2djA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wxnTB1je; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wxnTB1je"
Message-ID: <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783063661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYPGG7oSyvpEIFDIsiAE2WqgUhJkjiEWYW22I8750Tc=;
	b=wxnTB1jeUQocK9BJWSWnjlsQalb4qukGei3yxMDTzYi/kReANBZ5285tIel93bEksGwYwQ
	eJ4Z5DVLh0u9YcH6KUJMPB72vge4kJMe4XJEuqDiHMjcQjQWxlmDl6i0VUUV5KDsWzq0e9
	vdLYeL7a+o95A2opkTviuEFAOZx976g=
Date: Fri, 3 Jul 2026 15:27:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
To: Norbert Szetei <norbert@doyensec.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Breno Leitao <leitao@debian.org>, Taegu Ha <hataegu0826@gmail.com>,
 Kees Cook <kees@kernel.org>, linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
 netdev@vger.kernel.org
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2026/7/2 2:12, Norbert Szetei wrote:
> +/* Purge after the grace period: a late ppp_input() may still queue an
> + * skb on pch->file.rq before the last RCU reader drains.
> + */
> +static void ppp_release_channel_free(struct rcu_head *rcu)
> +{
> +	struct channel *pch = container_of(rcu, struct channel, rcu);
> +
> +	skb_queue_purge(&pch->file.xq);
> +	skb_queue_purge(&pch->file.rq);
> +	kfree(pch);
> +}
> +
>   /*
>    * Drop a reference to a ppp channel and free its memory if the refcount reaches
>    * zero.
> @@ -3581,9 +3594,7 @@ static void ppp_release_channel(struct channel *pch)
>   		pr_err("ppp: destroying undead channel %p !\n", pch);
>   		return;
>   	}
> -	skb_queue_purge(&pch->file.xq);
> -	skb_queue_purge(&pch->file.rq);
> -	kfree(pch);
> +	call_rcu(&pch->rcu, ppp_release_channel_free);
>   }
>   
>   static void __exit ppp_cleanup(void)

AI-review found an issue: 
https://sashiko.dev/#/patchset/D9C0245B-608B-4884-8A09-F55BA4A9F948%40doyensec.com

An rcu_barrier() call is needed at the end of ppp_cleanup().

Regards,

Qingfang

