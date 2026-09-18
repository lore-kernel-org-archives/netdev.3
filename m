Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1644F6460;
	Fri, 18 Sep 2026 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726626; cv=none; b=QagtNeHIYdyOUWlxebrTTsnULG9PwDtBp2PrSHp5ciMfzgXl4+wo8OjEp61Mdd0tkvS0FEcl0Q9kFj4jKHyl/s3u84D9WQ6OLC7s+prjsC182pCMVaVb+AB0i8UtZl5Yn3tvUg4jmjRstv0ROY+xdFEv439439V1CImjHG5qh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726626; c=relaxed/simple;
	bh=Umdnckj/Pv270Hpi+iJItlPPecV9HERP5wUxztOHEwE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BVpIiXeYDdboWW/fD9aWcMLBP8oZvP93FgzWqmXQw1W39ZlkjwjF1HoF+gNMLIHx0j/LkyhvTZSyalXETBV0SKjvUAoemCpYGd1F88EshtWbNtZC86f2D7rvpbyx1ZGglpKCkIJ3VF97FD6A0xzJuQLR9DFioU2oJf3pR3o9BWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=QascyoPD; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="QascyoPD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EF47A5620;
	Fri, 18 Sep 2026 12:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789726613; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q6RdvS2y/NYTy1eqHoSNFL6RWEeWGyUp6RfbyD3opoc=;
	b=QascyoPDH9ubhwH/RD6xxeOdq9FccC5Bog6M2H9FGj4lFJl7SK1EDQjqdt1F3KoPW0+eJ6
	MXEhlxIxnyo0TrZRfLrJ0XLV+pcnnuyY8bAKAE2YsPCNGV+YVKvA343LbbmaoZGny8rwj7
	TEVeNNMJEKj93nGTvNfqOPscKbu3gI5OWhy+AhoC7IwyFFFmPwN/KDjPbRr4I4oxqjKR9S
	MKX6H0e37AQoafWHVbxcUnJFRWnWghfQoZ2Krf36ZTUU1RqpQ+SRwmc9wNYc9AP6jvvB9G
	JA3CdU7X3rQwhKPXB+pldHBw4W0gHNMoK+H+7ftCj4bI5jMXNkvd160h+5sGEg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 12:16:53 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/8] net: bcmgenet: do not skip WoL power up on GENET
 V1
In-Reply-To: <20260918000732.276506-4-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-4-florian.fainelli@broadcom.com>
Message-ID: <d54766239c598f0261184a80d65799d2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_power_up() had an early check for bcmgenet_has_ext(priv) 
> before
> dispatching by power mode. GENET V1 does not have the EXT block (unlike
> GENET V2+), which causes bcmgenet_power_up() to immediately return 0.
> 
> As a consequence, when waking up from GENET_POWER_WOL_MAGIC on GENET 
> V1,
> bcmgenet_wol_power_up_cfg() is never invoked to disable the WoL clock,
> clear wake event masks, and restore normal PHY and MAC operations.
> 
> Move the bcmgenet_has_ext() checks to the GENET_POWER_PASSIVE and
> GENET_POWER_CABLE_SENSE cases where the EXT registers are actually
> accessed, allowing GENET_POWER_WOL_MAGIC cleanup to execute on all
> hardware versions.
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")

c3ae64ae0c08 ("net: bcmgenet: handle GENET_POWER_WOL_MAGIC") ?

> [...]

With the correct Fixes tag:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
