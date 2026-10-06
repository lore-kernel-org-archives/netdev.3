Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8C3B6C09;
	Tue,  6 Oct 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294484; cv=none; b=Ot/kvsWVJ1JhL5/+rVEaQLTf0g8kuGfz4IyJVoLBmemOGXMXshR5pdIKu+XWqvz5TQzwhbH+NNApXtjfAEQt4X0AF7G8dBObD8+YtGrmedI/T1BRsoQa+dzILJbAqAcj5la2ALQ7cpfWv7D+DNUo8mJnm7LhK/y55nLVAG/lv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294484; c=relaxed/simple;
	bh=A95iOD8EPA2fBI6O4l67tkcCR1SsZXfZd0uCiQRM83o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUBnAKoiC3Plx4mF20chGUQLAMfFZGZ/DZac1egfrGHrXIhHXeeKulp2TGkj9KoTO5U7xD6ZUfGbqe9QRcwpdKwVWJ/mQeqxtJWo557FTxlRpyO8o2TNfHGZxIm9+zNwV409wCt+tVil7rqPvbUTS0rFL8uglBXulDBS74j9xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtyV5OsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtyV5OsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A71F000FF;
	Tue,  6 Oct 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791294483;
	bh=bX8Hd8xkhkvU6LYfv2cR6ForT+o/uR4b+HCuOknf1cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jtyV5OsLOt5wzeBUdktXowhC6OUd0Le9GyAAD2mp7k00aIDP2WQsS4XcNUOiUb/Qg
	 yOOI7hz2BHk+yUFwewK2BuEKeYX1oU6NJ5e4Omrpz7dBsfvqutBCwYUp/4/+d7fl66
	 XpSFEPggIvj5uNJP4LzqD63xLTS2/RyEukp886nXaYzC30xH2llQPniEyOVTAUdB8A
	 pznpljoMYHUHjd8UnWBWkcEzWlNpWXfvEYLJJG052TkWiMHsAy9mKvlqTO1dh6UHvI
	 Jy/Z4Ml1GKQw5cs+yYpi2ufH9veW70RnmWmfA5gDXVrUunbU5OV9aLe3vb/6HYpAbE
	 2w4jv722onw6A==
Date: Tue, 6 Oct 2026 08:48:02 -0500
From: Rob Herring <robh@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 4/6] dt-bindings: net: rockchip-dwmac:
 document pcs-handle
Message-ID: <20261006134802.GA1916640-robh@kernel.org>
References: <20261005223011.1124347-1-coiaprant@gmail.com>
 <20261005223011.1124347-5-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005223011.1124347-5-coiaprant@gmail.com>

On Tue, Oct 06, 2026 at 06:30:06AM +0800, Coia Prant wrote:
> The Rockchip GMAC binding needs to describe the PCS reference used by
> the SGMII support added later in this series. The property will be
> parsed by rk_pcs_init(), and a missing phandle fails the probe. Add it
> and require it when phy-mode is "sgmii" on rockchip,rk3568-gmac, the
> only SoC in this binding that has SGMII support.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  .../bindings/net/rockchip-dwmac.yaml           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 80c252845349c..bb7540e838033 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -120,6 +120,12 @@ properties:
>      maximum: 0x7F
>      default: 0x10
>  
> +  pcs-handle:
> +    description:
> +      Specifies a reference to a node representing the PCS device
> +      connected to this GMAC. Required when phy-mode is "sgmii".
> +    maxItems: 1
> +
>    phy-supply:
>      description: PHY regulator
>  
> @@ -159,6 +165,18 @@ allOf:
>          clocks:
>            minItems: 5
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-gmac
> +        phy-mode:
> +          contains:
> +            const: sgmii

The 'if' will also be true if 'phy-mode' is not present. Probably not 
what you want? You need 'required: [ phy-mode ]'.

Rob
