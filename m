Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816473;
	b=DxWkdiuLDReDZ+/QsMXH+MeLtDAsinCGFT6jVPc/he5rEyZNb/o6dTegJhDvlUUnjUz7
	 mMJK7GbQXYlU7Yd5GnxoUjiq16dqe8fiR+Ku2iw/YXrvsyBvWxTCGyCmOWX7CUsPgVpLO
	 jzWiHoT4JrZHNM4Svd0lSqXb5v3ERrzpTN21TpbTg1WWXU7/ySr8ViepiYKQ2s0biQhB1
	 DlFe+VvDKqapG7ROPvza+Epjkh+aQv7qL7vkDtz33oNLbTKdTz+2D9DeT2bIn7acHhWoV
	 AX6pU4j3pPoyJaLSPcw34n2E13RfsVIpKahEBPS4vqwoooh80bPufDoNa9kpupThcKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cFj2Vg73sWN64Aw19X/jflqAwIWYnVVn9Sm4ZEKSS6U=;
	b=DHf/hCdkDRz7yAr2Ft1dhF0hGaiIYDW6GP+OsaymdeZgYlUcbVMtnT2gWg4c0oggacxX
	 dXb9WU1AfYcj7RFv+Kla/4UcPI+i0LDP0XTPp6CDETIgJJR4kXpmGXWibnXx73+ghlkro
	 5s9NPGokJ3nByBtCP04mFHaXa3pRA7ZmV/HC/T46UizpEmRzqnH/N7WYQn662/1NJpzaA
	 1vY+oU1qdqH39my4YHak7WWLXFctbKRaXn3Qn9HJV4NwUedTY7HK5/uS+IH5atk+NmVzw
	 A8TFmQ46j1e5/lKm4MaEkB0f8ZtrtBkA3w93W15ketufsuCERsUOYv0F/1am7Ek192Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evK3EuzW;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B4606D83E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 285B4606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evK3EuzW
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e47347279so630032f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816471; x=1794421271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFj2Vg73sWN64Aw19X/jflqAwIWYnVVn9Sm4ZEKSS6U=;
        b=evK3EuzWrZco9A3pe+vzfj7Nnh5aKYLSVJSb6SVHGnDJqWvHFZUSvI/sN11GN7hWCq
         whUHw70sm2cNf1MyAnBJ7+rN7Wntz6rHthAXkKroJZ4KWYV4cWNW6mkN123FFox4WjDj
         o6UdUpa2z+Qiii5IJJebalnJjh7BUuOHtLzvz22dY6zXfvP+yLkaCW1BuKKHkomkjVY7
         LS+GIljoPQnDnw6puczRo1iULWB1IMW2336IZqDKV0UwmodqBkcJ4UhhZ0k7NH8xwtJF
         ag/OugW8XD1yeDdRKcWEqqt7i5d/DoLKLR2tbqwIu6n+pupugkIAdt6GkuVuUbLVOQsJ
         LQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816471; x=1794421271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFj2Vg73sWN64Aw19X/jflqAwIWYnVVn9Sm4ZEKSS6U=;
        b=VukgnA7vdx4mqwJ7gWgYpravn+aN/tT0HaaRdUAAU9Da2mfo4ui2Vyxx2s0Rw1adBQ
         k3ccbT0Eez3s+KPSBIdI0VCZmosRmWJ5MEqKv2KYjCteilfrvV0TQ2OqCl79gWePVzL8
         0w7IthllqetKnBCaQBpJt8JFoJq56WE5Bc8E8mr5R2J3qGl6+HJoOlOoK4pCEuanpQig
         yptygdp7nXJgDsYQ5peu2E0mnJoDrVSTIH0GoKH70Ac0pFCYFyG+Vg6xguDG0zQ2bkM5
         ABKKua6HrMdX50wS28nWlug9A2H+cgpFm50OvedBZgP0sOeeelwbmlPzZjuqdnQMV1BX
         9/nQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsGx1MgVnpr5k13NAuTA+Hz3VSSKO3d84D5Ry7KOujTs2skdpQAK8ojO9yf87GilxIQY5uUgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+svBQV2gbRZHzXXJe071jxBPjSf+AmIJRJ5hZFu2stlIFnMkCn
	NBZKyxU0MSbl1NjBxOZI5C4+OaNsvScLoO0JeVJ64BAqDWbJ9EZZ7NkV
X-Gm-Gg: AYBFou1tJ0jpt+7FK6QOKO+bU7ngJlHMoh7V/3eNDrqG18DfcJQcFbBtHYyxqUwDXaZ
	x+hGviPpq8Xe3twesCytq0Qq6HFJwNmYlXFwCpyuFLjDXac3eE0LQkJMUWvF5L+GPssxj7b8o3+
	0kT+As2eYQMKnkYNZBkMINxfjdWPLWG8KWQhYDg64+D6mHVss6/ukfJ+WumcxOCNH5Akr2ZkTz6
	DTIizmhlfdh+zIC7izdF4EC5uDYhNAAa2AZOQ9dIAfSb/36LUY4fiqNIGpsflExICkTLONeesBb
	5zUy7RdRK6IuNCRzdn8zjieIFOI2ul6R7KGBnwY6yi1n+pFJk9Mi6ASoCAlpFBREGsYNvRwyJPQ
	Jsza0V8iUHVthKVWvppeDlfYTJGRt1Hx2bE8c2JhiJy4VFJtdfkq8sdfxWDP1oX9LwNs38oSGJm
	QW0QsvLvn40ms+kLrXmaR8Eql+7Y8RFoomXXpObOwEFdPCDSBd9Xvmci4eURbpy8pnffFa+lteO
	hc0ltbXRdIPyrbuSxqkAAOAiCtIhdbi2w+but6F2tzFOfPiwcDVz+Fa0S0z7SZVWrglHYs2LwKV
	2XPnyasSfX6R49x9YPfoNURjzXQBVxqyfgVu298xp/YE/AHnvI7AfwHKHjb+cNfLoaZ3x+L7tfx
	HLKebKBbsOIoSZDPasqaoedqiloOJTg85WCqqVw==
X-Received: by 2002:a05:6000:2404:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-48e6e2c1e2amr36364110f8f.8.1793816471273;
        Wed, 04 Nov 2026 10:21:11 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:10 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
Subject: [PATCH net-next v4 00/14] Add ETHSW support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Wed,  4 Nov 2026 18:20:48 +0000
Message-ID: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

The RZ/T2H and RZ/N2H SoCs integrate an Ethernet switch derived from the
RZ/N1 A5PSW, but with a different port topology, additional clock and
reset resources, and different tag control-data semantics.

This series extends the existing A5PSW DSA driver to support the ETHSW
variant while preserving RZ/N1 behavior. It adds a distinct DSA tag
protocol for ETHSW, selects switch topology and tag protocol through
SoC match data, handles the ETHSW clock and reset resources, and applies
a management-port frame-length workaround for an ETHSW hardware issue.
The binding and Kconfig entries are updated to describe and enable the
new variants.

v3->v4:
- Added new patch to DT binding to restrict to use only ethernet ports
- Added restriction to validate the reg property in ethernet ports
- Restricted the reg property for ethernet-ports to maximum 3 for RZ/T2H
- Added RB tag from Rob for the DT binding changes
- Added return value check for of_device_get_match_data()

v2->v3:
- Added new patch to restrict ports beyond port@4
- Added a restriction to disallow port@4 on T2H SoC
- Updated commit message for patch #5
- Fixed typo in commit message: swicth -> switch
- Marked of_data as const pointer to avoid build warning

v1->v2:
- Added RB tag
- Fixed review comments from Vladimir.
- Added info about the IP issue and the workaround

v3: https://lore.kernel.org/all/20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v2: https://lore.kernel.org/all/20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://lore.kernel.org/all/20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (14):
  net: dsa: tag_rzn1_a5psw: Drop redundant ETH_P_DSA_A5PSW definition
  net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW tag protocol support
  net: dsa: Kconfig: Expand config description to cover RZ/T2H and
    RZ/N2H ETHSW
  dt-bindings: net: dsa: renesas,rzn1-a5psw: Reject the "ports" node
  dt-bindings: net: dsa: renesas,rzn1-a5psw: Disallow ports beyond
    port@4
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

 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  | 175 +++++++++++++++---
 drivers/net/dsa/Kconfig                       |   9 +-
 drivers/net/dsa/rzn1_a5psw.c                  |  83 +++++++--
 drivers/net/dsa/rzn1_a5psw.h                  |  25 ++-
 include/net/dsa.h                             |   2 +
 include/uapi/linux/if_ether.h                 |   2 +-
 net/dsa/Kconfig                               |   9 +-
 net/dsa/tag_rzn1_a5psw.c                      |  22 ++-
 8 files changed, 275 insertions(+), 52 deletions(-)

-- 
2.56.0

