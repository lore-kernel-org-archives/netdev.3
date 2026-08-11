Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD941D209;
	Tue, 11 Aug 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484333; cv=none; b=DByPUvHfdxVnhjYbB3kurPnhvekR/RwWxdFjDigozUT0icdfK/vO9uhBPBH0E9LTZzPAc6+JWTNJmztR02cLZ0ultJEbdWOxpzcAq4u0Ms7+znGydH2qKpfMp0hhxq8+W+//1eeyA25c722YPtlsXpgaDh/Pj4fSSWJw+QH64Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484333; c=relaxed/simple;
	bh=cibvq4KNb/SsPD+RK1bdrBTC4eHL46PmZ81jeedjjio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCQx5VpSCfkObxPgPSggYYHotr2+Th96K020IXTt5zxVepzK66C2LbFc+P0CK70VJb+qWu0edUOVC1kuFUZMVu14naRDQ6PM1VByT/s0Q8CkR6jCRg8t53fA5ig5PzYd6pxLPe1MKRXsBh5MBViJMgiqREHVLMAIMpJixESxnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4FXQ2ipp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4FXQ2ipp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SSHNtHbQVca9EVivkBqWEGMIWhdvhl8gq+N/T9BAjz4=; b=4FXQ2ippstqgnA+75yMrEU+EWL
	+o9dlKYlhR8Ic33IV8BBTbYVLicm4twJIPgajXr5iP6nBYIXzTcSk0fqJYcaLniGEjEjPICsUXNX8
	gZMiIhc9ZCEZ0x6Zy9WAQcFCEGanHVLIDaz8Za0HyeoZ4uYEOq+uTiD/Dw/M6XJHzdI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtuBG-00H9PH-56; Tue, 11 Aug 2026 23:38:42 +0200
Date: Tue, 11 Aug 2026 23:38:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kyle.switch@motor-comm.com, Frank.Sae@motor-comm.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v9] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <1c494ee1-4b57-4dfa-b99e-0870a74f6efd@lunn.ch>
References: <20260804114419.4129109-1-kyle.switch@motor-comm.com>
 <20260810222616.906676-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810222616.906676-2-kuba@kernel.org>

> [Severity: High]
> Does swapping the global register space and then releasing the mdio bus lock
> expose other generic phylib operations to silent data corruption?

I would suggest you look at how EEE is handled. phylib often goes
direct to the hardware and accesses the registers, without calling
into the driver first. So it is missing the lock you just added.

I would suggest you audit phylib and see if there are other cases
where it calls genphy_ functions, e.g if the driver does not provide a
method in phy_driver.

     Andrew
