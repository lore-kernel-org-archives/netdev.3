Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001F4A2071;
	Wed,  2 Sep 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360153; cv=none; b=dZ7sCnbkRSUfOiWiCogVMRg7AyPW4X5Q91xA9J4v22EdBmL4q3Fo/J5Jt37lA5kMp5diRAWUCkiIkDeXxuQC5Vri6mJCWB+FauAgoLl7U0qvDPgyOsEynsg1546OVZ+3WcTYXu+NqVGTQ1PtUEwYV89GUpjXkSlRY3lsEudN+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360153; c=relaxed/simple;
	bh=BJzEXCYbOmX6Sa4oO8erFmkpFv64hVENIBznK3zgWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOAhgS6xcMb3iab6aeupTb1dHwhXcU4uYHrUJoY/hdbXbQy0zFxcQseUSjj5pzTlRfKwqXUaOW8feFpmsoMGXkKfmd8PKKY2BLWDfIwO0vhhK/qCs3lbCp9+DC3WVpeZ8BKWDdDxU8OuAl21T1JRriVFIyuXrU+Q0fkjf1rcqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dxfmVoRY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dxfmVoRY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zpl7aTMfLkXO1AZyD4e+4BRHvm0tJ99NUORBZCpsf34=; b=dxfmVoRY7c49rGWHvrZ2QgdD72
	bedfHxNssJHlkuf09d5NRBz7E8oOwCfG5mZ3dmV9TbeTZtGZvvYTNLGESakPpH+HydbDR/9EHaFck
	isAGN8cJkFJkXmCCG+HJ9gnXqRlLU+g8Ini3AscurooFEMHsu9XEcVcKk7eleOMg4/dk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1mAT-002XGa-1X; Wed, 02 Sep 2026 16:42:25 +0200
Date: Wed, 2 Sep 2026 16:42:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v9 7/7] r8169: fix RTL8116af can not enter
 s0idle and c10
Message-ID: <5f501f1b-9522-4825-9a5d-36548fd8111b@lunn.ch>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
 <20260831053745.1197-8-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053745.1197-8-javen_xu@realsil.com.cn>

On Mon, Aug 31, 2026 at 01:37:45PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116AF is a multi-function device. Functions 2 to 7 are hidden from
> the PCI core and return an all-ones response when their vendor ID is read,
> so they are not enumerated as normal PCI functions.
> 
> However, these hidden functions can still affect platform power
> management. If they are left in D0 or keep ASPM disabled, the platform may
> fail to enter the low-power s0ix state and the CPU package may fail to
> enter Package C10.
> 
> Put functions 2 to 7 into D3hot and enable ASPM on their PCIe link control
> register. Since these functions are hidden, access their configuration
> space through pci_bus_read_config_dword() / pci_bus_write_config_dword()
> using the same slot and the target function numbers.
> 
> Ignore functions that return a PCI error response when reading their
> configuration space.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
