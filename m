Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DB314A9B;
	Mon, 16 Feb 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254093; cv=none; b=nmVG7oLB3Hj6L9dPkihq72pYyMl1ofNOq1qqeQae96fCYLDermGPCtmxHGmikAWOL3Oy7vn1sBcNtvS2gFrFNSB/WR2+kEc6hktrtr9Rgo0jNwmQS7gaw9JSi+Mu8Fybp/s3RUIzeh4PO25c10Jnnm9aSiWtye1B4SEZeOY4kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254093; c=relaxed/simple;
	bh=vWuDr3Tx4NiEtoueri5s7dOMix7kqoaTVHP12WT4dMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvolYd2yVKneQptDm3d1kwzhwzw7eW81DqzpDFEvP2DZY9vUO0bpFYUHwkNtJzDS3+6xNyeXyCYkYDifOybD1q0kKVWLnNRj2ISjqvDQvnE5Dt+EgnM0c+rkGwz3H0b/C53H49RDEpD4wJtMR91tJwiCxtJedy9JjKBwVMgsJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w6PjxASX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w6PjxASX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fZ0BCqVUH5xPPVxomeaJKF0H4wRC7cRMGuNTgfAR7WI=; b=w6PjxASXJb/jnKoq7U4mc7F09F
	M+xmz3gOYR7Ca1HJInWEsV5zH2bW7wTOmUURs8Iqd/CedefWZsl40Eml0ThMfyZS96rueKMgBG4zv
	Z3GYZTxYKJKEl1eD6d/vndPPB7BzF8znThFBD5KMyrGoWDlc50i6brFtlE32V91VSFrC/qEaiauFh
	LgDo4370TZ7ofHrDPYb31I8cSwTfqRp4vVCbBly/4F8zr87B0JN3GmwCfaL9Df0ReNWQYLYuZZ/ZA
	/dJjNkCQ+lPvU0WaSAfDlkFOELE+aN5C3/GsLc2AgZRHIp306ODXzaPchHtcOCqIKglF+c+m5/O7W
	GOxrcLrQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47910)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vs05t-0000000073K-1oiw;
	Mon, 16 Feb 2026 15:01:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vs05p-000000000K6-2pxV;
	Mon, 16 Feb 2026 15:00:57 +0000
Date: Mon, 16 Feb 2026 15:00:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yao Zi <me@ziyao.cc>, Heiko Stuebner <heiko@sntech.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <aZMxKdkl2Qa7e1WU@shell.armlinux.org.uk>
References: <aY9s5PXP4zZ7R6fa@pie>
 <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
 <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
 <aZDGsJNLZIty0242@shell.armlinux.org.uk>
 <a4aebacc-c273-4e42-97ff-0cdd88d771dd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4aebacc-c273-4e42-97ff-0cdd88d771dd@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 16, 2026 at 02:57:48AM +0100, Andrew Lunn wrote:
> On Sat, Feb 14, 2026 at 07:02:08PM +0000, Russell King (Oracle) wrote:
> > On Sat, Feb 14, 2026 at 05:50:15PM +0100, Andrew Lunn wrote:
> > > Rockchip have recently started adding support for a new version, and
> > > appear to of listened to what we have been saying. So it could be the
> > > next generation of chips get this correct.
> > 
> > Have you seen any proposed code from Rockchip for their new scheme?
> 
> There was a patch, including a rather odd formulae to convert register
> value to delay. I gave some feedback, but it has been silence
> afterwards.

Searching lore's netdev archive doesn't seem to bring anything up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
