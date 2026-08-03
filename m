Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4D3803D0;
	Mon,  3 Aug 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774949; cv=none; b=ATDsy5dHG0/zg4We2CW3VzAxrZ9t9s6qmAAp9WukaqugeYcPxtgm69V6ONDLfhThqs/gHlllRhmybRtPIMa6DFrRbFM/BXJqWC1kbHKrDAHBErFp5ldVkkIH2owoCtHLmral+jaw2s3EWliebD4ukco0fujsuibESN/wPiBp2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774949; c=relaxed/simple;
	bh=gqfLhbK+FpyZC8QVQniFhuQROMIteEIBH5475dJBO9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlfIMpc6AysDuHPc/JiCjBMGEsFmjqiZZYdtLU2Dd9D9umPoqXtcmZ5In2RH5yJsOUqUBHDWURyLo6hIjtOh4urQR+l+0CwWO8FFMSjTHdEvfyGII/LYSXyesCNvPJiNs/qgZGU5lNNnt/IEKRuwI+h+29xpiGaaW3sZRyCnsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W71AafRZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W71AafRZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ub/U5LwyEcHsBsMTPHfibA1LuxK0rhc/UelyC7OrLCA=; b=W71AafRZlgv7HMWelHFhsMjJ/A
	hVH/yCbz/T4QFJScn4WhDYECx6yBLsVJXhaUTdPJDmuQHo/SUUOr6TKQ6S2UxcV7iYjRfkvS9ogwY
	K9iurNHQzq2ow9E7I+7jxa1oP2VcVjH5FD85c6NgFEdiqX9d6Va4VmvREQOaDpN6PYKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqvdc-00FlvB-FI; Mon, 03 Aug 2026 18:35:40 +0200
Date: Mon, 3 Aug 2026 18:35:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <604ff3d4-2a66-4086-80d3-ce838773b9ed@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <879a1366-872d-4bad-8bec-fa8a7ee82dab@lunn.ch>
 <cc7b7a56557d30be86097640a26f455d7262ff4b.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7b7a56557d30be86097640a26f455d7262ff4b.camel@linutronix.de>

> There are synthesis options for various management interfaces. MDIO and
> MMIO are two of them. I only have one variant for the memory-mapped
> version. For v2, I'll discard everything else and update the
> documentation accordingly.

Please take a look at the DSA drivers which support multiple
interfaces.

You probably want a MMIO driver which creates a regmap, and passes it
to the core driver. A future MDIO driver can create a regmap and pass
it to the core driver.

The DT binding should be similarly structured, a .yaml file for the
core, and a .yaml for the MMIO wrapper.

	Andrew
