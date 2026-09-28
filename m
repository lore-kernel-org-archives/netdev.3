Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48746D56E;
	Mon, 28 Sep 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582021; cv=none; b=oKck8HD4azOQxK8A45Wnh2HvgXSUknJDWW5RH8Vt7QoyevbrHBSOMcaLU1mh8Uq9ekrX+3XlX2takQM0dlcel83xLZSMYQM+LIWPa/JEefylwWcP9vd4qoZ8ZNVH0HBKu7w7JSQgJxc4k0jwxT2HyG2XlnSQlF83rXUzjumpwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582021; c=relaxed/simple;
	bh=rLMemcTGjmm8SHWfRqw2bH6bqVNgymdng9wGI6zJmgc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzefQpFh5OvOMxTp6o0L/ovNboX9HObz/J/pQYTTg76He+mEsyvF72D5nlayU0vmBkjGIkZWH3oftsOzfBk4KAyQtTKeniTy4oQp3hgCOqjN9Zx7nmbTOO/KZD5GxxMYcBXjzg1lgvhyjP2YTax0l+C5uIXTDdyn62Ruim8t71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGCvmFyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGCvmFyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7642E1F000FF;
	Mon, 28 Sep 2026 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582019;
	bh=rm8mvrgOXmhM8P747mp7fE4w601Zhc6br4KrfkiHnWs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZGCvmFyhnKyA42mxO7fiS3BI8EwGUSGuFYfELzG+raisLWdMcGUxOPT9O++/aB0/J
	 JATY+PYgTLVXVn8T1oyzmoZzMKFU7xSLj4VeNTK3/wOFtMuuklhN7tG3/DMy4iRv4E
	 zqh4y+pvoFheD7SeJyngH5x76f81dPsa7cPBU2y6rWyF4QIjNM03LRKHUGtv1lWiiO
	 8msTJbiES8KeGG7n3ArtXzXeM7Q+FmYEIXObcc73O/9vh9yaF+LBi3senIaZh8ogc2
	 RJWEEJbOzfSxqtPEI4Qqsb+IkdMQgKmpwKin4OSKpkqPjZoXjyZVMEpbpmDzJS8q6Z
	 e+11BOMosayUA==
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Date: Mon, 28 Sep 2026 07:53:37 +0000
Message-ID: <179058201796.3145.3820811818247443890@kernel.org>
In-Reply-To: <20260924075048.4060414-2-kyle.switch@motor-comm.com>
References: <20260924075048.4060414-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new binding
  Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml redefines…
- [Low] The patch adds `M: Kyle Switch <kyle.switch@motor-comm.com>` as a
  second maintainer for the whole existing MOTORCOMM PHY DRIVER section…
- [Low] The `reg` description in motorcomm,yt8824.yaml gives its address
  rule in terms of 'internal mode' and 'external mode'.
- [Low] (Discarded as a false positive in the final series state.) The
  concern was that no in-tree code reads the required `phy-mode` or uses…
- [Low] motorcomm,yt8824.yaml says the package `reg` is 'fixed at 9' in
  internal mode, but the schema does not enforce it.
- [Low] (Discarded as a false positive.) The concern was that the example
  (member PHYs at 4..7, package reg 9) contradicts the 'base + 4' rule.

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This commit adds a devicetree binding for the Motorcomm YT8824, a package
of four Ethernet PHYs. The binding is built on ethernet-phy-package.yaml.
The commit also updates the MOTORCOMM PHY DRIVER section in MAINTAINERS
with the new file and a new maintainer.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 000000000000..fd62b309e7ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,69 @@

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - motorcomm,yt8824-package
> +  phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, 10g-qxgmii ]

[Severity: Medium]
Would a vendor-prefixed property fit better here than phy-mode?

ethernet-controller.yaml defines phy-mode as the interface type between
the MAC and the PHY:

  phy-mode:
    $ref: "#/properties/phy-connection-type"

This binding gives phy-mode its own string type and enum on the package
node and uses it to pick the package operating mode. In the driver patch
later in this series, yt8824_phy_package_probe_once() reads it only to
choose between the internal and external init/reset sequences:

  res = of_get_phy_mode(np, &priv->interface_mode);

qcom,qca807x.yaml has a similar PHY package and uses a vendor property
for the same purpose:

  qcom,package-mode:
    ...
    $ref: /schemas/types.yaml#/definitions/string
    enum:
      - qsgmii
      - psgmii

writing-bindings.rst also asks for a vendor prefix on device-specific
property names.

This value on the package node also duplicates the MAC's phy-mode, which
phylink already passes to the PHY as phydev->interface. Can the two
disagree? The YT8824 driver never looks at phydev->interface.

phy-mode is also listed under required, so every YT8824 DT will carry it.
Changing its name or meaning after merge would break those DTs.

> +  reg:
> +    description:
> +      The absolute MDIO address of the YT8824 shared top extend
> +      register block.
> +      For internal mode, this is fixed at 9;
> +      For external mode it is (base MDIO address of the four
> +      member PHYs) + 4.
> +      Note that this is NOT the base ID of the first member PHY.

[Severity: Low]
Which phy-mode value does "external mode" mean? The phy-mode enum above
only allows internal and 10g-qxgmii. The text never says that the base + 4
rule applies to phy-mode = "10g-qxgmii".

That can only be worked out from the driver patch later in the series,
which treats any mode other than PHY_INTERFACE_MODE_INTERNAL as external.

The value matters. of_phy_package_join() stores this reg as
shared->base_addr, and ytphy_read_top_ext() and ytphy_write_top_ext()
reach the top block at that address.

[Severity: Low]
Could the schema enforce the "fixed at 9" rule for internal mode? No
allOf/if block ties reg to phy-mode, so a node with phy-mode = "internal"
and reg = <5> still passes dt_binding_check and dtbs_check.

Something along these lines would cover it:

  allOf:
    - if:
        properties:
          phy-mode:
            const: internal
      then:
        properties:
          reg:
            const: 9

With the driver added later in the series, a wrong reg value is used
directly at runtime:

of_phy_package_join()
  phy_package_join(phydev, base_addr, ...)

ytphy_write_top_ext()
  __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, ...)

In that case, writes to the top block would go to the wrong MDIO device.
The schema can't express the external base + 4 rule, but it can express
the internal-mode constant.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3ce77c839b0..ed7af1bd9521 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18409,8 +18409,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
>  
>  MOTORCOMM PHY DRIVER
>  M:	Frank <Frank.Sae@motor-comm.com>
> +M:	Kyle Switch <kyle.switch@motor-comm.com>

[Severity: Low]
This line makes Kyle Switch a second maintainer of the whole MOTORCOMM PHY
DRIVER section. That section also covers drivers/net/phy/motorcomm.c and
motorcomm,yt8xxx.yaml, not just the new binding.

The commit message only says:

  Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.

It doesn't mention the maintainer change, and there's no Acked-by from the
current maintainer.

Could this be split into its own patch, or at least be described in the
changelog?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924075048.4060414-1-kyle.switch%40motor-comm.com
