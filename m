Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC648CD54
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046167; cv=none; b=ZkG6QFUhKAoBfps8ij+ReCVNSO7U4lPyBkmSTnAOgadPe4RASznGgPiy5zgyWI6U/cjHBPCmhE6gUJ3xXie58phuMdZQwxNhyFyRIvzVtRX6xtVy/BBqcgYtCTngJ6cXywB4e78saPicvdi75kEIGraF9KIXYn08GRC+0tzFPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046167; c=relaxed/simple;
	bh=5yTTq1/XsmwCBvY8kHAUtMKgJZVPGmWsxtmZqbt+3EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZgEQt2kGtEbXFfEScBPm6qWx4PHdTJeMrYe+31WFns70TBsKHTdHVJlaxrFPdGQ5uUrYW8D109IfOfRLPdzH9fun3H/vAPSNLeeHGYb+7590c1Yzye0rbuYFCB3dyu9QY+r7/5X+0SDrJaQ9bXAcyKrNKZnHF6blq6ovm8odFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fo1ZzWkK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMyxUmKz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo1ZzWkK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMyxUmKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789046164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1OZi1zQ+XqiZWXGSYJusIHWCY5uWKCZSFZWv7Uia6Y=;
	b=Fo1ZzWkKxdHze3vEAZKLc/u2cpQ5bbnRKesmEGbNoXT0Umh4ErBgdGVjVKJ7suZ8P60hXP
	X1ODf9QzRRFxNfVjhVhALUAN840zVatI4xzblt4w/WuFAfIaNDCW/7ywMSiQV/cUOK050u
	Mujs8/r1FNIRznF2N+gQQfyEH2r0es0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-e-rvyhaFPlObQosu-4BQVw-1; Thu, 10 Sep 2026 09:16:01 -0400
X-MC-Unique: e-rvyhaFPlObQosu-4BQVw-1
X-Mimecast-MFC-AGG-ID: e-rvyhaFPlObQosu-4BQVw_1789046160
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-485afdd5079so1550397f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789046160; x=1789650960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1OZi1zQ+XqiZWXGSYJusIHWCY5uWKCZSFZWv7Uia6Y=;
        b=NMyxUmKzORHr7zX1F+GXC75UpP0h80zXEcqZq7Km4H8yfzzcYzz16RlCjyOPgr9U7d
         foUMbgP1IWFsEP0qYbJMjkj0ZpClIQV41Xec/Qb/EVm9TY7ml44ZdTjVQvl7KoZavtdL
         PfK7G9Vur8g5KVd0Mzzsd7FPIVZA7YYFxT+f6NDWO945Ftgia1300hNMRJDXm62RU41z
         rpbZS4Nl/hw+lO778qxbcXDx6kym+RKkmzEzDfpd+pKFg38SsVsh5xbUeoSzMwsCg801
         dJ8UqhAo5pcXeVH0l4fhZ8G4c8qbAkq3KuBacwXnQBpX05ji8mkrZubhpCz1bMl0fb+U
         O9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789046160; x=1789650960;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1OZi1zQ+XqiZWXGSYJusIHWCY5uWKCZSFZWv7Uia6Y=;
        b=VMbmKAuQTKRPrk4i3pfBHXsln5IoExAyY858v4G2sW4TFfJdbWeVrBuZOKjb0sr+ey
         11Num9O1iN+zfvMpVRD8BhaRE9fITZ+Jo11arLFxx97KFPflC+Z9a6Hzwac0Jq+MPEY7
         86kZ/e+6PIA+5Y7NVk0Sun3Zs/2me0fdAb49ZD+F2Ggrif1pKpxpMnuRFZBhvLx++ah9
         hDbPRDPaqgAPF2Cn3wFaWXJu8PC1aBKijRU3Iuf7dweebBWB8HZKZO+9H2ACY7WvjZFC
         vnnT8hCu1CqY6YcNe3nZD/ZyapvFi/CoexTMdJfaNoApvgCJ585B4htzOCiBDCuWS5Ey
         e1IA==
X-Gm-Message-State: AFuF++ndZLsUrBltuwRaTg27690FGzHLjvceb6iWJ13AbZLwZixVwkfA
	XUFeabV8lo8kfKdamB26XuQb2LWEo35Oof51K3brDftbXRHgQV68nQiemF5RyQ3C8odqno2wjiq
	JG4Moqil1FBqP0invjQpNclfGSGoneRi4orNZAxGqNlUKQXOwycPVT+qA5A==
X-Gm-Gg: AYBFou3Ji8IiJfFrzdqbQI3uUv9qRgQdzi8r6FT5gs4kUwTOeJaJyCKmKt8PYVjJmj4
	5URvPBAadAD6XP897QsK9xtiP0jzfEI+Lhqkfg3damdTkPOdRABP+X5Yl1qa/dKk+ywlq6+2KX0
	E2agoxpuVtqx2RGoZ5/4iiTXhXWosDNSXT8uDPrd8fIAoLFbOsMApOPO8zzVPGT0tmQVmx6s+F1
	m2uFjoaEsHt4dERQau67DLJtjXs4D6V21DwdJjD8Ho52LxGXOqMX36Sl+7Fy+yl4mdROJiga0oG
	wuvbC3qM4yKNT4MNotNSj4XEQPsHu0A/wxf6Vo61Tlg/7B3mBrpBxuj7S+gInUuj1JmAwX9WTNs
	kPjHzlCgOgcHOXJL901f7BjWh9YVPDPibG1+4H70K+A26aU8V3vYrm3zy1/SJ3AjtNRkcePXoWg
	==
X-Received: by 2002:a05:6000:2f86:b0:485:8ad6:1af9 with SMTP id ffacd0b85a97d-4858ad61f16mr39481768f8f.12.1789046160220;
        Thu, 10 Sep 2026 06:16:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2f86:b0:485:8ad6:1af9 with SMTP id ffacd0b85a97d-4858ad61f16mr39481704f8f.12.1789046159707;
        Thu, 10 Sep 2026 06:15:59 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm50809210f8f.35.2026.09.10.06.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 06:15:58 -0700 (PDT)
Message-ID: <1a1e531c-90db-4a68-bce1-517ada2fe4a0@redhat.com>
Date: Thu, 10 Sep 2026 15:15:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: phy: air_en8811h: select LED GPIO pins
 based on AN8811HB package variant
To: weiting.lee@airoha.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, linux-kernel@vger.kernel.org, bjorn@mork.no,
 ericwouds@gmail.com, frank-w@public-files.de, joseph.lin@airoha.com,
 wenshin.chung@airoha.com, lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20260907015638.2875763-1-weiting.lee@airoha.com>
 <178897303632.219967.12350879229326827803@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178897303632.219967.12350879229326827803@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 6:57 PM, netdev-bot+sashiko@kernel.org wrote:
>> @@ -1115,6 +1167,12 @@ static int an8811hb_probe(struct phy_device *phydev)
>>  	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
>>  	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
>>  
>> +	/* Detect package variant */
>> +	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &reg_val);
>> +	if (ret < 0)
>> +		goto err_dev_create;
>> +	priv->is_an8811hbcn = FIELD_GET(AN8811HB_HWTRAP2_PKG, reg_val);
>> +
>>  	ret = en8811h_leds_setup(phydev);
>>  	if (ret < 0)
>>  		goto err_dev_create;
> 
> [Severity: Medium]
> AN8811HB_HWTRAP2_PKG is GENMASK(14, 12), so FIELD_GET() yields a
> 3-bit value here, but it is stored straight into the bool
> priv->is_an8811hbcn.  Any non-zero package code therefore collapses to
> true, which means the whole variant decision in
> an8811hb_led_gpio_setup() rests on the unstated assumption that
> AN8811HBCN is the only encoding with a non-zero value and AN8811HBN
> reads back exactly 0.
> 
> If the field can take any other value - a second AN8811HBN encoding, a
> reserved code, or a future package - it lands in the
> AN8811HB_GPIO_OUTPUT_0115 branch and the driver drives GPIO 0/1/15
> plus the SEL1/SEL2 mux for a part whose LEDs are not on those pads.
> That failure mode is silent: the LEDs simply do not work, and there is
> nothing in the source that documents what the encoding actually is.
> 
> Could you define the expected package identifiers as named constants
> and compare against them explicitly, e.g. something like
> 
> 	pkg = FIELD_GET(AN8811HB_HWTRAP2_PKG, reg_val);
> 	priv->is_an8811hbcn = (pkg == AN8811HB_HWTRAP2_PKG_HBCN);
> 
> so that unknown codes fall into the conservative branch rather than
> being treated as AN8811HBCN?  If the hardware really only ever reports
> two values and 0 is guaranteed to mean AN8811HBN, please say so in a
> comment next to the assignment, since the reader cannot tell that from
> the mask alone.  Also, is it worth warning (or failing probe) on an
> unrecognised package code rather than silently picking a GPIO mapping?

I think we are better off without per pkg macros until there are only
2 of them around.

All others are doubtful nit-picks.

@Weiting: note that you are requested to address sashiko comments
proactively.

/P


> 

