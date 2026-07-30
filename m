Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D543559CA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405637; cv=none; b=IDF/VACSu2QfZgS0K22T5Y5L4jI+HBF8WYK8gcBpyqP433syIWNNOG8bIGrjpJE/LdMHeopUbgemiJHG1vYuiO3hbzGNtD1jiTy8c+Yh5BK/Yi/0aSaVxOVhVmTURcPeLY5kRG8HeKgAycEiFLO3ZJu9w3EtZvGmIlRG8k4QwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405637; c=relaxed/simple;
	bh=zK36PrpFkfhmCHFEeJMjXOMCIM0dGnWGnY7l47xxgt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoHDO9EabviW0Xkie40xPG9pf4d+byd/b+pyV2J+sIQ2u1qXj/g/Cw8KoIJvoya54JiDZKMIdd/vwBzC37fmYFIvKs462b5egp52CMILhq0ZJvaueXo/swOvrzuFND4+BwAMALkx4XrfTgLFU3+Ql8qpegcCrRl1DjoopwT3v+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbwMeK8B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbwMeK8B"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49800c6a846so4618655e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405634; x=1786010434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=APzEGW6pwTYOv019V8m90qHkwClK0q1OMWnbES6kegY=;
        b=gbwMeK8B99h4WDOZKtyviw0AH7I11KV1DCQPRXT7mZVfcXj3rHwQSFZKPzKd5Ke1SK
         j5Th7+h8m+t99Gpe5fYIyuXgM5vzAx5JuwgLB+z29P/CVGuE13bQQLCXxNSJkXn7IFjr
         TPMGXVv8e7p+2UOWioprB0vWtf8V10w+guWE60l4xL3hiDbTQSs9crbIfkglfauFasJx
         /VqLrdVrjm4WdAKrOHLza3Ub4DYfOG20pLWVCL2H9tz5IDsQJdIjtj1IEN+do3LEOuSZ
         9qv8ljzSLTE4j5F9yFlzg+A+yYlC0BBVGQTyUWWFTaSfUqNmv369nU8Mgsn3/6qAjlEL
         3udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405634; x=1786010434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APzEGW6pwTYOv019V8m90qHkwClK0q1OMWnbES6kegY=;
        b=I/USbAS4jLArsdVZFj3u0rV0fK37nfkGG6CsS1mqESgbKcxoSA1p41VFyTcfkRXZw6
         LOpxufr9QGnXSCB8MIOtNfKmApPv2u21/ZlAe33jGl8/GDeFxkSTUTjl5Ok/McvqlyZc
         CbznaxHi3hqMaal3pSlLLniF8kgJSW2XVqpJit5mb4gqO64mFfvb6QbAkJtBRNBFw9dp
         3B2M7fEm4BBE6hIlk1svuRObHuSv+i5zLCbxouHRUxpWpE9W3BYqxtKsoUldfcKAVXx3
         XaegTpI+D22Ybhb9lMtRBODdxhxOtl4YmjSugZ1Z6ewbc1xU6NxBXX8ZkDxX0wO1i8+Q
         h1qw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8iz59vmRhcUAh1o0mcJT0uHZjhoAEqT0vsiDIS/QUEpNMNZDKcno+jyLOfwud6Wltzp6hqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5Gb7AX3IrT/s6o3O+mczi7fz6yiEMoM7Ag6/0DCK1djBqele
	7FAKJ9UpmGQ1BwzQUXzHQgIcerxnXn6KJE74Uan71f1IIWi928pcO5YQ
X-Gm-Gg: AR+sD10XCN2rY5aaLbCKdSDGB4BUe2J6eyH8KG2uEm24Oig1zBzaUE47fEC+LuX7OVl
	F5zw072KLiVYNDuwS4rB/oer2P10EKw9xx2gbB4EPR4m8/Z8vkLP7JTdx/btbx9h2cXQpNc6xUL
	Gce68RzBqkSGRbHyaGhcHTMBSihAPtJ6Lfd1TkDgWwqI48yN9qFFeam5TaQd7GoQu0/XdkaCLbL
	2J7R7UN1GHE5bAKOtBIFqKzfXs9zprymWumW69eGS/1xHiq8yQOfSoQjd02U/4/9q4vqVPxydCK
	TLf4tkdxsA5qpAq7mvxaneLY87Ug0RwESI5Buf6rgw1FP4IL8wrVwdgHf8Uyb98G8eUNAlyHZ1B
	UAMIgoWexWGSbnyRvd6yGzqv4vSRuwBlTRZt2HNo9SuSuqfN88jmrBq4rZTXiguJYsl6Tbv4Ze5
	7L+P2HqfUQv1fD2ykOjtS2nbHwIeTpncsnpEKSUMpwiL229kQ6S1G49Qowl+p1C5oIejE6cr/RH
	VTihQkUOMOs
X-Received: by 2002:a05:600c:1f93:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-49800e7a711mr24299645e9.15.1785405633946;
        Thu, 30 Jul 2026 03:00:33 -0700 (PDT)
Received: from pf-5j7x25.fkb.profitbricks.net ([2001:9e8:482:5000:a5d:311:98af:bd1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e4721sm3984728f8f.16.2026.07.30.03.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:00:33 -0700 (PDT)
From: Reshma Sreekumar <reshmaisat@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Reshma Sreekumar <reshmaisat@gmail.com>
Subject: [PATCH net 0/2] net/sched: flag inconsistent qdisc dumps
Date: Thu, 30 Jul 2026 12:00:04 +0200
Message-ID: <20260730100006.3547944-1-reshmaisat@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc_dump_qdisc() walks every netdev in the netns and spans many netlink
batches on any busy host.  RTNL is only held while a single batch is filled,
so the device list can change in between and the reply can miss entries --
but nothing under net/sched sets cb->seq, so NLM_F_DUMP_INTR is never raised
and userspace cannot tell a partial listing from a complete one.
rtnl_dump_ifinfo() already pairs for_each_netdev_dump() with
cb->seq = dev_base_seq and nl_dump_check_consistent(); patch 1 does the same
for the qdisc dump.

Patch 2 adds a selftest.  Netlink dumps are driven by the reader, so it
unregisters a device at a known point between two batches instead of racing
against one, and a second case requires the flag to stay clear on an
undisturbed dump.  It fails on net/main and passes with patch 1.

Build coverage: allmodconfig builds clean with W=1 -- vmlinux and all
modules link, no new warnings, none in net/sched.  allyesconfig compiles
clean with W=1, including net/sched/sch_api.o with no diagnostics in
net/sched, but the final LD of vmlinux.o exceeds the memory of the machine
used here, so that link was not completed.

Reshma Sreekumar (2):
  net/sched: flag inconsistent qdisc dumps
  selftests: net: check that a disturbed qdisc dump is flagged

 net/sched/sch_api.c                           |  16 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/qdisc_dump_intr.py  | 123 ++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/qdisc_dump_intr.py


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.43.0

