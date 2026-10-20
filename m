Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514337;
	b=yXpSRP5fWLvZVZDRsH7d2a5LakTgtoHgxDRi57uQdQY5TbmAJ8L3jXfa/dgDzov9GLlV
	 kgB7MBXNgRT8MflESKQZlCalQArzHwFmdMEhs/JDGwtGIBtonX6E2bg51z9+1nRqfbIBX
	 thKPVdMJ5EOIDtIDH2dDlWvSz11iTBaNrhy21KirmcBcWwCpV/bsEioJbYCae9ueFqgpL
	 ntAYrCw+Tuu6dlKyQMlD9VjESBUKUIwZqatf1PhbnIKP/UVfy30Ut9qhZw/RNT0eMP8tS
	 iTQVvJ9YkC7ii+NRKkilu8MWFZhuy2rUZcGNDZd7VGqQT5BsC96kpu3uW9QbYBjwdWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=r6Qh0C8VZGXvZEDc2kZsxVXKMJiu5wqeD9DHYON/9u4=;
	b=JIERD0EQ6WskEhdiiDaLGCKcGTrX3wOl7p803KBlEL1yG0bdwoqCh2+DzOguAKNSXmEb
	 P/Zkq+Y31jTFrDaIWfiWubU8xlC38VBFcQ29/EshbG6iDJ1pNnn6xKGdtqmJfa/rBzMYF
	 tNfKa34xBvjtq8PAuiFJr7GMUgie5y0FnyHH6X1H0rXHThA5/6DP/m8BKSLgZ9wgrMiEK
	 ac0scjVI/JIx2OPMkGTjeKkIlma73Z0CArCveIBZ7FnmU1mCnF1bx2j/wN0A8KgQ8QJ9F
	 DqN0bkpVti/j6AgTaWnehIZkVsbsCBvso4CO8/HB3i31PpEsTPP3R2TQMPZ7hLr4FHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tavip.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KYgZ+C7j;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC22606D520
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC22606D520
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KYgZ+C7j
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a03834d8ffso4494533b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514336; x=1793119136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6Qh0C8VZGXvZEDc2kZsxVXKMJiu5wqeD9DHYON/9u4=;
        b=KYgZ+C7j3c5dwv4GHy9pr7LdM1CxrF5CNMfFJM5DOO+lPu665oZmc9mDHqjYT5XHAT
         opu2QloeTeCgpu3TqIw2bzZ5kLERLZr9fFSZTY1+8wpzkqio8CzWtdHaBlfw88ZcQNw9
         KWMy1smzR1EDbTMYIqATI7NLaKTaTsYUwdjAHrp2Zaq2m7yUM92lHDZQ4CuK3F4sLokZ
         gIj7u1DwXOXSzTZnYv4P3t6qCabBDafQeOPiQpyMtzP+g9dmr1nyJTGByso1diZIUUDo
         chHHb1QMHJjFp3JOD60p4vjB9oP+4p/X7szNga1rQ6Oj/7MRzzRzGNYTe+hvUIIfx3iu
         i39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6Qh0C8VZGXvZEDc2kZsxVXKMJiu5wqeD9DHYON/9u4=;
        b=d0kkgFLW9bNxYYZ6PZLyPi9Cz1Ih8C8HAq6x9EVjWg0g1l4kbjawQct8FnF37JfNEo
         ARI5Do5IGCuQOnBWRAV1BGmOPux/o2gjs4Ee3QOHWkM3VwEsgAJBkes8Y3eP4ey77Ip1
         ERKDPhkO0Oo4ckQz2PkEXvLe/lXE7S57o2WxgS/2EBdIPdcvXLuNT+GxM6iU1XJiA9du
         +6MtU9aFnZmuUSVz6FuhKY8TZYr5y6UBK9pZ+kKMV1MmaPl4dzp2+FaznS64Vv7Hfq5+
         SmrCkC+DQbTCv7UlcghmT7zYYhSmG7dV6FxsLM4DaooIxCBpW1xrfUNW5Q4RNOTNe2ap
         V0gw==
X-Forwarded-Encrypted: i=1; AKwUvBzr7ltQBCDfYh8kqP7L53FzQTmxevFctivqR/RbDVcSrm8OwK9ZIZmE0eGY2nyLqak6QZx1WX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvZlhAWfgI830MH18k3ghCCVXCRX6ppZ4cSaEwgwk7SifZUS/z
	gj0NYv/aaU+1ZLXt87M0f0syjAzmG7sTOqxiuC5YnWNcw9KPSVJKrVWEDWizFcP3dX1E17psTNc
	tFQ==
X-Received: from pgbd19-n2.prod.google.com ([2002:a05:6a02:64d3:20b0:cc7:d4f0:846d])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f89:b0:3d8:1f68:59ac
 with SMTP id adf61e73a8af0-3e225fe8c5cmr9977058637.23.1792514335679; Tue, 20
 Oct 2026 09:38:55 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:38:35 +0000
In-Reply-To: <20261020163835.4076594-1-tavip@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163835.4076594-1-tavip@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163835.4076594-3-tavip@google.com>
Subject: [PATCH net v2 2/2] selftests: net: packetdrill: add test for negative
 sk_forward_alloc in tcp_wmem_schedule()
From: Octavian Purdila <tavip@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a packetdrill test that drives sk->sk_forward_alloc negative via
tcp_collapse() on the receive queue while sk->sk_wmem_queued exceeds
sysctl_tcp_wmem[0], and verifies that a subsequent non-blocking write()
under TCP memory pressure fails with EAGAIN rather than returning a
negative copy length from tcp_wmem_schedule() and failing with EFAULT.

Assisted-by: LLM
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
- Skip the test when PAGE_SIZE != 4096 via --define=REQUIRES_PAGESIZE="4096"
  in ksft_runner.sh (Eric Dumazet).

 .../testing/selftests/net/packetdrill/config  |   1 +
 .../selftests/net/packetdrill/ksft_runner.sh  |   6 +
 .../tcp_wmem_schedule_negative_fwd_alloc.pkt  | 117 ++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_alloc.pkt

diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index b7df8bf309200..dc3cd72a8da8c 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -1,6 +1,7 @@
 CONFIG_HZ=1000
 CONFIG_HZ_1000=y
 CONFIG_IPV6=y
+CONFIG_MEMCG=y
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_FQ=y
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0a97d5ae34699..dcda2b93c76e0 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -52,6 +52,12 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 	failfunc=ktap_test_xfail
 fi
 
+pagesize=$(grep -E '^--define=REQUIRES_PAGESIZE=' $script | cut -d '=' -f 3 | tr -d '"')
+if [[ -n "$pagesize" && "$(getconf PAGESIZE)" != "$pagesize" ]]; then
+	ktap_skip_all "requires ${pagesize}B PAGE_SIZE"
+	exit "$KSFT_SKIP"
+fi
+
 ip_versions=$(grep -E '^--ip_version=' $script | cut -d '=' -f 2)
 if [[ -z $ip_versions ]]; then
 	ip_versions="ipv4 ipv6 ipv4-mapped-ipv6"
diff --git a/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_alloc.pkt b/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_alloc.pkt
new file mode 100644
index 0000000000000..96a5d60a52cb1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_alloc.pkt
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that tcp_wmem_schedule() clamps negative sk->sk_forward_alloc to 0
+// when sk_wmem_schedule() fails under memory pressure and
+// sk->sk_wmem_queued >= sysctl_tcp_wmem[0], returning EAGAIN rather than EFAULT.
+
+--define=REQUIRES_PAGESIZE="4096"
+--mtu=65535
+--tolerance_usecs=100000
+
+`set -e
+./defaults.sh
+ip link set dev tun0 mtu 65535
+sysctl -q net.ipv4.tcp_rmem="4096 131072 6291456"
+sysctl -q net.ipv4.tcp_wmem="4096 16384 4194304"
+cgroot=$(mount -t cgroup2 | head -1 | awk '{print $3}')
+[ -n "$cgroot" ]
+echo +memory > "${cgroot}/cgroup.subtree_control"
+mkdir -p "${cgroot}/pkt_${PPID}"
+echo $PPID > "${cgroot}/pkt_${PPID}/cgroup.procs"
+`
+
+// Create listening socket in pkt_${PPID} memcg and establish connection
+0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0.000 bind(3, ..., ...) = 0
++0.000 listen(3, 1) = 0
+
++0.000 < S 0:0(0) win 65535 <mss 36000,nop,wscale 7>
++0.000 > S. 0:0(0) ack 1 <...>
++0.000 < . 1:1(0) ack 1 win 512
++0.000 accept(3, ..., ...) = 4
+
+// Move packetdrill back to its original cgroup so only the sockets remain charged to pkt_${PPID}
++0.000 `cgroot=$(mount -t cgroup2 | head -1 | awk '{print $3}')
+runner_pid=$(awk '/^PPid:/ {print $2}' /proc/$PPID/status)
+orig_cg=$(sed -n 's/^0:://p' /proc/$runner_pid/cgroup)
+echo $PPID > "${cgroot}${orig_cg}/cgroup.procs"`
+
++0.000 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [2097152], 4) = 0
++0.000 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [145536], 4) = 0
+
+// 1. Warm up rcv_ssthresh to full window (~256 KB)
++0.000 < P. 1:36001(36000) ack 1 win 512
++0.000 > . 1:1(0) ack 36001
++0.000 read(4, ..., 36000) = 36000
+
++0.000 < P. 36001:72001(36000) ack 1 win 512
++0.000 > . 1:1(0) ack 72001
++0.000 read(4, ..., 36000) = 36000
+
++0.000 < P. 72001:108001(36000) ack 1 win 512
++0.000 > . 1:1(0) ack 108001
++0.000 read(4, ..., 36000) = 36000
+
++0.000 < P. 108001:144001(36000) ack 1 win 512
++0.000 > . 1:1(0) ack 144001
++0.000 read(4, ..., 36000) = 36000
+
+// 2. Queue 500 KB on TX so sk_wmem_queued >= sysctl_tcp_wmem[0]
++0.000 write(4, ..., 500000) = 500000
+
+// 3a. Inject 6 high-density 36 KB segments (216 KB payload, 222.7 KB truesize)
+//     and read 100 bytes from the head SKB so before(skb->seq, tp->copied_seq) is true.
++0.000 < P. 144001:180001(36000) ack 1 win 512
++0.000 read(4, ..., 100) = 100
+
++0.000 < P. 180001:216001(36000) ack 1 win 512
++0.000 < P. 216001:252001(36000) ack 1 win 512
++0.000 < P. 252001:288001(36000) ack 1 win 512
++0.000 < P. 288001:324001(36000) ack 1 win 512
++0.000 < P. 324001:360001(36000) ack 1 win 512
+
+// 3b. Inject 22 smaller 1000-byte segments into the remaining advertised rcv_wnd.
+//     Their higher truesize pushes sk_rmem_alloc > sk_rcvbuf (291072),
+//     triggering tcp_prune_queue -> tcp_collapse on the 216 KB of 36 KB SKBs
+//     and driving sk->sk_forward_alloc negative (-32768).
++0.000 < P. 360001:361001(1000) ack 1 win 512
++0.000 < P. 361001:362001(1000) ack 1 win 512
++0.000 < P. 362001:363001(1000) ack 1 win 512
++0.000 < P. 363001:364001(1000) ack 1 win 512
++0.000 < P. 364001:365001(1000) ack 1 win 512
++0.000 < P. 365001:366001(1000) ack 1 win 512
++0.000 < P. 366001:367001(1000) ack 1 win 512
++0.000 < P. 367001:368001(1000) ack 1 win 512
++0.000 < P. 368001:369001(1000) ack 1 win 512
++0.000 < P. 369001:370001(1000) ack 1 win 512
++0.000 < P. 370001:371001(1000) ack 1 win 512
++0.000 < P. 371001:372001(1000) ack 1 win 512
++0.000 < P. 372001:373001(1000) ack 1 win 512
++0.000 < P. 373001:374001(1000) ack 1 win 512
++0.000 < P. 374001:375001(1000) ack 1 win 512
++0.000 < P. 375001:376001(1000) ack 1 win 512
++0.000 < P. 376001:377001(1000) ack 1 win 512
++0.000 < P. 377001:378001(1000) ack 1 win 512
++0.000 < P. 378001:379001(1000) ack 1 win 512
++0.000 < P. 379001:380001(1000) ack 1 win 512
++0.000 < P. 380001:381001(1000) ack 1 win 512
++0.000 < P. 381001:382001(1000) ack 1 win 512
+
+// 4. Cap the socket memcg at its current usage and expect -EAGAIN on non-blocking write.
++0.010 `cgroot=$(mount -t cgroup2 | head -1 | awk '{print $3}')
+echo 0 > "${cgroot}/pkt_${PPID}/memory.high"
+cat "${cgroot}/pkt_${PPID}/memory.current" > "${cgroot}/pkt_${PPID}/memory.max"`
++0.000 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
++0.000 write(4, ..., 16384) = -1 EAGAIN (Resource temporarily unavailable)
+
++0.000 close(4) = 0
++0.000 close(3) = 0
+
+// Untimed cleanup command executed by packetdrill on both pass and early failure.
+`cgroot=$(mount -t cgroup2 | head -1 | awk '{print $3}')
+[ -n "$cgroot" ] || exit 0
+runner_pid=$(awk '/^PPid:/ {print $2}' /proc/$PPID/status)
+orig_cg=$(sed -n 's/^0:://p' /proc/$runner_pid/cgroup)
+echo $PPID > "${cgroot}${orig_cg}/cgroup.procs" 2>/dev/null || true
+echo $$ > "${cgroot}${orig_cg}/cgroup.procs" 2>/dev/null || true
+rmdir "${cgroot}/pkt_${PPID}"`
-- 
2.56.0.212.g129ede20d9-goog

