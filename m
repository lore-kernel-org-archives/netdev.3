Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED763115AE;
	Wed, 16 Sep 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570215; cv=none; b=OnU7ihyE+6jXtOHVkpDGdaz//wbVl4aqCWZ9FDYGlLTkwSqvvESZzjhjwtuRDJFM+vvBX3/GnS0OZ1O2Q1zZypRI/uASPF2RxEnhLKT4Pq9hKviWcm26Uu+uUjMVeJUunnSTM6hV6IcSLh0UGVPp/ROqRxDnjPES5SQ4yM1wvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570215; c=relaxed/simple;
	bh=T5oJQRvlKGIT5Z+xpOUQyew7rmZYZtulwLyGUmPxkbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF+QsaKnKrSaa+6jTpoT2f8FsIYYxeWvohlBHte+vJxAhoE2vxP1YOetYHzbg2VqU1g5iYqU02BZ0zV2okmWNh/D9Ecw+ec+jXsdj1SyBbguHPQgHOKiIn3JJsrtGzJwptAf05gYLRMoQIhM0G4NAOtgv1rcsFQW8pL84Ahij3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2iqH+ziL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2iqH+ziL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lGQP+UWUC6IA+x0OfkhU76QWikjYeprvqcMNeO6W3jM=; b=2iqH+ziL6DOHx27n8oKGzt+bMN
	E3EvR7lKy/+6Bl/eI6pBGWSL5sVW1hmN6pKtXWiuP7C44euWLzIZZa/ow7qoDSdLAeySKEVpORbZ+
	En1TlJV7qo5Wnrck/0zJISOQ4eg7VB+Atq6WCeZ0pIswCobSGx/aKOIccymUC5i7RPyE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6qxR-005UoK-NO; Wed, 16 Sep 2026 16:49:57 +0200
Date: Wed, 16 Sep 2026 16:49:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: phy: Add Allwinner AC300
 EPHY binding
Message-ID: <dbf2768d-1c83-4524-98c4-156ce4d16bb2@lunn.ch>
References: <20260916044119.475666-1-alastair@d-silva.org>
 <20260916044119.475666-2-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916044119.475666-2-alastair@d-silva.org>

> +properties:
> +  compatible:
> +    items:
> +      - const: ethernet-phy-id0044.1400
> +      - const: allwinner,sun50i-h618-ac300-ephy

PHYs don't have compatibles which are vendor strings, only IDs or
c22/c45. PHYs get probed by ID, not these strings.

    Andrew

---
pw-bot: cr
