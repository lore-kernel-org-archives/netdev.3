Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2A3A63EF;
	Thu, 15 Oct 2026 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096486; cv=none; b=cVuuYBDbLw598kdnQ9ChYB+yvM/9Et1LV//ANyz6hP3M7kpxv0EHRmoN5auECmpmvyQef7l94NyjrLfgWSUqLN1f18AH1zzOgwD/6o7CCCr1tfLHlGRjeUIYB97cTYwNOYutmY8BJmf9tpoi6uguWwzCpXjB42iyH1mRR7ppvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096486; c=relaxed/simple;
	bh=sV2HEuvR9zQyz+Q4KvsucuhVmhv9nZsLKpq9zIz6v+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIqc97rJTP5qniRdyWtW1RQcoYsEpHBEpKOcNut/fHFE5eb6lFNKOupS5WUv6F0lZ1h3dLo2aJVxgN0skWqx8JmXvk8qmPF+PuCXzoRt9IGGfOynBMff2FM/9eu8OruH/dRPCZGamkwPbN+Yl1+Ax1DDSLc3ajihcAY9YQwIuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhi/zd5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhi/zd5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A943E1F000C5;
	Thu, 15 Oct 2026 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096483;
	bh=Iem+pLJO9ZYQDqe8VHL3AmzInyj0TGtjgP3owuH6BbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hhi/zd5WiI25MM7Uu1D5DQx+Y77A3b3pGnGm6oSq87Wvjws3mS2ZeSaNbGN5P6pIM
	 P30CkKd+hVHbPpDrHS4FBXq/Qx5aL4tkaeIE4SGeHKhDJnHRjB/I9VtyRN+w5aNd1o
	 zMrrRx+xqkHs66L3jDB+3A79nsAGkclmOExJ99bycu+sR175QNegjKKEOjZXknhDEQ
	 QAd6J7HtB06OLgTSP2eLr7hL40SNZZEItMKbAZHt5O1rBcBCLv+WyTavZu9lB0nmaw
	 Yhs0aU1S74bEFV5bae2ZeYho6lt+M0qqXKLY7/7fegw8u0kqOA4ybyJm01jg/W5q15
	 ax0acgG/OIE8g==
Date: Thu, 15 Oct 2026 15:34:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Issam Hamdi <ih@simonwunderlich.de>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Javen Xu <javen_xu@realsil.com.cn>, dam.dejean@gmail.com,
	Manuel Stocker <mensi@mensi.ch>, Eric Dumazet <edumazet@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
	Jan Hoffmann <jan@3e8.eu>, Florian Fainelli <f.fainelli@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>, Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: realtek: add RTL8224
 package binding
Message-ID: <179209648173.3102384.6472126730411571099.robh@kernel.org>
References: <20261013185635.1412452-1-oskari@lemmela.net>
 <20261013185635.1412452-2-oskari@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013185635.1412452-2-oskari@lemmela.net>


On Tue, 13 Oct 2026 21:56:34 +0300, Oskari Lemmela wrote:
> RTL8224 packages contain four PHYs at consecutive MDIO addresses and
> share configuration registers. Unaligned packages need an explicit base
> address to select the correct package registers and per-port MDI fields.
> 
> Introduce realtek,rtl8224-package so the package example selects a
> dedicated schema while child PHYs retain their Clause 45 discovery
> compatible. Validate package and child properties, document that
> unaligned layouts require a package node, and preserve support for
> existing aligned descriptions without package nodes.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../bindings/net/realtek,rtl8224-package.yaml | 332 ++++++++++++++++++
>  1 file changed, 332 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

