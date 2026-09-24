Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9347D440;
	Thu, 24 Sep 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246537; cv=none; b=vCrsA2MsnqYzCanf+okaaOqzJBdl7cay2IoqGH3m9QUG2VE44oNJjeRPRCSf6rw3oWrwI0Q4/TGiiKvpGSouF11Nk8F0L0Cv9wJUM8aU2Lpap/3Tcgy2/Y5ag00dJ4LwnoL55A5UelKzjVo84eOeYzcDf/PX/veyfunxljERSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246537; c=relaxed/simple;
	bh=LxAruGH+iszuVMTJGGW1IamPO+xINDb85hejdnN2LH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrHYWNX8fnlbc5YG1gOtVpO6gW9gDRrYSIKe1JSQNlpAytQTp6edyGX++iHsm21wnapDprizY6/yVjPa+3VTP2tBrE9cIOg1Ez4qtrFBxvKZIenfP17qfDxC/FY3bbo+BOBP+GyOEWRFj+Rp8LvtJcHSwtWc1N/ErF2VhNoPRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VHDbTqvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xJcpVEC9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VHDbTqvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xJcpVEC9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 28CE71D000A9;
	Thu, 24 Sep 2026 06:42:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790246532; x=
	1790332932; bh=kHtFvdPQOCvh4h36vOrsDsVbrZP/EDR37eZ+POo6P9E=; b=V
	HDbTqvOOsLZHOafCBn2brFmYM9PNDxn9ho46kgwBjxdSDDU/bZWaZDQJtv2aJB9g
	1rjWgUaC/p9Xm25GSSDF9kl5FVStRsAcpCgF+vYIs1dn6wnYWt8Wn5DY2Wzv5Mib
	q6RgdAQC64xSO6+WRPUV9KtvkzMJDJ39AXqMp2LzeDUx9PrdkjXr6inFJAR3MHr9
	toWbLHmP00r90eyX9eo7Llk1wRERv+sxSxQaFFTgoCuxXum6BzPMnMCJjwUgiEwo
	wy4UHhtI1G5g7I2cr9rIw9NhRGX4FncceSmzOPAvKz0gWC2YJsozaR3L7a/4eH6S
	KQa1dkU2py+shF3eMfY4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790246532; x=1790332932; bh=kHtFvdPQOCvh4h36vOrsDsVbrZP/EDR37eZ
	+POo6P9E=; b=xJcpVEC9zNern9qs4WPTTHatH7kyi968Q8oZmhc2VqMkeAJ0TzX
	/AH97vzwwuE7BDAevk/k6Gy4DDDzLlx0SPxSLtNIDJ27O/x/NkDbwcWwGKCTWuwT
	E5iUAXo7lNJRSDO8I5T2AgLQXLywUG7QZ5X7HofbWhIHj3S6q4CJHOeQTy9iZi62
	M8IfdqjFHfMHExhvcbXogvabjoHFo17jdT+FFxehjFMbQcWKXbATQWMsg932zc9m
	Nv4T6Ol6QCzxCs2N43Z8oKPMaiTx1y6cV4b4mnaQza3jzr4VA1QDJyT0QSr+7aUB
	obTWfTIfRO6zUGZqyvowFN4kGKnmicYh+lg==
X-ME-Sender: <xms:g_60amYHp7XCBtgYUY4B6a133pGEX9Zlsn69_-IvetJdTjs19hRQgg>
    <xme:g_60ao8J6kxsFoaNzAbLVHXtV6BssLbemVQMaIFblOkwy7s8uc52BlsFobsAE5xam
    BZpIN96re9ZsB0DSxraKeS-vLA7bHK7Z__pCCbG2wGznss-c_Lbcs-G>
X-ME-Received: <xmr:g_60alQfjLgtN8ZSOCVq6Ds_sCJQKYwxLwBc49wFTS43CrunKAVXbbJ4ypLN>
X-ME-Proxy-Cause: dmFkZTF0GMKLYo3mCT8N07MbHfuL6bhf5mjAU+CIekP090s2EHcJvy4WGszgEfetzJaDOg
    v6W+eNwKI2pnHZERNkJzADAo0BNyUAJ3CzQpqutrwSssTEBTMSGmu9vtFateckeANyYFwj
    oKv4NAARpHhW/CWuFD0POm5xpq1Vau3Ho5YWtJ3Ga6nebBK2eGW/MSsvhWQT1/0gEgqfrE
    Asr+uI1iMcbxikDd8qatoF7tul7uQ7hTfxSCZwH8rjqudpSQxVcX6J4p5yKzyT2Zi5g3D5
    sha6cgoMe8EL5fwJrtUMiAHAPxfdbScI1OEFUJsry07agtWX1mC5UzeheMIEEIYOVx9bNp
    TPwx0YXRHbtOBqHLFDxWskV1hNLzrh+44rA51xLkF3pWSoxKIDgIoBTUdg+yOf88iTzKTb
    mSUF6kW+JBA4AoZTwz/X2nqSYMurcsgOKiKg1xwbfnyyhHw/PTCWawlxlz2uFlAYmWGyPD
    58yFTmklZy5STWE6eJgVh+MdrknHwbf/vkauI4IEFcrQDWB2ptuhIbF9eb42HjSYrtMeAY
    rlfuQrJe3Plrt3K14BSgNgtqjfEV/4SphS87/OKzxAuJIiN+s9iU6g9IKGcJ4EJkEPLODe
    6ed/zTus3aI+uzpaQ0wPDLMX+NvhJ3JuVI6qPpxhrP8Ax8uZBTJ4CnNoyz6g
X-ME-Proxy: <xmx:g_60arJOH3LZMlsWI6f8ZlAyLfL0ciV5nnLAuAiiRR45HWWWqxYJqw>
    <xmx:g_60avT-2-L_yKGZW-PNcmO4SWeHmUvD6LkM5epxmlE4K-Q8Bj0SpQ>
    <xmx:g_60arLa32Y6_mprNaa5OgYZOXJ338sJY5rF2DAAiGQTEAxjrbkdaQ>
    <xmx:g_60aq-pqpA70RYswbsdyiFcobFjXCu0OvoS5xktkbFxueEvqQ8_2Q>
    <xmx:hP60akUwVRZkPsHTgrq2F0g4Xngs2_Mv0Tspmaq2D6f5yJpsaJYZaHDL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:42:10 -0400 (EDT)
Date: Thu, 24 Sep 2026 12:42:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Haseeb Malik via B4 Relay <devnull+haseebulhaq55.gmail.com@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, andrew+netdev@lunn.ch, hangbin.liu@linux.dev,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	felix.walter@cloudandheat.com,
	syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com,
	Haseeb Malik <haseebulhaq55@gmail.com>
Subject: Re: [PATCH net v3] macsec: initialize SecY before registering the
 netdevice
Message-ID: <arT-gJcnJww-6cjV@krikkit>
References: <20260921-fix-macsec-net-v3-1-accf94f93f5e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-fix-macsec-net-v3-1-accf94f93f5e@gmail.com>

2026-09-21, 16:40:30 -0400, Haseeb Malik via B4 Relay wrote:
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
> Even without the warning, notifications during registration can report
> uninitialized SecY attributes, including the SCI. This ordering has existed
> since the driver was introduced.
> 
> Initialize the SecY and apply the new-link attributes before registration.
> Move MAC address inheritance into macsec_newlink() so the SCI can also be
> initialized before registration-time notifications report it. Move the
> per-CPU statistics and metadata destination allocation into ndo_init(),
> and release partial allocations on failure.
> 
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Reported-by: syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f2f6312ad1b5a0bfe316
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://lists.openwall.net/linux-kernel/2026/08/19/552
> Signed-off-by: Haseeb Malik <haseebulhaq55@gmail.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks for taking care of this.

-- 
Sabrina
