Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F28448391;
	Mon,  7 Sep 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772258; cv=none; b=EBXXo27uDrdIYkj8efWBqMtJlRwz9A0lb9wYieF/FYW6svGFobZRZQHZcZdDrfJUSSHjOOAVPNRBfDh7JTOCfr2bcJVqhZRMNmmyxcOhlWNGy4uOoxeexc2q2KtijYyUQyYcFZHQWn4dZdAtcl3jFdn9/wppKep5t483GK58PC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772258; c=relaxed/simple;
	bh=kD88WPjO2q8Z0rvP+M+ld9b/ip/Dnp/7Qdyt/uY1O+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKWYtno2KRTaMLvIVWU1kaXmIUlRyXLLRUB+e3sXbDNWvJgNPUWXdbNM8hi0E2aAw2lV3oPstkZPNgSt1S3jduLgHvuW+9d7kjjH1lcbZr7cAzTd66/avlKTMNV3Y4KqojDu2u+bTqEb5qpf5smMWGHvdIqDof2yUz3O3XbgBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mixHjN6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mixHjN6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB0E1F00A3A;
	Mon,  7 Sep 2026 09:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788772256;
	bh=QunEK4bJDjHKRItDHtFYdP6VKrb5WXoolVwD0wMuE5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mixHjN6Ti1Yew2y+wZItCTtCjGFWJmoBTa4FMfaQV68ilRglzrAcZfwXLwQsyH5nV
	 PAMyGsKZFeBTbcxcNgs4Q2iI0u+YoNa41pyHywl/yAZ+7wY7lIKgfLIIxXPsj+vo+G
	 d3CstSY+v7qb5s7mV5bit/lAsBqsBN1HmlTofTR1c00VsJ+9OSDUmHEf7wOn4h9xN0
	 8fAl1SkmdfdICwMeDIqEiiQ0eGyCQSmJukwWEibL2dIvMImzNFyjK0W/83Chl1ky38
	 Ao30mguWPye4Gz5ZuJRDcTC9m9zYZvtiwsQ10hIiOLUuzVoIzV3WQ/ICYXwTvHXMU3
	 nBOV59oflQFbg==
Date: Mon, 7 Sep 2026 11:10:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 0/4] net: dsa: Add SoC-e DSA driver
Message-ID: <20260907-resourceful-hissing-hummingbird-70cf8c@quoll>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>

On Thu, Sep 03, 2026 at 08:10:57PM +0200, Vasilij Strassheim wrote:
> Add support for SoC-e Ethernet switch IP cores synthesized for and
> implemented in FPGAs.
> 
> The series introduces the SoC-e vendor prefix and device tree binding,
> an EtherType-based SDSA tagger, and an initial DSA switch driver.
> 
> The driver uses a memory-mapped control interface. During probe, it
> detects the core version and the licensed and implemented port counts,
> and verifies that the synthesized core provides DSA support. Port
> counts from 1 through 31 are supported.
> 
> The initial implementation supports Ethernet switching using MII, GMII,
> RMII, and RGMII port interfaces. Offloading features are not
> implemented.
> 
> External MDIO outputs are exposed as separate logical MDIO buses sharing
> the integrated MDIO controller.
> 
> The driver was tested with a SoC-e MRS 25.01 IP core on a Xilinx ZynqMP
> platform.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
> Changes in v2:
> - Correctly use net-next prefix
> - Rework the binding into a single MMIO-based switch node
> - Model hardware MDIO outputs as separate logical MDIO buses
> - Detect the switch version, features, and port count from hardware
> - Drop incomplete STP, bridge, and FDB offloading
> - Derive phylink capabilities from each port's phy-mode
> - Harden MDIO access and SDSA receive validation
> - Address binding, naming, and coding style review comments

This is not specific enough. Every contributor can say that for every
patch...

Best regards,
Krzysztof

