Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE636B903;
	Wed,  5 Aug 2026 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901125; cv=none; b=mMzUsjVm3McZQbSY+ee17D7oPnokg+i4Z0YaOteRmcOTlKdFiu8r/Srd2cZH6v3jUntHWpSJkQpR1mMEaK4nSHACTc0Wqi5kh02YFqZrNQnUjWgSIChWjKlRYMP1apTmZVL45GRdNPr/VK7PzWFR7U6Gwchy90j02Qc8i4KWwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901125; c=relaxed/simple;
	bh=OKP6xHa+1c17CYJor4ZlJfUFbUr1hnHsEjWCcgS6M7M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tLvqI83jDQu5NpUeq00+buMtR8OD4OHXwsvI+DpTqoSjti6Qhv0uvT0w3b9LlJ3yYvG0mSFylEOA0zO+QZxmazk3aIQb082jKn3R6oWVIBMHGvT2ooLKt903Ojn9yYverICkGLInzvSYa/mS5MUZiwpDS1wfkg4Fp39qhSVeWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drlgmm2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drlgmm2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA0C1F000E9;
	Wed,  5 Aug 2026 03:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785901123;
	bh=DV1z5mj1QUuYa1oiWEhvT6ntXIxw5uNdwhuaWJTrkz4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=Drlgmm2LfLdi0ki/OU0Gb5E4e5+I+O2JNolD4ppPZaLJkXeTG5e4xqL9bH0xg5dz5
	 Ecu1kCnadnEl4qpRAcaiDUcK5JJrZqrXzJ1+bj4jMLjSj3Roh8mYx9FCbsSAB9ZeP6
	 ntB8sCmubWP2E5oqg1iodV7HNKtGhiTKyuZc18MPgqjS6VQgq1EnwkK2D9Qnk+BEcc
	 QkO3HNbG0XZELHCViM3NT74RgZd/JL+q7ubZ/zTBdk/NhIVh/UX0Evas6uNMytAuUL
	 Mdu99nSX6FDAyx6lAe/+l2Xzq9H0NX4yAE9GKEwYysO42Mst+n76HarxMJJ3Pv8JQV
	 CWdfPsvBRbc3w==
Date: Tue, 04 Aug 2026 22:38:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com>
Message-Id: <178590112290.2793077.11109877876759547563.robh@kernel.org>
Subject: Re: [PATCH net-next v2 5/8] dt-bindings: net: x-powers: add AC300
 EPHY control


On Tue, 04 Aug 2026 20:27:03 -0600, James Hilliard wrote:
> The AC300 exposes its Fast Ethernet PHY control registers through a
> separate non-PHY Clause 22 address. The manual defines that address as
> the link PHY address plus 16, giving control addresses 16 through 23 and
> link addresses 0 through 7.
> 
> Describe the control endpoint, its required VCC1 supply, its 24, 25 or
> 27 MHz input clock and its SoC SID calibration cell. The actual PHY
> remains a separate ethernet-phy node and supplies the MAC-selected
> interface mode at runtime.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../bindings/net/x-powers,ac300-ephy-ctl.yaml      | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.example.dtb: display0: fsl,pcr: b'\xf0\xc8\x80\x80' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

