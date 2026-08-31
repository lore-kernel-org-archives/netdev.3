Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6253C456B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173943; cv=none; b=jiwuLk3aYsuFI9nZv3jzPDPKzmXmGme0CasXJgvgpJknEFgszqcW4RTj/U2K0s/Lu9DVyLVdtLsGfk1Th2vHr8qvBnU3pM6qhze2QksR1YOi8LmhesFVOMBM7cGehkmFp3iSqdfzEYNggCIlVUK3OnSpDS6RA8VV1h5nnfjfeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173943; c=relaxed/simple;
	bh=ihE3IbQjryxAsZoD44/tDnIUtcAmNLPV+p6V9WhATdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LS+HrdZqsBshHY+z+ZmpHUHpDxrEWeFbQcrVtArLKxb+bIzah00UR+yHb0XUdCYFMPTyD9CbAai9PKX437ZzMcRM+3x4XjA5E2ZQKfPkp26QF2LsNVdwz4mP2iobXAIlVnVvLkivNUynJhTxXu7AY9jEay/ZoaBMtUfdL9GwNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr1eXMBm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr1eXMBm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843e397f74so559353f8f.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173940; x=1788778740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6D44vT98lo4GhN0bPflWOJiXkBCMziJukOHdW6nL4ro=;
        b=lr1eXMBmHceppSgkIYk6ncWF+qaWahe4uXtzC4nKdqyg2csJU+FMvz7IWpAIzBqnX3
         GVGZD+3U2IbPNvQIp3M7fZj0Exmm4jB/CykqL40iTPp9JhEk9pdoqZ73o19/s+Nf0DPg
         QCgbk7xSjhwm37Z70WgNSQAX+QE7JjmukM8PItFDTaK2sfIkYsqTMCUBpaiuu+3SGSWR
         OmnoR+hbUKPyq927/7DG3zJGqE8j9T7OxuyCFlIa+RfU1vLLmt98F/Z6/GIMA/fxpFPi
         OG0ykybTgwqWCtkXT2nKzn8Y1OVSngUwAjagY5D3y8KaWbUCmb2wLoZtJMIFuSrHGh+K
         GUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173940; x=1788778740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6D44vT98lo4GhN0bPflWOJiXkBCMziJukOHdW6nL4ro=;
        b=shuwlGpW3i5vAc+0yg9HE2xf/+lDwkf8zZ5IEOFbyuzOOUC5aqJQb1RzgcqyAlaA8b
         CSO2M0X4Knw0DZwnDOwD4CDAMsj1G5fb1CXfDXTAVAQxFPOYE975lvBOgbLh9kFcMjee
         tWf5Vur95QMWi0J/ztopEUKSMPy+vPsK8CoqsKaaSJuX7KxfCE8jAa+21LV5TcDHTv0S
         +LRmS5pBTLfnFu3jKTJzNgNvUMAruV0L9oDQg/Hz2dZ0MKC5Gk8nNO6ktAHRv6jR+k2f
         I3bNX1/Z8esepENIj4giNqN/9CEZzAnr7rT/XB557KZD6JWYspARCwcu3jFGj1XnQw0b
         jkIw==
X-Forwarded-Encrypted: i=1; AKwUvBz9P/ZjHMeVgUfAbtrMv7bH8ZsxjlYRW8O6QnUYeR8BKplEmcoCy4rlc1kw8jUez7gnfrj7axM=@vger.kernel.org
X-Gm-Message-State: AFuF++m9CfQNxrdMKlGMjXa5Tk5vMo3sEpf5OHt8ye6KDv8j4YzkjFmc
	11sEnIB01+0lykm0UsPeSEuQVO0U/wfs9cDjoYEFuwfgB8QfabQQMWZI
X-Gm-Gg: AYBFou28UdTNOooxPD0kPdheyjyld/H4dmaUswL62tj5ibYg79mWZGLdw7CT7boqeIf
	30h4p+5BAr3aahE4Cci+ccZRhpScCworD2TRCzVkMS4zmHix+k91UP7+gqCsN4WXJhG3yKeiwp3
	os4oRFHic/LoA78XULjHQcBI4geiUsIbNfRCHFxzv47yie2Q1Hf8MCCuivwRGuEVG2uZvmeNFE2
	oT08qroyqwnMUC/f/Ua5vC5pnzmUCtzvsV3jnxA2UL5rzaJ+WpvsGFgUe9QG5xvV5cql4i6+94E
	bcYHL6fIGjui5ee/vowZ94mGKs7bUSfiDRjspKnOR+Xukr2C1v06O7V90KAR50gDt7wwSM8O5ql
	GQcyrfCbHyOsznnqWtUsYdifM7HgwYxwoEuUYvG/j48A0tXBtcZq9QLcYeo/chDfWL/koyAz7st
	5/ejQB9AOL9IsJhC6RXkg3ta2/Jm6UKxHl7U27om3rct4taxUPNbog6LMsC8gRua6RvRvLUKb9l
	wPJww==
X-Received: by 2002:a05:6000:60e:b0:475:da0e:744d with SMTP id ffacd0b85a97d-484397a0a67mr13565071f8f.8.1788173940131;
        Mon, 31 Aug 2026 03:59:00 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:58:59 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Date: Mon, 31 Aug 2026 11:09:25 +0000
Message-ID: <20260831110934.241898-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF LSM programs are allowed to attach to LSM hooks. This enables
operators to mitigate known bugs without a need to reboot or livepatch
machines.  BPF has shown very useful to create such runtime policies.
However, many APIs and parts of kernel aren't covered by existing LSM
hooks and this would be beneficial to extend the coverage.

To simplify the process of adding new hooks this patch series enables
BPF to attach policy programs to hooks defined outside of the
official LSM list.

One of the reasons to add a new mechanism is that in order to add a
new LSM hook an implementation, at least one in-kernel LSM must be
added, such as SELinux or AppArmor, and BPF is specifically not
considered as a reference implementation [1].  This is, however, not
feasible for the use cases and capabilities covered by BPF LSMs,
which are not directly comparable to those of traditional LSMs.

This series introduces several initial hooks as a starting point for
adding further networking and non-networking hooks. The selection of
these hooks is guided by clusters of CVEs published by the kernel
numbering authority.

The series consists of the following patches:

  Patch 1 adds a new mechanism to add hooks. (It is deliberately
  made as simple as possible.)

  Patch 2 adds a new BPF hook for generic netlink.

  Patch 3 adds new BPF hooks for the ethtool APIs: generic netlink
  family and ioctl.

  The rest of patches add corresponding selftests.

(The series applies to bpf-next. Two net-next-related patches adding
actual hooks are accompanied by BPF selftests, so it looks like
bpf-next also might be the right destination.)

Links:

  [1] Linux Security Module Subsystem Readme,
      https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README.md

Anton Protopopov (7):
  bpf: Allow BPF LSM programs to attach to more hooks
  net, bpf: Add a generic netlink hook on msg_rcv
  net, bpf: Add bpf hooks for ethtool control path
  selftests/bpf: Extract some helpers from tests to the netlink library
  selftests/bpf: Add netdevsim helper library
  selftests/bpf: Add tests for the generic netlink BPF hook
  selftests/bpf: Add tests for BPF ethtool hooks

 MAINTAINERS                                   |   1 +
 include/linux/bpf_lsm.h                       |  14 +
 include/linux/bpf_lsm_hook_defs.h             |  18 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 net/ethtool/cabletest.c                       |   6 +
 net/ethtool/features.c                        |   3 +
 net/ethtool/ioctl.c                           |   5 +
 net/ethtool/module.c                          |   3 +
 net/ethtool/netlink.c                         |  17 +-
 net/ethtool/netlink.h                         |  25 ++
 net/ethtool/rss.c                             |  10 +
 net/ethtool/tsinfo.c                          |  13 +
 net/ethtool/tunnels.c                         |  14 +
 net/netlink/genetlink.c                       |   6 +
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/netdevsim_helpers.c | 176 ++++++++++
 .../testing/selftests/bpf/netdevsim_helpers.h |   9 +
 tools/testing/selftests/bpf/netlink_helpers.c | 176 ++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  12 +
 .../selftests/bpf/prog_tests/ethtool_lsm.c    | 330 ++++++++++++++++++
 .../selftests/bpf/prog_tests/genl_lsm.c       | 242 +++++++++++++
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 160 ++-------
 .../testing/selftests/bpf/progs/ethtool_lsm.c | 168 +++++++++
 tools/testing/selftests/bpf/progs/genl_lsm.c  |  58 +++
 25 files changed, 1345 insertions(+), 125 deletions(-)
 create mode 100644 include/linux/bpf_lsm_hook_defs.h
 create mode 100644 tools/testing/selftests/bpf/netdevsim_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netdevsim_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/genl_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/ethtool_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/genl_lsm.c

-- 
2.43.0

