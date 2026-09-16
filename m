Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355674F4730;
	Wed, 16 Sep 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572133; cv=none; b=kQjJJTukFKQ7ABM++OU3DfSfU8PApeBBR1VyiwSefhXsVKqQcEP0Ph+lqdjduyClUrNSCXeIB1H1ffxyYPvopB0//Ie3V03ByMsDDJAlDBGVu0tchvLv5+gb40gZS5iXSNnXj9Su5vK+oxDW1PFFE8O1kZjVOZeaAPlYiaefqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572133; c=relaxed/simple;
	bh=AZSQtEBN7kQJsgzRDGgC/AX5q1GuadKhXLqhMjB5AHU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WEiVOBFrJBkDx9XDdmfpK35HKgbOQ7j7InUnsoy3GGTczf5NTgv5EwMSNQiiy/wh1aOOe0nnF6/NH8FqZFWLZdriOxGufqGC/plA9qfD1eonc/KSiNjY8f6QMZ1ZjCSOgN5Z/r2vQX9JovsIyUh7fqns+15HguNl3CYzg/zNML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghwDoUYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghwDoUYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D191F00893;
	Wed, 16 Sep 2026 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572127;
	bh=8tD6Xr9J2ucQ5/OOmstOBkaQazxoKsfY0YaWI5fIV5g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=ghwDoUYQfT6LqJhAL5A6kG9TMoaCptirC39o32HGg7XG01YipLD+Lk2WqNjipGxu2
	 UKAFVY7SM+TOQWwPrJgXEvQOvqs6JKOWjehSZwPJAzTDkMB++EOtdb0iGGllqiGulf
	 gseRWbN+//EfJXylS6lTsAwveesUkZnK6LcsR4mwkQT8ASC5ZXJ3MXAdVLIHuQZWtg
	 Qz4sxNxJT4QPrAq2dK6cFfeIalrHwUHttgOwxiVv0TAmiP7dafVn7XziOAezZ1mHAW
	 Z2mvSIUHiLaR78mhPW2rym4XtHu+ntuK+mzekWfWRhwmLqgJT9Zg9ntdgDO5I5Zyez
	 1V7i3im/MJ1Gw==
Date: Wed, 16 Sep 2026 10:22:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Paolo Abeni <pabeni@redhat.com>, Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
To: Alastair D'Silva <alastair@d-silva.org>
In-Reply-To: <20260916044119.475666-4-alastair@d-silva.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
 <20260916044119.475666-4-alastair@d-silva.org>
Message-Id: <178957206885.228671.2262343816324087676.robh@kernel.org>
Subject: Re: [PATCH net-next 3/4] dt-bindings: net:
 allwinner,sun8i-a83t-emac: Add Allwinner H616 EMAC1 and syscon index


On Wed, 16 Sep 2026 14:41:18 +1000, Alastair D'Silva wrote:
> Document the Allwinner H616 EMAC1 and internal EMAC compatible strings
> ("allwinner,sun50i-h616-emac1" and "allwinner,sun50i-h616-internal-emac").
> Update the syscon property schema to support an optional register index
> offset argument, allowing boards to reference the secondary EMAC clock
> register on H616/H618 SoCs.
> 
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
> 
> Notes:
>     Tested against Allwinner H616/H618 device trees in Armbian, verifying
>     schema validation with dt_binding_check.
> 
>  .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml: properties:syscon:items:0: {'minItems': 1, 'maxItems': 2, 'items': [{'description': 'Phandle to the device containing the EMAC or GMAC clock register'}, {'description': 'Register index offset (0 for EMAC0, 1 for EMAC1)'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260916044119.475666-4-alastair@d-silva.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

