Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B7396D38;
	Fri,  9 Oct 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564587; cv=none; b=HYPwZIcM2rnhnNFLaqvpFOBoDwV9R1GuCyfIkyR5RVdI0w5jmYK2o0Z2Frwlsux7fnZ2sCQLOlNJ7saRb3gfQlxL1+tJ4mCxkYGIiuYzgGNK3mmXJsL2yUUYOoZw8ZLTChVS3stNv5hMY36o2wJGS0Y8JfVBbMT+5R1x8khfT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564587; c=relaxed/simple;
	bh=iAbcYQHMciL8QkKpj9dDQRLVVEpXDZmVDCEKaxnxQ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbMC9jcBjtb+Y7f+FW7+g6PwFGeoJKOVsT0aXPaGCyJ4L1YuEYKICqS2FKesKZckxIwSNxpWAeCIYLnVtiSRQIrhfPS0JAyHAFC50WgN2035zHDIDdu5cfJiGexma7d33XRDxxc2cNJR5J95ZPng92Uuiq24SBx9IKRdkaDKkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSX7FMUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSX7FMUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C581F000FF;
	Fri,  9 Oct 2026 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791564586;
	bh=CTT8pod/dXSgBzj9OOaa5UJXITB7IAWcLcd9LSZGJk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WSX7FMUOCYVTX/ma95DRi6BuxZOdqwIprcFhIKZpgHCYwBIJEHdcMeFOFVMwlDt/A
	 CWVJ1TJ45tECI7M+iXIunGxrTb+HsIChi/MgZk5nR72uRQOu4BFs5+VVGT6Im62Wxi
	 enlLXKLlAUgqXlhJk8gIIGuOIexyVphQ5PSDIwtOZmQ/tTVBWHGSuNKESj3syoWguy
	 X5p80UaYONzYWLXb65Bmfr88jEXZKPFElnpCfbEqCi41EeZLAbVzwvDNDTPgi5tHUS
	 +SJSLtZ28KWDFNgdjiCrsKVRM58FPAmtExWyZuiHVCcEaocPzlcwFCXc59iXn9C3ZR
	 wIXx1fu1QaY9w==
Date: Fri, 9 Oct 2026 11:49:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v11 2/6] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
Message-ID: <179156458455.2715944.16954075391439114318.robh@kernel.org>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
 <20261008175225.3375274-3-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008175225.3375274-3-coiaprant@gmail.com>


On Fri, 09 Oct 2026 01:51:56 +0800, Coia Prant wrote:
> Add device tree binding documentation for the Synopsys DesignWare
> XPCS integrated on the Rockchip RK3568 SoC.
> 
> The XPCS is accessed over the APB3 bus and internally connected to
> a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
> QSGMII modes, with four MII ports.
> 
> The MII port used by the SGMII link is derived from the MAC it is
> routed to: GMAC0 uses port 0, GMAC1 uses port 1.  The port index is
> not an independent board-level configuration, so the binding does
> not describe the ports.  If a future SoC needs per-port configuration
> that cannot be derived, pcs-handle argument cells can be added then.
> 
> The CRU reset lines (SRST_XPCS*) are intentionally not described: no
> in-tree user requests them, and bring-up relies on the PD_PIPE power
> domain, the SerDes PHY and the in-IP soft reset. They can be added
> later as optional without breaking ABI.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  .../net/pcs/rockchip,rk3568-xpcs.yaml         | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

