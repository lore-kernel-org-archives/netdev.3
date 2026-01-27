Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A830B507;
	Tue, 27 Jan 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519053; cv=none; b=q92liZSgzYdRNBPh1Id4jIKdB5gGF0okQSwbqoCanewYPk/PSOTtVJr/87jpHyGyLGc8NTid5ftHE9mHI/m8bPrI7kidXaLEuKqsgq39oIzPs9i9HqjFG8UnpDSzTb0M4ipaHc624kiINnZn9jKV4hzL2/yswbHFr5NEjaMUOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519053; c=relaxed/simple;
	bh=/sMNo49PvxYnv+gACGRWMhDyPZWVliso0khkMIowWiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgQ93uIE78HbXBdb9w2vCFlgN05IuGXNC9XBYKIJejq/vxpmoR7Xu8WbC5h8/Es4GBQ6uwkXDzud2IXIHqzAlXbDi6XM8m/eY/CKirExALkjd2eyqchznSSLYn/2MBXIaZhhjMTTpMpuqtlAxwBWZJygONOC7cp6dbkL1ZXuHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wfpN1R+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wfpN1R+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679BCC116C6;
	Tue, 27 Jan 2026 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519052;
	bh=/sMNo49PvxYnv+gACGRWMhDyPZWVliso0khkMIowWiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wfpN1R+4XJxAMiXao95NhpGQpxFnQhSRBi9rUuVvcajobNX9C4x1oPwc1/32SMv3L
	 5j0Kc5Fgs2he2j9JpEhYPsA7iZsj+JXcrFsXYvQktBMWiFWKa5YvtjsmpTbi9oUemm
	 5OCOpFqtwLK8WUD05UmwDCmpWkGojI450ajPD658=
Date: Tue, 27 Jan 2026 14:04:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivan <kernvirt@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] r8152: Tx timeout and xHCI setup device timeout. RTL8153
 31.00
Message-ID: <2026012758-dedicate-desecrate-358a@gregkh>
References: <CAOf3c5fDit7nvfWUGf+f5Ctmfr9ebg6KqiwZhZYusHyFaeE5CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf3c5fDit7nvfWUGf+f5Ctmfr9ebg6KqiwZhZYusHyFaeE5CQ@mail.gmail.com>

On Tue, Jan 27, 2026 at 03:36:44PM +0300, Ivan wrote:
> Hello
> I am reporting a persistent hardware hang issue with the r8152 driver
> on an Ryzen 5 7520u (Mendocino) using a usb type c hub.
> 
> The Ethernet connection can drop at any time. After the connection
> fails, the Ethernet adapter itself disappears from the system, but the
> other USB devices in the hub continue to work.
> USB_QUIRK_NO_LPM (0x400) is enabled by default, but it doesn't help.
> 
> Environment:
> CPU: Ryzen 5 7520u (Mendocino)
> Kernel: 6.18.6 (arch linux), 6.12 lts (gentoo)
> Ethernet chip: rtl8153 0bda:8153, bcdDevice 31.00
> 
> I have attached the relevant journalctl logs and the lsusb -vd for this device

There's no timing in the log, so it's a bit hard to determine this, but
it looks like the device is locking up and there's nothing we can do
about it from the kernel side:

asus kernel: r8152 4-1.1:1.0 enp3s0f4u1u1: carrier on
asus kernel: r8152-cfgselector 4-1.1: Failed to read 4 bytes at 0xe820/0x0133 (-110)
asus kernel: xhci_hcd 0000:03:00.4: Timeout while waiting for setup device command
asus kernel: r8152 4-1.1:1.0 enp3s0f4u1u1: NETDEV WATCHDOG: CPU: 4: transmit queue 0 timed out 6129 ms
asus kernel: r8152 4-1.1:1.0 enp3s0f4u1u1: Tx timeout
asus kernel: xhci_hcd 0000:03:00.4: Timeout while waiting for setup device command
asus kernel: r8152-cfgselector 4-1.1: device not accepting address 4, error -62
asus kernel: r8152 4-1.1:1.0 enp3s0f4u1u1: Get ether addr fail
asus kernel: r8152-cfgselector 4-1.1: USB disconnect, device number 4

So perhaps the chip itself is the problem?

sorry it's a bit hard to determine what is really happening here but it
seems like a flaky device.  Is it overheating?

thanks,

greg k-h
