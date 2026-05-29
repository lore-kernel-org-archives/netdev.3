Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58F34B1A6
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017132; cv=none; b=E33lqfSfElWHMAfZxjcUQDNWadfhe+jAxZ9heCUxc9NDJ8NsCiyejy/X3M3KDgGL73z/tGaUDLs43COLFPjKrK0qeI6M/qw+DEH40nDnrasiSRQIZkZRL9u6lUBIQrNfULlnxSf44XSRfBH/xjmvQDJUVot8siZYKBNx6zgnKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017132; c=relaxed/simple;
	bh=UpjEPdoR8PO/VmH8InGlp2kLgNl/owG0NgTDe8FXUcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB3ZgEv+DphtUNYgae3u8vMtrTQ/7Hyg4rO5Md8WJaN2Cz3feDGQTitkX2++RVJxXmfbK7m+O+VwVC0vaxz626hJGyuHslGUaSgk1OnKY1ylUyLb9UqpouwELPaMa8EzfbVgkGmy+ASDaci8OBWTAFCWfOuK8cUe2j8SZaknufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r+gmjmSO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r+gmjmSO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PwNmho1gsKTlAE0X7shECimLhQvpaRLC55trLpCwjMM=; b=r+gmjmSOP2XTNUsyyJsVAp39Gl
	S0PJXiG+0DeWNLdsdcZuEUJ3piZyyJw/rZrX/Kt6kPi0e/SpmXGBCzG8PDRIFZLOptQ9vo0yXDWqf
	Y/l3PidozPXfpBzvJURjKKZp/9AiMra0QaEYmaWEzBhPtZq4xzGxrE14+MNPXxxnZ+LU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSllc-004zMa-66; Fri, 29 May 2026 03:12:04 +0200
Date: Fri, 29 May 2026 03:12:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next v2 2/4] net: mdio: realtek-rtl9300: use command
 runner for write_c22()
Message-ID: <499c484c-b2e6-4ea3-9ff5-a4f491e5332a@lunn.ch>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
 <20260527163449.1294961-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527163449.1294961-3-markus.stockhausen@gmx.de>

On Wed, May 27, 2026 at 06:34:47PM +0200, Markus Stockhausen wrote:
> Now that the driver has a generic command runner make use of it in the
> write_c22() path. For this.
> 
> - add generic otto_emdio_write_c22() helper that will be called by bus
> - convert otto_emdio_9300_write_c22() to new command runner logic
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
