Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A640DB35
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233577; cv=none; b=V4EE53WMQF3cFCh3t3fJObjZuFpv+XZVq1UnSAzspzgpt8VQs6YS5xFTMlnLBE+DAG1zOy4dVyXH9Uwi3ygEsnLpUxhhbkp/p3CMLOTLN0eSc+VpApU+EK0rc31rDMICOXBWbGRGSL2zLCnIkn6YOsSZRYavIps5wGu1Fw5yFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233577; c=relaxed/simple;
	bh=GtkSlyBq7/JCay1sZEkoqGrRyNduEivBSqsSTqb9oTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIl4YaQBlS/KEmORjC+aBbYAW+mB/wIBfXgxuUX8OAtR1o6i7TZFhv2SeQ4iCIWBX3RFMI7PhXGnuCPXkAme3I/5rAOEPLlaRNmWpUrqq0pKC58UmhKrmPT9DEqMq7OZIsgbswxEDSDJkrNszrIKnQkeI7sY2igyOO5lzym/6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yam2O+Yi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yam2O+Yi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 89355C211D0;
	Thu, 24 Sep 2026 07:06:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E9DB5FB45;
	Thu, 24 Sep 2026 07:06:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57B8D103294B4;
	Thu, 24 Sep 2026 09:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790233568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=G4o6d/Q/EKM0Gg1FOF9eIxGS/5ZA4PMQ4U5wfjsuxAE=;
	b=yam2O+YiIi83Hcxrhi1SsJ+8vHcp1SaP5+4AxrJeWJXHEfB0rjxOBHZ4KBUsccioF+0ExM
	vQgjYlFJE5RnMqAGCeVr07di24CWLgcM66VdtQ5IdFQ4p+si6oeT0GkWj/sfWS9C336h6P
	wu4xNYotcMagaOPa+bxfI7Y0V94fLIBEsVLBEe1Sr/FXok7IAz6EZOagFQ8mY2+skmVe77
	94sK4s2TSWFDJtinzQAaIFOvbAaOnGyDSZGFsyl3lwKDwZVon2A80YZWXEFDAePWgYfJHL
	rcBJpHFo44SM5itt7HhIymNINOp9IDSYfI8aidwKDZvo6PvtYyksVLVQeELaDA==
Message-ID: <a24935c9-8bf4-4f50-ac21-de76a3b73f26@bootlin.com>
Date: Thu, 24 Sep 2026 09:06:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PHY ports: combo port with a MAC-side GPIO mux on a DSA switch?
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <20260923225909.1649267-1-f@lex.la>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260923225909.1649267-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/24/26 00:59, Aleksei Sviridkin wrote:
> Hi Maxime,
> 
> I have a board where one switch port can use either an SFP cage or a
> separate copper PHY, picked by a GPIO mux. I would like to know whether
> the PHY ports work is meant to cover it, and how to describe such a
> port in devicetree until then.
> 
> The board is a Keenetic KN-1012 (MT7981B) with an MT7531 switch. Port 5
> is a DSA user port, lan4, in 2500base-x. Its SerDes goes through a mux
> on GPIO 27 either to an SFP cage or to an Airoha EN8811H 2.5G copper
> PHY, one at a time. SFP presence is on GPIO 23.
> 
> OpenWrt handles it downstream with two devicetree overlays. The copper
> one gives port 5 a phy-handle to the EN8811H. The SFP one gives it
> sfp = <&sfp1> and managed = "in-band-status". The mux is set by an
> OpenWrt-only gpio-export node, and a chainloaded U-Boot reads the SFP
> presence pin at each boot and picks the overlay. Changing media needs a
> reboot.
> 
> The PHY ports code in net-next covers an SFP that the PHY drives itself,
> with marvell10g as the user. Here the choice sits between the SerDes on
> the MAC side and two separate media, a cage and a separate PHY. So my
> questions:
> 
> 1. Is a MAC-side mux like this in scope for the PHY ports work?
> 2. If it is, what devicetree shape should a board use today so it does
>    not have to change later?
> 3. If it is not, is describing a single medium the accepted way for now?
> 
> I can test patches on this board. Writing the framework part is beyond
> what I can take on myself.

There's ongoing work for that, hopefully that'll work soon :)

https://lore.kernel.org/netdev/20260910170103.1029108-1-maxime.chevallier@bootlin.com/

This is bringing the SFP representation as a "phy_port" that we can see from
userspace, so that we can later switch dynamically between the interfaces
of a combo port.

The next step is mux, including GPIO driven ones :) Any review and testing
is welcome for the above series, I'll CC you on the next iterations,

Maxime
