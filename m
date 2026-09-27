Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C530E0FE;
	Sun, 27 Sep 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534729; cv=none; b=Hz14+VdsnT7sfXXpF4fqZe+yM8vBodHxde78bP/roWaxzSafDCqaNjeX6aIiddLmhJMt3sDnsaeayFQP9bLBAnHIQI7TIzkc3It6RLt/eqsPw5a0fnkhYchT+1w2NsqQeOZxuJVwGa91FPvhbEkEs9hILbe9/3NLeNEMEnVA1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534729; c=relaxed/simple;
	bh=otKpkFo3fxS9EmndeJyODqHThBhg6teG+Gs9AeIaXS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af+iePLLzJlUQsShoe3YiyWDA/u+M+kGl2sbOeKQq0pCV9AM1qn6F4RbUOFA/gMhnxDojvuud/ZeVnLY4+2u52uB62EArHuqrTLQL0/AExvTzZ1xQ5jeKlyGH8tBVO6zyF7FwDWQus6MYFGaxrKsm1GeEuvZLmxEqgUn/Kr29JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rCiSnUJ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rCiSnUJ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XOZCUtTkrG5ksbg7GHum6vxlU/QGb8FKtSPAAJz104M=; b=rCiSnUJ2wDqcA0siV9Oe9iiKYI
	c4LnjWW9IHv9TSgwZHH3Ae9tkM50pS7OsMeJKUQY+vb2yGMBePj8zqdyOddBug+P4Ir7N+US+D0sP
	D9AkkjIOu4Kg/c7FkJMVT9QMweed7vJhBBNc/RNgZgVO3jJycd5kSvheRasKBeMLBLYU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAts2-007YMh-Kf; Sun, 27 Sep 2026 20:45:06 +0200
Date: Sun, 27 Sep 2026 20:45:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v23 5/9] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <544bfdda-abdb-4fb6-a4c1-201dd8899703@lunn.ch>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
 <20260925182435.21207-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925182435.21207-6-ansuelsmth@gmail.com>

On Fri, Sep 25, 2026 at 08:24:27PM +0200, Christian Marangi wrote:
> Add support for Airoha AN8855 Internal Switch Gigabit PHY.
> 
> This is a simple PHY driver to configure and calibrate the PHY for the
> AN8855 Switch with the use of NVMEM cells.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
