Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57D36C5BF;
	Sun, 11 Oct 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742045; cv=none; b=dp69sre0atee+biqCmWLemjuAWvseGTp1QGmANZM4qH28q4JdkZWLClZCGrKD5qvYd1nv2prSLp3Vvelm6zZgh39MCi749AfVeQQy46O9pP0B1zvQ1S9Z1LSRSU3nPuD0kgxtiFtsF61a+dIIwQTWCOCDllW4YT6cvJlmpEZD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742045; c=relaxed/simple;
	bh=5Cr27iKU35LWbUwRz0pgjQQZ+GO/Jx9Uviy2gu19Ufw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rQpIJQgXqZzMpZuVvQ5JJhmqSMRtKbL+Gojzdz2w2tnL9FZ1r8DApoBycpqAkxMAUOc7ocEd0Z2LSTb03hp5u8R5ZPU+JDAJQ7TWG1cH+yp1D4T5KktPN6RVN7c/+JnIZXeSgUeix2fmUzEGDhvnXag9LznEmppwggrOwm+GqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=l6RszutC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="l6RszutC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A567A1566;
	Sun, 11 Oct 2026 20:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791742037; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IcYL9fZE9jnk9d+hPholRkBzjD07Lkz/hbWQDi+8jsQ=;
	b=l6RszutC4zA1jetfCHsEMUNg+hxVSz8yNItUlzG5bkrHqkUn8jFWlYN977xvK+wnB93kiM
	4yDhAzu72JVdI3dtyzHVp+dcUbebBl4dq9EhibtRszJQdl48xhkV/Q7bK2etVaralyDsO+
	QflQYkpwXSaGULJL9VL+YEgrokdolAgHXf/1CqXuJNtD9LnIYpI7aetBdlQ3FuDySNZA9i
	wKxnZyNJ4DZeb6eURpF2OzhwO6ldUm5g2/ZjCC5W6rFmzaae/MJranhLlhQB+GVgpmLnAP
	uSgAvW+QaSC30S+tDkOJCJWAfE6ux+50AxF+LQLmE5tYRpDT8IZUjilSkeGZ5A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Oct 2026 20:07:13 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger
 <opendmb@gmail.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, Conor Dooley
 <conor.dooley@microchip.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: mdio: add timestamped MDIO writes for
 PHY gettimex64
In-Reply-To: <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
Message-ID: <db3a0f73c1883645f51294ca46cffe05@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew

On 11.10.2026 15:50, Andrew Lunn wrote:
>> For example, using PTP_SYS_OFFSET_EXTENDED on the Raspberry Pi CM5 to
>> synchronize the system clock from the BCM54210PE PHY PHC leads to the
>> system clock being 32 µs ahead of the PHC. On the CM4, it is about 7 
>> µs.
>> (The difference is because the MDIO clock frequency is higher on the
>> CM4: 10 MHz as opposed to 2.08 MHz on the CM5.)
> 
> IEEE 802.3 says the clock should be 2.5Mhz. Does the CM4 use a
> clock-frequency DT property to enable this faster clock?
> 
> 	Andrew

The Pi 400 is the only BCM2711 board with clock-frequency in DT
(1950000, from a downstream "Limit MDIO clock speed" commit with no
further explanation). There the driver's assumed 250 MHz reference
gives divider 63, which with the real 200 MHz (see my comments on
patch 5) is about 1.56 MHz.

Pi 4 and CM4 (the one with the PTP PHY) have no clock-frequency, so
the driver keeps the firmware's divider 9, and 200 MHz / 20 is the
10 MHz James mentions.

Regards Nicolai
