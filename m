Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D14E324A;
	Thu, 17 Sep 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674611; cv=none; b=C8HlavVbdVazNjzLaCH4+RURbptfn9N6RwjHsZ/7x3NHTn1+Mt2I6jydiapu4XKOYv+wpNrDLFrAU4OArOdT5g8SUdK4iuf6H/QzOYDKUJwTqQjJRWPbB1OPEnep8EahFL6Bhtj5vaW5y3u+D8qFp2gkhavVnge4mWSfh9XCplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674611; c=relaxed/simple;
	bh=EOHdecQpaL/GlKIrm1Ple59SctseC42flfYo8o3xhhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGWvBm/gICGJJ0Chizlx+6G4r7O/NoEFhtldYr+/OTUIgNaYloq3jgKybXdKVaXocrElYsRitmjvj+Eh15AcpbgI0+yB+ytwMNU9pqMhUAi5N71jy5ybf0pKJsidzLBmw3UVYJaGQ4WqAOa0kedM2OWw+Sb6lCm7pBgqiSLjuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrECmR+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrECmR+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE8A1F000FF;
	Thu, 17 Sep 2026 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674609;
	bh=G0Ueg6iQdpUNa9p9nLh4vzjWRkCm6UmXBREY4j0sk+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mrECmR+lIdha3cKWAI20UARLbzlqrmStsU1mbB9l0xqH0HC1BWjbgOJ1RkXnLZnxF
	 5X1SDOU67OY5zntAv5Mb18P2FsycYaZI+kluhsiz8oKAZ39Lgc4pfKDNX2uy17RNBt
	 d1WgXVU4oKoZUM2GuPSqvut4RwbzNho5vU38AdR8EjXIiuRp4NfSmK2RjEez0pnQ+G
	 6ndqKtIUtiHQO/zVMIvkYb9FKJzFtXrbqSbb8XFb6Sq4ChFBb1WgT3MAx2TrlZvBDi
	 AWEJcLX7VZSbvk22fMcwgyfW5XZ+gqJUAMeNsDzdX4qXZZzQWql86URAymj1p6p++o
	 dAKwVt8RbrcHA==
Date: Thu, 17 Sep 2026 14:50:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: simona.toaca@nxp.com, devicetree@vger.kernel.org,
	daniel.baluta@gmail.com, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
	m-chawdhry@ti.com, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	goledhruva@gmail.com, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3] dt-bindings: net: ti,davinci-emac: Convert to DT
 schema
Message-ID: <178967460728.3473947.18194028941421372719.robh@kernel.org>
References: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>


On Tue, 01 Sep 2026 05:45:50 +0530, Bhargav Joshi wrote:
> Convert Texas Instruments DaVinci EMAC binding from text to DT schema.
> 
> Changes from the original binding:
> - Add clocks, clock-names, syscon, power-domains, and ti,hwmods
>   properties that are used in existing DTS files but were undocumented.
> - Disallow syscon and clock-names for ti,davinci-dm6467-emac since they
>   are not applicable to that SoC.
> - Allow 1-2 reg entries for DM816.
> - Make clocks a required property as driver probe fails without it.
> - Mark ti,hwmods as deprecated.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
> Changes in v3:
> - Rebase to latest mainline rc.
> - Allow 2 regs for DM816x only.
> - Link to v2: https://lore.kernel.org/r/20260818-ti-davinci-emac-v2-1-805736d99e65@gmail.com
> 
> Changes in v2:
> - Remove original text binding that was left in v1
> - Link to v1: https://lore.kernel.org/r/20260817-ti-davinci-emac-v1-1-022678d966e9@gmail.com
> ---
>  .../devicetree/bindings/net/davinci_emac.txt       |  44 -------
>  .../devicetree/bindings/net/ti,davinci-emac.yaml   | 127 +++++++++++++++++++++
>  2 files changed, 127 insertions(+), 44 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

