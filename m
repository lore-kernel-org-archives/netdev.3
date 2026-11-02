Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591995;
	b=klTe6n01AdL2sBMmBnnWgWcKM85MeZJT3OyJ8xfVrfmM3OHkvmCwSwfFFv79lNjZD6Us
	 434+J8RwHnjIDNx90YiqfrdP/kHJCdFDeT5uxTnwFkXjHkT2EoadXUfQECioK17CHOlXY
	 LwCQgmNQMWq+qCpSChwQvlP72dGDJ0B5ycOwHeLAx5Cf+ChMHjplpxA/RLdk2/R/FsvWZ
	 Ilaxpx8I02K2PWFnhaqHbHr7Zz5RVfIisf7XUvhOh8gN1nNqST+Ocl+OdfuHQcWhKuxOv
	 7lcY/GVwQ4KJKD7rUj6QWHQBc6FAEnAvMNmKHtTjl5oUjdNBFaOVrngRsjEp+AiWozQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591995;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WUOuof5QyeG4h6zDAvzUQGjyJrapVOdsqODDVpd/AzU=;
	b=fndk2qu9LW+QmtLY3mNV1Bw+A8/TmPynqp72+Xd2Ewd+SKHo7osuUXFwP3wh0NWR3kG3
	 1CSxB+Ex4ATQwx3r66afwNRc8YqIfmLkKe4KqERIA/AFDatvN7xTAMwbmH4LWOH/2Y/mw
	 tp7x+AGgazp1bqqmzslJkJuprT2oGdT9Rj3JxpiFJWu699F8Nt8cApxf8jv0X8A+nebxx
	 H9pBh6mnK/HatMJhzsnYFjbd2fZqI9rHjDyEBGI63YFjV9K2ZOo11imsRbpIKrESJjV9m
	 WK54NPpM002und7nIRStqxbOX22LIWG2y/voZfxTfFBcgbpZm6XNMo+m7JlVn2IGsOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NY32l9RJ;
	arc=none smtp.remote-ip=91.218.175.172
Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60651606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60651606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NY32l9RJ
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q83PV9k/7H90lkCx+6f3IVbBsobtHrsCWaMNnm1i8fs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793591991; v=1; x=1794196791;
 b=NY32l9RJ68s2x9k6GR07/i/8hKrmAWD6GObhOLhx/1wMh0G5dUkZLTN90SC4VQdjXLHWvrfy
 ArYm6qJTNuPmVkkoq2P2VyAPQDPywqjDUeFzsynd/VWU+0V58n7W1eYSKhDZOGnYMkZK9NEgJyJ
 QHQI8xhG0hIlBnGEdkijL4QA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 72094826e2f7c04a;
	Mon, 02 Nov 2026 03:59:51 +0000
X-Mizu-Trace-ID: 72094826e2f7c04a
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yuchung Cheng <ycheng@google.com>,
	Wei Wang <weiwan@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH net] tcp: initialize send sequence numbers before deferring TFO
Date: Mon,  2 Nov 2026 11:59:43 +0800
Message-ID: <20261102035943.9700-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
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

TCP_FASTOPEN_CONNECT can return from connect() before tcp_connect_init()
when a cached cookie or cookieless Fast Open allows deferring the SYN.
At this point write_seq contains the initial sequence number, while
snd_una and snd_nxt have not been initialized to that sequence number.

Consequently, inet_diag and /proc/net/tcp{,6} report the initial
sequence number as the send queue length despite no SYN or payload being
queued.

Initialize snd_una and snd_nxt to write_seq before marking the
connection as deferred. Both sequence-based queue lengths then remain
zero until the first write starts the connection and runs
tcp_connect_init().

Fixes: 19f6d3f3c842 ("net/tcp-fastopen: Add new API support")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
Reproducer:

#define _GNU_SOURCE
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <stdio.h>
#include <sys/socket.h>
#include <unistd.h>

int main(void)
{
	struct sockaddr_in dst = {
		.sin_family = AF_INET,
		.sin_port = htons(9),
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	struct tcp_info info = {0};
	socklen_t len = sizeof(info);
	int fd = socket(AF_INET, SOCK_STREAM, 0), one = 1;

	if (fd < 0 ||
	    setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN_CONNECT, &one, sizeof(one)) < 0 ||
	    setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN_NO_COOKIE, &one, sizeof(one)) < 0 ||
	    connect(fd, (struct sockaddr *)&dst, sizeof(dst)) < 0 ||
	    getsockopt(fd, IPPROTO_TCP, TCP_INFO, &info, &len) < 0) {
		perror("TFO setup");
		return 1;
	}
	if (info.tcpi_state != TCP_SYN_SENT) {
		fprintf(stderr, "Expected SYN_SENT, got state %u\n", info.tcpi_state);
		return 1;
	}
	printf("PID %ld: deferred SYN_SENT; no SYN or payload sent\n", (long)getpid());
	fflush(stdout);
	for (;;)
		pause();
}

`ss -ntp state syn-sent` will show a bogus Send-Q number, which is the
initial sequence number interpreted as signed 32-bit:

Recv-Q          Send-Q                        Local Address:Port                      Peer Address:Port          Process
0               -1405690727                       127.0.0.1:57290                        127.0.0.1:9              users:(("a.out",pid=63363,fd=3))

Diagnosis and implementation were assisted by GPT Codex.
---
 net/ipv4/tcp_fastopen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 6dfe40322fb5..ff81e663ac61 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -545,6 +545,8 @@ bool tcp_fastopen_defer_connect(struct sock *sk, int *err)
 
 	if (tp->fastopen_connect && !tp->fastopen_req) {
 		if (tcp_fastopen_cookie_check(sk, &mss, &cookie)) {
+			WRITE_ONCE(tp->snd_una, tp->write_seq);
+			WRITE_ONCE(tp->snd_nxt, tp->write_seq);
 			inet_set_bit(DEFER_CONNECT, sk);
 			return true;
 		}
-- 
2.43.0

