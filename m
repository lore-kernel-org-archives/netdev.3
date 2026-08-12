Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FC2E719B;
	Wed, 12 Aug 2026 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498472; cv=none; b=CM8RD5XPoHBmuFzxUvLl+wxCfElMixs6jPj4SwPgySFBHSC2QWqiGr5oEWbOCeogBB0FNLaVgvlgoLPTKjNB0ae+g1E6Ps5un/I76hoTfjgoQHoEZlWeofy3cQkY6M5a4Ug6uolQYWVh0g/Faiy/pnbo14s+MPfSA0PyXm0ESCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498472; c=relaxed/simple;
	bh=SeI9m/fxJGo+ncHiEvAY77kMvWhNF5jd1wCxH0Il0fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXKLPMBAqGQBVrjHg1aX3Mrt6X9IIIlNDRcL19SjBL8YZwb9eu0ccqlkftrtOkUJDcwOBBakenFQdsYn4DJeOz05zr7xzE5R6/flUkppZIoXbZjGiSbYmpjg5qmVaUIXmMM61qUfr+ra7XGwbj6R/6+S2dr2D4xElIGvUBtOXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebKQc6hj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebKQc6hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB31F00A3A;
	Wed, 12 Aug 2026 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498470;
	bh=+P9AFmJLuCcrDWr80X+E8AP0t/nxQRMEiXVqhr9T2/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ebKQc6hjvXbhBmahLlzlcEHg9vv34qd4YB3GFoTTr0N6n5re0e3xlukXoaTOvYgzx
	 +rZ3lgRgWi9e40ypYh0WWz5mV2p84GKpsGBUznOrPP/T0eMnL8bB6zVCopnR6qyjs1
	 GQTOM66M6oI9mxjlN6hS84zv5aisWp5KJQkqAsAw9qQydd8y57zM+S5vT8AGfKd+39
	 c3AmOdGppQRzSZBxpiELisDZ1qt646RXwln0eSfC14XCK1NEP9giChWGFMnxX5hbR6
	 LMfJwlJl19NdGUTFhvY2CjlxtXRjL3E9dgJHtWFglif0EXpz8wY5YrBCRaGnEAhLWE
	 kDOz4ohiLxX7g==
Date: Tue, 11 Aug 2026 20:34:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Liu Changjie <liucj1228@outlook.com>,
	Eric Dumazet <edumazet@google.com>, Chen-Yu Tsai <wens@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: net: Maxio PHY: add PHY-ID for -Q2C
 variant
Message-ID: <178649846890.469780.9151201106387845136.robh@kernel.org>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101452.2993721-4-andre.przywara@arm.com>


On Mon, 03 Aug 2026 12:14:49 +0200, Andre Przywara wrote:
> The Maxio MAE0621A PHY is out there in at least two variants: the
> MAE0621A-Q3C chip, with the PHY-ID 0x7b744412, and the -Q2C variant,
> identifying as 0x7b744411.
> 
> Allow both IDs to be used as the PHY compatible string, to potentially
> avoid probing, which might fail due to unavailable resources (clock).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/net/maxio,mae0621a.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

