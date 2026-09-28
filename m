Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7694349B4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583143; cv=none; b=LIciKFd/qPEPo0Gq7OqzpWNAhEPx/EV7KYeIS2+25TqRj88CQoMgEjczjp5j411UWzYaKbDoIvJBBUS5lLYkmr89arcdAL5vDrQeTVwf4dTknQpPEmIY0MN9JuOteYyJwOuDVhpI/Wi7vLuSFyQwZD8qUrMc4j0urZZo5cDAq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583143; c=relaxed/simple;
	bh=TyxHn0Wu36KDiL8WwciFmuuaKn7lMO1TcQeqTgcWM4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im/PvBXdpSW5+kTu+avbLncr2jdZDgwQBK+eXZJoh+GhjfipUHTiftU2Fqy/plNGY0HUvhjcS7wo7VCICRh0AbqACqsQ5N+tOAoUXetiqDwf6iugad54NX/0CKD2iqHnQEcIqx7guJyENuXkg2X2woMtLnQSp/LnYC/Xl5zj2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ee08tlh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTwzN8bq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ee08tlh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTwzN8bq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 413CEEC00EA;
	Mon, 28 Sep 2026 04:12:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 04:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790583141; x=
	1790669541; bh=fUO05wwfDPp2cjcPTEwadUMo5hF4h04UFs4Nk0G7upA=; b=e
	e08tlh63IaOU31HHj92beLyc+ViSfkFc4Nf7ffmUp3QDslLgJqNetinp03bmn8DF
	a7VxWJIgbRHZqWmbzR1gBJw8Vt/HWngVKhpqUjnWxS1f778jjE7ARdNg5C5c2uUG
	GfHlHYGqfjFt87uUXSDf/pXT6NKRoyze3PvvTWcMHb3HyOlLKEQlx0Vc3pyaLSK9
	cRar0uW53N+qfFLwXAT6ot6fS05PHbDgUY8U/vVWkbPaAsDqBXobadYIQ9VbWAYN
	IWJ3cwxAbSeuE1tILef321x3ZOj1TO5j4LrgEtAylfwcA5yH8nw+tyUdn90XWkru
	4aahekpZTFMvdTppbR6gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790583141; x=1790669541; bh=fUO05wwfDPp2cjcPTEwadUMo5hF4h04UFs4
	Nk0G7upA=; b=TTwzN8bqDlNo8i9GTOUreXrNF78Pnf/pkWEYtvJs+GNsNK8jB3v
	CqITp03ggPh84KA/kEJ+vE4hS6CgU9GOb9sArRAVGGtICaPfxcH9RxpWzQwr+hx8
	ETJvXq9rKoy4jByJrrhvHpg8BxfgSmafhdtdcDQauQ4GTKFxDhXgilaW2vayC2DF
	DzoxxJx4NHr3Bt91RoyfpiEW2bmL3GoGXnqAel7Zexp6kmmNPfaIuNUAzx8B8hyt
	SnNz1aHAH5asf8HlRPRC6CTyONhEUMxt7waXZCttkvouiNhGNt6DILg2LwreogPI
	y8FQXfAEownSjM9q+Z0rLM5n5SK4Ax2GlaQ==
X-ME-Sender: <xms:ZSG6apZvdgA3kNUfdXaSUxJdGi8Knqo9Es77gxhPV99cJHBERBwePg>
    <xme:ZSG6ambmiWVqPsaAiuLf3VBA0-F9HKzuW3G5nma-i2kwe1J56lAUc7PpF-yPYz8QN
    sFU5T9I2fKkgYLQb7TcGP5yPOi190J73BkTW3-Cwl2wwPPnu6Qvt9lA>
X-ME-Received: <xmr:ZSG6apmzBy9-szdF-FlV2XdXsZQ5esfaQHz4ZzbABbLLlvKiQ2ysUO-no7L9>
X-ME-Proxy-Cause: dmFkZTECWVJZRwmsUQHyQdPhZJRQny9omh7UV1fHsun8O48PDyi9yvGz1lzESyhsZqn+ct
    GbsVOUP+CGtRWNkmzGvAGYCybz4XObf+fznuHaV4gE0vrMtoTFA62dlH3R7fsf3PiV7P1o
    qjQmVXuimLZ442ctKap9M/PjqSJNq0WNuZj/zsQB+Fp+MyAFuOVuolNjN8Kj83af5PZ4Z9
    PeAqT+pJzBDv87v2mpVzTsO/dYCSImdxzGhlCTe0dKu0VGcPnWUgDIUx6z580X4/H9879q
    Zd9t6qRpevB/ZDYtEqeNPLY5H63IipEA5kPmr2LOFa2bBsOaCborxYbLw45yVYadU9kfHc
    Yaz/VtU5f9YMTZZK2oRIsQ2qMNqqyfjuDcbwFS+ooRZ1IeBzfQvE/O/0Z31xVgfaTemJNf
    dYDd6PZctXBP+tFcuht52bNgeEn/bre5JSZCzuh9re49Qzm1yblYL2/axyyaI8zNlZrxEY
    /Tqi8yrtBzQWKtchKPF+QkDtTI9Gxvae+1+zDCZ8SqTG/5UbcPuw+2cZZRpEec+ZWifvSI
    o2WtKrMhhBjKtfp1Sno2G8M9J8H+qqxXAecg+7l3Sdom/yT5VhFCmwEz+HOkEITxzeHzcb
    MhQbU0cV1qSBXRhggaTMmZBQHSvJlfOjq/4GjIQqUs7Yu4FTAYVIDJfOIXaA
X-ME-Proxy: <xmx:ZSG6aiw3iVgBLRswNAODxBAkhSgUwgmIOkgI2KZNj8qWh92PJqqpmw>
    <xmx:ZSG6anODVOjyLAmceA_As8b5QeE-QNw8sTlJATOsE2QvxVjI2PYU3A>
    <xmx:ZSG6amQ1sV8n4qswtrWy-PoifQuL-r-KACQMJi-KTCchrrSIP3F4Dg>
    <xmx:ZSG6alZGMMDluFx0Ke1AzDDx7ZOQQj4JlTZ9gNZsHo5QucFn5XnZ4A>
    <xmx:ZSG6avLz_5DhOgKeR4fMZocv6R0jb04ZmwqzT3SaLFUgvmLLF_9y7ckP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 04:12:20 -0400 (EDT)
Date: Mon, 28 Sep 2026 10:12:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <arohYhcuP2dZa8Qr@krikkit>
References: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>

2026-09-25, 15:51:58 +0200, Sabrina Dubroca wrote:
> The comment above strp_done() claims that if strp is stopped,
> strp_recv will no longer be called. That's only true if the caller has
> a mechanism (eg locking) to guarantee that strp_recv() calls that
> started before strp_stop() have completed by the time we call
> strp_done().
> 
> This adds a lock_sock/release_sock pair to guarantee that any
> in-flight strp_recv() (which runs under either bh_lock_sock or
> lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> has completed.
> 
> Only espintcp can be affected by this race condition, but this patch
> makes sure no future user of strp can have the bug.
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

And obviously I forgot the Cc: stable tag once more [*]. I guess I'll
post a v2 tomorrow if I don't get any comments on this today.

[*] but hopefully not again:
https://lore.kernel.org/all/1e5824f7bb8f5d32783c5b47ef4c06b1fc59969a.1790437098.git.sd@queasysnail.net/

-- 
Sabrina
