Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3B385536
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658861; cv=none; b=d6MGqCoDZZEp2rjMpummeyrcjlPVjt+lgZrg5OXkKGBRpujnpH3pkVVFWyRshrJ3Jzot1aHxLPe3vYGY7GP6K5JJZhDGwGiOHYUNVfBBKddS8mBV6JYdJ5vjSByfJqWXyZi/Nj8xFkoZotnMWMDmJbUE1M03L6FDWmKHC46unWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658861; c=relaxed/simple;
	bh=QeHdo4PzDoIW+7yC/XUa+IEZtrrNchtYbV0uMClETaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4V2H3XCeedEXaqQKnmOSRBrw9slrVlbZOb6GLjlpwdwKTv1jnAHKTT9npT1etNuE3AhAWsHhq59kt9Lv8Mc9Vmx9NxoihJeJVuddoO/nuudXknhgtfPLCbwUzpkLLEy2mMJqKKuOPHVl/PE3rK3YZJKbvnIz0fax/Lc6MCvrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I26utYhD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I26utYhD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DIqHp97e1+CNKtjbRZfd1Zm1V5xs1TXHOVWIpIgd7Xk=; b=I26utYhDQhoVCdDCkLyX+G0OT4
	4gvbuVpvKfse9rvRAtYMzGw3bXSexcVFbHpvOFmQCAX15N3uBBJ9onDismXb8F7NuVbHkOhjO7Jt8
	FDrxkszxiDzYbbxQ/I6mD4Dw3WQlttxBMsz5BpO+JyDZ1FfXoIdSOG/OVkUAUNizml64qpogk/tkf
	cENDzVab02X3l5KZYcwZ+gAd0D+rvygE58vJbvQaxwUVmM3hhX2/AX08cThsosjMtbmBqWvLOkKrq
	qjCPME3UwGAKc271G64T2hGDB+S4pj+fg048XGqWJbCPmIOfjYsrxsDQuVGlruL57a2e9CTfZi3xN
	DrntY01g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxtXj-00000000732-1iAG;
	Wed, 04 Mar 2026 21:14:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxtXf-000000008FR-3YlI;
	Wed, 04 Mar 2026 21:14:03 +0000
Date: Wed, 4 Mar 2026 21:14:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, quan@os.amperecomputing.com,
	keyur@os.amperecomputing.com, iyappan@os.amperecomputing.com,
	andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: mdio: xgene: Fix misleading err message in
 xgene mdio read
Message-ID: <aaigm4iqgf6fSaZu@shell.armlinux.org.uk>
References: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 04, 2026 at 11:57:36AM -0800, Alok Tiwari wrote:
> xgene_xfi_mdio_read() prints "write failed" when the MDIO management
> interface remains busy and the read times out. Update the message to
> "read failed" to match the operation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
