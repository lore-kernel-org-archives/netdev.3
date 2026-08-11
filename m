Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC9356741
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444559; cv=none; b=ZHPV9uGilhz4Mxlvv5sNNgQ/wYWDAfqwYG+8e5vLpZmbFuPfP/1zupg1GINAaOgKuInDeCOOxUv6y2qh72YKP3vI8zhGqmbMO0/ZGAEYFMVCBj7msBTs3PHcUjM4qvYh9g2AAlViek1QU0yWVdAz7LvaneWcmQYsEKCeFGaU5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444559; c=relaxed/simple;
	bh=yWfJyZGK2HzJXX4QCUhrVzxfpvC79QZuU7HvRTGrRfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfnTMOjrYXbz+wr5938EGQfd+uwIWAJXYAgDMYJX4s9QHEnPi+d4xoyR9FFn2ptSxwMVTVKL22feq+gWz8qdoQncp2Oc5bhR0rLq2h1OuGM8ZF4i70F3OGHVZavYXYDLqVYv5lzwi+6rg9vFf0yQK4zZ5nQt7WCFTFEaH1uimtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xk6ntRTM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UULIlaxZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk6ntRTM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UULIlaxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786444555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgWj1WXd9QdIIoi0sGrC76AwkF5BooWQkqcP0amfyhM=;
	b=Xk6ntRTMGHiAe45L6mwmz+14PSXcEpt51qpHbXljgiTUHSkV+89es5v9thZ0HLypn7QYz6
	rMw3iI7uyz+0/1EG57Rg5HoQBITL0bj5TZmwRBp6Ji+bVcMgpMHyHeh1PkYSvEDHWVuyFp
	wcXnJLZpQYlXhRX9lLnM1I6bbpLKe10=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-CKucq-WaNFSPS25CeH89gQ-1; Tue, 11 Aug 2026 06:35:54 -0400
X-MC-Unique: CKucq-WaNFSPS25CeH89gQ-1
X-Mimecast-MFC-AGG-ID: CKucq-WaNFSPS25CeH89gQ_1786444553
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6db77430so1615339f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786444553; x=1787049353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZgWj1WXd9QdIIoi0sGrC76AwkF5BooWQkqcP0amfyhM=;
        b=UULIlaxZr2Qf7+EQcOzWwBS+9hrHgQ4T2iNYn8UkyHVyNQk3sAHZjwVX7eijBmHlNG
         3j/84K9SNn/i+oGF6sQGWI6W3UCQ9pM4p3RUz2oD7DqMzqfW+/bMB/RNtiQi4j+7ICmR
         7nB4l3+oh+iypevx3tts/rYaVPlUNKaFqvMRWNHRv4vCGK44cCU+itIvvSzps3pHxnoc
         oSxB/EyHmFUkAozQ2DJozT9GSaMnUv/cdJnRpuJ16B3bHKnoSdUHkfXcYnUTagQ3Nfgq
         a0nvmjtiB7X/Jz2z6w7nOvp7hVWVMTGsfPZ3gAIdbYLSAlKWfXeidxPa1YmOj5rMTtHp
         jvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444553; x=1787049353;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZgWj1WXd9QdIIoi0sGrC76AwkF5BooWQkqcP0amfyhM=;
        b=Zsc1Alcvu0OfhtDJvdffBD7XQqTK2unexEQQ595kOH7ghTJgaJU+4mXGDLYH+LJ9dx
         qZCmhWMAcvgtZYDl2oXDzQnPJyPPZUJ8YwnTBj8ansK54Fj1leNlt65eQ4zOBwPnA21k
         k0pzC02wsc/f+yAJrLHXit+ee9nCNK6JB3CbxQKLqT+YdLzgJj7TUEbfy8CPzsJKFL1N
         K3k2tkTSOUp/8Ufv/s6mJfI9k1t5OePXJAW/7yGaAftg/7/yMr2WgaWDzsZ47MvwsyRw
         Jmf58RkQqJhd5Wai9PRNNwbRM7q9dUnrgXQZ3ir4p3mBkP3TenxPo+s7krnAO487Inho
         IZmg==
X-Forwarded-Encrypted: i=1; AHgh+Rp07b+vpSI6CMFXsIPPiKbksmIGm3jLGAZl2RaetDqiz4Uodi1CpzvA4y3WkcTaWQfQ2a2d3gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/Kj6laqRb24XUHxMQBr0WFmpD4y0UjrZeWWjM2FVodL2ehxA
	j2tpfiYHF+NITVFxqSuE/QV4trqpEpd5DzU5rtkMsMKlhnxEFI+sSkKA1zS3LZ7YxMRxA9sIpZ5
	AmUbl97e1WVc8t8CAeQaYLIF7PWqC+OvV8QHhQmMnafZnCiGYsTXA9LhZcQ==
X-Gm-Gg: AR+sD10m7TWgSev3jajTF70OQ9IUy+ZZ9nJyHdbCuLQdQn2+q78iTfIlhHfPgmg//0o
	z3arC1tR3t6Dg29PaSe1zkl8jE1mravk/kH7DFhMChwA89gIAuAZ29SFMNUuY01DxX/M9FFPjZ0
	1irgVt8P8xZaAPh9i297fs80mrFSITsWr0GsUU7RdLuZuoLMCQkGp5yxMYZa5sfzbjipJ6BK8Bu
	EHc79o01F8w1SfaWI8m2s99xjobcDxSNkhIfgC7O214HOgd2Tda6+UskOcno35135bArg/DBiBy
	arGpVjFwG/f/CFJyHLPG+mof90RYI+jJnLJQoXlK2/QSu6Eji5VEePKGzL2CNMPg2eHP9xrFXVK
	CCATnkjBZ8ZUjzlDr7cL55DPSmu0cnGF0jCzNHuYNLHFgQRlrgyLmd7PvkgQKdsJu4yNtMJSjEf
	8=
X-Received: by 2002:a05:6000:2689:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-4814ade3152mr3775313f8f.27.1786444553113;
        Tue, 11 Aug 2026 03:35:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2689:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-4814ade3152mr3775229f8f.27.1786444552662;
        Tue, 11 Aug 2026 03:35:52 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cdb8sm3375919f8f.35.2026.08.11.03.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:35:52 -0700 (PDT)
Message-ID: <16b71fd7-9911-429b-a5a0-577f6ba0e999@redhat.com>
Date: Tue, 11 Aug 2026 12:35:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
To: =?UTF-8?Q?Jens_Emil_Schulz_=C3=98stergaard?=
 <jensemil.schulzostergaard@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 Russell King <linux@armlinux.org.uk>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/26 4:34 PM, Jens Emil Schulz Østergaard wrote:
> This series provides the Microchip LAN9645X Switch driver.
> 
> The LAN9645x is a family of chips with ethernet switch functionality and
> multiple peripheral functions. The switch delivers up to 9 ethernet
> ports and 12 Gbps switching bandwidth.
> 
> The switch chip has 5 integrated copper PHYs, support for 2x RGMII
> interfaces, 2x SGMII and one QSGMII interface.
> 
> The switch chip is from the same design architecture family as ocelot
> and lan966x, and the driver reflects this similarity. However, LAN9645x
> does not have an internal CPU in any package, and must be driven
> externally. For register IO it supports interfaces such as SPI, I2C and
> MDIO.
> 
> The chip supports a variety of network features such as
> 
> * Mactable for MDB/FDB functionality
> * Bridge forwarding offload
> * VLAN-aware bridging
> * IGMP/MLD snooping
> * Link aggregation
> * PTP timestamping
> * FRER (802.1CB)
> * Media Redundancy Protocol
> * Parallel Redundancy and High-Availability Seamless Redundancy
>   (HSR/PRP) in DANH/DANP mode
> * Per stream filtering and policing
> * Shapers such as Credit Based Shaping and Time Aware Shaing
> * Frame preemption
> * A TCAM (VCAP) for line-rate frame processing
> 
> The LAN9645x family consists of the following SKUs:
> 
> LAN96455F
> LAN96457F
> LAN96459F
> LAN96455S
> LAN96457S
> LAN96459S
> 
> The difference between the SKUs is the number of supported ports (5, 7
> or 9) and features supported. The F subfamily supports HSR/PRP and TSN,
> while the S subfamily does not.
> 
> The intended way to bind this driver is using a parent MFD driver,
> responsible for the register IO protocol, and distributing regmaps to
> child devices. The goal is to use the same approach as the MFD driver in
> drivers/mfd/ocelot-spi.c.
> 
> This driver expects to request named regmaps from a parent device. This
> approach is similar to the DSA driver
> 
> drivers/net/dsa/ocelot/ocelot_ext.c
> 
> which supports being driven by an external CPU via SPI with parent
> device drivers/mfd/ocelot-spi.c.
> 
> The MFD driver will come in a later series, because there are
> requirements on the number of child devices before a driver qualifies as
> a MFD device.
> 
> Development is done using the LAN966x as a host CPU, running the lan966x
> swichdev driver, using the EVB-LAN9668 EDS2 board.
> 
> The datasheet is available here:
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/LAN9645xF-Data-Sheet-DS00006065.pdf
> 
> This series will deliver the following features:
> 
> * Standalone ports
> * Bridge forwarding and FDB offloading
> * VLAN-aware bridge
> * Stats integration
> 
> More support will be added at a later stage. Here is a tentative plan of
> future patches for this DSA driver:
> 
> * Add LAG support.
> * Add MDB support.
> * Add TC matchall mirror support.
> * Add TC matchall police support.
> * Add DCB/qos support.
> * Add simple TC support: mqprio, cbs, tbf, ebf.
> * Add TC flower filter support.
> * Add HSR/PRP offloading support.
> * Add PTP support.
> * Add TC taprio support.
> 
> For completeness I include tentative plan of planned patches for
> LAN9645x peripherals:
> 
> * Extend pinctrl-ocelot for LAN9645x:
>   https://lore.kernel.org/linux-gpio/20260119-pinctrl_ocelot_extend_support_for_lan9645x-v1-0-1228155ed0ee@microchip.com/
> * Add driver for internal PHY:
>   https://lore.kernel.org/netdev/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com/
> * MFD driver for managing register IO protocol and child device
>   initialization.
> * Extend pinctrl-microchip-sgpio for LAN9645x support.
> * Extend i2c_designware for LAN9645x support.
> * Add driver for outbound interrupt controller.
> * Add serdes driver for lan9645x.
> 
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
I forwarded the feedback from sashiko/nipa, but sashiko gemini has more
comments:

https://sashiko.dev/#/patchset/20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a%40microchip.com

please have a look and also to net-next commit c82ff94592fb

/P

