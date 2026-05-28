Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0F2BCF45
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996061; cv=none; b=troPMG+l3XTkAGbaU/F9FLen1sSy9JUlSNMrmZ5snT3ej7fgGMKkvUPaRDGiu79RrRFckoGr7Ny9s4q0Lfn5boHWl67s+/y5BFuhH7OrOSxmN9jwV+EW5NITFyhlrbbcqvzYOCElvARo/QKT/4a6KTC296XOTdHhZFSu74y0ixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996061; c=relaxed/simple;
	bh=FpY/1qq1Kgu6gRdlbE+5U7r9bnI00IAgqrvsAaq//EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkcDISI5tjz1IshRM5lzZsX1zsCPXkG5cWk6uP1m13smr2cigMk71QSh+EUquPMvFlAnccpY5jfkGqzM3te6mpTVtbvoscBgGevenelI7im1Yei6mWTU6IQjoPhQlbyUA8GB8P/kEDymv9ZXoLj2bCNXxHkmHl+admqTwAdRzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a85n9ODo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a85n9ODo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pgSFZILZZU+FolwShAv9UOJx1SEIkwMsfAmA7nw/fds=; b=a85n9ODofNzAwqHrcXvSPsTkPo
	kAV/nzSOQuEFv5676LzlQRekHxw6frI058y+CiryTP58JmUjO7VxwdSKNUMnyYjfF3K7zttW9RzTy
	E7FNdu7RCxOcFUJFfrwM93lchPpVT60DrgC/wSSJrJ9KkVXzdcxQlg+RcVj6/NVacl5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSgHk-004xAy-R9; Thu, 28 May 2026 21:20:52 +0200
Date: Thu, 28 May 2026 21:20:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/2] net: phy: dp83822: Add optional external PHY clock
Message-ID: <bf9abacb-c2ab-4cbf-b332-2af795dfad66@lunn.ch>
References: <20260528184642.33424-1-wahrenst@gmx.net>
 <20260528184642.33424-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528184642.33424-3-wahrenst@gmx.net>

On Thu, May 28, 2026 at 08:46:42PM +0200, Stefan Wahren wrote:
> In some cases, the PHY can use an external ref clock source instead of a
> crystal.
> 
> Add an optional clock in the PHY node to make sure that the clock source
> is enabled, if specified, before probing.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
