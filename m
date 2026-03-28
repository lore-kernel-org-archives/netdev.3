Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399420C00A
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774724528; cv=none; b=GLfVcGZ9XEfAhysI0Ms3wGlTsURZ0Ubmi+EwvuRKVOZR00K/u9mSRWaBR/o/LpXgFqt+8CE9Ia9xzpqQ+MhQQ5IdG3hy+aNt2/h5yOjU9G/Eiz/HSctmpm8d0P+0lcs546p6VtlfwojtZHnf/w0Eh2e8eYVsp5v4fdqk+0j0Vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774724528; c=relaxed/simple;
	bh=eZtqSVG360UjdFF80ohYShIeP5GLmrGcjO2TxNWA6zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBDX/KT1Ndi8aMO9cfton05+v90hS90rD0dCWIqGVcDfLJKTC+rnatGhvFkViX08PaFd3n6poVqKN1evNLTwB28etFOu8L/gxdVwOrUeHYtoYnV0J+5MXLFLj5H187R2m6TeLggwK/+wc9SY2wcCEdqK3A/DWeXgnTXTlyQmX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i1r9zpcS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i1r9zpcS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Rb4wCk6H2roWyP+DozeL7nTaj472Y54VMKypVEtfEo=; b=i1r9zpcSc0bLMgchIaP5miZ1r2
	omE0TXDqFJ69rF329SCnyIJ3EPRZlONfYsBFdjpTjcx/mGD80+sfXLo11Lxn1kJuKgXVtjyr/LA9C
	f/3zTkQUzWbahnhEJ4ni7KqEWQdj7UE/3rlc9xntvpLztNddGCAwmUT4sE9AFcv2N0G0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6Yut-00DoRR-J9; Sat, 28 Mar 2026 20:01:51 +0100
Date: Sat, 28 Mar 2026 20:01:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ong Boon Leong <boon.leong.ong@intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: simplify GSO/TSO test in
 stmmac_xmit()
Message-ID: <695294f1-8548-4a0a-8e21-ec99c9c0e903@lunn.ch>
References: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
 <E1w63fl-0000000E3Vb-3JkY@rmk-PC.armlinux.org.uk>
 <aceQRSc5o4D-HHmq@shell.armlinux.org.uk>
 <acegAqUb-Dzy87d8@shell.armlinux.org.uk>
 <acgPJgW9r0l952qu@shell.armlinux.org.uk>
 <acgkM2FGS2h-fPVN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acgkM2FGS2h-fPVN@shell.armlinux.org.uk>

> I'm surprised we haven't had reports of brokenness in this area.

Could a self test be written for this case?

      Andrew
