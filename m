Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90B47DD43;
	Wed, 13 May 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690349; cv=none; b=Z1uPTiwS6gZU7mO7X95qBbT9eseucaztMIEFf92HJ1T5GYiliWQVEBh7VOT5WFIv6ODAME+H+SszMfoRH2IDDwOD8ceOlT82wMZfpEsoK1QPo0VSZTLijhnMzuPgJkOpSghbQXOMHhVyWA0GopziWq+H4LOF0zX9BsiOdnEVrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690349; c=relaxed/simple;
	bh=jTLiBlw18TYWMKIxl/753MDSgPlbqgABBLAxYXJoZtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzS5180ovHwZH7ttuN+r9UMSIqJBNBtngTmkWP0jyhn5sVSn/lAE3rw/MQDSz5diLY57bFJkJ3uw5A/Anpq9wd9MWwRQKkL2TGBGhxYEJ4jF3O4SOckEfBdP5jS44kas6D+FHBFA+0j90V1kwl6vwXuML/1RDBJi2DnZzImKSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bgtyOyUF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bgtyOyUF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MJkd/qTlxMG7YI6Zl4+/tXtTS+TkR88GPRYYm3E7D1k=; b=bgtyOyUFh1eq3ZGlxDNbsyDSfD
	iZpxM3bL5Qz1aGqgPkpUdKCcTNRq/2fN9QmIUeDXGFMRP9zuiUhlzlE/3YT4KNK08onLbkeTS+ABx
	czGjCE9fe7fStiJ4dBei9FJfTJI7KePXmBsyp4YraPGcAJrrR8PusRqcPN94Zl92mlPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNCbo-002lkA-EP; Wed, 13 May 2026 18:38:56 +0200
Date: Wed, 13 May 2026 18:38:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Message-ID: <3c5aa072-9107-440c-820f-3f63aa3ac3e9@lunn.ch>
References: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20542d76-6f70-4c2d-9fef-0de620a8d6d1@lunn.ch>
 <CY8PR02MB924974BBC348DE4814DA3C7C83062@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924974BBC348DE4814DA3C7C83062@CY8PR02MB9249.namprd02.prod.outlook.com>

> I believe this will affect the parameters passed to request_irq in oa_tc6.c. At present, IRQF_TRIGGER_FALLING is used. It has to be changed to IRQF_TRIGGER_LOW.
> BTW, I did test with this configuration. Both edge triggered and active low, level triggered seem to work, though technically it is supposed to be level triggered.
> 
> My understanding is that I should submit this particular change to oa_tc6, to net, not net-next as it falls under bug fix. Can you confirm?

Yes, this is a bug. Please submit it to net, and include a Fixes: tag.

     Andrew
