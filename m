Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A6257845
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810287; cv=none; b=hPlBxz5Oy+iHaDg7oDcelbq7teOd+Eg//nMLpHvtjCkjPEiegrn8K9jDwt+zU6dX3oUbzRQpxQfeED7xui9McKbeSKWAaUJ2lM71PFMmXhp3E7+hkDGKv+5iutJmhmKJQo9dUynvPJr+9j32dpDFpvtKpxbLjGzP7lFzKiAFbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810287; c=relaxed/simple;
	bh=QjmZmixW0ZArSo8nLoJWPYikYGxsTiSShB+QbPkKd2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt5XaE3AhScIWNu8DK8t1N6piullNf2hmuVLUtuKj9rydkRwO4PU9c+wLTgQSe30WWiIuoTcSVGqX1ih+mEHdZ3MM6QZquEsnkOMZasd+TfsU2MCYhl95SSN6dK8NuA6g0DY58BGC8T4xLw9wf/SlVMhbY/iBtP3tKd+v9dLeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TCX48G0o; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TCX48G0o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MkB3zjZHS6vwd8b3RjjpKkeR3qneJxmhLMAiJQwBqNQ=; b=TCX48G0oF8y68pyA/xRADyxEkq
	jROR84zUloQc8DGevldQokQgi6xVTEQQhemuENKvZzLxppUHSfIODkj5rGEp/eAx5TifM36relQ3J
	Va0kGHW6imY3KKE+Z+RnFfVHwJuFhg7CEfCbLLerxkUaPjDur0NAkmoQjn82KfSzt+gk/fox6kCuN
	ZWHbg9L48Q4jPv89fY1tyj2/GKZv328BqM1Ahl2CWGjQ453e9oGiLk4YFQV/HQE/qjk+mAM08jn7l
	2pS5ZsvysQ0797dn8zG3S1ffpZMrCyf0K8l0N2jLBk2Sn3/UVShJ4iefMLZsA4FFhfdRTaNi5rSBG
	Tb1eIhPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6vEF-000000008CD-24t8;
	Sun, 29 Mar 2026 19:51:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6vED-000000001wx-10vu;
	Sun, 29 Mar 2026 19:51:17 +0100
Date: Sun, 29 Mar 2026 19:51:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] net: stmmac: TSO fixes/cleanups
Message-ID: <acl0pTqJ97o0PRxY@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
 <20260329111123.740bada9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329111123.740bada9@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 29, 2026 at 11:11:23AM -0700, Jakub Kicinski wrote:
> On Sat, 28 Mar 2026 21:36:21 +0000 Russell King (Oracle) wrote:
> > Hot off the press from reading various sources of dwmac information,
> > this series attempts to fix the buggy hacks that were previously
> > merged, and clean up the code handling this.
> 
> We have a limit of 15 outstanding patches per tree.
> Please follow the community guidelines.

I see that restriction was newly introduced back in January.

> While I have you - you have a significantly negative "reviewer score".
> You post much more than you review. Which should earn you extra 24h
> of delay in our system. I've been trying to ignore that and prioritize
> applying your patches but it'd be great if you could review a bit more.

Sorry, but given the effort that stmmac is taking, I don't have much
capacity to extend mental cycles elsewhere.

This two patch series wouldn't have exploded into ten (or maybe even
more) patches had someone not pointed out the problem with
suspend/resume interacting with disabling TSO... which prompted me to
look deeper and discover a multitude of other problems. Should I
instead ignore these bugs and not bother trying to fix this stuff?

Honestly, I'm getting tired of stmmac with it sucking lots of my time,
and I suspect you're getting tired of the constant stream of patches
for it - but the reason there's a constant stream is because there's
so much that's wrong or broken in this driver.

So either we let the driver rot, or... what?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
