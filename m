Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239360;
	b=GzNmvFpA75n/dWCSLJioccuANkcymc1S/cOXCXnDMzU0rh5xfurJEiqMsPeM89vtVe5y
	 O+Kjdfn8awT5plSZLr+rcHsBqCxs8xHk6W/1Nf2BTILh0XaGkqEO0kfl0eBdOsWKWxdJg
	 iD1BiJWAoDOxTKAN0/J3wyrCzIVBxrgqAva6kYPkvwBwUxqEfU7bXSha+y7NAvOQ+xSHE
	 R/XRtiY+7TxWIqAA1I1nZpbJTPEiTZU7ptem8KGyaxZq5dBmGAP/RpFfiIFGmtRcVEd5P
	 BZBtxo9iklvqJ5b8UVfSC6R8vGXpfClJKeg7dSu283n7Ov+eJyLby+Q1Sdtv8jAE6DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239360;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4cOh5ydFl01OU2B+rC207B1abgz09QduO3g9/V7orkQ=;
	b=MwkQc5eeGV4m5CeDJPjjzUjaXSq2mFNwj6oT8vkO1DxEKLEXdFo12QvOlQanLttL98+Z
	 9/KvolVbVF2ZKmSaR2MC892/dmMLqh3nirvXzRKrHH5Zdn0eX9/gr9enfz36uY2NbJnLA
	 Y5G0k+2H+Sr3AJjtx1B8kqfS+ee3qyJAeKWCrABMYXlAKFlYo5L0Q5HAuQL1kKuy9Y2Go
	 f2xTYe+kRmNDXyL6yUQG+KbTScCuOO1VkO9ZruHZnp419KPe4j7uNoZ4f8DVu/EAsF3Dz
	 SOHr3loPCWwEVh/WdbfQbqPVzFhyJTEZTMe/QX5cjmfVnKDE2tuWOxMHRFEoZjqI8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq8Ce5SY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB2606A31A;
	Thu, 29 Oct 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq8Ce5SY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F3C1F031E1;
	Thu, 29 Oct 2026 02:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239359;
	bh=4cOh5ydFl01OU2B+rC207B1abgz09QduO3g9/V7orkQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fq8Ce5SYBJjzwaICyFdWDMIxo7tyMKs3IiuFfF/drrqy2f36QwHpfb5LGFc5M3SLq
	 WGP4VeuFau7DtIAtOiwYXbT+f/g4LwD5lMmTzVTkNqWgQ1o4rhb0bS1PtD3XZqad1O
	 2/UjlkZh9jj8XH1zj7OGpEePE4Yonu9pvHfy0uzT0f4ntL33eFFk/sFYloOF+48DHq
	 Zttzg/Yxo9Scph3mYQzvHCdzgkbxId9TRft+RgqqlnytlZ3zoQ+F6g56F6n03ToSTf
	 oa0zEuY6qQcciCIzHepDlH0FPxAKuEkrkZSJDSMjKLnbBg7x1CgbWQ0elJL0J8NuTO
	 XQKwlnTD2o2JA==
Subject: Re: [PATCH v3 2/7] dt-bindings: net: dsa: mediatek,mt7530: add
 passthrough mode
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 29 Oct 2026 02:02:37 +0000
Message-ID: <179323935725.3134.9897775788252590471@kernel.org>
In-Reply-To: <20261028011317.1557238-3-cjd@cjdns.fr>
References: <20261028011317.1557238-3-cjd@cjdns.fr>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding tells DT authors to model passthrough as a two-
  switch DSA cascade ('the upstream switch is configured with a DSA link…
- [Low] The passthrough paragraph added to the description of
  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml (lines…

--

dt-bindings: net: dsa: mediatek,mt7530: add passthrough mode

This commit documents a "passthrough" mode for MT7530/MT7531 switches in
the mediatek,mt7530 binding description. In this mode the upstream switch
forwards traffic between its CPU port and a DSA link to a downstream
switch, and it does not alter the MediaTek tag.

> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 90b3582b76190..e29fb86934981 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -73,6 +73,13 @@ description: |
>  
>        Check out example 7.
>  
> +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
> +  mode. In this mode, traffic is unconditionally passed between the CPU port
> +  and the DSA port which links to a second switch. To use passthrough mode, the
> +  upstream switch is configured with a DSA link to the downstream switch. In

[Severity: Medium]
Should this also say which DSA switch index each switch has to use?

The MediaTek tag carries only a 3-bit source port and no switch ID.
mtk_tag_rcv() always looks the port up on switch index 0:

net/dsa/tag_mtk.c:mtk_tag_rcv() {
    ...
	port = (hdr & MTK_HDR_RECV_SOURCE_PORT_MASK);

	skb->dev = dsa_conduit_find_user(dev, 0, port);
	if (!skb->dev) {
		kfree_skb(skb);
		return NULL;
	}
    ...
}

dsa_conduit_find_user() only matches DSA_PORT_TYPE_USER ports on the
given switch index. In passthrough mode the upstream switch forwards the
downstream switch's tag unchanged, so port is a downstream port number.

The two switches can't share an index, because
dsa_switch_parse_member_of() returns -EEXIST for a duplicate.

Take a DT that uses the natural ordering: the CPU-facing upstream switch
at dsa,member switch index 0 and the downstream switch at index 1. Would
every received frame then be looked up on the upstream switch?

That switch has no user ports in passthrough mode. The lookup would
return NULL and the frame would be freed, so all RX traffic on the
downstream user ports would be lost.

No later patch in the series seems to change this. tag_mtk.c is
unchanged, the driver doesn't touch ds->index, and the final binding has
no passthrough example or dsa,member guidance.

Could the text say that the downstream switch must be switch index 0 in
dsa,member and the upstream switch must use a non-zero index? An example
showing this would also work.

> +  passthrough mode the upstream switch is restricted, with no other ports or
> +  switch configuration allowed.

[Severity: Low]
These topology rules are stated only in prose. Could they be encoded in
the schema as well?

Ports match ^(ethernet-)?port@[0-6]$ with additionalProperties: true.
The per-port reg and phy-mode rules apply only to ports that have an
ethernet property. Those rules are the top-level if: required:
[ ethernet ] block and the builtin-dsa-port, mt7530-dsa-port and
mt7531-dsa-port $defs.

As a result, a port with a link phandle on the upstream switch gets no
reg or phy-mode check. A node with extra user ports next to the CPU and
link ports also passes dt_binding_check.

mt753x_check_passthrough() in the driver does reject that case at probe
with "Only two ports allowed in passthrough mode". The schema does not.

The port reg description still reads:

    Port address described must be 5 or 6 for CPU port and from 0 to 5
    for user ports.

Should it mention DSA link ports too?

Later in the series, "dt-bindings: net: dsa: mediatek,mt7530: add
econet,en751221" adds mt7530-passthrough-dsa-port, which requires the
link port to be reg 6 and trgmii. That $def applies only to the
downstream econet,en751221-gswitch. The upstream econet,en751221-switch
uses builtin-dsa-port, so its link port is still unconstrained.

There is also a small wording mismatch. The commit message says:

    MT7530 switches can be configured to blindly pass packets between their

but the binding text says "The MT7530 and MT7531 switches". Could these
be made to match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028011317.1557238-1-cjd%40cjdns.fr
