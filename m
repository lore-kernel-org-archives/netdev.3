Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79734D3A9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525991; cv=none; b=GM4c8+ysZyzHu3eUXC2+CVuX5ImzmX5KC7R14ZEGzwn/AUKfO9d41pq4DAo8D3tL2anlEUXVPE4eByyK6facObepVmGYqKAMqoD2Q66Rw+nhUCjPGyDgcb0Q8KT5z6hz/LKwzRPQm0Pp2FIYuD3pifaP5m5+/uOqM4SDj/uyWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525991; c=relaxed/simple;
	bh=HdMdiMCe3MKVqlaCIyB0c2RfvFNaLGy9nwclIDSQHRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sc07ifmmbcCCGzeukwS3fLcWIDSCttDQPUisIlLrX9DabsJgyTTnDHCB9xKsGVEVqVixiBqGvojacLYU2dwUEBZRpbC+wuTbMpikY/ew3XwqjTCR9KnRRVowAFDEzKQ87tclWKlcY4j2xbL/8GIzGR7iEG4WP5wGl//+xPwHRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLJhTOz2; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLJhTOz2"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35115b52125so5037548eec.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791525989; x=1792130789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pb4Xp4D0s8TBdd/O2D9YrmHfrZaQPX0yAvwKrkVsb5Q=;
        b=jLJhTOz2h4odG2H3v/UViuNyPp0oQubMwQKAzLqER/g8krzcFx+MbI4HhhDbzbspJT
         REm81gvRV+a4KdZfqenjCITSZ3FCJ7JqGlYVwsP5jqssc3v5K2PiMRWpyYVB/SOReYXR
         YbIuc+QugoemaN52mmD5+Y+vqgTvicl/S1YnGYiFf4aCzN0bXDPQpUa9vFX4MoLRlM74
         g8QZ6vGml/eAEtQuOC6801SWcZnkEfcOqO/4UJtzHD9fYJRpQ3clQy2DbNaSWffafMwv
         KxEXyHe5WgGF5sq97/af5SkjnVDIR4UtgtTY7+S2XwFJ/WATqJoBOOPGuMgkEOSLYqAW
         9TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525989; x=1792130789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pb4Xp4D0s8TBdd/O2D9YrmHfrZaQPX0yAvwKrkVsb5Q=;
        b=gsYNmtLmrO4yP9nsdEBR1PIGvoC6kjC+folWep5RhqZamWGmHdxTmwQYdIlAjh0Kic
         aScQUrAYFAJWHTKH1T1r6Ta7DCwlDaW2QcLT5rLg1Eoe3MhSIeKbWdXKTOofq/Y7VjcV
         t4JmaMC+x/zkDus6l2KJJasEF5hF4HJKuOD/gJhU0rZhABk2BxnaXBQ1lKmt91P8GDtp
         o555kAnGgO987ozYUxANsTxz8J/l16XoDrv9bTOPHbXwvG1DtSMu/ONPfWVfcHbsWCAb
         SZztrxG7JHB7nUkJDwZ93d6+bud0IH7miozBhmhne+l9sBa+IVxKlgVhGihwUIRz1HQn
         X2iQ==
X-Forwarded-Encrypted: i=1; AKwUvByKjp2IMrxlK4ho4cJ4c8sPLefbXOD1jW5Fe32biZhLpDoVWEqQn8gswU2MwK8gF8Qv5ytY+IM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaIwfU+sl1gr761/CN2O86G0+qBGBCqU5jHdTGR61pvG/QR6nu
	ACAXIjIzmIgXvFD0sORJrMQ8joLjU0/7U1G5oWLvgkiLg80EFNDqi9Ms
X-Gm-Gg: AYBFou0GgLjKcTX4pBJGwgW1iFVYCRgk6jpkjaZTP19FE7DPIznZtXctLSbDnaYEkCW
	FV5VIn+g4nwwZgBOwb0himgBNGU4rYDNnsuquPYxCry6JsRk7dXZ2iEEVF4KRS5JhbC6RaW1UvS
	Xd9OD200d2rYX8do0ErZ2OTraePU8CAro5Or0ihpXwOKqFfyC71+ytZ3Cp7eXWA3H/ut+xEUxOW
	BxOvWOOiDesR+W+3uxO5/OH2gh12weR/C2OI7texFhaapr+EJuo+WsUpeAaYQc7przmL8Cq3G4w
	KF8JOWIhb3G8OMzb1VXWZw8uDzP9I9+xoyIUbfuoiKxBsqTSJJSsb3mLXMa5NhYZvP+3M98UWXO
	KJksWK+VZKGLktXOt8zSBkGEeHH+o4zL4wrPZR8yZ4ZMpJ0x2qWbJTiKjRJtAbqAs2r7bCpw2Zt
	mH6y/n2OU3k5QYmac4Yd/X7Ip5xfjGYvwaaIoxj+hFb7HcjYrRT2UDV0XjQVd2UIGSo6PMlM8iP
	IARfjqKPcNwE7VLyzN73BHrvSrQLsW8dryrKVI3/JrmmvxSgd+rjtgxs7G+7jXC8/9ZDS1gXx81
	AeSzqB3i/Z8GoV+kQdLBY+Xf5mFS2qHbhpetPxCXqgg=
X-Received: by 2002:a05:7301:1522:b0:351:6b56:6627 with SMTP id 5a478bee46e88-3537e0f5b7bmr1520841eec.40.1791525988955;
        Thu, 08 Oct 2026 23:06:28 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a2afsm4185544eec.31.2026.10.08.23.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:06:28 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 0/3] gtp: ynl spec for the GTP netlink family, a reply-command fix, and a selftest
Date: Fri,  9 Oct 2026 06:06:12 +0000
Message-Id: <20261009060615.4177402-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This respins the RFC "netlink: specs: add genetlink-legacy spec for GTP"
(netdev, 2026-10-01) as a patch, and adds a driver fix the spec exposed
plus a selftest that uses it.

While writing a ynl-based selftest for the existing gtp family I found
that the GET and dump replies put the genl family id in the command
field instead of a GTP_CMD_* value. libgtpnl ignores the command so it
never mattered, but ynl rejects the reply as an unknown command and
drops it. Patch 1 fixes the driver; patches 2 and 3 then describe and
test the family.

Patch 1 sets a valid command (GTP_CMD_GETPDP) in the get and dump
replies.

Patch 2 adds a genetlink-legacy ynl spec for the gtp family
(NEWPDP/DELPDP/GETPDP/ECHOREQ). Description only, no uapi change.

Patch 3 adds a selftest built on the spec: it creates a gtp device, adds
a PDP context with newpdp, checks getpdp lists it and delpdp removes it.
It skips when the kernel or iproute2 lack GTP support.

Changes since v2:
 - selftest: add CONFIG_GTP to tools/testing/selftests/net/config
   (kept in sorted order).
 - selftest: move gtp.py to its correct alphabetical slot in the net
   Makefile (after the gre_* entries) and mark the script executable.
 - selftest: add docstrings to the three test functions and main();
   ruff check is clean under tools/testing/selftests/net/ruff.toml.
 - selftest: move GtpFamily before PSPFamily in lib/py (import and
   __all__).
 - Patches 1 and 2 are unchanged from v2.

v2: https://lore.kernel.org/netdev/20261008181031.4129029-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  gtp: set a valid genl command in PDP context get and dump replies
  netlink: specs: add genetlink-legacy spec for GTP
  selftests: net: add a test for the gtp netlink family

 Documentation/netlink/specs/gtp.yaml          | 170 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 drivers/net/gtp.c                             |   4 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/gtp.py            |  85 +++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   8 +-
 8 files changed, 271 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/gtp.yaml
 create mode 100755 tools/testing/selftests/net/gtp.py

-- 
2.25.1

