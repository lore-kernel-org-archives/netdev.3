Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610F35DA55;
	Tue,  4 Aug 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848107; cv=none; b=u/fhlpXYhFhW6GDd4FVCTE74N+cEDg46D34lhocf96DL97I8HGFO/LDWc3y/SEf3UXUIanvUj3nv90Ttr2aTU7Yk8tPDLxTHx/B5h4NiS9hwrr8sbEiHwG5srzNm4aHrrrCazxMtFVr8UqmAPVrrt/hfbQQqqJWk+kZeqHQgJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848107; c=relaxed/simple;
	bh=v9uZf/K4UlFQAcjvYXyGRvHzQHuBM1nW2X87AA4JBV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSIYK2f3QYrVtyHTP+udGn0q4it7QBfGB6kyDH71RdG+wuwjrZG2PBxOxSepPlh9GEJ+abCSv9KbgC+yYBTKAW+IkqTGVLkhh+qquyVrnHAKNHrXfFO3A0HypstgzW2BzQPVS7LcPI9TeQnrkEbv/4z3+trxVPN1pxPCnrvggRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6Cn1pAy0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Cn1pAy0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HKFoSc4WyjuzV3/KLrCz1zhVhYsYspAY5SPlxV8GVgk=; b=6Cn1pAy0rPFo/yJpQ9BOc/aCmx
	K+MMUgTqo4AfbyD64CznVJTTiVtUeidb0dVA1BubShVzybhawuk6bwjECm0SKkUZvQy6CJIg9x9LZ
	5hWo9FIMHfGgN/Gnb5cVD42A4cAvf52dOTjKT91Ns9kFbF2P/RIsf9g4Gtokj2G+9nZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrEfV-00FzLN-E0; Tue, 04 Aug 2026 14:54:53 +0200
Date: Tue, 4 Aug 2026 14:54:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: mdio: support dynamic OF device
 changes
Message-ID: <c6f001d6-b9db-4434-8468-4705d62ffdbb@lunn.ch>
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
 <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch>
 <CADvTj4o+B933k4TUshgcvZ4tENDbit3fHEBtwy5ODpsf60osyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4o+B933k4TUshgcvZ4tENDbit3fHEBtwy5ODpsf60osyw@mail.gmail.com>

> > If this was a hat on top of a SBC, with an EEPROM indicating what the
> > hat was, then maybe DT overlays would make sense. But from what you
> > have said, this is a fixed PCB design, nothing hot/cold plugable.
> 
> Some H616/H618 boards have the ethernet port on an expansion board:
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/2W-expansion-board.html

I don't see a list of pins which go across the connector. Does the
MDIO bus go to the expansion board? Is the PHY on the expansion
board. It all looks passive to me.

	Andrew
