Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32C4BB298;
	Sat, 10 Oct 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661217; cv=none; b=UbCi6mysyPJUA913X/JANpd7pt1B5RjHO+UMX1+s8Z7Tlt8TUgb9jm7COONNpsy6kx/TNjbCxFd7pHce0iOYB3/WKiUEFWux4caoGhZRMIzEkoNBZX/aD8dvU2+M7JQuz8LKMxA52TrdYeS6y46dlaop9uHpVzChrxu9WREaqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661217; c=relaxed/simple;
	bh=I4ATVEh7unBIA3iDv8TcKZgRPvpPi6uCNiKW67MdfT0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGbGaGh0UZgEO9BYhETqu2oaceWRYuFWp/6HDxk2uCGaUKjnJ9rF3BQcfaZfeXyEwDuh2HzT01CPPEhrTgbbRNYcHiDbndG4ZPQb/6obtPjFQ5lzkYAoFLWogW4dGOkT+beL2NqiDoiq5/AujQ+Ia0bCY8DkTtz/oBRSw6/x3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqLTWGBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqLTWGBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C711F000FF;
	Sat, 10 Oct 2026 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661211;
	bh=0r5UUjFumMsYCBi2YuyR6SkyRNOKpNF/2rDGULVRSvs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KqLTWGBHjpHCy0PDCpj4fxfdmps3xnzV5PPQAMbd6mRwLEETFc/ZRWuN//Woq49Ea
	 MBxJ1tc8N9aeNqZS/exoExTdluU+qt6RgM2iqjWXthkOMujJAuC7O1OSKWuLhP4thx
	 rxYFfHxN5P6zghGDpJt44jNZIeRyePlmJq3Gqla69Sob1n9PwAD5QQ5QlXt+9TFzMB
	 MIXATpM08uASh7Nf5zkon8Vx67UU+tVzNJhDobWYT393vZf/tTIwdXJBK8rAsZt5XY
	 58NCsIQITu6FzbjtBRi5GPp90EtLaPruoopUpBoArZkEAi4u0y8tjNMJ+WEd0ZLc3P
	 PODz/aG/eEDDA==
Subject: Re: [PATCH net-next v9 02/11] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:09 +0000
Message-ID: <179166120913.434549.12298856160000074889@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-2-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-2-dcefe1d0bf0d@onsemi.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline decision: false positive, kept only because
  requires_validation=true.
- [Low] The new framework bullet in Documentation/networking/oa-
  tc6-framework.rst (lines 156-158) reads: 'If supported by the hardware…

--

Documentation: networking: Add timestamp related APIs to OA TC6 framework

This patch documents new OA TC6 framework APIs for hardware timestamping,
PTP clock registration and the VEND1 MMS mapping helper. It also documents
the existing MMS-based register read/write helpers. A new entry in the
framework feature list describes hardware timestamp updates in the skb.

> diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
> index 2545ef694016f..3cfe8cb7cf75f 100644
> --- a/Documentation/networking/oa-tc6-framework.rst
> +++ b/Documentation/networking/oa-tc6-framework.rst
> @@ -153,6 +153,10 @@ OPEN Alliance TC6 Framework
>  - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
>    subsystem.
>  
> +- If supported by the hardware and enabled, updates hardware timestamp
> +  in skb, when indicated by one of the three timestamp capture registers
> +  through TSC fields of the header.

[Severity: Low]
Does this bullet only describe the transmit side of timestamping?

This document defines TSC as a field of the transmit data header:

  TSC (Bit 7..6) - Timestamp Capture. Request a timestamp capture when the
                   frame is transmitted onto the network.

Receive timestamps use the RTSA/RTSP footer bits instead, and the timestamp
is added to the start of the frame:

  RTSA (Bit 7) - Receive Timestamp Added. This bit is set when a 32-bit or
                 64-bit timestamp has been added to the beginning of the
                 received Ethernet frame. ...

By the end of the series the framework handles both paths. On transmit it
sets the TSC field, reads the TTSCx capture registers and calls
skb_tstamp_tx(). On receive in oa_tc6.c it parses RTSA/RTSP and checks the
parity of the 64-bit timestamp at the start of the frame. It then stores
the timestamp in skb_hwtstamps(skb) and strips it with skb_pull().

This bullet comes right after the "Forwards the received Ethernet frame"
item and refers to updating the timestamp in the skb. Could a reader take
this to mean that receive timestamps come from the TSC capture registers?

Would it be clearer to have one entry for transmit (TSC and capture
registers) and another for receive (RTSA/RTSP)?

> +
>  Data Transaction
>  ~~~~~~~~~~~~~~~~
>  
> @@ -496,3 +500,58 @@ the MAC-PHY.
>  Zero align receive frame feature can be enabled to align all receive ethernet
>  frames data to start at the beginning of any receive data chunk payload with a
>  start word offset (SWO) of zero.
> +
> +.. c:function:: int oa_tc6_ptp_register(struct oa_tc6 *tc6, \
> +                                        struct ptp_clock_info *info);

[ ... ]

> +.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
> +
> +Helper to map MDIO_MMD_VEND1 command to vendor specific Memory Map Select
> +(MMS) value. This function offers flexibility for vendors that may have
> +used any MMS value between 10 and 15 as allowed by the specification.
> +MDIO_MMD_VEND2 is already mapped to MMS4 in the OA TC6 frame work code.

[Severity: Low]
This isn't a bug, but at this point in the series none of these APIs
exist yet: oa_tc6_ptp_register(), oa_tc6_ptp_unregister(),
oa_tc6_get_ts_info(), oa_tc6_hwtstamp_get(), oa_tc6_get_ts_stats(),
oa_tc6_hwtstamp_set() and oa_tc6_set_vend1_mms(). Also,
oa_tc6_get_phy_c45_mms() does not map MDIO_MMD_VEND1 yet.

All of them are added later in the series, in "net: ethernet: oa_tc6:
Support for hardware timestamp" and "net: ethernet: oa_tc6: Support for
vendor specific MMS". This only affects someone reading the docs partway
through the series.

Would it make sense to move this patch after those two, so the docs land
together with the code?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
