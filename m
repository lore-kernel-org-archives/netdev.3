Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22AF223322;
	Thu, 28 May 2026 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934421; cv=none; b=Q2fA/Ri5LocARlfCa1yVORCcWis+Lm0WFLnXypv/KxcR+TI7y6fmeJAj7KnrJ9OvJDhWl/z+a7w7hB9xlAJwTdJS6A2IvES58YDfuIedNDQKswRHWYgxSCUn0XCX/G1+Ykdj4g+O4ANANV/d2gd13GRoWG11DHpkwFIaUQSTlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934421; c=relaxed/simple;
	bh=FnIIRhwHVxhf84QYbjG1naW87w4UL3JLS8AFwtzW2cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzmG5wFhK9Kmch7yMH1EFUS9zXzwu9Dzz9CClk+mqAF4ohSnAHPbhDKl32Y2cXPqmTLFWM+xUq/ycxYY0TlRNP6qLS/DHV92nq3lKDV7+y3dhC1DhmxTkrxF3M/ECemWysWmXVMrZqroOst0tHh1x/7zd1ohWoiM3X/GUoQ/7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dZnTR7Wb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dZnTR7Wb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+6hZhN0fsF8RcPZ8QWhufIy7gHA5Gi1Zrz/J4AEwbxo=; b=dZnTR7WbuolpUN1hRSzyk5dRCB
	dK0JcdzLhslSJvFq5MyRh82olom/sM6CAlxWWztjGX8LLSc0bcK3qFMTIZ8YAhhlhxJXIk9Ygwj6z
	cUR21pm56u1t5gGXp10HxrXqc9weQN/VX8+fCALo1OrofkvuOhqo4rr93mI8Yo2QnIAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSQFV-004qFX-UL; Thu, 28 May 2026 04:13:29 +0200
Date: Thu, 28 May 2026 04:13:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/10] net: ethernet: oa_tc6: Export the C45
 access functions
Message-ID: <c2463fa3-7a43-4749-946a-e96f337e7d96@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-4-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-4-37e5c8d4e0a0@analog.com>

On Wed, May 27, 2026 at 12:51:49AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The C45 access functions can still be used by some Ethernet drivers
> which set the OA_TC6_BROKEN_PHY flag. Export them.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
