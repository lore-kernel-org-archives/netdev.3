Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27C3264EE;
	Sat, 14 Mar 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508097; cv=none; b=OXsRZ0Nv7bmnoeaMGqoUezxHDrkQ23TWDRAfdYV0BBvDw13YRVL8KMACqjTffxC9RShdQr4ZRz81+/tSYPyAnsvxmM+Dx6+Xk5NnvasGVt/f8uIxg+s4P8SISz5asZvnhxnSBEIxxyqWQH0R6ZvZezHigfri1zkaOmgbmX6qM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508097; c=relaxed/simple;
	bh=RAqxzBHUF/oqZC3vNycqPMi6xdSA+hFGQgUlJnNtGG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvjVVY8SpMXi6Qu6bGeWKfYPDgygN9bzZiQCLFA4fLAevxE9OnEqoIerXt8bqA11gWv2WT1WMuObM2eUdvJDUf3YDC5QBjmw1/0ULn1Xl/N7W4WJQGejEznVUo6xErU3DoSi5r5Z41JvwLnxIfGVcTHjFs/OeIyGZ/KrXsQMbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvsLjkoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvsLjkoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D7CC116C6;
	Sat, 14 Mar 2026 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773508097;
	bh=RAqxzBHUF/oqZC3vNycqPMi6xdSA+hFGQgUlJnNtGG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvsLjkoRb5kJJJWyioU+S+bPhF4rrjH7dPMLVPEDRWMhDyUYTDJtd5TQPazXGnI1Z
	 VCvLOdrF+VWLV4xQTBmzeDq6wJXk+wzA3nbmSuP3LvIxsolPmwwyQWLhz2L9osmo0U
	 ae8AJ3WAPGFvSzIXJuhNmcUhgqlnui2NX+hMEyZSPPeEy4tb+q7esJEquufzmAALUH
	 FMVH6cUxTzBnM8zGMir/i8K1Meg6YUZYy7UUt2jL05gRylt69jLggEu086o8g4ti8A
	 vb8UnKfWOxZme5R6dlsQGiF//oHVgcMz8UV7Hk0q9RlIHoj6Ic0tpzF3Sufww6hzEQ
	 jkIyS+tDZsLwg==
Date: Sat, 14 Mar 2026 10:08:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>, Donald
 Hunter <donald.hunter@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Divya.Koppera@microchip.com, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v12 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20260314100815.6c653458@kernel.org>
In-Reply-To: <20260304094811.2779953-1-o.rempel@pengutronix.de>
References: <20260304094811.2779953-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Mar 2026 10:48:11 +0100 Oleksij Rempel wrote:
> Introduce a new document, flow_control.rst, to provide a comprehensive
> guide on Ethernet Flow Control in Linux. The guide explains how flow
> control works, how autonegotiation resolves pause capabilities, and how
> to configure it using ethtool and Netlink.
> 
> In parallel, document the pause and pause-stat attributes in the
> ethtool.yaml netlink spec. This enables the ynl tool to generate
> kernel-doc comments for the corresponding enums in the UAPI header,
> making the C interface self-documenting.
> 
> Finally, replace the legacy flow control section in phy.rst with a
> reference to the new document and add pointers in the relevant C source
> files.

We're getting no acks from the phy maintainers. With my "integrated NIC"
hat on - the description is also documenting too many details which seem
heavily inspired by the kernel-managed phy behavior. It appears that
nobody is excited for the doc to be merged in its current form :(
-- 
pw-bot: cr
