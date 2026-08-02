Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A192F7EE7;
	Sun,  2 Aug 2026 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707271; cv=none; b=C9FHCZnuIgMRW88y3z3MS4abUt3K2WxCx1qACxh1RMaFIv4gTv6CIN9v/fO5D8ovY6mwYaYtQQ9gAnwCFWKPB07vJLdDs8SHEEctsfnZnp5szb19Mbdn4bHL1AxL7BWz7k6SYV1MeGPkreNTBFYya+UgO6ojHe69IzJpGepFNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707271; c=relaxed/simple;
	bh=oCa+ByNIo60iXDN/IIl/0O5ntXL/S0I5qZSVjl2Rwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnOvTpoTrGMn5sgC1Q/OrdF0NnQ8xrEvmGwkDbZxOZTEOWvbshNPRKd1KpDXk4F1/Iyg+L7sDeu3AA8sDGyXcZl6K+lHmmfnQhPTGR5mtw179Yl+PvCIjJzCKqdHOB1z/hNKg14VjMOJKL1O+VX3/U+1Kicp8ylSXTBNZltMP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qATBs2Uw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qATBs2Uw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ku5XFCYG0xf2eTttFqzdphgvdWRWRLQ5gAxJOEEcO+c=; b=qATBs2UwCE5cSx5CgCSQJIr/ER
	Ivx9HDiSXRmNfnArew6YOR/VDMhwi8vWN/Ac4O+b2V4sy6tLzdUNMSNdq3gUK2szt377B87CUu2r2
	ii5mlTmM1P0Qh164PY2W8Kuh4MvLJQHTMEhTe1ioG44/ddAhUzN6iDuieAAGNx7wm/mY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqe23-00FcOV-6f; Sun, 02 Aug 2026 23:47:43 +0200
Date: Sun, 2 Aug 2026 23:47:43 +0200
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
Subject: Re: [PATCH net-next v5 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <8b7fa8f9-4fc3-4ea9-9782-3f7c43e9d2c9@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c

Please add an entry to MAINTAINERS for this file, and add yourself as
the Maintainer.

    Andrew
