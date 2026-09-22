Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B5357D1D
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111198; cv=none; b=BfJpK0t32PAtwDTBouZlKz6gv5A19LilqfLSLTo3+t2yNSeNPyHfskY5u8fkhHeIo9To4FIDEWBWA3nNq4xuyhzgqPLjVO4PBwmlWQ2sXegkElBMpQIMIc8uATNZB8uFYBdyLzTo/9SDy92W/3lcL3bN9ZGPWlsAJH8W1njpYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111198; c=relaxed/simple;
	bh=JdtHqMS2FdX2jVz7Qnh9w/MfZ3IAdiQq5xr+2BkHo/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=METDoQJVaDqUxiuv5sSJ+T4FA209zi5vT+UJfKjhtsi3TygWP+5z3ifzynhpN73p6oVzJKE9LpER6aLy3fjrAtecl5lqQejEsYCVb4uiS4bBwLBdq4Kxk8iBw4kdSOXqYfNO9fFN5g6nhsS4Fbjj1TTMiWNnqRgEijyhfLqOXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oRdkmR/z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oRdkmR/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NYirrNBuhR4MQDPOH6D4PWRr+5A7+MjyI1DL0E/A/ac=; b=oRdkmR/zI8mg39nUaO+/s6AUDi
	SJN33rFucmHxqnCc+SHn6XL57dJ7bVXgspcvWw4iNziatEICGmK6swab4HEBoI+Ba4g/MhzzygxrA
	OBxTJSt+e13aNglfS1tA0vaF1B/oJzqjTI2PQdISZtQQxJdvPhNkor9IJVYGUXxMk0kA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x97gq-006fwK-Nj; Tue, 22 Sep 2026 23:06:12 +0200
Date: Tue, 22 Sep 2026 23:06:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, ansuelsmth@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [RFC PATCH net-next v2 5/5] net: phy: qca83xx: disable
 SmartSpeed before resetting CPU PHYs
Message-ID: <c50f5ffd-a67d-4adf-a38e-048acf7bd61d@lunn.ch>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
 <20260922202653.1153-6-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922202653.1153-6-yongzhao.derek@gmail.com>

On Tue, Sep 22, 2026 at 10:26:53PM +0200, Yongzhao Chen wrote:
> Consume the qca8k flag on QCA8337 by clearing SmartSpeed enable and
> bypass-timer bits before genphy_soft_reset(). Read-modify-write preserves
> the remaining register bits, and a failed update prevents reset.
> 
> The same clear runs before the resume BMCR reset. If MDIO access fails,
> resume returns the error without issuing that reset.
> 
> The downstream Redmi AX5400 experiment observed Gigabit advertisement
> being removed while the conduit was not yet running.

Does this happen after .config_aneg() has been called on the PHY
driver?

Is this another name for downshift, where the PHY detects there is a
broken pair and so reduces the link to 100Mbps which only requires 2
working pairs?

	Andrew
