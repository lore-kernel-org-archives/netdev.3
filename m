Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704122;
	b=YeB2esthRwaPBRFFlRV9O1Ctlt7WTrEh+VMGr11cCeldYwpGvLAGazOdIqQasrpZsHMV
	 lyLbS+j7R2TZIz6slz+w6gwAs5Bbp1Z1cOwqvGbOYY3EbqCFwSy/PPs0nVuDf4CU41hbT
	 tMYbRXsj2tvOEJcchV5z7mtu0j7ICJifA3tOxYuYykPRpD2CPmlXzCM3knjdnLrs1KmM3
	 O+6L31WFupjnWv8bjI1e1B4xikrjotlqc59Lu0hWULaj0qs1+DQrJGUXrsVt1ypVKWddc
	 n+VJGRr1yWIXI/0ApkNOC3prSX7gEbBCVvyt4p+swwREbAr/CbwJS4XKCjCmpFwk9KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704122;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aYL/i0YuscUEzD0VCErR+Tz3KdHDJR7ZwPlCYlD62po=;
	b=tIWFUXM6goONnBM5M73BgbxSXVHfywKLclImN+DnZ+o+9cHpttqyvdyDJQiOtJWo15bt
	 w8vsdIT6sMp0IQsoF9Qa9vtpTxY8iaGufBZZHWloP31VYE8ruUO8ojAUv6+WMh/SvYCmI
	 A4ii49bpJVQFzVbIBFyO2BOibiCq5pN4DFbtPojNf5pOycds8DZcrmhf3wSS4F+GdS2sL
	 sjtblxipFoi4FJ4vJoP/c0j5Rd+8il5TXvxiGOw4Pwn2SYiYSJcPwVgCzlzEiFHgYFiP8
	 rnofIeuaoocwNlUy8s54flgyVpgXiWhmdqNmuIuDAziuwTtpVTYz8Z3XAUFDdNUvQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ib3z5+Md;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F4606A32E;
	Tue,  3 Nov 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ib3z5+Md
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF051F000C1;
	Tue,  3 Nov 2026 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704121;
	bh=aYL/i0YuscUEzD0VCErR+Tz3KdHDJR7ZwPlCYlD62po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ib3z5+MdhkonNdwMiArvyjWg6RnzTYHc2pP/M44kZZ+O5Vr8BoPLiJPCfQFqyxVHW
	 N1YYjgkSE9RJ5mkBYWF/Wkv2WqEyM8LwFzDLHiZyZXRwW9+lo5WtALZ12TX+bsotmk
	 VYq5I9K/9tJovZW+Gaef777aWtvI04kR29BgdVYEOhbbEhxZcAYKpr7klaqi+IlgbX
	 oVMX/g0apanLPeSaSllUbJBAuluobnHJgzD8bgoakxClpdDEdjGc+8oUhyweJURGZj
	 59hulPiSobqluqW2m8XOZyAG+/hl6V9VWBDKI/B95hDZyuLjpSuLjprzGFeSH5r4V5
	 lT7XCpm47J4/A==
Date: Tue, 3 Nov 2026 12:08:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com, daniel@makrotopia.org, 
	linux@armlinux.org.uk, arinc.unal@arinc9.com, Landen.Chao@mediatek.com, 
	dqfext@gmail.com, sean.wang@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Subject: Re: [PATCH v4 6/7] dt-bindings: net: dsa: mediatek,mt7530: add
 EcoNet EN751221 switches
Message-ID: <20261103-soft-lyrical-squid-c5a108@quoll>
References: <20261029184202.1859843-1-cjd@cjdns.fr>
 <20261029184202.1859843-7-cjd@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029184202.1859843-7-cjd@cjdns.fr>

On Thu, Oct 29, 2026 at 06:42:01PM +0000, Caleb James DeLisle wrote:
> The EcoNet EN751221 MIPS SoC integrates an MT7530 switch memory-mapped
> in the SoC register space. It is similar to the econet,en7528-switch
> except that ports 0..3 are 10/100 only, port 4 has a gigabit PHY, and
> port 5 has no PHY, but is in some implementations connected to a
> downstream MT7530 multi-chip module via a TRGMII link.
> 
> The downstream MT7530 is similar to the MT7621 multi-chip module and
> has all gigabit ports.
> 
> Add the econet,en751221-switch compatible with the same constraints as
> the other built-in switches and also add the econet,en751221-gswitch
> multi-chip-module switch whose port 6 is configured as a DSA link port.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  .../bindings/net/dsa/mediatek,mt7530.yaml     | 43 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index f98b9113ad12..011c94ef9554 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -29,6 +29,12 @@ description: |
>    and the switch registers are directly mapped into SoC's memory map rather than
>    using MDIO. The DSA driver currently doesn't support MT7620 variants.
>  
> +  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
> +  gigabit PHY. Some EN751221 chips such as EN7513G and EN7526G have a multi-chip
> +  module implementation of the MT7530 as well as the on-die switch. In these
> +  packages, the multi-chip module is connected to port 5 of the on-die switch
> +  via a TRGMII link and allows for 5 gigabit ports.
> +
>    There is only the standalone version of MT7531.
>  
>    Port 5 on MT7530 supports various configurations:
> @@ -109,6 +115,14 @@ properties:
>            Built-in switch of the EcoNet EN7528 SoC
>          const: econet,en7528-switch
>  
> +      - description:
> +          Built-in switch of EcoNet EN751221 SoC

You can drop, pointless description, repeats the compatible.

> +        const: econet,en751221-switch
> +
> +      - description:
> +          Multi-chip module gigabit MT7530 in EN751221 SoC

Keep it in one line with description. No need to inflate it even more.

> +        const: econet,en751221-gswitch

That's almost the same compatible, which makes me wonder if you describe
the same device twice. Same device, same compatible.

Best regards,
Krzysztof

