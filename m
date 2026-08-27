Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1E41DE0D;
	Thu, 27 Aug 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825949; cv=none; b=ldRafrKg6YIrjnAPsxFWxt3GHyWOA/AW/u/2s5CqK7nB5FVoLX3C0ae1lc2hengyTIMCwW5dqyW+1eBzZkjBAlFpC/qku7Te5CVWDNDyQ6p7NMy8XJKTs3Gvpuvehf4nIVWt13Ds64utUUX0uxNjBeguS6JKVxDnulTJiM4VJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825949; c=relaxed/simple;
	bh=b23i4JInd3NgcZWX9YdVLFKS7PQlXWm71AW8ccT03TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiF2UoYJbHvFTqbAfVOOoOl1SnwV87apZ3DEXapdC8ATyYmTMsYR8yhD7hWnxIQRbTPkYCKKSysI1IMXsifp1vk176UYG+ZVQMbeVCySiVjA0DoXfx75sFtRFdw0xsexL7Ug8AisJHIRinhzquxMAq7XiMLLHXE22L3RrYzgkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkihwFH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkihwFH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC191F000E9;
	Thu, 27 Aug 2026 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787825940;
	bh=RHMZgXDnYG9+lZOZk7gZyNeyINoTKCnT+RWVcPW3E2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YkihwFH05IT2kv8KS9WydsuiR5v6RuRMQycw+UZd/Fm9gRfdkJWCg56rq+ly1ZHYr
	 9s+uB0gt+Bh0npVqQkigGuNnAKt2wg9RMtxad8uHSfCxjqK2/bSG53Bvk2D4JDujJT
	 qiYuI1H88tZ9Rd44eIipgxuIBd17/ECwPOf9PiPqRhFls4XV4sicluvPGhfGx6Ks5D
	 ETonwaBVjOk9stp2x15FlD2QMXoZUNQ2Otn8yCrFU8YOGZKDyNJ10d29LxB37/GT3c
	 l6L1PK+BDHvNkaYCEN92lUNNm8ozmr7eagAsLRB6EEp8dHy+aaf3Kvt2SCByF9Sr+J
	 +xhIex1n3wIrg==
Date: Thu, 27 Aug 2026 12:18:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nfc: st-nci: add raw NCI path for ST21NFCD
Message-ID: <20260827-garrulous-iguana-of-dignity-355fc7@quoll>
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
 <20260820-fp5-st21nfcd-v3-v3-2-5ee0a7f44d04@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820-fp5-st21nfcd-v3-v3-2-5ee0a7f44d04@proton.me>

On Thu, Aug 20, 2026 at 08:56:10PM +0000, Kristian Brox wrote:
>  static const struct i2c_device_id st_nci_i2c_id_table[] = {
> -	{ .name = ST_NCI_DRIVER_NAME },
> -	{ }
> +	{ ST_NCI_DRIVER_NAME },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, st_nci_i2c_id_table);
>  
> -static const struct acpi_device_id st_nci_i2c_acpi_match[] = {
> -	{ .id = "SMO2101" },
> -	{ .id = "SMO2102" },
> -	{ }
> +static const struct acpi_device_id st_nci_i2c_acpi_match[] __maybe_unused = {
> +	{"SMO2101"},
> +	{"SMO2102"},

Odd. Previous code was correct, this is not.

What are you doing here?

> +	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
>  
> -static const struct of_device_id of_st_nci_i2c_match[] = {
> -	{ .compatible = "st,st21nfcb-i2c" },
> -	{ .compatible = "st,st21nfcb_i2c" },
> -	{ .compatible = "st,st21nfcc-i2c" },
> -	{ }
> +static const struct of_device_id of_st_nci_i2c_match[] __maybe_unused = {
> +	{ .compatible = "st,st21nfcb-i2c", },
> +	{ .compatible = "st,st21nfcb_i2c", },

Why do you change the order of these entries?

> +	{ .compatible = "st,st21nfcc-i2c", },
> +	{ .compatible = "st,st21nfcd",
> +	  .data = (void *)ST_NCI_I2C_PROTO_RAW_NCI },
> +	{}

Best regards,
Krzysztof

