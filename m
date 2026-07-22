Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E947D92E;
	Wed, 22 Jul 2026 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714352; cv=none; b=dYMWAuw51E1NBierkVisO50RpUYTvewGzgC+KQXE6vUSKj+VnRE6duSVrrsS+ITpbEd0mWpGDSVAmMUV4ZalCXACKT6FSbqXnqGMsnWY/Q3Nkpjyf9XOScDwn4POq001LpymlvJeAtOQuRYcCsXhJX/Go+vq9GiGUtUwKgtAeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714352; c=relaxed/simple;
	bh=gaqhkp8jYarc+paOabRRjjajXIwxOOCwXbPyJ2ST4kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ylmlw7jPEXnpY4/Acm9kuPFuDjXF3FsIBrIMzC9+sJGhT8jxvYQ48kd7FyIKDIDbkTSQ7EdkbA7QELBjSC0ggER/Y0yCEjtMilWY9sLEG1oFSPH8fa06AyB7WfTkx1C8Eq2C2VGETqnkX8tUXklvJ8ixaBQ5JpRivQ3kxkTvpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nd3cfduj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nd3cfduj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8282A1A1168;
	Wed, 22 Jul 2026 09:59:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 545C160388;
	Wed, 22 Jul 2026 09:59:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBD1F11BD0424;
	Wed, 22 Jul 2026 11:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784714347; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=f5OHHR0Ksqa+TPukxW7dIMcZjcY8rnMl54Evsi8oxA0=;
	b=Nd3cfdujaR8XpNMBiNgZ3SHHfrlDKlU1lH7HW1mgQMexH1/EnbrVWqpKRgtJiZVaDk6FLI
	Y+vt+0z9ckEu/qt3MDt3H57bkS9BKiMbWUInZsoJST7sxqSF6ignkO+HjuUVEnstYwLVq0
	WK2FeMHvCo20snjmy1o9e5Z8wX/Da0FvU/7GTigMGdOc4Sg8+ONEl7sgntb33Hy/FOtwxY
	+LxymXoJLGP2XvRiSJnT3T70ht9x5uCuP3oJDlpvUlAEG+/Dje4Fze39NaUnAZbDMfNLmQ
	gSbQLBX+CQCjq+0LFOWjkVhUH+jo5ITYEXQjIX0bUlvC40W1+v3yEPFrbfMphA==
Message-ID: <97369137-f060-421c-8a80-f8067f076bd0@bootlin.com>
Date: Wed, 22 Jul 2026 11:59:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 06/10] net: phy: phy_port: Store information
 about a port's upstream
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
 <20260720174808.139573-7-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260720174808.139573-7-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/20/26 19:48, Maxime Chevallier wrote:
> MII phy_ports are not meant to be connected directly to a link partner.
> They are meant to feed into some media converter devices that will
> expose an MDI phy_port, so far we only support SFP modules for that.
> 
> In the case an MDI phy_port is backed by an MII port (e.g. a SFP
> module's port, backed by the SFP cage port), let's keep track of the
> port id of the MII port backing it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Sashiko notices that we may race between phy_attach() and
phy_set_upstream_port() in the SFP case, that's indeed a possibility I'll
address.

Maxime

