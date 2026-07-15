Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3D42048C;
	Wed, 15 Jul 2026 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121266; cv=none; b=AjI44ECVKfUbkWXzRC9poOzSFz/6PN/qqCOamEdOjI9Au8EQYrJLwyD7k7r8oaMG7w6K18u6cFhkjllZtdqJfeYEsr73YZkueZMc1ZUpbZ8+ekW/apYxiXSMPlNipR43ejCdZ9Hk4UeozPytZcj+ctyzka/cEcfmJoDWs3J9YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121266; c=relaxed/simple;
	bh=1n1me0HW/60IlNzlclm4wUnOKtrEZvAsZP0FQtBUqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVY2MhP8qPywtWjAJupN2fBWFsgGtOcSae1hmJHZhszQfa8/dMN1HCmianSKbgdeJhUu98Eb4LIs71LTi2YURGM/xArQnDMB+vlC45n0ssXXTr43Ddk0rMhRJxsRZNoPAlYz/d7ZEIVjdIslG0jkwyRnsmJof605lZN5BvcdIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QpxhrUx6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QpxhrUx6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7pwS8//mFGs3TLwIfH0iHzBhfKiC3tgg2YbAeSiqB0w=; b=QpxhrUx6e7m+SZzEwoiiGe2s/D
	jAhofgM7n+syKEfUFsxN2lsyLC9yuodBXrSqz9oMJbF0xbbXjC/lDsLMc1KB5RlQE2mTuLp0EpukW
	XpCH7uN5dUd47BgOB7iS5vxWYrD5ubNkfSfMdyTFZIQs5a6BrBwKR9LJIz1nc5v8THJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjzRJ-00CMC6-RV; Wed, 15 Jul 2026 15:14:17 +0200
Date: Wed, 15 Jul 2026 15:14:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 1/2] net: mdio: Kconfig: Group mdio
 controller drivers in a submenu
Message-ID: <53d88321-1913-4518-869d-ab32f14e22fb@lunn.ch>
References: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
 <20260715082226.51481-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715082226.51481-2-maxime.chevallier@bootlin.com>

On Wed, Jul 15, 2026 at 10:22:24AM +0200, Maxime Chevallier wrote:
> Currently, all inidivual drivers for MDIO bus controllers are directly
> listed under Device drivers -> Network device support. Let's group them
> altogether in a submenu, while keeping the dependency on PHYLIB.
> 
> No intended functional change besides the menuconfig ordering.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
