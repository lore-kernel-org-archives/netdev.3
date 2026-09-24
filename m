Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B281F5821;
	Thu, 24 Sep 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253816; cv=none; b=EjJjY3O15QB6Kg9P8kiG4z+10l+1a375dMkiHG1NvX/bvuWwAk07ctJXfXAjCvmBrFL9e6B9f6n8B9jL5rtifN6h9Np91gL06Z+vciOUOGrkMnF+1veOJeUZfUAKJ6U5+SJ82Z1AJM/5WtD/F+Dh+n/MtS4Iwx4z/vyTmAZz3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253816; c=relaxed/simple;
	bh=wp9kJBgKcuMTK8zvUARb1wzYwJ9KGS5nCTbFezFgblU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRfhkzVWApoGcCPlJtGd75L29+DjXqyLy7F6Cj+HnvjDVnDd5gDINa4nkOGtKUm4toOcyWpxJ2MgBO/hvLDyVUV+ZY4o/ZW9n7t/3o9136x0FwXpAdhIOhyqXckZ3mI4R9APmOZY2k51kRNcBoOqd9HUGoHi7lExIgebjB+aP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G1McD9Cm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G1McD9Cm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rJNa6PEHuOf61A8VU/xeS1mJTAmx4EYTfnhLoLOZvi8=; b=G1McD9CmbJs+s4r+8f1ZLI6p2J
	kFJBYW8nHS0P4+vRvocqdKiru/LjTavgV1eC8xboXFhEocaXCUKTdfasaN1blB+PDFS3PQHEfFjBt
	AW4x2YBV2gHjE0uFEZSMGD2/wuu4KtTD7Nho1Ep3fiDmYLnjRhckSIqQH2Y3v5Jc+zwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9inM-006zYD-06; Thu, 24 Sep 2026 14:43:24 +0200
Date: Thu, 24 Sep 2026 14:43:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: aquantia: AQR113c fix up PMA capabilities
Message-ID: <19cac4ee-0523-45bb-b4f2-beec46e174dc@lunn.ch>
References: <20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com>
 <5b7031ce-4f5a-49af-9d2f-202050f53aed@lunn.ch>
 <6cf51763-9053-44e3-803e-6bc1e000e75a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf51763-9053-44e3-803e-6bc1e000e75a@oss.qualcomm.com>

On Thu, Sep 24, 2026 at 11:41:53AM +0800, Hongmei Xu wrote:
> We only have AQR113C hardware available for testing. The AQR113 may
> have the same issue, but since we cannot verify it, this patch
> intentionally limits the change to AQR113C only.

Do you have access to the datasheet? Any erratas?

If not, please extend the commit message with a comment that the same
issue might apply to the AQR113.

      Andrew
