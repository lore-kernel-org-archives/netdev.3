Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB93BB124;
	Sat,  5 Sep 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640945; cv=none; b=ZxCfIGGZu6h6OgIkUnlbfpC2oNxR07FDvzKUgyIp3VtMOkbb8BOeXYchQQuuDBeFbi7+a+WPO+KgouRU9vPQ8N7/sZTGQ/nL24ZST53xyFlEfCA/IIpwkLVqxZmyEnO35c7r8TK20XUpArvEX05/vD0/b9GQLoHqwoFpLmq45QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640945; c=relaxed/simple;
	bh=/fAPAdx4/GzrMW/hwBWEwYUpO5jDoI9jcjDG21RXJhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asFoZf2zn4cHh/cyf4ZI2DUIUrmmE7xe5nKIX/DHHo/AI6QMNM0Ls+pLB2ygWwuNR4TKKGA2r9TsrxDi3sp+Eory0Uqbf9n2U5Duf9w3wcbFEjTouTpQ4117EKH2Rb2SQ24nw8SIW+A442awGhb8di5Me0caeWOqNPEfSCWgiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYKflOhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYKflOhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C291F00A3A;
	Sat,  5 Sep 2026 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640942;
	bh=8nsdlGIzl2XD+lbi7c8VIZD6pHl0s5VgaJBuohl7ScY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eYKflOheSYbP4/XvNREJPf4QZJ9D5B7uykHiqol23mylQxF94A/ESnQnDqeUc7mMA
	 ryhIwZ5g1gLLpoWarmz8bw9XteZuJPpfElusN02e1l2lGoMkYpGyhFP442w0mlU5Ob
	 wvqzteuTsI+x3bAiVj1GOHTC1DZHwTegXi11embCssWHOzwvM1Muue2MPT8FfiyxeU
	 FqjmcvAT+iqJgWi0Anx7OhlGOgT6hhvFLUvXmOT88Ykeir3W0KkmQMCzHDiZPUoz3a
	 ks86L3XmYaGqYTfQvwE5VEpZ+RzHWI9klyBQjE5Kg6UMXSSS/wLtYCTXayEBvfBKwX
	 CSeOQoP1eTrYg==
Date: Sat, 5 Sep 2026 13:42:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <jhs@mojatatu.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: sched: act_gact: use acquire/release
 for tcfg_ptype
Message-ID: <20260905134221.233ae6b5@kernel.org>
In-Reply-To: <20260902071659.395509-1-ruanjinjie@huawei.com>
References: <20260902071659.395509-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 15:16:59 +0800 Jinjie Ruan wrote:
> @@ -160,7 +155,8 @@ TC_INDIRECT_SCOPE int tcf_gact_act(struct sk_buff *skb,
>  
>  #ifdef CONFIG_GACT_PROB
>  	{
> -	u32 ptype = READ_ONCE(gact->tcfg_ptype);
> +	/* Pairs with smp_store_release() in tcf_gact_init() */
> +	u32 ptype = smp_load_acquire(&gact->tcfg_ptype);
>  
>  	if (ptype)
>  		action = gact_rand[ptype](gact);

Clashiko points out that you are turning what used to be a conditional
barrier into one that's always obeyed, even if ptype is 0.
-- 
pw-bot: cr
