Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A102EEE90;
	Fri, 24 Jul 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898317; cv=none; b=BUxOyMSucliPHizE3ySsXlciYhHiUUMf2G87rmHc+GDgsuIBqTY3HzYw7q2IGbr3pEfrUU9D8d6DS5JrU7EzVOPb+4nL7LBSieS3ViIaUD5QSZVVPMJq2BRflsSdKKWi4GD2pDmY2gvuQtJhfWr7Dt4y3uQ2WPKLdLQArqTupA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898317; c=relaxed/simple;
	bh=vAVv4qJLy813qNxBf2YdVZlLecBtQgjrjTYdfTz6+Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4JAzdzohecQr9fQhNUz/+t3RsxxYDNMquq6Hy6W3yPgZvY1hLC5uwhfwC19lUPTIU2GPG5I67biPU2vzksPqaVJnux7/ni1i3Kzqxo6PY+j8g1un20SwFJPxBMF1z0mFcDSKDxa/vuuWFe71nSK/rw2VH0Hl6bHBPhqoMDHbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n46vKnAn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n46vKnAn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9JC5m34jALCEFafeMU7h6wca0BxlqZu9tFlZOqOnDQk=; b=n46vKnAnrJ9jg3V6k/AqX6Nsge
	5d/kiS77xoxJVZ8MQGOFh+SExxGqKvgx29wXVgqkLZFaYPM59LMWORBIk4nhOtMonii4+cOjH764N
	in1JjawAdvOxNuaxGL5Yen2F+b4GtFn6/FGKx3QFcAYFh5gvtKgA0VPfbvn1cIDyKG8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnFaQ-00Dza7-TE; Fri, 24 Jul 2026 15:05:10 +0200
Date: Fri, 24 Jul 2026 15:05:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH net-next] net: phylink: add phylink_pcs_loopback() method
 for PCS loopback support
Message-ID: <ab95d5f7-dddb-4980-91c6-5be12172534c@lunn.ch>
References: <20260724085224.3321663-1-zxyan0222@gmail.com>
 <42606cde-cdef-420d-adf4-b28c353d564b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42606cde-cdef-420d-adf4-b28c353d564b@bootlin.com>

> Besides that, I don't see and PCS that supports that loopback, I think
> it would be nice to also have the PCS code for loopback as well...

That is pretty much required for merging. We want to see both sides of
a new API.

There has also been discussion about in which direction should it
loopback. Towards the media or towards the host. For self test you
want host side, but as an exposed feature for user space to enable,
media side could also be interesting. So you should think about what
the internal API looks like to be able to specify the loop direction.

    Andrew
