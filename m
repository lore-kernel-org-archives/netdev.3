Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D02BE7A7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122950; cv=none; b=G5hIH+rJics1Zqt7lwK2g98wdQKh6yj6u2jqs8xoOV1MsCtxbf9LMQ/VKn/y1HLmaw6waCVGs5tBJnS6Hem1ru15DgBIUdS1Wu6UiojcjV6g6ao7/8mIQKlMXeTSz0BhuHSFdnwc6MN0bclHSFCEWWRn1fK3SeylZHNr7xfQi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122950; c=relaxed/simple;
	bh=3g+wpnZHiCEsHE6YwB4A6ShdT7sQM+58Z1ZJu+va2xM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diESxOPib/GRC7eMoyCFEsxafqciDZBpLr6y8qGsfFb1j3Pq52nYAzYlvcDPVtyI6L+9XjeEdu8bedWlGacQ/ScW42HXT43bR8RNtY6v3lq+n1q1LaLrPeBRwcJIKNULKahYT/H/1vGiFA+IJngwdz6lsXuDSg4qW5zQsh3PXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKZxYvN7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKZxYvN7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so12633125e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122945; x=1786727745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WgXBMFX+/OrJQbeCB3wCgD7VfH2uKxWS2TFBEQrDNPo=;
        b=RKZxYvN7swLJUFwGoyA7ywWfI5ePew5VM4Y50vVlnd3xp0+ykgz5066TFivYdSX4xn
         y+4FpwwkCSMailqmfjIm49JVW0YMW50dl4SOXWTzBzxTKzB/DZC259NXDuvMdlNFz1ED
         7SQCZmFUCcMJK/aRbwOpt6VeuCo2EeCajCDX1jSrLpPugzxq0Qv4OTyQZBBbVDTFUlan
         /eT9krJhQCcaVEvU1dJKzbd/OZMA+rgnrt1Ax9BHhCyUvMa/WmpENS3I/2U5gNE27SJw
         krpkM7xXq807fGISqLo90oDcu+elix+UqRoNws28H1odAmBJM8lGsftlAQGNPPlZPtab
         v4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122945; x=1786727745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgXBMFX+/OrJQbeCB3wCgD7VfH2uKxWS2TFBEQrDNPo=;
        b=NndOz0RPmX/Z8XpShCkAT82RvemskUqAgYc2gXXmkNOeKamD2M2+WAsjWgsOgNx9bM
         KBH2+W/5evIkWh+KL/PQXiOIrSe2KSmCc+dVPMKIqczIr4HU6fRtUMG/K18vaoIcM7IM
         bG0DgICG5BqjWH66pg4ZHjFsywxcOpYRLz/93rE36OhIWhbp0EdEJtRSkgkNfaTtLan2
         nUjZQsQZ9YkdegepiaTySeytxyg2sZtphRMkgUdkV4gt6e8xEqEQT7F22I+BiPS60FD8
         yx3C7mzJRjoSo3QUku+BSKarSVZlGVIvIsHwKmYIUA624HLPbIIbNqNA72zgu5FGo12V
         u8fA==
X-Forwarded-Encrypted: i=1; AHgh+RqOv3WLnpHmS4LYLFrAxuxFWGeejmhNt6/cClRHsdr8Ljd9e735rIQ+cRACYv+LRME1FOjiB6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgpe09H8vYyfxZEb2fiSWYmt7FEDhcdUW/W5xp+B7EMkffJLcH
	Dc0mM0vd9asBsgm1kQ9x+4pDAworCMApvzfVtY+G8/HRyLwqn/7nLPdr
X-Gm-Gg: AR+sD114FSWcKq7Y4z7+2EQLWLGdQUqYWxmb9RsNcnNKMUHKS7aj3mdO46PtrzlmWvQ
	s1BJXoTMIaToSxs7IfIJ7ni3N+fo3dO9dWpvfsJcQS5dYzlHryo/rQk9hrN73ziHBiFRQTGofxb
	XxNJ9oOsRMYs/Dur8vv7hE+0Gn0C7Ho+SpkukZlk8s4c/PfcnvX6SmNcfU432SI11b6zFyJctCW
	8k92+lReEk+7ueN/kjX5Mm9SwnFvsjCEYnBQ/2b9woSaOt1kyNLpePRLlAsVvn3Qw//L1oquo2c
	cVFkqEnrdgKtSueLEDwz8iPF7cjRVCgQUGgg6y5GLEeiaC7IEy1I7sd7K02pZ2TuRqUCl4hM8Vr
	FJD0q6NIjDeNMfloIEDhxsfy8g6B6MVCaH9uGUXChL8cK9ZPLbWSYg0KVHu2qq0NqUxd8+5t/qi
	Y3y9Mf+fvSP8nGxmJ1J4rfdXJM9zAHAa5dXpk6UQTRZbgd4Gtxut9iUcbGZD8s2i3lCFzdnGZQC
	8deqK0K7yQBN1B4qxEfjSuXUiNXyKoadw==
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr314648145e9.6.1786122945168;
        Fri, 07 Aug 2026 10:15:45 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995d85b96csm27737425e9.2.2026.08.07.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:44 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 0/5] Introduce bpf_ksock
Date: Fri,  7 Aug 2026 17:15:27 +0000
Message-Id: <20260807171532.125149-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces bpf_ksock, a set of BPF kfuncs to allow BPF
programs to create UDP sockets and send data. This provides a mechanism
for BPF LSM progs to emit telemetry over UDP independently of userspace.

The main use case is to be able to completely dispense with
agents/daemons for BPF programs after startup. In the case of
Isovalent's Tetragon, the idea would be to be able to emit security
alerts or export data from BPF even when the agent is down. For meta,
according to Liam presentation[^2], this could replace logging via
ringbuffers which created cross-binary versioning issues.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration), for example used by the network bpf_crypto kfuncs.

For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
during his presentation of BpfJailer[^2]. Then it was also discussed
during LSF/MM/BPF 2026 in Zagreb.

A first version of it, called bpf_netpoll was submitted to the mailing
list but eventually NACKED by Jakub Kicinski[^3]. The discussion
eventually reached an agreement that we should use regular kernel
sockets if we want to do network from BPF programs[^4]. This was
fundamentally more complex to implement but here is a first proposition
of how it could look like after several automated reviews using sashiko.

For more details, here are some of the main adjustements I had to make
during the preparation of these patches:

Initially, the goal was to register the ksock_kfunc_set with
BPF_PROG_TYPE_UNSPEC to allow send to be called from any programs. This
introduces significant challenges (but might be doable). The limitation
is still that the programs should be able to sleep but combining this
with bpf workqueue allows to send from virtually anywhere. However, not
by-passing LSM socket hooks make it impossible to be called from the
workqueue context as the credential of the initial caller would not be
preserved. Also, it would be easy for users to shoot themselves in the
foot and attach a program that sends asynchronously over the network on
a network hook. So the idea for now is to restrict the ksock_kfunc_set
(which is acquire, release and send) to SYSCALL and LSM to make it
simpler. Also to make the patch set easier to start with, the sockets
are restricted to UDP.

v5 updates:
- add Song Liu ack on first patch (Song)
- guard BTF ID of bpf_lsm_socket_sendmsg on CONFIG_BPF_LSM (Jiayuan)
- fix checkpatch warnings on style (Jiayuan)
- encapsulate RCU dance in new ksock_ctx_get() selftest helper (Jiayuan)

v4 updates:
- drop the __sys_ prefix on connect_socket() (Song)
- replace recursion protection with a verifier filter on calling
  bpf_ksock_send() on a program attached to the security_socket_sendmsg()
  LSM hook (Song)

v3 updates:
Simplifies bpf_ksock_connect arg by using a union (union bpf_ksock_addr)
containing struct sockaddr_in and struct sockaddr_in6 to remove most of
bpf_ksock_parse_addr() code (Stanislav).

Note that I initially tried to put the union inside of struct
bpf_ksock_addr_opts but we ended up with too much struct nesting depth
from bpf, for example when trying to write the ipv4 address:

	addr_opts.addr.sin.sin_addr.s_addr = ipv4_remote;

It resulted in:

	max struct nesting depth exceeded
	R2 pointer type STRUCT bpf_ksock_addr_opts must point to void,
	scalar, or struct with scalar

v2 updates:
This second version simplifies the patch set by removing bind, keeping
connect + send for now (could be replaced per sendto if needed). It also
removes the sysctl limit and the whole hashtable ksock_send guard with a
single bit in task_struct.

- remove bind from the API (Stanislav, Amery, Kuniyuki)
- remove the bpf_ksock_max sysctl limit (Stanislav, Kuniyuki)
- replace ksock_send_guard with a bit in task_struct (Kuniyuki)
- remove unnecessary init struct sockaddr_storage addr = {}; (Kuniyuki)
- remove redundant ASSERT_OK_FD (sashiko)
- fix typos in ksock test patch commit log (bot+bpf-ci)
- fix return statement in kfunc registration (bot+bpf-ci)

v1 updates (from local sashiko iterations):
- do not bypass the LSM and thus add send re-enter protection;
- limit the number of socket creation through the kfunc per ns;
- copy the arg values to avoid TOCTOU race since kfunc can sleep;
- prevent calling bpf_ksock_create from workqueue with improper creds.

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lpc.events/event/19/contributions/2159/
[^3]: https://lore.kernel.org/bpf/20260511182019.69ebc7c6@kernel.org/
[^4]: https://lore.kernel.org/bpf/CAPhsuW71P58XqsXrLbqsShgnozg66TA=T_c=fYrqSSzvL1tTWA@mail.gmail.com/

Link to v4: https://lore.kernel.org/bpf/20260806182234.380833-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  net: Add connect_socket() helper
  bpf: Add ksock kfuncs
  selftests/bpf: Add ksock kfunc test
  selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
  selftests/bpf: Add ksock test for async callback guard

 include/linux/bpf_ksock.h                     |  36 ++
 include/linux/socket.h                        |   2 +
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   3 +
 net/core/bpf_ksock.c                          | 335 ++++++++++++++++++
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 133 +++++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../selftests/bpf/progs/ksock_common.h        |  78 ++++
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  72 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  36 ++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 ++++
 12 files changed, 812 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

--
2.34.1

