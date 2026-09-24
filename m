Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318B70830
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287284; cv=none; b=bPVIXQOtSLpxRl5COqp45++XGgu92xkMcdA6mnyZkWradS5MrInL8DoOYCui6CrA2BpBefS6jDjTSrxybDI0UyIbGGWGtNMX0esj3pje1g7Tq4mkfgQxpFes8Y3Y2X2eetVx/X1FCZQS0lRUk56B6+HvG9tFmWwrZExVItC1lA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287284; c=relaxed/simple;
	bh=fyRLcGAYOnSsmGc/YKxjM/QZdjFJiTsk5pPJHNThrIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgA/d97Kq5kndQjRV5XLI1QxyzKLOV2CCc+9JSk3BJctEYBxXzqX5iyCmrqJetBGDlVYwABgI6nhPnLye9hE4N0YL1y3tqgaj3HRaScaoeG6lT6uR9xBHLwSQU6x3v9WbvzOVxr6pxsQlRzh1/wR+hEnClpmA/fKDa1mbPCbJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=jIoTh8Z7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="jIoTh8Z7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48870973bddso119609f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287281; x=1790892081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/MXsr8udBMbCSEosD72Zya8yVpr92mX9EcNav60MGyE=;
        b=jIoTh8Z7BPxrrhDJD+33wq1qW3VA5H+TosRe4d3xkHbV4PR8q9VcTT24ckLnSrD5dB
         9Y+pZnLXZWyxj1fkMDb/QJ1XTyRQJ0YsINWIJCH7L/XVfgzBlSyPoEiu7OpnTY9Sdqii
         OZK/6zqc9lD3HMoxHok0WUA59wWGXq34/o52GwvOQnED3bpUKg0K1fwEjocXsA9Hq9Ia
         zBv8YKgnPmcBf3K8Uu8I70ttaZxV/icr3VjP2L3Gf4q9QFQTXZ/yLMG4dAD2bldYE2tq
         kd9g2gUj/gNVIRQJg6ILAyY1xQic3z7HObBFs45RSajEqBhX3lz826tCIaW726ZNfH5z
         Q+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287281; x=1790892081;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MXsr8udBMbCSEosD72Zya8yVpr92mX9EcNav60MGyE=;
        b=j7+obnrtiAhCFvGcvOQ0BnuLHWm7aLA4J/jTS3Nepl1C99xuXmFW9tafnygT8HW084
         o/n31VURpQ5q+8k29aaMyKE5lxbR3E+EhzRW5Iv1B08/Pm+Z4qgHa6wLE383tGs2RKIe
         KPUDKziP7swZCNIZURWdtd+tv7ZkfhsGtcJZ7JUuipZOhcEYb9kdgAytZEWc1uO0qFT0
         IK+D7NqErjMKTW1qzDHFPCF/aCgJPRuZKez+0N7qkDgE4lQFAUXknKLOisRPd8M6wMFc
         PVSvEcyjJbOcSnojDztTPb6Dx+R8/tulOZZNT6aM49Pc00TwH0unVyefwvlYKbpj0ZbK
         i9ag==
X-Forwarded-Encrypted: i=1; AKwUvBz8/dJXSub5zCB4peQOC78+mRTh8MoUSzl//jCimEx57onoagsFCcV5chHLQyDXtaIWJN54/5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mqQcM3ZK+MUQp2gs5GJl6RkF8hUkIytp4+hCaIpT9bQpyo+SL0
	ygoD6OVKfXHzc2wOIPr3pefU+Zuwqb7wwuVa3NxxFGjKMzQIhMwmHxRoSFlf8YDW2VlgA7zpzDo
	yICkOS7+YXA==
X-Gm-Gg: AYBFou3mvRz3uySicOeS3MxZ4Zop0KtAOkqG/w5r/h9Cpo0oHgPy7xUQLTczs9NratK
	DmJp3ufkYZlPwo0j6+5n9nkBS4unIvjKOMJ8BBL6730wRDs3iZpnweKT/UYS3rdt2Tyiwht+7pm
	GX6p5iv7afSgB+8dsPOj7sQk+qcLZzx47U8C2O5LXeaD8L77uSXc3hwPCXOvdXp3yZP6U9hwppY
	adnYMqzSZz78x4Y5/e4kYeTPohqQRaK5WXDYTuJlfNvL0w9fHAkeYoa0R8UBiyGmqatCeM5z2zh
	Pu8PS54HRfIlLZNCCRrxWhxIbpaTxT91F58P9wWE6DELDSsWR04s93ALJ8oWmpUFhcqfprrGnXx
	JQl+ECW74FouEDkLJkvQU4F9COkihN+xPP7GqcitK5EeyvCzzrtozbnpdNi/9eGMhq5hC6VZH2O
	7v3JepRMcOC1qDeXC9TURMwQ56F7XmssLAE2+FqQKNS6oPN6t3Kw==
X-Received: by 2002:a05:6000:2083:b0:487:1577:9e33 with SMTP id ffacd0b85a97d-488716f4c5bmr7148793f8f.25.1790287281255;
        Thu, 24 Sep 2026 15:01:21 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm2048758f8f.2.2026.09.24.15.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:01:20 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH RESEND net-next v17 00/10] net: phy_port: SFP modules
 representation and phy_port listing
Date: Fri, 25 Sep 2026 01:01:18 +0300
Message-ID: <20260924220118.2129522-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Maxime,=0D
=0D
I ran v17 on a Keenetic KN-1012 (MT7981B + MT7531). Switch port 5=0D
(lan4) goes either to an SFP cage or to an EN8811H copper PHY, and the=0D
bootloader picks one devicetree variant per boot. The series was=0D
backported to OpenWrt's 6.18 kernel together with the phy_port base and=0D
its fixes, with PROVE_LOCKING and DEBUG_ATOMIC_SLEEP enabled.=0D
=0D
Copper variant: lan4 lists one mdi port, id 1, with 100/1000/2500baseT,=0D
the same modes the PHY reports. The EN8811H attaches late, after the=0D
netdev is registered, because it waits for its firmware. The port still=0D
shows up, and traffic passes. The other user ports each list one mdi=0D
port.=0D
=0D
With a small netlink client I also checked the calls the ethtool CLI=0D
can't make. An unfiltered dump returns the five ports and then DONE.=0D
A dump filtered on a netdev without a topology returns nothing and a=0D
clean DONE. A DO with a valid PORT_ID returns the port. An unknown id=0D
gives ENODEV, id 0 gives ERANGE from the policy, and a request with no=0D
id gives EINVAL. lockdep stayed clean and debug_locks stayed 1.=0D
=0D
SFP variant, with the cage port and a module port:=0D
=0D
  Port for lan4:=0D
          Port id: 1=0D
          Supported MII interfaces : sgmii, 1000base-x, 2500base-x=0D
          Port type: sfp=0D
=0D
  Port for lan4:=0D
          Port id: 3=0D
          Upstream id: 1=0D
          Supported link modes:  2500baseX/Full=0D
                                 1000baseX/Full=0D
          Port type: mdi=0D
=0D
That is a passive DAC. A GPON ONU stick gives 1000baseX/Full, and=0D
phylink moves to 1000base-x. On every removal the module port goes away=0D
and the cage port stays. Every insert gets a new id, with no stale or=0D
duplicate entry. I tried a replug within one second, two fast=0D
out/in cycles, and swapping the DAC for the ONU with no pause. The=0D
double cycle didn't manage an insert while the previous probe was still=0D
running, since a hand can't beat the ~0.9s probe. lockdep stayed clean=0D
throughout.=0D
=0D
Over the DAC at 1000base-X to a UniFi UDR7 (whose SFP+ path goes=0D
through its CPU), iperf3 gives 926 Mbit/s board to UDR7 and 606 Mbit/s=0D
back, with no interface errors, no link drops and lockdep clean. I also pul=
led=0D
the DAC while a ping6 flood was running and plugged it back in: the=0D
module port went away, came back with a new id, and the link and=0D
traffic recovered.=0D
=0D
Not covered:=0D
- A module with its own PHY (06/10): neither of my modules probed one.=0D
- A dump that spans more than one skb: five ports fit in one.=0D
=0D
Three notes:=0D
=0D
The ethtool branch linked in the cover still reads PORT_VACANT and a u8=0D
port type, while v17 has UPSTREAM_PORT (u32) in that slot and a u32=0D
type. I adapted it locally. Could you push the ethtool you used for the=0D
cover letter?=0D
=0D
The raw supported-modes of a PHY's default port also carry the=0D
Autoneg, TP and MII bits, e.g. "... 1000baseT/Full Autoneg TP MII=0D
2500baseT/Full" on lan4. ethtool hides them, but MII on an mdi port=0D
looks odd to anyone reading the attribute directly. Is that intended?=0D
=0D
A module port follows the netdev's admin state rather than module=0D
presence. With lan4 down, a module sitting in the cage isn't listed,=0D
because sfp_module_stop() runs phylink_del_sfp_mod_port(). After ifup=0D
it comes back under a new id, so every ifdown/ifup renumbers it. Is=0D
that intended? From userspace, "port 3 upstream 1" isn't stable across=0D
an ifup.=0D
=0D
Tested-by: Aleksei Sviridkin <f@lex.la>=0D
=0D
Aleksei=0D
