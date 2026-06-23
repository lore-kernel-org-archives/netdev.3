Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361ED3CF698;
	Tue, 23 Jun 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204978; cv=none; b=CA2bmK1tP4gdk6SKXs6yww9Droroqioc2ZHxSlOFIlZAekNERDI2YZ/zEeflz9XHc8WfNqzjLphKqED/gpB5iXYDAVEgPb7gub3dPXwNyOxZy/iWqkHTNfoKt8tSxl2JCNLNdDYp2ylP3zqCw9tST0Ukfy1gnfTGAnBhAs7lGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204978; c=relaxed/simple;
	bh=lasrUOmRtOf0H23ugUHsADC0umSxAmfD5tw+nrWTFto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/Wt+arzveL6LU33uAPZw1SJ8KdEbloP+IyYe+rGp26ep8lXnxSOFccF1/msntoCn8FKk7VvhGrsj8c1vGk/zNeBg3lNHTJssF+ZEZizST4KsvXODk31H5YIkSTSwVpF4DDpnzWbXQrbf41deM6fvwHLMAMiccfB+2I/6adXIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rkhWL3XM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rkhWL3XM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mg7Wg/0MzYEsVNjhs2fAO/oE9tCQV5P3j5pPw8Luxn4=; b=rkhWL3XM/52kS4/EBE6dLkbNfI
	IvdxEEzbch5JH1nffo6mYQWxnTE9BbQDSNNse8Jzi+//CE+Xi/zfWUl2iaUQ3eOxMGVAjkGo1Mfkp
	3YoPykMULXUW4CkMXaYjDJ+Fjh0H80kKI1HaGbJSTax+K4RE/Cbh0Q8WDds9vnPh+99Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbwvW-008vX5-Sh; Tue, 23 Jun 2026 10:56:14 +0200
Date: Tue, 23 Jun 2026 10:56:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] atm: fore200e: disable PCI device on DMA mask failure
Message-ID: <16ca6db2-6cf1-4f49-a77a-62bde8341b50@lunn.ch>
References: <20260623075405.47120-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623075405.47120-1-mhun512@gmail.com>

On Tue, Jun 23, 2026 at 04:53:56PM +0900, Myeonghun Pak wrote:
> fore200e_pca_detect() enables the PCI device before setting the DMA
> mask. If dma_set_mask_and_coherent() fails, the current error path
> returns without disabling the device.
> 
> Reuse the existing out_disable unwind label for this failure path so
> pci_disable_device() is called after a successful pci_enable_device().

What tree is this against?

ommit 6deb53595092b1426885f6503d93eedc1e3ece77
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Mon Apr 20 13:42:28 2026 -0700

    net: remove unused ATM protocols and legacy ATM device drivers
    
    Remove the ATM protocol modules and PCI/SBUS ATM device drivers
    that are no longer in active use.
    
    The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
    drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
    over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
    The Solos ADSL2+ PCI driver is also retained.
    
    Removed ATM protocol modules:
     - net/atm/clip.c - Classical IP over ATM (RFC 2225)
     - net/atm/lec.c - LAN Emulation Client (LANE)
     - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
    
    Removed PCI/SBUS ATM device drivers (drivers/atm/):
     - adummy, atmtcp - software/testing ATM devices
     - eni - Efficient Networks ENI155P (OC-3, ~1995)
     - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)


Please subscribe to the netdev Mailing list, so you know what is going
on.


    Andrew

---
pw-bot: reject
	
