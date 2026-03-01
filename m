Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34A33344A;
	Sun,  1 Mar 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377884; cv=none; b=eXiJQo8/tl7FkHAjZm08AgUfvNmr1+SSb86xSyMW+u30KAwpkkMb1urREmmRiLXW5CaogOfrT9YCj6r4J1+j7TY2leKfPVAP/EP9LQWu1hoJa7+lxV4DkU3ZEY1bTGaiLoXYT3iRb86rRgCK8K9M7oKSWg6WSy8HrFufExyMRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377884; c=relaxed/simple;
	bh=5oipx8+TOnO24hSfjvP1Igdv1jnKwQ3GJ3LYT5IOIBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAI4bqaBqW9+aKa1CUOgZoCk3BuTOIChuLzGNRUgdHz2tgMBRCYL2nQ9E5KRZ0u/y57Gsocau3OZp2jQ377nCXDxqFS8x4l54Rdm/7COKPprtDTEGLBDxSHbjzm2mNTbPmOWTd9NSgTAD3zPgUkU7PaK67Oh4s9bYqbLh4RkAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uaifjYPF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uaifjYPF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=pwhmjQsbXem5Vo4+DF9ztOlh3riUC6Eb/RZs2skHZhM=; b=ua
	ifjYPFYxJmwzZWRUP+45XE/IYbZ9N6tUi7WDav8TMsug6GMtySN8fcLHRR5j/8Mdt3s5nZ26Hqo0P
	erizph5rZQS+TiyWdo8A8mNfEa8BGrpxvhaaZLgce00uYFcLeE9lac9TsWw9DMyuw7UEt3KADUlg+
	/sTMJhXEcMITBYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwiRt-009OYP-Jh; Sun, 01 Mar 2026 16:11:13 +0100
Date: Sun, 1 Mar 2026 16:11:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 1/5] net: mdiobus: Scan buses in reverse
 order (31 -> 0)
Message-ID: <cf2d16d7-be4a-4729-80e3-81f6f02eeb8c@lunn.ch>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
 <20260228232241.1274236-2-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228232241.1274236-2-linuxtardis@gmail.com>

On Sun, Mar 01, 2026 at 12:22:37AM +0100, Jakub Vaněk wrote:
> Some PHY devices incorrectly treat address 0 as a broadcast address.
> As a result, accesses to address 0 may cause multiple PHYs to respond,
> making one or both PHYs work unreliably. In other cases, the PHY may be
> detected twice by Linux: once at address 0 and once at its actual
> address).
> 
> On several PHYs (e.g. Motorcomm YT8821 and Realtek RTL8221B), this
> behavior can be disabled via a vendor-specific internal register.
> However, for that to be useful, that register would have to be
> programmed before address 0 is accessed for the first time.
> 
> On non-Device Tree systems, MDIO buses are typically scanned in
> mdiobus_register(). Change the address scan order from 0->31 to 31->0
> so that PHY fixups are applied to addresses 1-31 before address 0
> is probed. This way the address collision can be avoided.

Please add a comment about phy_package_join() etc. You need to
indicate this change has not broken any assumptions. It might also be
good to extend the documentation about PHY packages.

     Andrew

