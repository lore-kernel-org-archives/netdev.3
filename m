Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F32DAFDD;
	Fri,  6 Mar 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830998; cv=none; b=jjbBfIb7z3m3tTkfEd1KtzOLR/FuyFZrOt2OYTX/NDBVAuB3xg3lj0Cr7pJh7oO16bV1Q2enrgK94EIloKevp69i4LhEr3NEWyO3JXHkRWQ2qyhd2Hoa5gxOEwCLGcd/X8C9snTobNIwPrECSew9SM4Tg8Z84rbnaa2XSELVvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830998; c=relaxed/simple;
	bh=vtlMIOBOftG6rTdW7YpbwUHeofhE7VIs5ry4k7APlHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czCGiQntkk3enQmkkJIOnXXr2hUmdVt31TGhJgux0KOPlt+5VBPmCV8LcKhqwHtWGAgEzHFiiLfUJMQkQKldPxjPzDOuWcKsAitpkdCSZ73lW0u403niBgvnF2z2KyIuMRpSACw511Xzi9HsuhJ213c2zm6e8HEjBCPulADKVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+MqEJ0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+MqEJ0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61080C4CEF7;
	Fri,  6 Mar 2026 21:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772830998;
	bh=vtlMIOBOftG6rTdW7YpbwUHeofhE7VIs5ry4k7APlHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+MqEJ0suCYyViBIUgX+n/bPskTGYVFVPQigZXEzXBpmEgqYTJpIolGAtNU0A1Kf9
	 Toe7TWrylJIkM9U0xKrHZpsjfmc8KrQquvwzkKt+7QKZ9mxL1JGhqjSFJ+pYFou+TL
	 5mikVklJY1sHHU7G5NyVsQYUQyVtC5QytmqwqEmwl3I8FrR1U9DWluOPSJYLlOxLcu
	 okH9VgD8FwGp8mkKJ//bLnaoyOt3oO81SkdpPS5mEmKNWYvw93ZLMdewAAufiZqF97
	 MPFHMKjiJiFhJFi9gRj20pb6sYddmzPZIfiMFZ+RnFtCqjjcoqROx6L3PPlpIQrOYl
	 Tl5u6ldDuVmlQ==
Date: Fri, 6 Mar 2026 13:03:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jens Emil Schulz Ostergaard
 <jensemil.schulzostergaard@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <20260306130316.0159bcbb@kernel.org>
In-Reply-To: <aarjFiS6NX_7glkr@shell.armlinux.org.uk>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	<20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
	<aahWu2-3YT92vMuC@shell.armlinux.org.uk>
	<32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
	<052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
	<aarjFiS6NX_7glkr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 14:22:14 +0000 Russell King (Oracle) wrote:
> Should a regexp be added to MAINTAINERS phylib entry to detect patches
> which contain PHY_INTERFACE_MODE_RGMII?

Yes, please!
