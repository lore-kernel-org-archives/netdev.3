Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FE3B0AD0;
	Tue, 31 Mar 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960214; cv=none; b=Ac7HaKtHkWktCax6/FdPSNQ/xwowKCPAxNH+lS/rDDcb9zs+HMZ6a3wG8PNm1uZaO25UQmcr8Jl/yrTQVxKxdw/3SVMA0LVqwG/6pPMFtis8ZBIra4Gz0LVfI1givM+EmotD/RFoIZ6qffTFbkpp89lZgHTIkuUF2qO6fwUxL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960214; c=relaxed/simple;
	bh=OQJlvwNf/qiW+LpcSodHYUethJ5VunVzGgHagnXmiXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPWN+uEv0QDUjGP/ihhzEVhBm1ulh7hJqQ0H8SCyFf6sLk7p5jw0onaxyRrUZVGv6z0df7+t9Q2adbMmOIR1HpUpN2ij95HVQkr6Qg+xDLcAi0RQ1e1Gd3PiICIcE4EneUoyKw5iTwCAkCdPuqNXRKdx8CJjai+vr/KhfljFVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a2u0lPA6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a2u0lPA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F79QCtXzXa5tHU8nSoJsDLLtDJfEeAlFOGFuiWskg7s=; b=a2u0lPA6a1owXhY222XCmt5PRQ
	HyNtmWXoyPCyg0saKK1ARbzhPtBk6HS9rJI7aw82QyycL5iIkfJf/1f436p3si7Ove07SdyngQjsP
	PflxpIrG6Ms6QGWUx9rSATQIWgXDvJ24472/z6ZKZP5oF6WPcr2h6dZ3d+2kUTc/P/ZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7YEK-00EC60-PP; Tue, 31 Mar 2026 14:30:00 +0200
Date: Tue, 31 Mar 2026 14:30:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <d4f7ac51-5c46-4104-b657-23e5c4a375f8@lunn.ch>
References: <20260330184017.766200-1-joey@tinyisr.com>
 <20260330184017.766200-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330184017.766200-5-joey@tinyisr.com>

On Mon, Mar 30, 2026 at 09:40:17PM +0300, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch.
> 
> The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
> port that is internally attached to the SoCs CPU MAC and serves as the
> CPU port.
> 
> The switch hardware has a very limited 16 entry VLAN table. Configuring
> VLANs is the only way to control switch forwarding. Currently 6 entries
> are used by tag_8021q to isolate the ports. Double tag feature is
> enabled to force the switch to append the VLAN tag even if the incoming
> packet is already tagged, this simulates VLAN-unaware functionality and
> simplifies the tagger implementation.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
