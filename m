Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619E38C2A0;
	Wed,  9 Sep 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975195; cv=none; b=A2k3nzjg6MBpMTQb8Aw+BGPRp+qx1DlDHbIO3ACKXuSejpSKJIQoEz7yP56Ed18QmclUR82oJBHpeC7bMy5TZnURFQDOfYaUo1uHP4pSUqSzR1QyOWJiZxM7U5jf9feI58NtGBTJh0FBXPreqbWZcKyrFyznFcJ6GEdJ6OlZcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975195; c=relaxed/simple;
	bh=8e65vqBqS2+xPNtfIXxAIdUPEoHFNmQ9ODmWLxPHkS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9KOjg0FxbGMKWN/c1LmI4FFwyLbV2JLTHlHHmZNqp0012YV+kRNGArMsUdMoDnff8x/8bIwh3ph3KROi0JSPXa8WmvNFHl2+niNoQYg7bA8Y6ot4oTDWrPpF1hOHyAwL4GzI2O52tqq5AJy/ytAbKDW6ZWrsWEtgwlPTodvIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0WGoVxJM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0WGoVxJM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qqzky4NioK/O0Csy4TAuIV9g/PeGeOmc1R35TVZNWDY=; b=0WGoVxJMhT2iQsWfTdyG9M1Zh+
	gTiJslqIatvt11Rrm9MsM1MiJOqD/cYccENxUdvfs6EClGwMO6EW0PjC/tXJv6zwKO9fg8r8N+nLG
	qd8SXt3YjPGWtQs55BsAwWT0DUgYRagC1CMA9F1eCAowbSuE7rDdReSx0fWyatk3mpYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4MA3-004GBP-Gl; Wed, 09 Sep 2026 19:32:39 +0200
Date: Wed, 9 Sep 2026 19:32:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: Kyle Switch <kyle.switch@motor-comm.com>, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v6 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <0aa20394-2042-4c52-b30b-cdd742d4da65@lunn.ch>
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
 <20260908083614.2210505-7-kyle.switch@motor-comm.com>
 <CAAXyoMMLpaD5B4QojC0OKHxOFfPfFGpsS2nxCMT9e=nJeo8beg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMMLpaD5B4QojC0OKHxOFfPfFGpsS2nxCMT9e=nJeo8beg@mail.gmail.com>

> > +/**
> > + * Initialize serdes configuration based on interface mode.
> > + */
> > +static int yt922x_sds_init(struct yt921x_priv *priv, int port,
> > +                          phy_interface_t interface)
> > +{
> > +       int addr;
> > +       u16 data;
> > +       int res;
> > +
> > +       addr = yt922x_sds_phyaddr_get
> > +               (port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
> > +                YT922X_PHY_REG_SPACE_SGMII);
> > +       if (addr < 0)
> > +               return -EINVAL;
> > +       /* write protect */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
> > +       if (res)
> > +               return res;
> > +       /* CDR */
> > +       if (interface == PHY_INTERFACE_MODE_100BASEX) {
> > +               res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
> > +               if (res)
> > +                       return res;
> > +       } else {
> > +               res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
> > +               if (res)
> > +                       return res;
> > +       }
> > +       /* PLL */
> > +       if (interface == PHY_INTERFACE_MODE_USXGMII) {
> > +               res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070);
> > +               if (res)
> > +                       return res;
> > +       } else {
> > +               res = yt921x_intif_ext_write(priv, addr, 0x43d, 0x207d);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x43c, 0x207d);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3032);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x6);
> > +               if (res)
> > +                       return res;
> > +               res = yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070);
> > +               if (res)
> > +                       return res;
> > +       }
> > +       /* VCO */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x439, 0xC0);
> > +       if (res)
> > +               return res;
> > +       /* Vdac */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x491, 0x7f);
> > +       if (res)
> > +               return res;
> > +       /* Eye */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x454, 0xf14);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x497, 0xa44);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4cd, 0x0);
> > +       if (res)
> > +               return res;
> > +
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e3);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x48a, 0xfff);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x408, 0x7c00);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4d6, 0x7f);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x44f, 0xff08);
> > +       if (res)
> > +               return res;
> > +       /* FFE */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x48e, 0x7d00);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0xd, 0x60f);
> > +       if (res)
> > +               return res;
> > +       /* CTLE */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4b0, 0x804);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4b1, 0x7774);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e7);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x3, 0x5603);
> > +       if (res)
> > +               return res;
> > +
> > +       msleep(20);
> > +       res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7fff);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
> > +       if (res)
> > +               return res;
> > +       /* CTLE */
> > +       res = yt921x_intif_ext_write(priv, addr, 0x2000, 0x40);
> > +       if (res)
> > +               return res;
> > +       res = yt921x_intif_ext_write(priv, addr, 0x2000, 0x0);
> > +       if (res)
> > +               return res;
> > +
> > +       if (interface == PHY_INTERFACE_MODE_SGMII) {
> > +               res = yt921x_intif_ext_write(priv, addr, 0x1042, 0x48c);
> > +               if (res)
> > +                       return res;
> > +       }
> > +       /* soft reset */
> > +       addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
> > +                                     YT922X_PHY_REG_SPACE_SGMII);
> > +       if (addr < 0)
> > +               return res;
> > +       res = yt921x_intif_read(priv, addr, 0x0, &data);
> > +       if (res)
> > +               return res;
> > +       data &= ~(1 << 15);
> > +       res = yt921x_intif_write(priv, addr, 0x0, data);
> > +       if (res)
> > +               return res;
> > +       addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
> > +                                     YT922X_PHY_REG_SPACE_USXGMII);
> > +       if (addr < 0)
> > +               return res;
> > +       res = yt921x_intif_read(priv, addr, 0x0, &data);
> > +       if (res)
> > +               return res;
> > +       data |= 1 << 15;
> > +       res = yt921x_intif_write(priv, addr, 0x0, data);
> > +       if (res)
> > +               return res;
> > +
> > +       return 0;
> > +}
> 
> No one else, except you, can maintain this stuff. Drop it for now and
> discuss it later.

There also appears to be similar magic in the PHY driver. Can this be
consolidated?

	Andrew
