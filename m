Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10851CF79
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869416; cv=none; b=Ru71hP/wB4tYGaI1XTgP/lo6Ty831utStMDJJJHkFCv8PDs5pBN//ukOV64fotTHGduaxL92BxB8rSEgsc5WPExCluG/fNaBo+2HDOrf7SJ6pmCsTgVV7XL80qZ5SmwcQSTusC7RmEK5O/L6n/htgsGtmCnLrBFPT9Xdgk3bQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869416; c=relaxed/simple;
	bh=j9l1v7SIh1agy+d/CcExB7uuosTnCNp7Ova34dlK+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWXyES+8fkAuC2FcoEmkupZKZs+TqKuuw0u6+LUxAJbLl1dzbsHxc4HvMACqKhmeJkv0RC/BAYGGrSuEX4v3EnrH3l0XldfDLnRykNUKz49rSfdpFGFFdruIEyYS03tSsu+Ikri0KyEvpn+9CSvLNG8lPnBM+gjqCpVbg/DEMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uegk7I5v; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uegk7I5v"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso68880915e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869413; x=1791474213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mIaBbe8F5fUbSrAQQEV7tPEg3S5HZdRq+Ky+H8+JXg=;
        b=Uegk7I5v9aNjou9OucGzKvmOgXm6sAKL6XsmgKtblas5GOouOmWH3WeXtZ77Dts60V
         SzblQ1hmd3OsZW9FgTQvM5LY9/RFNMk1PuUZ0+dh9WPldiSlWAEzb8ZQfSBSRn+Dh/+A
         hzBkh/XC8ERT55GZzzkU6jjXFaLEzDLtm5ugY+pb1hufReKJDLkPbjR9Z5FCkHiERd/H
         v8vPWjf4ze7p02VUZrIpN91Z5igBhLnlVxZvWZ5MO52ZPH3LURdQ8lVWpCDG7o3MQbPw
         KSwu7Z0C5ueayQubxBT0g2F6TFzmSCCHeBNqXU8ChWr8tp85hQu3Puh1prNAMwL8IKeF
         AH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869413; x=1791474213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mIaBbe8F5fUbSrAQQEV7tPEg3S5HZdRq+Ky+H8+JXg=;
        b=jebCQSggpJ7vk6ZJ9YRPOvoc2UyOOvv5gyL/2/OSPS0KZyo0ocTWpB/QzqSMREVsuC
         vkjB9HRH+mGx1A/Sx7OndU6iRI+62756k2ss5+jCfQOTIZxCPUCNLNX/9fqM8zwaPodj
         IACzo6tdBJdwlLXk+KUdXDC4F91Xk5TuXfZSjpk77uqkOwXehr3n+HRHxL0Q4sBjJtZn
         9VdI/ozUfDqn0NUJogv26ooSFC2cvUaox4Rb8MrfnYKT4OiVa/4jyTCVhnPRoDJCmh3d
         8SBv6QmRFqlcbiN5e2Nt/yxcrTxuZbiJsEfBxUP1XZKv12+PAQxskD1Fm71S+5QW5Eef
         P+xg==
X-Forwarded-Encrypted: i=1; AKwUvByOBVBpbwobG1uxcVc3TxI7Frv2OzHOgxu1apHlUGLLhtPOK4cPR6FiV4G8dKxsGQsrkt7D1ek=@vger.kernel.org
X-Gm-Message-State: AFuF++kWQerCGaWQXdzZg4UIPodiSyC1tyKqtu5NAEcyu0Gi3rFar17+
	4jveFLk6KaBmLsno+gXxtR4DWbyB+t1mSvCvvulT/Wpk6SxkU7cvJYTB
X-Gm-Gg: AYBFou0glZnKy/yW7KV6D32g83991q356Me3ePqhyHF6hVKE7y5mY8AwWh2I2Or5EKy
	BOKpjsTGRlx7UMrkdZMtCy5Im9anu6Q+avsceK5MRjGlcFm73rVAWH14X7rjpu0kNDn03K7SWNf
	tj/iEpicQKzaDOIBt+25mzI0Vo6iZ828eQNibTYg6CyDMD7QgpcHI6vqz6fUphbSlQJ+Jfb4NjJ
	XkHhymM3kIa4T3whsnsW7yCgimLiW6cWS+pBCQ6pl8cXbAG27VKtGZyMsZvBnRK752QNxQcx5TR
	yIuHDej+EAt7CR7HH8IULM7EkHS2oM7esshZuppmZCP7eDNdjR+42HmwSnHghHV+f62KTF1W+4h
	jbthcK6wWanGNbrXFYl8nNkGaFqi1yTJsbu3kf3xbMGMeFa2/NVIqUBJErbMsgtBs/nGE9/NaPU
	sqyjY3ymSVmcDv28too/uFvHyL6iVjrWmEWrbjSv+RoZpK2NDPssKb5plSANxFde8XyTfJoJeq/
	6CTjiuYrCbNLZ8MiDB+TaCQpQshwkbJjlRAeTG2C4zMvLy5a05Ir8zo6B+JUQjmFUdtIZ8wFrMw
	npSqD+4D
X-Received: by 2002:a05:600c:4e4e:b0:4a0:62d:4424 with SMTP id 5b1f17b1804b1-4a027566f93mr163105e9.8.1790869413262;
        Thu, 01 Oct 2026 08:43:33 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 00/12] Add ETHSW support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Thu,  1 Oct 2026 16:43:13 +0100
Message-ID: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series of patches adds support for the Renesas RZ/T2H and RZ/N2H SoCs
which integrate an Ethernet switch IP variant called ETHSW. The ETHSW is
largely compatible with the A5PSW switch found on RZ/N1 SoCs, but has
several key differences in register layout and hardware configuration. The
series includes updates to the DSA driver, device tree bindings, and
Kconfig to enable support for these SoCs.

v1->v2:
- Added RB tag
- Fixed review comments from Vladimir.
- Added info about the IP issue and the workaround

v1: https://lore.kernel.org/all/20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (12):
  net: dsa: tag_rzn1_a5psw: Drop redundant ETH_P_DSA_A5PSW definition
  net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW tag protocol support
  net: dsa: Kconfig: Expand config description to cover RZ/T2H and
    RZ/N2H ETHSW
  dt-bindings: net: dsa: renesas,rzn1-a5psw: Add RZ/T2H and RZ/N2H ETHSW
    support
  net: dsa: rzn1-a5psw: Add support for optional reset control
  net: dsa: rzn1-a5psw: Add support for optional timestamp clock
  net: dsa: rzn1-a5psw: Make use dev_err_probe()
  net: dsa: rzn1-a5psw: Get switch info via OF data
  net: dsa: rzn1-a5psw: Choose tagging protocol based on compatible
    string
  net: dsa: rzn1-a5psw: Add fixed frame length workaround for management
    port
  net: dsa: rzn1-a5psw: Add support for RZ/T2H Ethernet switch
  net: dsa: Kconfig: Enable support for RZ/T2H and RZ/N2H SoCs

 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  | 154 +++++++++++++++---
 drivers/net/dsa/Kconfig                       |   9 +-
 drivers/net/dsa/rzn1_a5psw.c                  |  79 +++++++--
 drivers/net/dsa/rzn1_a5psw.h                  |  25 ++-
 include/net/dsa.h                             |   2 +
 include/uapi/linux/if_ether.h                 |   2 +-
 net/dsa/Kconfig                               |   9 +-
 net/dsa/tag_rzn1_a5psw.c                      |  22 ++-
 8 files changed, 250 insertions(+), 52 deletions(-)

-- 
2.55.0

