Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976F3A9D8D;
	Tue, 28 Jul 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273085; cv=none; b=c0iZqDa+W+A1yc/UMn6kwxDevju1S2V9juv6rZfcz4UYEKdl7Mcyq/KZHHedmoaXL2KWB6yjqLLVfDjSxcxeYNqkBrgDtQKdzaURaG2PbPPzJ5PeC/jLSPg+fhbIacDaHCFKFG8jISyI7ShnEagA1JnnMRhlxjxMEbavmhCtY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273085; c=relaxed/simple;
	bh=75Eh6qcZS0QdDjEqnFbwUrSY2OlKylJ085L5d8yn/Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVq/C6YeCvIKyTQSJgnI/0neS7tCrWQK8c4+b68TjA4ddxaogNkGsgog1FUkSEzax4S/XiBUo7WStjfg4QJad+FfvzVNbEHNJfSdPEdAYogl+zRm0knH03DFl6otqDnc9THN4TagGTNx3azDU+6d5vg1jj7aBbOyos3rKpfd8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K2G5jPcI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K2G5jPcI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tls3zw3iHiUFUa6sbxybce8bd81debJG0XA+7SW4nuM=; b=K2G5jPcI4ohFhEH0UNgOkf4Eam
	8lJw9aor1jw0IWqs3NsUwogExgQe3k0SkG+ToYTKf9hfq0SjgSN5/qeq/7MuLu0R8uD5iPtSPUkMx
	GtgR8PmIB17sY498rj5FUgnb2+jX+YgLnvGyoBLm1Zx/ceg6s8RBs+/cxpmwzWaEneQ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wop4x-00EhY5-Sq; Tue, 28 Jul 2026 23:11:11 +0200
Date: Tue, 28 Jul 2026 23:11:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] net: phy: nxp-tja11xx: cancel registration work on remove
Message-ID: <86a53aed-4e7b-443e-a519-f789fbd42c17@lunn.ch>
References: <20260728123423.781-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728123423.781-1-getshell@seu.edu.cn>

On Tue, Jul 28, 2026 at 08:33:35PM +0800, Hongyan Xu wrote:
> tja1102_p0_probe() schedules work to register the second port. The work
> uses the Port 0 private data and phydev. The private data is
> devm-allocated, but the driver did not cancel the work before detach.
> 
> Store the Port 0 private data in phydev->priv and add a remove callback.
> The callback waits for the registration work before devres can free it.
> 
> This issue was found by a static analysis tool.
> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject: line should indicate which tree this patch should be
applied to.

	Andrew
