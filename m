Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5B3DBD67
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043054; cv=none; b=CNw8LlD5XJGMUtavKd4kHzhbi3FKQv0yfr9Dmnci9JYTvKeW0atPEdsim3mDuko4sT9CmJ0D2IhMHZHnsczFS5KoHPe6CcbSMm5JjBT/N0cviI2FnpWGxMXCvOx8Vi/13U1xUZu8EUe3seMSWJnsopfputFHPK9fDeAOo1Pv3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043054; c=relaxed/simple;
	bh=P0XTqNHSYh46la0uCM92ORJAtWeJrcW1XVQ0cl+cRTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUXIQ2DddUC9cnPOVSaPmPyshajewGc02Ob+h+o5q4LLqG/ZpIsUFbntXLOD0L/TJfnmLXsq5f5VuCXbMvINLAmA7Gf01y6v7njBTQsPN+uaJ/I7qr6QT/6ggIHHVWYtAknoUoKI3mr/Ig/q3XZF3wydPpFq0zUqrODcw1q6AZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YKvSFQ5h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YKvSFQ5h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZRVHF0u6g1TthdpokXmg97pOdWzzhaalIj5QKlQde34=; b=YKvSFQ5hVmRs76k+UVWJtzB6+y
	0SyhAOeYKSxZFSVkmakO6DvVYtQduvtZkrgO9niH3EY4GgjhzX4b92FIid91WlYGD09b2NFPBjUCQ
	UXFKz/Mob3DK/4dlTIdl2mJNGlSnG2rGR0ILAHqogBbdZqwDErfhrToH4HD5pb4G0PQA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3hdT-00Ce0t-OZ; Fri, 20 Mar 2026 22:44:03 +0100
Date: Fri, 20 Mar 2026 22:44:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Patryk <pbiel7@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: How to approach slow firmware loading process?
Message-ID: <842d9c06-a45e-407e-b817-ee09ffbeb132@lunn.ch>
References: <CA+DkFDbcAqyj2miq7Y4nDfXXMef39WWhcKwowPKBeVH8b6pZVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DkFDbcAqyj2miq7Y4nDfXXMef39WWhcKwowPKBeVH8b6pZVw@mail.gmail.com>

On Fri, Mar 20, 2026 at 05:48:05PM +0100, Patryk wrote:
> Hello
> I've been working on a 10G QXGMII Ethernet PHY bring-up and stumbled
> upon a problem.

It is a good idea to Cc: the PHY Maintainers when you have a PHY
problem.

Also, you were lucky that i even read this, because the subject has
nothing in it to suggest it is PHY problem...

> 2) Then the PHY layer calls the config_init. In the config_init I use
> phy_package_init_once to check whether the common init function has
> already been called. If not then I call the common init function that
> is responsible for broadcasting firmware to all ports of the PHY.
> And this is the place where things get problematic. The thing is that
> loading firmware takes ages... namely around 30 seconds, which results
> in the boot process waiting for config_init to complete its execution.

This is not a simple problem to solve, apart from buying some FLASH
for your PHY chip :-)

Historically, PHY devices have not needed firmware downloaded. This
lead to assumptions being made about when a PHY is assumed to be
usable.

MAC drivers typically connect to the PHY in open(), not probe(). In
probe(), if the PHY has not registered itself yet, because it is still
probing, i.e. downloading firmware, you could return -EPROBE_DEFER and
get the core to try again later. In open() it is too late, you cannot
return -EPROBE_DEFER you have to fail the open() which is not supposed
to happen.

And as you pointed out, phylib assumes that as soon as
probe()/config_init() returns, the PHY is good to go. So if you did
return from config_init(), with the PHY still downloading firmware,
you are going to get into a bad situation later on.

There are a few things you can try to speed it up.

Check if the MDIO bus supports running at a faster speed. A few
drivers support the "clock-frequency" property. It should default to
2.5Mhz. But many PHYs will works at higher speeds. Check the
datasheet. It might be the MDIO driver you are using does not
implement this property, and you will need to see if it can be added.

I've achieved 3x speed up playing around with this.

Another thing you can sometimes do is disable the preamble. An MDIO
bus transaction starts with 32 bits of preamble. But some PHYs are
happy without it. If you can turn it off, you send 50% less.

Combine these two, and you can get a 6x speed up.

Another thing to do is check the maths. One C22 MDIO transaction is 64
bits. Assuming a 2.5Mhz clock, you can work out how long that
takes. Look at the download protocol, is it efficient, 1 transaction
for very 2 bytes? You can work out the theoretical time it takes.
Then compare to what it actually takes. Because normally very few MDIO
bus transactions are performed, the implementation is not always
tuned. Sometimes the polling for the transaction to complete is too
large, for example. So you might be able to make the basic write
operation faster.

       Andrew
