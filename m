Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2834DCE3;
	Sun, 18 Oct 2026 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364675; cv=none; b=rVNdqYcmag8Cu8J5sJN9EifN6SA/o7wj7f6BJ6SPWWW9266YypU3ZtmgJ1vlOCUvn/zKETQ4TGMKmPSIetKgB44e1P5YNq4ECxH9YmpMqZfvzJZ1an9vIzLJSD/vgREFdGPGH8DLIO1N2TpkO4KWM/EEJUhvTD6I/HBooZ8/DJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364675; c=relaxed/simple;
	bh=PAdYOJ6+VQUsob6n2jCgdqPzP2nwBnJ35YUBMcjrd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQXuRMji1QgNY99Kc9Nwq2GnNrCRmraenRjVuVZkwmKxAvRkJF3oUvE/+JYr9EvlH4a9hHF+LcXCKbUYnfKHSb+sqe6ckBIZf3uwafMw6ekSi2LyMTeif0ZFRK5Vj5s2whxly0/A+tMEMhZ16IBc24QOq+8wg3m3HqP2Hjt9wCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5hv9qdVc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5hv9qdVc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=saxxRacJ5hWTgsNIWolEJAGpb2rG2OONC5ywqM+ibRo=; b=5hv9qdVcTuXxc9z/5PoWMKTFcL
	DO4v4BUWrRy86imNADS8X+LnvB9mX3G40kWVE8vOnUqgZUs+I+xD5qQIK7Gx1KmRyKV/k+uoBNqKk
	yby9qzUgUb4S79ro2+htic2gjD1Oa80p0O7veT3S8N2YY+QP8rxJ40WjDsvkDLQLSnig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIZvQ-00BX8B-Kl; Mon, 19 Oct 2026 01:04:20 +0200
Date: Mon, 19 Oct 2026 01:04:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, linusw@kernel.org,
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/9] net: dsa: realtek: rtl8365mb: set speed
 for family D
Message-ID: <2d26a270-fb06-4971-b9e1-3e3572a8b814@lunn.ch>
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
 <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
 <CAJq09z5ZAxca0rRT0mSiU_3xp2wxEU4qahbDM3SBGpwe1vbMRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z5ZAxca0rRT0mSiU_3xp2wxEU4qahbDM3SBGpwe1vbMRw@mail.gmail.com>

On Sun, Oct 18, 2026 at 07:40:47PM -0300, Luiz Angelo Daros de Luca wrote:
> > diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> > index 840db5a..2dabc4d 100644
> > --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> > +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> > @@ -344,6 +344,7 @@
> >  #define RTL8365MB_PORT_SPEED_10M       0
> >  #define RTL8365MB_PORT_SPEED_100M      1
> >  #define RTL8365MB_PORT_SPEED_1000M     2
> > +#define RTL8365MB_D_PORT_SPEED_2500M   5
> 
> I also used the same _<FAMILY>_ tag trick previously, but it gets
> confusing quickly. Does RTL8365MB_D_xxx mean something exclusive to
> family D, or family D and later? I hope a more seasoned reviewer can
> weigh in on this.

The Marvell switch driver does something similar. There are a few
families of devices, and within each family, a few devices. Within a
family, the devices are register compatible, but they either have
different number of ports, or features are not present.

The naming of functions and defines is based around the highest family
member of the family which introduced the feature. A few examples:

int mv88e6097_port_pause_limit(struct mv88e6xxx_chip *chip, int port, u8 in,
                               u8 out);
int mv88e6390_port_pause_limit(struct mv88e6xxx_chip *chip, int port, u8 in,
                               u8 out);

The feature was first introduced in mv88e6097, and this method is used
in all families until the mv88e6390 came along, which required a
different implementation because the registers changed.

So i would say RTL8365MB_D_xxx means D and later. And if you need
RTL8365MB_F_xxx, put it close by so other developers are aware it
exists.

What we also sometimes do is have a mv88e6xxx_foo function, which is
generic, but it calls mv88e6352_foo, mv88e6189_foo, mv88e6393_foo as
needed.

	Andrew

