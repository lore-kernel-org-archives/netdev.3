Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9A35E1AA;
	Fri,  9 Oct 2026 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586941; cv=none; b=c9FcLltGfWrpOC9mksGpfWdYrJf5xVaZoLn3EXsk92s0oZJs+FH0b4MXNL5iKLP75SAP/xG3BF2+YNX7s3oQF7zMRpkBMLDCKy6u38QqCo729I811094vdDdEbNHkR3/bkqZLOBlecV4brQA6HrdFg1ZY/xG6tZCMBZNjO5Q0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586941; c=relaxed/simple;
	bh=WFbgsXq9x5wQl6fZmgFSgE0d1Fm4i8XPFbd7Mig7AU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjwgAQl7WrQROlAHNuM4M25SG01uoV2LazyopUuq+HBNzzms0GG5GK7I2wNLy9Uzob+cfCxLPMaPIx2F6P4n8cZpQUcrlWb+DDG+ZLe3uki1/jJupAYhFCwNvPlrhzeSg/zy7VfE++kKgm84v9b3laUCcR1PG5Jo7zkyTmqRXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M/M2RrrN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/M2RrrN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1ZIyz1/OPj/Af2dLzTUaE10fWPUAL1OAIW2ByRolxEU=; b=M/M2RrrNvH1etedYXYR9wGmAtn
	Pf6JPKhphvDIpBfHJuR33YHRYFvMkwuotmu7rZ9EJFsZ0bLYZyXvKBZ+hAgsNeWr0T1cNnDussnKU
	SrL81owTsYR9jAKxCHemaooWhBmlptqpAu9LMzT9S90o18mUTNvmpPB9XROJJSeLhdRic9I7HZNVp
	0Ty2oK1U087XXykX49ThZY9Z9Wz6Z+QLSTfI0qIA9jQojaQbfv537O+mdoq7GDNJzIOOuD+bfUu1o
	WT88UBUgEedvFOBorL1Iyx/K5T5Dwly/CvJjGZugfP4nPLgajVWJR+FxsbqqROZcDLKEd8b5XWRD6
	3bqy1pAw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFJbP-00000007JyH-2CFW;
	Fri, 09 Oct 2026 23:02:11 +0000
Message-ID: <d6e094cd-3341-498e-9591-3544908db069@infradead.org>
Date: Fri, 9 Oct 2026 16:02:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 08/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
To: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jerry Ray <jerry.ray@microchip.com>, Ciprian Regus <ciprian.regus@analog.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
 <20261009-s2500-mac-phy-support-v9-8-dcefe1d0bf0d@onsemi.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-8-dcefe1d0bf0d@onsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 10:12 AM, Selvamani Rajagopal via B4 Relay wrote:
> diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
> new file mode 100644
> index 000000000000..abd967448af0
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# onsemi S2500 Driver Support
> +#
> +
> +config S2500_MACPHY
> +	tristate "S2500 support"
> +	depends on SPI
> +	depends on PTP_1588_CLOCK_OPTIONAL
> +	imply NET_SELFTESTS
> +	select BITREVERSE
> +	select NCN26000_PHY
> +	select OA_TC6
> +	help
> +	  Support for the onsemi S2500 MACPHY Ethernet chip.
> +	  It works under the framework that conform to OPEN Alliance

	                                    conforms

> +	  10BASE-T1x Serial Interface specification.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called s2500.

-- 
~Randy

