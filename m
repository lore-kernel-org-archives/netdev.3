Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413647255B
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367257; cv=pass; b=Z7xnPt4kyGAJuYRL6KRKNYvGDvS/dgbEAa83wwPjvgK4qnAbjxQUU7IrDCOnrG5io1TCg0it+Q5fK3R/vqAagL2fGlHevDcCh3ZL8O5dpY+8U/TDn3ZoHW+qKOpYr5hzbPo+ZpDdFukg1GvsrXrB3AQmIHejS9K74uqu1isQx8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367257; c=relaxed/simple;
	bh=XjU0hXtNcJGjUwPx9iC1DYv0ec/khzfjn6lTjTcCAAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgQ3zUrbTKTVSEWYD1VOoy8HnajRDClCHGR9FMoD6agZM9tGRf4JN+PosYo03mvSNslHTkiaF1oSbDrBn6El2upL5Wmb4D2iGzHZF7WkhOmtlVpKz25WKTeAISqwmaZaw3nSqbLc4cDFTq9bt2uoCNbQhbJhFK0TlzknL9sZkUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmXeuwVm; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmXeuwVm"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c2e22754212so206829366b.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791367245; cv=none;
        d=google.com; s=arc-20260327;
        b=iPcKUnyJRvaWWvVcQG/7m8FzciD3lls2jZ72TmFFgzln66Rbts+wEQk6gB/UXZXPMW
         6uE7NTiTzRUUTMryM+gtz878kJ0FR5XPqAV2Dmv8dEaspd7FP5Fh/0mLtC5Fvn6CsxDt
         In/gmkafjH3vAWZuiNLP0cB83uJQC1qwQEBirYnWHIaRWYtB//gxFv0JwQFzkIrzs/0p
         LCCWyOecXkutLrZa/NzbwacM7hdKa1CihcsEL7MFMRWB7TBRwDHmWG2v4zw0P+zO+rgj
         CoYhHEbNxN2cuN9/HCK2nHalw3r1aUjbcEcGEGddMtkQyrakQncKQiT2Up673RY5o752
         ihIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WrNkpb0d4qtNovZAgW6O0CMNn2hpdnuON/KzQGIiKiQ=;
        fh=6X2YZaqI0erQxmEaXfZWc3Lll0qfEBinfyL+65nW6Lg=;
        b=Vfsc09LUA/2AZ8JfepybfulWFKtDJ+uEsWz/XbqSSud5MfbjE2GtNis481GxOYWCQF
         ZzsXG1YsqP0I4AEmMB6ML6gsZd17AO0AVDBhm3lO0P8G0fNuEm36mMixN6+TlSD2+oUV
         0Yc+h6xye1IUo7VUmY1wOd8Yt7UgzVWko8+MEyIRk0ejp2FF/uziYX1A08G4AH4Pk/Bm
         p80K+ej9FwQkNsJhd0cocPMCqy8DutKSqjyDoG2FS5jw+YscZRCDTjaXr7BTBbQug6q8
         x2P5DSS/VU4TF/mNtts2yddTqvniSv7tEpNIt43zLz5oyCYrm6eY6r/KiJ5KXh+OvBiI
         2Apw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791367245; x=1791972045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WrNkpb0d4qtNovZAgW6O0CMNn2hpdnuON/KzQGIiKiQ=;
        b=CmXeuwVmSFDuDcs9vky2qwqsK5i0LnOOUUIPI9JdSoflykHhzY07iZvqagsFZPwQJf
         9YkXTL2SERoue7SmpoPzj2AAKcWKp2vbrJaDxKmRgZAEMEdWM6vH1hN8uuaJ1Hq+MFoM
         mqA4xoWgBq5Mm1gJOvPldVZxARLZQdd3/OqHQaqWuvOdcjN39R+iAJSvPDPrBs17i96g
         WrQrY02D9MjwpfC3/ZetbA+XhHNsXp/UQX4qvM9G1995fPYXBVUqcx3r029urA6LgkCq
         K87GAC3nB+48llKqfGIJnHryaBhsMaxMVvobqF+4zEUcgrTVYNjEq/yJ2JmQpYPN8WLz
         DW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791367245; x=1791972045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrNkpb0d4qtNovZAgW6O0CMNn2hpdnuON/KzQGIiKiQ=;
        b=UfHJFt+xKzFYVFzkVqDeaJ5bNdjsgG4mKa5B2WwP5QVi0Y+FggoLLMcc+W5+NPITYP
         9aKjf9G+x+nIxv6afEtQkiXCNmkX/xEMRoKWiHBZlLzkQO+LqVBFIZendXQvKLhk0laK
         /tQQURhKItapVMOvtxdnXdMTcBMrI9YDT5hfE9E9ay+xageVK5ZiQ3BmBrVvzeQAhxfa
         slK1GrPqKqRvkzswmF2OimLxJJwGza/hj89MwSEnl5eeluYmwmb8FAtaTFbdxruo2XYc
         ItXrrSmSNGyFS4iD7xkdWHe3BrGBxNx2zxoIIClhjGE5wAL6td6F+QEDv92OtiFztDAE
         2NOg==
X-Forwarded-Encrypted: i=1; AKwUvByJM/cb4EzqKuUu9kNKraLeGVSpQmy6T/GOlHLQ8dtHSvVHeaoQ3Kddxnrp2DH5bnZdAahTcTM=@vger.kernel.org
X-Gm-Message-State: AFuF++koUdDTf2yTUU0HazPcPuUnhQMu3LNHvyok/DEQD3GXKUyVoZ7v
	IPtT4CP1ZjHxgEbI13laSwggguKhjwKY1iwZc7ZRGDfo0nLXfJluftpjErC0E9nxwcF3VtRGaL4
	DtLFDGvpb5yolDE7Uq3dumqOROcEWkIc=
X-Gm-Gg: AYBFou2tN0K/dnpNi8fKJUkv61toh7Wa4NhmBdv0BEslSoqo7wc4FpSGPPl6ZS7LuoP
	o/T8ocaZl3qfshf0ap9jYav5hv+JVZYqB0gfQy49iMzniqfsXsP/ZiAqoeWfGSJc3toIO1Qq7+S
	q36FmwCbdDqHCSIFiu/y8tNdOXVZRxRFSr7B0D6PtAICY3AiPNTe80menhxbQ668qfkfiZTyT1x
	UglJiSUTCAf3M5lHnsqWGMpYbrZyteYsx0HP/vjcwdL7JWANJknlAGqS8ru9ba0vgxwrBs3ibtC
	sk49iqQOzH+KBvagq+6ZjXwHnpJiLUsJLQ6XKuEF4aBTV8/m5TNYlon/lg==
X-Received: by 2002:a17:907:968f:b0:c31:5c2b:9e4b with SMTP id
 a640c23a62f3a-c317bd913e3mr171417966b.9.1791367244345; Wed, 07 Oct 2026
 03:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005223011.1124347-1-coiaprant@gmail.com> <20261005223011.1124347-2-coiaprant@gmail.com>
 <20261006132428.GA1659963-robh@kernel.org> <96FA84EA-3C0E-4FAC-963F-2A8165538748@gmail.com>
 <20261006150831.GC2194299-robh@kernel.org> <46337722-9C86-4118-8286-A506B455B23D@gmail.com>
In-Reply-To: <46337722-9C86-4118-8286-A506B455B23D@gmail.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 7 Oct 2026 18:00:32 +0800
X-Gm-Features: AclHuK8fvALioIp_2ZDF3ZkGQsmcOc_f0Q9lbyHaYtZVARGtB6mcLM_NG_T3Tgk
Message-ID: <CALj3r0ihUKOtn4dE4=UJQG1qZbdE7EEZ76it-17N36gFHDSrzg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/6] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
To: Rob Herring <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Coia Prant <coiaprant@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C 23:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On October 6, 2026 11:08:31 PM GMT+08:00, Rob Herring <robh@kernel.org> w=
rote:
> >On Tue, Oct 06, 2026 at 09:59:49PM +0800, Coia Prant wrote:
> >> On October 6, 2026 9:24:28 PM GMT+08:00, Rob Herring <robh@kernel.org>=
 wrote:
> >> >On Tue, Oct 06, 2026 at 06:30:03AM +0800, Coia Prant wrote:
> >> >> Add device tree binding documentation for the Synopsys DesignWare
> >> >> XPCS integrated on the Rockchip RK3568 SoC.
> >> >>
> >> >> The XPCS is accessed over the APB3 bus and internally connected to
> >> >> a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
> >> >> QSGMII modes, with four MII ports.
> >> >>
> >> >> The four MII ports are described as ethernet-pcs-mii@N child nodes,
> >> >> consumed by the Rockchip XPCS glue driver later in this series.
> >> >>
> >> >> phys and phy-names are required because dtbs_check only validates
> >> >> required properties for enabled nodes. The SerDes link is a board-l=
evel
> >> >> design choice (combphy1 on some boards, combphy2 on others), so the=
se
> >> >> properties must be provided by the board device tree, not the SoC d=
tsi.
> >> >>
> >> >> The CRU reset lines (SRST_XPCS*) are intentionally not described: n=
o
> >> >> in-tree user requests them, and bring-up relies on the PD_PIPE powe=
r
> >> >> domain, the SerDes PHY and the in-IP soft reset. They can be added
> >> >> later as optional without breaking ABI.
> >> >>
> >> >> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> >> >> ---
> >> >>  .../net/pcs/rockchip,rk3568-xpcs.yaml         | 110 ++++++++++++++=
++++
> >> >>  1 file changed, 110 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/net/pcs/rockc=
hip,rk3568-xpcs.yaml
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3=
568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-x=
pcs.yaml
> >> >> new file mode 100644
> >> >> index 0000000000000..703fcff0e3f70
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpc=
s.yaml
> >> >> @@ -0,0 +1,110 @@
> >> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> >> +%YAML 1.2
> >> >> +---
> >> >> +$id: http://devicetree.org/schemas/net/pcs/rockchip,rk3568-xpcs.ya=
ml#
> >> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> >> +
> >> >> +title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
> >> >> +
> >> >> +maintainers:
> >> >> +  - Coia Prant <coiaprant@gmail.com>
> >> >> +
> >> >> +description: |
> >> >> +  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Ph=
ysical
> >> >> +  Coding Sublayer (XPCS).
> >> >> +  The PCS provides an interface between the Media Access Control (=
MAC)
> >> >> +  and the Physical Medium Attachment (PMA) sublayer through a Medi=
a
> >> >> +  Independent Interface (GMII).
> >> >> +
> >> >> +  The XPCS is accessed over the APB3 bus and internally connected =
to a
> >> >> +  Naneng Combo SerDes PHY.
> >> >> +  It supports 1000BASE-X, SGMII and QSGMII modes.
> >> >> +
> >> >> +  The block contains four MII ports that can be individually enabl=
ed and
> >> >> +  routed to one of the Ethernet GMAC controllers via the pcs-handl=
e
> >> >> +  property in the MAC device tree node.
> >> >> +
> >> >> +properties:
> >> >> +  compatible:
> >> >> +    const: rockchip,rk3568-xpcs
> >> >> +
> >> >> +  reg:
> >> >> +    maxItems: 1
> >> >> +
> >> >> +  "#address-cells":
> >> >> +    const: 1
> >> >> +
> >> >> +  "#size-cells":
> >> >> +    const: 0
> >> >> +
> >> >> +  clocks:
> >> >> +    items:
> >> >> +      - description: APB3 bus interface clock (clk_csr_i), require=
d for register access
> >> >> +      - description: EEE clock (clk_eee_i), required for Energy Ef=
ficient Ethernet operation
> >> >> +
> >> >> +  clock-names:
> >> >> +    items:
> >> >> +      - const: csr
> >> >> +      - const: eee
> >> >> +
> >> >> +  phys:
> >> >> +    maxItems: 1
> >> >> +
> >> >> +  phy-names:
> >> >> +    const: serdes
> >> >
> >> >You don't really need phy-names if there is only 1 entry.
> >> >
> >> >> +
> >> >> +  power-domains:
> >> >> +    maxItems: 1
> >> >> +
> >> >> +patternProperties:
> >> >> +  "^ethernet-pcs-mii@[0-3]$":
> >> >> +    type: object
> >> >> +    description:
> >> >> +      One of the four MII ports of the XPCS. The port is linked to=
 an
> >> >> +      Ethernet MAC controller via the pcs-handle property in the M=
AC's
> >> >> +      device tree node.
> >> >> +
> >> >> +    properties:
> >> >> +      reg:
> >> >> +        description: MII port number.
> >> >> +        enum: [0, 1, 2, 3]
> >> >> +
> >> >> +    required:
> >> >> +      - reg
> >> >
> >> >Why the child nodes? They don't contain anything.
> >> >
> >> >Perhaps that's due to pcs-handle not supporting arg cells to pass the
> >> >port number? That's about to change[1].
> >> >
> >> >Rob
> >> >
> >> >[1] https://github.com/devicetree-org/dt-schema/pull/198
> >>
> >> Hi Rob,
> >>
> >> Both points make sense.
> >>
> >> 1. I'll drop phy-names since there's only a single entry.
> >>
> >> 2. For the ethernet-pcs-mii child nodes: you're right that they only
> >>    contain 'reg'. The reason I used child nodes is because pcs-handle
> >>    arg cells are not available yet -- PR #198 is still open and in
> >>    RFC/change-request state.
> >>
> >>    The RZN1 MII converter binding does the same thing: it declares
> >>    MII ports as subnodes and references the PCS via pcs-handle, until
> >>    arg cells land.
> >>
> >>    So I'd like to keep the child nodes as a temporary workaround, and
> >>    I'll add a note in the binding that this can be simplified once
> >>    PR #198 is merged.
> >
> >Bindings are an ABI. You can't merge the binding then change it. Please
> >comment on the PR that you all need it.
> >
> >Rob
>
> Hi Rob,
>
> Understood on the ABI point, and I don't want to merge a binding we'd
> have to change later.
>
> Could I ask for your guidance on the practical path? This series is
> ready, and I'd like to get it into 7.4 if possible, since OpenWrt and
> other distros base their support on LTS kernels. Missing this window
> means a long wait for users.
>
> Given PR #198 is still open, I see these options:
>
> 1. Wait for PR #198, then use pcs-handle =3D <&xpcs 0>. My concern is tha=
t
>    I have no visibility into its timeline -- it could be weeks or much
>    longer -- and holding the whole binding on that is hard to plan
>    around.
>
> 2. Keep the child nodes as the final ABI, RZ/N1 style, no planned
>    migration.
>
> 3. Something else you'd prefer.
>
> Which would you recommend? If waiting is the right call, I'll do that,
> but I'd like to understand roughly how long PR #198 is expected to take.
>
> Thanks,
> Coia

Hi Rob,

Thanks for the feedback. I went back to the Rockchip OEM SDK to check how
this is actually wired up, and it confirms the MII port is not an
independent board-level configuration -- it follows the MAC the SGMII
link is routed to (GMAC0 -> port 0, GMAC1 -> port 1).

So I've dropped the ethernet-pcs-mii child nodes and the phy-names
property, and the glue driver now derives the MII port from the MAC id.
The binding no longer needs pcs-handle argument cells, so we don't have
to wait for PR #198.

I'll post the updated series on the 9th.

Thanks,
Coia
