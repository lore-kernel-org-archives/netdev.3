Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EF13CF82;
	Sun,  4 Oct 2026 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152140; cv=none; b=DFRG3wjliT3cXeZEhR32NYIU4fv5Zd3HisoApQnQtIvpmmmiKQoOPznsQXnZgqVi3U6GMp8m3frDxzf1gEfSoT41hx8b4sp2I3rKncV6tFBIqUHFsX2L+pIix0IUVyQKKXtm7jt1dPR8Jup/f3eg69FxprBPV6FsThHT/zSD4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152140; c=relaxed/simple;
	bh=35EEexwvsk1l3odmqC/OL5FDZhrSDKxD/d3/MbCWehU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gm52O+WbZ+Qg0Emu+U/88c3FuQv5k+Vuew5KuR4oXjrOUtEFh5kWLzFCOGCCD6i+T5N5Za3xTfw9+aTStia4onZNmyRIJ1ggQqK0ifyHCztXGdx3sep3R0NYHdXYqEZ9KDxzaE183y2hgmzuiW+BWQFOs14EozWoiGoqrigF9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqb4EH1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqb4EH1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFC21F000FF;
	Sun,  4 Oct 2026 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791152139;
	bh=Szuc6VYTZ1Mhv2sQBIokhfD9CAHddVmZ2m3utthK21E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dqb4EH1ahv2Dq+gRsg3RLQ08KQC4ndjU1TkT9qHR3Y6rjT+EWEX09OGVkzqBlqc2C
	 kGVakqrl3bFhNJNhesh//cylIX1vMTNKxKbU4I4KcnH4J934jQa/YmxS+KMo2/6cm8
	 yeI5ujrWCNuD/MENgjz6vUJx2RUGue+Yd8NhzzaGAad8464IuiRQ0njIwZA7nHyHrW
	 BVzxhmZ+DnnHi2pUGkLH6/EzEquFIvHtk9U7Utzst2xRKcxvtpdSUfle8O0DkvcahE
	 9cEStjUYy8g1jXNp1AYTt1CbSQVeJ7tuojplBT8C864QlVHNLJ301XKLniqHCYLKd6
	 s6i7XlQftRsRg==
Subject: Re: [PATCH net-next v2] dt-bindings: net: Convert HiSilicon hns-dsaf
 to DT schema
From: netdev-bot+sashiko@kernel.org
To: robh@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 22:15:37 +0000
Message-ID: <179115213771.434549.6434616017051204695@kernel.org>
In-Reply-To: <20260930201919.76465-2-robh@kernel.org>
References: <20260930201919.76465-2-robh@kernel.org>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The conversion drops the two leading legacy 'reg' regions
  (sub-control and SerDes) that the old binding documented as the…
- [Medium] The top-level 'required' list in hisilicon,hns-dsaf-v1.yaml
  leaves out 'desc-num' and 'buf-size', although the deleted text…
- [Low] The patch deletes
  Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt, but…
- [Low] The deleted text binding had the buf-size and desc-num ranges
  swapped ('buf-size: ... should be 16-1024', 'desc-num: ... should be…
- [Low] The concern says that 'mc-mac-mask' with only 'maxItems: 6'
  accepts 1–5 bytes, while hns_mac_get_info() needs exactly ETH_ALEN (6)…
- [Low] reg and reg-names use 'minItems: 1' for every 'mode'.

--

dt-bindings: net: Convert HiSilicon hns-dsaf to DT schema

This commit converts the HiSilicon hns-dsaf text binding to a YAML DT
schema. It drops the unused top-level phy-handle property and documents
the previously undocumented media-type port property.

> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
> new file mode 100644
> index 0000000000000..36251b45abeb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml

[ ... ]

> +  reg:
> +    minItems: 1
> +    items:
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

[Severity: Low]
minItems: 1 applies to every mode here. Would the schema accept a node
with mode = "6port-16rss" and only reg-names = "ppe-base"?

The description says dsaf-base may only be left out in single-port mode.
hns_dsaf_get_cfg() skips it only when HNS_DSAF_IS_DEBUG() is true, which
means dsaf_mode == DSAF_MODE_DISABLE_SP:

	if (!HNS_DSAF_IS_DEBUG(dsaf_dev)) {
		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
						   "dsaf-base");
		if (!res) {
			res = platform_get_resource(pdev, IORESOURCE_MEM,
						    res_idx);
			...
		}
		dsaf_dev->io_base = devm_ioremap_resource(&pdev->dev, res);

When subctrl-syscon is used, res_idx is still 0 at this point. The
fallback therefore picks the ppe-base region again, and
devm_ioremap_resource() fails with -EBUSY.

Could an if/then on mode require two reg and reg-names entries for
2port-64vf, 6port-16rss and 6port-16vf?

[ ... ]

> +  buf-size:
> +    description: RX buffer size (bytes)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [512, 1024, 2048, 4096]
> +
> +  desc-num:
> +    description: number of descriptors in TX and RX queue
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 16
> +    maximum: 1024

[Severity: Low]
This isn't a bug, but these ranges are the reverse of what the deleted
text binding said:

- buf-size: rx buffer size, should be 16-1024.
- desc-num: number of description in TX and RX queue, should be 512, 1024, 2048 or 4096.

The new constraints match the driver. hns_dsaf_get_cfg() checks desc-num
against HNS_DSAF_MIN_DESC_CNT and HNS_DSAF_MAX_DESC_CNT, and it checks
buf-size through hns_rcb_buf_size2type().

The only related note is "Add constraints for buf-size and desc-num" in
the v2 changelog, and that text is dropped when the patch is applied.
Could the commit message say that the old text had these ranges swapped?

[ ... ]

> +      mc-mac-mask:
> +        description: multicast MAC address mask
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +        maxItems: 6

[Severity: Low]
hns_mac_get_info() needs exactly ETH_ALEN bytes for this property. With
any other length it falls back to the broadcast mask:

	if (fwnode_property_read_u8_array(mac_cb->fw_port, "mc-mac-mask",
					  mac_cb->mc_mask, ETH_ALEN)) {
		dev_warn(mac_cb->dev,
			 "no mc-mac-mask property, set to default value.\n");
		eth_broadcast_addr(mac_cb->mc_mask);
	}

Does maxItems: 6 on its own reject a mask shorter than 6 bytes? If the
dtschema fixups set minItems equal to maxItems here, this is already
fine. If they don't, is an explicit minItems: 6 needed?

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - mode

[Severity: Medium]
Should subctrl-syscon be in this list now?

The old binding allowed two leading reg regions, for sub-control and
SerDes, as an alternative to subctrl-syscon. This conversion drops those
regions, so reg can now only describe ppe-base and dsaf-base.

The OF path in hns_dsaf_get_cfg() still uses the old layout when the
phandle is missing:

	np_temp = of_parse_phandle(np, "subctrl-syscon", 0);
	syscon = syscon_node_to_regmap(np_temp);
	of_node_put(np_temp);
	if (IS_ERR_OR_NULL(syscon)) {
		res = platform_get_resource(pdev, IORESOURCE_MEM,
					    res_idx++);
		...
		dsaf_dev->sc_base = devm_ioremap_resource(&pdev->dev,
							  res);
		...
		res = platform_get_resource(pdev, IORESOURCE_MEM,
					    res_idx++);
		...
		dsaf_dev->sds_base = devm_ioremap_resource(&pdev->dev,
							   res);

Under the new schema reg[0] is ppe-base, so the lookup by name that
follows requests the same region a second time:

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ppe-base");
	...
	dsaf_dev->ppe_base = devm_ioremap_resource(&pdev->dev, res);

That call fails with -EBUSY. In single-port mode, where only ppe-base is
present, probe fails even earlier with "serdes-ctrl info is needed!".

So a node without subctrl-syscon passes dt_binding_check but can never
probe. The in-tree hip06 and hip07 dtsi files already set
subctrl-syscon, so requiring it would not break them.

Also, the narrowing of reg appears only in the v2 changelog ("Drop
erroneous 1st 2 'reg' entries") and not in the commit body. Could the
body mention it, as it does for the phy-handle and media-type changes?

[Severity: Medium]
The deleted text binding listed buf-size and desc-num under "Required
properties". hns_dsaf_get_cfg() fails probe if either one is missing:

	ret = device_property_read_u32(dsaf_dev->dev, "desc-num", &desc_num);
	if (ret < 0 || desc_num < HNS_DSAF_MIN_DESC_CNT ||
	    desc_num > HNS_DSAF_MAX_DESC_CNT) {
		...
		return -EINVAL;
	}
	...
	ret = device_property_read_u32(dsaf_dev->dev, "buf-size", &buf_size);
	if (ret < 0) {
		...
		return ret;
	}

Should desc-num and buf-size be added to this list as well?

[ ... ]

> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> deleted file mode 100644
> index 8ee4b1cedae80..0000000000000
> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> +++ /dev/null

[Severity: Low]
The ae-handle description in
Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt still points
to this file:

- ae-handle: accelerator engine handle for hns,
  specifies a reference to the associating hardware driver node.
  see Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt

Should it point to hisilicon,hns-dsaf-v1.yaml instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930201919.76465-2-robh%40kernel.org
