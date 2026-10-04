Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72388414429;
	Sun,  4 Oct 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125054; cv=none; b=FTYAHjygrUQ0QEnNil9+TIJXgkkmbYNOLn+uAcx0mFUmctHGxgVFoIB3zEZ228WG1MTcMltsksBaG4rqvuDpN0b0fP8I9HzIp5uf6JzGhJiebsvGF+joAWOSi4xU8m4ruRCsu1A63xkRQyjl9R/R0LSfExcOrZ8TYimSd0mBvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125054; c=relaxed/simple;
	bh=dTyC9WZw3Hm7ZjEiYmlGlgy+1CYbkD/LCkjwOqdxgmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRQKLvc0qUUvKmoPKj1HYLQw2eQw1K8SnToWyoEI8u3xQesi43DRz1SKzYtgQTUnSAhptB+R+TevhvwtjEW08EJX680mkjDX+12L1zuncD3f6dyo7LCj8J1PbgGIHKiJGi0lb8CToWabgMz7bG2fDoCk76DBcpNXp/S89cEmt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AV95UymE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AV95UymE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ifXSq0+YFSM5CvX7u7FIa/yYNYrYWA9gQuKxbqp2eng=; b=AV95UymE36Fu+SSDR+gi+FD4DO
	R4jOSCAdHqkupj/XoJ+lS6tz4/Nn4XmvZ1cIr+643fRJVpMNtfeND973Mli/Vmf85iR0zZILQhQwX
	CWxwFzqzm+6PO6MFBX/qBTjDOnCpmovqmM5fgUgFlD9jXd3GHMvEH2yHeWBra3dc203k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDNRT-008tVw-Ow; Sun, 04 Oct 2026 16:43:55 +0200
Date: Sun, 4 Oct 2026 16:43:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v19 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <435b23c9-48ca-4cee-8bfb-70773be296ca@lunn.ch>
References: <cover.1791035885.git.daniel@makrotopia.org>
 <6bf133505781800d1f64ea736e72c557759bb03e.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf133505781800d1f64ea736e72c557759bb03e.1791035885.git.daniel@makrotopia.org>

On Sat, Oct 03, 2026 at 04:52:37PM +0100, Daniel Golle wrote:
> Implement "devlink dev flash" for firmware upgrade and "devlink dev
> info" for version reporting. info reports the chip part number and
> revision as the asic.id and asic.rev fixed versions, and the firmware
> version as both the running and the stored version, since the switch
> boots its firmware from its own flash; a zero part number or an all-zero
> version is omitted rather than published as a bogus match for userspace.
> 
> flash validates the image and its payload CRCs, reboots the switch into
> its MCUboot loader with SYS_MISC_FW_UPDATE, transfers the image over the
> SB PDI clause-22 SMDIO protocol, and reboots into the new firmware once
> the loader has verified it. For the duration the driver closes and
> detaches the user ports so userspace cannot reopen them, closes the
> conduit, and blocks firmware API access under the MDIO bus lock so
> nothing reaches the bus after the switch has left for MCUboot. A blocked
> write reports success, so a bridge tearing its ports down over a flash
> does not see port_vlan_del() fail and leak its VLAN group. A transfer
> that fails leaves the switch in the loader; the next patch recovers it
> from there.
> 
> MCUboot offers no in-place path back, so the driver reinitialises with a
> deferred re-probe scheduled through device_schedule_reprobe() from the
> previous patch, which runs in the driver core off the devlink caller's
> locks and without pinning the driver module. ->shutdown() and
> .remove() take the devlink instance lock up front, since neither goes
> through devlink and dsa_unregister_switch() frees the user netdevs
> before devlink_unregister() would: this waits out a transfer in flight,
> for as long as the transfer's own timeouts allow, rather than cutting
> it in half, and refuses a flash that starts once teardown has begun. A
> flash is refused as well until the DSA tree has finished its setup,
> since devlink registers the switch before the core creates the user
> ports.
> 
> Assisted-by: LLM
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
