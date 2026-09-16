Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D53EDE64;
	Wed, 16 Sep 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541251; cv=none; b=RNPcXNJyPj1rnptjyYwlcn1FDFWH3THrF8WRZbsyR3tA56/wTQwxYxIw2BbpwdSfhk3RUraJRrQh5OopKXy8K1oLhvDasdXLxWHq+0NAVZ+VmMcOcmiUhSezNqFJCuq2W+ifsAFQL3lLlLrEkWJa+wkONPvktFS6F24UxDbJjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541251; c=relaxed/simple;
	bh=lMkKTWBfh9KngLhAbumNWgk6bUElzsB2+kFDjdWbnT8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VuqnKnsg9MQI3xQP1Z63W8/zabZnGxLETocjo4rLzQDl2WzU64LavEJ2K0M1ChMiSGDruPrUnPMg6HlyoPbp1X2N4SBVGKxU2vOFTxHsjHV25AnuzO8yEDTJNuSKf2bb/BJ46c1wfYcM/oMHqigtRPYJFvXpJYefRkPzo2UsYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2gRzOwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2gRzOwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08CD1F00893;
	Wed, 16 Sep 2026 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541248;
	bh=/2MXCTNWFjDABS5FYmBUzNP+2LKeamMNjBmhfhZjtsc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g2gRzOwhmlax1ym4SUR+r7PfEu/yyTRUY1ZMcyG+JaYJT4v0FPnoqipdTXqBWynU0
	 brvhGbw1JTF/zD/bSz1TCF/fDB2i8ecbYEb0Xe4CWceze/Cfywf6VIxlUDplo33JnO
	 59fshYiL8xayoarfA2HNwGHyociWFlH8rAaSrsqt/rXzZnhkOpZEF78Q5KA4MGO0Oc
	 C5jow3tnzlTT2a0UgeKfKLF5jZ8CvU3nSFoqfy1gJyjSylrN8cR9oRdSI2KRr8TspW
	 iKdwTCfy7oc9rMDRcXH7j96ec6LCw6Q9bL83Cm/lVXJfvZUys0HKIIt7VRb92o0w1s
	 OMU7Ji/26fk5g==
Subject: Re: [PATCH net-next v11 05/15] ax88179_178a: Add netdev2data()
 convenience function
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:27 +0000
Message-ID: <178954124720.22033.15506626512402958845@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-5-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-5-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Naming-convention / global-namespace violation: the new helper is
  defined non-static in drivers/net/usb/ax88179_lib.c:131 and declared…
- [Low] Reported for completeness, but verified NOT a defect: the concern
  was that `netdev2data()` is added with zero callers and that the…

--

ax88179_178a: Add netdev2data() convenience function

This commit adds a small helper to the ax88179 library that returns the
ax88179_data structure belonging to a net_device by going through
netdev_priv() and usbnet->driver_priv. It is declared in
ax88179_lib.h alongside the other library entry points.

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 761701ebc0692..ea36aef3d3e45 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -128,6 +128,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	return ret;
>  }
>  
> +struct ax88179_data *netdev2data(struct net_device *net)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +
> +	return dev->driver_priv;
> +}
> +

[Severity: Low]
This isn't a bug, but would a prefixed name be preferable here?

Every other cross-file symbol in this library carries the ax88179_
prefix: ax88179_read_cmd(), ax88179_write_cmd(), ax88179_mdio_read(),
ax88179_status(), ax88179_get_wol(), ax88179_set_multicast() and so on.
netdev2data() is defined non-static in ax88179_lib.c, so with
CONFIG_USB_NET_AX88179_178A=y the unprefixed name ends up in the
vmlinux/kallsyms global namespace and backtraces no longer say which
driver it belongs to.

Since drivers/net/usb/Makefile links ax88179_lib.o into the multi-object
ax88179 module, the function cannot simply be made static in the .c file.
Would either of these work instead?

  ax88179_netdev2data()

or, given the body is two lines, a static inline in ax88179_lib.h.

I checked at the end of the series (5c3c73e9) and the symbol is still
global and unprefixed, so no later patch renames or localizes it.

[Severity: Low]
Also worth noting for completeness, and this turned out not to be a
problem: at this commit netdev2data() has no callers, and the existing
open-coded netdev_priv() + ->driver_priv sequences in the same file
(ax88179_get_wol(), ax88179_set_wol(), ax88179_set_multicast()) are left
untouched.

Checking the rest of the series shows the consumers arrive in the later
patches, with drivers/net/usb/ax88179a_devices.c calling netdev2data()
in six places at 5c3c73e9, so the intermediate commit builds cleanly and
changes no behaviour. Could the commit message mention which follow-up
patch first uses the helper?

>  void ax88179_status(struct usbnet *dev, struct urb *urb)
>  {
>  	struct ax88179_int_data *event;
> diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
> index b2ee1356727cf..9ff2a94a6fb2d 100644
> --- a/drivers/net/usb/ax88179_lib.h
> +++ b/drivers/net/usb/ax88179_lib.h
> @@ -181,6 +181,7 @@ void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  			     u16 size, void *data);
>  int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
>  void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
> +struct ax88179_data *netdev2data(struct net_device *net);
>  void ax88179_status(struct usbnet *dev, struct urb *urb);
>  void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
>  int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);

The new declaration sits in the middle of the ax88179_-prefixed block,
which is where the naming inconsistency above is most visible.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
