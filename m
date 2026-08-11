Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C137B027;
	Tue, 11 Aug 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466086; cv=none; b=QDuLT3A5+fapM74hVFFYlaAkMgXgm3POE/EOrAV4nPa7BHPNfaxWOVmNxoexE6rjC+nndYTd9vj5Yfn5PQJsvyG+E729SGBa1hFwkfFBlsZ3qQsvMNzY0K/kw1p6wGDh479EgrpxLYGaRm4G5mKD/S0dYjpc8hP9DZIuFpBE2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466086; c=relaxed/simple;
	bh=mwk0Q1YHxLPUcUJIqzhfld8QkNE1JrHIt1OuWed/7o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN7Hrczw1UYvkLiGBOZdpiLAOdMRSIWYd48r4qhu1mQvNPLb1zuYLVXql04E6gqMNbuxNKoQU/8rL/LsnQBAdb7suh87BlZDFKr/RkcsCY9bmcqWtc0F20vUKwNiv1csQJkONWleMxCRen3ypUYG9y7NbIBMpbXlGqdkYoVUbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pjGyMv+G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjGyMv+G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sqJsmzAvVdU+ObHxFGWkb7BkBsjzmkEndCdAUVN7nmI=; b=pjGyMv+GQ/jNx7SYBO1BZXVsNX
	o3cLZ9hwdr849cjKnC1Ge3Yxud90YYp0kSdWXnvTT9fTfCg2vUbxdNMv7Rx8sLs0Tto1RG1kH7hGb
	gkkSyNja4JMmOmRd6f88TAZ3PrEjUsVFvruYysHlnFEQp5hYfkm7VuzoL8luorpgxKp3cHSaXlMpR
	ImaZtal4L/M2KKqimq/QcdUBGKFQJHiaolIHcY5sZgy37qdg/DQtS+ZWfm893kkKYoL0uRf6HGJro
	j+Goc78aDcZrJpinE+6CgSJYsGJGeCRPD5NsirPG1UIbcHysR8tcOJKmwPI6Bi54kF2TWr6w41jC9
	yqRaUdig==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpQz-0000000EVvT-2T3l;
	Tue, 11 Aug 2026 16:34:37 +0000
Message-ID: <eeb5c44a-6cfa-479f-bbb5-f557470258a8@infradead.org>
Date: Tue, 11 Aug 2026 09:34:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 03/12] net: pcs: implement Firmware node
 support for PCS driver
To: Christian Marangi <ansuelsmth@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
Cc: Daniel Golle <daniel@makrotopia.org>
References: <20260811092843.673837-1-ansuelsmth@gmail.com>
 <20260811092843.673837-4-ansuelsmth@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260811092843.673837-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/26 2:28 AM, Christian Marangi wrote:
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index e417fd66f660..f5c9ca2e992b 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -5,6 +5,12 @@
>  
>  menu "PCS device drivers"
>  
> +config FWNODE_PCS
> +	bool "PCS Firmware Node"
> +	depends on ACPI || OF || COMPILE_TEST
> +	help
> +		Firmware node PCS accessors

That indentation for the help text is incorrect.
Should be just one tab + 2 spaces.

-- 
~Randy

