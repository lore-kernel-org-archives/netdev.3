Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D83FA5FD;
	Tue, 31 Mar 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965939; cv=none; b=YW4/gUt91Ga+QvnNLFcjzpAqhvZNHGtvcPFI4EpqfuBIpyUUTQR2h3Lt66nGCEdLaXxWiAeejYJS8OjHNc3ojecm21EY45yN2ZpXvJjp+RXkZnAOLsFjeoPA3YbCWpHK8Va3Ht3zO9TSbS3AXZh62GhJz3uvndOXcprb/vpsYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965939; c=relaxed/simple;
	bh=nky8LGIjAzgGEYfjmmij2TXvL4oJ5VmVrlAEnH7wcnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4XnQuFiN8W+bn82TNcn/ZnfG/0HOL190huTTqhTSrfazdFN68yR+ojVRkVNhBUQdywKHG8OjQk43mpQvnjS51MRKQFeyikHok3iFt4RDqEszC0uU0OXDQHrhfMNEgs0qZs0rjQyB/G+Z7PnK6HM+XtiHR+zfPfBIVzW5QlocmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EMQ5t84L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EMQ5t84L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uV4DeCfiVexWo4VyreT39ve7smlA/6H0o2P7GYX0+vE=; b=EMQ5t84Lu1d0XkxvLtXhkfev7w
	rrImvsYEhpmmUsxGBEWQkkDFC5a+rnanK8WJP4gP6VhLgwlfzp6KE9W2PwUcqfMKm8TSy26jm+PFZ
	4KMtgjw4jf9GlYHWDTP8c4b19P1VeErjDAXGjfNyhu5fAc9mjH5lFOHl8rywx23ViDvbbYD6AA8lF
	pdZjtBPhkUYlidXQsKfHmFnrQ2oZ6ETQdGeOn6PO2jFgGRkOZ8yH1VAhp6kvOV4+jDwrPWchJNPwA
	1lKel+CoEg0ZrXY1HMsH5oq6RMIPHwKFf1lUaa2ajTT632Qa5uH6It9mRutGabe6CPxrDCU47O7AF
	BGeJ/81g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7Zim-000000001uR-0IoZ;
	Tue, 31 Mar 2026 15:05:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7Zii-000000003mZ-3ytz;
	Tue, 31 Mar 2026 15:05:28 +0100
Date: Tue, 31 Mar 2026 15:05:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <acvUqDgepCIScs8M@shell.armlinux.org.uk>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
 <acvEpk1grDFAahzd@shell.armlinux.org.uk>
 <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 31, 2026 at 06:42:02AM -0700, Charles Perry wrote:
> I don't know if there's any value in waiting for write completion here as
> write completion doesn't mean that the effects of the write are available
> right now. I also didn't run into any issues in my testing. Let me know if
> you know of a use case where this wouldn't work.
> 
> I can add a wait for transaction completion if that's expected by phylib.

Consider a PHY using a shared interrupt line, and the interrupt being
disabled in at the PHY before being torn down... wouldn't we want the
write to the register which enables interrupts to complete before we
unregister the interrupt handler for the particular PHY?

I do notice that other MDIO drivers don't wait. Some PHY drivers don't
access the PHY after the write to disable interrupts either. So, maybe
phy_free_interrupt() should read-back from the PHY before calling
free_irq() to guarantee that the write has completed?

Andrew?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
