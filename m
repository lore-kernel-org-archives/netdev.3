Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628871;
	b=hp7iD59DItXkc8TiaYXjGj2ZAwVMKLZkX9g1/t23EHeoimahWNCCHLQi1TevsOEowZmp
	 ksat2jsuKarauw26eT/uHVmbT8weLVJRVQf5pYZjp/EFeNyRU4XW2IVnpyB9OTh1s/60q
	 +nFqtN+wuPVNBh4+6g6mRP+MyQ5T3L45P2KSey5hLCWGW1nP82/9d7QORv+tYR/e9gxfX
	 6gpVOOPUGAovBI+nfAiXRmRBo+CSGkaSAGmfZY6J+kbor9UgrZX8nwIttkwS4k0E/HLZ1
	 tmjudLcQCx1GwLEW9H1BH5mz7Zb/WBmzKox05bzw1pnk0t4XU511UjD47OnX1HzcsgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OEFLWV/jNzEhHP9ltrmzYG75eB3RgpJ5WuUSRLn3T7E=;
	b=gFeMUMVkwiSwq4adVsD+1j69PyxPKuBPG2QPjUtfjZck2b+aK0xPaq3NiKcYHdIxeOQh
	 sZjP5tVywnMhPA4Kmkh9nuZCchTpnU0VWGQW4MVfSNPg4SBpVXN9q8qxrs+1oYrf78PYt
	 C6FRRRP7awXHIsvjjoASKCkH6sk6qWG+Vig2QBPaaqhIw6lJaz7fKg3kupfw9cf5443ES
	 paCIy81p2jPd0J6Eqb/AgHZVSqm+RPBEw8VjEHBUry8RIujKzONLUxKb8O734J6VLaZJC
	 6wMBAQk5dS4SFS+qAYcxCyhYO9qZJOUrMwFcot2lWfi2T1Aq+qiyoPfBKljzj2VUGYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G8uL1wb4;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D5606A8B4
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C41D5606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G8uL1wb4
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b647bbf8a9so1970302b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628870; x=1795233670; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OEFLWV/jNzEhHP9ltrmzYG75eB3RgpJ5WuUSRLn3T7E=;
        b=G8uL1wb4Lz4MJvzrzwKe5jZ6/FKTKCEOy+sv/uNaoATOflWuR0FS4dsWxc8MMilJ+k
         kmnzVKKQAZ8KGtCbjEi80TlKWvvndaiRGKXAuClpNggh8tCblUh7GDDsUiSGpwf5X2Hf
         O8bUmgjO3s/m7Nm8EF/jpjOh1oF452UjDCWuEPa8AKIyr/iIo+KpfOFTKme+soVkOfa3
         yy3BRUpPD6aAZs4HkxM+/Hm6rqWiqSzmYbWeA7L4MuZMaHlJQUytAgYIvyY/y18ll7Ui
         ANeRh7FXqysVlRv5KKjWiPtfnWCMLhxe+QCESaHVH6Xnydwzc3jQF2d5Sde2Z69NMknr
         E2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628870; x=1795233670;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEFLWV/jNzEhHP9ltrmzYG75eB3RgpJ5WuUSRLn3T7E=;
        b=EOwyYSlEy9mmHo2wDM7H9e/za3EProWfFvLPvPerYdU3ZBe6gnQcHR9crxpuivHQho
         8DEbq0zk3S2dGymJqEoa1l9DlnGn+YHEkw+8pURCy7DKp7o3eBHsBlSESMV9lYzl81tJ
         A39tN1T4BFxP3HQMLsc5e0PsJB4PmoBdZuM4e0abwtsbh+UgvXvCuiLQ5lBya45PtJ+W
         8VUeax8OLQYErMFixMF4jdEGspDfRbK/YC1JVUoCQJIqQl0NkgJYhirFw9ne+Asggt1S
         zuGCEV/N9pTelmR8K0kwY7C2Rfxum4Kf3NOSKkJ3lM0BeaL67Oio/a/dT8RdqwVagpg+
         5Krw==
X-Forwarded-Encrypted: i=1; AL+hErHm5DkOigBJdnsnZLW3mSKs9reVuqnWnl1Y/rSkw2hUindzMBq3YPtNRPqG3NNNPEDZsL/QZIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ERD+hBrUa3wxMUmAz5KWDYsc9kosDycXTXIMcDL+owNMmBDAK
	E8/HoKgF1WF5apFl9V2kHskneRTrKhCiLMrx6mQ5xGmBpza0oUZciM3CoiSy+uYbjJhtishP7bS
	ZZqh9Cg==
X-Received: from pfdu2-n2.prod.google.com ([2002:a05:6a00:c002:20b0:88e:f55:207e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a212:b0:89f:3053:9ac1
 with SMTP id d2e1a72fcca58-8beb609d4c6mr4450606b3a.17.1794628869683; Fri, 13
 Nov 2026 20:01:09 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:51 +0000
In-Reply-To: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114040101.1043546-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 8/8] selftest: packetdrill: Add test for tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() now does not collapse high-density skbs and a
low-density skb sandwitched by hihg-density skbs.

tcp_collapse.pkt verifies the behaviour by

1. set a large SO_RCVBUF
2. send one high-density skb with 100 bytes read()
3. send one high-density skb
4. send one low-density skb
5. send one high-density skb
6. send 30 low-density skbs
7. set a small SO_RCVBUF
8. send a small data to trigger tcp_collapse()
9. check TcpExtTCPRcvCollapsed via nstat

Without the series, the first high-density skb is collapsed.
In addition, the first low-density skb drags the following
high-density skb into collapsing, consuming more memory.

If we remove sk_forced_mem_schedule() without this series,
sk->sk_forwad_alloc becomes negative at the end of tcp_collapse().

Note that 30 segments are to make the memory savings large
enough so that the margin can absorb minor size delta of
struct sk_buff or L1_CACHE_BYTES across configs.

skb truesize, TCP_COLLAPSE_MAX_SIZE, TCP_COLLAPSE_SCALING_RATIO
depend on PAGE_SIZE being 4K, so the test is skipped if getconf
returns non-4K PAGE_SIZE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/net/packetdrill/ksft_runner.sh  |   9 ++
 .../net/packetdrill/tcp_collapse.pkt          | 135 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_collapse.pkt

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0a97d5ae3469..250d143bb9f7 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -44,6 +44,15 @@ if [ -z "$(which packetdrill)" ]; then
 	exit "$KSFT_SKIP"
 fi
 
+page_size=$(grep -E '^--define="?PAGE_SIZE=' $script | sed -E 's/.*PAGE_SIZE="?([0-9]+)"?.*/\1/')
+if [[ -n "$page_size" ]]; then
+	cur_page_size=$(getconf PAGESIZE 2>/dev/null)
+	if [[ "$cur_page_size" != "$page_size" ]]; then
+		ktap_skip_all "requires PAGE_SIZE=$page_size (current: ${cur_page_size:-unknown})"
+		exit "$KSFT_SKIP"
+	fi
+fi
+
 declare -a optargs
 failfunc=ktap_test_fail
 
diff --git a/tools/testing/selftests/net/packetdrill/tcp_collapse.pkt b/tools/testing/selftests/net/packetdrill/tcp_collapse.pkt
new file mode 100644
index 000000000000..90e8be86968f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_collapse.pkt
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that tcp_collapse() only collapses bloated skb runs, skips leading
+// and trailing high-density skbs, skips isolated bloated skbs when collapsing
+// them would not shrink truesize, and properly recovers receive buffer space.
+
+--mss=1000
+--define="PAGE_SIZE=4096"
+
+`./defaults.sh`
+
+// Establish a connection with a large receive buffer.
+// __sock_set_rcvbuf() doubles, so 2000000
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1000000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 4>
+   +0 < . 1:1(0) ack 1 win 65535
+
+   +0 accept(3, ..., ...) = 4
+
+// 1. Queue two high-density 62,000 B segments (each adds 15 pages of frag
+// truesize with enough margin across NET_SKB_PAD, L1_CACHE_BYTES, and
+// MAX_SKB_FRAGS configs).
+// Read 100 bytes from the first one so before(skb->seq, tp->copied_seq) is true.
+   +0 < P. 1:62001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 62001
+   +0 read(4, ..., 100) = 100
+
+   +0 < P. 62001:124001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 124001
+
+// 2. Queue an isolated bloated 1,000 B segment.
+   +0 < P. 124001:125001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 125001
+
+// 3. Queue another high-density 62,000 B segment.
+   +0 < P. 125001:187001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 187001
+
+// 4. Queue a run of 30 bloated 1,000 B segments.
+   +0 < P. 187001:188001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 188001
+   +0 < P. 188001:189001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 189001
+   +0 < P. 189001:190001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 190001
+   +0 < P. 190001:191001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 191001
+   +0 < P. 191001:192001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 192001
+   +0 < P. 192001:193001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 193001
+   +0 < P. 193001:194001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 194001
+   +0 < P. 194001:195001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 195001
+   +0 < P. 195001:196001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 196001
+   +0 < P. 196001:197001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 197001
+   +0 < P. 197001:198001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 198001
+   +0 < P. 198001:199001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 199001
+   +0 < P. 199001:200001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 200001
+   +0 < P. 200001:201001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 201001
+   +0 < P. 201001:202001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 202001
+   +0 < P. 202001:203001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 203001
+   +0 < P. 203001:204001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 204001
+   +0 < P. 204001:205001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 205001
+   +0 < P. 205001:206001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 206001
+   +0 < P. 206001:207001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 207001
+   +0 < P. 207001:208001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 208001
+   +0 < P. 208001:209001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 209001
+   +0 < P. 209001:210001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 210001
+   +0 < P. 210001:211001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 211001
+   +0 < P. 211001:212001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 212001
+   +0 < P. 212001:213001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 213001
+   +0 < P. 213001:214001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 214001
+   +0 < P. 214001:215001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 215001
+   +0 < P. 215001:216001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 216001
+   +0 < P. 216001:217001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 217001
+
+// 5. Queue a trailing high-density 62,000 B segment.
+   +0 < P. 217001:279001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 279001
+
+// Reset SNMP counters.
+   +0 `nstat -n`
+
+// Shrink SO_RCVBUF so sk_rcvbuf (320,000) is smaller than current
+// sk_rmem_alloc (334,592 on x86_64 default), but larger than sk_rmem_alloc
+// after collapsing the 30 bloated skbs (300,288 on x86_64 default).
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [160000], 4) = 0
+
+// Inject the next 1,000 B segment with a changed window to bypass
+// header prediction.  This triggers tcp_prune_queue() -> tcp_collapse().
+// Only the 30 bloated segments should be collapsed; the high-density
+// segments and the isolated bloated segment are skipped.  sk_rmem_alloc
+// shrinks below sk_rcvbuf, so tcp_can_ingest() succeeds and the packet
+// is accepted.
+   +0 < P. 279001:280001(1000) ack 1 win 65534
+    * > .  1:1(0) ack 280001
+
+// Verify exactly 30 skbs were collapsed.
+   +0 `nstat -s | grep TcpExtTCPRcvCollapsed | grep -q " 30 "`
+
+// Verify no packets were dropped.
+   +0 `test -z "$(nstat -s | grep TcpExtTCPRcvQDrop)"`
+
+// Read all remaining queued data to verify data integrity.
+   +0 read(4, ..., 300000) = 279900
-- 
2.56.0.611.g1030f0b940-goog

