Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4247C0E1;
	Mon, 14 Sep 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406055; cv=none; b=ojKBr+fsndj7eUp4OvUhGliPSJYwUxYPtR6J2DaW/WsBYnB/mvC5j87Ask77ZEVMzGnD/ZsO9ZerkL9oU3N3ASub9IvUZ3UnPj9++yqP+ZrB5YQhO2uoimGb4XjSh7V23UCJ/wyqE/zbYWaoXoPJKmMFog0gcv3pjJsNh5Yln/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406055; c=relaxed/simple;
	bh=ptoVQIdRHBxhXEzkQVXKrRQCostEfGy+EKPdcFsnJWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od/aWL4LlzXqWKMh/+WREeHkLWXXm39Dksak5Unu4va45TybwdmXx375IoGPqe8IGxshQvxfuSpZUhTiaJsd8e0gESPqIPs2Yc70vqow7T2ncJfyG3eX9qd8fTBe1jfaryUR1Vg8DGIWrbcQbteAWngySA5Z61sTO0oexMFwDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=whilRdHx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="whilRdHx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yZY7/3LXlvE8iem0fytsdQIcItaGwNzjkvfcyxZ+xhM=; b=whilRdHxfmA+jRN0eCo5Ux92KI
	DahiiBaKW2JNt5YSDRBtQ+pWkt6L5ap+Of7IXApFJIyrM+n3OfMHPWgT6dE5pf1sGmwoWA2MDiqji
	q3Sg+oV7AEAWTo7oc8NpFSZ9j6wV3tI/ufvVRshr50rmcyT76tAthLc0AA+PfgT050/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6AFn-0057MY-Ht; Mon, 14 Sep 2026 19:14:03 +0200
Date: Mon, 14 Sep 2026 19:14:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] net: pcs: rzn1-miic: Fix config array
 initialization
Message-ID: <c64a0d48-6c01-49dd-88af-b6a236d4f46f@lunn.ch>
References: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
 <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>

On Mon, Sep 14, 2026 at 09:41:00AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Fix memset parameters to initialize the entire DT value array
> 
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to SoC-specific struct")
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Actually...

Please split this patch out and submit it to net, not net-next. It is
a real fix.

  Andrew
