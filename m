Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510107;
	b=OHFkHbn9lgWZyHgGr8HhX8Hs1aEdM3mIWf8i2y2jl2kL5P5bS1B9XyUMY5IM+F2O3E3K
	 +MbzrVCT/mHehxYwsquoqQS3KdV01RwcwwttW2yajUMNI6VkxQc/dIDlm3SbxMCXiBY7u
	 /TTUc6g573rmbrAzK8wAJ0bMI6bmxlmySxPb2gPrPcd1fMKUV1krNMDEO/Gv8KLpVB3GT
	 wKJQTFnzqj5NhgUMfsgdPMvt+4oOXlXvOW0ODW+XwBv+Aet386hgIsUKBymMs6M1rDSNa
	 mtvkYhwL9dzLl35KWRL35zNohOmnCUwxVBZsHGOwSIOiWcxiU9IALsdxeI2h/D+J+VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510107;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DAFHkg4Hi5ytokXkuyFfDVfxiK2CCIWzJMm4haXDhGI=;
	b=tFZHAf9kTgM9l7BydqG7tE2jqC1suvHBGKANr1VR1tLa/74DAhE7P5aq70ngkpI/Qfb/
	 F5VzFfnlyK+1UYqWjBfLQzbmT6xV8hHOgGNLJ3OFUVihrTWT9fYI4X77p+p1ZIKaj1dt/
	 74TgzYURTYR0YnNORrkin5aLOkWkClh1R8OGzcJil/4RNrKK32BFscUYk5CMDSOj9XeZB
	 wwVnbwZkfszpc4Gq8Th1OSLnTvog/hM0eYn+rJuT5EM2kqaGwIOic3krZMQ3dyPvpTKNY
	 KUdySZBeJ9pQDPmojUfUbjKMBjLPrnVgonPaJW4GWHTqXxzY6gq4cCTBX6br83I3J7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.62
Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C9606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D63C9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L6MRdmgTqY9S3w7Q6dez7ePn+jJY+pxXNkWkG83F6Vw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792510098; v=1; x=1793114898;
 b=nznvEF9CdeJw3GY1A5JC/8OrgJY/3LbgTMc9Oj6bgKxGMag5XcO+ezoHB9ll84PCDOZxq6od
 AzB8YUMafgj2JV2IjXVTwHEcGs/CmDv9gukV0HAXNADqwGp7EBaDTbADZGWA3MDLw1jenKx1/Zn
 IEUcgL91TjxKIydLxEH7vWw0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fb790a52be900cec;
	Tue, 20 Oct 2026 15:28:18 +0000
X-Mizu-Trace-ID: fb790a52be900cec
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v3 0/6] bpf: Add syscall common attrs support for xdp link_create
Date: Tue, 20 Oct 2026 23:27:58 +0800
Message-ID: <20261020152804.39863-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm planning to add syscall common attrs support for LINK_CREATE cmd.

This is the first series for the plan, that adds syscall common attrs
support for xdp LINK_CREATE.

Thereafter, retire the tracepoint bpf_xdp_link_attach_failed, because
the underlying driver's error can be back-propagated to user space via
the syscall common attrs.

Changes:
v2 -> v3:
* Drop bpf_log_attr_report_size() helper. (Alexei)
* Drop 2nd write for log_true_size and the put_prog label. (Alexei)
* v2: https://lore.kernel.org/bpf/20261019153628.15912-1-leon.hwang@linux.dev/

v1 -> v2:
* Add log for invalid prog type in link_create().
* Reject log_opts for fallback bpf_raw_tracepoint_open() in libbpf.
* Report log_true_size as 0 before creating concrete link, and report
  the actual log_true_size when fail to create the concrete link.
  (Sashiko)
* Add stub bpf_log() when CONFIG_BPF_SYSCALL is not set. (bots)
* Check 'extack._msg' before adding 'extack._msg' to log buffer.
  (Sashiko, bot+bpf-ci)
* Change __bpf_sys_fd to __sys_bpf_fd in the subject and body of
  patch 4. (bot+bpf-ci)
* Move OPTS_VALID(opts, bpf_link_create_opts) to __sys_bpf_fd(). (Sashiko)
* Move bpf_link_create_log to the LIBBPF_1.9.0 section. (Sashiko)
* Update patch msg with a concrete case in patch 5. (bot+bpf-ci)
* Factor out helpers to simplify the tests code. (bot+bpf-ci)
* v1: https://lore.kernel.org/bpf/20261017142649.51047-1-leon.hwang@linux.dev/

Leon Hwang (6):
  bpf: Add syscall common attrs support for link_create
  bpf: Add syscall common attrs support for xdp link_create
  bpf: Retire tracepoint bpf_xdp_link_attach_failed
  libbpf: Factor out __sys_bpf_fd helper
  libbpf: Add bpf_link_create_log API
  selftests/bpf: Add tests to verify link_create logs

 include/linux/bpf_verifier.h                  |   5 +
 include/linux/netdevice.h                     |   3 +-
 include/trace/events/xdp.h                    |  17 ---
 kernel/bpf/syscall.c                          |  36 +++++--
 net/core/dev.c                                |   8 +-
 tools/lib/bpf/bpf.c                           |  69 ++++++++----
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/xdp_attach.c     |  65 -----------
 .../selftests/bpf/prog_tests/xdp_link.c       | 101 ++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          |  54 ----------
 11 files changed, 198 insertions(+), 167 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

-- 
2.55.0

