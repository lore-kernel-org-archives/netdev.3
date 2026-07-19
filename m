Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3D1F427C;
	Sun, 19 Jul 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473025; cv=none; b=fY+cPRa8CXv4JQloGvVNAKTm9F/kuJEnyGdMsGoxr0KQG7YbrNfmxsE7tKhpJ6YvsKY1nVE301BfAATSATmYuV1L/W+7YjTRyJdEE+ioffqWSsHDGoIEAimpc0URmx/UQa3+VI6Mur9Y0dDKJAiAtU4J7DEkn3QKCH9fOtR+uQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473025; c=relaxed/simple;
	bh=BSdDS4BnSaYiaQdJzgd9ND2JV8p15NZceDEXtTuXyhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1ZvGoaTfFiH+ohI1Hv0dTtSsv3p3ylXqztLwvLS4g5LGFnAJCJK6CZEMzCCdXUZxdEUDr75c4rFr1K8IpvVEDLYpDmrrqiR1jKWIdxfNVuiA3FGJ9rBgwsFBAQLyHkDpDli89umySiN0Muy1H384q+6ehQUm28W8nUpPNqcX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=sw+yYzDV; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="sw+yYzDV"
Received: from [192.168.1.182] (ip-62-24-73-79.bb.vodafone.cz [62.24.73.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 2B1205340249;
	Sun, 19 Jul 2026 16:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1784473019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DhVOLA73dceqAtcrXFLpeM378Jlk+ATnXoEMgNymJao=;
	b=sw+yYzDVcpen4eUfXBPZkscwBkHqP9tgRa0GIune6BKiEtmqCZ8fgAujbuUV3b3WGtvwQK
	0e/wSMQieDHC3xLxNse7GRzIJeafKmyf1kAvlmVJVCoz0UcW1BGFdWID7m+AY+VXP1gu4C
	FsO9y0PSAb7je4X7nwoSvkJH2krWzYU=
Message-ID: <5d26f3ae-1287-4440-bd38-96c9900f16ea@ixit.cz>
Date: Sun, 19 Jul 2026 16:56:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] nfc: s3fwrn5: support the S3NRN4V variant
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
 Luca Weiss <luca.weiss@fairphone.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
 <20260705190621.128257-3-jorijnvdgraaf@catcrafts.net>
 <18c3e13f-88e4-458e-9f57-7aceeb1ce1d1@ixit.cz>
 <20260719142241.12640-1-jorijnvdgraaf@catcrafts.net>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260719142241.12640-1-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:22, Jorijn van der Graaf wrote:
> Hello David,
> 
> Thank you for the review!
> 
> On 19/07/2026 15:15, David Heidelberg wrote:
>> Please, send the "drop the of_match_ptr()/__maybe_unused annotations
>> from it." type of change as part of the series, but as a separate
>> commit before the new HW support introduction.
> 
> Will do in v3.
> 
>> Since you touch S3FWRN5_I2C_DRIVER_NAME, replace define
>> S3FWRN5_I2C_DRIVER_NAME occurenced with the "s3fwrn5_i2c" directly
>> before introducing the support (also separate commit)
> 
> Will do, also in v3.
> 
>> is S3NRN4V really a variant of S3FWRN5 or is it just S3NRN4V?
> 
> It is a separate, later part, but from the same Samsung S.LSI NFC
> controller line this driver covers. Samsung's downstream stack drives
> that whole line with one kernel driver and one HAL: the HAL's product
> table lists the N5 (S3FWRN5) and N82 (S3FWRN82) generations next to
> RN4V (S3NRN4V) and others, dispatching on a product code reported by
> the chip's bootloader, and the parts share the I2C framing, the
> power-control GPIO scheme and the proprietary-NCI style of
> configuration. The generational differences (bootloader protocol,
> RF-register transport command, FW_CFG payload form) are exactly what
> this patch dispatches on -- the same way the driver already supports
> the S3FWRN82 next to the S3FWRN5.
> 
> That said, "S3FWRN5-family" can indeed be read as "a variant of the
> S3FWRN5 chip", which it is not, so I'll reword it in v3 to something
> like "a later part of the same Samsung NFC controller line". The
> phrase also sits in the commit message of the already-acked binding
> patch; I'll tweak it there too (commit message only) and note it in
> the changelog.
> 
>> While it's "register update" and function is named "configure_dual",
>> it's loading firmware.
>>
>> If it's not a firmware, but only configuration, it can reside inside
>> the driver, maybe LLM even be able to decode to understandable
>> sequence of registers and values.
> 
> There are two separate things here: the chip's executable firmware
> (~180 KiB) ships in its flash and is not touched by this patch at all
> -- its download protocol is not implemented, which is why the
> download step is skipped. What is loaded here are only the two RF
> register tables (~3.5 KiB combined).
> 
> Those tables are configuration by nature, but I don't think they can
> reside in the driver:
> 
> - They are board-specific analog/RF tuning, not chip constants: the
>    values match a particular antenna/matching-network design, and the
>    vendor revises them across software releases (my two Fairphone 6
>    units shipped different builds of these files, with different
>    version stamps embedded). A different S3NRN4V board design would be
>    expected to ship its own tables. Per-device data loaded at runtime
>    is what request_firmware() is there for, much like Wi-Fi
>    board/calibration files. The tables ship in the device's vendor
>    image, which is where I extracted them from.
> 
> - There is nothing to decode them against. The register map of these
>    controllers is not publicly documented, and even Samsung's own
>    (Apache-licensed) HAL treats the register content as opaque: the
>    only part of the image it interprets is a 16-byte metadata trailer
>    at its end (version stamps, used to decide whether an update is
>    needed at all, plus a region code), while the register content
>    itself is pushed to the chip untouched, in 252-byte sections.
>    Nothing in the stream or in the vendor stack identifies
>    address/value pairs one could transcribe, so "decoded" into the
>    driver this could only become a 3.5 KiB hex array in C, and we
>    would lose the ability to ship a newer table without rebuilding
>    the kernel.
> 
> - It also mirrors what this driver already does for the parts it
>    supports: s3fwrn5_nci_rf_configure() loads the same class of table
>    (sec_s3fwrn5_rfreg.bin) with request_firmware() and pushes it via
>    the older START/SET/STOP_RFREG commands. The new function is the
>    same operation over the newer parts' transport command.
> 
> If the naming reads confusingly I'm happy to rename the function or
> extend its comment to spell out the firmware-vs-register-table
> distinction.

Thanks,

now it makes more sense to me, feel free to name it as calibration data.

I would suggest to introduce something as a calibration-variant (see ath10k code).

If I understand right, firmware location path could look like

default path + driver vendor and model + device vendor and model + revision

/lib/firmware/ + Samsung/s3nrn4v/ + Fairphone/FP5/hwrevision.bin

/cc Luca here, as he may know more about the different configuration data shipped.

We should assume the configuration will be shipped with linux-firmware at some 
point.

David

> 
>> For next revision of the patch, I'll likely still have some
>> additional feedback.
> 
> Understood -- I'll send the v3 with all of the above shortly.
> 
>> With next revision send also as last patch the device-tree entry for
>> the Fairphone 6, so we can also get additional testing from
>> developers/users.
> 
> Will do -- v3 will carry the Fairphone 6 DT patch at the end of the
> series, marked as included for testing and presumably to be picked up
> via the Qualcomm DT tree once the driver side is settled; I'll Cc
> linux-arm-msm and the qcom maintainers on that patch.
> 
> Thanks again,
> Jorijn

-- 
David Heidelberg

