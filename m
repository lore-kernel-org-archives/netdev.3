Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360F48A2D1
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040566; cv=none; b=LCBjfWAJHSQ1d6zpTxkbenNpB1ZELyOuegI5RZTOJCIWZ584gVif9d9Ie8Chr5hR30bUj7kwho5DEIS/XfVuylw+OpL2U3NwXhG5xFsMApZbpQhPpRRYD4vUFInF/WQNDqgZO1w4Zw6Sop06yYqO9yiiTgcLFK99vqwQHlPG7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040566; c=relaxed/simple;
	bh=EQ7JJcNfGobpRBKLruxZxyQYlNTVRpJsh8Fv6F42UfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/bOQHBdsoXIJlInWFmvchf5CZVYixBtQi2z2kubo+8V83u9cR17ibe+uU4rQSq7c59iXvh2tzEZCJUXEnRtO2xn1dH/l3XIlFbosRcsIAg9IsE4wGTw4VnEBUpKvadzANbyp6wd4+JdL6VD8Wh4T1DNQt59qoEB0nWGdFlp37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ2wR/Zz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ2wR/Zz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495635a85d2so21485675e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040563; x=1786645363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5M14lldlo4edE1Inq08j5CZxhFj4ORfcjPmMog4vd4=;
        b=pJ2wR/ZzaNVeb5G07P1LMrqtxGhsB7uvteOlJLJSfZQBiqS4ziYRPT5H46g/LQ4+u6
         DEzN9netzB5z0MwMtUcUjvpjWqVMElT2PntfAilk9mi3dXnq2rut2Jbi6gkUjuYsrrs5
         P54/h7UmDWavRwVSn8atEdSdbZtHZL1PD01YdAPr1XMfzLC4+LCyFayIE4/bDAiFS0Cn
         jz4wsoTiFWLunnirw91/LK6Tv+yWDihpfAA1zatTj36K6mFCcFfkPiY7B3Ykg/hNauzc
         x+SAjmNhUF2sq1q7rfCp6/QN7+I+Jz+w5vlY0uvNFLcrB84jh51FUzdzqDgtAaBofcGU
         3Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040563; x=1786645363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5M14lldlo4edE1Inq08j5CZxhFj4ORfcjPmMog4vd4=;
        b=NYMYgjnU0JIV53OFEViW+GYNVwjxCD+owQftVO1ccM2GsbbSkP1xlRS8oCTtNkz65B
         ps6zFcsH37eum3KL1d/Hk4ezWnbIPU/2GZoyv2srso5eJKWVCU4R81U2P6UuhSZpAz7K
         uSFNOc3skbdfM8xbiVisvo2JDVHhZHBRfHP+hey1DtM0MuubtXvfoWG91NVvMWP9d9pe
         IqHo1mi3O8kWWyw0SxCgNNdoonSGTD0BoyAP+HbAaAfP5DWaFJ/Bm1uNch2DFnvJdyDf
         2O8ZmB5uMoI29MQw0566K9mH9PUk9dT6kn0AdpaOizalNUgmZpYt4cLxvcenfIlC2NCs
         HHMg==
X-Forwarded-Encrypted: i=1; AHgh+Rry0rt9cIZb6m6zusS/DI0yfD9MZ/sl4UhSk5IxxG17XVnVhxbLbf0NlAmrM5QA0VMxRCAAMZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhIbVRBmkA+whqykVjLgbgYbFt7htfg22sBzoEysuukQTfZnD
	CIIaWbQ1jV0XHgaJ0FVJdFhLMdtkoTeNLjf4NjRad5sznb505Q1SZ+ES
X-Gm-Gg: AR+sD12oaTN9j8FqTDF5Qz1zvAN/X8EWjiNqviyOQ0ijoFtHixWSWU3/9n8p5ISEN27
	Bofhdk0MSiJn9AUg+K1uraeFIgetig38pKOFPaQC8AnrOQ57frX6kQ/saF9/JvJq35Xz2gBWhai
	Gaf3ojFEqyzKtn19Rhx2wthGMV8xy7q4nedUWwOdIImJ9CeORRr9wjtxsoDm7EePEE37A3GC19h
	nGzRhLO2ivXq34l5ST+M5HBPk/2tabHkV6obRr1yQxOEp5Cms4DKD487427yE7PLEkiuA71jk12
	WpsDLKlEsayzcVOF/ZeVdDa/O6uQyTjmu3eqLOHuZl5/P63YWCyvox+8S5I2Z6eculFGX/fWMTT
	m/84NA4Svr4aZsBKyJb4xxDIY6wrtUp6Fa8VRy/sK94iCWpstbKwbyW+HhYdfJC9dmUptK5VOrd
	4vZjEvM4OBmBOIAkQT1sjFduDJWxAfPJ4aNtTpLHGz6yB9QvHWpaQ3/3C+JyEutRbIZ6T33GqYn
	Toto+rGrm1YhFKl41KP3PjEGJh29OXW6w==
X-Received: by 2002:a05:600c:5791:b0:498:11b5:3ff7 with SMTP id 5b1f17b1804b1-4994e7d8a85mr188950265e9.18.1786040562951;
        Thu, 06 Aug 2026 11:22:42 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm82214425e9.3.2026.08.06.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:22:41 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v4 0/5] Introduce bpf_ksock
Date: Thu,  6 Aug 2026 18:22:29 +0000
Message-Id: <20260806182234.380833-1-mahe.tardy@gmail.com>
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

Link to v3: https://lore.kernel.org/bpf/20260804164652.296919-1-mahe.tardy@gmail.com/

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
 net/core/bpf_ksock.c                          | 331 ++++++++++++++++++
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 133 +++++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../selftests/bpf/progs/ksock_common.h        |  58 +++
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  88 +++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  36 ++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 ++++
 12 files changed, 804 insertions(+), 14 deletions(-)
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

