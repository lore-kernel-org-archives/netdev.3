Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40E456DF3;
	Wed, 16 Sep 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545595; cv=none; b=j73uGW6Xj1j1dCWKUEusblIjqUXe+Xr/jziyrBILEb3BDG4AoDaU6AcyqnAas8lWEyC+Xa00YrSM0Nnd66kF7BEsllibFXCXyGdY6c5ijPHNT90xgfLg4eyHuWQleQDngWKTny+C+FhGNuugcuR14/QDZ9JuCdxVH1ihgBMk8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545595; c=relaxed/simple;
	bh=tgAt4AMy9wR3C9Wx6/aRYrkbjbYyTUsCJmfJ81m3syk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4lBz+F937WNGHQRYqoVpJF2K/HUL2ME1uc2evmCChhAFHMi2oqJ4wLpmdewRFWNh4nOYE9DX6wMJ1g1MQ3QoImiXVY8+f6K/LvoPW8eyXxvWG+lc4n0K6iX+1mUX395awiHPLjJcxCsZUnNxeF1Fq1VwR3KXzYch11k8s28Li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pzBjbPPa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pzBjbPPa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D6647C5CD5E;
	Wed, 16 Sep 2026 08:00:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3CFE60337;
	Wed, 16 Sep 2026 07:59:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C8CC11C7AFE2;
	Wed, 16 Sep 2026 09:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789545568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=US2yq1sGRJHPOj/xzuG498kyLNhvScgzcm69R59EPbA=;
	b=pzBjbPPaN7n2BiS2bDcVorC+akn3GejLWK2tQ9r7T4LyoBU4WO+17WnwBfshoGteKUuF8/
	9DhRI2wOV5uYY4jSJDhyXamKpvrwalVF8Z2JpMr4CIHK/baAs2k66/xL4fj2NoQsErjZiR
	Ap8UGI52VKYgmQ9CskVrP0h5+AxOHrc9CXdBThWrFvLB2k1Tx5oXbXaPADBaG3MnLP5p/E
	cMvpHJQeMqkbqExi3tFb46l6SFFhTBRsHEleazzIwkL2b/VRBsKT2Y0s8H3x1AgnPFWPfn
	MF+UpKNyMQuP+NlrEe0U4bWNXq2lAMhSohA6QbCaQvO0rKXgY8ycg8w1gC/edA==
Message-ID: <c030d207-ac65-49be-b778-29f9c0aa70d5@bootlin.com>
Date: Wed, 16 Sep 2026 09:59:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: add Allwinner H616 EMAC1
 support
To: James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alastair D'Silva <alastair@d-silva.org>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/16/26 05:07, James Hilliard wrote:
> The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a separate
> system-control clock register at offset 0x34. Add its binding and a
> sun8i stmmac variant using that register. A distinct compatible without
> an older fallback prevents the driver from using EMAC0's clock register.
> 
> EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and has
> no external PHY pins. Leave PHY initialization to the PHY driver instead
> of using the H3 internal-PHY controls. The RMII-only variant does not
> expose the RGMII clock-delay properties.
> 
> The AC200/AC300 EPHY driver and package bindings are already in
> net-next. This series separates the H616 EMAC1 MAC driver and binding
> support from the earlier combined series. PWM, MFD and device-tree
> enablement are being handled separately.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Drop EMAC1 TX/RX clock-delay property support and keep the existing
>   RGMII-only delay descriptions unchanged, as requested by Maxime Ripard.
> - Clarify that EMAC1 connects internally to a co-packaged PHY, not an
>   external PHY or the H3-style internal-PHY controls.
> - Rebase onto current net-next.
> - Link to v1: https://patch.msgid.link/20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com

I didn't see that V2, but in all fairness you're not supposed to iterate
this fast. 24 hours between submissions, please :

https://docs.kernel.org/process/maintainer-netdev.html

There were discussions on Alastair's submission too, the MUX, clock,
reset part.

Adding Alastair so that he can test it on his board, and see what's missing.

Maxime

