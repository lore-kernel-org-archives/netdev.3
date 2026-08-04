Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03E3382EC;
	Tue,  4 Aug 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869369; cv=none; b=L8eaMeQeRaj0UOrZmGMqKfl0eMmSTP6nsXWDNVYpBP37HVyrdTAg6UVkJGE9QFSnj6113Tz8s7aP7U6oOmFPvEZspVlVsMBcpD+SvdHN6eNB5RJak7Q58NifYnA/XSWXm4zJQ5zns3zovtx7bHFSW7UBKEsKBdpGgo/PThnOiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869369; c=relaxed/simple;
	bh=p5ejriXvIHe92PoihQGiSuHICsoQ8A4brrIpgh24MJY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=T0gp4TPZP79+Wea5JMrm2wuqDDYWnYIAiKAZ/SY8q+MTeVDTV3xh6Urdk93xGXS7HxhibLYH4+ICJ0yAotksx2mZjSSdtCTOw3UFKmeDEo3uVH7SUeEeeWxeyTt203//GuTM2X26kpLjYPLxp4BNx1jPqsuWHtUwjEkL+P+BhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB8XdsWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB8XdsWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436EB1F000E9;
	Tue,  4 Aug 2026 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869368;
	bh=90/secOziNSTq8roV7vJAqKXK+mm27dYteEtawJ0lCI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=NB8XdsWWb7MLQh6zfTHmsKjsU25TwvrArY+VNepEOsOaNqkh6VN3iOttPPzas6DDf
	 49MhUQUn5MIQEBIlGAlhEr7L3PMITGTy/EIqbMmm6YrzX/JyfZXdziBsXpgujwaM2v
	 kt+uW5TL8hOSd5jVK+BmVMZx25wqlcpfq0dzEfgafzko/OT1kopXxCHqqia6CoPuSz
	 NB5Swkki7GpX8R3l58VAqWWSjhyZZBZ6Ivu1pJ9PR05I0eQyEx4KtalA5DYNNW2Wef
	 Hy/5xK74N9xM/Zi+qZ3Oiw0W3xGZCISCWMmEeSHSoDtZvSnGjOO6LRR40ngGT6y/hw
	 wBlTyTSoevBRw==
Date: Tue, 04 Aug 2026 13:49:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
To: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
In-Reply-To: <20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
 <20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net>
Message-Id: <178586936766.1476772.2850222255833424056.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: convert wiznet,w5x00 to YAML


On Tue, 04 Aug 2026 19:40:57 +0200, Arthur Crépin Leblond wrote:
> Convert the Wiznet w5x00 SPI Ethernet controller binding from
> text to DT schema format.
> 
> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
> ---
>  .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ----------
>  .../devicetree/bindings/net/wiznet,w5x00.yaml      | 103 +++++++++++++++++++++
>  2 files changed, 103 insertions(+), 50 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml: properties:pinctrl-names: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml: properties:interrupts: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
Error: Documentation/devicetree/bindings/net/wiznet,w5x00.example.dts:33.23-24 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/net/wiznet,w5x00.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1703: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

