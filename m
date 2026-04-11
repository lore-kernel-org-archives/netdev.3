Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE761E633C;
	Sat, 11 Apr 2026 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775908199; cv=none; b=BhwSCMhPv+et4o3gicuUXmEXmtjqCKauqLgPpdFC+SwIxjc578j4qIwewFLihY95ir23TdxMLM8Nb74EHDeV7j2+uqMwXMvd7PZBdP2rGxbC0u3f9lBbfQHpKL8/Eacr2cmQPpJtGc1eNTdfkMryHLjeD9GOeuk9Zu0s6qqiHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775908199; c=relaxed/simple;
	bh=VpuD7iWqGHd7etcKXcAHh+iVV+ym/x0pAo85hXx4Jhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu234dHS9+VGd9ZZWRxoMDgguXA++pNKgFeMDmLjtgkt6trLhjJXLG5Qa/IBErhRv8GBZOYdPBxjsPg07HC2TcPt8gHbHWBqL8nYXQwbzaKlo29uIkxkSOMOlX0VUGvIdpvhyTnIgYVA+OxwxYANv/ljh0pqWMxmFw2rG/3pg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wBWqI-000000001yt-0iW4;
	Sat, 11 Apr 2026 11:49:38 +0000
Date: Sat, 11 Apr 2026 12:49:35 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, michael@fossekall.de,
	daniel.braunwarth@kuka.com, ih@simonwunderlich.de,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: use LEDCR page number define on
 RTL8211F
Message-ID: <ado1T2mbTA3cBKvd@makrotopia.org>
References: <20260411105150.184577-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411105150.184577-1-olek2@wp.pl>

On Sat, Apr 11, 2026 at 12:51:45PM +0200, Aleksander Jan Bajkowski wrote:
> Replace the magic number with an existing define for the LEDCR
> register page number on the RTL8211F.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
