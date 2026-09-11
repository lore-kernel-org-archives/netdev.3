Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95225469840;
	Fri, 11 Sep 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116265; cv=none; b=OiYxIiNLB08ZNiahKEnNRJhC37N3YdYrmdM1QrDVDiIAobLYP6k2/jUI+O6dz+5/MRRaULJ776+bmED+bJQ1Vzi7aFYlSuGomh24EI3dsa0PUYn2HSKUJNo5aVdTIGUhXaiIzp1/l/XhX9mIk0z+U+NtPtyD+F8XSeMSOEnDhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116265; c=relaxed/simple;
	bh=wQ+NK8oI0kpedKGLeaX2BXXvhSLdSPDT2uE7PQYQA0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uix7lM33PrhuSqaNfxTh+ynuPVjQyfsQf8pscKYqsXP+SZGwwhx37ebPzXFWOVvR9CPWuscDqwkXSezboa5AsEkkERfAmzvTHENkATps0wSwB74FFdPm3zWlAh19x76p6TzhKoWj84gZ8YbU0QGZP6UuRk8t9RAknvTKcRovgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm3bTb04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm3bTb04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4EC1F000FF;
	Fri, 11 Sep 2026 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789116264;
	bh=z3r4COyHctccKKhBPYehoXK6/1U5/Ptf/ivRioJgOAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jm3bTb04mhPldN0zTfwFn3CarArd7NI9MOHHz5u/neLizqndr/wb9lguxCQ0esa+9
	 6JDd5uszF86kEVnxDHsQILNp4+8bKKJ2cBA2d4Ll8KLZICQnodVehR23BIYICtDWP+
	 HcCkIDnI+ZDB+vF8sHO5VgHsIHaz/JJ4ckusi+S0FDr7di/r+ipB1fpH2QVT5fCmJK
	 hUNyUoSdtVIHRzmQCzq3j46AXYNSvAJ2pJrT/tQQWtiD21+YTS09gzFOblTtp5voCC
	 Xv29XacJZPoC8hj7PaTyKYhlurDAokfprXk8h9uonIldHE03kLc67CVDPFWnBWZkYE
	 Wd5eDSWSDeVLQ==
Date: Fri, 11 Sep 2026 10:44:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, ming.xu@motor-comm.com, 
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, jie.han@motor-comm.com, 
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH v16 2/2] dt-bindings: net: Document Motorcomm YT8824 PHY
 package
Message-ID: <20260911-metal-muskrat-of-finesse-1abf97@quoll>
References: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
 <20260910074624.2426899-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910074624.2426899-3-kyle.switch@motor-comm.com>

On Thu, Sep 10, 2026 at 03:46:24PM +0800, Kyle Switch wrote:
> Document Motorcomm YT8824 PHY package.
> 
> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.

One sentence is enough. "Document foo bar, a baz bam something".

> 
> Document the required property to make the PHY package correctly
> configure and work.

This is redundant sentence.

> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
>  .../bindings/net/motorcomm,yt8824.yaml        | 63 +++++++++++++++++++

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 000000000000..9907a4a7e63e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MotorComm YT8824 Ethernet PHY
> +
> +maintainers:
> +  - Kyle Switch <kyle.switch@motor-comm.com>
> +
> +description: |


Do not need '|' unless you need to preserve formatting.

> +  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
> +
> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id4f51.e8b8
> +
> +  motorcomm,interface-mode:

Aren't you duplicating protocol-names from
/schemas/phy/phy-common-props.yaml?


Best regards,
Krzysztof

