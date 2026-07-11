Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A51A0BF3
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783751496; cv=none; b=WNfAJ+jy6uac32Y50gWqXoIK0nDk+bsyy5r7RoAS63kJggIa3BXLcnH80cKYc/riRxIpco0+NH4xaAqPLXx72BBkPkDxSZ2YQFZ/qyOM/zJsXPjx+V2BR76e43tvqPLO3jdm6kW5B8YGLEsCtHN4CidRjhPmqo2zOuhhc8cPavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783751496; c=relaxed/simple;
	bh=aUabuki/pt3WgADB/p7SVGbbNNs0bOybAXOLCiYKtM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuANHqrIEk0s8ntmAblkDzD0pPxWikctnx6bql3ZMi//apSHWQR/BFWFZVYRsAQgPyqGx20J2dwQ37T3GEOPX8SdD9tZPV6hCHJN9wlfZT2ntQvlczd064h076emrX4WRr4nVaC6Nl6+WIjbuDeKxqC7UQO2T9jz7rxuAqobKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbBbBCoA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbBbBCoA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47db714766aso1346586f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783751493; x=1784356293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0oUjZpGn007Jt9IUvKRKCvnkkIDEGFJR4Yx4a+vmn6k=;
        b=RbBbBCoAQ2KvoEbl6iIMl359BK8dBLDAIIQSHCRkE9c/bMH5M27Sk2t4Io49A29d/P
         3IHnLAcP3/fXDYAsmObT6fwash4wJ2edneFl3RAjirYv0UTsPVCCFVCINazzlddygGB6
         4fQlQiNc8yhp6xw62nbVhOUDm5ji0TMeloRqn8oG/Jx+SApcoBfc0lzTQn46Q2Hge5XF
         5MCT2EcLY2FpCWweIO+32kTpexpW+HAt4RQ7I1VKgLQLH4sIxpFIh5Goxb8C2Y+ujOJ7
         hKDtxby93N2CpdRcSUmyquc5qjHqkKuzMtX2RuZHBq512/tZUqv+E8pA9BHA+Qz74LTG
         5qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783751493; x=1784356293;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oUjZpGn007Jt9IUvKRKCvnkkIDEGFJR4Yx4a+vmn6k=;
        b=WlYfwtXK8g18pyUd+ddgjVOMaLPB32RIeya3J0dTz+SoIKk6As9PU9v+fTBLYecN8f
         q95vUtNeBZ4xf3EdrAiqkok0LaKM8d2ekW18ycTxvKpAUyuA6wDeZBGKfTwIXWKqV9/6
         TX0MPaw6ilmMtuOYj5NrjknWwpgNp2lrJyoF4a3cEiFqqToY1DIV8Hi0olTp96TipN/a
         1YcNy2z90bhGINGyzAp9OkHjcBykVDTV2NbGTOqycIYHY75e3k//Er1YtJCfd9WNK29x
         BOLSAbWecFrdLpCgCKm1WcxZidtcbiDhw5+SAFJ1Ek98vJJdQkAcr12biix8rJa0X/Tk
         NLcg==
X-Forwarded-Encrypted: i=1; AHgh+RpHOwp34UE/lpthwysPv+509b3FVX1s+Le+hqV++DLZcsG8vg47btzG1Lxfo4ePe1PhzcF5ooc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9z/r6RSYAtbXivPTnWC7RQEha2y6d6jUA4rC0XKNZmA0h6d+E
	FK//yjBYSL8Mwd1Hjjb6QP5bRKUWFCryg7FrkWuE2jfOGN53KWRs+PmW
X-Gm-Gg: AfdE7cnRF8ryd4QcfUWOl4oLDGPmyFduMbHtI8oevcczJJJIEOzGkSubei2abxxPe0P
	QD31qri73F1Mi6w1n1LapuGXvoxPp2y58D818SMVHaR9K7dHoNzRXg04vUj7jANCsIShX2ZbA5g
	OiSx+V/KeiaKfN97bpv6EE/3Qo2p1aGBxFW3eJjyKvXlqVUX4rKds5l7+yUbSSiF1ixAy8cayIm
	/b0CPPU3gGvCFNPu90r3y1i1mgnAw6zcMPUgfsCi8Rv6MRjYJA2/6ksvT7EGQTz81CaSu3HSw0P
	KxCGGUOCb5glDSIA27F9q6Xzmt2QdsHqyUag9DVj8ZO2tW/0Tm231UeXoYmOE60QIpkn2wDfak5
	X3q3e/SG8h6jrPmxCTbolWbmp/PR+VTdYhK2tQBpYaqCdU+vtlJeSybFfSmx8cN6BrQmGn3A5LC
	w+TSJjD6nHN/6b/QBynfsiEcPNO+dQdxehEozQCm+z2Ijzow==
X-Received: by 2002:a05:6000:200e:b0:474:c3a5:4132 with SMTP id ffacd0b85a97d-47ef695b898mr7649186f8f.9.1783751492843;
        Fri, 10 Jul 2026 23:31:32 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm66121608f8f.5.2026.07.10.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:31:32 -0700 (PDT)
Date: Sat, 11 Jul 2026 07:31:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "D H, Siddaraju" <siddaraju.dh@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Michal Kubecek <mkubecek@suse.cz>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chintalapalle, Balaji"
 <balaji.chintalapalle@intel.com>, "Das, Shubham" <shubham.das@intel.com>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "singhai.anjali55@gmail.com"
 <singhai.anjali55@gmail.com>, "Brandeburg, Jesse"
 <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Message-ID: <20260711073128.7f94e0ac@pumpkin>
In-Reply-To: <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
	<e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 00:54:00 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Jul 10, 2026 at 09:45:43PM +0000, D H, Siddaraju wrote:
> > Hello Linux Ethernet team, Maxime, Andrew & Michal,
> > 
> > The IEEE AUI chip-to-chip (C2C) is the accepted standard for connecting
> > chips that handle subfunctions within the OSI physical layer. Just to
> > pick, the C2C is widely used when connecting Ethernet SoCs with retimers
> > and PCS SerDes terminated external-phys to offload PHY sublayer functions.  
> 
> It cannot be that widely used if Linux does not support it yet :-)

It also seems like something that is fixed for a physical board.
So while a common MAC driver would need to be told how to configure
its output, the user wouldn't be changing the value so it would
be more of a DT parameter than an ethtool one.

...
> Also, an architecture question...
> 
> It sounds like you use this between the MAC and the PCS. The PCS can
> then be connected to a PHY, and the PHY then has a line side. (I'm
> being a bit loose with the terms here, i should probably be saying
> PMA, PMD etc.)
> 
> Should ethtool be saying:
> 
> Settings for eth0:
> 	Supported ports: [ TP	 MII ]
> 	Supported link modes:   25000baseC2C
> 
> or should it be reporting:
> 
> Settings for eth0:
> 	Supported ports: [ TP	 MII ]
> 	Supported link modes:   25000baseSR
> 
> I _think_ ethtool reports the media, not some intermediary format.

You'd want to use ethtool to set the final link parameters of the
external phy?
So I think you's still want to be able to select (say) 100MHDX
for a TP link.

Remember the history.
The parameter was originally used to select between the the AUI, COAX and TP
connectors on a 10M ethernet card.
Then the internal TP gained extra speeds.
We then get MII for external 10M and 100M PHY, later RGMII for external Ge PHY.
But you rarely get boards (not MAC chips) that have a choice of interfaces
any more.

> Is ETHTOOL_LINK_MODE_25000baseC2C_Full_BIT actually needed? I suppose
> one use case would be when you directly connect two MACs together, PMA
> to PMA. So a 25G NIC directly connected to a switch port, with no
> 'media' in the middle. Then ethtool probably should report
> 25000baseC2C.

That might be similar to using RGMII crossover to connect to MAC together
(Which does get used on-board).
I'm not sure how we selected that, but overloading the media is 'sort of'
ok because there is no media in that case.

	David

> 
> 	Andrew
> 

