Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BE35C689
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713943; cv=none; b=blu9EhGOyg2hhIeWehw/3wGmeS4Mc5Yjntpw30+h8BI3dFgkMIqAsF7tfvVXwyPSkmH+zg9i7+uP+3dgwvnad8R1ySalQSq1o989Xi5T1CMYGULEG/X6AIbnWpVCvv+/XuAoXJb31ZWQRJJVptU4GEnGJcJngnifP2PNlGv/BgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713943; c=relaxed/simple;
	bh=zzjyPzaTQMBt5HlLjBXV5nQ1WvrfyaDFdaz/QTRoJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg37YKpKWYNXMzG4Ti2fcpJo54fp1SG3VqK4aAlSNeRKh5GqdUfftb6VHHd98dl34mUwRdlGN3ptFaOyuxAb1xNpeg1nYfKwl8Hs90NT1q3rTYNUnyPNPEEgY9kbVt6cGOrCM/s9pWZnxJBzjRYILOGLC7p9BOmcm0r/rJUv5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rtkDxFdx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rtkDxFdx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 21EF81A1162;
	Wed, 22 Jul 2026 09:52:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E63B960388;
	Wed, 22 Jul 2026 09:52:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF7F311BD0424;
	Wed, 22 Jul 2026 11:52:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784713938; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pgo266Ejtr9qFsZy/rxRmwXgSNyRGi3lzEytrT/pfHs=;
	b=rtkDxFdxpJxEROqIhTqoDsJT5xEn+6sBBeJw4Fgd8IoJA1GimmWgnhFrDaxYd7w70gKpNn
	4eavYw7M1z/EVkiCqYwVexfREmAc8Vk9w1adp4aqdAytZ7KsX0gqJTg3/EMUdH7TYuuM1F
	JEWrqc2Q5AX1ko2IdsD6mAWDpvTZlsC657f9uiX2uROFuklRYtqz3SjAweHjnM8h2v4YWq
	whnDFpFnKZf37A5zFKuT9NxCCqw7kFHR5VpSOgsC9Tj3IvIqtqgi4wQ0/pfN8qc3/EBkt+
	U110S2zOcb0fJQStf86jsoN7fhdyOB7gaY+vnb6j2UFamD3llIZvcXHQqYTqCg==
Message-ID: <a35ce7df-534e-4eb0-a8b3-7239c3717759@bootlin.com>
Date: Wed, 22 Jul 2026 11:52:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 05/10] net: phy: Represent PHY-less SFP
 modules with phy_port
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>
References: <20260720174808.139573-1-maxime.chevallier@bootlin.com>
 <20260720174808.139573-6-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260720174808.139573-6-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/20/26 19:48, Maxime Chevallier wrote:
> Now that the SFP bus infrastructure notifies when PHY-less modules are
> connected, we can create a phy_port to represent it. Instead of letting
> the SFP subsystem handle that, the Bus' upstream is in charge of
> maintaining that phy_port and register it to the topology, as the
> upstream (in this case a phy device) is directly interacting with the
> underlying net_device.
> 
> Add a phy_caps helper to get the achievable modes on this module based
> on what the phy_port representing the bus supports.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Sashiko NIPA says :

"
Can re-attaching a phy_device that owns an SFP cage with an inserted
PHY-less module to a different netdev corrupt the destination topology?
The mod_port is created during module_start and lives until module_stop,
so it survives phy_detach on the original netdev. On phy_detach, only
phy_link_topo_del_port() is called, but phydev->mod_port and
mod_port->id are left as-is
"

That's not possible, we can't detach a port and attach it to another netdev.
the port->id is kept accross topo remove/add to keep a consistent ID in
case we detach the port's parent at link-down.

Maxime

