Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509164;
	b=ES0NRdlga7TDnLbgJDrEGIrNloDe6cTj/41C+lFa2KeyFsBb12mkK5moZ0XtcCmPBjHY
	 xLC0/FYJombeTxI8q799TKEPAqvOZzsFK1oEAPoPYAVht56137wRjCrYOk/1K0yX9wTmH
	 tFLI0wMRyLJxzAYjk8zoVmdjS9OPz8oJbNBUyDu4uhNUL3wq8c7HNfiY2opL4Tok3Ntlo
	 Y3tVSY0D0S5db1/A/mVgHPSoxvY7pexc+JW+yBKmNRQaClay6CVUVXHwHBrzIPuMtcahz
	 f0BFoxcVr+l75Hy9OD/792sk3GIfUIv2dEMXXki0VRMCq5UVSOYeep7BFrd0jfl8BmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509164;
	h=Received:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=13Yuoyae55wiKNqti/LOAEL9RI5niDoBeik6pXc0Zx4=;
	b=mKzhujc8cKb4YtGoFK7QOWHZ1bc3euRZyqC9x0d7KHsonNkulDebB7LmcBudNpDH9kXO
	 5wYoc9MkSHSO6Ct97BByfvL2lXAOYRduHiSuZO32MAg3/PjI1GljO6mkPGpzpsoaua9rG
	 PkzVPbSNxFttx7emWxiEI4R+jn5oLYDUDZVzoztmHRTDNIz1Hyw1xvS17iJy8S0fbcn2r
	 HQje6kuFamzaKfIDpmLZ37CoGG+/sH43lF4Y3kQI5xqZSyoLVFUMJRHszUIQJC9xqSpF0
	 qVZp7rAS0j2z8h+FzliTLchtVWg6s9Yh4hYoyH5U51EQ5OGxn6Bry3nvxv9yDxcstfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3C606A320;
	Tue, 20 Oct 2026 15:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1188E1F000C4;
	Tue, 20 Oct 2026 15:12:44 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:12:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, edumazet@kernel.org, 
 devicetree@vger.kernel.org, mohd.anwar@oss.qualcomm.com, 
 peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com, 
 alexandre.torgue@foss.st.com, daniel@riscstar.com, joabreu@synopsys.com, 
 pabeni@redhat.com, davem@davemloft.net, maxime.chevallier@bootlin.com, 
 netdev@vger.kernel.org, linux@armlinux.org.uk, richardcochran@gmail.com, 
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com, 
 kuba@kernel.org, hkallweit1@gmail.com, krzk+dt@kernel.org, 
 p.zabel@pengutronix.de, andrew+netdev@lunn.ch, conor+dt@kernel.org, 
 lorenzo.bianconi@oss.qualcomm.com
To: Alex Elder <elder@riscstar.com>
In-Reply-To: <20261019030129.1470307-2-elder@riscstar.com>
References: <20261019030129.1470307-1-elder@riscstar.com>
 <20261019030129.1470307-2-elder@riscstar.com>
Message-Id: <179250894164.3309593.6302141090126438838.robh@kernel.org>
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: add support for Toshiba
 TC9564


On Sun, 18 Oct 2026 22:01:24 -0500, Alex Elder wrote:
> The Toshiba TC9564 is an SoC that exposes two XGMAC 10 Gbps Ethernet
> interfaces, each of which is attached to an embedded PCIe function.
> 
> These XGMAC interfaces have three resets, for the MAC, PMA, and XPCS
> layers.  These resets differ from the standard two resets defined
> in "snps,dwmac.yaml".
> 
> To permit these other resets to be used, modify the way resets are
> defined in "snps,dwmac.yaml" to be similar to the way interrupts and
> their names are defined earlier in the file.  That is, rather than
> adding descriptions with the resets property values, just specify the
> maximum number of items.  Then, in the reset-names property, provide
> a list of description/constant value pairs, indicating which renames
> may be used among the (three) reset items specified.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  26 +-
>  .../bindings/net/toshiba,tc9564-xgmac.yaml    | 327 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  3 files changed, 351 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/snps,dwmac.yaml: properties:reset-names: {'maxItems': 3, 'items': [{'oneOf': [{'description': 'GMAC stmmaceth reset', 'const': 'stmmaceth'}, {'description': 'AHB reset', 'const': 'ahb'}, {'description': 'MAC reset', 'const': 'mac-reset'}, {'description': 'PMA (Physical Medium Attachment) reset', 'const': 'pma-reset'}, {'description': 'XPCS reset', 'const': 'xpcs-reset'}, {'description': 'OCP reset (deprecated)', 'const': 'stmmaceth-ocp'}]}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/snps,dwmac.yaml: properties:reset-names:items:0: 'oneOf' is not one of ['const', 'deprecated', 'description', 'enum', 'not', 'pattern']
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.example.dtb: ethernet@48000 (toshiba,tc9564-xgmac): False schema does not allow True
	from schema $id: http://devicetree.org/schemas/net/toshiba,tc9564-xgmac.yaml
Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.example.dtb: ethernet-phy@1c (ethernet-phy-id004d.d101): Unevaluated properties are not allowed ('vdd18-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/qca,qca808x.yaml

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml

See https://patchwork.kernel.org/project/devicetree/patch/20261019030129.1470307-2-elder@riscstar.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

