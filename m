Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C727A476;
	Fri,  1 May 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638082; cv=none; b=lgjxg1GHEUBqsrq2jhUxRq2fcFe5r7flAQyXOJnskuaNEOWZhGKpTuAdrULVECzGKLgh86hpzuxae+VKoFnorKw6+aFADstgoQx5xOFBE2Xk4cuwyrk3mCXdDOlyDjxE825ULV4YLGQTSQLYXzY8MuYGUCJpw+pE+Y3eoyPwD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638082; c=relaxed/simple;
	bh=TNzDR1TZBAM85v+1er1cq8xj4+1oEevMKUhGnxk3ru8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7zW0/cbuC0YA5El/DfmOXlFZBQbrNP9q/HPacngkSY6+GCGHenlrtIk46TJsVIl6uZSHtCWNQDafiSlpIbsK6QDTtz6UJIPv54mW94OISqux0/wxkl4QYets1m8iQCTkr1WSlElOUHausDFhlw7KQm1AL/XFU/lGNtxQYDkd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VBNUx1lF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VBNUx1lF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MsrW9P+18F84Qy89FNTzjz238B+2WoEoX3uJ89Kl6oU=; b=VBNUx1lFE3UuUK5wfhNEymEvQL
	3FgOUfwExbmAdD/bnOXkAoh+L2C0xOeXB0hsEeI37FXr5G/52UzprljFbbSSH2/EDlZ5JOEsfmskS
	/D38J4PwGEh/q2JIQZtf54zjTkU4N8m1NXLRggizZEh07YNnLZEsQvM6/ZwCMMzGSGiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wImrk-000oXt-RZ; Fri, 01 May 2026 14:21:08 +0200
Date: Fri, 1 May 2026 14:21:08 +0200
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
Message-ID: <0fd2b263-bbe0-483d-b2e7-92d76d895b11@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
 <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
 <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
 <20260429200214.3e8dee67.michal.pecio@gmail.com>
 <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
 <fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
 <62fb1f24-b0cb-4310-a155-1f5cce14d83a@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62fb1f24-b0cb-4310-a155-1f5cce14d83a@birger-koblitz.de>

> However, there is a big difference in CPU-load when running iperf3,
> especially with multiple threads:
> 
> WITH the CODE saying it disables IRQ mitigation:
> $ iperf3 -c 192.168.3.1
> [  5] 0.00-10.00  sec  10.3 GBytes  8.83 Gbits/sec
> CPU: iperf3 22.5% ksoftirqd 16.6%
> 
> $ iperf3 -c 192.168.3.1 -P4
> [SUM]   0.00-10.00  sec  9.36 GBytes  8.04 Gbits/sec
> perf3: 19.3% ksoftirqd 96.7%
> 
> 
> WITHOUT the CODE saying it disabled IRQ mitigation:
> [  5]   0.00-10.00  sec  10.3 GBytes  8.87 Gbits/sec
> CPU: perf3 19.7% ksoftirqd 12.5%
> 
> $ iperf3 -c 192.168.3.1 -P4
> [SUM]   0.00-10.00  sec  10.3 GBytes  8.81 Gbits/sec
> CPU: iperf3 22.0% ksoftirqd 46.5%

Thanks for doing this performance testing.


> My undestanding from the first email by Michal is that the behavior with the
> ESHUTOWN is actually harmless and has been seen in the driver already for
> the RTL8153.
> 
> So, my suggestion is I drop this part of the patch-series and remove the
> IRQ-mitigation code that says it disables the IRQ mitigation as performance
> is higher without that code.

Agreed.

	Andrew
