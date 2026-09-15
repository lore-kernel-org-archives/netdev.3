Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA33D34AC;
	Tue, 15 Sep 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488951; cv=none; b=LPElEQcPgxUMXUmhKWP2HM4bcRue6D3x/AyIQPNiWFTsOcN/0fJZmVGbFXPKgw/rb3633wfUDZfHjH8Li8IvHkZzhKwfH/mk5ek8E730Vr3Aw+DZSAMv6pouubNh7SuAw0ZBUTyZshdacPqWvxdQPcO3QbnkAjBWzp4DxZSmMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488951; c=relaxed/simple;
	bh=3dCgZsXXFqxTaTo1sT9khmwGORVN1rwXRG7jp1rvIgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQqXCOmdy+0WOoJi7uPZ+6PLNL6P1oYGkfKvMvguol9BTtNeKfFWiz0heGklqDytpwLQO7Hz0S3mVE3MPoguqEiQXdKNGyyJTJrB9tDrXHZaOJlAxyF1TfPoSONq7GtEEzg1ssEvMPtvONCE0cJntz99S8HNTKFmVuneewCxOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=flTsLXLE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="flTsLXLE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P3Hgjw7laGOWScI+sHbX1ErTzip/jWvwqQPcLsTDwxk=; b=flTsLXLEu02Sg//bmouBFb7T4s
	lU79ILbCW7JCGM+m4uq7BS8/U/AnqH39tgkBc2PZJ6YJiGTjGSRgVpkhGafktUwPKh7dw7+UZIkot
	P7BVzI5NaDqf+qUBS0et9u7MYqkpMKMeuoH5kZofjgt+BSa6Po8Uf5U91ixJA+I3edvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6Vom-005JM1-PV; Tue, 15 Sep 2026 18:15:36 +0200
Date: Tue, 15 Sep 2026 18:15:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: axienet: add a TX timeout handler to
 recover a lost DMA interrupt
Message-ID: <6acfc82e-7690-4759-90df-22b64a5441ba@lunn.ch>
References: <20260915065534.102249-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915065534.102249-1-maimon.sagi@gmail.com>

On Tue, Sep 15, 2026 at 09:55:34AM +0300, Sagi Maimon wrote:
> axienet_dma_err_handler() is the driver's only reset path, and the only
> two places that schedule it are axienet_tx_irq() and axienet_rx_irq(),
> both on the XAXIDMA_IRQ_ERROR_MASK branch.  Every route into recovery
> therefore depends on a DMA interrupt being delivered.
> 
> If a completion interrupt is lost the queue stops making progress with
> descriptors unreclaimed, and nothing ever schedules the reset: the error
> branch cannot run because no interrupt arrives, and NAPI is not polled
> because it is only scheduled from those same handlers.  The interface
> stays wedged until the driver is unloaded.
> 
> Add an .ndo_tx_timeout handler so the netdev watchdog provides a route
> into the existing reset path that does not depend on the interrupt that
> was lost.  The handler only queues the work; axienet_dma_err_handler()
> then performs the reset in process context, as it already does for the
> error-interrupt case.
> 
> .ndo_tx_timeout is added to axienet_netdev_ops alone.  On the dmaengine
> path lp->dma_err_task is never initialised - INIT_WORK() for it lives in
> axienet_init_legacy_dma() - so scheduling it there would be a bug, and
> watchdog_timeo is set in the same branch for that reason.
> 
> Tested on a Xilinx AXI Ethernet MAC by clearing PCI_MSIX_FLAGS_ENABLE
> underneath a running interface to drop completion interrupts: without
> this patch the TX queue stalls permanently, with it the watchdog fires
> and the interface resumes passing traffic.

Have you seen the hardware wedge without faking it by clearing
PCI_MSIX_FLAGS_ENABLE?

	Andrew
