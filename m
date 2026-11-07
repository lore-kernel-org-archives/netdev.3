Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095846;
	b=Im3IRmeG/Du9Ng6/JSfBKwpLAUMXg807ABDxX2FCMribOqoanH24AWM4f0919qZ3tps6
	 rko/Od03Mv4kIleNCqYmpM79rs0bDU/n8pcE5ZxucIr6YhPEYPRBmpiTyOqLQy1hhroMv
	 Smzge+MHeDymvb7CR1+Zk9rOTbDifSu7AAaHILJg+oSkh3EW2LtJlGAThEoW7Hra+KoRy
	 t/c5k/8NQwVUbyFHiOrHAt5GMFTPj+Ejkwvjc/Bu9AK/VxHVXARLg0/KR9HCACxWPAES7
	 SziqMi45qqH6VKo/GisXc3kHUTuzrfGBfYakouU9flyhDNuJHIiRMwCmdcNdaC5qK2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=1XwejjBhAzFQnbN58N4Zu+3eojFkK9VxtFw4iuM3dMY=;
	b=w6cjAJkLlcLsgV5OuQgaePtd4lW6tjQ2QSo/ZSDJg2zomrgDxU4dFRzkYj+VvLZLycxv
	 eiF9lJkGWj1ANVhVMWRW/Wt3RFM1LB/KCFW6m0Y9gymTFy8j84S7JDu7lFLoz7PZaNLiF
	 kXgCFuyuLloJrppHvmHSO8uV03SlPWz+puibDEbm8mdxXCp5GmKOSb4imtET2t0Ma02wk
	 ttvbZJs3Htc3GGiDTFl6VGkeg3aC1SmWJDWkdgz+rWkR17ROL2ZbcfMqFfQ6Ys4JSnAnR
	 lDuCFNIl5ZS+puP/n8I4XjeP96UL5r4kiR+7dxwLOVd2UC9RouXXucf5YGnCjV3jI8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SR5yq94M;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93269606A334
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 23:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93269606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SR5yq94M
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eb2437d752so1339815ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 15:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794095845; x=1794700645; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1XwejjBhAzFQnbN58N4Zu+3eojFkK9VxtFw4iuM3dMY=;
        b=SR5yq94MxbXcFny+Xi/s1nQQZ9CfimKWDRWqpNOQu6lZJ7BCoJ0yTiZ07ejTa8RQFk
         3MJQwif++0q+U5ZQ9WnvP69GtaglaxQ4woSFr4GuF8Vn8ZzmbI4LHExBgpcR8g0Bgy+N
         QU1wfMchBEPditbwD13qVvjzUo7tUNTbuJRkgIThTO5F/aPZ50makCmNipkq+pMtR2wz
         vLxT6s5ijEP07cGaohBh9hnnUYhqIzDU4xtr+DKkG6Db0PAXy2WlzDLKQiumdMQ5f0c0
         sMVhpw2aI1HbYVf7paASoJ4FrEm+/eDLBlPPToUtr8BgbZxcc6YoHLnFrQZaSFZf/6L9
         zU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794095845; x=1794700645;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XwejjBhAzFQnbN58N4Zu+3eojFkK9VxtFw4iuM3dMY=;
        b=nKI0JX1TjeVxYPQzhvkRD4WURb4lrtycR07cG93r9qf9bY4XeZfRR7AMZKc5xDLn6R
         7FsgXan80k9ymvhGKaI20ZXpKUKu53/jKKrW3rE1drzAJ3dcx2vUz+QgeYOjh9tOrpsz
         WrNWxnCUPU5pBFXyVQcSrU9HbDVxed4SIPzQlY4ALZERDkEOAx7V3lnXh/xrT184hyLg
         2UnAd59xZVFSpW3KcqAN+fhkI0W7cpBJy/+6z4XLogiStU59iLws/8cYNp0dRFRhfkpm
         2NE9izzQFBD3ECrRddFqJFvsureXSD7ZRNPdhN05/2O7CmtGIjwBguMbt0k5q/Ic72o3
         Y4gQ==
X-Forwarded-Encrypted: i=1; AL+hErFq1/4gjvwpR7KNszpZ2QVTjy3Pqr1J41qcOpUuvEqKIxQGe6d3xIzBUaU68BXqbIMhx+sdWJ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/reLYunifwARbme3nKfVCsU5Z3MGr8DM2zz3rX6g3NJkii7y6m
	Zpwi6xAeRGi1GqrtaeieXFZjeTTs5Tn5+FSqXvgksffFb/vy43UPjIDEbTMId4XRR2VNbNUqpXz
	jYMELhw==
X-Received: from plbmf12.prod.google.com ([2002:a17:902:fc8c:b0:2e9:544a:42ca])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2ea:a2ea:5f62
 with SMTP id d9443c01a7336-2ed83772738mr1451625ad.24.1794095844679; Sat, 07
 Nov 2026 15:57:24 -0800 (PST)
Date: Sat,  7 Nov 2026 23:56:10 +0000
In-Reply-To: <20261107235720.3129212-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107235720.3129212-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107235720.3129212-4-kuniyu@google.com>
Subject: [PATCH v1 net 3/3] selftest: packetdrill: Add test for DEFER_CONNECT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcp_fastopen_client_defer-connect.pkt does the following:

  1. create a socket
  2. connect() + connect(AF_UNSPEC) to let packetdrill
     remember 4-tuple
  3. setsockopt(TCP_FASTOPEN_CONNECT) + connect()
  4. inject a forged SYN
  5. check sk->sk_state
  6. verify sendto() sends SYN

Without the previous patch, incoming simultaneous SYN is
accepted even before outgoing SYN is sent.

Before:

  [   27.941419] TCP: tcp_send_synack: wrong queue state
  tcp_fastopen_client_defer-connect.pkt:35: error handling packet:
    live packet field tcp_seq: expected: 501 (0x1f5) vs actual: 0 (0x0)
  script packet:  0.004460 . 501:501(0) ack 1
  actual packet:  0.004450 . 0:0(0) ack 4294961618 win 1050
  not ok 1 ipv4

Or if we remove Test 1, we can see ICMP is accepted:

  tcp_fastopen_client_defer-connect.pkt:33: runtime error in sendto
    call: Expected result 500 but got -1 with errno 103 (Software caused connection abort)
  not ok 1 ipv4

After:

  ok 1 ipv4
  ok 2 ipv6
  ok 3 ipv4-mapped-ipv6
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../tcp_fastopen_client_defer-connect.pkt     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_defer-connect.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_defer-connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_defer-connect.pkt
new file mode 100644
index 000000000000..e90df498d935
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_defer-connect.pkt
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that a TCP_FASTOPEN_CONNECT socket in DEFER_CONNECT state
+// ignores inbound TCP segments and ICMP errors before SYN is sent.
+//
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
+
+// Cache warmup: send a Fast Open cookie request
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+   +0 < S. 123:123(0) ack 1 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
+   +0 > . 1:1(0) ack 1
+   +0 close(3) = 0
+   +0 > F. 1:1(0) ack 1
+   +0 < F. 1:1(0) ack 2 win 92
+   +0 > . 2:2(0) ack 2
+
+// Test 1: Forged SYN during DEFER_CONNECT
+// connect() + connect(AF_UNSPEC) to let packetdrill remember
+// IP, ports, ISN to inject a forged SYN
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 connect(4, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 connect(4, AF_UNSPEC, ...) = 0
+
+// set DEFER_CONNECT bit
+   +0 bind(4, ..., ...) = 0
+   +0 setsockopt(4, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0
+   +0 connect(4, ..., ...) = 0
+
+// Forged SYN should not be accepted
+   +0 < 8080 > 8080 S 0:0(0) win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6>
+   +0 %{ assert tcpi_state == TCP_SYN_SENT, tcpi_state }%
+
+   +0 sendto(4, ..., 500, 0, ..., ...) = 500
+   +0 > S 0:500(500) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
+   +0 < S. 5678:5678(0) ack 501 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6>
+   +0 > . 501:501(0) ack 1
+   +0 %{ assert tcpi_state == TCP_ESTABLISHED, tcpi_state }%
+   +0 close(4) = 0
+   +0 > F. 501:501(0) ack 1
+   +0 < R. 1:1(0) ack 502 win 0
+
+// Test 2: Forged ICMP error during DEFER_CONNECT
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 5
+   +0 setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(5, ..., ...) = 0
+   +0 connect(5, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 connect(5, AF_UNSPEC, ...) = 0
+   +0 setsockopt(5, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0
+   +0 connect(5, ..., ...) = 0
+
+   +0 < icmp unreachable [3:3(0)]
+   +0 %{ assert tcpi_state == TCP_SYN_SENT, tcpi_state }%
+   +0 sendto(5, ..., 500, 0, ..., ...) = 500
+   +0 close(5) = 0
+
+`/tmp/sysctl_restore_${PPID}.sh`
-- 
2.56.0.455.g6c5a503b38-goog

