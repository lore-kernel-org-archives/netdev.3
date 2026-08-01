Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC61F2380;
	Sat,  1 Aug 2026 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567957; cv=none; b=SqaSv4tipCMTBN65rm1DSezHNfG5Rv0Gtf807PVhpEjFPOMVNURWhEo7Ct0g+4JNNSYeJylV2x1wbyt1UGYIadyhyBGxpDooBF+7AdRIurgNZT/BfowqJ8ERuLUPExbZ8N/r6lxvFGRPeaAzEy2aro4eC90cwbF9DI4JaLVUtuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567957; c=relaxed/simple;
	bh=erzK1Th2TBoaCTR5UTV+1STaCBFMqSv6dq0OdLjJTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqPV5MJrCI2rwMXHKHMOHoyC+IADtwbnA9ZkAsHuh3P5tQR191lxyAqeWFLyx7ncSKoFWbZP92QLIwfAhCPMAW+FFz+S4tblMyc/lLBUDv4VDDakdf0+4x9LOAb18ai+18siuUmo3ZuunXCrxJPMQ+fPSUAMbEjHkeVM5b/gUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d4Z2knDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d4Z2knDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42401F00AC4;
	Sat,  1 Aug 2026 07:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785567955;
	bh=zAMd2B8bpOnhUlWUOEOiC7iQATpEbu0ud9L1Bvwwy1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4Z2knDYNCMkK01SJ33shztf5LzPqcLtv4ULsXPiVzrzxfncwrMEBRrKX19uvova+
	 thHtddor+n5utTmSetK+UC9y3Qkmi3h0WFbT7vwiJJcci6bR5iaEfcFSoopHz4HKjZ
	 5aqW7hqFs7H3ETR5HCtaRYiAoqx5Y3QC5X3gIyd4=
Date: Sat, 1 Aug 2026 09:04:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pablo =?iso-8859-1?Q?Vallesp=EDn?= Aranguren <pablopva014@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:TULIP NETWORK DRIVERS" <netdev@vger.kernel.org>,
	"open list:TULIP NETWORK DRIVERS" <linux-parisc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: tulip: xircom_cb: drop runt frames before skb copy
Message-ID: <2026080158-next-diligent-b4ce@gregkh>
References: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
 <20260731202629.10ff97e6@pumpkin>
 <am0L4gNtPJaMPx_9@ThinkPad-P15>
 <20260731165555.50741429@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731165555.50741429@kernel.org>

On Fri, Jul 31, 2026 at 04:55:55PM -0700, Jakub Kicinski wrote:
> On Fri, 31 Jul 2026 22:56:02 +0200 Pablo Vallespín Aranguren wrote:
> > > Have you checked that that hardware can actually set a short value?
> > > I'd expect that packets shorter than 64 bytes (including the crc) are
> > > dropped as 'runts' and probably don't even use a ring entry.  
> > 
> > I haven't verified how the real Xircom firmware handles runt frames (I
> > don't own this hardware). I tested with Qemu's emulated NIC, the device
> > itself does validate and reject negative-size values before sending them
> > to the driver.
> 
> Are you related to Greg KH in any way? You use the same slop tag.
> Just curious.

Pablo is part of an CS masters intern project through vu.nl that I'm
running to help audit and submit LLM-found issues against the kernel.
Hence the gkh_clanker tag, as my bot is the thing that originally
"found" this report.

> Please send a patch to delete this driver if you want to help.
> It's ancient.

No objection from me, that fixes all of the issues!

Pablo, want to submit a patch for that?

thanks,

greg k-h
