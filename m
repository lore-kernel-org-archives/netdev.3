Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E52ECD32;
	Tue, 11 Aug 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467249; cv=none; b=ktAarobk9R1R4UpAQyBvyHhEjpR0ry/MpwgvOqTuQf6kFDzhjPfJu9pfuqDm9PoJRTYyc112jszjlTAEv0OSow+BPPeK8cF/MglO38x6gWAhcL3rw5yLBQX27V6sGqQw4MyRIx8huGtwIFNW70DlPA7icfugTwg8kCyMWHFRKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467249; c=relaxed/simple;
	bh=J+8f8VdFlqno8KOp8oAJhpLpmTOk2ot/HH8tyVoPDKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZFm2bq2IrFylvJA6QLzzA+XzQ86E+AZi4BibNvOvw+vRBTRiRkJ+brHz6qB/5ptpF67tky5kjYSRNddfRO+swvs5FNhA9FdJU1+U2Xr0lSnXmjpubX9URbMuFDRkW1FodK+7y2BHa0QPDHMTjk6xGRlbrmndI9IWkTRghlpJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uIUrd/ZA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uIUrd/ZA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NVNhdZBfHZby8z9L2Q7rYgiNbqq2wAlCzjhxu04hhJk=; b=uIUrd/ZA87XZB5AerIzkeHK7eZ
	XkQFf/KGV7L4+5xJZZ2WxWAQ7PXNMujj+uCNm0R21AY0vxBJEjeCWdMtwemn8CFU9PqtJ8ClSmGY5
	DZrsKovDRHjRausnak27cQwr15mmFUulE7CkuU64LY1pHcBPO8cq1jkzf+lDWbvY01kE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtpje-00H7xB-Lr; Tue, 11 Aug 2026 18:53:54 +0200
Date: Tue, 11 Aug 2026 18:53:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: natsemi: ns83820: Fix use-after-free in
 ns83820_remove_one due to race condition
Message-ID: <0bb90a8c-0b27-415d-9add-1398fca17304@lunn.ch>
References: <da666a865879cf17574fb724242c742d081c4a3b.1786416553.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da666a865879cf17574fb724242c742d081c4a3b.1786416553.git.xiaopei01@kylinos.cn>

On Tue, Aug 11, 2026 at 10:51:47AM +0800, Pei Xiao wrote:
> In ns83820_init_one, &dev->tq_refill is bound with queue_refill, and
> ns83820_rx_kick can schedule this work on system_wq when it is called
> from the IRQ handler ns83820_irq (via ns83820_do_isr) or from the rx
> tasklet rx_action.
> 
> If we remove the device, ns83820_remove_one makes cleanup and the
> memory allocated for dev with netdev_priv() is released by
> free_netdev(), while the work mentioned above may still be pending or
> running. The sequence of operations that may lead to a UAF bug is as
> follows:
> 
> CPU0                                      CPU1
> 
>                                           | ns83820_irq
>                                           | ns83820_do_isr
>                                           | ns83820_rx_kick
>                                           | schedule_work(&dev->tq_refill)
> ns83820_remove_one                        |
> ns83820_disable_interrupts(dev)           |
> unregister_netdev(ndev)                   |
> free_irq(dev->pci_dev->irq, ndev)         |
> iounmap(dev->base)                        |
> dma_free_coherent(...)                    |
> free_netdev(ndev)                         |
> // dev is freed                           |
>                                           | queue_refill
>                                           | // use dev (use-after-free)
> 
> free_irq() only prevents the IRQ handler from running again. An rx
> tasklet that was already scheduled by a previous interrupt can still
> run afterwards, and rx_action calls ns83820_rx_kick, which can
> re-schedule tq_refill on system_wq. This leaves a window where
> queue_refill can still run after free_netdev() has freed dev.
> 
> Fix it by stopping the sources that can schedule the work, in order:
> unregister_netdev() and free_irq() stop the IRQ handler, tasklet_kill()
> waits for the rx tasklet to finish, and cancel_work_sync() then drains
> any work that was queued before proceeding with the remaining cleanup
> in ns83820_remove_one.

Is this change tested in any way?

   Andrew
