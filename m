Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA122E736A;
	Mon,  6 Jul 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346026; cv=none; b=ts/7/LDnV/D1D3jVBNX7I676cUCEIgbUVfepx2/dKwutz4wc6mXgM1SQ6bljXB9nPVMBRJuE9i1bQQrIewq4j5gz483zNeNFd4pTauW+YAjwMV28S2UShP4I2OZxiLAKq6Q+FCFzIfKxvE2V/RtwSdaNAXgmdffZcj8s6EUHuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346026; c=relaxed/simple;
	bh=GsPL7KbRZPqGujnzbJsjeG3QKPL4qPUV2iOe/wvfAMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU+D8XYxnP1PqLDyK3dUdTfwHzAaOPMHucexwBYn/0grtHjWConQNvP8dT7xflTRBsZJVz+rBd5oDEkmvMvI3VQkKW29u/gyj6WC91K7vH2R0oaXGlKAA+DW5bSXpJZS4eXlozx3UV07qgeuPhEd6Hb2RW9JsVyZlC9ovwh/Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xJAdxKcv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xJAdxKcv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ycKeZ8huTYhCrCKuSwO/Y7VMMDg+VHi4UtgYihXDt/U=; b=xJAdxKcvksL1+QZVY6LvcoJX8Q
	bwVhXUMhBUpKZp2bv9p3Z92agbKjEsWoTacD5J66L6ZV+ZAkMdm5379fgqIzUJJuSFH+obItnXUUt
	Fo9bsN0dRDgVUXL9daVDPC4fwdjEv0E6G/WKOIPsYdOF1y/QihvP/kMl/KaaQ9l1VMjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgjlH-00B01M-HK; Mon, 06 Jul 2026 15:53:27 +0200
Date: Mon, 6 Jul 2026 15:53:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gary Guo <gary@garyguo.net>
Cc: Guru Das Srinagesh <linux@gurudas.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import
 style
Message-ID: <4d2e0248-11ee-4c0e-9133-8af15912e0cf@lunn.ch>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>
 <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
 <DJRJ4N9UQUR8.1GSF8WWG5WO2Q@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJRJ4N9UQUR8.1GSF8WWG5WO2Q@garyguo.net>

> This is sorted list, albeit in ASCIIbetical order instead of alphabetical.

Ah, O.K. To avoid merge conflicts, the actual sorting scheme does not
matter, it just needs to be sorted, so inserts are more likely to be
spread across the list rather than appended at the end.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
