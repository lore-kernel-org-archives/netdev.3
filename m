Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BB47FAF4;
	Wed,  2 Sep 2026 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350699; cv=none; b=C484QjdnWnGSv3+gaG1psnhBL/6RX0IZgfQdqlgzJ2PHg6/n7SJzG7BVwGLvZY2WLmWlbZNoOVV06BnWG08K81ljHGwp/IzXjOjZLeukai8DmqV1t5rfCbM7cg4dRSfMqLEahPHSQCnTy3YA1f9xE+0Zw4ut0LCJn9o9VxYwy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350699; c=relaxed/simple;
	bh=mRkUfYStPkFa3gRUiis1yOOBE3gmRIjBScw1ExHohX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emD7xPHrfh5XyQoEjkEPgtyG/1pv9GN2RmBxUhFiOP6l3g5EWBDS2Q/5X5ZVF1lA5CVonVR3dDgAonPNLLaieki/DlUomiEhRKxWe9244T4tpxaFo87P48pw1nf0yoZE/ZpT3PsbMoT+K2FnwsupQmMFZGBSMjsRvV733x1FCRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FiNyV15A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FiNyV15A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TPpTauZDU0aQOfK5RCZ05OFPP6Wl3wzfzEM2+qWjF9M=; b=FiNyV15A+tiNQttTDwkz1Vq6ah
	xOXkcsV8HASptVdToC0bRMqhnATO1ZbYcX+Ylt21oGPhF3G3Q9lSLGn+6Ej00iGs5+vxjlkTjZF3h
	qbUYVEGPqf5PYtw15zq+Tn+dkyuo0Q4Eqc2HM5dxFBVB1Hk0Zc7Ngnv0unxJH0WgGDEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1jhh-002Vuf-2S; Wed, 02 Sep 2026 14:04:33 +0200
Date: Wed, 2 Sep 2026 14:04:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/5] net: dsa: motorcomm: Add LED support
Message-ID: <f17be0c1-96a4-4226-9581-a28a07d14a73@lunn.ch>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
 <20260831044818.4103477-5-mmyangfl@gmail.com>
 <20260901175618.28d81bd6@kernel.org>
 <CAAXyoMOQf8oK3Z_TQKDmLvCQmgAjUR29VnFSFi+np4RtNNw_bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMOQf8oK3Z_TQKDmLvCQmgAjUR29VnFSFi+np4RtNNw_bg@mail.gmail.com>

> > Would an "echo netdev > /sys/class/leds/<led>/trigger" racing with switch
> > unbind, or with the dsa_tree_setup() error path, touch a freed
> > net_device here? Would removing the LEDs per port before the netdevs go
> > away, or validating dp->user under rtnl_lock, avoid that?
> >
> > > @@ -4581,6 +4589,12 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
> > >       if (res)
> > >               return res;
> > >
> > > +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> > > +     res = yt921x_leds_setup(priv);
> > > +     if (res)
> > > +             dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> > > +#endif
> > > +
> 
> Just a question: I don't see any protection against this in other DSA
> led drivers, like mv88e6 or qca8k.

Registering the LEDs uses devm_ so the life of the LEDs is the life of
the chip. The LED trigger does however take a reference on the network
device, so it should not be possible for it to disappear while the
trigger is still bound to it.

	Andrew
