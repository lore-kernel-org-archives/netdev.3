Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE743B38BC;
	Sun,  2 Aug 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684430; cv=none; b=fAmL9AjWaMhfxsfDqQSNfitKvhTfrMj4P6Pnxh9ZlIr4kJuqiMelsEErPA5VNuvxLdukVnk9WQ+42pXQ4GukjyWN84Jj8ak/MXd9a5yRrC7YgI6jo/UHxHrWHH4/cweM/jW+A6wqkJDZ3AKPSa8t6Xv8vTOFXbVNSx3Zt5AXglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684430; c=relaxed/simple;
	bh=gft9dSOdxl9Ekdje6WTGMQrxUFqa+rLONnmCbH5q188=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9qvqn5kPjq9BThSduDDOKZ2s25IKJrJiGnM8D38Y2NW4xb0Al6HZPnmf5Fbt84emy61lPHbdVR+8uUmQrPTeXPoTfrTz/4uI4c/E3a02eL7pTRkHkIWWd8DHvU3mcZoEFm29Dv/d9muKx0SagacPXzWiohYj4wR7vnANljSXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W9Qg/T6A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W9Qg/T6A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5I/GPh7YsynKBRC48MxjpIxgnCoYXKA/C+I1rx8ZmMA=; b=W9Qg/T6AawvFq4bI3dQANbJltI
	BkdnlQPpE1pmtmqteOPw1T1FA9phonQVRdlv2fKBNyde0e54kNi33CQuASyhicQG6yWztvm1DtPUt
	L8cz7L2hs2qHaSfbkyDuPpRnX22cYg7gcrdS1CrGfzKLKTIkgT/4G4tgIsQt1j8TxMuA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqY5d-00FaX5-UX; Sun, 02 Aug 2026 17:27:01 +0200
Date: Sun, 2 Aug 2026 17:27:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v4 05/12] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Message-ID: <39b533f4-2edc-487d-a596-15deaed2a5a0@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-5-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-5-2cf1f71b1dd2@birger-koblitz.de>

On Fri, Jul 31, 2026 at 06:19:05PM +0200, Birger Koblitz wrote:
> Configure phylink to work with the PHYs in the AX88197A controllers
> and provide ethtool get/set eee operations calling into phylink.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
