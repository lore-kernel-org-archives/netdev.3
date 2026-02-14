Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A261F8755;
	Sat, 14 Feb 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771095760; cv=none; b=Y2LbjLML2xvgh7K3Wbu7igQH+/yEoXV+HLsy91bPECmcAnqnumR6F54Pr/Qpi68kP1TifGExmjcpMxVPmcjrNeWzYB79cI1zFBjFYUqoU//zQzwQa0IK5fVD8qacsQ6Xwm0rccIyiY69mnXGPe6VLF3cKONCUJU+IgffHaou0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771095760; c=relaxed/simple;
	bh=qT6IKyTgPgoWtq/pv4/ob9KiVzrzF9Y3L9t2eY2mF7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1PDEaHQCRVa67D4Ig674qJwsrZq3KymStmx7CJLD0vSHdVsKV/CNSKekNO4teP++Q0kuG8RL5yH0NssJtO6lB+dJoElZVp4rZCP/C0j5hoWFhZbVKUOeQ+a8AxQoJbbWDRB8T4rSKVPdP92/8rzYSEDvLANkuKo95oyimgreKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=s/RJfSbH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s/RJfSbH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cu+TqsuHAXYizEfNBI0UDoQ498p1s8mX09LKRbQR0g4=; b=s/RJfSbHpNem+gp3NJ6JTnqJQS
	fxoaewFnUWkdh4CzkZq5dJSLKkncMY/reCTtwACFwPCnPpv44SQAt42IKKzn6aCVxsEAH+SX85IR+
	VwPDaw3zr14DSsm5ODITZJEKB7aJCHRburoWQYIOqTMmv/3FaoxszQu1K0kJiPryY8eFAooGLmgVZ
	ZgGE8NBwDSy+MaKcNPNLN0WiUscah3Oq/QL3NsxXQ3Z8GD+deTqyGTGr8tZymD3FeDNg9GqTBoaAQ
	GJRHzuHVAHv6TLa0HgGoXqvTyjrtIkFUTImQKXRVHznsFd2sT+q2G8jVryzQKfAS2TwyQ+WT3nIpD
	YaIVBGkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52392)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vrKuC-0000000060D-2rUa;
	Sat, 14 Feb 2026 19:02:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vrKu8-000000006zz-2kpK;
	Sat, 14 Feb 2026 19:02:08 +0000
Date: Sat, 14 Feb 2026 19:02:08 +0000
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
Message-ID: <aZDGsJNLZIty0242@shell.armlinux.org.uk>
References: <aY9s5PXP4zZ7R6fa@pie>
 <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
 <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 14, 2026 at 05:50:15PM +0100, Andrew Lunn wrote:
> Rockchip have recently started adding support for a new version, and
> appear to of listened to what we have been saying. So it could be the
> next generation of chips get this correct.

Have you seen any proposed code from Rockchip for their new scheme?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
