Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CD430CC1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896896; cv=none; b=mNLTbhav65J8Hh8PrhJP70ld8HiwwnPXZzpdTIwk4hy6CrSeTLCaIJN1lH4VhsDl5MhB9fMefosjZDnPqzn+JRwMgQBx4U4PR6V0jxWHTNrgxF+PL/Kk32dljh7DWIhPe9X2HLGt+m3HYwOkQwtv/ljOfjDLav59IlDZbqDhCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896896; c=relaxed/simple;
	bh=qGvZtVLF1PNj59LPI2pzdZUORCzbf/cryffMvuk7n5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjkDXgGFmmc8ZGY5psrDAO1wuCRM2WgoTJjsN66zWk/zrbN+ZKnpVILwvy9nxJnTDTvFZqA8HFt/7D5rvRRSkIfJBDDjfRkPyxS6weCz10YSMU4PL1GL2dUEn/L2aJX7OuylkqAqTjsZ8MyMaNradK4ZRQsjJK/lSC0C7DVFuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd6Ko7G5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd6Ko7G5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953f64372aso294075e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784896893; x=1785501693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVob7c+v3aI7MKDefWCNuMOS0UxDiJWUoQOuHz5yVOQ=;
        b=Bd6Ko7G5diOFyHz/Y57ycPG3NYp/x4+kky97fLaL6FAIBSELAH9SEz3PFx8F12tEHh
         e5kBBS5xijsyY11w9BI5XuEEt7fPeKZaISHj3bNhxakfFKjIn8nrsvvFKyQydjPHYtKU
         N1BOuEmX2Z/P7W/+DsHV/QaOZSkhD12QKk2jOD7ccbdlTpSVmwRSSzdIdgxgFP47qDsc
         Mn6YWqeBMVpMqdYqh1sc5zHSzA4drXVFw8bNNEKiDLa8uyHDbKb8VOE6x7ML8ePw/FhC
         NGRRlO+f1g/Mc78w80MP64EwFbMWdolbm6JNamHikv9StTmx0WEHO91eS9h0l8z7lOQR
         ehoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896893; x=1785501693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVob7c+v3aI7MKDefWCNuMOS0UxDiJWUoQOuHz5yVOQ=;
        b=XIhoiy0phWH6aT3p9wCJ1h1Ts+a/6LjNz3YZQOiT39G/FEzFF9gqRA4RZA57snEapd
         JoeFNyszVR5NSxhGwIStHUVgjSnfV6G7/gQUZYnv6TnXc4gSoB/iRWTcHAE2EdzM7G3P
         UMEq9eCjuAJ4feC5TjSZkDVQLkpX4dTaTtRjau0x2xWnyeX04gBu4YoI5AHsiyZp5Pd6
         GDe5HWr1xhYUb5B14qcjCS6YETSO169j6ZbAcEpx+sJcYcUW45lHJE+OKByrY2km0R75
         9Qy1IsgTFNeog/sNJT4POYXVIqkO22Cw+uHlcWvmlcAWnhhPxBB3HDX1Fch1fZa32do7
         jQwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlvLZJ0F+tnp+4GxTRWn4WorUxqcLdSOiuv7CmiorQ14isoo6IhbtpBQPqO/eRvZEIS2dBfDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyfuE7FZvhfHoxUsHGvYRndOG3pTbD+L4/Z52uRcEH61+DwRm
	URp8Rye0LpZNx9FEtsfMGRrLVdfHHH5/cn2ZVzqvXFHnyHV5qsfmMvhr
X-Gm-Gg: AR+sD12368zQ6K3kfB1kPjEgyze63EGi82pPPE81XCcOZbxSaRFEcDkysSZmw7uH9IK
	oTGVVWn8tWflNqcgp94jJtVnctrvkXUlM9Zal298VTOygxWBdT5nDzrbSVuI/bZ+n9VldjEoqCn
	V5HDEBj0ergnccc40+NJW4P4cS0QmnnRb9qhKhHySP4USGCLN5PyjGoKxPTgszwcJ84xhFnByr8
	Jav+tqER2n7t/mKEYoQs1eGNd7FekT+78TN0anyH4sfklF5f4+1gGuFyGo7LjqWuY2z11owrSpm
	qagpgeqx7WlWmQNkQN8Cqsr2BHrf4ymxUfx90MGx72DUzs41mV7xWnGiqk/VGYFk6GveR2ZrC2T
	EBZZPiwDo+tBRZvzb6NnQY29FqMWaT4KG+TCbNpkI6joXcbEjXdaTgfNRH8/GuLZnO04+
X-Received: by 2002:a05:600c:4f82:b0:495:64c5:c6dc with SMTP id 5b1f17b1804b1-49573cfaa4emr46736005e9.5.1784896892670;
        Fri, 24 Jul 2026 05:41:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d801:b100:414a:1dac:6b40:cc91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfb20ddsm42855935e9.3.2026.07.24.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:41:31 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:41:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: unsync host addresses when destroying
 user port
Message-ID: <20260724124128.f4327icrjw4jmkrl@skbuf>
References: <34a027de7d860796d37de2f2108337eb82110144.1784679091.git.daniel@makrotopia.org>
 <20260723225735.b7muegd4dlc6wsxz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723225735.b7muegd4dlc6wsxz@skbuf>

On Fri, Jul 24, 2026 at 01:57:35AM +0300, Vladimir Oltean wrote:
> On Wed, Jul 22, 2026 at 01:12:47AM +0100, Daniel Golle wrote:
> > When a user port is destroyed while addresses are still synced to it,
> > e.g. multicast addresses synced by a bridge the port is a member of,
> > the host FDB/MDB entries these addresses installed on the CPU port are
> > never removed: the only removal path is dsa_user_unsync_uc()/_mc() via
> > ndo_set_rx_mode, and __dev_set_rx_mode() does not call the ndo on a
> > device which is down. By the time the bridge unsyncs its addresses in
> > del_nbp() during unregistration, the netdev has already been closed,
> > so the unsync never reaches DSA and the entries linger until
> > dsa_switch_release_ports() reports them:
> > 
> >   Cleaning up multicast address 33:33:00:00:00:01 vid 0 from port 9
> > 
> > This happens on every unbind of a DSA driver supporting host address
> > filtering while its ports are up.
> > 
> > Unsync the host addresses in dsa_user_destroy() before unregistering
> > the netdev, at a point where the driver can still process the
> > deletion, just like dsa_user_change_conduit() already does when
> > migrating host addresses to a new conduit.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  net/dsa/user.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index 03c7af6abe18..a7dabb645036 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -2885,6 +2885,7 @@ void dsa_user_destroy(struct net_device *user_dev)
> >  
> >  	netif_carrier_off(user_dev);
> >  	rtnl_lock();
> > +	dsa_user_unsync_ha(user_dev);
> >  	netdev_upper_dev_unlink(conduit, user_dev);
> >  	unregister_netdevice(user_dev);
> >  	phylink_disconnect_phy(dp->pl);
> > -- 
> > 2.55.0
> 
> Sorry, I noticed this patch late. Something doesn't add up - I don't
> understand what makes the unregistration path unique, since according to
> all you've said, it should be enough to remove the user port from the
> bridge while administratively down, and it should lead to the same
> effect (no unsync event triggered). In that case, maybe the
> dsa_user_unsync_ha() belongs somewhere in dsa_user_close(), near
> dsa_user_host_uc_uninstall().
> 
> I will return tomorrow with more comments after I do some testing.

Back with some more comments.

Your statement "multicast addresses synced by a bridge the port is a
member of" is not correct. The bridge does not call dev_mc_add().
The multicast addresses come from a different place - likely from
net/ipv6/mcast.c instead.

Therefore, the part of the explanation that ties del_nbp() to the chain
of events truly has no relationship and should be dropped. The
host-joined multicast groups for the bridge are all synced to hardware
through the SWITCHDEV_OBJ_ID_HOST_MDB mechanism.

The minimal reproducer for the problem you observed should be:

$ ip link set swp0 up
$ ip link set swp0 down
$ echo <device-name> > /path/to/driver/unbind

and the correct fix is to put the dsa_user_unsync_ha() call where I
suggested earlier - in dsa_user_close().

pw-bot: cr
