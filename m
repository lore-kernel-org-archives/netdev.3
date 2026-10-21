Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590919;
	b=UyVq9ti85mVceDy9J79MFcbALgs5dOXi6OGuAA6MV6GUkfsTUk1Kj6dxN9kUvdKldW/c
	 OL/5eIusorVBHy04zuyQ+bTulgWGPabRvDDCBRkSQ0pXXvcko9Mr6moG3nlhT+4AavaIZ
	 i0LKZfxhM3UkaRF+MoehQWtgtapBfhsWoPKAWQiArg/h0zIRBoh/tb01B2YvUC7UCswMz
	 zgNlRuO1gDH8r+SQfq5Uxfx0tz0LrVhbQiE15Kx/32MpTf9lhpeoK8eQoQXlHSTzTI16N
	 /HQuo+sO64jNLDxXc/F+pFDQ3Qgighs4rIs7YeaEJGpm9ZVWnHE2q57Gxr3+zgDR8CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590919;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gcdtC/fQilVLytvcExf3DvZGKa+sg+zSw4aP6GRTCPo=;
	b=Zf9KenoYD5lzymBhNRF4SYpxuwL2BV/JwvyVi1aaQqnL1bGAp3DqFm3J1WXRfPmBazB7
	 Ya0PG+HHLxowqn/2sesjpWWvoMiCGdRKn61jtNb1wmnmXf/27WUBa/Zy0Xds1EftFKJcw
	 Aoi7FxoWaVRdnTiZVdXwoy6JSAGR9nqXZJPJvzkYfJaxK5FW7hDmhyITPrCGKZ20cXoAf
	 1Mf+AylMblS4dzPdt6GfY8suKRip5Fe+yhU+aCNQZ5NFae/+UceKtkQWs9P0XE7wY1jpG
	 9BbbPO0jwaNpjcAapOA5UCEqaBf0FlfWOZo2C+A+4btqebcOOPjRcpgQEeH3i7tCmQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXGY1kjr;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="lfKn/C4s";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D352606A33C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D352606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXGY1kjr;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lfKn/C4s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792590917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcdtC/fQilVLytvcExf3DvZGKa+sg+zSw4aP6GRTCPo=;
	b=XXGY1kjraEw7shUoV9sJKwszb9fX5iLZG1wneJOmUYzxPtLEuAVzJQWa8eZflItlo8ehky
	A9c9g9xC8j/Gucg7EtK97lnofwDXR3WLeZvqUx+wCKL9cQZcz6Trfb8CKzCy9wcZuOKw78
	WfVaXxSqLL4RSwyom7lQtlEFiXJBVm0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-be3Ybq1gNpG4KKFVQXtxNw-1; Wed, 21 Oct 2026 09:55:14 -0400
X-MC-Unique: be3Ybq1gNpG4KKFVQXtxNw-1
X-Mimecast-MFC-AGG-ID: be3Ybq1gNpG4KKFVQXtxNw_1792590913
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b027578a4so615391f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792590913; x=1793195713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcdtC/fQilVLytvcExf3DvZGKa+sg+zSw4aP6GRTCPo=;
        b=lfKn/C4sq6Z9mlrqEpKLhZ9iOenI1pxXhgIKMe9xra0t3vPbK3KS+FEsYBPa5W33bY
         vjFl6QxDIGS7EhYdcqcOBYwKBP9Y7LHDT5GzmiF2pKXpeCaGn2dHVZWKF8/tylZ3973v
         AV+H5Daaw8JKSKCuO9aJQwE65hP1BKnWDhzYJQMbSySkO7gSQnVSMa9OSa5VwY/bpjT/
         C96eFWLZ9pGOjxWXypPCytKStTSrpErqs6QiRItfPLQczs/99JPb+WYM18H3vOiIqM1c
         uIM4VJoqZ7ar5ywc9svdfCMO8T9gscb+9LsJm8SE1hwOkXRmX/F9Rzg6BeEcWnR7goTZ
         FhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590913; x=1793195713;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcdtC/fQilVLytvcExf3DvZGKa+sg+zSw4aP6GRTCPo=;
        b=XxaOacnM1teRJuwIZjFsYtfsuXu0JcozWpcIMe1F+jO/UL42/MRijIQweFjhqFIaK7
         7mstZoNDRhQe/5VPwHfw7OD0HN9Z0nJ3TZytfA4tpOPhnGFsIOYj7Sf7rtwSY97l1EEE
         tf60c9UVkvgClmBfcC0/eq1xa9whwsZeeXlTVlVQ4kjC4GeqtDLgDYwc8pXl9oQ8lkka
         3RtQZVNWKXpbbBsXgnOTs4uAj9WPzAxmtNLITVNCF9PwFhj/zh8aExtZJX8oqwH9Y85E
         iYk0I35YrOWOSAbLLwR4HoaDU5o/grBfmyIf3P3GmIRAKI7MKR560xyTx1xcA1cS07m0
         ALUw==
X-Forwarded-Encrypted: i=1; AKwUvBwSuy53OshdSHN9ifKlBMY6atoYg42QX/wQHOxY+UHU03LctARGosycDOLs/qbCvZd8NtmN0gU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnXRbe6RHil5KLd9lG38Qympqb01rdmfQlbq4nO/cCmxCZinIj
	VNYmoA1rkucFZfpNDVf0YYgZ74NL7eBlgDk3N3tECTvSuCLOdHbIC9VuHEh8jMr07ch+Vd+Kn1l
	yhkHpDUbde6piaIyEvHPx/Qq+lf1TCAYnmaPn+BDodTG2Uuyv08VSadyM6A==
X-Gm-Gg: AYBFou38+obNzr5YWSxEg+PrXiMoq266AIPVJlIF0212jgYiJvFU0/bGImd5Tb6kUJE
	YL/b766LRLiSfB3RtimnHJk9wK5rCgfdOejkYGPUZ8uRNKmzuqH8p6tt8QUoxP31eHrgVgsvOt8
	q6rwszzRTiH+Q27j/gQbrWI3awYoiXSSvCfeRkFhyKqkWBANAXHGaEIf7b7+dgUNWL7GZDMdvdm
	2Xf7om2G8xRbRd9lT/F9DXJeuRksSEo1bU7VZGRA2a1PsWIjtmbETtSdEgy0iKFWEqHfvyvzHEw
	bvnwkJYgJl02P+VeqWgFMFoEZ9Wr04JNh02qkSf2OMTYwbTzPnT9uI3kyhpb/UJE/TKRFgWJc2K
	McH0k4YiFlMa9vudzhEDRSityu+FMGnfUo8gdy/uo1eYA6C4yvh90H06niqu3kY/c4dHqlMEjsA
	==
X-Received: by 2002:a05:6000:2211:b0:48d:f488:f32a with SMTP id ffacd0b85a97d-48e264bfce8mr4070954f8f.56.1792590913295;
        Wed, 21 Oct 2026 06:55:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2211:b0:48d:f488:f32a with SMTP id ffacd0b85a97d-48e264bfce8mr4070902f8f.56.1792590912728;
        Wed, 21 Oct 2026 06:55:12 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835e22sm6389477f8f.44.2026.10.21.06.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:55:11 -0700 (PDT)
Message-ID: <668e4c5c-b034-4bf0-982f-501da29c6571@redhat.com>
Date: Wed, 21 Oct 2026 15:55:09 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/6] net: mdio: add timestamped MDIO writes
 for PHY gettimex64
To: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Conor Dooley <conor.dooley@microchip.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Hubert Feurstein <h.feurstein@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261018100257.566267-1-jjc@jclark.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261018100257.566267-1-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/18/26 12:02, James Clark wrote:
> PTP_SYS_OFFSET_EXTENDED uses gettimex64 to bracket each PHC read with
> system clock reads. Some PHYs have a PTP hardware clock (PHC) that is
> read over MDIO and sometimes multiple MDIO transfers are needed to read
> the clock. This leads to brackets in the tens of microseconds.
> Applications that synchronize the system clock from the PHC typically
> use the midpoint of the bracket as the system time of the PHC reading.
> With multiple transfers, the midpoint of the bracket is typically far
> from the time when the PHC reading actually occurred.
> 
> For example, using PTP_SYS_OFFSET_EXTENDED on the Raspberry Pi CM5 to
> synchronize the system clock from the BCM54210PE PHY PHC leads to the
> system clock being 32 µs ahead of the PHC. On the CM4, it is about 7 µs.
> (The difference is because the MDIO clock frequency is higher on the
> CM4: 10 MHz as opposed to 2.08 MHz on the CM5.) The brackets are about
> 74 µs on the CM5 and 42 µs on the CM4. In comparison, the MAC PHC
> on the CM5 has brackets of about 1 µs.
> 
> This series introduces a new MDIO operation, write_sts, that allows a
> PHY driver to ask the MDIO bus driver for system timestamps bounding
> the completion of a clause 22 MDIO write transfer. A bus driver
> computes them by shifting the timestamps taken around the start of the
> transfer by bounds on its duration, worked out from the MDC period and
> the length of the frame. The series:
> 
> - adds a timekeeping function to scale a CLOCK_MONOTONIC_RAW duration
>    by a clock's frequency;
> - adds ptp helpers that use it to shift system timestamps;
> - adds the operation to the MDIO core;
> - makes bcm-phy-ptp use the operation for the write that triggers the
>    capture of the PHC time, allowing 350 ns for the PHY to capture it;
> - implements the operation for macb, with tighter bounds on RP1, where
>    its timing has been measured;
> - implements it for UniMAC, when the mdio node has a clock giving the
>    MDC reference rate. On BCM2711 that is the GISB clock, which Nicolai
>    Buchwitz is adding to clk-bcm2835 [1]. Until then BCM2711 does not
>    get write_sts, and nothing changes.
> 
> The effect of this series is to reduce PTP_SYS_OFFSET_EXTENDED brackets
> from 74 µs to about 1.5 µs on the CM5, and from 42 µs to about 1.0 µs
> on the CM4. The synchronization error drops from 32 µs to about 0.1 µs
> on the CM5, and from 7 µs to about 60 ns on the CM4.
> 
> There was an earlier proposal addressing a similar problem, in 2019, for
> the PHC of mv88e6xxx switches [2]. In the relevant respects the
> situation is the same as with the BCM PHY: the PHC is read over MDIO
> with several transfers, and one write fixes the moment at which the
> clock is sampled. Richard and Andrew suggested taking the system
> timestamps in the MDIO bus driver, around that write, and Hubert
> Feurstein posted a series implementing this [3][4][5].
> 
> Like Hubert's v2 and v3, this series shifts the timestamps to allow for
> the time the transfer takes. The discussion of that raised some points,
> which this series addresses. First, the meaning of the timestamps
> returned by the MDIO core operation is clear: they bound the end of the
> MDIO write transfer. Second, the bus driver uses a lower and an upper
> bound on the transfer time, including the preamble. The lower and upper
> timestamps taken around the start of the transfer are shifted
> separately, so that the returned bounds are guaranteed to contain the
> end of the transfer. Third, the PHY driver gives a bound on the delay
> between the end of the transfer and the PHY acting on the write, which
> the MDIO core adds to the upper timestamp.
> 
> This series also differs in having a write_sts operation, rather than an
> sts pointer in struct mii_bus. This allows the bus driver to compute the
> transfer time bounds at each call, from the same divider and clock rate
> that it uses to set the MDC speed. Unlike Andrew's suggestion, there is
> no fallback in the core, because a bus driver's write may return before
> the transfer has completed.
> 
> The earlier discussion also raised interrupts arriving between the
> timestamps and the write, and the latency of the posted write. In this
> series, the bus drivers take the timestamps with local interrupts
> disabled, and flush the posted write before taking the upper timestamp.
> 
> SPI introduced a similar facility to allow a device driver to obtain
> timestamp bounds from the bus controller in commit 79591b7db21d ("spi:
> Add a PTP system timestamp to the transfer structure").
> 
> This series implements the operation for only one PHY driver. But I
> surveyed other PHY drivers and identified at least two for which this
> operation could be implemented: micrel (specifically LAN8814) and
> dp83640, although they would need updating to use gettimex64 first.
> 
> The measurements come from the method described in patch 4/6, with
> ppsbias (https://github.com/jclark/ppsbias) timing the PPS on the GPIO.
> On the CM5 this is consistent with an independent check: with the MAC's
> PHC synchronized by PTP to an external grandmaster, and the system clock
> synchronized from it, the system clock and the PHY's PHC read with
> PTP_SYS_OFFSET_EXTENDED agree to within about 0.15 µs.
> 
> Changes in v2:
> - Improved measurement method (described in 4/6), which measures the
>    synchronization error more precisely
> - New timekeeping patch (1/6), so that the ptp helpers (2/6) scale the
>    shift by the selected clock's current frequency
> - Patches reordered: the ptp helpers (was 3/5) now come before the mdio
>    core (was 1/5), which uses them
> - mdio core (3/6): sts required, clause 22 stated, and frame-length
>    constants for the bus drivers (Andrew); an event delay added to the
>    upper bound; the wait and its 1 ms cap explained (Andrew)
> - bcm-phy-ptp (4/6): a 350 ns bound on the PHY's capture delay, found by
>    measurement
> - macb (5/6): wider bounds unless the MAC starts the frame with the
>    command write, as RP1 does; the MDC rate recorded when the divisor is
>    chosen (Théo)
> - UniMAC (6/6): the reference rate from a clock on the mdio node
>    (Florian, Nicolai); a suppressed preamble allowed (Andrew)
> - v1: https://lore.kernel.org/netdev/20261009143506.2507607-1-jjc@jclark.com/
> 
> [1] https://lore.kernel.org/netdev/41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de/
> [2] https://lore.kernel.org/all/20190805082642.12873-1-hubert.feurstein@vahle.at/
> [3] https://lore.kernel.org/r/20190816163157.25314-1-h.feurstein@gmail.com
> [4] https://lore.kernel.org/r/20190819172827.9550-1-hubert.feurstein@vahle.at
> [5] https://lore.kernel.org/r/20190820084833.6019-1-hubert.feurstein@vahle.at
We are wrapping-up the net-next PR for 7.4, and I would like an explicit
ack from subsystems and possibly from device maintainers, which are not coming
very soon.

Please repost after the merge window,

Thanks.

Paolo

