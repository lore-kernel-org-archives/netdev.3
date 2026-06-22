Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA24369970;
	Mon, 22 Jun 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119298; cv=none; b=kbFPLiVXbBUF738wNKtVgQbdA5t287KTjz5YPGaTqsnsScb0SqdY6Sj/HPgVI2YSgGTRkaixESEQWAuBErTsntPR48DUfPQARbG8HbGbYVDlWLf4BCb3FoxjT27RKjR8PpKyBGKH4Jolx71LT95OfAeQPI0BxG+hPNzc+qj1gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119298; c=relaxed/simple;
	bh=eCHssKVV2pJxL1MZXNEcttSU7Bm5ic3nvRkwWPlZf5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWA6/JNroR1nolbIDLAxHYXlTC8xuoiMSRbyeEQ01kjigdl+2K/N1IRPB7K8NdVfd+tnpviPhqrohEbrdQsNdLWcV7yOZjQT62v8Y2MOBuyUv2tf8QyLEycgRltlS+aAKKouE12rKfKfkSvsVISjydCLrXYAi66gU525WCGOmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1B1K+pL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1B1K+pL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B0F1F000E9;
	Mon, 22 Jun 2026 09:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782119294;
	bh=oMLg+Sr/y5FDapu46bskmirKujQ32N1+2dZN0r1E5GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1B1K+pL0YgcSkF9lt16MUlpIGOSpE0OQoc0ejByA1kBy6EcYPpmvpPFyxXW3QQGd
	 XTS9JJ7Ilhxkl/7oE1Eqwjfm44/Lttayqjg1LGCnT0BDoXkzx5S6aqO397J7jwBfO4
	 GqtnM/kB5xJlj8Uft0y12T+3mj5j5lzy6gWaxb4noi6kk0yU4KYyLD5UBXfS1eC0dd
	 xXDtlemnG1rfWAtd5v0Bok/1PkbZua4Qwb428rve79Xe5kWLE3GKufXsY3iXa2hNuK
	 s/ugVOYZXOhO48oiuNPRFwm0dq9UIW2sKyeIihaeX5KpAap5diinMI3aL4VvntcfgD
	 5v0XqsW51cxxg==
Date: Mon, 22 Jun 2026 11:08:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: ricardo@pardini.net, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: net: add Realtek RTL8125 PCIe
 Ethernet
Message-ID: <20260622-sympathetic-inscrutable-macaque-f3bffc@quoll>
References: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
 <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-1-2bd38922d129@pardini.net>
 <876a38f8-75ea-4b32-bb65-216cb3adb436@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <876a38f8-75ea-4b32-bb65-216cb3adb436@gmail.com>

On Wed, Jun 17, 2026 at 06:43:42PM +0200, Heiner Kallweit wrote:
> On 17.06.2026 14:58, Ricardo Pardini via B4 Relay wrote:
> > From: Ricardo Pardini <ricardo@pardini.net>
> > 
> > Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
> > controller.
> > 
> > The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
> > spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
> > need a binding when used in a board DT - analogous to "usbVVVV,PPPP"

Ricardo,

No, they do not need. They are already documented, they already have a
binding, see: dtschema/schemas/pci/pci-device.yaml


> > compatibles documented in their own bindings (e.g. microchip,lan95xx)
> > so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
> > these PCI function nodes can be validated.
> > 
> > Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> > ---
> >  .../devicetree/bindings/net/realtek,rtl8125.yaml   | 43 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
> > new file mode 100644
> > index 0000000000000..eee13fbc1e6a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/realtek,rtl8125.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Realtek RTL8125 2.5 Gigabit PCIe Ethernet Controller
> > +
> > +maintainers:
> > +  - Heiner Kallweit <hkallweit1@gmail.com>
> > +
> > +description:
> > +  The Realtek RTL8125 is a 2.5GBASE-T Ethernet controller with a PCIe host
> > +  interface.
> > +
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: pci10ec,8125
> 
> IIRC we came to the conclusion that the compatible string isn't used in the
> relevant code path. Then why add it here? Is there an alignment on this?

Heiner, it is used - in the DTS.

> If it should be added here, then an explaining comment would be helpful.

Commit msg should explain that.  The compatible is used, so it
must be documented and in fact already is, so you need to specify them
ONLY if device nodes have some other properties, like being an ethernet
controller.

I assume that this is the case here, although that should be mentioned
in the commit msg.

Best regards,
Krzysztof

