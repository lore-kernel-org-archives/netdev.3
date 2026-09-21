Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DA46D540;
	Mon, 21 Sep 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982972; cv=none; b=bQeuSE0P2Toyjya9vd1+4o5zckw8w+cz8s13BIw6Pg5r8Xg6ezsSIb25dAawPA93Fyf7PLwY4yH0BT1B7mlsgD+r8Q2cHaQA8WfZnhX5gUCntrtdKpUqKyR5RyCgncHqohS9IZPvWsAvR26KhTUsFnyggLD3G550nGhmAB4LiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982972; c=relaxed/simple;
	bh=SIpIlxvqLnULWsMVrpFj7gSY/FAXED4xw6Fwv4KkZC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzBRJCZsmzaVQCD1MvmlxOAD8vITFb9e8zbuG8cALORow62iLbAw6Bb5kif+Mm3dlVKU3b8tE1YkYA8/D/RG/jwcJOMzF+d2Xfn+32FUmzz2DH7x9y7b5frHrOQVviKwMSTes9zgO6JITdTVtxqUUAhd2YSTlQ0btCztyc77cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HyV6GGaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kXKKfKPO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HyV6GGaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXKKfKPO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 142301D0008F;
	Mon, 21 Sep 2026 05:29:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 05:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789982966; x=
	1790069366; bh=tozHMk5NwGp0Nnkz9Qbt5sXPlfSoracy95QzI1l+XLE=; b=H
	yV6GGaTGMINmU77HePz827y9m8BqF1JtmDcK1Hr9k6MCKfsIhPXQj9QZnm+nlQIs
	4D9dz+7Bmh68xFKwBUx9z66hOdwQtbfwfKZQ1gBCGPOPGPbWh8eHQQoXv0zucqU8
	Ois+SwBGIqBjEF3/TBza6NcxTjbypsHLgFuiC3tVskPqxFKQBOFSamV/uUXSdRBv
	HWIBOnaA67fEy03HRlQeaFe1HFbYARXHqJQQnJrhOLzqSVySm9se/95uCCA+wkAm
	KgZ7KIneRjyHz276+sq4o4JdwPVJwO56nY6Op3HUGN5F0w8auQN9RwPhI7pH0dKB
	vPGuSNzNJznmff+I98QnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789982966; x=1790069366; bh=tozHMk5NwGp0Nnkz9Qbt5sXPlfSoracy95Q
	zI1l+XLE=; b=kXKKfKPOrCSaRbpUx0SKn2BovUirZaAFD9awqASXPupTc5vIaEF
	CKFKCxTBHJps64ri1hO1525MoQaYngRcdVi8KUCNO1UuGi1+2aOhZ9xQWwNHBr8q
	QmT89ksUq/cutE8ZA7D87HlzdyN6Z7986U3f2xS6/+0NeuoSukA0WB+004RalRBI
	BqODY9wBef/PypO33/vhRmN9AZL1U7bjc4aKB36bR/69gba8wmDmx8pi9A7Vq+b8
	JLVIR9YJN8V2PleOsmp8SaFisQ4U+UDiW6DYjCUfodi4Ktj5IsH+prxJcjQdl/ND
	UWnU9dfMY/nRqkpcfXP5b6F38+JBIBsWYqQ==
X-ME-Sender: <xms:9viwat61I9fl6fPUprJpzFY3eAKzCv7PyseYvV8hL7xPGPWiOM_6eQ>
    <xme:9viwaqciYHoo6DS_wdDxqQ07CRCTEcAIwJtt3wKbLv_kGBnPWQ8K9Cwe1-UNfqwQs
    w10TzfEpks2WZC22pcuyZOdc-1vQ7BGzS_7KarBNbe0vcuJkhkqJ-6XTA>
X-ME-Received: <xmr:9viwaoxegCDHLWZaXvVCX58Pzbf9cPcNM8UfB7JA8E29_5x0MIsdyTgppmD3>
X-ME-Proxy-Cause: dmFkZTGEn3taAaYhLgx4plFq+cNdstjuMDhwzeKDpA7LcdYpkkHm3ZO32h5jf8AFCfTMLK
    sRc/vQbLHiHHAVj9DOghD1Sqj050uLY85xpdm7EFRlPC/2AdhSIADvaaTgyWw8d3VL9QK6
    rNXWelIQOAxQfGO7XfHjmeWtiE+md4TTugCesltQLiE4Cp5Oh8EDskO9zFYAvgUBLnN8el
    KHzAKB7BMG86kTwvwtkCgo8g5ccC78D1tvAAD5IBXAnuLFMOOhdPjDhFwWQYY1KuixJQ9z
    g/OOpRFAUojC/rJ1u/Oz2CIb2apHoeSLfO8AtAMPI4VvmpZW3ctPBH0Cf/URXDI4ubZRnU
    RUUuPY6OgRGn2nLOocWFVkErprPrV11/pcKYBKXeTPHiyET4/u9CAuNAIyA1KXtjnn/okh
    4WxH3Fi98rffvIGJpJoHCzFVgYHUDX17EX9S1GJ0g9v8BXfAM+FfA1s/+2xKMERyVKCpOs
    YGIAuEZ3ktTEvzwBJdiF3aVY4gnhL7jqXMMy13O4Nu7ZSX/vwwslrlKKmfPrTTtcz0xa64
    EJED79zBvGtzg/o/r5okT6b/U6/3TTKT+T7Z7qa886HOueGqnR6YJjwhUOz6q2TIBOEhZf
    vvVYkk02oCBLOk482kqbEaMmxp1aXaLKvfJjBu37WKJe1NTnwL3qgAiKrItw
X-ME-Proxy: <xmx:9viwaoqJiv1TptxjTLQZtnoT81VAPI_8Gc3zVDVv0p6UR1cmjAmLVg>
    <xmx:9viwauwcgiX9k42YECLcE88Y0HSrenWge8SnSH_cqgcBIVuqpHAl8w>
    <xmx:9viwakptJ7eRJGu3r1WuR73m7k706RyHZau0rXlq7AyocGRDMNrQ9A>
    <xmx:9viwamek-ACqI5t42CTSQ2mGPmCl8xnKcCZ-iMZ0jx_n0pGpmSJquw>
    <xmx:9viwar3d7hTjWIWx1tv7t9EI-Zrc6OKf9z_m6AX_3PrBCxvfLYDEeTgO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 05:29:25 -0400 (EDT)
Date: Mon, 21 Sep 2026 11:29:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Haseeb Malik via B4 Relay <devnull+haseebulhaq55.gmail.com@kernel.org>
Cc: felix.walter@cloudandheat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	hangbin.liu@linux.dev, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, horms@kernel.org, davem@davemloft.net,
	syzkaller-bugs@googlegroups.com,
	syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com,
	Haseeb Malik <haseebulhaq55@gmail.com>
Subject: Re: [PATCH net v2] macsec: initialize SecY before registering the
 netdevice
Message-ID: <arD488xDvFFwtTTN@krikkit>
References: <20260918-fix-macsec-net-v2-1-784203ec4836@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-fix-macsec-net-v2-1-784203ec4836@gmail.com>

2026-09-18, 15:01:29 -0400, Haseeb Malik via B4 Relay wrote:
> From: Haseeb Malik <haseebulhaq55@gmail.com>
> 
> Creating a MACsec device with MAC offload over an LRO-capable lower
> device triggers a warning in rtmsg_ifinfo_build_skb() when IPv4
> forwarding is enabled by default.
> 
> register_netdevice() invokes inetdev_init(), which disables LRO and emits
> a NETDEV_FEAT_CHANGE notification. This reaches macsec_fill_info() before
> macsec_add_dev() initializes the SecY. key_len is still zero, so
> macsec_fill_info() returns -EMSGSIZE and trips the WARN_ON in
> rtmsg_ifinfo_build_skb(), even though the skb has enough space.
> 
> Initialize the SecY and apply the new-link attributes before registration.
> Move MAC address inheritance into macsec_newlink() so the SCI can also be
> initialized before registration-time notifications report it. Move the
> per-CPU statistics and metadata destination allocation into ndo_init(),
> and release partial allocations on failure.
> 
> Fixes: ccfdec908922 ("macsec: Add support for GCM-AES-256 cipher suite")

Why this commit? The "register, then init SCI etc" order of operations
has existed since day 1. Without ccfdec908922 we don't hit the WARN_ON
in rtmsg_ifinfo_build_skb, but the bit fixed by "Registration can
notify listeners before returning." would still be bogus.

The patch itself looks ok. Thanks for picking this up, things got
crazy and I forgot about it.

-- 
Sabrina
