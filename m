Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30235245008
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376083; cv=none; b=U0ArmxAV3Fzy3+so9aWbP6k3qPcNaGvB7MM1aWuyOPzd0OsgGOjwUdsSO3trZvgDEe80HPSr6cGG020YAESqcgBmDWZWk7DVrzT1Pt5anG2puieU+rbiS8UbabIxQBb4K9CyjjVXJtQWFVZ0QwBtMtS/WqAihafk/4ttB5IfCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376083; c=relaxed/simple;
	bh=P3Du/sxDwZDkM3QzxJvPrULyH8CHODo3WrDMlwx/Wbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuX/yNohbnh5NrJDtu6eswTgKfyIh2EDrnl6KGBEWSUW5NP8cvmyNYtmmbM3RGDqKgFp3sLfHMsZGwuP9mvlt+IAcEXzsYEnRGOiYPjXi9haetCxZoa692hCy4IyCfu1J4g+lgr4boTrJ/ql0MipzyXlA5N6y5wzsYxqrTFtIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pn4R14/1; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pn4R14/1"
Message-ID: <7e61d730-f897-443c-9d02-04ec456e1367@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785376078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aTRGlYyjZSyhtoM/FAMAXq/kozne1gtzVWc4ALsdKw=;
	b=Pn4R14/1pYXnsyfU35pAdfGuMAPgXd7ksiHEyTwfD4EeGfRM3Oa/ji+9jhnA4qwun/4v6e
	viGJ3HMkL9Xd26VIOwJOJXTxBISXof2WeHRaPdrOQtdQq0l73ty96bwatNacivy/dQBJw8
	rCn3+qjk8v0Jayoo41q6uCxtYhHV5wQ=
Date: Thu, 30 Jul 2026 09:47:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: phy: dp83640: fix per-bus clock lifetime
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260724023532.14583-1-xuanqiang.luo@linux.dev>
 <20260728190340.780d3f63@kernel.org>
 <73276f2b-9a0a-40d6-bf5f-9d23d2731c57@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <73276f2b-9a0a-40d6-bf5f-9d23d2731c57@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/7/29 21:39, Andrew Lunn 写道:
> On Tue, Jul 28, 2026 at 07:03:40PM -0700, Jakub Kicinski wrote:
>> On Fri, 24 Jul 2026 10:35:32 +0800 xuanqiang.luo@linux.dev wrote:
>>> Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
>>> removal handling") moved per-bus clock cleanup from module exit to the
>>> remove path. This leaves two lifetime problems.
>> Isn't this sort of shared PHY resource problem supposed to be solved
>> using the PHY package API?
> Ah! Sorry, my reply was completely wrong, now that i have looked at
> the patch.
>
> We have clocks and we have clocks. To me, a clock is something which
> uses the common clock framework, because it is a clock. clk_get,
> clk_enable, clk_disable.
>
> And then we have these PTP things, which some people call clocks, but
> they are something else. And in this patch, we are talking about this
> something else.
>
> And you are correct, it does appear to be one of these PTP things
> which is shared by a number of PHYs. So yes, the PHY package API
> should be used here.
>
> Xuanqiang please take a look at drivers/net/phy/phy_package.c, and the
> PHYs which use it. It should help solve your lifetime problems.
>
>      Andrew
>
> ---
> pw-bot: cr
>
Thanks Jakub and Andrew for pointing this out.

That does look like a much cleaner way to handle the lifetime of the
shared PTP clock.

I'll rework the patch and send a v2.

