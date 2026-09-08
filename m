Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B9125A0;
	Tue,  8 Sep 2026 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827990; cv=none; b=tcDmOPBPxrympKqMzDKpm+e1sxg28dZwdt9Zty4ipYSjfhh3bzbDk601hoeogLVqlqxBF9y9set4pglPfJme35zlmFd2l74fmlp/rJJe3hdzIkPXTYSkHSItghNElo8UJd+YR/PJpxlo3av7OtVl9pA3La51Hm/iZgaoJNnlQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827990; c=relaxed/simple;
	bh=86U0Usu6XU0MUW+rLTc/SIKgQGdd0AxYC5QLhFqqm28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti+vL+kj8nfjskQ497e74EQlW8PAH42FKl8p3UpAJPzMK+EnSO38UIH1x85Pc6E1mMzAPQpwfe4eQaI0YISiGsBLCWNVXGaihtZ/7y9qeH7qtPkfPryVA4osBSnAj1WnV9XklDoK2fri5XxLcepmuFbp4TXRUx0FpGuseqQA1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PFdNGnNM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PFdNGnNM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bpidYmGTkvtlIe1UMQeLokqcOJiWTFi3w8rpLtzeeO8=; b=PFdNGnNMDb8RORz0GbYmnhQ3qe
	V4Z13z3h7mPg12mEl4sGZDNe+DOQ5L6YAzorVlUKi5W6WXO0OeyZnXl9R+YcLyJXrYhUNspwIhUuW
	fMOfRb7uysKiyx/UXpTkJTpbi2AaZX+cgoqmBvETBVvmnbOvfyjBb19o+7n4jrONSfYw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3js4-003gTV-WC; Tue, 08 Sep 2026 02:39:33 +0200
Date: Tue, 8 Sep 2026 02:39:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: mdio: realtek-rtl9300: Convert
 "fwnode" left-overs to "of"
Message-ID: <21278f92-870c-4787-b6a3-ce663089c512@lunn.ch>
References: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
 <20260906081946.3499898-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906081946.3499898-3-markus.stockhausen@gmx.de>

On Sun, Sep 06, 2026 at 10:19:45AM +0200, Markus Stockhausen wrote:
> The latest developments of the MDIO driver consistently used the
> "of" API. Convert the remaining "fwnode" left-overs too. With this
> align the continued parameter of otto_emdio_probe_one() with the
> opening parenthesis to follow the kernel coding style.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
