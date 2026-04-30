Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524F2417D1;
	Thu, 30 Apr 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558782; cv=none; b=iOuDCR8Iqk2oB8/1bRLDrVm6Mf0O6aWAFuB33IKBo2J0TBVp1uASI/6713Fq1pNdTKsAb+tDkbVHNeUJpPbFXFwsV3tP2VSrb9DbUcTKYHcC9LBJ7Ag4H7mo2jeCN7jZUaGKeXEBXI4Sc3OjoY1pJ8KaJbQ36U8gatybBn1VoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558782; c=relaxed/simple;
	bh=AWX9jAGWykXF91wY2ndunvZcL/XLos2lreupCLe9wis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmtXOcp59uKpDHjO86iIvI5uFI5PLiSgWHx0LNWz+Yguh4HHspS2witv8GD9j4GwanT354/yBZxdLNzHrQlZI0JYAHmyhL8IQVIq6bwhcP95Re8dE3mMKrqiLXYlQkR9FAx5UjqboRQ5mWhecVeA+oihRCzIjts3Gps3C0AisnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TEnDmfpZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TEnDmfpZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zsgPDUbJfBPKH1Tuq2IW5151E1Ba4vIY34mQtMpCrU0=; b=TEnDmfpZooRRGOy812VdIZR9fV
	jmDGZTHBQ5xuWaQj7u3U+nHcwU092ow3Ur6DeL9hkFJrl8Jf4uVl1lZY5+d8BT5fG29TUgvqf7FdK
	g3BLv6VzxS/rP2FbI2ydIAyGpscJR3E6PhVk2f+qU71AsqG769xJRa6BdwvhkEvMya+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wISEk-000h0e-Gf; Thu, 30 Apr 2026 16:19:30 +0200
Date: Thu, 30 Apr 2026 16:19:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Message-ID: <fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
 <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
 <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
 <20260429200214.3e8dee67.michal.pecio@gmail.com>
 <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>

> Also, I only see the issue on slow 5GBit USB-C connections, sometimes with
> the RTL8157, basically every time with the RTL8159, and so far never on a
> 20GBit USB-C connection, so the mitigation is probably some kind of
> interrupt coalescing.

Do you notice any latency changes with this setting in place? Or CPU load.

ping can be a good measure for latency.

If this is interrupt coalescing, it normally means don't interrupt as
soon as one packet has been received. Delay the interrupt, so there
are likely to be more packets in the receive queue. The cost of the
interrupt handling is then spread over a number of packets.

If this register setting is disabling coalescing, you should see the
latency go down, but the CPU load go up.

If you are getting interrupts after the device has been disabled, i
guess it is because the timer for a delayed interrupt is not cancelled
by the firmware. If so you might be able to work around this firmware
bug. Disable the receiver, sleep for 10ms but keep processing
interrupts, and then continue with the tear down.

	Andrew

