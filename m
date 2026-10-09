Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209D3AEF50
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565124; cv=none; b=M/tJPPmZgpQ7vXBUa/J3mYKxaqdj83v+BCFhBybyfR+l0/6PNQTl2CVs5kc124LleLCmowwLZRxj9j6xP1ZEpfFfkcnj17Pum9wsGk76FeexBtXC8yA71Sv3lfOeZfc2wA2xO1loKUYwd9n4OfqoWqgT//fbFkC3G3yakpGHPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565124; c=relaxed/simple;
	bh=buZ6qltwC1ejIwyTNn15zGgc6lh0GpPbL07r50E9di0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/q3dIbRRetmKJD2ZtZR41hfGiEBM3OylNkGVzK4qeys2oER+oKoLXRfz7w6wcgKjrMmJDs9AUfd44Sqoi7oRJ5P+h0TSBcp2eG1rVgI7WbU4RENKwjv5rDT/Vd7pBR6iYS8QQuyFMoRPVNPpiPehxF7T/tCwkKeRc7DN+5WBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blm4zhXr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blm4zhXr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8875d220446so2385523b3a.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565122; x=1792169922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KlijA4wF7PV1etHWVzlP7RU50laOzEh5e/QgJFQcuts=;
        b=Blm4zhXrRLyFimufOtIiYyCx7EOUslxZgUWXDFI1Qx+xQRs2ICjfR0TuTphkbFJ9AI
         oXwHr7kMzzQ5sqbK6V6P5DBNHdxBasoZ61kwHUWtWPuqnwke6Ru+duelLiL59Udyb9xT
         8W7sMAHi/ZaDL2Rj6hDSf6/8X81ijn+3PBgygzUhzD/0NNba2BqKBjEzygSTv/NQe7ZF
         1Adum989tvGVwivkOLXNgaFWXRwWD3PVaGUXPwa5YUYg/dhoixNPDKnY5D/MwEVe44Oa
         Oj+n1O8MLeMKMzPT7wdLZI8EHqeI9bzFkAF2aut21/abOfktl/qQ6pf7H/rUw4vZxImE
         H0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565122; x=1792169922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlijA4wF7PV1etHWVzlP7RU50laOzEh5e/QgJFQcuts=;
        b=WlJND3j0gpWHVKtwvHT+2yotmQH4T9ahTxXTTAxsJYL9G6XP7MJ/YXACw9mXZC0gAx
         EXj8J7NBHcA4LwiUmIM0wWfzYhGbO0kPcTmc+9i3nhKXnOxda+pMjr8VB9YT60moxxw+
         VQ3xyb/LnX3GzEsFj4+G8Wa7x4uedrpCV49bc3qhfN30dG1WS2i8l42ISp1dwMRguI3x
         MCOcd61PV3i4NRVoD0zuKlstVlgnIDtzHWWGk2jieWs5MlxKx6h+pW1Ttf5m4VnD5yvI
         yols7RRCKZ71CgrhHhANmUl9PEMClFWluMWpTYst1qsvgRpq+uVv0pmZwjvKqlEFpkoF
         wcZg==
X-Gm-Message-State: AFq9FYLOxNfkGh0aAwf9w9PNy7pFq8qT41KHRMPw9wi1zIcK/7Z93rQg
	9IsVoGFRjc+UrMLuBnlTNjYOJNFS0L1dLJJphiGEeGRG5jWWqlZPx1hhpzirTrMD
X-Gm-Gg: AYBFou1HTnK+37ZQFy4ULon5hv1HYHrQnCONwfNkGm+mCgbT8fSfT87Rzl0CSamuutW
	Wnf59/tTASRp+hAsQiKlvXvhCUSc4HMR4jYQuqZEX+yHlEpePkhGkq6bWEgNiZ7Ele2hgPdwlXV
	Xj3AGrZFo7Ec2zcZtrI27zaTph61TojWqpdIvg+D00QrteePim/0wxZwGTqfslEDbDf5kkywxe6
	HWVt0t3n5w7AIB4tMG9Vpd46PvdMb0GBFgGQJzY2Uoh1mWSVS0mYCYEt0tGZ6jlPG/s06l41VXA
	h0fnXnb7LRv7zy5WESGFecrjz7sL8HTMe0sK4JUcGJPT5ZmucDC3ufV8iwKhyWHdNgcZJf1m933
	Z/o6BdQ0bAw//CLhPaDSH2t8MolfoD78f5m313xfjyFsoLEQMUiQ8hgRL0iKbAvSXrfqwbGruBd
	mvvWicVw1R8oiC+wIKx6CSWztZBeD6hp37mOS7wN3TqJd+INGVgNh/PppUhs26XyWUh0uodtCIE
	2rUg1Hp6ZIBO/MZX6cdZRAzVg==
X-Received: by 2002:a05:6a00:2e86:b0:874:705d:f65d with SMTP id d2e1a72fcca58-897c6e18d04mr2218928b3a.43.1791565122176;
        Fri, 09 Oct 2026 09:58:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c37de994sm1494437b3a.26.2026.10.09.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:58:40 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net: dsa: motorcomm: TC offload follow-ups
Date: Sat, 10 Oct 2026 00:58:18 +0800
Message-ID: <20261009165825.359259-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the traffic control work on the Motorcomm YT9215S
DSA driver: it reorganizes the offload code and then adds ACL enablement
on demand and flower priority mapping.

v3:
  - rebase
  - reword commit messages and comments
  - fix cleanup path in acl_add()
v2: https://lore.kernel.org/r/20261001204851.2576101-1-mmyangfl@gmail.com
  - move type casting helper into chip.h
  - remove flow statistics and broadcast/multicast policers
v1: https://lore.kernel.org/r/20260926211813.935723-1-mmyangfl@gmail.com

David Yang (4):
  net: dsa: motorcomm: Split TC module
  net: dsa: motorcomm: Use NSEC_PER_SEC
  net: dsa: motorcomm: Enable ACL on demand
  net: dsa: motorcomm: Add TC prio support

 drivers/net/dsa/motorcomm/Makefile |    1 +
 drivers/net/dsa/motorcomm/chip.c   | 1662 ++--------------------------
 drivers/net/dsa/motorcomm/chip.h   |  352 +-----
 drivers/net/dsa/motorcomm/tc.c     | 1583 ++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/tc.h     |  381 +++++++
 5 files changed, 2059 insertions(+), 1920 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/tc.c
 create mode 100644 drivers/net/dsa/motorcomm/tc.h

-- 
2.53.0

