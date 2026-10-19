Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424206;
	b=dNECeoJb3Zm58n0W06Jl6mUikknXJr4BdUombmzc8ea/m0Y35nvmhwHFjocjc9HqH+vv
	 Z7qqTG9gkIs7ivZ09HNHg9RXyWl6QV9Tp5Lf+XkywZLswOrhaYVfoU8YcuhG+wq+D1zBv
	 SNdBEsjptxoQd2MIvqu4MNe07GEfLlGX+yL3JUMwSGIx4Wzyi4ntLvLqhKtd/MCiz4h0f
	 YQoS0niW5LVjRySeZF6H3L0v3f3e90h8NFVoRNx0rU00KrUCcRCZlIomWbD774JySmXq0
	 6cWAvObSEeUzuQ09oIWiiYK+8OP/Dw5XRAv0OmILWxQvtp1UGNrxfYMHpKr4h0xX03g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424206;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UOj9knh0frr379rHSoli0b/qodvVS2OqPC7MrjigU40=;
	b=jchnFa5s+BjlIvM0p8Nf/wTQf1B/o9GT8K+0CjxPMaAUXXMSRyO8vyrmmkK9gCBbY0YG
	 e9UWxBIGWAnilx+GuapuQc9Vt+wEevxMHJGdSK7TnlrDYzkykfZY+EFKVCbmtzZtHRzQ+
	 voOboovCFGBOGtbObyc0zplwuwNFOlZloUPMHy2irUr9T+1IftfQQBqeSJ7eHLN9SMaQm
	 N0T5zn99CW/t6rBjG8A2U2Q0i06ugT9/09Utt2758XhhMcWHsXnr+pMOjeskNzDYSNkNr
	 hfLDphtQNNeDvaZqdylRHbZDK8pIyQggnmUO6qm4Xoyn7yAfTK2R1RSK9qcAy9noDhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QAv97V8g;
	arc=none smtp.remote-ip=95.215.58.34
Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD36075509
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85FD36075509
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QAv97V8g
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XDVY+hJBQ7Ezg2H1SpsrCrnN81f0MMx4M8tEPctpFHU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792424203; v=1; x=1793029003;
 b=QAv97V8gISE9gLS9YDSGh9BqdBlGkcqlufsQgDuEVuRZbstseQ0/OtUJNNOtmWLybKDBiRd6
 LOdRf4XOpPqsIQTa35rB6gAX7vuDSQH7ra4JOV5DwH3Iq4gVfFhPuH0U5XyuG3B2f0AnjiP0i/S
 cDcX6iDXucQeHhz7dn6nPbLY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 503e4b6d01360189;
	Mon, 19 Oct 2026 15:36:43 +0000
X-Mizu-Trace-ID: 503e4b6d01360189
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
Subject: [PATCH bpf-next v2 0/6] bpf: Add syscall common attrs support for xdp link_create
Date: Mon, 19 Oct 2026 23:36:22 +0800
Message-ID: <20261019153628.15912-1-leon.hwang@linux.dev>
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

 include/linux/bpf_verifier.h                  |   6 ++
 include/linux/netdevice.h                     |   3 +-
 include/trace/events/xdp.h                    |  17 ---
 kernel/bpf/log.c                              |  19 ++--
 kernel/bpf/syscall.c                          |  41 +++++--
 net/core/dev.c                                |   8 +-
 tools/lib/bpf/bpf.c                           |  69 ++++++++----
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/xdp_attach.c     |  65 -----------
 .../selftests/bpf/prog_tests/xdp_link.c       | 101 ++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          |  54 ----------
 12 files changed, 217 insertions(+), 173 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

-- 
2.55.0

