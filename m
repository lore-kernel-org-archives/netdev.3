Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42049344D90;
	Fri,  3 Jul 2026 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783115024; cv=none; b=GFA883q/HOnzSJA27pu8W0Y3R0rCHrwgbHUvzB79lTIKuNjF6eenDFM1mlcqkqAR3xrHwOKmpvBEYSkSlgNoQ9/FqO8P9PdwVxQoeOWr0ye54zXbdc1WCNlBawWG15bQgHpGEg8Ryq/N4FPGyNjaIQsK8BWQWR6tY5+kn4+TfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783115024; c=relaxed/simple;
	bh=sh1v0BgyiVrbIWK1EhotgEJABJE3oFph91vxVNoM80k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjfe6Gi7aG+IErZarD5NmyBda1JrvDolfSdqFVTPJdDiQ/Jl9rsRFfs5wceYJ2fpBdlEzwnwyvyW17pPcmGNVW+NEepXtRvfmHTkIFOqRSfdx8v6HRvs6fKviixd0jIhcp8Er+tpUcMtwBxvbZtnNwxh50OES7HJDlhBqLJGiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PswdgUND; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PswdgUND"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fyh5Jz/zd3eMw7zxHR3YpP3JEnNl9pLHOSLEVxhX9JU=; b=PswdgUNDfK0j77zSpts3KFqilk
	Tg/7gAaorWwowak+5h9GC/dvOdh90XGydgYB4s/Rf+JzqIEtwBu2boubm6sUGeStMLYSv4Zdjorct
	RSdNySLEtb8b8X0ReJ5tr/xCVRlYZZc4/Rb6eCAD4ewsJHxu1vnN5ZqzmJlDj6q/3SIw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wflfO-00AbsA-Dd; Fri, 03 Jul 2026 23:43:22 +0200
Date: Fri, 3 Jul 2026 23:43:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: use direct ATU hash on
 88E6141/6341
Message-ID: <8c2fd5d8-6b64-41d1-9dd4-bb1db687b844@lunn.ch>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
 <9eea72a5-b30d-4543-ac97-179743d99950@lunn.ch>
 <81F61D3E-D9EB-4646-A401-9C34BAF0903D@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81F61D3E-D9EB-4646-A401-9C34BAF0903D@padl.com>

> No documentation, just my experience, which is why I asked in the
> cover for others to test. I can include test results with the next
> revision.

Not so much the test results, but the test case.

The reason i added the devlink option was because the network
contained only devices from one vendor. So the OUI in the MAC
addresses was the same, the usable number of bits in the MAC address
being cut in half, in the best case. As a result, there was a lot of
hash collisions. For this special case network, the test mode hash was
better.

If you are also seeing a lot of collisions, it makes me wounder what
your distribution of MAC addresses is.

> >> have a performance impact (the data sheet notes this is for testing
> >> only), but it also enables correctness, at least in local testing.
> > 
> > How do you define correctness? Are you using a well defined test?
> > 
> > Why is the devlink parameter not sufficient.
> 

> Devlink would indeed be better, but changing hash mode with a
> non-empty ATU causes it to be corrupt on read back. Perhaps the
> right solution is to flus the ATU when changing hash mode via
> devlink.

Flushing the ATU would make sense. It could well be in the system i
was working on, once it was shown to help, the EEPROM contents was set
to configure the ATU hash at hardware boot time, and devlink was not
used in production. The vendor had a bad habit of using the EEPROM.

     Andrew
