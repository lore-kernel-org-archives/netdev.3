Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA3598C0A;
	Thu, 15 Oct 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096750; cv=none; b=Xz2rWp9uFPhSKwxrEnpxST2bIdWPdfbl4WMw1soBXbaichG/8d4KQlFifTz/Ev70sh10VBpAwT9hpJr+fRWqvUMSp7UI91qce592lgUpGIcMUw56HtGOrSC68pr5sUILtNwjrDMC4IIniZoZrwCGhEWDpS+7DNDvT8+/GBahLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096750; c=relaxed/simple;
	bh=gndoiN0HGGrSX8vXu1lvn7okm6dRgbzBufiibmcRMKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvrIv65qb8jNsyDw/+JJPOTp6Ua+Y/+07xX+XI2ZTinRkPKHDrnZDFjMIZJdbs4qtBhht6rPraJ2WX75rT2EzSxnyAy8XZFWJ+pkItvalkBmBfPhFNMzpadtO+IcY6igaRPfyvnn8R1hgJUhMz0uS/4O5p0UWIHpImdog/936AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQpKjQBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQpKjQBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FA71F000C4;
	Thu, 15 Oct 2026 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096742;
	bh=d62YmESqtgY8UCW/mdTw/JJnpWt2aagGW+KCVm98MR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kQpKjQByrEICicmMWr+wQGdGKMF2OggpserEgG2Y3YkxkDS+Kx8FVuhFu33Cr78W4
	 Ax0eh09IllwZT9ANuVLkPdWBh5i49beZz7SZWhkCJBqpQp3yJlLDPzb5fqE/nYF8jv
	 M48O2eFcvf69MbXCcNE936pHksotcEtR6Gi3R1N0Bn8cGqw6rS3ks7AitnqRjwSLDo
	 7w9Jk7Ew8dTSNkmpN8zOTfphsvhRBNb53cGlHQ4u9/6z8IVT9O7oooQvWnNmr+PBsE
	 Zr0Z4BiHv+HjZ6qrBbOQGvAj5g0bk2WjgOqyGhvAMjPLYvqu+Cn8WforgRIy4ZMjri
	 GXlgNugbXAVJw==
Date: Thu, 15 Oct 2026 15:39:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next v3 05/13] dt-bindings: net: dsa:
 renesas,rzn1-a5psw: Add RZ/T2H and RZ/N2H ETHSW support
Message-ID: <179209673997.3126689.17711678980732766735.robh@kernel.org>
References: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261014131906.990077-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014131906.990077-6-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Wed, 14 Oct 2026 14:18:53 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Extend the A5PSW DSA binding to cover the ETHSW variant used on newer
> Renesas RZ/T2H and RZ/N2H SoCs. ETHSW is derived from the A5PSW switch
> found on RZ/N1 but differs in register layout, clocking and interrupt
> topology, and exposes four ports in total (including the CPU/management
> port) instead of five.
> 
> Add a dedicated compatible for RZ/T2H and use it as the fallback
> compatible for RZ/N2H, since both SoCs integrate the same ETHSW IP.
> 
> Also make interrupts and interrupt-names required for all supported
> variants. The existing RZ/N1 SoC DTSI already provides both properties,
> so this change does not require updates to existing RZ/N1 device trees.
> 
> Add myself as a co-maintainer of the binding to support ongoing work on
> the ETHSW family across RZ/T2H and RZ/N2H devices.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Added a restriction to disallow port@4
> - Updated commit message
> 
> v1->v2:
> - Added full names for SoCs
> ---
>  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  | 157 +++++++++++++++---
>  1 file changed, 133 insertions(+), 24 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

