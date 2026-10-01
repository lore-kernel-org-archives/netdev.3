Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA337488D84
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887742; cv=none; b=UNAqqcwEtabIB5vV2KCXBmXiCHYnuz7YINaDZVEvPvYtpRtngE9AfcgNdzxCKMY7A3TLzZZAvCL8nGqFGog4RaqaORfxLoVZTiXqv8menj1fi3slOzwoekY3SffjoOLoDCNAWrmroRAybwifKjIpCRYxUC46LoMpTiydiLHqEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887742; c=relaxed/simple;
	bh=gK7i1R2R8y0ow3LubgXS6PxW5W+N8VcRjGkt+FYuZiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAllJmQShatR/A29ezTab6tYtCdeCNsuw0jW2+xUmWAoo7IqHbcaDESWqhRio/6vrkRWkLAyMcO0/CGbGL+GUj00wvUnplI+YQMkY3TAtBHYIf+nl/y2jNpsvChG8JP14G7xUCiSX9sQSNEqxbpBqHD0gmpXQZG97PUWAIUA0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/7AtjGO; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/7AtjGO"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso3004432a91.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887741; x=1791492541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GaNhy8Dh25vssvZWVoAJu0vGDz+eGpNkgK57kC+Sq5Y=;
        b=k/7AtjGOIkNljKPEF7HjAf1Z/w50E3Y6Zgwir5V5Rr46DeQEZx2UI70he94pwNd3GB
         6gW9SehNb05UHFKZFZtLQ6U7omPYs1jNwZjKmwk+FzEPdyvRP8JUTFCo8+wrPbOm5Igg
         l3u4m7TMqKaFZuCN10H1J1S9biqAODXPJM8EpGpb9EXiLVR4FS0NX5R5iZZOf7P9tKoT
         LDr1GUlAqZT7lhkPGllSqUEYuQBNLn96pxTY14EK2eCamMWJUZvr7hMY0Aejo+BEMnO1
         eWKRnrkSDVxwjdXVfjSFySaB55/kbo1kRdCa6CYr5x4x6IaZLyN/U6NoRXKaZXDu1i/R
         loxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887741; x=1791492541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GaNhy8Dh25vssvZWVoAJu0vGDz+eGpNkgK57kC+Sq5Y=;
        b=sBm4OStKaQ4twZOwnC0nYZtlZc1RKFykSkUa6K6oqXbnZcsQLLAG9N8RCalKl147Ly
         VU84o17rSM74hxJsj4WF74xaIKyexNP5DMfMlk/YKNeHSqMaAoHeONC85hPbTkReFc4I
         2qwzffVlocOmcZUMcHmSvIovKO8buyBy4RcCQ+Bv7HoYBKCPMETOfQlrGK5Mw44BCDN0
         t50mIQqBQyf79VPXQ9vSXMkVjkd+eFBUO28w8aK/E9DQRlrYjTpS3dg0PGLGUD8h3m7K
         7lPgNgTlm+KLvRH3GEM1Bkhv9DTtWHKGSBKEa/PX9Rac0GjXMavJaYRY0zboJItO+RhZ
         hsDg==
X-Gm-Message-State: AFq9FYLTZeAqtjgb6J1ppjyyPzPbTzfcVKpvAcPuJdtw+zIRBkFR6Zln
	djViVR7dxCeTloM8tnqIm2fZCXSjVvCRjV7v0cDjgxcSQJ2iyU7h7F1Yq43AOw4s
X-Gm-Gg: AYBFou2QK2F6GU40ibMT/nt8Gk/aLQSrU0/5QQiTGEGfHYa0Hlfnqv+LLqGOwzvU68R
	NaidrEkArQA3UWqDXQRrR++HobyGDcqF/3fWzGH0PriMpFf/DJFx0sZ5+5ggqa0Us2/gWAUYqwj
	7ALhSMe6LePmDqa3qZiAGgxOZ3Om/uglfINSSCf9FpVAToZjiR/uAiyIbu5lxJodwxpTbDEqVwL
	yMupf6/DDL8gWhlnr7lCLpouMWBTLASLS1Imy/tznJiQMTxBEc02UZJVHDB042uMhGyF6D17PAF
	pgdGHCT/LTUorp4UUeH76X877Z94tH5Z5zFfdIeO92kaYROEkniycHn0t7Fz+dV4GANqG6oJ6m+
	WbZpLdzZRx/pVK/PwHoKUohHn0UyNQsXeIqHYtjoovqIwE+OXsKGDCeaKx5k8HpPmelfOfRcMO0
	d5hjO/LNX39d/6y3535ClfbO435DaV9XOSSSt/kdRI4DyrrFouipV5WCvmuScF0dtV80mRf1wav
	he8Fzko0OLil8l6zhjr1p5WTw==
X-Received: by 2002:a17:90b:1b0a:b0:3a4:b911:e9f6 with SMTP id 98e67ed59e1d1-3a6ce95e913mr261740a91.56.1790887740754;
        Thu, 01 Oct 2026 13:49:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661e:3050::4d0:26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e9c6sm5658797a91.14.2026.10.01.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:49:00 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: dsa: motorcomm: TC offload follow-ups
Date: Fri,  2 Oct 2026 04:48:43 +0800
Message-ID: <20261001204851.2576101-1-mmyangfl@gmail.com>
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

v2:
  - move type casting helper into chip.h
  - remove flow statistics and broadcast/multicast policers
v1: https://lore.kernel.org/r/20260926211813.935723-1-mmyangfl@gmail.com

David Yang (5):
  net: dsa: motorcomm: Hoist type casting helper into chip.h
  net: dsa: motorcomm: Split TC module
  net: dsa: motorcomm: Use NSEC_PER_SEC
  net: dsa: motorcomm: Enable ACL on demand
  net: dsa: motorcomm: Add TC prio support

 drivers/net/dsa/motorcomm/Makefile   |    1 +
 drivers/net/dsa/motorcomm/chip.c     | 1568 +-------------------------
 drivers/net/dsa/motorcomm/chip.h     |  355 +-----
 drivers/net/dsa/motorcomm/leds.c     |    7 +-
 drivers/net/dsa/motorcomm/mdio_bus.c |   10 +-
 drivers/net/dsa/motorcomm/pcs-921x.c |    8 +-
 drivers/net/dsa/motorcomm/tc.c       | 1524 +++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/tc.h       |  379 +++++++
 8 files changed, 1982 insertions(+), 1870 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/tc.c
 create mode 100644 drivers/net/dsa/motorcomm/tc.h

-- 
2.53.0

