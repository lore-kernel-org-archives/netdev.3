Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B123328E6;
	Wed, 12 Aug 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543695; cv=pass; b=oMrQFXmmaxvGYjbgZ2PL1c0BCRdHVHE1iivH9Yq1zH0OHQhI5jzYV+Kps1v2P2qYbgmbJqSKxmkKE/ft4CvHi3XIvDr0mBZu+WfwKN2/GZu34Tef+w1GrSWUlyQCsgAmKiA5Fr+1en/1TUZKKnbxPqgL0IKxCwUthrjP+423Mmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543695; c=relaxed/simple;
	bh=ED8/Id9P39kmd/HPBrlkxLCZ3WweR8fEB58UhEUIfso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkCmZUENbry+wu4LVOLAGo8Z39tiHyFUT437b7J/Kk7H5jPFfDHjVDTkWoFHAVQoHzLt8s77FxoSp91KbdbHzUcfD5aTXdeCeRTsVMadeFpdjbXYApD4TzGik2dEN+9G5MiTQy1v198JltFUbjQulmc/LQtQtP//jSRBeeUWBMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=SiObeyYz; arc=pass smtp.client-ip=136.143.169.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="SiObeyYz"
ARC-Seal: i=1; a=rsa-sha256; t=1786543673; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fdl3LxpQwolOmeLMcKKGi9sHb4BVLcohVfrGJKAz7LBiu3+90bVW4g93dIHFVlOc6FaDERLzs6+56WdYn1tsx1fy9EdGw2fYqaBUp9c5xhkqFDSc6EUFfimgZog569PUi5kukaEM54WZ9E9XFDDDPivnyIm4HCFHKf3L+/kSNsc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786543673; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xt/PHOrNVQzQMJAzk0d6e0ED79WRzu+fLKRv8nOdiTA=; 
	b=eSBA+vSUCrvSFz3KJ1efkXeFW8gIBQZlS01G6FjbbmVUhFyGqYIA2aPzIYv8+rLJAkdFD8bcXFDNWNJzEu+76Id2NPLhm21pFhjcj9U+401EwUifS56kBMPuUqXTyIOF/g65S4lZdBoi5QqdFNRKiTUEf9RomhvukTGe8cCuzXo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786543673;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=xt/PHOrNVQzQMJAzk0d6e0ED79WRzu+fLKRv8nOdiTA=;
	b=SiObeyYzCiNwlFjxh+Q1ObC962esYs2VfnaxlcFyanUF6icunAY8cWSxortM2fYX
	PjJPFtz1uiKF6k2swfk3huJH2AQcrBTLZUeJLs6jz+TFMxDZHNsIVjDikuJPurSadW5
	1NJQzua6q5n7r5sDgGVcHfv396/CkPr1j3tMcgaE=
Received: by mx.zoho.eu with SMTPS id 1786543671884839.3312813793443;
	Wed, 12 Aug 2026 16:07:51 +0200 (CEST)
Date: Wed, 12 Aug 2026 16:07:50 +0200
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Message-ID: <anx-NixOL_6WVLlH@larwa.hq.kempniu.pl>
References: <20260810061612.23745-1-kernel@kempniu.pl>
 <cc6d8243-e82b-4f1b-acf4-13ba6a74baaf@lunn.ch>
 <anw5OvAxKh3pnezZ@larwa.hq.kempniu.pl>
 <469e446d-36ab-45c7-9bf5-6e040747572b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <469e446d-36ab-45c7-9bf5-6e040747572b@lunn.ch>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.11.1.5.2/286.510.57
X-ZohoMailClient: External

> > Could you please point me at the exact retry mechanism you had in mind,
> > either the qca8k one or the Marvell equivalent?  I cannot see any in
> > drivers/net/dsa/qca/qca8k-8xxx.c.  If I'm reading qca8k code correctly,
> > when wait_for_completion_timeout() fails, its return value is just
> > bubbled up the call chain.
> 
> With the mv88e6xxx code, if ethernet times out, i repeated the request
> using MDIO. The code is not in mainline but a few users are using it.

Ah, that way, okay.  It looks like every mgmt Ethernet function in qca8k
has an MDIO fallback path, but I'll keep this in mind, thanks.

> At minimum, i would put a printk() there, and see if it happens.  It
> could be unrelated to your problem...

Ack, thanks.

-- 
Best regards,
Michał Kępień
