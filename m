Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500134;
	b=fHeU8FHLAiO6logpr/fVIweHGLbvMZuuIt0CjY/d1YhSb2RXpUK0ZVRhPCbSwv/fQXAW
	 vtWW274WYaEZC0j2LnDkNO5rxvm1y5LSFEZd74lxRgrsNJ2Qq+aT64NvL7NPgAnK1M9qc
	 maZvAryl9P37iprKq6SJmEFD6Hf7vT1Y1hPByuXEunAxi2SaFoGsrxECXpdRWgB5VWoJo
	 +u+DNWraeAPla9/J+WCh8lJLhsRjt/QcLFm1l9ckYsjKRSxtMELFf9m/XJaZICnOLP8IC
	 GBEeWTzANJwZrgDRci1RlLu2Aphr6uOyZP52CYKnDfXMERoP+A/m9DkfKKYj8C8Ca/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500134;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=E+lPQFUisVnZ0dm/OJdC+O18hBtu9MYe0Vq+o6Ob5tw=;
	b=osD5SlZxQGdp3UdB/00lysKIGjNhkSjHV3A8WV/Hln8GW11/4yi8oRJKaBBJ7M6j6c3u
	 7S1N7Zox06v8VG4f5H0nXGRS4u5yPG9d0a4RApj+hcqG0Ynid+v5Nk8Uaj4fmOYUyQgNf
	 wONTJRUUfQTEfoR7IcgRPen+Z/bPdlESrpFMPNx7+hwrC/ZMTTMW6wos6PHCYy52+fXyg
	 3jvK0cy9uecZqdI+fEINlvxwL8HInEYqSykN+BHJkuqXmUCZVwUaKRD9esQ35Y8qktkBE
	 6WU+/7ow+M6rUFGXYZFhIcAFvL3uyyt3HZ2Wg9fYsM1kxgs6bclgj7plaGTDbB0YU4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=YL8JYSvP;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC5606A32E;
	Thu, 12 Nov 2026 16:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAEC5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=YL8JYSvP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E+lPQFUisVnZ0dm/OJdC+O18hBtu9MYe0Vq+o6Ob5tw=; b=YL8JYSvPAzt1jdXgOvy7T68YhR
	L07tbukDoNe8lhW4ZtRnr3BLMgF73ulQcKd2L3CxLsBEhDpgeVA3IPRtl6Q+8vmZ/DG8PJhY5wRki
	HTtG0i5PfnUxtqGuaV55ytsQVbntKsQLXmkSQO0pUWC7HdNrAQkr18oyDjdLLMbGwGbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRXSD-00G3yy-KR; Thu, 12 Nov 2026 17:15:13 +0100
Date: Thu, 12 Nov 2026 17:15:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, davem@davemloft.net,
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
	n05ec@lzu.edu.cn, ylong030@ucr.edu, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net] vlan: prevent cross-netns MII register writes
Message-ID: <706b09ea-49cc-4801-a24b-b22d2ea7d257@lunn.ch>
References: <20261106124639.12584-1-dennylin0707@gmail.com>
 <20261112075624.23c04230@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112075624.23c04230@kernel.org>

On Thu, Nov 12, 2026 at 07:56:24AM -0800, Jakub Kicinski wrote:
> On Fri,  6 Nov 2026 12:46:39 +0000 Hungyu Lin wrote:
> > vlan_dev_ioctl() forwards SIOCSMIIREG to the underlying real
> > device without checking whether the VLAN device and real device
> > belong to the same network namespace.
> > 
> > A VLAN device can be moved into another network namespace while
> > its real device remains in the host namespace. This allows a
> > process with the required privileges in the VLAN device's
> > namespace to modify PHY registers on the host's real device.
> > 
> > Reject SIOCSMIIREG when the two devices belong to different
> > network namespaces. Preserve MII reads across namespaces and
> > allow MII writes when both devices belong to the same namespace.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> 
> > diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> > index bca0a3693636..0d0904103302 100644
> > --- a/net/8021q/vlan_dev.c
> > +++ b/net/8021q/vlan_dev.c
> > @@ -416,9 +416,12 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> >  	ifrr.ifr_ifru = ifr->ifr_ifru;
> >  
> >  	switch (cmd) {
> > +	case SIOCSMIIREG:
> > +		if (!net_eq(dev_net(dev), dev_net(real_dev)))
> > +			break;
> > +		fallthrough;
> >  	case SIOCGMIIPHY:
> >  	case SIOCGMIIREG:
> > -	case SIOCSMIIREG:
> >  		err = dev_eth_ioctl(real_dev, &ifrr, cmd);
> >  		break;
> >  	}
> 
> Andrew, Florian, any idea if we could delete this completely?
> Why would anyone want to run MII/PHY commands on a VLAN?

It does seem questionable.

Hungyu, do any other virtual devices forward these ioctl calls to the
physical device below? I assume they have the same problem. So we need
a fix for them all.

	 Andrew
