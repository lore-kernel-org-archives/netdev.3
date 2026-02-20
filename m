Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867663469F5;
	Fri, 20 Feb 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593227; cv=none; b=oBa/pnobhcEoN9V8rdwkKcb0wuxzl9bjWm6dceT2LHMPj63XL4BFBo43tpnUR/KBQLeje4zb97CgHbLMXK7D1MqGtt33Zc9ptCvLhAT1JJ/QnvexMnR07rDhfaKby9RaTd0n/ZfceElDm0PNT3XGD01TqBMaknPJn8k4LUt5rfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593227; c=relaxed/simple;
	bh=yJXCHZVeM+0E7vosFIV4IAwQF0MV0rsZqJp0HABhWu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD7XRNDcajRWW3obFutl26OHmH4wao7IIoxYpdCCK8b58d0mi3nhDba/GwOnviOK9nqQiKaV/v3uelYAtsHa9acQnGjXNMXJ02wNkhZwNJkm1J8/vTXSgGfd1CsoQBu1R8CeS0pM6zkRodcgH26etmDNvJHj1sxnDsVGk5AMGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0CuWvvNp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0CuWvvNp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=63PZ5ikUAAIUS3H+LncoEFZzYKIrjKtt3if4XIt6msc=; b=0CuWvvNpbCYIP7ytGRFlaGjNy9
	7Li+Do5DI9p9LJ1rh9vWN7+ON6VDwnZ8sV6WUOk2CQ1jgRULJlNFRmLgtQxcJVHUXY0LGqU9+u3oo
	/0tEbSMWJ+xOaBkGWDBhHukhLN2/awYRgH+eDEl6t8hYK5DjyOiBqBcpClVQQYEZkp9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtQK5-0084O8-IN; Fri, 20 Feb 2026 14:13:33 +0100
Date: Fri, 20 Feb 2026 14:13:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Max Hsu <max.hsu@sifive.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 3/5] net: macb: Add support for SiFive FU740-C000
Message-ID: <45821cd4-214c-43c0-ab2d-bbf34d9ec911@lunn.ch>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
 <20260220-fu740-v1-3-c8af54130c58@sifive.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-fu740-v1-3-c8af54130c58@sifive.com>

On Fri, Feb 20, 2026 at 04:27:07PM +0800, Max Hsu wrote:
> Add a distinct configuration for the SiFive FU740-C000 ethernet
> controller to comply with the SiFive IP versioning guidelines.

We are in the merge window at the moment, so net-next is closed.

As requested, please reword the commit messages to replace the SiFive
guidelines with the generic DT guidelines. And repost when net-next
reopens.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject line also needs to indicate which tree this is for.

    Andrew

---
pw-bot: cr
