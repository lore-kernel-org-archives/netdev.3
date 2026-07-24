Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E002DC79A;
	Fri, 24 Jul 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899013; cv=none; b=HZQIKUyMUrI+EZBae5GrBX6p7RBKl1CWGFBMMsE7iRZBMNPZgZ9zDKQm7V2BcrkKOFrATcw02mbYb2TZrRxWlZbtrdGVCtbN0TMHT56QEvBMR2DdoFPawJ67OzMhfsXdGeNshg7fY5mOitIxRuwcldUxnk/K4rtXKdechHhyy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899013; c=relaxed/simple;
	bh=5fg70FATkdTPlB+r5sELlMsftIy9haRZRX0/8GePUIo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SCAqStDwYrLDJS+AQQ3FYRR+gn4F4W7Y+2bl2i7I1zwvYd9pdWrxzXMzfBR328c5ubmOJjmlo3uUr87pcGr45tlCyrhx+KbrLoLZ/+w7Cqq+laVgAcvuUB3g+PVzL3yb9uH7F1kp/R3kOWCsPtdOXQyAdtk8gSSbBrQVKdYnJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfT2mN54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfT2mN54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5311F000E9;
	Fri, 24 Jul 2026 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784899011;
	bh=J5CUcwtybRsnP7K85MNqacwjWecyslUsjby8+ZC9UXw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=SfT2mN54HZxMmsREoVtswZlYPLgI8qEJG1+7Hxsj1WWftapWz00QtYB9irMeStjSm
	 XqMvusvqJsssC6KlCh5TzZIuf+44vryFOMpoU/Bo4ebqVSpEHbdUaSR3YrH/Ep7bRW
	 rvh1LIp8AkVxRnJJhIbDEJkNF3IumU4S/3G//pZWHyGIAUffaoPla2XCV4fzI/uhOs
	 S/RawXOOiOwtaew7SnE5ee65HwVkei5jlf8foS8aTrQG3Cg0mDSA6r4VmsdmH8G+1y
	 4Hu8BmSqKlS3/kpN3tSgEFwgcyHCG9ymFbUjvQuHtFxL6fohbeCYYlo+VXNR742ZTR
	 0GTFxZKgNBFXA==
Date: Fri, 24 Jul 2026 08:16:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
 linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shyam Pandey <radhey.shyam.pandey@xilinx.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S . Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, harini.katakam@amd.com, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
In-Reply-To: <20260723123838.125145-4-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260723123838.125145-4-suraj.gupta2@amd.com>
Message-Id: <178489900988.2774291.12161691819404985580.robh@kernel.org>
Subject: Re: [PATCH net-next 3/7] dt-bindings: net: xlnx,axi-ethernet: Add
 10G/25G (XXV) ethernet


On Thu, 23 Jul 2026 18:08:34 +0530, Suraj Gupta wrote:
> The XXV Ethernet IP integrates a 10G/25G Ethernet MAC with an in-core
> PCS/PMA driving a high-speed serial transceiver. Extend the existing
> xlnx,axi-ethernet binding to describe it.
> 
> Add the "xlnx,xxv-ethernet-1.0" compatible and make the resource
> requirements conditional based on the XXV compatible string:
> 
>   - "dmas", "dma-names", and "phy-mode" are required.
>   - Interrupt properties are not required as it does not have a dedicated
>     Ethernet core interrupt.
>   - "phy-handle" is not required as it has internal PCS and PMA.
>   - Add the 10gbase-r and 25gbase-r phy-mode values used by XXV.
> Annotate the existing compatibles, generalise the title to cover both
> variants, and add an example node for XXV.
> 
> Define properties at top level per binding style and use if/then to
> constrain requirements and phy-mode per compatible. Forbid 1G-only and
> unused ethernet-controller properties on XXV nodes.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  .../bindings/net/xlnx,axi-ethernet.yaml       | 144 ++++++++++++++----
>  1 file changed, 117 insertions(+), 27 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml: allOf:2:then:properties:clocks: {'maxItems': 3, 'items': [{'description': 'RX AXI4-Stream clock (rx_core_clk).'}, {'description': 'GT DRP clock (dclk).'}, {'description': 'AXI4-Lite register clock (s_axi_aclk).'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml: allOf:2:then:properties:clock-names: {'maxItems': 3, 'items': [{'const': 'rx_core_clk'}, {'const': 'dclk'}, {'const': 's_axi_aclk'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260723123838.125145-4-suraj.gupta2@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

