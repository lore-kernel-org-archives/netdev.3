Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0721D5AF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755752; cv=none; b=Zs4NEQEvyOgVypvPKckr/et7Jop5Cr+has+c4TGHDipIxzBXPM+jwiAkaKbZRliyMbStde16PSxZK0OjFyDbgbPYssdBmIEvf9GOlGSkB1zxpMbSJ2HafSeVi1hK3HvaMkvwJUlPZKvIiF1Q2lJdxiKmsmMZWWUaaoAfIkoum+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755752; c=relaxed/simple;
	bh=dh5wCK0lHCrCxrrHLiVzXvxBW2zSxafnp2sTztekImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVXRup+KSueUKyHRpXo75u/t8UYyj54YeM5U+q3b6tP8jfHMHwkz75drb2cH8cD5ku1jmBh/lelyWAeHAf8VPAFG0dT2MY+iHfWjDOQvhGGj+PhFZ8dQctn+2fC5qAE31GjcZ43xNY0E+RrJR7yqu7219/FbQuq7rqZvS+LEhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lUtFJCZm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lUtFJCZm"
Message-ID: <efea4e44-e9cd-444d-a648-8831f408acbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781755748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRNtQtrmBi3UmEh4UWSO7FkcYQWctEZwQil6uxg8zgc=;
	b=lUtFJCZmCZIl2AfZL4/j39wxxE1OV10WNoWd8u0jUDD1ywF+p1BcuO8tB4dqJ6AW4BO6e2
	eRtPeZJLUVSeQqxYUsl3fRm9sduJ4wM1q9a7XLyGuP8FR3G8SS+y2v18nh46BMU+mJqH4D
	Dq92jktXbnAkSAIftxFGlIMiwN+iaZE=
Date: Thu, 18 Jun 2026 12:08:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
To: Weiming Shi <bestswngs@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260617065512.2529757-2-bestswngs@gmail.com>
 <e8ace4ba-31cb-40d7-b288-eeb411f8d0ef@linux.dev>
 <DJBD6SGYRIHX.1IHLCVG9YYTNJ@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DJBD6SGYRIHX.1IHLCVG9YYTNJ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/17/26 9:38 PM, Weiming Shi wrote:
> On Wed Jun 17, 2026 at 4:32 PM CST, Jiayuan Chen wrote:
>> On 6/17/26 2:55 PM, Weiming Shi wrote:
>>> accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
>>> and dereferences idev->cnf.accept_untracked_na without a NULL check,
>>
>> Does ipv6_rpl_srh_rcv have same problem?
> Hi,
>
> Yes, ipv6_rpl_srh_rcv() has the same missing check. It reads
> idev->cnf.rpl_seg_enabled right after __in6_dev_get(skb->dev) with no
> NULL check, while seg6 and ioam6 in the same file both check it.
>
> But I tried to trigger it and couldn't. With a guard added as an instrument,
> idev never came back NULL over tens of millions of RPL packets while
> flapping the MTU, so I can't say it's actually reachable.


Can you need to add mdelay to enlarge the race window to reproduce it?

I believe we need more precise traffic and timing control, instead of
aggressively ramping up traffic and load in an attempt to reproduce the 
issue.

