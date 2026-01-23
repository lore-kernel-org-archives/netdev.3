Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110529E0E9
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198714; cv=none; b=WWrEs2de4Ax6zPxoWu/JUUvpvM1eJKULJ4p6IOCj8NnOlzRrzb4Tjg8tARvsuhBIClzKG7kSYs7iFOLAp7BD7g9y77aaQZMYovDaTu34h37lbqpsfPA5RNRWlDmVZzT3/vWjPSZ3XBRsT3R8Ug2ItdLmnxqG+3VFAbQl8Vp/ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198714; c=relaxed/simple;
	bh=Ldu/Iph9Sl2g1wo4/QwtGKNLWTdTKEPfd1q0etXiFcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcbTUjmqzBWgnydXhxZe4hpRnG/JegoDW13P0Sb1s1SmaBlSjJC+SiW59MzKnhh35uNnpW6XMO5iYWyjHFdoTD0arJwY5ZaCBoJWmRpwKtQ8Sov3btlLoQ1fXRXlc2M8LSNDrOxXVv4J+pHDblt9dSBgXWkqEuasYYyUOQqBl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5uIGOQC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5uIGOQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C348C2BC87;
	Fri, 23 Jan 2026 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769198714;
	bh=Ldu/Iph9Sl2g1wo4/QwtGKNLWTdTKEPfd1q0etXiFcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F5uIGOQC60CAbbESyp3DGk1hvnN0d33H/8oWwoFE6pCLSWb6xgSMaBz3sJ+uT/rJi
	 grLPgFgBEPB/LPWjWwRZmzBbmRe2kNluYTTe6XXl1cV4vKUJSJo+oYWkSQ2SdVdrP0
	 /WcpN59peXqAcwj/KSwhaOrnMsNxSq9IDf3yJ/QfmWfsws8IUtPCyd/Sknlx1AYUq6
	 8FnTVB98d4oa6LgdeF3OBGRi9D2tonJMn4ZeES56YoJipfXSRp8mappPH2SbaaNxhQ
	 lDR3usIbYVV5SWbTYxnOmq4977oVCMDmgYYes+qVApFy+A47oZQTO2TLSFG3tPh99+
	 gQoUsPgnxjBXQ==
Date: Fri, 23 Jan 2026 12:05:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, lee@trager.us,
 o.rempel@pengutronix.de, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Message-ID: <20260123120512.162ae4d9@kernel.org>
In-Reply-To: <7ab606d1-9f65-4123-827e-58650eb8944a@broadcom.com>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
	<7ab606d1-9f65-4123-827e-58650eb8944a@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 11:36:33 -0800 Florian Fainelli wrote:
> On 1/22/26 11:21, Mohsin Bashir wrote:
> > With TX pause enabled, if a device cannot deliver received frames to
> > the stack (e.g., during a system hang), it may generate excessive pause
> > frames causing a pause storm. This series updates the uAPI to track TX
> > pause storm events as part of the pause stats (p1), adds pause storm
> > protection support for fbnic (p2), and leverages p1 to provide
> > observability into these events for fbnic (p3).  
> 
> Jakub, should I go ahead and re-submit this patch series then:
> 
> https://patchew.org/linux/20251107002510.1678369-1-florian.fainelli@broadcom.com/

Sounded like Oleksij is also interested so let's go ahead.
Presumably an attr in ethtool -a/-A ?

> Looks like this is exactly what you ran into here.

Kinda, the machines reboot on panic. The problematic cases are those
that crashed in a way that didn't trigger normal reboot cycle. 
Or got wedge somewhere funny.
