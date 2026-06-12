Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB6261388
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223487; cv=none; b=YHSyLTBhciE82MJTSJa9sRtCNnpQbS4DT+08sPFvF32dqw2KMRzhwSMfDecSLaKnwkyuaGIiSYTIp58+eBug8uu9Hw5PpCAxqW1AuNNVceoB2XKoRSHIGclLtoIfA/BEcarOl+Ac/pO9D8Fnvoj4Onv41XKwP9gKxUtdJ1jOhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223487; c=relaxed/simple;
	bh=nrJEujpdtWenU75xWFosdMAwzUUl2fVjUsBe4NrU64U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pdwkJ0+PHIhM7JAIFUu5C7xokUej2eHgAcBDInn3gnDBD//EgOa5ZjtMnZXBo5RIDOc+wbUj1HpuUxLUy8dtdnIrREdDIydkae1ro88/QfqDxaEvb//g1VUA7BOP60KHstK4JiLEjMNvlXYdUSyGGZ6o+49DFt+zhyf2sH53cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYOKrmbp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYOKrmbp"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1845bddfso4243745ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223486; x=1781828286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jw+mb2Oix6vlzmX2fEritHAtIrKXijXb9hNuLq3RszM=;
        b=eYOKrmbpLYV8EgRFUXPJr2IIoaPZJapAFc+fyNDYgCYdJC9ukFnDbWfHt4MvtmYlFp
         WpW+rGYDhm4emvSvGO4d5Z32nTglwh6gPsOteq+WgMBB/Cns6Y9xNCJcSfTYWAb5dr2h
         u90gCdsL9Ugi4Ri/qV2PtTFgdSvFcpohBXmAbFzz1bF1EkJCOC7p1XThW7b0G8gLW70B
         acmxTYL7LbufO2Tgdjjuu4jEqjdoxuBjRJeY7V/ch9A5+LggZdBTSpkfFyEyQaM7zEhX
         M4/jV1t/4a2TjV5FGc7mxGzXYHT8lKKKJk9owpWfJxXsrBcSgn6j26MjvY1ayj+4SeD2
         5n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223486; x=1781828286;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw+mb2Oix6vlzmX2fEritHAtIrKXijXb9hNuLq3RszM=;
        b=tYinAxa3jcDyAWeDOMXtSWyJmBKMugxU9fhb9iisD3gKLKOqvT2QeF9V3wF5yfeDB0
         71dQyp/Wf/FqEtW6xQXPC85+KTHIfujrjs2gt5wZVG8Jj5TDbTlwBI2BjDwzj6YilxwJ
         de5kPUNfwQEpXMYoAXfYfcSOMgSOb1xKpDsFaTO1vCIM4eR/cfV1Q32x1D6y8LCd3aQ2
         mhsxoqgF5mJ08OK4fwZhqHJCF6ajdRdMCgNcHQ4kzaGc6acxiXZa5XM9Xv+3Ck4DLzc2
         /kea4so5FlU+gwjkaALqdHlglT5U/nZl+/f872gZsVLjoKcfz522Xj70RGYNPq9+ZF7R
         oiFg==
X-Forwarded-Encrypted: i=1; AFNElJ+Pz+C4/4+07v7hkwZBvFpkRx34QLmDGHPzj40ktJISCioa/NFkkK8lxDh2o74XK/06ujJF4Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaucECdf/ljhVlARdsbK68fGC7EFfHqw+G3EuD045Xi8EL65+M
	EMA9GpRUPp2H5R6ZT6HkL2OhGl6klO3W7xurM2LP7i87EK6O79knvyDWKm9jbWh4m8ubwWq2rg1
	sj6C1Bw==
X-Received: from plbbh3.prod.google.com ([2002:a17:902:a983:b0:2ae:ceb3:f968])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54c:b0:2c1:f262:495f
 with SMTP id d9443c01a7336-2c41235c4acmr6889605ad.26.1781223485353; Thu, 11
 Jun 2026 17:18:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have some hosts where packets come from special hardware
and are provided directly to userspace, bypassing the kernel
networking stack.

When standard socket applications are run on these hosts,
a userspace proxy is required to mediate traffic between the
hardware and the applications.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     ^                               ^
  userspace   |     |                               |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|  virtual interface  |<---'
  kernel     | |   skb   +---------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

However, even though the hardware fully supports timestamping,
the HW timestamps are not directly accessible to the socket
applications because the skb is consumed/injected by the proxy.

This series extends ethtool and adds BPF kfuncs to transparently
support HW timestamp on such a setup.

Patch 1 is pure net-next patch to advertise fake timestamping
capability on virtual interfaces (e.g. ipvlan, geneve, etc).

Patch 2 is misc cleanup.

Patch 3 & 4 add kfunc to proxy RX/TX hwtstamp.

Patch 5 is selftest to demonstrate how it works.

Note the test requires this iproute2 commit:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c9a9f12aa619288fd3d4e16bc4b3c73b655a4efe


Kuniyuki Iwashima (5):
  ethtool: Introduce ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
  bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
  bpf: Add bpf_skb_set_hwtstamp().
  bpf: Add kfunc to proxy TX HW Timestamp.
  selftest: bpf: Add test for hwtstamp proxy.

 Documentation/netlink/specs/ethtool.yaml      |  13 +
 include/linux/filter.h                        |   2 +
 include/linux/netdevice.h                     |  11 +
 include/linux/skbuff.h                        |  13 +
 include/net/tcx.h                             |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 include/uapi/linux/pkt_cls.h                  |   3 +-
 kernel/bpf/verifier.c                         |  13 +-
 net/core/dev.c                                |  39 ++
 net/core/dev_ioctl.c                          |  31 +-
 net/core/filter.c                             |  91 ++-
 net/ethtool/common.c                          |   4 +
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/tsconfig.c                        |   7 +-
 net/ethtool/tsinfo.c                          | 123 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 580 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 234 +++++++
 21 files changed, 1169 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

-- 
2.54.0.1136.gdb2ca164c4-goog

