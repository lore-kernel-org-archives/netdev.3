Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB049436BC9;
	Wed, 12 Aug 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533530; cv=none; b=FnnWjsDQBtB+zUkSAhHKOyHWuP0hkbIjRCEp/a3hcOw1XMP+ViuTvcUjj99PSO3VHpVp0wYg2/VeExc4Y8yv1+UWwp8dccpzvKhrivhSXjb5adFBMvznu/96fRjRCsaiB6hvQXeU/XucA5cFXQhZ6NBwN+S4+yFLhY/xWg2w+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533530; c=relaxed/simple;
	bh=/qWUVu4Bp+xrCFfV5lDFh1FyW63H3CQSlJmq+9G4ii8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9qib8dtftm5054WxzWjeCCUKFm0umGsloDEHP+4MH+V/8W4kHVWPOK40m5zpgkZSvqdqM5SKx/Rv1XRmyv9CCRetm3tK4sP1H4bDvHgvzBFdic0lhSY4SlmC8Zw8E7GK74VauoqKwEnpdlq0w1rMEKqFTyYqwMowB5BVQThuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=JDcNvNeN; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="JDcNvNeN"
Received: from [172.16.124.192] (unknown [78.44.13.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id B3FA053405A5;
	Wed, 12 Aug 2026 13:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786533525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Ul2jKtraNQpi3ITKUkHD5JY/kubfNpWZjJBe/4vMH8=;
	b=JDcNvNeNjcGwm6QvtaPVxW0FoYSVQhl0jxg/ENc34e8Rzc3h915cGI2+KfzS+XWtOSk74W
	PkKsXvtITTEHponJW+2VTYbppgP7TX6wrZCIqRXhC7Qj/Nv714kU1ji2PXydoeSkd4A5us
	XMCdHIiRuC9GOaWmor3LLWoXw0Eu0x8=
Message-ID: <e9b0c679-6a50-48ba-8ce8-684bd4b5606b@ixit.cz>
Date: Wed, 12 Aug 2026 13:18:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nfc: s3fwrn5: support the S3NRN4V variant
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Bjorn Andersson <andersson@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
References: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net>
 <20260811220135.472380-6-jorijnvdgraaf@catcrafts.net>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260811220135.472380-6-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 00:01, Jorijn van der Graaf wrote:
> The S3NRN4V (e.g. on the Fairphone 6, SM7635) is a later part in the
> Samsung NFC controller line this driver covers. It needs different
> bring-up, selected with a new samsung,s3nrn4v compatible:
> 
>   - It ships with working firmware, and its bootloader reports a
>     hardware version this driver has no flash base address for, so the
>     firmware download step is skipped. Its RF calibration data is
>     loaded with the proprietary DUAL_OPTION command (the HW and SW
>     blobs merged into a single stream) instead of the
>     START/SET/STOP_RFREG sequence. The upload is version-gated on
>     DUAL_OPTION GET_VER, matching the vendor stack: GET_VER reports
>     the chip's current calibration versions, and the push is skipped
>     when both match the blobs (each blob carries its version in its
>     last 16 bytes). post_setup runs on every device-up, so the
>     gate is what keeps the chip's calibration store from being rewritten
>     each time NFC is enabled.
> 
>   - Its reference clock speed is configured with the single-byte FW_CFG
>     form, sent from the ->init hook, before CORE_RESET, in the same
>     order the vendor stack sends it. The vendor HAL uses the
>     single-byte form for this generation, and its vendor configuration
>     sets the selector to 0x11, which selects the 19.2 MHz reference.
>     Without this command the chip completes NCI initialization but
>     goes silent on RF_DISCOVER -- the command times out unanswered and
>     polling never starts (verified on hardware).
> 
> The calibration data is requested from a chip-scoped directory,
> samsung/s3nrn4v/hwreg.bin and samsung/s3nrn4v/swreg.bin, rather than
> the flat sec_s3fwrn5_rfreg.bin name the older parts use.
> 
> The variant is carried as match data by both the OF and the I2C device
> id tables so the two match paths agree.
> 
> Existing S3FWRN5 / S3FWRN82 setups keep the firmware-download path and
> the legacy rfreg sequence, unchanged.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-fable-5
> Assisted-by: Claude:claude-opus-5

I was going to make a joke about over-assisted stuff with two-lines of 
Assisted-by before, but... :)

Here's my mental model:

  - It's good to know that you used an LLM (hence Assisted-by).
  - Someone may want to reproduce some generated code, so knowing which model was
    used is useful.
  - When you put THREE ;-) models there, I think it's getting a bit useless, as
    we don't know which part was generated or adjusted by which model. At this
    point, it feels somewhat pointless.

My recommendation would be to keep just one line for the model used for:

a) the majority of the changes
b) the last model used (at least for notable changes)
c) the most powerful model doing the generation and/or review

I personally don't mind either approach. There have been discussions about 
dropping Assisted-by completely, but so far it makes sense to me to keep it, 
just in moderation.

Also, the patchset is shaping up nicely! :)

Thank you for your work,
David

[...]
