Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F6381B11;
	Tue,  3 Mar 2026 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569330; cv=none; b=eBNgUXVJBpoKcgx1rbEEPQ9fisR/PmxFvS30bRvt2MzGGY8z6gNJ82yiyMn4TQMXf5TGGHCq7x/DN9WyTCM4N+IxN6Yfb+nXgyjMYTOEK5f6qC2ntowJWXl3lim+dS7oFqzix4fDILxGCdH44o6k1sZpSR/dIgY8Y/mp/ZKrBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569330; c=relaxed/simple;
	bh=D8cMkBpRmAZ6+xAK8tnB+59N0CkmeL+GJj7QAqgdO7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYdw5cnO8WU0kOx4RQVxz3Ey94nfBADMY0jk7pnaM+u8XvD8yCHFzAbGl8wBSnHXHQYmazdPFsFXVJJEqtjrK6J/bNHPH+fLl3KhmMemne9ZrvVDrazKOXPEby2mEMDYoxtOpssAIhVxXV6WLXFjBXBINhbhjBO7zZw+CvnAqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dDA8S5PD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dDA8S5PD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2aVi0+7nYPcHGQkYEYxqHadDSArAd5HgY2E64wvkGHU=; b=dDA8S5PDolMbiI5X8rlx7/+egu
	FtXnV7GyOWwBsmlIayqCy2+Ls5OqOQoxKp2XaOWiZh9hiF+kc2u1mAGLU0Dzy2HE+/EpWxLrPGLbF
	3rjQ9aKqAEOg55a2R+tNipA6xijU3rMj49VJb6iHuf11qtGDCO3pIPkxBJrnS9IWQZzM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxWFV-009xRA-R4; Tue, 03 Mar 2026 21:21:45 +0100
Date: Tue, 3 Mar 2026 21:21:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 8/8] net: dsa: lan9645x: add port statistics
Message-ID: <c327cdb9-ce0c-41dd-917a-429b2b52bc26@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
 <20260303160159.efjtqzpa2w4awxht@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303160159.efjtqzpa2w4awxht@skbuf>

> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +				struct rtnl_link_stats64 *stats)
> > +{
> > +	u64 *port_cnt;
> > +
> > +	/* Avoid stats update, as this is called very often by DSA. */
> > +	mutex_lock(&lan9645x->stats->hw_lock);
> 
> This is atomic context, you can't acquire a mutex which may be held by a
> process which sleeps, which also puts you to sleep for it.

Which suggests no testing has been done with kernel configuration
options enabled which does checks for this, deadlock detection, etc.

I would suggest PROVE_LOCKING, DEBUG_SPINLOCK, DEBUG_MUTEXES,
DEBUG_ATOMIC_SLEEP.

	Andrew
