Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2333F5A7;
	Sun, 23 Aug 2026 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787473941; cv=none; b=Alp+47qVu+QGZNpEhqyHgDnim64CJNCkITSuaey4HtnK5Arru6RMLzs/Nw9421VAXVeMcrwEUEnLXB5g0s/VQqoUJL2A0zLKUA5V8NMvo7DFkGp96LSu0YOxEWiLHRrNJrjx1JZIJHYtAf5SFGW5xVIqnckgKqOE+R8dM6GIzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787473941; c=relaxed/simple;
	bh=6nN7F+g2bvyuvSxs2ZDjHWjbfEgXT41SOL/yingCANs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKMcIys1S6YHXCX2CuNSlDV0X6QcLxG/Td11HCeKAtcm0+1JdhzkXEkwi6eNwOnUSy/mcbigJFImfCIm3nm8t56kDPlbBVRlnvt6ytRKr84G0Fca2EvM07naIaCpQSiOYZsnhUaonznC+XQsctPUAi/VrWxDtUvdNvmqEO7u/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=h1SQjeJn; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="h1SQjeJn"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 4334953402C6;
	Sun, 23 Aug 2026 10:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1787473930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2JlsbcyZwzKezXPdK2tC1+1lCw/bBm3L87lBJldaxnQ=;
	b=h1SQjeJnHt5llfVWVCbl4rChd3b8QAdayAQdsGsw6WVrtr4ei3eHES3MY98ChGZrh2ITif
	Z9/Z/s9PAasw3yVI1XzE6ojeKvak9j3KdLE1/bFdaZ8vvJp1WtO3IHe0Brb37KnKBxAZGk
	bGD3Sjlt7wuc9P7+isUT0n/ftJ7KFpg=
Message-ID: <4816df55-c486-408b-8aae-80cef532d327@ixit.cz>
Date: Sun, 23 Aug 2026 10:32:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nfc: st-nci: add raw NCI path for ST21NFCD
To: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
 <20260820-fp5-st21nfcd-v3-v3-2-5ee0a7f44d04@proton.me>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260820-fp5-st21nfcd-v3-v3-2-5ee0a7f44d04@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 22:56, Kristian Brox wrote:
> ST21NFCD does not use NDLC. When the compatible is st,st21nfcd,
> talk raw NCI:
> 
> - do not add or strip an NDLC PCB
> - do not run the T1/T2 ACK timers
> - I2C reads are a 3-byte NCI header plus payload
> - skip proprietary SET_NFC_MODE and HCI SE discovery
> 
> Optionally enable clocks (SYS_CLK) and vdd-io (VPS_IO) when the
> DT describes them. Existing st21nfcb / st21nfcc boards keep the
> NDLC path and do not need those properties.
> 
> Tested on Fairphone 5: adapter powers up and reads an NTAG 215.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
>   drivers/nfc/st-nci/core.c |  5 +++
>   drivers/nfc/st-nci/i2c.c  | 87 ++++++++++++++++++++++++++++++++++++++++-------
>   drivers/nfc/st-nci/ndlc.c | 23 +++++++++----
>   drivers/nfc/st-nci/ndlc.h |  2 ++
>   drivers/nfc/st-nci/se.c   |  3 ++
>   5 files changed, 102 insertions(+), 18 deletions(-)
> 

Hello Kristian,

getting better, but still few nitpicls

1. Always To / Cc maintainer :)
2. read the Sashiko review, there is one issue pointed out

see below,

[...]
> @@ -257,23 +318,25 @@ static void st_nci_i2c_remove(struct i2c_client *client)
>   }
>   
>   static const struct i2c_device_id st_nci_i2c_id_table[] = {
> -	{ .name = ST_NCI_DRIVER_NAME },
> -	{ }
> +	{ ST_NCI_DRIVER_NAME },
> +	{}

I believe you reverting recent changes, same below.

>   };
>   MODULE_DEVICE_TABLE(i2c, st_nci_i2c_id_table);
>   
> -static const struct acpi_device_id st_nci_i2c_acpi_match[] = {
> -	{ .id = "SMO2101" },
> -	{ .id = "SMO2102" },
> -	{ }
> +static const struct acpi_device_id st_nci_i2c_acpi_match[] __maybe_unused = {
> +	{"SMO2101"},
> +	{"SMO2102"},
> +	{}
>   };
>   MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
>   
> -static const struct of_device_id of_st_nci_i2c_match[] = {
> -	{ .compatible = "st,st21nfcb-i2c" },
> -	{ .compatible = "st,st21nfcb_i2c" },
> -	{ .compatible = "st,st21nfcc-i2c" },
> -	{ }
> +static const struct of_device_id of_st_nci_i2c_match[] __maybe_unused = {
> +	{ .compatible = "st,st21nfcb-i2c", },
> +	{ .compatible = "st,st21nfcb_i2c", },
> +	{ .compatible = "st,st21nfcc-i2c", },

The `,` above was removed recently, keep it that way ;-)

> +	{ .compatible = "st,st21nfcd",
> +	  .data = (void *)ST_NCI_I2C_PROTO_RAW_NCI },
> +	{}
>   };
>   MODULE_DEVICE_TABLE(of, of_st_nci_i2c_match);
>   
[...]
