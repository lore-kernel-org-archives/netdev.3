Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5183E0C5C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485239; cv=none; b=MZUqnLWnjsNhFwbTkG1LLCMXF4nm2NvmLJAZuD4Y+rQYbLVHhC1v5KCOxpv8+8Rq9uv52n6IhhNBKrTLHzQQx73ao/DXKm0IjMBNf9Dxn1cmZzVrY5oEbr7kw0lP5HBIwY3raxi4UE0H98AbmQY2IOD+Nzb5V3O9vwrDr72Qi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485239; c=relaxed/simple;
	bh=T/8dagHviJxEMDUnbTJ+PstlpsOXiV3K/NgN3MeHDxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgImwgH8cbW52gYjNX9beTJTYXlHcc2TFsiPymU3m8Tb74h75xFMcM9RHUNtIngbh023HHCrOD1QhDK28NPdM0vQ8IOfabjCsL/TuRVtsOABKLwT5g9SP0w9Df+zMj96YiDJACINr+qiLDkxTJo61bBc4Osgl5gL3PpdJ/IMW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G6/4v/7v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G6/4v/7v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fYbi/t0gONKmk4SLCse/j+L+yKhsV1XhXCl0a/WtfkE=; b=G6/4v/7v88OJhFmNDosbMeC3Ea
	6/7yf+7aGwu52fS7VsMjtNuAcMKRz61Z9y6wH6f4an7gYp9ZgZcL/RfP0Q1iUGKeb/Mjyk8ziYurc
	g44yQfjWDiUqDwrISEC/gLGYz+pmRC2xKB2nPW82rcHkcQ1305BNRNahmgtz4Q3XaIqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6Uqv-005IYn-T7; Tue, 15 Sep 2026 17:13:45 +0200
Date: Tue, 15 Sep 2026 17:13:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RESUBMIT net-next] net: phy: factor out legacy PHY fixup
 support and make it always built-in
Message-ID: <6cabf1c8-9c1e-406f-97a9-80fbbdff7b35@lunn.ch>
References: <9bf96f6b-2d08-402a-af5b-cc6b33fc6d26@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf96f6b-2d08-402a-af5b-cc6b33fc6d26@gmail.com>

On Sun, Sep 13, 2026 at 10:00:03PM +0200, Heiner Kallweit wrote:
> PHY fixup registration is used from platform code in init phase only.
> Let's move the PHY fixup code from the modular part of phylib to the
> always built-in part of phylib. This allows to annotate the fixup
> registration as __init. No caller uses the return code of PHY fixup
> registration, therefore change related functions to return void.
> 
> phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
> the built-in part of phylib. But doing so allows to fully factor out
> legacy fixup support into its own source code file, and make struct
> phy_fixup and phy_fixup_list strictly private to phy_fixup.c.
> 
> phy_scan_fixups() is used after init phase only, then phy_fixup_list
> is read-only. So we don't need the mutex when accessing the list.
> Also when registering PHY fixups the mutex isn't needed, because
> fixup registration is done sequentially from platform init code.
> Actually there is only one platform with more than one fixup.
> 
> In addition this change lays the foundation for enabling modular
> phylib on platforms where the fixup just sets a flag.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
