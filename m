Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792493;
	b=cHg6OJpJ9lLKT/bv0oBJxKmuiPhIYqsQ+l6fBEXGjg3z8wDq4OMOxAQV5P3samxdbKDx
	 kcALYMh1SefTlEC5lRa2OXlHqPkyNtKNEnWRgN9PnnwwZgON/VOAsY77++w1vuvH397Qa
	 OpUNzlFh2439VKwg/tobrvv9XZccWlFqfleSzXj2Cl5OrsIVSbkuOAWy9Xa9jXwkpJQ2a
	 Bh1FjONxhYk5LHCSus9NJt/Bz20VoK10YDbtRIJ0KMdHs0zlNhpsLiibvikwweopj0vb3
	 VNUPrFmS99yOTWmAoiCFiVdXZeNDsQEB4cX8YATHGweXNePQ1qvcMp03piCpF+i7jCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Qb8IozTgHKQQ6vrxYNMVYzlqHaIYwX6c5i2r79HOrtw=;
	b=lQkOI2LYV64h5RknG8D9kfDt9p1pH2WjpvcFTPPyv8VnmFHnOjS29bDHvW0dihXkXICb
	 1dxWP79kPNi3umVNT0mgc8k9gXcE1djyMEe0XFNE58vUXHOLEgiO1BDmRsNhgXCUkBWWu
	 JpIJsql/jldAZOuSvyMjhuCYDhvmcPPQxByceePyDWL3MOBYJdcYrHImFfjzDTcfnUt1C
	 SQpQNIFhJ8df+Tpx3xwEhnCfvPP6+uI7xtgISIjr+9NBQGndTR5FOCBC++JMt/PAXBfmZ
	 PNwnELo0qUIwVP0qzHtU8J5HxSLzy1oi2JoOC7CgEOfz7PsQssv1X0aqmOF4KA9oaIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=TN4NkhEv;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090B606A31E;
	Fri, 23 Oct 2026 21:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5090B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=TN4NkhEv
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 262B1E83954;
	Fri, 23 Oct 2026 23:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792792486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb8IozTgHKQQ6vrxYNMVYzlqHaIYwX6c5i2r79HOrtw=;
	b=TN4NkhEv5J4hL38fW9ekD/Mv0IKypgcjXDTUI7/yXv8JTT0vd9ANKj1+3sPddJLE4yTReA
	3eAxp6ggXPxYwJBZqLCmfkDKDUX4j5DNVrWY17tp+13wxjpjg0OMs01SjmbdAZEz+kp2U4
	D4bz6trM5KqwLLX4bJjySnQp71JJmfRS4fCpitwAjNOf2CyjkqWacBEtBjVJtwQLPksELX
	lyz+9v7XyX9vHk5qblR+/PWwamVzwtTiRJn9eKWPX4rs9Jdof8adDZlLnPW+ua1lH5+xKy
	N3lazv08xQ5v/H9D+VtBn3oeRK+3ETKkArc0PqE7CiRMs++u48qPdnXY0kddUA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id KwJjj8dShNYH; Fri, 23 Oct 2026 23:54:46 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri, 23 Oct 2026 23:54:45 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 06/14] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Fri, 23 Oct 2026 23:54:41 +0200
Message-ID: <20261023215441.1087277-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179274321449.3134.2737207729630977183@kernel.org>
References: <179274321449.3134.2737207729630977183@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 23 Oct 2026 08:13:34 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Do admin_state_enabled and isr_pd_detected really mean the PI is powered?

Kory, a question about pending PIs. A PI can be admin enabled with a
PD detected but without power: when there was not enough budget when
it was enabled or when the PD was detected, or when a PI with higher
priority took its budget. Such a PI passes the check in
pse_pi_update_pw_budget(), so setting a power limit reserves budget
for it if the limit fits. When the PI is powered later,
pse_pi_allocate_pw_budget_static_prio() sets pw_allocated_mW again,
and the budget reserved before is never freed.

This was the same before my patch. Should set_pw_limit skip a pending
PI, for example with pse_pi_is_admin_enable_pending()? If yes, I would
send that as a separate patch.

Carlo
