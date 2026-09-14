Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1253481AAD;
	Mon, 14 Sep 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403496; cv=none; b=pCf9WgDwgotn8ZUQOMs1SZwPZmget2/gJrVOHrlrFR/80pyRZ2zIAVtn22pxhqU3a/NBxlSE7bC9h3bqbAls1wVGUhES/pW3iJvio0j4JxZqEiTEZLoiEvPmx6OIjUuu0jrvPVMFuOrAj90tsL9RXST5VauDjIRAGl73LEwcmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403496; c=relaxed/simple;
	bh=V4GPfZQxjldVfrnQd27X7cE+nxRwoCOn2DPimlIxhn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwM3qJESl55nSAJYEGSOgwP2DKbYY87oor48QmG/NNhjWQb22y1qN4Fq3srrbEMlI9vauQdz4Yni1Mh4TcF8f85gRynPMwqgFWl94dKjlMCO+xQNYBim8becUIngRFN2L6t5KTE1SgS42JuGK6tnrMocYWmRJLxVBpfnOdEUWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OWD2mhq1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OWD2mhq1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4/H0Z+qgEWnsPBPZFg8CocJxlgnik6qpe74h8fBsyAA=; b=OWD2mhq1HfDvZgjIf9xHfWldkO
	5kUTs5YqR2fL315RjwALgJI3aqwzmsCE1bUB5Yq1uFpKrqSia1VGPRmh7+/bcSE5juB2RarCpRzPh
	IwnvfbHbRO6b8lesWaowndfVtExxumPCeTIzpB/875lhrOO57KweBSLs+7HvU+a7tnVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x69aW-00575C-Px; Mon, 14 Sep 2026 18:31:24 +0200
Date: Mon, 14 Sep 2026 18:31:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/5] net: mdio: realtek-rtl9300: reject
 duplicate MDIO bus IDs
Message-ID: <dc561b55-1705-4149-a5f6-82c81e246459@lunn.ch>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
 <20260912130451.3757276-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912130451.3757276-5-markus.stockhausen@gmx.de>

On Sat, Sep 12, 2026 at 03:04:50PM +0200, Markus Stockhausen wrote:
> The reg property identifies the hardware MDIO bus and is used as an
> index into the per-bus state. However, duplicate bus IDs are currently
> not rejected explicitly and only fail later during MDIO bus
> registration due to the duplicate bus ID.
> 
> Keep track of successfully registered buses and reject a duplicate reg
> value before allocating another bus. For this use the already existing
> but currently unused priv->bus[] property.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
