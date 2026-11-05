Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887578;
	b=bQ5d+lnd0C535Z80/R6V2qKATEBwH8WkBBmKMmWwDdiSWg6nGuKljLEdU3ioXGhFxzvc
	 d/f652rqo8PHGcTjfiqIONtdBseZQkWM2qDPThgC6K1h+Bs4IbCL7MEnxg7SqSBx9sJVD
	 CsvZP8xS5/COdrs30VxuRcH4Q+ApdRv4MmfSq0Vwa5GOMKUU9jmmvdlFey4011ry5SHTF
	 SuF9xFu0MvQDP4rQF+hWS5xdw6V3NEoQssRDEdqZt88vI+elERUG427sHl2e7tr3vCztk
	 C+PU5fs1gk1x9rmeDbD3Qdyuv0QnZ7F8UxauCW2AYxeQSOI2Z6Ccm511eqzqzkH0hKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UJCvvH2LVzLLKKiKlCpu1moOiFoxJyhCDFLz6en74v0=;
	b=Es1tC2eAZa+i5kc8vI1qV+pNVBKerwqtQLRfT2jHlc1Nq1AJgNxtxay35fF0SlC74FcA
	 U8Lmo8NvIroqtTcbmmHGU0EzgxEd67Z9f+6zDSkQNu2HcY4U1UDfotqyK6yZQZevnsU1P
	 +oKvgAawZnGzEiKIuQDfgI2XbzcdPr+6j2NfdZrwhVI4/VVmzdxubDtI1kDwFD9MXxfXP
	 dqehAAgoQHO0LEm8/b6bdJJkz7mnxSyKgRvAkF7Yhn2SiUwVANKgoPtEen0gxxwergeA6
	 oTEe2h14JD/6LXZierKvfcLfJRtfsQdNE7cO2lm5wrnY9y7c1VWm3C9Gtt+0nNIuVmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b="fOD/4HlG";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3985606EE96
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3985606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=fOD/4HlG
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so17424445e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793887576; x=1794492376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UJCvvH2LVzLLKKiKlCpu1moOiFoxJyhCDFLz6en74v0=;
        b=fOD/4HlGPz3p6ReV4CfAWtPZfVdjBTvS80aQFytCHG+6jvIftCSh6f33hBH74qDKMD
         ftCb2VZnl35ODwucMVWosLYjOo+gqKLVsfL4wRp+2ScgKMOo4xVnCgqfr8/3m8l+r9/B
         kC2ereSHyGhSuzM9TwXN52enpcQLEgnTub3nyrkWfpPQWnf+4jt6m9gFA7NjfG3ZXmlA
         NYhJmxex+zpzci+DTQCBHdH1/s5ASBB7wxqC0XO8zKYB6o4ySvfD4DC6PLVDtU69CbjI
         8siL3N2z7ShBjJzbX7zhb9ks3cqC79+P2To5mG7LESNlNW+mdoKOvw+RX/ntmvhwfP6S
         0Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887576; x=1794492376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJCvvH2LVzLLKKiKlCpu1moOiFoxJyhCDFLz6en74v0=;
        b=w/O253ak2UeNaKeq2Kg9uWNSJIHQDsS/PN1KTzLMwSW/BTeGMKhkfA28E6CEj7GbhD
         OPOUg8fyJuVMTt4KsfniH12JFu0fNBat/prpzv4XXQqkAnBN6a1KIjnsUKOmOJ7FQ6KN
         /FBHj/6uUJg80GepQRS/rlMtX078HR/bpiKm4vp0+vLUvEiwfdPmkTxLvS2bgngQTH7r
         39cOvwJX4WxZdCk0ws8WrljZBTN86spORcXx8Hf4gyS4h5oDq/DTCYxb2MHi95yH5dT2
         bSqL8DuJmgORREGqDUzxRx+13ClKud9n2MziJKPgoNHc6szZEtpMgTs0U489zvDX/7VS
         OyTA==
X-Forwarded-Encrypted: i=1; AKwUvBx2u6rZZWqzLXWRD9oJs+dw8AE/RIaFa9q8T5kPo9nAqDW0rfad8FXY2S4Eow0QlKr9PtzeR84=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3/BjQIT/krg/Kv/tDTsDXTZXftfFre+jViTnU0eIu75vEJED4
	sDX+swWHrRbcTZ17MJtMzzIVCCbor+NVpWhCcNulzPzfHvtaemhu0VhOwOcVtm9iKYM=
X-Gm-Gg: AYBFou1yeWX42/FCUA80Wc67TYotuZ4DjHF0Y4WIO/eoJCnAXmNU8Xd6aiwqlcGkTIr
	8Tz5rVNwCioIuasvj16Ini8PESP4VgFJck/fz0BYJw2TYxdMnhbQrDgZ8OdqrS8t4CdwxC27GMS
	M2rxYKSLPjFM9Ylk8dSY53bUXpzeOJdKE0X128hZULDSyNvBMB5RXnnHvmLB0LCAIMxff+oxfu1
	PLdjsGmjyTVXz4JtiGI7b548WimYzKZPhIUi05GggEXKCceHGcWObeeiGGydQrRe90AkgUisgKQ
	UDM5yfr4WDi7C1ykKEgIFacwGojJOWm78k3DThOFOLpJ36guCIxhJOkqQV+KLS8e7NGV7zFf36m
	U0i0lg+Yob90CeSRARwbK2qa6Ng3DLzd1ZVAqOFIaJ4496SkMBrAtGh8WNs73HSG/yEY5BezO75
	eGzLW1sfCrH7BnJO/zMucajdvUwCrCWDxb/k7+XGNKjgxDziZBzF/ITZPeofQHumMobjmE16MTM
	L1p29eA3BupQWT1PVkDQq5btu7PV4St/YruWahQP9duvst1NTM14g81LMCaGfCB53pkef9nWB2N
	vWDQDDwcSlYM3KXzTg3acwJStsC9nDblbh2VE/zZ/xYJIVyaGYXb8dhS1t3CDOdCmqph7Rn4o3z
	gkoiHKaNgSot4qDfpS+AdsSzjNqKwy1nCZtPzJh79zwAV1X/uKzDkAr2XCiRKGOb2e+2OwlBSz8
	VD21wRQaVNHbUn
X-Received: by 2002:a05:600c:83c5:b0:4a2:148b:c88c with SMTP id 5b1f17b1804b1-4ac17191017mr399753615e9.8.1793887575774;
        Thu, 05 Nov 2026 06:06:15 -0800 (PST)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57203a98fsm59048765e9.4.2026.11.05.06.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:15 -0800 (PST)
Date: Thu, 5 Nov 2026 14:06:12 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, richardcochran@gmail.com,
	p.zabel@pengutronix.de, peppe.cavallaro@st.com,
	joabreu@synopsys.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: stmmac: support the TC9564 SoC
Message-ID: <auyNVNo2I_Xunxi-@aspen.lan>
References: <20261019030129.1470307-1-elder@riscstar.com>
 <20261019030129.1470307-6-elder@riscstar.com>
 <3d0b17c6-3b94-4e36-b7bc-700211c83273@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0b17c6-3b94-4e36-b7bc-700211c83273@bootlin.com>

Hi Maxime

Actually, this might be more for Alex to find when he works through the
review feedback but...


On Mon, Oct 19, 2026 at 09:52:58AM +0200, Maxime Chevallier wrote:
> > +static struct tc9564_mac_speed mac_speed[] = {
> > +	{ PHY_INTERFACE_MODE_2500BASEX,	SPEED_2500,  SP_SEL_2500BASEX },
> > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_1000,  SP_SEL_SGMII_1000M },
> > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_100,   SP_SEL_SGMII_100M },
> > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_10,    SP_SEL_SGMII_10M },
> > +};
> <snip>
> > +static int tc9564_mac_speed_select(struct tc9564_data *td,
> > +				   phy_interface_t interface, int speed)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(mac_speed); i++) {
> > +		if (mac_speed[i].phy_interface != interface)
> > +			continue;
> > +
> > +		if (speed == mac_speed[i].speed || speed == SPEED_UNKNOWN)
> > +			return mac_speed[i].sp_sel;
> > +	}
> > +	dev_err(td->dev, "%s/%d unsupported\n", phy_modes(interface), speed);
>
> Is that "mac_speed" lookup table actually needed ? maybe a simpler switch/case
> based on the speed alone would be enough, or do we really need to validate
> the phy_interface_t each time ?

Once we add 10G PHY support I don't think it can be based on link speed
alone (for 10G PHY we have to write the same value to SP_SEL regardless
of link speed).

However even when that happens we could still code it up using switch/case
and ifs.


Daniel.
