Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925545FFA5;
	Mon, 24 Aug 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588721; cv=none; b=i7BVOm3qMWjIPJ8K9wU91E++2ahpx/Icc414cCmPwAiCdN83Cl9ouar2OcVqEJD2Ql44XB+Ahp/VBMzSkIbETtgvE/sZw7l7GOWvn5aEQ0LqkdWoSVXbiDvUCEXzQZiGpQ/O3Xj5OIhVjgrI60yipJK/aE1CPtX4Vqw7PGjt3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588721; c=relaxed/simple;
	bh=KhlD/4yisOQc5Pg3lfD/03rSzChlw1INKaNuEpD+6o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAetpgA7dN8Oj6QrOVxDoYnaVYm/SYPzlKCm0CCF4CjjQK11WvqgPQALWpJbuUQA6c753/TD/7cqzvgDFV9et94b6RbXIEsUzi+y/Ws9yBxg2k/Ss90VPSrQGXIL2HIL/KMXmLtGKVkNYEZcGTvGgEncQhLIHlyo708/Bni7sqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mq6CY99z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mq6CY99z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e/fbm7uSRlumFDcoj1Oi6ZdNByqQRSy0W20IDr9swQE=; b=mq6CY99zhNyojgndScrh11m81n
	BtfTyC0YKb/8LNzFccKEvuszJ5aRIPJ+Ks4W4+hrU3+ZEbFG5ZH9H8b9Snrp/AkKi3//ZkMZqzq4/
	KYNdfd2xXSC71UHWFS99YZ1M9HcwySZERLT27B7ZRzEDIky1puvaxdCP0Dg3ufgUm/1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyXTw-001GaV-Qw; Mon, 24 Aug 2026 18:25:08 +0200
Date: Mon, 24 Aug 2026 18:25:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: survive a PHY whose driver arrives
 after the switch probes
Message-ID: <a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch>
References: <20260822155259.87146-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822155259.87146-1-f@lex.la>

Hi Aleksei

I've had time to think about this, and now have a architecture to
solve the problem which i think it better.

It splits into two parts, getting the PHY firmware downloaded and
registered with phylib, and the phylink handling "hotplug" PHYs.

When power is applied to the "PHY", or after a reset, it is not
actually a PHY. It is a microcontroller sat in its bootloader waiting
for firmware to be downloaded. At that point, it has no PHY
functionality. So lets represent it this way in DT:

    davinci_mdio: mdio@5c030000 {
        reg = <0x5c030000 0x1000>;
        #address-cells = <1>;
        #size-cells = <0>;

        reset-gpios = <&gpio2 5 1>;
        reset-delay-us = <2>;

        ethphy0: ethernet-phy@1 {
            reg = <1>;
        };

	mcu: mcu@3 {
	    compatible = "airoha,en8811h-mcu";
	    reg = <3>;
	}

The compatible here makes it an MDIO device, not a PHY device. The
MDIO subsystem will load an MDIO driver for that compatible, and the
driver can then access device 3 on the MDIO bus. That driver will then
poll the filesystem for the firmware and download it. It might need to
do that in a thread, rather than probe(), i don't know.

Once the firmware starts, we have a PHY. And thinking ahead a bit,
there is no reason this MCU is for a single PHY, it could be a quad
PHY. We need to be able to represent this PHY in DT:

    davinci_mdio: mdio@5c030000 {
        reg = <0x5c030000 0x1000>;
        #address-cells = <1>;
        #size-cells = <0>;

        reset-gpios = <&gpio2 5 1>;
        reset-delay-us = <2>;

        ethphy0: ethernet-phy@1 {
            reg = <1>;
        };

	mcu: mcu@3 {
	    compatible = "airoha,en8811h-mcu";
	    reg = <3>;

	    mdio {
	        ethphy3: ethernet-phy@3 {
                reg = <3>;
            };
	};
    };

Have the MDIO device create a new MDIO bus, with pass through
operations to access the underlying MDIO bus, but just for one
address. For all other addresses return -ENODEV. When you register
this MDIO bus, it will get scanned and the PHY found. Since the PHY is
now actually up and running phylib is happy, its usual semantics are
true, the device is ready to go as soon a probe() returns.

As you pointed out, there are currently 3 devices which need to
download firmware. I _guess_ 3/4 of the code can be shared, so please
put must of it into a library, and only have code for actually
downloading to the PHY in the driver.

Then there is a phylink part. This is inspired by how SFP works. We
need some property in the MAC node which indicates the PHY is going to
arrive late. I'm not sure 'hotplug' is the correct description here,
since we know it is there, it is described in DT, it cannot be
exchanged for something else. For the moment, lets just call this
property 'slow-to-probe'. phylink_of_phy_connect() will look for this
property. If it finds 'slow-to-probe', there must also be a phy-handle
pointing to the PHY. phylink then sets itself up to handle this slow
PHY. It needs to poll the phy-handle until it resolves. It can then
call its own phylink_connect_phy() function to connect up the PHY.

As with an SFP, ksetting_get() should return no link modes if the PHY
is not connected yet. ksetting_set() will automatically return EINVAL
when asked to enable a link mode, since none are supported.
eee_get/eee_set should do the same. Since this is how SFPs work, it
should not be too hard to make user space understand an interface can
start out not supporting anything, and then later have various link
modes, autoneg etc.

Please have a think about this architecture, and see if you can find
any holes in it.

    Andrew
