Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C254F7CB0
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633213; cv=none; b=tdISv14tBMai0PXKeINpiOVLn90H5KSYWzj3eggOcLA18qfRTse6WHW5iHDMWO4IEZDTTZp+Uly986ybvyhUfEFMGrBbDiHnnGwFEk8ncIUvGVZnA76k3Hv/D383Ll/ZG6XOz7I9LYO9zczZBt+Z82eQRkTGyrZeSn0+4zegrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633213; c=relaxed/simple;
	bh=VA1PPp1FMJ21LCxz7xn35Wp1a4bo/XM5ylNH+VhiGv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkAJNuwtEFO7DcDFyybqXyYEOkeOdsF7Fi78XIWtrTP6R1zMCzqOD3EY/saD95dVb+62hhLDPcq/VOHJigS38/4k5smxI+H4PDkEnYh4x8lc5913XRASIwO66XL7g5C+5MJ1xEeGxVjLFXZC/Ms55qsmMBvHjb57EwWHLOvDDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNZXCDQ1; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNZXCDQ1"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbbf409b8so320472866b.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633209; x=1791238009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8y6eEk+phFinuim1+Sgx9zrq/h1dTfgS9jzVTEFSOX0=;
        b=sNZXCDQ1C3gzM7jYeFQMPuzJYTUvoqQ5CxMTlpRJiLrEXC7XbsB+4PQaf5HUl1A4ah
         YNwqdn4Wdilg3K9StoOGQzxRF4KLgQkN8bOaoTrwUfkxw9MhjzKCPgO1rMlArCFGeHK9
         7cBUnRgsNlcTw/fKKwgM91kRtF2qTwJreHFgprJDBASwQpuS7EDxJlHn2Msn0EPBmcSe
         nzAfpQy+t5X72IYzA5Yqwa/hBiYsqwAPp3ChDRcWNGip2G/cKb041bNGPPsZIQf2hYfD
         fSSsD6aVZxa+UmYPrlY1A8ufYisMKat0BWWJMAUP+d0ZRBVP/8WPJsVfJ/n8ZYlMvq6K
         6kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633209; x=1791238009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8y6eEk+phFinuim1+Sgx9zrq/h1dTfgS9jzVTEFSOX0=;
        b=jurmxetfKNTAb1RQZ8NV9z5lu47HfwnjdqrCu25RucqJ0/1oSHRVgFGq8Vl0KZ6049
         aqw2RLavtoJbQ9s9iRqNZo0eSuvAj6tsW4DQlo5bNiL0zZB35HWwxIlGt0+rNemFj7ld
         148i6E0RPhbqUjg/Ono2uA4OfARXxkxrpfobTJQDqwlQgqtaZffcCIf7suRqsfRJ//Px
         B+Gkkt5Jh2xWv4BZ8p08Hvs1+rddt1Sz223uEG8+biWnRtMutd+A/hOtG7FrZLjGWK7E
         ZftGNsawogu9nsVVCzdMF6CJtu30vDRp77m3xbcKBYHmeFTuzOBpVumD8WAAyLItIS4o
         fzLw==
X-Gm-Message-State: AFuF++mF52zqXWvu2rCCmi0oKl4FVkLiovLtJpH0eGURb+gp54gDOscG
	CAS5+eyKMFEtHTUtlWXSGqgZAm3ilXrLHZCBgHvtNKNB3w+ciJoKQyQubmmlfdvy8sDhuw==
X-Gm-Gg: AYBFou1CLz0WpqnI1JsaqNfmAp3sZsFWSRm6DYDkUMgt7Bu6U6JkhzXNeg6YLuqVc2t
	sKl8c3FvqdRnA+Qnq3HiyUFmXM7IMtR97S2i9HZDC9rGr0Gi4YWDWBFosZTnDe5+EjTwkaIvcs/
	zIO4fYtWeb6djJEQt7Koxmwsf30zm2pEEJXV69L1JWa7Pvo6duMUe8B0t6KF65poBPf46vYjLpx
	b2MuFhVemi4COuGi+XMtJ/YEy5uZsvH42O6rjyL0iN1m8m0A4cbpIpr2ztnSjywoC6mzHgO2ajQ
	ArVgIh5Wzrw3lVUlYldtRUGvPdU2l6LpMCcIVO2vEDx1B2l5d7XgS/h0dewjObmx8MYV8pFdcvV
	po529YBaXSGpgmrseIQsgIFYzKdbGsjgrnwIDjzogiU59bBTkxxLXS4yHVBaGOYzzshzO52WrFq
	uIU3WtHsTEEcM6J/PHTG3JCNo5bJGcW1qa5fg9SJlz7bGu65RiDkx9m4IFtb8JG8V+cR6LnaSnA
	V6FwcmL3A9fSupV+d9d6sL/84snlRQEZLN+5/8woWI0utGB5Mx1gE4i8g==
X-Received: by 2002:a17:906:6a0b:b0:c2d:c33d:a9db with SMTP id a640c23a62f3a-c2dc33dad2dmr569606766b.6.1790633209082;
        Mon, 28 Sep 2026 15:06:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b50fsm520177266b.32.2026.09.28.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:06:48 -0700 (PDT)
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
Subject: [PATCH net v2 0/3] net: dsa: qca8k: fix MDIO error handling
Date: Tue, 29 Sep 2026 00:06:26 +0200
Message-ID: <20260928220629.238-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix error handling in the qca8k internal MDIO master
paths.

Patch 1 propagates MDIO read and write errors instead of reporting
success or returning 0xffff. Apart from the trailers it is the v1
patch.

Patches 2 and 3 fix the two problems the Sashiko review found around
v1 [1]. Both predate v1:
- After a failed page select, the MASTER_EN cleanup write went to
  whichever page the switch still had selected, which can clear the
  upper half of an unrelated register. The page cache also kept the old
  page even though the failed write may have reached the switch.
- A management Ethernet busy wait that timed out with successful poll
  requests carried on to the data read, so a read could return data
  from an incomplete transaction and never fall back to the MDIO bus.

Testing: each patch builds with W=1 for arm64 (drivers/net/dsa/qca,
net/dsa, drivers/net/phy/qcom), and checkpatch --strict reports only
the missing sign-off and the Fixes: IDs that my shallow clone cannot
resolve. A userspace model compiles the driver's own MDIO functions
against a simulated paged switch and a scripted management Ethernet
responder, including phylib's read-modify-write helper as a consumer.
Each patch fixes its own cases; the base fails all of them.

A Redmi AX5400 (IPQ5018 + QCA8337) was tested with a 6.18 backport of
this series in OpenWrt. Connectivity was verified after boot, reboot,
cold boot, link re-initialization and MTU changes. That board has its
switch PHYs on the SoC MDIO bus and no CPU port 0, so it never uses the
internal MDIO master or management Ethernet. On hardware this only
shows that normal register access through the page select path still
works.

v2:
- Patch 1: removed the blank line between Fixes: and the other trailers;
  Cc John Crispin, author of the commit named in Fixes:.
- Patches 2 and 3 are new.

v1: https://lore.kernel.org/netdev/20260923215748.1336-1-yongzhao.derek@gmail.com/

[1] https://lore.kernel.org/netdev/179054715863.3145.10179961093285192493@kernel.org/

Yongzhao Chen (3):
  net: dsa: qca8k: propagate MDIO errors
  net: dsa: qca8k: do not clear MASTER_EN after a failed page select
  net: dsa: qca8k: fail mgmt Ethernet MDIO access on busy wait errors

 drivers/net/dsa/qca/qca8k-8xxx.c | 66 +++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 27 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.43.0
