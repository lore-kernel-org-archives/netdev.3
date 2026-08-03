Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A13AEF36;
	Mon,  3 Aug 2026 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791075; cv=none; b=CrJ9xV1nDaBkTqHmUAuOYvsMu7jH0pTXsMTFoZYvMTsclRBNb83zMlEa2IZq83Z6eNUy5u7tEUSDqOp1IDCuC5I1A045Njn6B+PMxlZp0bbeLxe2bjMPIEEto85TZZeBbwYhyEn5jhM+tN7tAl9xhaAAgVXTPBchwfXPRJ6E2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791075; c=relaxed/simple;
	bh=yRO4nZt4SwsVLtNZXLNpX4GUr6kzDe3pLYCzbCCTif4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezcRfy9YS/8AhqmpKsEPRZ/1jcOrtbr//bQwp6pL7StvFYXO6/kKhsQ6mg/MMTkrHtogP7rSY4w/eOIzbMNkMVuZ72wKAcOIDuGi+lRqCre2KDWAlJC8GBOcPTjZ8owDO/isE5zuLVTN08Cm1cf5Guxm0u9g/MvpVFEtMWWQ7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoI0VTMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoI0VTMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57601F000E9;
	Mon,  3 Aug 2026 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785791074;
	bh=UQhLnz3mpy2qBFnjzVK2ULjIqXUz+jTiv2KwzypMi3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NoI0VTMiFLoEJ+Kvir6VJbuBgJbOExEDKh9pnw2/hx0utlClM0kMjqx0n/SfyNkL+
	 HkwQ07aLPfXanmD+WMvUMucfxqkhvNSrd3e46/9M2NgYRD8eL9KOC2+/mioW9+kpx8
	 meu3GmpM2RyYg5G3UVW2yB2UXXA5pxNoeTVEIwOYPUoD5ioq7AexqulwU0McMjQqUA
	 DVD0iQQfp36342AW9VDIwzqGuh+LzqqITYsDKDEM6b9TqyU1hbXhm4ojXyWByCX4C/
	 NLI+A55XnwAsUVHymfI+SmPSHIOe67JMoSZrZjSJBdsHClL8GbLd/9/J3BCCndId+Z
	 FtcxKjDZSwcug==
Date: Mon, 3 Aug 2026 14:04:31 -0700
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
Subject: Re: [PATCH net-next v15 00/10] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260803140431.2bbe2949@kernel.org>
In-Reply-To: <20260801074332.98755-1-maxime.chevallier@bootlin.com>
References: <20260801074332.98755-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Aug 2026 09:43:21 +0200 Maxime Chevallier wrote:
> Here's V15 for the phy_port improved SFP support and netlink interface.

Breaks YNL build:

  In file included from ethtool-user.c:10:
  ethtool-user.h:8523:42: error: field 'obj' has incomplete type
   8523 |         struct ethtool_port_get_rsp_dump obj __attribute__((aligned(8)));
        |                                          ^~~
  ethtool-user.c: In function 'ethtool_port_get_dump':
  ethtool-user.c:8833:18: error: 'ethtool_port_get_rsp_dump_parse' undeclared
        (first use in this function); did you mean 'ethtool_port_get_rsp_parse'?
  ethtool-user.c:8847:19: error: returning 'void *' from a function with return
        type 'int' makes integer from pointer without a cast
  ethtool-user.c:8851:16: error: returning 'void *' from a function with return
        type 'int' makes integer from pointer without a cast
  make[1]: *** [Makefile:52: ethtool-user.o] Error 1
  make: *** [Makefile:57: ../generated/protos.a] Error 2

You need to specify the reply for dump, I didn't check if it matches do
but if it does:

--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2896,12 +2896,12 @@ c-version-name: ethtool-genl-version
 
       attribute-set: port
 
-      do: &port-get-op
+      do:
         request:
           attributes:
             - header
             - id
-        reply:
+        reply: &port-get-op-reply
           attributes:
             - header
             - id
@@ -2913,6 +2913,7 @@ c-version-name: ethtool-genl-version
         request:
           attributes:
             - header
+        reply: *port-get-op-reply
 
 mcast-groups:
   list:
