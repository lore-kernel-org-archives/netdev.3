Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC818BBAE;
	Mon,  8 Jun 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905157; cv=none; b=rHJTY8c04Vokt6RqxJleIezOm3c2XXg8BpdRcPTdqMaHG5ooB2ILsjxrPYICTKtF6IoeNdhr6nCflpJRfpDO/+T5xXCzdY5ipif4zS1aRb3t6AGiauGU0NwFCMjSkG1HxyBO1uWmVH/5gi+/Btgdb7VAZT2EGmrWiHxXzoEvRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905157; c=relaxed/simple;
	bh=YjGWb9LoE8hgeVijdthV3rreDApUGkXhWQjpjTSlqrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCvb1MHiDMGUVn+yCVQCFufUB3tnHCDwPmVnMrvRRT8jzBGXQBNFIsVk2K3iWD0gNSxSbDNBNgdIb4++KxDRlwuTy6Ah0M8V6y7ysjd5QObb79lglU8HK1W5l+COtiICJmvXSaLsYmHLCKFiitzhppmG1o4XSRN/FPXGQsCm8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBFZP43n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBFZP43n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05351F00893;
	Mon,  8 Jun 2026 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780905156;
	bh=0LSyYeJqo7Y0D30XLBtQ0E7nFVxQ40P8OawZYkz6wcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LBFZP43nsE4v1amubo8sboKkhhoQz8g/tDMj45JLDy7hibzw6WQ+EZaFuxkoT4rRC
	 FJeS95c8VbY0/ce8ugOJ0xngNrOrASHFNokYBykErwCRqijwDEsgV9UGbQRvee75Ur
	 n4O9RlCDJWI2PNinM75E/AwmH91K9vkq9gG2KnLP5YJ2+JSEW6k2oZ70m9+yt6sd+r
	 c97Hd3l2npSqaGm3JZ9kahIgokPwKBnDBo3l3f+ccqOkbIPAfztapwvNlr2xDg6gg0
	 0+USU8phLBQMi7Md4mwACCAK2f7t8jWkUyah1CcQMeJe8cBWr95Uz5Ir0FR55/wdj8
	 QUvq4tu8KjyEg==
Date: Mon, 8 Jun 2026 09:52:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v4 15/16] dt-bindings: net: add onsemi's S2500
Message-ID: <20260608-cornflower-chital-of-romance-7b1ab5@quoll>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-15-de0fbc13c6d8@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605-s2500-mac-phy-support-v4-15-de0fbc13c6d8@onsemi.com>

On Fri, Jun 05, 2026 at 10:42:46PM -0700, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg

s/YAML//

> compliant Ethernet transceiver device.
> 
> We use IRQF_TRIGGER_FALLING, though OPEN Alliance 10BASE-T1x
> Serial Interface specification calls for IRQF_TRIGGER_LOW.
> 
> This is to match IRQF_TRIGGER_FALLING used by OA TC6 framework code.
> This bug fix requires changes to the stable branch. At that time,
> this will be changed to IRQF_TRIGGER_LOW.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

