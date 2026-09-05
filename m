Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F7329E6C;
	Sat,  5 Sep 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640255; cv=none; b=fYCUrsZt2Bg0UupY1Fpe8oI1VA/UER7eqp5CpYPB2URRbimg/vGqvGo5wkYlatI1DQndpSaadegkL/mAoUbEyD4jSkeL5skboyeLFFBFB2oDxik2hC5NMJDMaYkMSR1wdZ7azbb2ZTreQj8QBRALfR0KAjWX3vzqnyyyneaG2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640255; c=relaxed/simple;
	bh=SXM8apCtbNkDIlpr+VZLnf7ArlfsYH3/PyE1qLajdtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj03Vye/7OTijxx7Y3eiBOKVbiY+Y96s2CJDXhEnE8eEF+9EtTQVFJkRj3vd5jD4FlzRzsohcF0pGx5Ernn/RezPeY852qq+kLCP/zibgWgezh/kuDSc6gYuiyacz4wp5HRqLFyRreH3vS+Tq3XUTUiL+0LOwneCTMdRFHAyyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/gsuIAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/gsuIAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C70E1F00A3A;
	Sat,  5 Sep 2026 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640254;
	bh=+eZf2V+wa2JVdic47rPz1ATyb5pBikOwrUj1c8azbOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A/gsuIAI/ov4tfVASWwmk9bCLiMY47DsCHchmIffs3ZAWX3qS+r5iK5bP63OGFSel
	 RMo/kc72iwzAm3IVgpK1t9tMsB8uw+Ryllzk3/pt9ULaNA2fa+QtjKGSx1p4nvOoUE
	 zBxl5coDUKFC02hEKah4LAkhSikgclcbuChQd4f/LlncShMrU/638VE89F0fCIIZzh
	 m8REdYrxNe9LK/EUrrIVWOuQTzbAwCYwaV7xuy3NNTuXnvFoXc4kRPW9N5Kj9MTjri
	 NJcmAdYm7+Q+XeoiGIg3JalJcRr+lVqN7lXBic3kPEwLuV2aKhefBG5vhWMUS5ICYW
	 2BR68/DwLRwFw==
Date: Sat, 5 Sep 2026 13:30:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau
 <dimitri.fedrau@liebherr.com>, Frank Wunderlich
 <frank.wunderlich@linux.dev>, Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH net-next v16 00/10] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260905133052.62d1b224@kernel.org>
In-Reply-To: <20260902212135.1805948-1-maxime.chevallier@bootlin.com>
References: <20260902212135.1805948-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  2 Sep 2026 23:21:24 +0200 Maxime Chevallier wrote:
> Here's V16 for the phy_port improved SFP support and netlink interface.

ynl says =F0=9F=99=81=EF=B8=8F This needs to be squashed into the patches:

diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/=
linux/ethtool_netlink_generated.h
index f9d8794eabc1..660e0c08a766 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -78,6 +78,9 @@ enum ethtool_pse_event {
        ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR =3D 64,
 };
=20
+/*
+ * type of physical connector
+ */
 enum ethtool_port_type {
        ETHTOOL_PORT_TYPE_MDI,
        ETHTOOL_PORT_TYPE_SFP,
