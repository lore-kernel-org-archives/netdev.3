Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCF3DEAF9;
	Tue, 24 Mar 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345745; cv=none; b=QTo4tvmCJ8eS0bguWRf6RFPaqmbb1m0Ixw0C0gY6LPu9hbfad83aNu6QtqvOvQCjKDbw0G/cUZvLLluPIrB2+OKUlSIcO2guDOweOvYm6FRFh4yVKUlQ+dHA6/551FcTnuvlHEpJef/75X3tQmqUMw0mgxjz2/Pcng4QUR3bcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345745; c=relaxed/simple;
	bh=fSuJNN8Jugp9CK3fRYqZPfUa5q7LcX1UmdnU72npshE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW2C9LuUuFHFF6MgGOyRtar3SJN0RoEFsEhRgBTl2Muzj1BTuk7ECQ8ED1ib9QHLPxByCAMAB3g4mk48gz251KSBqeUkDVDkfyjLlfSVrBzWFeAyNphFXmVnpp+pqAlTq+3DnwP03GZIZwyMoPLT9zOqNBE7I4GMirCGiLnnwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WdBMv7lO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WdBMv7lO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O3zSGBMOP8SLkvjNah7bxtlePOkK0bAZhrbaj4sgYC0=; b=WdBMv7lOsX71X7cUozgMFqvRlJ
	DHuyWR1HAIB7+KhaI0Yeg5lREb6TcGa0VmTBcumcYtoEufxf/LjCR6dPA1i/sPgh6F+d+58qIPxnP
	0HRnoRDi/9HiBCzYlnUl3Bzi6m9qPbvHPQwKss/btlVQfCnJggD51pS7XJArB+X0AKIBX0HgKCoYW
	eqGgsBn0Nr6lPXHbIpHlgJAPyIWxTxjzwbk3FbckBB4J01cqOPC2/cUtcfZsEYI3z2F2vAbN4aZLx
	wgJlCcpfWUmgBxOp95WyJLgaxY6cc843MuQC6A+c2Mqn+P7aESeRBgHSBg0Vut9nbj/8F57QwuPk7
	wzoeiVAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4yNZ-000000001hO-22Vr;
	Tue, 24 Mar 2026 09:48:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4yNX-000000004xr-3Knl;
	Tue, 24 Mar 2026 09:48:51 +0000
Date: Tue, 24 Mar 2026 09:48:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/5] net: stmmac: dwmac-socfpga: Use the
 socfpga_sgmii_config() helper
Message-ID: <acJeA6c2M4eSrxC4@shell.armlinux.org.uk>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
 <20260324092102.687082-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324092102.687082-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 24, 2026 at 10:20:57AM +0100, Maxime Chevallier wrote:
> Use the existing socfpga_sgmii_config() helper in
> socfpga_dwmac_fix_mac_speed(), instead of re-coding the register access.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
