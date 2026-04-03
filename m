Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93403AF66D;
	Fri,  3 Apr 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223105; cv=none; b=VfQWwHzDJx0gI5784kJsPFPj19CxrJ+YwCCxE23tANq9qsoAW9DU4bA7cGRabVO8YDSLx0yXF6Tut3iVwRgOsrYFgPkyThg+0MGsTM10dDSoX8SWaffSZdkOcNaR5NLIO4OMj98MvuaOoDGIz9iHDPNJtZEo2yc6jaNlJkDxSp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223105; c=relaxed/simple;
	bh=ULlTor93LTVl7DpujHY9Tt49xouP3oK17pC/jZvCvqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+vltXTjf08XkrT8E5aTzJOekVdxi98EflxAc2nLVo3fR2fT/2uA6bZg7v4cPkse+tcIGAFJFCYPl61WRwBopAKO3ySFRaCBWETmCiotM44S8X4ArGvzGaVE0VfWw5wasjY8Fn7fUhN9jiTey07WsN6mSBXRXCtebba0HDyygik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=cePKHuXI; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="cePKHuXI"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id CFE97E873BB;
	Fri,  3 Apr 2026 15:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1775223095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBISm6sVGwWV/xV8gKA9Istq2dgSeXSMu4fAVjoCJME=;
	b=cePKHuXI7VUnwqja+ZiE3RqKtB/JqxJf0NEZypbNJDO9UaHuQKLRQ0uRFmBHDE5nfM1+74
	qQqg9G2yTq/CcREx+qD37dqSAX63/FGLS9bXUy9LPesiFSBKxX7Rb96+7aFrSsEXCx30kT
	YPbd4nLJfonsi8OEMc+G+VeKvtIwKlAGpqn1cetcDhuBF8yAREAFBN9vJEijChLXULGsjT
	I1BSyC+l+RPWiAWUj7icspJu0ubD89vKsaTWtLyTIwuFYq8Yji+uT/Zu8d7VgZ7mVuGeNz
	svlKLGp/ZqMy8hbqsdY3LQU8jRtQuldsxVGOt1sMpPDfMJ+MF8P+1omto6hBxw==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id AevU4C_n1MBI; Fri,  3 Apr 2026 15:31:35 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri,  3 Apr 2026 15:31:35 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
Date: Fri,  3 Apr 2026 15:31:11 +0200
Message-ID: <20260403133111.3304497-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
References: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thx for helping me! 
I thought of keeping the eager path so we still catch broken DT bindings
early at boot instead of silently failing later on first ethtool access.
But you're right, dropping it would simplify things quite a bit. Do you
think that trade-off is worth it? I will follow your lead. 

cheers Carlo
