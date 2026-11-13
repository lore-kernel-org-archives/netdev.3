Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605972;
	b=pY38UTNodMH+y3FgEmReoW6OEH2tzWB3G+hIVz/0yveOlDxBFrOxrlPLDRRl0Ct0W3gW
	 mnKJ/cGWDuc5x8hIu3xEefHZjaGSyHM5DTXyghVDXTnzQSRtQOgtzZf4BZQ5ESwfLb1a9
	 MLdlxu2vsQcDfuuEeq1Ehw+z+uge8O2jPEsDzrtqN9gBy/i+pzxv+XH5xBexvWvnTXdfb
	 rt2tEtWtpC2oyEzy3GGRV907EOjTT76+EFwlcCcIX8s7wI83uI4DggeMS/T2eLCRWuBB7
	 QXmadr7n9c7Y0p4g/x6eNrp05dyoeovp0R9qSxrS0MRyN8TfJLNlzR7tWf3XSu8fhgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gX+jaWsdQdLNGoqVpAczWKnlHXr6VQWsFTApnkkxsUY=;
	b=OUkQ9kanhv33xDHA4sSPMRYZp4DVecTku4tnDg7UVCmAFUnVSmPuAc0YPj0FqLwAAJAC
	 HKksRlFZljukWQ+mosB18vWGS2OdnfVDoJCm6MFxfQm1fTBATtifChK93u2PBMDpR7ZZl
	 XvxAX2AVdS5aFgddaLGuzXpchX0cII1as9fqx9G2PBY/kyM1Xu2tTHnWYLr11/wZ+/nbM
	 vaFxjyT21tVVkNgsF9+XJqamxGFEx/JiBiy/LBOBlCEUrIcMqvEFAt8WW6xXjEbJ1BG5W
	 qWHIcjv4c8I9y1eJ4UrTPZrkgmdBRbbowQnDjGeZG59GZ/mxVZLE41tkm2bTvD/MzrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F0PoWYnB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B537606A333;
	Fri, 13 Nov 2026 21:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B537606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F0PoWYnB
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AF0A820128B;
	Fri, 13 Nov 2026 22:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794605964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX+jaWsdQdLNGoqVpAczWKnlHXr6VQWsFTApnkkxsUY=;
	b=F0PoWYnBIM42NEGkfwC35DWf3Cli3oHB+9CEyCQRIxYJ3e/WlNHTk1IwqdE063MMURqanI
	shFl2Fhn0Ngdtc0IDYTk9XdnakrXgPoZK9OwUAWEILCOv5q2ZT7ahrHfN6maOc5zJGciiX
	fnCnRZpO52kaamTcDlofNcUcjkX3gYxkHKxOVezCBeQy2d0W6m1Jns1bp+syvcX5w+ogXP
	YyLDcggSDqLJAwgG5klNARIwV/eYFDOZFVQFCU+nDLfO/tBZ42Q3+V0dfCnphUEccXdy3D
	5JPXlWjhr2a5DnPHLfxB/oLDvR0e3a+8zmczpJgP/xudoRMXhSLhGl6pU8V6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794605964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX+jaWsdQdLNGoqVpAczWKnlHXr6VQWsFTApnkkxsUY=;
	b=eQ6cyWXQJybeoCHZZy7KVytLRIPo9jjHeYAxjrrzLg5ttCKuW60MPQwV3lG0okz/Mptef0
	eTnN4Al6nr6l0t/Roams/zcNKUhI49Kg8Y1K53XBx2kekLcarOLx60eXzEWf1bAul3/zkE
	no5HSxH6jmSdhqR/6XMXoqQetHqsBDirMghkP00zD7IITZSQ7HBUEMlfCIy5QYPtklQDVw
	T+brIXqjEY10mHZ9lFabh7X4AZI//x+mcBPpYFkt+lFm23xVrt2EZygQXVeqjEq8lyemrP
	HAOqadx8CYyLh55JQF25cw3XsHHqFziSYkXFuFlTI5ojUqqzwQPC+FAUYv1T3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794605964; a=rsa-sha256;
	cv=none;
	b=Tgy8FoLVUrIk+FkJFcUpcuiQAO/ys9wtPU+0IUV5H3dsdb2Qw34xnE1/WLEUvyqHCp2/Qv
	vc2pdk9HYNPymKmCJSwYWspgZfsVwd1Jx3zdn6bUTZIJ+lwIoXdtNx/rpfVVLjPT/Vz4Yb
	NBhjjdrwHsGCyVnQiYV36/721geXMoDhiYbttY+njuT+X7YUkECp6YNTKSfToLS3jy0x/R
	tS+pt8GUp/OUDCG1UVbCr3goKDnHKIulwlhZA6MoLz98UwUyXnS8WdD8bNiFiVCc7X5304
	+TYYoyiBCJnAs1nUObQxb+GKyFebpuW145KckLZCMikSCvVV1rFJ/Z+3ilFjag==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id 9087A1C0265; Fri, 13 Nov 2026 22:39:24 +0100 (CET)
Date: Fri, 13 Nov 2026 22:39:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: dp83tg720: report inclusive RX
 packet totals
Message-ID: <aveDjK-2qZL-4Sm2@pengutronix.de>
References: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
 <20261113-submit-acx00-phy-stats-v1-v4-3-986b8a4a1871@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-submit-acx00-phy-stats-v1-v4-3-986b8a4a1871@gmail.com>

On Fri, Nov 13, 2026 at 10:12:07AM -0700, James Hilliard wrote:
> The DP83TG720S-Q1 datasheet describes PKT_STAT_4 and PKT_STAT_5
> (0x063c and 0x063d) as the total received packet count, including packets
> with errors. The driver currently reports this count through rx_packets,
> which is defined as successfully received packets.
>
> Report the accumulated count through rx_packets_total instead. This
> exposes it as RxFramesTotal rather than RxFrames in the ethtool phydev
> statistics group, matching the hardware counter's semantics.
>
> Fixes: 677d895af1cc ("net: phy: dp83tg720: add statistics support")
> Link: https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf
> Cc: <stable+noautosel@kernel.org> # Requires the new PHY receive-total statistics API
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

I do not think this patch should go in. Please drop it from the series.
Patches 1 and 2 do not depend on it; dp83tg720 can keep reporting
rx_packets as it does today.

The datasheet (SNLS604G) does not say that this count includes frames
with errors. Tables 7-80 and 7-81 describe the fields only as the lower
and upper 16 bits of the Rx packet counter. Section 6.3.1.3 and Table 6-2
list a total packet count and a count of packets with errors. They do
not say whether the total includes those packets. The word "total" alone
does not settle it.

Before the reported value changes, I need either a test or other TI
documentation that shows whether the counter includes frames with
CRC errors.

Even if it turns out that the counter includes frames with CRC errors, I
would rather subtract the CRC error count (RxErrors) in the driver and
keep rx_packets with its documented meaning than change the interface
for existing users.

Oleksij
