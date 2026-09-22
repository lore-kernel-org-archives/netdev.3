Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277647ECC6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105799; cv=none; b=NO7BuMg+7vvCcmHBxCdStA3suGUSwZ+wJAHhLuQROfksAMLQQSRZGox3F5fQOkE+8WMwpO/e6/avbW1//Y8p0KgTQCPpd/HGtjTXq5iOYcal1qGEJ7QA3HEg8GO/L6SHM/BfNnb7dQnMnY6fZAKYzlnwKI1R48wGlMyIuPy3ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105799; c=relaxed/simple;
	bh=xzAgobl65Wk/Ljhu+DSG1Y5eezIk4U/GDS86YOO7i7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=dqzDFcsaaw2FnMy9CxQNQNatAUNMzDQhlV5d5ojWEJWKTmGTRB99yDjiYZDPWnFk2PBLaFB26JLZ8eprXsBm/Y9Zesi3mgy7z0DMpEq4UlCEnsMP+N7n3ZOk4LlzOL2KSuIPoOWPppWUNws/V9V9izXjzTnsd+6J2aZn/jEKjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A50SedNY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A50SedNY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BB8C9C21A8A;
	Tue, 22 Sep 2026 19:37:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0553F60580;
	Tue, 22 Sep 2026 19:36:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EAED103293A5;
	Tue, 22 Sep 2026 21:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790105789; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2m6qgchu9EBAEhRvV8evuKScGQzkDX7unQPuIGUPnSo=;
	b=A50SedNYRBpodQBpHJQzgMfis9JpmoRxgi4fme8COjpTDN70U7kvC2Ul/FjYXFLl0czBZG
	nhWHfwLD0PzWiccFFSVg4xTp+oniHZYb6BEV1II9/exIOIXLBj9UHHcLIlMfMbtMOkyBf9
	usaEEQl5mFDtrprqq/XY64Sx6ghffFekDLtPdWI6O4L+iXZ8eeQegCMpF0pjwKhRdmQTNK
	uCzjeUjeV9VWwbpz+2NjwvHWbHCYKyFHvvUlg0RnW92Vzzxc6EeiWjrM1pD3VSp1MV8H45
	uZPOx//CsESRH8Mo0kySGTPZ/HDi5dVDRUvHD8Orwt7dMq3kuSaSBoKZcx3r8Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 21:36:24 +0200
Message-Id: <DLM3JGMU0268.2JFQBB70QLPXA@bootlin.com>
To: <5mghybrid@khu.ac.kr>, <netdev@vger.kernel.org>, "Rafal Ozieblo"
 <rafalo@cadence.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/4] net: macb: Preserve timestamp settings on
 rejected requests
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr> <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr> <DLM2SWGU9QV6.3H7Q7U7MLE786@bootlin.com>
In-Reply-To: <DLM2SWGU9QV6.3H7Q7U7MLE786@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Th=C3=A9o,

On Tue Sep 22, 2026 at 9:01 PM CEST, Th=C3=A9o Lebrun wrote:
> Hello Kim,
>
> On Tue Sep 22, 2026 at 11:10 AM CEST, Kim Wooseok via B4 Relay wrote:
>> From: Kim Wooseok <5mghybrid@khu.ac.kr>
>>
>> gem_set_hwtst() can reject a request after changing the TX one-step
>> setting, because it programs the TX mode before checking the RX
>> filter. The call returns -ERANGE, but the hardware may no longer match
>> the cached configuration.
>>
>> Validate both settings first and keep the adjusted RX filter local
>> until validation succeeds. Then apply the register settings and update
>> the configuration. A rejected request now leaves the hardware, the
>> caller's settings and the cached configuration unchanged.
>>
>> Protect the NCR read-modify-write with bp->lock, keeping the descriptor
>> writes and cache update in the same section. With the register writes
>> now in the setter, remove gem_ptp_set_one_step_sync() and
>> gem_ptp_set_ts_mode().
>>
>> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
>> Assisted-by: GPT-6 Astra
>> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
>> ---
> [...]
>>  int gem_set_hwtst(struct net_device *netdev,
>>  		  struct kernel_hwtstamp_config *tstamp_config,
>>  		  struct netlink_ext_ack *extack)
>>  {
>> +	u32 ncr_mask =3D 0;
>>  	enum macb_bd_control tx_bd_control =3D TSTAMP_DISABLED;
>>  	enum macb_bd_control rx_bd_control =3D TSTAMP_DISABLED;
>> +	int rx_filter =3D tstamp_config->rx_filter;
>>  	struct macb *bp =3D netdev_priv(netdev);
>> +	unsigned long flags;
>> +	u32 ncr_bits =3D 0;
>>  	u32 regval;
>
> Same remark as Nicolai (no surprise there). With that
>
> Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Sorry for the two stage review, I had forgotten that aspect on first
review. I would prefer simpler code:

> @@ -424,18 +406,17 @@ int gem_set_hwtst(struct net_device *netdev,
>     case HWTSTAMP_TX_OFF:
>        break;
>     case HWTSTAMP_TX_ONESTEP_SYNC:
> -      gem_ptp_set_one_step_sync(bp, 1);
> -      tx_bd_control =3D TSTAMP_ALL_FRAMES;
> -      break;
> +      ncr_bits |=3D MACB_BIT(OSSMODE);
> +      fallthrough;
>     case HWTSTAMP_TX_ON:
> -      gem_ptp_set_one_step_sync(bp, 0);
> +      ncr_mask |=3D MACB_BIT(OSSMODE);
>        tx_bd_control =3D TSTAMP_ALL_FRAMES;
>        break;
>     default:
>        return -ERANGE;
>     }

Let's avoid the fallthrough. Simple & easy to read:

	case HWTSTAMP_TX_ONESTEP_SYNC:
		ncr_bits |=3D MACB_BIT(OSSMODE);
		ncr_mask |=3D MACB_BIT(OSSMODE);
		tx_bd_control =3D TSTAMP_ALL_FRAMES;
		break;
	case HWTSTAMP_TX_ON:
		ncr_mask |=3D MACB_BIT(OSSMODE);
		tx_bd_control =3D TSTAMP_ALL_FRAMES;
		break;

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

