Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6983AE1A0;
	Fri, 16 Oct 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193832; cv=none; b=fTKM4hub43aTIUxcNMBWJZAOP2AVX5c7ry4gVyY29lC/UzubnuZ2gQaJn+03QXeBtafl4faXiFaEzvAtng3WXdHZ2v4LbkfvJcYaaGPkPeVTBaMgEeHcQHOKKaPVO2pZXBCnnhLriH7LWjsdTzO7KKZiG4CggdvHuSzQaQJs5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193832; c=relaxed/simple;
	bh=h6tEoQaLTi+vKhbUM715c+hLbsGi6OgBFWS6x/3C8R4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZaexIzhLcT2S3DrwVEp6PM/0dt7bGhlXCfJThbRPGtrnVFLXj6+aTH2PHxYevpKyR60d5CCF4ogmgR64hS2FBcQ980lV7puA/kBAQzASs6FPevSRzAN7jfbTnVP/2tEkQlXq+D3qOHvkp37KY3Vm3zaRC/DuPyMRSOf+eOVFxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTmYIRN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTmYIRN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF301F000C4;
	Fri, 16 Oct 2026 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792193830;
	bh=43dmYeJ/z+ZxlGAmge5piW4Cp5LEqx3lnTOjZcqfDnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nTmYIRN4QNxbA3F470LzUbUhvzUkwGOw2235mQrsCYOqOPtJc4PF9rRHdFO7lIKxp
	 eG+GwMr5zt32zIMJNboTIR+ysq9AXOC4c4Ice9fsdvr+8mZse44UWuY/Qh1+4W8DKE
	 WZoKr9B4NydAfnHF3eVC5HXgveDBJS7LBeO0qhnGZsiEYdx2C6ddkAPGukp5+dFLih
	 EbIdiDlqJBljTpnMjh78LQIEwrFRHrNRkJszxoChmXqK2T+898EiYUeNFx84F5yTYq
	 2ax24A07eEMvGbQFVjtwHykeLzcj9efN2SO0GDyiigog0ddHIlBformmepc2SfR5tI
	 iX78LGI+5JP1A==
Date: Fri, 16 Oct 2026 16:37:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 3/6] net: pcs: xpcs: add Rockchip RK3568
 platform glue driver
Message-ID: <20261016163709.00cc7c12@kernel.org>
In-Reply-To: <20261008175225.3375274-4-coiaprant@gmail.com>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
	<20261008175225.3375274-4-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 01:51:57 +0800 Coia Prant wrote:
> +config PCS_XPCS_PLATFORM
> +	tristate "Generic XPCS controller support"
> +	default PCS_XPCS

Why the default? Surely there are platforms with PCS_XPCS enabled
which work today == don't care about the new code?

Linus is known to hate _any_ new symbols defaulting to enabled
on olddefconfig.

> +	help
> +	  Generic DWXPCS driver for platforms that don't require any
> +	  platform specific code to function or is using platform
> +	  data for setup.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +config PCS_XPCS_ROCKCHIP
> +	tristate "Rockchip XPCS controller support"
> +	default ARCH_ROCKCHIP

Same here.

> +	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  Support for XPCS controller on Rockchip RK356x SoC.
> +
> +	  If you have a Rockchip SoC with this interface, say Y or M here.
-- 
pw-bot: cr
