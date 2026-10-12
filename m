Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B735A38C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773291; cv=none; b=hmF64R7gFfBExpYoSiix9FGM4QwBkevBNNT8GVTdkZvpNe9LksLTvTHYVCTw6QN15GLFeGGnIu0Q6hcOjS3vZPvyn6uoDkv3Hw6Ga2xtKW7A8Di9SvDg0e4wApaYh36D92rBNrLXoqXN21INIWVcuMDp1BenlWdf3ejY2UfLHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773291; c=relaxed/simple;
	bh=wV1N0EMtebqy+ViUTneYqlfzv0kZ43eOEZ5LQbIFAjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rohCPUr6qtX9CKMOsBxtdAvYjWRsFREw/6Vf22k+kMe+K3CJHLM/B/SyGffALOtQqayGZzqFI0RDj3BhnPE2FskltI0QScYl+hOpLr7nSxwRuA94tAIqwUjcw11lyUaGHI5s61n4BTsdJq8HgktapZD0UtmTXtkC5FJVE3CMA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsW03kCj; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsW03kCj"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so2127792eec.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 19:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773288; x=1792378088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uP+7PH/D8Dh+nlraV4xc/jtLrXAcsGGaqtx5xWCT1ME=;
        b=IsW03kCjrqG8gsW79hxVdCzY/nFBqhBfS7z+iv+8e3sk+FO28kAGX4XDI+Zz9E05jq
         QCLY1XpINSku9ugXSHn40sEDkY4NhCdGl44EVO37YST5qrM85l8i7aqmG40hBqr4aRlO
         rFoUVUOBoCpDuEqFoZpBI/jR6uGspP6N3+/QT5sIRnaa20WpxOdn+717dshqvOp0O1Zo
         gyoIlinc4CuBlkT9st7y3a3kfpSUZTdLIuH548k3Lttctg6Vi7bhvWpDqj6lwsU0qWLn
         ClaQY0F71+9P2mw9d6G8zgcoQc3EsqfosOee7UnVKKe2jSFVy2YKLC3o0EN4rZiUkc2m
         X3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773288; x=1792378088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uP+7PH/D8Dh+nlraV4xc/jtLrXAcsGGaqtx5xWCT1ME=;
        b=2Jo5ZpgyAf5HShL42cvQ3IZre/VY6USE17ncZRr4pc/QL7HKrzv+W7xtoze60LybZl
         smz/QxRsxhrYgRUMLALiLevV1fFyi5BGz8qXIGrASx8SzHKO84TNHhAbu5rNG1aPGG0T
         ixPFzK9sqsVZb893Wh1x8nKamA35rp63H9QeBjopsCnKDbTxUhhrYnuZzX2xidkRZXkm
         zE8LYF67oOqTL+0Y8dN4DBoQ9ShyvG3I0PPPhK3KfFKGGtghyRrDICMM7W9X2qcj5Zee
         ikrkT2Pk1FwqR0m3vnCBoXuP+0rn8ZCfJTAhaPpV/368ivA4KPmmrRAySyrZYMqSXSCK
         nPqQ==
X-Forwarded-Encrypted: i=1; AKwUvByg1gsoPnl4s1+K4KK/jSgWypa3OVoHBJbFTWWsX3LsgPA1fwH/jviqWBHNO+GbQ/u0dLYvn3w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN+yK+uj+J6S2F5dAeV3Bplgp9EQc1FFHz3Sz1vFsPZuq++W5P
	Jv3QB0VBv0VbekqKQXV/PcrdgQowmJL15OG6olMDqdgcAeGRu2Ufi5iD
X-Gm-Gg: AYBFou2yO9UYnEf5uyT2EdVq7+i68xNt5bLM1gVLLR8AiPgTI5xTjs6v/vk96fwGWMC
	ivq5FEKold2Ip1wf1qsapY313hJlNWjT7jTmvBNxxmYWxbDHTK5jMBPBP4T871Ub6JrmDnfokvH
	40vGXC7roXzJ7Xyahi1s3H4fz18619+chFd1L0AoN1gxJ2lOkhmyXOCJJzJJITA+XtH/ju/rLvY
	/xn2AthDQ+WISScyHa9eogha4UsISVb77jL5YtH3JJwz1wfPAte8733JOLgk8Xwfj4V1h5sGIiK
	RZBLNrzLaGt+58UyaYMgvl9b5mt6Vw7W34CzCSMiRj0LyqVwMSrI2TMPOPAYSNLHzJb2K4Ip8hf
	2/S3srHhXYL8d7PWTSr6leyVRJlzUXb0JBWo09PmzIRseXXzW1X83iPUMp3kbZj1w3Kw3NpjV8v
	6+FA3dii+7W87kCpCyQJa0CjXfcyKa33dzgpFcX/+gGJF/QpODQGo1kD2wVQakg4bCPkIfjZ2B2
	36x00ULqs5WzFPYkZnVIW50ghD5hMfmqNVvPscAKe+ydE3tDjEKePs8zzdPanh8dQcidw5r0h6/
	3t/7bcXeYLn6gtCstYO1W5vsWY40J1h58PZ4ThlXlecTy4rT31xfiQ==
X-Received: by 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id 5a478bee46e88-359bdd83104mr4936824eec.21.1791773287658;
        Sun, 11 Oct 2026 19:48:07 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm26075299eec.6.2026.10.11.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:48:07 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/3] gtp: ynl spec for the GTP netlink family, a reply-command fix, and a selftest
Date: Mon, 12 Oct 2026 02:47:57 +0000
Message-Id: <20261012024800.400616-1-anilkaushikwireless@gmail.com>
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
current uapi header. I can look at generator support as a follow-up.

v5:
 - ynl: add CFLAGS_gtp so the generated code builds with older headers
 - spec: doc fixes (notifications, version 0, echoreq ms-address,
   ms-addr6 /64), min-len for the IPv6 attributes
 - selftest: only skip when GTP is unavailable, close the ynl handle
v4:
 - spec: request/reply attributes now match the handlers
 - selftest: fix the gtp.ko autoload crash, check ENOENT, delete by
   TEI and by MS address

v4: https://lore.kernel.org/netdev/20261010105740.223992-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/netdev/20261009060615.4177402-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/netdev/20261008181031.4129029-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  gtp: set a valid genl command in PDP context get and dump replies
  netlink: specs: add genetlink-legacy spec for GTP
  selftests: net: add a test for the gtp netlink family

 Documentation/netlink/specs/gtp.yaml          | 183 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 drivers/net/gtp.c                             |   4 +-
 tools/net/ynl/Makefile.deps                   |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/gtp.py            | 122 ++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   8 +-
 9 files changed, 322 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/gtp.yaml
 create mode 100755 tools/testing/selftests/net/gtp.py

-- 
2.25.1

