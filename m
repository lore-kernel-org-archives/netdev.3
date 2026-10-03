Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA69381E96
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048265; cv=none; b=L9pzY4+680u7vitzn/B3Kan4xsNzig67KoPA7aX7GWaYEB+tA038X/Tqobi8m2qSLx+Q+68u1uDE0lU5xWeO1hOnGoMtqngKpttpAFFh+G4ZP8x+kr7hUbLxowNO2wlKa65wFFSTiX4FGvu9XyM2qZRBiXmrPdoxM4wk93gN864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048265; c=relaxed/simple;
	bh=s2Ss/x948Y93uzsFgTiimFn4QGTk+GR3g2Spav0zjfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQDa8ykhcG5GmtndmTb/CFejGI3QJefvKHPTCZTQ0TZqaBRWcgZovoRM/RtkCBy1aSXciEPDU8TGTYrWBMsc0lz53Dyx4jzA7rLrHHezYq/3wDbfq/wIff+vnj1Sp3l8dhRqhMB4mYVjWTJW5zNLsCwsW4EUMhfDofenj5GmOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE4+Hv85; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE4+Hv85"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e62319cfaso55972666b.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791048262; x=1791653062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5aEM4qdj9p9V8Y8pWjk1UcQVcLLXmG3YTCLxCb/8ly4=;
        b=IE4+Hv85flgTsL+AOLqNM6KSX18Mp9PfSJb3ZM532dOhAuOsmbw0g9Jwfqy5qa7jY2
         S8Cn8fuXqPe5hwaVp8oXgcofGo9vQBGoMUCTnta/ST+UjqHWBviWJ5Lc4EGuSMhrOy5L
         sxLrjrfz0OoX+AMs8eCpYD1MSSEoCazzAZtW7wqR4VpB8tj9rnAQMWUuTYNAeHK+Hb2V
         TL3zbHjwM7xCJE4EOn10LP+d4jxB7eyb4G+AkAYtZhHifuGodhSDpJHIMNmSK4jXwbyv
         BPPOCBpJOgcG1xaCOvt4Re7JIYMpvC/LO11p+zP5jCR0ClXNQi+6haTLQnk3LUicmvKm
         JLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791048262; x=1791653062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5aEM4qdj9p9V8Y8pWjk1UcQVcLLXmG3YTCLxCb/8ly4=;
        b=N//5yJKuGoqOvv4KD2VYarhU3/9e2hEUuUXxlyu5LYPgXszDNRwusA1LcttaI9JaPB
         KW1JXWH/Ilt+a9W88E6yEQXfA1Xi2ZO/QOvS51nFYAZy2/j4IdcYS6gcDtN0z6mTxwJr
         LzvdX9D5YpUTBGYpQOjg+R2lhGctJ3+/aFxr+SMNKPq0eh2mAhF+R2XLh+EIQ8BszZpo
         xTl4mf3TPqPKaMc5D0hJk48FN6i7kS5kkWxEWXHpXSY/MzNukSSTVNfBc8QRaEwYj05l
         LmPUS92pmpqMLfZ48jUv0c0sdje05gc6JDGrY4E40YRDZV9Blrg2EdLq36YI9B05O2Y4
         P4ig==
X-Gm-Message-State: AFq9FYLBO5R66flH1gigWd0ms4f6O/ilI3bkhvcm1I0eebgClpMGbJKm
	6L/3Wx1+mvanXbXB9Lp70eMkp+zAObUeGuqG4MoW5kQ61JNy1VMG26pqE94F61RjPrd9lw==
X-Gm-Gg: AYBFou3uksgrc6jiNQ+Ve+SwNZ1ZJcIQkRqcSFHlSxbuOm6MyjUHCNpK8ANI7ew18Lk
	GOPytbZplG5daFEBVsZPmWNBfHTRW9z/jgUTkAydmd4M2l3VN3GED6azhIf9InOnVvKwR6o3Dak
	yHFlZI9hEirUkho7TQDU59alwikCwUryF7rSwvoRbGkH5sf4Avz8HblLkTtoZp9GBy3dB2mzkn9
	mMJP3Ly1GYa9sJ4XF+03JXOXGddIK2NjzTyrAF9b/PJLVeYx7Sya2rzQ0POGTV6o2Zmmba1CBpz
	F6V1Ou9GcT7OMATcQzmXJYb0lrRZhsPD5AfoHFe4nEPu+Wx05RX0HtnlsjgOrpSQAyqRRYbMosu
	6SvdtwrhRt2niFd6wsg+YyRm10Mow8/6Jvv75RXcXQxBRFlOuhewhWt6w3fSvAhkXbq2FVvR6rg
	L+4ID9MlVhP6q2MJ3ZW6K2mimOHUuV4SsLPWFYZ+OHnfXa4QumlJsQUZMkyMXQu9u2s1n7ecp2Q
	9PfusnS26uOsR1QceackR7W8tomdomCFXj8Q2NOgY+V63tcI9XBo6pt
X-Received: by 2002:a17:907:97d3:b0:c29:45f6:6a0b with SMTP id a640c23a62f3a-c2e6edba366mr222307866b.34.1791048261810;
        Sat, 03 Oct 2026 10:24:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:7995:7ccd:ec2b:6712])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf87430sm211407666b.64.2026.10.03.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:24:21 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dsa: qca8k: fix MDIO error handling
Date: Sat,  3 Oct 2026 19:24:01 +0200
Message-ID: <20261003172405.342-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes qca8k MDIO error-handling bugs found by code
inspection and the Sashiko review of v1 [1]. I am not aware of reports
of actual MDIO failures, so v3 targets net-next without Fixes tags, as
Andrew requested [2].

The patches propagate register and PHY access errors, skip MASTER_EN
cleanup after a failed page select, invalidate the uncertain page cache,
and return management Ethernet busy-wait errors so MDIO fallback can run.
They apply directly to net-next; the separate qca8k MTU series depends on
the write-error propagation provided here.

Testing: the base and each patch build with W=1 for arm64
(drivers/net/dsa/qca, net/dsa, drivers/net/phy/qcom). A userspace model
compiles the driver's own MDIO functions against a simulated paged
switch and a scripted management Ethernet responder, with phylib's
read-modify-write helper as a consumer. Fault injection leaves 15 failing
cases on the base, 10 after patch 1, seven after patch 2, and none after
patch 3. These are model tests, not kernel selftests or hardware error
injection.

A Redmi AX5400 (RA74, IPQ5018 + QCA8337) passed connectivity checks
with a 6.18.52 OpenWrt backport of v2 after boot, reboot, one cold boot,
link re-initialization and MTU changes. Its switch PHYs are on the SoC
MDIO bus and it has no CPU port 0. This covers normal register access
through page selection; the internal MDIO master and management
Ethernet paths remain tested only in the model.

v3:
- Target net-next and drop the Fixes: tags as requested [2]. Historical
  commits are identified in the commit messages instead.
- Order local variable declarations in reverse Christmas tree order in
  the functions the series touches [3]. No other code change.

Previous versions:
v2 [4], v1 [5].

[1] https://lore.kernel.org/netdev/179054715863.3145.10179961093285192493@kernel.org/
[2] https://lore.kernel.org/netdev/12875133-1659-4507-a007-c3cfa425ec76@lunn.ch/
[3] https://lore.kernel.org/netdev/f7889e9e-8ca8-47b1-b902-c31e7c016858@lunn.ch/
[4] https://lore.kernel.org/netdev/20260928220629.238-1-yongzhao.derek@gmail.com/
[5] https://lore.kernel.org/netdev/20260923215748.1336-1-yongzhao.derek@gmail.com/

Yongzhao Chen (3):
  net: dsa: qca8k: propagate MDIO errors
  net: dsa: qca8k: do not clear MASTER_EN after a failed page select
  net: dsa: qca8k: fail mgmt Ethernet MDIO access on busy wait errors

 drivers/net/dsa/qca/qca8k-8xxx.c | 68 +++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 28 deletions(-)


base-commit: cfb7793d1bc0f7d90571611979654cf1b3886b29
-- 
2.43.0
