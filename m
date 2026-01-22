Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20103F22AE;
	Thu, 22 Jan 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098697; cv=none; b=SaBO/L0jnNvWG+G4XWv5KfHWhoN0Sd8f2bbQCIynJ+s81X6Eg1XGauGhDbgRXS9gBJipoGs7ndp0QcfLThn8gtMTsHzwkEBurGyLK167QSKfGx7tZdywUlDXdKmjkGpsgorN58zQlPeJIIYfc6W1IzgdEy2JrNQZ9yDUcozxXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098697; c=relaxed/simple;
	bh=G7VNC55Ha486PBu02P5s/GAzjKHVUKElTcE3p8sB+P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcC1818Xmfr7+T2lXCs23LB/1RvJdjA8A40smMR8/8owXDo1NFSHhQrYt89F7PwIgWzssmgyFgg4q4JbOjDC1+oFAMj7zBpegJt2yNMpw1sC3J+qMgZhi9RUvivBfqdlKILn8na6+jd+1bR83zktASB5SUUhaLrtlhCFV7K0EQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zneOet2r; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zneOet2r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ROhcxupK5+fjDAxb5ECIUsDM3Hongs6Ym9DHamBwjLI=; b=zneOet2rcigg3Y+DAN1uEIPChM
	DQjt3UKrNi06hFU1LmLIM5PutacQhegzV3V1swgfQItUlaKa6UBclNiM/iJNlHk6V/jeXo9JEuHTd
	dVi1huNtzLCjMJ7rSVCZYyRpKlJu19gz/+/q4mOT2+cBg2uNNPVAwe4y/6wo7E+NvqzPCg4qwOdpq
	fFtSIj3aynEUhzz4ovpIqdcvaRo+6UAToQHQY0XjL4vEyzYDWQ7pwTfLozdGiOH6wHNXdJ4qtmqdq
	uGkWjX34+zbOUTevDFwMqryX1n+ooqSP0SizrM3ni3yc2/6EiTXhGRkaeDiUJbmNXHOJ4JQcvfnLE
	Ksb95ZcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58740)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vixNk-000000000ft-2F40;
	Thu, 22 Jan 2026 16:18:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vixNf-0000000018M-3Kqv;
	Thu, 22 Jan 2026 16:17:59 +0000
Date: Thu, 22 Jan 2026 16:17:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 04/15] net: dsa: sja1105: prepare regmap for
 passing to child devices
Message-ID: <aXJNtz0i--EZXQUR@shell.armlinux.org.uk>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-5-vladimir.oltean@nxp.com>
 <aXIWttaIcR-yq0nx@smile.fi.intel.com>
 <20260122134245.i5rocwklpcauk3hw@skbuf>
 <aXI6E4-n25aYn-0y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXI6E4-n25aYn-0y@smile.fi.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 22, 2026 at 04:54:11PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 03:42:45PM +0200, Vladimir Oltean wrote:
> > I never understood the point of dev_err_probe() when you know the return
> > code can never be -EPROBE_DEFER.
> 
> i) Smaller code; ii) no need to care about: a) deferred probe cases;
> b) -ENOMEM cases.  I see only benefits here by using it.

Isn't it also used for /sys/kernel/debug/devices_deferred to report to
the user ?

E.g.

supply-voltage-monitor  iio_hwmon: Failed to get channels

produced by drivers/hwmon/iio_hwmon.c::iio_hwmon_probe():

        channels = devm_iio_channel_get_all(dev);
        if (IS_ERR(channels)) {
                ret = PTR_ERR(channels);
                if (ret == -ENODEV)
                        ret = -EPROBE_DEFER;
                return dev_err_probe(dev, ret,
                                     "Failed to get channels\n");
        }


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
