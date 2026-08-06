Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA61A680B;
	Thu,  6 Aug 2026 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000933; cv=none; b=YEcAeLWGSZUeJzG20yAPtahvtOxmYDMGKMNClbqGiWbLLPnR8A0m0Z08fn9U7dFIN0giwPkgwI7s1SKoXVA0yHqmulBa/yZATmgAFA3LfJ5qV+k568C6Gce9fAqbesTVZxvFyGDT6LnFE2xnaBM3PNbngyi5rsZ4EB/xINwmtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000933; c=relaxed/simple;
	bh=5wHqZ7ljqrIUBlZxpUNlub2FOLpW0rJ5bkBqJSvoKNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzw2Nu2Evh/Lup4fYL2yHWHsPn6cABDECuHj0F37QeAeZ2Jw7sxzpB4BGDkECCQ+lXP3eiOoHKnYtPAFiRpHDTcFoHZcMoKaam6ssGmu/g6YBhElkZgqxgl/CBopA/g50/4HbmT30L17usMoeuR/7vsuxvuKRLmqjCQamUt5F/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBfsMs4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBfsMs4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31801F000E9;
	Thu,  6 Aug 2026 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786000931;
	bh=1Q3INv6xfDxzZrTqbzjcHEhGswuBK+llXThgQbDfu2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jBfsMs4b2u6YbDN4jD0UjuLe2iw8ro9plUDcXgmrVXDLBO4ZijnOT8sTfuc97RdSN
	 TZ2l/GNR10Spsj5gRMgQNGk2/sgIFqjxbYJl7zSUrr9202rabWVmp+AqWKepGaD8XJ
	 XnPSqBIz/+CKXnlmsAVX0HsZzSCrn7ZxylhCWSDAph0WeFMcTj6ddT4PcPi2Xsh0o3
	 EBZ+p6UXY3udNAsMEMeXR0Gv0wdciQPhtmC84x1kDWMv5vf5pZP4LElFGTP/vy/T2S
	 WeeOD7s5PRT8baYjobe1O6iRD8+p5oUgQQ+roJHObqfuMaC3BJbdEC7W0tYhiTdnYe
	 dMu+Tzj++V3ZQ==
Date: Thu, 6 Aug 2026 09:22:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/3] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
Message-ID: <20260806-witty-apricot-condor-efe3ac@quoll>
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
 <20260805085540.452260-3-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805085540.452260-3-a.shimko.dev@gmail.com>

On Wed, Aug 05, 2026 at 11:55:39AM +0300, Artem Shimko wrote:
> Add device tree binding documentation for the DAPU Telecom DAP8211R(I)
> Gigabit Ethernet PHY.
> 
> The PHY supports TX and RX clock delays in 150 ps steps from 0 to 2250 ps,
> with a default of 1950 ps if not specified.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  .../bindings/net/dptel,dap8211r.yaml          | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dptel,dap8211r.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

