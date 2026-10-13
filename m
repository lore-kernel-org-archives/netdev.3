Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574973DD86F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861010; cv=none; b=nE0j+DisSMzjWaguKew8Ryc8BO3ngbPq+K2MeRhHGiILvmvqkZW/qpadJWeaMgSKsQ0RByS5Q3j3hLeP4TFcRM380x25KqhLSBC1qh9GaXkQl/EXOGKWfYLzHRDHE2sAOw/ymj76q1NfrRxOiskkSCw9ypaxIpvb/VebFTrTFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861010; c=relaxed/simple;
	bh=YcESl/ADayFbyaJFP0o4E3Zs0nYkFpwyo9EyrGvtq0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YV0DXSjrQmAgyeuViDpq6vwq5Uhc3CQCwIp0Q50XcQcImw+TKES439ZHBo2VeyFiMpyZtKGNRwjF3DOQa0gARiaDsiRJy5vQOyOnuS82AKoo3MrKLHGZclG8ycbt8hNOVj7qH3AXIoAuhgtlbNZvrS8tz4og3yfLfUAcskBTHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0BEjlzs; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0BEjlzs"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so4681133eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791861008; x=1792465808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4qXadGqOSJuFTQlPSxL6FN1OZie+PxVsFb6Na9SuAw=;
        b=N0BEjlzsPSkaFzWiEP3nIveFFUR3eM54B7FIOfuP5Hu1xy4AuOD1hsDXNorvEdnQyu
         imH/Z72zdwJa0gTxEGB0a/4Y5THWB4TiVw1MSP90drmhfTL2yA/cXAslW1f+Whi83uZv
         9a6yHCn5PUA2q5X3/DzHWtJHPqQCECysjBM/quaV5zBSQPIrnl9BhROVBTzh+tggTSRl
         0rb8S4R5x3O8I4YON1PrI9wizl+V89KcYzaf6z5UwJOjRUO+sPOp27L5kFuudbQGOrwe
         bIH46OVowp76JJM3cfVSWvQIGuz0VqMeumpBrRxu9O/cm0PbMDb+GrZ9X5ui/w223jXd
         3OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791861008; x=1792465808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y4qXadGqOSJuFTQlPSxL6FN1OZie+PxVsFb6Na9SuAw=;
        b=BQPtfHOuOMIfuSrFo6VCslfBN567fCQpmr6PvqSjGCdCLixW12YVNfi4d9LqHSwYj7
         5/b/SRy1+N8ada7LP5gH6GJdbpDv7YP9N6++96y6zipKW+i9poGT+N3rqzZaQ1xzq9i2
         aNVMIRvbgraTpUh86yOWzO7dfvKVwcoU69aS9r9CjJsmofq5fbsS+PLAiS1DeQOCi0e0
         /NIm2yviPvDFEayD/N1cU1/4kSqHrssh6605FfWQfbDWHzVJxD7cKY9+9DjD7bUG2t15
         b7UuzTuo3gk+R8kttMoe7d41uLw3m6VE8U9uoiHbCqtJirW3DHo9TJqhC8uPnG+SUrTH
         qGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaJyhjzaUYntCzEfcIJQZasByc75SzpH6onvyRKvQIcmYq4wMkIamcJvaO0UDMh2FH+mv8QaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt6/8v/itJhjv1hjEHFrjl0nrT2o9qLzOK1WYDpqVX/ZgjtClt
	VnDx3Ce3IoiVj6WmSnOSqijZaFbw53s6+gkus77P5qY90JtFqm1Z7t0h
X-Gm-Gg: AYBFou3AqMjGjEczeeNIyV4/QuZgm5t9Y9WGPRAytmyv3dENhhm42GYZ16VovHSTrjN
	fz7CCqaPSSfVVpxdKhXXZfIXqsQLOrm4xKHwBYjzWyG5RZL7q0IGynce1Y0DdmsBbpmz+IptTqO
	I2EDVN1ALiC7fpYZPq+yIZo7buEY9hN5IUt+WaJEIm9fhXMm6/QAiFqCeiddqf15sYHNrsFSyoF
	djmSrlbbIq3HJSI9jpAdRKA2mEK/qynI36CeZupPpobYtF0TQzLkKXZbOJXI3E7ytECN3v/RBYk
	6uzjlZGi/7ZtR5Tjdm2Nlh0GGrTMXw80Dg4v8chk0IaiJpxuBxVdFdZv5MtS6wMPEIRSi4SPC6W
	XqOdS4H00V86XMijhxBMxsy2ZbqVOUF6ubatUEHaINI78V+mIugKvMvG2CLLZA4SvOLzfKe9bod
	Z/A4n8DwLgpkaVWPQtZSxsVTZ75PscymSaHlk9Yq78RXo0IEqbqE2ELoI1PfJfX1Y9fHRiu9jYM
	05ffAxiD2N3pUIU5oDGEOFd9zLOwQaJwnqLS2Q6J3toEEhHxZURVTMmW31bBmp1CFZPn5enypp0
	yMn/zRNFOWq47TWVj37bJk40LE7bfmShEW5c0lySRiI=
X-Received: by 2002:a05:693c:8943:10b0:35a:17ed:b31e with SMTP id 5a478bee46e88-35a17edb9dbmr7603628eec.8.1791861007893;
        Mon, 12 Oct 2026 20:10:07 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm41129053eec.27.2026.10.12.20.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:10:07 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v6 0/3] gtp: ynl spec for the GTP netlink family, a reply-command fix, and a selftest
Date: Tue, 13 Oct 2026 03:09:57 +0000
Message-Id: <20261013031000.528393-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a ynl spec for the gtp genetlink family, a small driver fix
it needed, and a selftest.

Patch 1: the GET and dump replies carried the family id in the command
field, so ynl dropped them. Use GTP_CMD_GETPDP instead.
Patch 2: the spec (NEWPDP/DELPDP/GETPDP/ECHOREQ), no uapi change.
Patch 3: a selftest that adds, dumps and deletes PDP contexts.

The multicast notifications are not in the spec: they reuse the request
command values, which the ynl C generator can't express with the
current uapi header.

v6:
 - spec: use the gtp_version uapi enum for the version attribute
 - spec: family only applies to the MS address, fix its doc
 - selftest: also skip on "Unknown device type", printed by iproute2
   with extack support when the kernel has no gtp
v5:
 - ynl: add CFLAGS_gtp so the generated code builds with older headers
 - spec: doc fixes, min-len for the IPv6 attributes
 - selftest: only skip when GTP is unavailable, close the ynl handle
v4:
 - spec: request/reply attributes now match the handlers
 - selftest: fix the gtp.ko autoload crash, check ENOENT, delete by
   TEI and by MS address

v5: https://lore.kernel.org/netdev/20261012024800.400616-1-anilkaushikwireless@gmail.com/
v4: https://lore.kernel.org/netdev/20261010105740.223992-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/netdev/20261009060615.4177402-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/netdev/20261008181031.4129029-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  gtp: set a valid genl command in PDP context get and dump replies
  netlink: specs: add genetlink-legacy spec for GTP
  selftests: net: add a test for the gtp netlink family

 Documentation/netlink/specs/gtp.yaml          | 196 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 drivers/net/gtp.c                             |   4 +-
 tools/net/ynl/Makefile.deps                   |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/gtp.py            | 123 +++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   8 +-
 9 files changed, 336 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/gtp.yaml
 create mode 100755 tools/testing/selftests/net/gtp.py

-- 
2.25.1

