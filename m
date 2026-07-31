Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920453CB2DF
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.209.48.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493100; cv=none; b=bGnIhEdXtKuCgcE0PRKAKSISYRTag4QBfGMnZxL8MAeXy9ZsFuMLEG6KwJUPgVsHHypUof3FEJAV5HQuRaZ0lIGPjjT3bjHKNHIGuwMMNIJA6v9EcKXk2GM8hxODdp1ht3AVcUGPpuWTiG0YhHd8oGLBJKu1Ue3WyWSsQrcboWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493100; c=relaxed/simple;
	bh=AKb0P876dPlJEu85flHgJKZhU+2+90AOd6wIoxtagGQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FTlU6gh6xGyfqH0XfrdPQP9c68L0Q7uL5IlvIpUSr/fBvVZIu3xdk59iyWPFPpG/hv6l10C2kq0Mwj3Y78GGZu6vHI0UvoDUXLXM3oEJlgsqxc9f30n/ia+eoKuoo3/ezFOdK7I+D0GQT5mX0fDGf1VoiGS0wrgePBsmvta1ckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=GYwNw3/j; arc=none smtp.client-ip=178.209.48.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agner.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="GYwNw3/j"
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 2A8995C2FCE;
	Fri, 31 Jul 2026 12:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1785493088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WvFlw83oU3ardfbEeUhO1Sko4VPKFXB5H/G+vZZef4=;
	b=GYwNw3/jgqL5pPBLHw4ZhaBexSS1iEeY5I1u0EYDj2TLnehO1MigECOy3f8gxhtmlGdImw
	zeDsgWuBDH7+gDv3b3yyoZDbwKIu0t+5ZkCtrU0WvgZSNil8Ga20WfJ0qt5AMVC6SRYR2K
	nWL4S+ibCo9l+X1Kvb+/nCQb9rAzXaM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 31 Jul 2026 12:18:08 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup when
 opening the interface
In-Reply-To: <ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>
References: <message-id-of-your-v1-mail>
 <20260707195425.405989-1-stefan@agner.ch>
 <CGME20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1@eucas1p2.samsung.com>
 <ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>
Message-ID: <9f7506a99b22293bae3f467f64506627@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 2026-07-07 23:13, Jakub Raczynski wrote:
> Please read
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> in this case 'don’t repost your patches within one 24h period'
> 
> Because:
> - you have two patches now processing and no changes requested yet,
>   nor did you get AI review that is currently employed
>   https://patchwork.kernel.org/project/netdevbpf/patch/20260707195425.405989-1-stefan@agner.ch/
>   and
>   https://patchwork.kernel.org/project/netdevbpf/patch/20260707162146.73823-1-stefan@agner.ch/

Isn't the definition of "repost" the same patch?

I took Andrew Lunn's comment as a change request, hence v2...

> - This change is actually broken - in previous patch rtnl_lock() was asserted
>   by dev_ioctl(), but in this version it is not asserted anywhere and will
>   trigger WARN_ONCE().
> - Full tests within an hour is possible, but no need to rush patches
> - Please spend time reviewing patches, as I spent few minutes to make sure
>   you (or rather Fable AI) is correct that rtnl_lock() was asserted, so my
>   review would be accurate (previous patch was ok, this is not).
> - Please respond yourself to comments, take time to understand codebase.
>   I would prefer not getting copy-paste answer from AI,
>   we have Sashiko review for that.

I am guessing you allude to my response at
https://patchwork.kernel.org/project/netdevbpf/patch/20260707162146.73823-1-stefan@agner.ch/#27051411

Can I influence the prompt for Sashiko? From my point of view the
response was for a specific architectural questions, which needed a
specific prompt to get the answer for. I've clearly declared that I've
used AI to aid for this discussion, is that no allowed?

> - Missing link to previous thread, shown below
> - Moving code to other lines does not justify dropping "Assisted by AI"

Whoops, yeah those two are failure on my part. Sorry about that.

Thanks for your help guiding me through the process! I intend to send
out v3, which at this point looks to be pretty much v2 plus formal fixes
and adding a tested by tag.

--
Stefan
