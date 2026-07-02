Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67F426400;
	Thu,  2 Jul 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998809; cv=none; b=qwBeWAoFc2oTuJ6hDACkQ1m57RJaxewITxayYDp59xmJtep55jT8cLGZLS12JATzW2CEKehHrUfbzUM6lCp227hRdJR5O4201j/cAQ8Unp+IaLzvoOBcDbuLujdHyFQKuo75ez5+Bv2iFNsnKtnOUOWabJwQVT/nLJXPVdh4eoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998809; c=relaxed/simple;
	bh=gzEKKXRHW55NBy9kesVk1b/uOh+mwMrAihvh8BkHFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InE24BddIKXMprkicRnxlAT3ebyHIMBakB5Smkd0y1LU/5UGUYrnCjVgHWtpXyOh5PbFGif1MSBMNuWxTO42d5o8lulb7HLPSMe+5MO3+LeRXf1kgnsp4Wk0bXf2w/Kod9A9cfsPmXC7NYf7pSfckdha5wpvk3CLWRZMJNYSL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EIIs/KW/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EIIs/KW/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iDgAaxSJmNrLZ/fcZee5jFXzDko+7FPC1vaAFIsohwU=; b=EIIs/KW/YC0jrhq6C5YR+VX2wd
	Hp05SmTK9lu5/k7sv42rd+UAvLezidYJgLH6eXNo/kLPmn0SloCTAbkEq0bSi0ASgMqox3FOFLIwr
	8ZvO+iE6BQ0kOKUDAa4E+hTMu3b7SVmIqnmUgV8XJDeVPX5sat84TKNsise1mn/xbKrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfHR6-00ANP5-6i; Thu, 02 Jul 2026 15:26:36 +0200
Date: Thu, 2 Jul 2026 15:26:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mdio: select REGMAP_MMIO instead of depending
 on it
Message-ID: <d25ceff6-7f34-42a7-874c-c35eb9f7bb2c@lunn.ch>
References: <20260702032653.1580616-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702032653.1580616-1-rosenp@gmail.com>

On Wed, Jul 01, 2026 at 08:26:52PM -0700, Rosen Penev wrote:
> REGMAP_MMIO is a hidden (non-user-visible) tristate symbol. Using
> depends on it is incorrect because there is no way for the user to
> enable it directly. Change to select, which is the convention used
> by every other driver in the tree that needs REGMAP_MMIO.
> 
> Fixes: 8057cbb8335c ("net: mdio: mscc-miim: Add depend of REGMAP_MMIO on MDIO_MSCC_MIIM")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
