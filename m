Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195F42CAFC;
	Mon, 17 Aug 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972363; cv=none; b=PhnrKDuRNcxjaLass92SuEHwA8gzLDMBqR0JQV2x0LkDGJPRTqFmG/C2x/DlGtyIv4lhUoOhpor+6bOwXnrXG+YobbW0s6gfjk+G7v0OJa2fq9Z/7ni9NPQJUA5aWAi4QIAKovOOj+s7Q8+OTk64/YD+tjw5zTTGOmIH8ej6K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972363; c=relaxed/simple;
	bh=B+jKSB3I1LdbAG0MTYeh9Z9B0+izpez3HSBV8q+9MTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED9+C1PA4jhky3RPfXLr00Ppr+usvwAcjqneBC04QzGbW4FHmz6wAvm+WRA7ZghPm2ezNK8U/V1Qj4v6UpQg0nP6d2QJDI5KEiduBoVrewKN62rzqVDwIJL1hZstj2AF53R1sQJqEouYjpo0F6fxEoAMAzRz5Kw3QxqyCumHZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6Zz9n7Kt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Zz9n7Kt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JpaZiUV93gLEC0bfZ6Z1FWRmp7zOkxQmDxqtszVkq8w=; b=6Z
	z9n7KtKaO0UaW3cvDJYu/hYclGMZ6IYNQ9rGa9LGQqAGj9FpJjaweBj9yjKR/eUTI+cOe6iNb+vek
	P2+wdphWoVWckMdosW7t4oj+wfbxHCm4iyM62ydRd4z2UMASJnmg2eN5Y7GSSJbgK+Fygpv4DqY0n
	/cYK6K458CtarLY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wvx8g-000Jf1-7C; Mon, 17 Aug 2026 15:12:30 +0200
Date: Mon, 17 Aug 2026 15:12:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v1] net:dsa:yt922x: Add support for Motorcomm
 YT922x
Message-ID: <944f80c0-5b0b-46ce-8e22-304b683dda60@lunn.ch>
References: <20260813104137.55550-1-kyle.switch@motor-comm.com>
 <CAAXyoMP=-YXbdgCWXRbPqmQXwPuRegHSDvDm9_+hhmf9ev2CAQ@mail.gmail.com>
 <f324481e-d49c-4d6d-b5fd-8a0296f82a15@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f324481e-d49c-4d6d-b5fd-8a0296f82a15@motor-comm.com>

On Mon, Aug 17, 2026 at 06:40:02PM +0800, Kyle Switch wrote:
> 
> On 8/17/26 05:17, David Yang wrote:
> > On Fri, Aug 14, 2026 at 9:50 AM Kyle Switch <kyle.switch@motor-comm.com> wrote:
> > 
> > > @@ -148,10 +148,15 @@ static const struct yt921x_info yt921x_infos[] = {
> > >                  YT921X_PORT_MASK_INT0_n(8),
> > >                  YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
> > >          },
> > > +       {
> > > +               "YT9224", YT9224_MAJOR, 0, 0,
> > > +               0x1f1,
> > > +               0x0,
> > > +       },
> > Why plain magic numbers here, despite what the above entries shows?
> Ans: will fixed done in patch v2.
> > 
> > >          {}
> > >   };
> > > 
> > > -#define YT921X_NAME    "yt921x"
> > > +#define YT92XX_NAME    "yt92xx"
> > This changed the module name which may affect end users. While I have
> > no objection to this, subsystem maintainers may have different
> > opinions.
> Ans: This is used to indicate support for both YT921X and YT922X.

It is pretty common for newer generations of devices to be mostly
backwards compatible, with older generations. The driver does not
change name in Linux it causes too much pointless churn. Please just
get the names correct in the struct phy_driver.
> > > +       res = yt921x_intif_read(priv, addr, 0x0, &data);
> > > +       if (res)
> > > +               return res;
> > > +       data |= 1 << 15;
> > > +       res = yt921x_intif_write(priv, addr, 0x0, data);
> > > +       if (res)
> > > +               return res;
> > Numerous magic numbers. On YT9215, same finetunes are not required for
> > a usable port. If you cannot name it, drop it if it is not mandatory.
> 
> Ans: Some patches are mandatory

If they are mandatory, why are they needed at all? Why are they not in
the firmware. Seems like a poor hardware/firmware design to me.

> while others are for performance optimization.

For these, it would be good to fully document them, because board
designers might want to optimze them in other ways.

> > > -static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> > > +static void yt92xx_mdio_remove(struct mdio_device *mdiodev)
> > Unnecessary renaming.

And taking this to its logical conclusion...

In a few years time you want to rename to yt9xxx.  And a few years
after that, rename to ytxxxx. 

    Andrew
