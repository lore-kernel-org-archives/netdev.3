Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9134119F4;
	Wed,  7 Oct 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377950; cv=none; b=eTRFaPv3alse+ITMLay8hGAWQV8klQYdm3RFnR+entKFdNlRcPZ/24YuDy7NFckOvS5HZinvkPnUzD2wo0tVRW8JWs7J5s+yHzWu2c0+yjb7W1qMK4g/zsaIk5CInRFiBh90QsaNm6GE2o2yI4AfSct+uRG7HdZCJJR2UkWqvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377950; c=relaxed/simple;
	bh=+kkXSvARqBuIPk51iikd65Qr/EZXshestNAOYzM8V24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llf3pqW0/K6/KGtVQD/Au+UyveDPSdwGigrVYWfaGl1PbG6TA4eSW+RVauVtvx1CTQ7YpOM8HXnHybSZcrHvl9Vg/tE5WeOenQ+3LhEExJkvKbvoKXC3buv2ZsP7wIJj6p2cn/3UReztnaJXNyeOHWGq8fYZOfx0FvZ4TLRJZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GgeYpCqx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GgeYpCqx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T3camnU/lQ0FiLPLT54GfqCHA8eBvYKjiIgqqnJuiMM=; b=GgeYpCqx6vVbAicUTaq+SmGAet
	CFUrMHMusDYreTpleL9EiZHXIHHb2GYU67zocRi/EvjcrpzLcC3w56wut6arqEW1GBNwfFsOZXD5T
	6mv9OlTP8DokfBtlohEtmjtXl+eRjI4u7PM71d+HnVQ1oT8o5/6bqnfGLloIqTOHOdh4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEREJ-009SWB-TM; Wed, 07 Oct 2026 14:58:43 +0200
Date: Wed, 7 Oct 2026 14:58:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] net: stmmac: dwmac-meson8b: let the
 controller apply the RGMII delays
Message-ID: <ecd9cfed-10b2-4e82-a67e-3d4c49579058@lunn.ch>
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-2-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007082627.63807-2-tanure@linux.com>

On Wed, Oct 07, 2026 at 09:26:21AM +0100, Lucas Tanure wrote:
> RGMII needs a delay on each of its two clocks. A board can get it from
> the length of its tracks, from the PHY, or from the controller.
> "rgmii-id" in the device tree says the delay is added inside the chips
> but not which chip adds it, and the generic tx-internal-delay-ps and
> rx-internal-delay-ps properties name the controller.
> 
> This driver ignored those properties. In the "-id" modes it switched
> its own delays off and left the whole job to the PHY, so a board that
> asks the controller for one of them does not get it, and a board whose
> PHY cannot supply that delay has no usable link at all.

Linux currently has no PHY device which cannot add delays. So this is
pretty much a non issue.

       Andrew
