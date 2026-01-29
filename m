Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB5289E13;
	Thu, 29 Jan 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707364; cv=none; b=rT4+XsIpy4lU09ZhauxL3bY7DkuvdGoAFwvTiwKW/EknlFlRYXie5HMNnOldT/svfecdINVT64jCQDhA6GkU7rqwr3cDOpcfXRJuj0GT3QwbQdNXBtjf7ODqAOgV2B1Abi8UghavyJ5cKZxrlu0xVvYcxL86OVC74qmG8vkKJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707364; c=relaxed/simple;
	bh=eiF77AvdfNH0Zm7/EakTLU4uCAaSLAb2I9Yx1IwIBV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dypVgc811sjpFTVMizS52h+8dnPy0Eq1BIneXg318IVfWoH6JzmARSZntDZQl+SWvtRoijDZfh2Eypu0flqsd8YHISnadyx9MgQ+pdYRI2u6yaft4FRLvKpFh7Fllg2ShITYyY0/j3wdgqFTA6gnz2593BZ25snuRtGF0qUmbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CfGD98Vm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CfGD98Vm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ggN4mfw/CmnAAwaeXXISIvQU1rCNG9A2qUJU6zpzHJY=; b=CfGD98Vm6ajwgXO/8WlluGKxHU
	QX5KjBiDjROVayYlLdeVesnHJ3UX89AmSQZAUGqaWbGK+ToTt0bnQzaYEh/m61SoT8YMs3GGsRUGF
	InV6xiSNAjmVUrrrasM0/Hm9E0R+q07fJlsM2PugbzCDNTrfxS3OTTD6bNHefVlYoz//wiI/GkxHq
	nb3qOVJH8CN4bjE3MrHlyJ7hClCQ/YkAWJJg7aTjXSpl4NNKdQTR+TJuylF+k4s+uYEU3sN3weBCA
	FZzdmRgUHTA0cfCZjIInO/ZKfYQzEytynjUqHYgoC8tgAsjFxSOKZWnCmrDYh7hFaYdm8HsNSeaEP
	tCVDP0kg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40944)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlVj4-000000000Jm-1t3z;
	Thu, 29 Jan 2026 17:22:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlVj1-0000000089i-3oag;
	Thu, 29 Jan 2026 17:22:35 +0000
Date: Thu, 29 Jan 2026 17:22:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 2/2] net: phy: dp83867: Always program R/SGMII
 enable bits
Message-ID: <aXuXWxhtR-1Hvlv4@shell.armlinux.org.uk>
References: <20260129171205.3868605-1-sean.anderson@linux.dev>
 <20260129171205.3868605-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129171205.3868605-3-sean.anderson@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 29, 2026 at 12:12:05PM -0500, Sean Anderson wrote:
> If the board designers have neglected to populate the appropriate
> resistors on the strapping pins then the phy may default to the wrong
> interface mode. Enable/disable the RGMII/SGMII enable bits as necessary
> to select the correct interface.
> 
> The dp83867 strapping pins have four levels and typically configure two
> features at once. LED_0 controls both port mirroring and whether SGMII
> is enabled. If it is pulled to VDDIO, both port mirroring and SGMII
> will be enabled. For variants of the dp83867 that do not support SGMII,
> this will prevent data from being transferred. As we now explicitly set
> the SGMII and RGMII enable bits, we do not need to detect whether SGMII
> has been inadvertently enabled.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Something to consider:

You have separate enable bits for SGMII and RGMII. The code you're
submitting sets the SGMII enable before clearing the RGMII enable.
Is it permitted to have both set?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
