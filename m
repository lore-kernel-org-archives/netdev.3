Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB953FD12A;
	Tue, 28 Apr 2026 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384536; cv=none; b=mXSfcwpk3ek8mKFNev9LtP64DouXA5tWujLgzDHzIZ2to0XHmVcVirrgaJ77PM1J9hIZRvPbUkbaULeROFbF+qXi7sdc9ibIKTa0bQyXOTu8cLBb4L48LHYLmnIpGR5HqZiPHhiwgJFpu+ge9XlQGOKFEz1jWp0vUiPmKLRL5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384536; c=relaxed/simple;
	bh=9teX/ayshIKIg1n/txxmxqU6bfzrQyhFSl1fkUIRnaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfwNYOLQNDrGU2PLmYkYHuHHA4+xMtgDXCb2fsq808HlQAiv/jITPfcgap+HqNqYco2dLBmjXfCg6yijBiR9N0gZxwqKoN1rDhvMT3grHe5+MmPOGNqPsG0Wl/O4UxIbnSoOHdBXqaZTuiC1+sP6FBloHpRpPaWULSVtp70zCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X//i7rbC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X//i7rbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975F7C2BCAF;
	Tue, 28 Apr 2026 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777384535;
	bh=9teX/ayshIKIg1n/txxmxqU6bfzrQyhFSl1fkUIRnaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X//i7rbCW8FPua77hzSpvxjOVUNbdOhUsBIRlImiLxjTrN1Xep/awe8P5UluvZYO5
	 guIxLpjdU8MLSJoRho4FzvbdVvFVEMHfBcu/KMtNbXhjBZ9Xqf/4a/9NqMwJTiyxFm
	 jrctQ7fgxsjrB1Fx7nN9DXmEXY2ZPZUbyCQqBPz8=
Date: Tue, 28 Apr 2026 07:54:51 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <2026042802-bobsled-envy-8e56@gregkh>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <2026042848-cubical-penalize-807c@gregkh>
 <20260428120314.GR557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428120314.GR557136@black.igk.intel.com>

On Tue, Apr 28, 2026 at 02:03:14PM +0200, Mika Westerberg wrote:
> On Tue, Apr 28, 2026 at 05:57:37AM -0600, Greg KH wrote:
> > On Tue, Apr 28, 2026 at 09:22:09AM +0200, Mika Westerberg wrote:
> > > Introduce USB4STREAM protocol and Linux implementation. This allows two
> > > (or more) hosts to transfer data directly over Thunderbolt/USB4 cable
> > > through a character device without need to go through the network stack.
> > > 
> > > Any application that supports read(2) and write(2) in some form should
> > > be able to use the device without changes. The data is sent out to the
> > > other side over a tunnel inside Thunderbolt/USB4 fabric. The character
> > > device is called /dev/tbstreamX where X is the minor number starting
> > > from 0.
> > > 
> > > All stream devices need to be configured first. This is done through
> > > ConfigFS interface. There can be multiple streams at the same time (this
> > > depends on number of DMA rings and available HopIDs) and a single stream
> > > supports traffic in both directions. For example there could be an
> > > application that uses one stream as control channel and another one as
> > > bi-directional data channel.
> > > 
> > > A real use-case for this is to take a backup as a part of recovery
> > > initramfs tooling (no need to setup networking or have ssh or similar
> > > tooling as part of the initramfs). Say we want to backup the disk of
> > > host1 to host2. First Thunderbolt/USB4 cable is connected between the
> > > hosts (there can be devices in the middle too) then the receiving side
> > > configures the stream:
> > > 
> > >   host2 # mkdir /sys/kernel/config/thunderbolt/stream/0-1.0
> > >   host2 # mkdir /sys/kernel/config/thunderbolt/stream/0-1.0/backup
> > >   host2 # echo -1 > /sys/kernel/config/thunderbolt/stream/0-1.0/backup/in_hopid
> > >   host2 # echo -1 > /sys/kernel/config/thunderbolt/stream/0-1.0/backup/out_hopid
> > > 
> > > We use automatic HopID allocation (writing -1 to HopIDs) for simplicity.
> > > >From this point forward the /dev/tbstream0 can be used pretty much as
> > > regular file:
> > > 
> > >   host2 # dd if=/dev/tbstream0 of=/tmp/host1.nvme0n1.backup-$(date +%F) bs=256k
> > > 
> > > The host that is being backed up then configures the stream accordingly:
> > > 
> > >   host1 # mkdir /sys/kernel/config/thunderbolt/stream/0-503.0
> > >   host1 # mkdir /sys/kernel/config/thunderbolt/stream/0-503.0/backup
> > > 
> > > Here we take advantage of the fact that host2 also announces the active
> > > streams through XDomain properties so the name "backup" gives us the
> > > HopIDs. It is also possible to configure them manually in the same way
> > > we did for host2.
> > > 
> > > Then it is just a matter of copying the data over:
> > > 
> > >   host1 # dd if=/dev/nvme0n1 of=/dev/tbstream0 bs=256k
> > > 
> > > Similarly it is possible to transfer parts of the filesystem. For
> > > example copy contents of mydir over to the host2:
> > > 
> > >   host2 # gunzip < /dev/tbstream0 | tar xf -
> > >   host1 # tar cf - mydir | gzip > /dev/tbstream0
> > > 
> > > Other end of the spectrum use-case is "borrowing" laptop (host1) camera
> > > to desktop (host2):
> > > 
> > >   host2 # gst-launch-1.0 filesrc location=/dev/tbstream0 ! jpegdec ! videoconvert ! \
> > >                          autovideosink
> > > 
> > >   host1 # gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw,width=1920,height=1080 ! \
> > >                          jpegenc quality=90 ! filesink location=/dev/tbstream0
> > > 
> > > Once the streams are no longer needed they can be removed:
> > > 
> > >   host1 # cd /sys/kernel/config/thunderbolt/stream/
> > >   host1 # rmdir -p 0-503.0/backup
> > > 
> > >   host2 # cd /sys/kernel/config/thunderbolt/stream
> > >   host2 # rmdir -p 0-1.0/backup
> > 
> > Very cool, but shouldn't the above be in some documentation somewhere so
> > that people know how to use it?
> 
> Sure, I can add it part of the Documentation/admin-guide/thunderbolt.rs for
> example.
> 
> > And why do you need a whole major for this, why not just use a misc
> > device that it dynamically created for every new dev?
> 
> We do use this:
> 
>        ret = alloc_chrdev_region(&tbstream_devt, 0, TBSTREAM_DEV_MINORS,
>                                   "tbstream");
> 
> that should be dynamically allocated, no?

Yes, but you are using up a whole major number for this, and in reality
there's only going to be 1-2, maybe 4, different devices needed at once,
right?  So just use the miscdev interface instead?

thanks,

greg k-h
