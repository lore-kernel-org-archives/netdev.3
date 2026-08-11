Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA542B31E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444629; cv=none; b=Q7titsO/isCrDZxIyjxB8u1dX2xazHihl89Obqn03/cLfJ9ueHdv4va7o8WFF5M3nEyd4rYdCmhdrNjE2NBn5vfiPtS9GR6SmKzIV426+lbjhaoX6+QeYmbctWZNsBtWN1Ny3N1oKhXOwZaKxS1CxfmW8RCLZ4YbfTwnfAe36qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444629; c=relaxed/simple;
	bh=gB3yqOeIsaaKzEUsb9uO6DUqNT2MwS8x7bL5ueDtyjI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ASyw/8tA9zGxRUG/BCaIrVoKBSA1xaEkT6wJWsD9PH0CGOuhxD5CPb/FtUsquPgxJzjkyahtofDSz9ocHSe6QSSDwERySRi5h5ILoXxJqJu+wif1n6CnKAvG6zZkZyCxZ5jvQPEHsLqMyoA1QQ50eoOjH9rXwqo5/GQ7lFVp5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhBAknql; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmxUUEk4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhBAknql";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmxUUEk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786444626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD4hJ+lUljz5+S3ejOLlVQpGKrh+mo85PPvj3j6hOww=;
	b=VhBAknqlb3F1z9PZebXesGHtEutVyYH5B8lU/t4ycpHBxKDaay6P8Qky+ZPaxdyuMCI1y3
	64aS66Q3kVz17sYKZKgA6cS0G1YIHSUXp7nnr126glREfWFQWd56jPp9so2wraxXNkxr0t
	VdZiyVGXR1tdEB0OMTNHCqRMSO5Bu+8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-8_LYhk-JPfa0tyC4WhjSvw-1; Tue, 11 Aug 2026 06:37:00 -0400
X-MC-Unique: 8_LYhk-JPfa0tyC4WhjSvw-1
X-Mimecast-MFC-AGG-ID: 8_LYhk-JPfa0tyC4WhjSvw_1786444619
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so29154425e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786444619; x=1787049419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jD4hJ+lUljz5+S3ejOLlVQpGKrh+mo85PPvj3j6hOww=;
        b=LmxUUEk4EnHmWvMUg3gdxOJWWuHYPjBxdR39/p09puAzxglBClP6uAvtdgOeWQ3aez
         ym67dt/FTmsLzDIfiRGZJEk5eu0sMAoPLRV1+7zeCaR7fxmSgO8sonqYmRABrX4yahOg
         T1qsPRqGI8DPuSaBp4t74Xfyv8bqAjZsJAtTU0IPMVMyqC95ku2somTGLa9EGozfliil
         AHAweU+L0iJeID421i9jJph941V3LJ1CsYNI+96o97Ngl5f03J6Uj9ZkB8v0mfwqDtUC
         1ZOxA/y9Rkt8u1JrY4C8HPQi+BmEgdK/RHkwCCMqyIqtQpkfo6Z5i/VGdaqYMXfBjx4o
         t6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444619; x=1787049419;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jD4hJ+lUljz5+S3ejOLlVQpGKrh+mo85PPvj3j6hOww=;
        b=L34iCaTCwpHnXz2Km0AZ0QyVNviqWBt38jOsiy5Y5T1EapowxzX7uPiSFy4ZUhqkjv
         VK3BUaRtOH1KZu7mTL9gaTFQspQk2zVstmzoDPW0PE1BeTmKPzEoQOCQibTeeiHMNiP1
         qeCy9YK2UjNNcDgHFfelHF6Jb/tQk8zTekpQFRhg3ER00IH120WvbFZk3gXqcbFq9xKI
         FEkljzjZ1jfCYcDmSN/H7A35n9ZoVudcCGJAIKJs04w+sexEWyAQbzYkJ8YViHNfw49E
         3uLSIhYbdW7G5XcLUzwqGjiiEuJqV1GmAP7O4SMeHnMjt/NIuLBYxiWTFaYYE6psZEH5
         pZjg==
X-Forwarded-Encrypted: i=1; AHgh+RqqrWRkh4fDmDjQJQ8AmA/7b2nV0CIDcC5oIrq3gAdePxGI8aVW4dSbqpjLb16udVD2mAEQi5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFAvRpodpoj71kLHOmea5gxTpuDAOhjtklJ+Qck4rygzTUC68
	LsMfdjr//dfbgVuwmgUi5GhDKwHJFULSFP2cIwrYn7p46DJoQd92LPF6i4J8JudA+mEGbtyxomu
	D/T03nbF0VnwSv4XBfEVdG1cpFSXT5kqTkoySCmsgR44AwN5O2SRXcuDXnQ==
X-Gm-Gg: AR+sD12G9b6QAmv7GVaUo23VzXZHtbWKrmxjS+726fPm0qIsni325dq2RdzO1lWGSH3
	xCieAQgiQt0E4vauqDdF5FiGFLfhd/81+VN8kU2hjIli+FeEdXRvcZCKdkOaQsSwnkgQwADSz5u
	/Dom8aciyqCHQLattYNEGtCoulLVm4KIudRAVtibzb+KaI7OaAlRJw7p5lC0iOm93EdJLLKAQk1
	hPJy/hhcusov/sYXZquq7rBwn9RrewttK7lH5TFi3cR+CYPwQAGRggmJcuJT5HtF1xrZ/ZRNV6s
	wqfoYuc+5rylF3Y/aCpZWubei4tWIDy7mhEHpBjhzGDebcqwxaN9eseabkf2K4KIer8zjS1hu8R
	TDBzUGz/JzCZIhwuOiz3A1KwBGlk1dBj6Q3/97DYADLPwdNnsx4Ncm8SDVGilaxYZd0X9bpivX3
	o=
X-Received: by 2002:a05:600c:310f:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49978439635mr27492775e9.5.1786444618957;
        Tue, 11 Aug 2026 03:36:58 -0700 (PDT)
X-Received: by 2002:a05:600c:310f:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49978439635mr27492175e9.5.1786444618470;
        Tue, 11 Aug 2026 03:36:58 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm33743245e9.1.2026.08.11.03.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:36:57 -0700 (PDT)
Message-ID: <2699d4d2-fb2e-4f87-9a41-88627f16fb78@redhat.com>
Date: Tue, 11 Aug 2026 12:36:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
From: Paolo Abeni <pabeni@redhat.com>
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
 <16b71fd7-9911-429b-a5a0-577f6ba0e999@redhat.com>
Content-Language: en-US
In-Reply-To: <16b71fd7-9911-429b-a5a0-577f6ba0e999@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 12:35 PM, Paolo Abeni wrote:
> On 8/5/26 4:34 PM, Jens Emil Schulz Østergaard wrote:
>> This series provides the Microchip LAN9645X Switch driver.
>>
>> The LAN9645x is a family of chips with ethernet switch functionality and
>> multiple peripheral functions. The switch delivers up to 9 ethernet
>> ports and 12 Gbps switching bandwidth.
>>
>> The switch chip has 5 integrated copper PHYs, support for 2x RGMII
>> interfaces, 2x SGMII and one QSGMII interface.
>>
>> The switch chip is from the same design architecture family as ocelot
>> and lan966x, and the driver reflects this similarity. However, LAN9645x
>> does not have an internal CPU in any package, and must be driven
>> externally. For register IO it supports interfaces such as SPI, I2C and
>> MDIO.
>>
>> The chip supports a variety of network features such as
>>
>> * Mactable for MDB/FDB functionality
>> * Bridge forwarding offload
>> * VLAN-aware bridging
>> * IGMP/MLD snooping
>> * Link aggregation
>> * PTP timestamping
>> * FRER (802.1CB)
>> * Media Redundancy Protocol
>> * Parallel Redundancy and High-Availability Seamless Redundancy
>>   (HSR/PRP) in DANH/DANP mode
>> * Per stream filtering and policing
>> * Shapers such as Credit Based Shaping and Time Aware Shaing
>> * Frame preemption
>> * A TCAM (VCAP) for line-rate frame processing
>>
>> The LAN9645x family consists of the following SKUs:
>>
>> LAN96455F
>> LAN96457F
>> LAN96459F
>> LAN96455S
>> LAN96457S
>> LAN96459S
>>
>> The difference between the SKUs is the number of supported ports (5, 7
>> or 9) and features supported. The F subfamily supports HSR/PRP and TSN,
>> while the S subfamily does not.
>>
>> The intended way to bind this driver is using a parent MFD driver,
>> responsible for the register IO protocol, and distributing regmaps to
>> child devices. The goal is to use the same approach as the MFD driver in
>> drivers/mfd/ocelot-spi.c.
>>
>> This driver expects to request named regmaps from a parent device. This
>> approach is similar to the DSA driver
>>
>> drivers/net/dsa/ocelot/ocelot_ext.c
>>
>> which supports being driven by an external CPU via SPI with parent
>> device drivers/mfd/ocelot-spi.c.
>>
>> The MFD driver will come in a later series, because there are
>> requirements on the number of child devices before a driver qualifies as
>> a MFD device.
>>
>> Development is done using the LAN966x as a host CPU, running the lan966x
>> swichdev driver, using the EVB-LAN9668 EDS2 board.
>>
>> The datasheet is available here:
>> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/LAN9645xF-Data-Sheet-DS00006065.pdf
>>
>> This series will deliver the following features:
>>
>> * Standalone ports
>> * Bridge forwarding and FDB offloading
>> * VLAN-aware bridge
>> * Stats integration
>>
>> More support will be added at a later stage. Here is a tentative plan of
>> future patches for this DSA driver:
>>
>> * Add LAG support.
>> * Add MDB support.
>> * Add TC matchall mirror support.
>> * Add TC matchall police support.
>> * Add DCB/qos support.
>> * Add simple TC support: mqprio, cbs, tbf, ebf.
>> * Add TC flower filter support.
>> * Add HSR/PRP offloading support.
>> * Add PTP support.
>> * Add TC taprio support.
>>
>> For completeness I include tentative plan of planned patches for
>> LAN9645x peripherals:
>>
>> * Extend pinctrl-ocelot for LAN9645x:
>>   https://lore.kernel.org/linux-gpio/20260119-pinctrl_ocelot_extend_support_for_lan9645x-v1-0-1228155ed0ee@microchip.com/
>> * Add driver for internal PHY:
>>   https://lore.kernel.org/netdev/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com/
>> * MFD driver for managing register IO protocol and child device
>>   initialization.
>> * Extend pinctrl-microchip-sgpio for LAN9645x support.
>> * Extend i2c_designware for LAN9645x support.
>> * Add driver for outbound interrupt controller.
>> * Add serdes driver for lan9645x.
>>
>> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> I forwarded the feedback from sashiko/nipa, but sashiko gemini has more
> comments:
> 
> https://sashiko.dev/#/patchset/20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a%40microchip.com
> 
> please have a look and also to net-next commit c82ff94592fb

Whoops, sorry I missed part of netdev traffic. Please ignore this one.

/P

