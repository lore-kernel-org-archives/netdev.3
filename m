Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09E35AC1B;
	Thu,  2 Jul 2026 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016164; cv=none; b=Es4cUqQxrX7Bf49/rD5mLRBWcKGOsJsYj+wcrOODEekZOT4/P/SaFTBz6YMwjk3sK8rbhiCTcMSkthIkvgkL8ffx8zL1VMzgM5VBXCuAiU4Ng8LpZdhNwD7FciLwViplbZIG3vdTzMJhSvczhmDuAXsSCnSQKT0sVhNIOmAx8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016164; c=relaxed/simple;
	bh=LFvbGG8e4RDOCrVe8X6kQOiiTYRB7+xbDmzgPNCW8Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw22d0QEOthaLT37WdHR1fzmovrgR+uOFA/4zU1h+YccDdIWCY+geu9xWe0K0E9gseN9Ty2hN2SaYGu6mjY9+MWxyZxrjjg80WCTyayJZ2rXZT6YKbhjZR/ZFFhjcRHoOwtjdzaBDIaHXkRQWfih6aTnMG5UhQlMvwWRYyz+P4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4cVrgA+f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4cVrgA+f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LI6AQYqAXXfUGAx8sXzR8t6YKhCEMxoGaSCmbpo2oFY=; b=4cVrgA+fm4JS9rc+29oYYvOEc/
	Cyb67qQhlJDwBY3sdXCePDZfNJHJR7PnvIzA84C4PNvFYXI3tUn15VnGuyBiGF12/AtMKJIE6L2l2
	B6I/9VVSamFMdRRj6XqwzA/hkEBk6dylWiYW7bC4cISr7g1kdRG51U/7NWjPISEqW9y8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfLx0-00APrj-Vm; Thu, 02 Jul 2026 20:15:50 +0200
Date: Thu, 2 Jul 2026 20:15:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shaoxul@foxmail.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: usb: move exported code to usbnet
Message-ID: <ea92d680-39f6-4dde-b558-4008ffbee587@lunn.ch>
References: <20260702143142.890654-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702143142.890654-1-oneukum@suse.com>

On Thu, Jul 02, 2026 at 04:25:29PM +0200, Oliver Neukum wrote:
> Some drivers are reusing common code originating in other drivers.
> This means that two drivers need to be loaded for one device.

Maybe consider using 'framework' or 'library', rather than driver,
when referring to the shared code?

I tend to think of a driver as the leaf node which probes based on
enumeration of a bus. But usbnet.c itself is never probed.

	Andrew
