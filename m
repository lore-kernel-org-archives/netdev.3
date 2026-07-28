Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18B3B961A;
	Tue, 28 Jul 2026 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272762; cv=none; b=TBdUsj2S74aMnrZdZTEcCY0TAjpbh1VvpRaKXWr1PcEpGPOh70mVXS2tTP6TNJ6ignY7fAJH5gapR2V5n/1VAO4SVNLbSxwhvwM1NDwkoOnCygSw5W+uRKNw8xm88diT1VIdCbR2Jd/PHszUOnDAgeR1R7e6m9Hy/6csS5lLX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272762; c=relaxed/simple;
	bh=Od0/ctBOxz8BkIinbfn4OQrOVnl1ASbobNH/pQmU5Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6QgsLctZXiUb3YSSMADGDoi63D7eXd5an93CMZmnKv4FB8suAgIk3cjCxliMRBwI9JuD7V5djLo7TqBGjLbDmT+sRN/1iYozrokxCBMEypNevcELxfFLm/FAsPu+PK1SYhzh+i0S7T6jxXBG4jbGTsQc5MKmjzkxEnF0PAn1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gNdEiECb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gNdEiECb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1S0KlBi30seu1JHMXi/GAE2O8nC0cKNZoFH/jteR0VU=; b=gNdEiECbjVmJOW1nH3TJG+PHGD
	LUAPBDKhQtCo/FQjS2JC4OEuiEA7uiSCa7v5ED5vN6g6hJFl0liiogZVsOjPm/t3IJRV3ouP1KiTM
	+78/qTub/DCCqSxi9AiW6lLxSdV7WCC04ztq7Cv81IraZ4U1u6oXWchWJ3VOtxD72wnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woozu-00EhQT-DC; Tue, 28 Jul 2026 23:05:58 +0200
Date: Tue, 28 Jul 2026 23:05:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: netdev <netdev@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: usb: net1080: add error handling to
 nc_vendor_write()
Message-ID: <1caa928e-fb7a-464b-a9af-1135569fd6da@lunn.ch>
References: <19fa888e049.512e8c5e24030.7986824281565553606@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fa888e049.512e8c5e24030.7986824281565553606@zohomail.in>

On Tue, Jul 28, 2026 at 05:12:50PM +0530, Ashwin Gundarapu wrote:
> >From 8c6ffd0b1a5ac33fb6a81cfd4d7d2c54462233bc Mon Sep 17 00:00:00 2001
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Mon, 27 Jul 2026 19:34:16 +0530
> Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write()
> 
> The nc_vendor_write() function currently ignores the return value of
> usbnet_write_cmd(). This can lead to silent failures when USB
> communication fails.
> 
> Change nc_vendor_write() and nc_register_write() to return int
> instead of void, and propagate the error from usbnet_write_cmd()
> back to the caller.
> 
> Also fix the callers in net1080_reset() to check the return value
> and handle errors appropriately. Remove an unused #if 0 block while
> at it.

This patch is doing multiple things. Please turn it into two patches
in a series.

    Andrew

---
pw-bot: cr
