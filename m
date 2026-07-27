Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4301E1DE5;
	Mon, 27 Jul 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163349; cv=none; b=D+c6dBPjGKUhU1eHU2FZkG7Kg7TAh6iuxAO+b9SpT7EHSuZxfgdO24u35hWfcZ5JKPYzDl/3SPlwE/Hv/O+4ltn9pku41xYimurjioF+HWoEZXK0inJerH9cIEeBu2kR5crFeohzvcIonG85Hc/iSMs5ir3t0cQ9Li170QTW1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163349; c=relaxed/simple;
	bh=HMh+F3nPUq6HwxDQ+GhoBXq4JZZnF/6l++dectVR2w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO7m+l8u0knGXoQBL88GujQifyTKwijvsJlBjQIFwtAa/TQPUsw8da/ucFQmcaJmIWb6ziN6Zg0hQOPwu4XzMgp6x6ezwNDs0SwNW7m5/IDORQSSWS0QHlsbpdQ2X8SplguLnq/okG7rZswbL3JrDFViuaCILRAXEp+TK8OctNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N5nAtw4H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N5nAtw4H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=49DCf6xkbdU2FC6tupY1A21cMRMTvs+tEMbewY0Dk4c=; b=N5nAtw4HJWK9QBragfitp6iVfS
	//8mTHg9rvsvMM58B+8LkQtaDnGspvBIP8q0/6czDsUPUiTQq4LX9k5gZ/hJSf5C8Y/vlMhiDUWtm
	++X7g5QFCUKbU/sgYiS08smVWy/xUDeqtev8ji6q7wz4jzWaFmuStqAsaEzBq4jdKwHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woMXA-00ERVe-KZ; Mon, 27 Jul 2026 16:42:24 +0200
Date: Mon, 27 Jul 2026 16:42:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: netdev <netdev@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usb: net1080: add error handling to
 nc_vendor_write()
Message-ID: <54bf0103-6ed1-46db-921a-fc09a6cc0555@lunn.ch>
References: <19fa3e79cfe.894831784405.7828961255432177577@zohomail.in>
 <19fa3f028d9.fe65e7a4540.8296440890414077743@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fa3f028d9.fe65e7a4540.8296440890414077743@zohomail.in>

On Mon, Jul 27, 2026 at 07:47:33PM +0530, Ashwin Gundarapu wrote:
> >From 70278069430a8b7d71728bc3c24400dc2bdffb63 Mon Sep 17 00:00:00 2001
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

The caller being:

static int net1080_reset(struct usbnet *dev)
{
	u16		usbctl, status, ttl;
	u16		vp;
	int		retval;

	// nc_dump_registers(dev);

	if ((retval = nc_register_read(dev, REG_STATUS, &vp)) < 0) {
		netdev_dbg(dev->net, "can't read %s-%s status: %d\n",
			   dev->udev->bus->bus_name, dev->udev->devpath, retval);
		goto done;
	}
	status = vp;
	nc_dump_status(dev, status);

	if ((retval = nc_register_read(dev, REG_USBCTL, &vp)) < 0) {
		netdev_dbg(dev->net, "can't read USBCTL, %d\n", retval);
		goto done;
	}
	usbctl = vp;
	nc_dump_usbctl(dev, usbctl);

	nc_register_write(dev, REG_USBCTL,
			USBCTL_FLUSH_THIS | USBCTL_FLUSH_OTHER);

which just ignores the return value. How is this better?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
