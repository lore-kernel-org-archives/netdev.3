Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EE36212C;
	Wed,  8 Jul 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531651; cv=none; b=JO7DEBLWw4kkcwU1cIAkX/8DCcpzbKTalDsrlXKXlImqo4toyzJp6pTlpZZN5sdNKmwdNNU5J5dc3r3sTr6DSbu3WHeV5tKPld4X7mMkw5iWXAdvjZJTAh5XIwIzWA0ozD38LI8kBiiapPjsl7d8rJXfgaXe78yS4Jk8HR+64c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531651; c=relaxed/simple;
	bh=6Tw0mCyu8NbeNKLcb8xdMLazzuLX6hJ3oj78/Kb4JJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7A3Oqs+G22E/zzBOgCRsD/Uyg7vz/O/SsFJ42pY+3Mr71NWroG8ukZ2nQ9Lz48G3ZirEmQiVGxzmiPN/G5QLv4WZkTT4Dt5AhGyhm4BAhoUonVJcqFJA5cKtaNTz/4NQraJNESG66qpTsJZ8OhfVlguYQxNCMVogNW6BqjaAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=roh6VpMR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="roh6VpMR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i7/EOE2xP34J/HXHqk7TR9GvRXZ14j+FiGbmWH6r+Hc=; b=roh6VpMR7swrNwg7qqQ2lMOini
	ECFDO0ugp7dXvmeJguublhK2C4pwpoImw+Bm+xkDq8fTcTzRukh0FzBXIpz1zQ/o5AbsZeasKxOVs
	OoN957e3yI4mCxe4iNuGM0xESGgXD6vp47dkQ0/qbbunCGTNlBG1nubOWTWFI6othruc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whW3N-00BMVM-CL; Wed, 08 Jul 2026 19:27:21 +0200
Date: Wed, 8 Jul 2026 19:27:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <42792433-a95c-431f-ba0c-dc0644dcbdb5@lunn.ch>
References: <ak0KOrM5E2_sPIHf@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0KOrM5E2_sPIHf@makrotopia.org>

> + * The flash process takes approximately 15 minutes. Progress is
> + * reported via devlink status notifications. After a successful (or
> + * failed) flash the driver reprobes the device automatically.

Have you tested the failed use case?

I assume if the firmware in the flash is invalid, the bootloader does
not boot it, and it remains in the bootloader waiting for another
attempt. Does this DSA driver still load, so devlink can be used to
try again?

      Andrew
