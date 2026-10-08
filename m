Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC9466B09;
	Thu,  8 Oct 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461132; cv=none; b=cGLKmpmXuuK5DnMaV4/Nhs31yQBAUXVPdDoZLZ1HCC4Hfg1fQnqFbITHH47y7d2ttsP6CHx8QXDiu+nbuQVS6mR73SwEU5qzA54VdR5J7sfKYM/chhTfNi2wIeYc++zPCOqwizdop2w2xUDpCi12ODX7To+/HJcweVnGkm+tLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461132; c=relaxed/simple;
	bh=Sl/omVN3q0pKD8frjowb8ej6v9l1n7YHwGaYtJXsNV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WokjaLdE8dlNWcGM9t2T4jpubpjlg3E2skPfHxKnuxEZQJaigx7uyc+TLL464vZ9CkjQUFDCg7145mLzNT7p8NMVN3D8NZ7+3xM0yu/YSmyqMczWjyfvbiXriJ7PpZuDbXhElVLsJDBzpdLevvNfd+VN+oAv6z9gaPIkxuenBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A23QgIL+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A23QgIL+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=42Yn8L0WiuoRJMFaqviViBd4jcl1zkmX+cY7rVmpn/M=; b=A23QgIL+082VjZiVU9T+M/UsN7
	oCxwf15lJ8ONOj36FPnRUwk341qzHjZNeptSGEDVp+ijp1j9LnJzZ6RIMh7BzjkmIeTChQ/mHmA7E
	qo6X5meMOqms4BQs0TGdAQluog/ugji7Mm7ZTg5JXrNLWxvO+ofBDDRVnwax5BitGKH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEmsF-009cXA-1q; Thu, 08 Oct 2026 14:05:23 +0200
Date: Thu, 8 Oct 2026 14:05:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <c9f76173-5ff3-421e-a18a-ef9240324e43@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
 <20261007205457.GA244932-robh@kernel.org>
 <35b4bc5dcd6a6340e98361570d304fedb099ae86.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b4bc5dcd6a6340e98361570d304fedb099ae86.camel@linutronix.de>

> > > +properties:
> > > +  compatible:
> > > +    const: soce,swip-00-04-0c-10
> > > +    description:
> > > +      Register layout with the core version register at offset 0x00 and
> > > +      feature identification registers at offsets 0x04, 0x0c, and 0x10.
> > 
> > Do you expect these to change? Kind of an odd compatible, but okay...
> 
> No, I don't expect them to change. But since this is FPGA IP which is
> easy to be changed, I would not rely on them either.

The description talks about "what" this compatible is, but does not
say anything about "why?" Adding a comment explaining the why? might
help avoid questions.

     Andrew
