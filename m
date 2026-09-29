Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93F3655EE;
	Tue, 29 Sep 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720840; cv=none; b=Bpxbnmn6xOmYWe3yN04bM1JnshwiXZiINYfQa6UYqK/2uJpiuYrZhEAsXhsoK4OqycN3Qco+QcTXwfKIaaHZW7zoNkYARz4wuWV9lxvN+BLKwBSLC7l0l6R4aGVefAyr7e3mUTSRESdupLm/0SUwYZc4l3pI2V7Et9XRudU/wTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720840; c=relaxed/simple;
	bh=fbykgit0n4ULaprfgP5+VfWnfZtXKoDZOHFdu9BumsY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2bYJ4vK3g3aFcThkO66fzsq+N5X7ezroB7j5MqGYZf/pRm2YQpGnNhpjcKgzr1UPOowoloVuSgsU3OflwX1y8vHWUhqyPoTWt5mg/0iPQIY3Re54ywE48TXrftR1K3RqjshrVwJxUaN5L/UWKxpiBKzJ0pW4b9KHfJpnJDtjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHPp+T7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHPp+T7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E940D1F000FF;
	Tue, 29 Sep 2026 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790720838;
	bh=1t/EmD32JasAg9G1mq7tSHX+cW5JX35AtHTXSmFCoe4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LHPp+T7QQru4ilslDfJod766syRFINgV1exFSGgz1boVv1YWdIxJ4YwyhPM2DaI3S
	 GNJE0GDGgnCsaawIMkbN1GQkrtfEH5fdbklI522WIotBYIYPyQ4ApiM3oJR4N7bmKQ
	 5HWIsAZS8KiGZTANBXzFBlK4IyHcYq/BI7S3i1CSlLFq4Nr2gFdG1tVdfGYvGVH33+
	 uQUWYtvYeh/qWXWbV23Pdo2j4MlpUEuQ98XJsrHWBm3jpmMe2ezOCncAmREG3wuVhF
	 MAcnCw4U5jX5sqhA4UG41Lc6hAhg0VyjJDx47RxI/1h7S7OskVd3NjaqbnDRxA70Pi
	 jq1vor7qJWk9A==
Subject: Re: [PATCH net-next] dt-bindings: net: Convert HiSilicon hns-dsaf to
 DT schema
From: netdev-bot+sashiko@kernel.org
To: robh@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 22:27:17 +0000
Message-ID: <179072083746.434549.9632212557416686292@kernel.org>
In-Reply-To: <20260925215848.2949157-2-robh@kernel.org>
References: <20260925215848.2949157-2-robh@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The schema leaves out properties the driver needs and drops
  value constraints the hardware relies on: (1) 'buf-size' and 'desc-…
- [Medium] The 'reg' description in the new schema (lines 21-33) gives a
  fixed four-entry positional layout: [0] external interface control…
- [Low] The patch deletes
  Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt without…
- [Low] In the new binding, the port 'media-type' enum (lines 115-119)
  allows only 'copper' and 'fiber'.
- [Low] The schema example (lines 135-142) sits at the top level with no
  parent bus node that sets '#address-cells = <2>; #size-cells = <2>;'.

--

dt-bindings: net: Convert HiSilicon hns-dsaf to DT schema

This converts the HiSilicon hns-dsaf binding from text to DT schema
format. It drops the unused top-level phy-handle property and documents
the previously undocumented media-type port property.

> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
> new file mode 100644
> index 0000000000000..4edc6cafcbed3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
> @@ -0,0 +1,168 @@

[ ... ]

> +  reg:
> +    minItems: 1
> +    items:
> +      - description:
> +          external interface control register base and size (optional, only
> +          used when subctrl-syscon does not exist)
> +      - description:
> +          SerDes base register and size (optional, only used when serdes-syscon
> +          in port node does not exist)
> +      - description:
> +          PPE register base and size
> +      - description:
> +          DSA Fabric base register and size (not required for single-port mode)
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: ppe-base
> +      - const: dsaf-base

[Severity: Medium]

Do the reg item descriptions match reg-names? The reg list describes a
four-entry layout by position (subctrl, SerDes, PPE, DSAF). But reg-names
is required, and it only allows ppe-base at index 0 and dsaf-base at
index 1.

The in-tree users in hip06.dtsi and hip07.dtsi look like this:

    reg = <0x0 0xc5000000 0x0 0x890000>,
          <0x0 0xc7000000 0x0 0x600000>;
    reg-names = "ppe-base", "dsaf-base";

So reg[0] is really the PPE block, but the schema describes it as the
external interface control block.

The four-region layout also can't be written with these reg-names. When
subctrl-syscon is absent, hns_dsaf_get_cfg() takes the first regions by
position and then looks up PPE by name:

drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:hns_dsaf_get_cfg() {
    ...
    if (IS_ERR_OR_NULL(syscon)) {
        res = platform_get_resource(pdev, IORESOURCE_MEM, res_idx++);
        ...
    }
    ...
    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ppe-base");
    ...
}

With ppe-base forced to index 0, wouldn't this lookup return the region
already mapped as sc_base? The second devm_ioremap_resource() would then
fail.

Should the reg items describe PPE and then DSAF instead, keeping
minItems: 1 for single-port mode?

[ ... ]

> +  buf-size:
> +    description: RX buffer size (bytes)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  desc-num:
> +    description: number of descriptors in TX and RX queue
> +    $ref: /schemas/types.yaml#/definitions/uint32

[ ... ]

> +      media-type:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - copper
> +          - fiber

[Severity: Low]

Should backplane be in this enum too? hns_mac_get_info() reads media-type
with fwnode_property_read_string() for both OF and ACPI port nodes. It
then matches the string against media_type_defs in hns_dsaf_mac.c:

    {HNAE_MEDIA_TYPE_UNKNOWN,   "unknown" },
    {HNAE_MEDIA_TYPE_FIBER,     "fiber" },
    {HNAE_MEDIA_TYPE_COPPER,    "copper" },
    {HNAE_MEDIA_TYPE_BACKPLANE, "backplane" },

The driver handles a DT port with media-type = "backplane", but that port
would fail dtbs_check with this schema. In-tree DTs only use fiber and
copper, and the commit message doesn't say why backplane was left out.

> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - mode

[Severity: Medium]

The old text binding listed buf-size and desc-num under "Required
properties". Neither one is in this required list, and the commit message
doesn't mention the change. Should they be required here?

hns_dsaf_get_cfg() fails probe if either one is missing:

    ret = device_property_read_u32(dsaf_dev->dev, "desc-num", &desc_num);
    if (ret < 0 || desc_num < HNS_DSAF_MIN_DESC_CNT ||
        desc_num > HNS_DSAF_MAX_DESC_CNT) {
    ...
    ret = device_property_read_u32(dsaf_dev->dev, "buf-size", &buf_size);
    if (ret < 0) {

The buf-size and desc-num definitions above also have no value
constraints. The driver only accepts a desc-num between
HNS_DSAF_MIN_DESC_CNT (16) and HNS_DSAF_MAX_DESC_CNT (1024).
hns_rcb_buf_size2type() only accepts a buf-size of 512, 1024, 2048 or
4096.

The old text had the two ranges swapped: "16-1024" for buf-size and
"512, 1024, 2048 or 4096" for desc-num. The conversion dropped both
ranges instead of fixing them.

Similarly, serdes-syscon isn't in the port required list, but for OF
port nodes hns_mac_get_info() does:

    if (IS_ERR_OR_NULL(syscon)) {
        dev_err(mac_cb->dev, "serdes-syscon is needed!\n");
        return -EINVAL;

The following DTs would pass dtbs_check but fail to probe:

  - buf-size = <1500> or desc-num = <0>
  - buf-size or desc-num missing
  - a port without serdes-syscon

The in-tree hip06 and hip07 DTs already set desc-num = <0x400>,
buf-size = <0x1000>, and serdes-syscon in every port. Would something
like this work?

  buf-size:
    enum: [512, 1024, 2048, 4096]
  desc-num:
    minimum: 16
    maximum: 1024

Both would then go in the top-level required list, and serdes-syscon in
the port required list.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsa@c7000000 {
> +        compatible = "hisilicon,hns-dsaf-v1";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        mode = "6port-16rss";
> +        reg = <0x0 0xc5000000 0x0 0x890000
> +               0x0 0xc7000000 0x0 0x60000>;
> +        reg-names = "ppe-base", "dsaf-base";

[Severity: Low]

Is this reg decoded as intended? The example has no parent bus node with
#address-cells = <2> and #size-cells = <2>, and dt_binding_check wraps
examples in a node with 1/1 cells. So the eight cells become four
(address, size) pairs:

    (0x0, 0xc5000000), (0x0, 0x890000), (0x0, 0xc7000000), (0x0, 0x60000)

There are only two reg-names, so ppe-base decodes as address 0x0 with
size 0xc5000000. Validation still passes because reg allows up to four
items and the reg count isn't checked against reg-names.

Also, the unit address @c7000000 doesn't match the first reg address with
either cell size. The in-tree nodes are named dsa@c5000000.

Could the example be wrapped in a bus node with 2/2 cells and renamed to
dsa@c5000000?

[ ... ]

> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> deleted file mode 100644
> index 8ee4b1cedae80..0000000000000
> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -Hisilicon DSA Fabric device controller

[ ... ]

[Severity: Low]

This file is deleted, but the ae-handle description in
hisilicon-hns-nic.txt still points to it:

Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt:
- ae-handle: accelerator engine handle for hns,
  specifies a reference to the associating hardware driver node.
  see Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt

Should this reference point to hisilicon,hns-dsaf-v1.yaml instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925215848.2949157-2-robh%40kernel.org
