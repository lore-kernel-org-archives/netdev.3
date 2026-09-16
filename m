Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D2511E89;
	Wed, 16 Sep 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572136; cv=none; b=NHyED+tKnw8dgISdVSHb2P/GC/MfKHP7Vg7D/+SWEBB3OiIg+Wut0J27SAy45Dn/WuPIYbJe2PRZ84Cav32SDEsjloVb+4W1vEUAoDTZ1dHUDtKFrce6/i72Dnw/XA/IutXq9MnVcEFxXOpaAtYlXxB2Zj8wHgWeKXXJ3MRgngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572136; c=relaxed/simple;
	bh=N8aiCHErIRe3cDRFakh4xoLjQHHkC0NHS1W/UCrd7dw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TMVE5o3GWQS6++e+UJDgqCwydVEYSnVbfdDTi+9zVQmzGuIBZWhaw1bazyf4vQ8YXwGSixqkXqDoF5wen80uwNvqHJb51V8jFuocanLwM2PqqBmRua9ohepW57VHcP9QBK1uUEDltb0R8Pax27gKWowNtynBwT9DvpvAlmjJC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opLOvjeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opLOvjeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A611F000FF;
	Wed, 16 Sep 2026 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572126;
	bh=8EztYNQsdjLqlbOEDEsuqybbRRUCXbpkuwA/2dp5qRI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=opLOvjeGosMppia9uO8Q/Y0ZFmvqlKZvofdW32/kTovLCJvHaJEayYOKbu4chKGNL
	 5hsNx+GTdLM7tS2SmzRggY9wFOz6uEM1hIyBzUxgWOyERkELVKd2hUfnyWJfIe6uLV
	 Rinjqu7DvXGC4BFwYD47POgPlE8TWZzzFv7DqKtt4Nbb82Iws037PyXZLt2geRDVXC
	 0bzPVRALj9OPpxmriQlotbjN6nD5oEYfMDXiwIAh53rVk+SBUuElHThnWULatSij7W
	 vpWIUtl8yA1g5KKxF98iEejoYgMd0+II91sTJIjVlbdskZ5y23NB7qY9KrvBZ/FZd4
	 8pfPsN5e/kgJw==
Date: Wed, 16 Sep 2026 10:22:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jakub Kicinski <kuba@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Samuel Holland <samuel@sholland.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 linux-sunxi@lists.linux.dev, Russell King <linux@armlinux.org.uk>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
To: Alastair D'Silva <alastair@d-silva.org>
In-Reply-To: <20260916044119.475666-2-alastair@d-silva.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
 <20260916044119.475666-2-alastair@d-silva.org>
Message-Id: <178957206753.228275.3543582001774069181.robh@kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: phy: Add Allwinner
 AC300 EPHY binding


On Wed, 16 Sep 2026 14:41:16 +1000, Alastair D'Silva wrote:
> Add device tree binding documentation for the Allwinner AC300
> Fast Ethernet Physical Layer (EPHY) co-packaged on Allwinner
> H616 and H618 SoCs.
> 
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
> 
> Notes:
>     Tested on Mellow Fly-C5 (Allwinner H618) under Armbian with Linux 6.18 and
>     7.x kernels, verifying schema validation with dt_binding_check.
> 
>  .../net/allwinner,sun50i-h618-ac300-ephy.yaml | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.example.dtb: ethernet-phy@0 (ethernet-phy-id0044.1400): compatible: 'oneOf' conditional failed, one must be fixed:
	['ethernet-phy-id0044.1400', 'allwinner,sun50i-h618-ac300-ephy', 'ethernet-phy-ieee802.3-c22'] is too long
	'ethernet-phy-ieee802.3-c22' was expected
	'ethernet-phy-ieee802.3-c45' was expected
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun50i-h618-ac300-ephy.yaml
Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.example.dtb: ethernet-phy@0 (ethernet-phy-id0044.1400): compatible: 'oneOf' conditional failed, one must be fixed:
	['ethernet-phy-id0044.1400', 'allwinner,sun50i-h618-ac300-ephy', 'ethernet-phy-ieee802.3-c22'] is too long
	'ethernet-phy-ieee802.3-c22' was expected
	'ethernet-phy-ieee802.3-c45' was expected
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260916044119.475666-2-alastair@d-silva.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

