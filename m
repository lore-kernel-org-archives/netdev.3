Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AB3E3142;
	Thu,  9 Jul 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590207; cv=none; b=utAkjkqqc6HaWiEb/9XsqXk6/2NerqxGKuqskYWoELepjN18utPKmmwb0RufF1OwzSf8aBPoQz7r9WWP5YIBqe5+NhQeANhq6v4vV0LJfDey3pDp5xRyj+XldmJw9f8pVLXg+ADBa4qn2nTFIV2LMewOty5yEBfwBX4oFbraLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590207; c=relaxed/simple;
	bh=0jcnfEcNzuF2aaI+oTB0yec5mlAuEeNt4FMCRkykrww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3mBl+8swG4M/m29Ch5PxLVT+PYSpdNWAACE3WFHcwc4jYwsllkFkXJYy2P3GFVc1Q9xQmipoX+8QTBJjtg9ipddtpRmbJZG27BzRZbzstnbXzbijwHq5lFlZrbtCht0UgkbBVm1cGW2/6ScrVcKO75eCC1q5NEs3NBq2nTioDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1whlHq-000000005Uq-3AXh;
	Thu, 09 Jul 2026 09:43:18 +0000
Date: Thu, 9 Jul 2026 11:43:03 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <ak9tJ0NGMu2rvnlc@makrotopia.org>
References: <ak0KOrM5E2_sPIHf@makrotopia.org>
 <42792433-a95c-431f-ba0c-dc0644dcbdb5@lunn.ch>
 <ak6s363rweBPZhQZ@makrotopia.org>
 <b3fc69ba-9139-4933-9a4f-455393a7cfaa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fc69ba-9139-4933-9a4f-455393a7cfaa@lunn.ch>

On Thu, Jul 09, 2026 at 01:24:49AM +0200, Andrew Lunn wrote:
> On Wed, Jul 08, 2026 at 10:02:39PM +0200, Daniel Golle wrote:
> > On Wed, Jul 08, 2026 at 07:27:21PM +0200, Andrew Lunn wrote:
> > > > + * The flash process takes approximately 15 minutes. Progress is
> > > > + * reported via devlink status notifications. After a successful (or
> > > > + * failed) flash the driver reprobes the device automatically.
> > > 
> > > Have you tested the failed use case?
> > > 
> > > I assume if the firmware in the flash is invalid, the bootloader does
> > > not boot it, and it remains in the bootloader waiting for another
> > > attempt. Does this DSA driver still load, so devlink can be used to
> > > try again?
> > 
> > No. Without a running the firmware the driver doesn't probe and only
> > a special rescue tool allows to recover the hardware.
> > Having the DSA driver detect the presence of the switch stuck in
> > mcuboot mode and probe without registering any user or CPU ports
> > also isn't straight forward.
> 
> And that special rescue tool exists?

Yes, but it's basically a custom bootable Linux image, based on a
patched/old Linux Kernel and vendor SDK driver.
It cannot just run from userspace because (apart from the out-of-tree
mdio-netlink API) there isn't any standard way to access the MDIO bus
from userspace.

> Why not wrap it in a script which unloads the DSA driver, let it do
> its thing, and then reload the DSA driver?

It would need to be yet another driver binding the device on the
MDIO bus, check if the mcuboot C22 MDIO interface responds and if not
fire the firmware API request to put reset the device into mcuboot mode.
And this, issueing a firmware API command, is why it is easier to make
it part of the existing DSA driver which already got a robust and
endian-safe implementation of the firmware API protocol.

> All the other users of devlink flash that i know of can operate while
> the device is still running. So it makes sense for it to be part of
> the driver, it is something just going on in the background. This
> device is different, so i don't really see the advantage of making it
> part of the driver.

The controlled teardown/reprobe/reconfigure as well as the ability to
issue the reboot-into-mcuboot firmware API command are good arguments
imho.
