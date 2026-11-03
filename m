Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793691461;
	b=Tyjpg0pF7EdXKXxyHTP9fNVA3QOavbfIn/SzASYb9Yh9H4Pwynvm0viA/5lzYOKLax8N
	 baWbwjmPbv/5tkhh3uCgLYwVdPQphPnxM0fxcip4xlmA+isAMktlWVRgZVKtVhvRhgtjV
	 PQoE97J1zW3j3edlx2REnobDJNv3msqmY/6qsE3ZmQg7iqPgCb5+9hwI5tmMpEeCBPYLl
	 KoXPBPMAYHFoVwb6GexFZZy8kSe84io+heIvzSgEFcElQlEOtbl6mhP2p66KBA6kN1Nlm
	 c62Fxm3RAyotl/si+xaetZC1xvk7aANn5UCafHRz77JI4fhQ7CZwWhCRZKKxnklDe/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=85i27vNHcmh26GGO34/PDAduUVAyw2KWb9PQhHoG2mE=;
	b=UO1q3R/2MwUMAp6H3rHrvjc2I/nzYm+aZJuWcp83wlLxQ2IFthZfR+RNjnwdwAD14jdJ
	 EP2zOs/WJ5hyaGfoBXITBlHNyjQbdS0jLnWZHWqxG6B6uKGSi7hI9Yb9kL7agaRwtlz2v
	 bhB/qv6kU+Nm8AF8gX7gNwOdtaGTNV1ZgFxt5zd6ULaMRdu1SOV/kgCBsx7+gocaWn9L3
	 osWCclXZA76HE8jUSCGR7yHAd2nslZRV8ux2j2l+p3AJ0DWNjRekQFfLSiHxx/lcMx++1
	 6hrKMyiGvPauAVJ5me8RtZxQzo5CdwzLrvVRfuyD+KxGgk+tspcXTyqSoOltJYAfaSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dnggIaTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3086606A324;
	Tue,  3 Nov 2026 07:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3086606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dnggIaTJ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BB6E2200B28;
	Tue, 03 Nov 2026 08:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793691457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85i27vNHcmh26GGO34/PDAduUVAyw2KWb9PQhHoG2mE=;
	b=dnggIaTJ0kBUxE+Wt/mjxk5/+E1bTENcxd/AVZztDM5hSxVKa8gjQTJiVKqVBqNPYt6cyz
	9MW9XlpZvPd9/hD2xGbRPhvuRgLneq/PxR+QRdmX36GWo4cHaX2/Lc4Uoaf5KD/js2XY6D
	Y+raiiGmJluHnUdvP5rFHB54M412wkYgU2XEjPEPetziimkULZ1WHGyUxQk/s8IIW38N3I
	RuBb1NRmuoPlSPsd0NMx7xp6d+WEiEP+0ifcySuBBdgC8QL/428VLVx0Delq6QfD99iln8
	qZIk5aHYdVsPoXNLHeapEr34wKypdXVkyrczxSiurfJd1HHTPLtoAEBh/bdj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793691457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85i27vNHcmh26GGO34/PDAduUVAyw2KWb9PQhHoG2mE=;
	b=KUF2GQ/GVTK8m/WieoQ0K1gOVitj4vqqucB8jBrNzzXHnBoXO4xf7HBQS4ZA2D4TJCHh8i
	JGjhZfO5wOmK3XaGmXjxcZEMB0oFhG5EAfICmFvcvV2AnuToRdf9BlVaX/MPiG5C/7E+Ce
	p1L3//ZxkvKULetehfM3Td8pXAlC0uYRD/0Q40nlK1jMjMXsCjH0Ddw7+htqtwrFg/LF3Y
	7TI15jH3aogkcKXZ0jQ++eGP3gbbaORmhoDpr7SvGHQHFHwQ9p481pPh8Kk43hissGcavq
	N4qy3mjSbwn8vQA6ElzF4ZqVGXjj4xd3vh6fZqxym2LxQs5xBV4pG5knLDhn6A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793691457; a=rsa-sha256;
	cv=none;
	b=Pc8IkTKUKWSPJMguNT13h5HSSsDD1AvPjYfGZ70oCF771cg6/lcOqGeZiH3WaHHe83+g4s
	eQ/5rRz+Ndl8SPqh2H7A8vfCTwdRvjPANiJ6A7TG6bap1o4dh9o/YZGWKUfismrJY5guaM
	yp7IPWx1pKa62hljX1iLskexLROwGNPhTDRdMqbll0OUAxyRoJ0z9izoj2auxBaXau4lya
	Y9F/CTiO0KbC50o9iqHrjgNSBZkq/hJA4F/y8ievtAdLT4I9jr4B1uJdDthmc0QTn8sUib
	r8/ucTgL1cZ1b3Ftxcb+MOJUdvor7RB5K/uKHCTE/2LCu65PICJkOVx4XF4Sww==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xO95N-002Pt0-28;
	Tue, 03 Nov 2026 08:37:37 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xO95N-00000008nLW-2Ilh;
	Tue, 03 Nov 2026 08:37:37 +0100
Date: Tue, 3 Nov 2026 08:37:37 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: resume phylink on non-reset USB
 resume
Message-ID: <aumPQeI3lInBvbNT@pengutronix.de>
References: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
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
In-Reply-To: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Stefano,

On Tue, Nov 03, 2026 at 12:51:33AM +0100, Stefano Munari wrote:
> lan78xx_suspend() calls phylink_suspend(dev->phylink, false) on an open
> interface, which always stops phylink and halts the PHY. The matching
> phylink_resume() is only called from lan78xx_reset_resume().
> When the USB device stays powered across system sleep (e.g. s2idle) and
> the USB core calls .resume instead, the link stays down until the interface
> is brought down and up by hand. The ifdown triggers:
> 
>   WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0x44/0xc8
>   called from state HALTED
> 
> Move phylink_resume() to the end of lan78xx_resume(), which both resume
> paths go through, and call it only if the resume succeeded and the
> interface was open, mirroring lan78xx_suspend(). As a side effect,
> lan78xx_reset_resume() no longer starts phylink on a closed interface.
> 
> Tested on a Raspberry Pi 3B+ (LAN7515) with s2idle: the link now comes
> back up on its own after resume and ifdown no longer warns.
> 
> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
> Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>

Partially tested on net-next (4dd16e31135e) with a LAN7850 on an
i.MX8MP. The USB host is reinitialized across s2idle here, so only
.reset_resume is used. With the interface closed, s2idle resume no
longer shows "multicast write failed -EACCES" and the WARNING at
phy.c:1352 in _phy_state_machine() (4/4 without, 0/4 with this patch).
An open interface still comes back after resume. The plain .resume
path, which is the main case of this patch, is not tested.

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
