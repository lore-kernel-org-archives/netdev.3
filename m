Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFD424D57
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289923; cv=none; b=oXGXjhd/20NLBRNhHb0gZdiCvk+n3C2gwVCRMAr80tXQR0+tfiUk++2tw+cg8OneP8hand/7h9+KLCH905jkPm+tYob6cltMyCXYsNAOQYebZ2FwI+pGzxCa5hgdqhjv9l+QOuII4sH9V4LYgWeqF+S1tMNsfMDo8v899lRo8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289923; c=relaxed/simple;
	bh=NePuDN/GagRxxQzM24a1ChFIy2sF05vRYKBSqljR36E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMQs9r6OKlhXkklr8YWc/Ik9s/hSaOlV8LQLeH0pcNWKRWvd2O40hB4FX9ceWmUfUtjMUR/NoHxUnjIkMgQPQ7q2WQw5VuW+2lXzavCE8zPZJUGoqhWogTn/bCLRysnkRE5B8Xt+0xldpuqWmcl75G1nMELR7ymVWrelInD1ZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ij9MblkL; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ij9MblkL"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcb5cb1so4020356d6.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790289910; x=1790894710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5LiObb8PczoN23fJheBRSuBwxtHznmlcKkljDuIqRU=;
        b=Ij9MblkLiLehosjBO28U2w5E3wkdmNDAoSeFMTcSQHhowUJdiXsvDVFlO2FDL9Ru51
         N8YNG5Xo1NezMdxF99HAxsrNb7XwrVt+4td6mJc4unAxygmp9YcAHZmTPW6F98G7yIC/
         NDhNqXmJDRAQufaVZSMZaxckpTOs0JIu9zTLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289910; x=1790894710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5LiObb8PczoN23fJheBRSuBwxtHznmlcKkljDuIqRU=;
        b=xe76Ud42m93QXdf6F/UipzxT3p21gETtsCREh+8CMJEeKvTFe0mwFNN1z37wMni2RJ
         6kXHuZxlAu/JFR0/+R0OyYP8J/GhsAxNfzjnkmPeORtblXty9T13h2ZkJP/QjLYmEEjU
         XsWkEBVrv+4Fx58uGW6qDh45KcLXAt4yPe3LVL6KsmgTTlWt6+rFcYj8Dj8kxZ5Senmf
         2OONN/5VnJDmqPhLqenBbHl1BU6DuoKTERO1AKO9KYODE+TTEOEcYWLYum6ldgrRaidT
         /F/MZ9H8URc3wJPZTONoIRs3jQZH1A9j0ULDk3RBfb50lWwGfyqycuaMVascdx8x+M/f
         wE4Q==
X-Gm-Message-State: AFuF++ml9QtSipEZKGhJKO7Cid2brIPENXWAxa97ZluGrZvIjEVhEPXh
	3MiYfRBQB3w2CzmtV9PKYk7zXesNUVQab256/M9HL2bmAn3nQl75ffHEgk1wHZyBPVq0y/CC8M4
	KyIYKlh7W+g==
X-Gm-Gg: AYBFou3J7ha3NvQb01/Z/QDw3OkRjBIdoTlkMVGoOhQXd6tQryZJV3fLxGdRR4udb5W
	ZkCdOykSKtxIzkXHdYqTDEQGFUhoD5/mxHIBSMS5Xi7OpAbjoUyIRgkCobihFQeRimYFGpgivoj
	p3EKNefcYZNl+3lNLC+XDHoLp0doXOOzrwDIH5K7y13WVke+NYTdVLrY3pXBQSmjyVSwkKuVu16
	UNjHOcevbJBIkAEGY2eOtqgvK4852MjIzB6FqeN2a/B3u+KcU7cXCQ5NSHD0sJmj/bD7Db9eg3J
	vBV1QyGcaWleplPVbRfV7EtyZtycz7umo7kTKd+XvUX4WLngt8W/cuYS0AJd98L4wDgCEPSaSYy
	YHOg6qiVn59D4AzbfECg4CtG9solvtHPyQ9QgJTz6b2KTBriTyis/GP2XghkuoPN9RSGy1cIdiT
	B5zgAtDFjJcsXynq0DYLe87gWbpRBHN48Z3mK2OeRtkUQ62nL0P72fQASOWKLwcX8K05UoPdGgJ
	u8C7B4SP3pRRC8uzjX5DFCvw0F0MOIqzqImUEWb6aIih7kYa9sigKc0toJQAdkzKZEl0rt+nlw=
X-Received: by 2002:a05:6214:2c08:b0:912:5f4c:ad3b with SMTP id 6a1803df08f44-91432234280mr4821276d6.16.1790289910313;
        Thu, 24 Sep 2026 15:45:10 -0700 (PDT)
Received: from com-94485.corp.openai.org ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e09ce4sm3858566d6.28.2026.09.24.15.45.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 15:45:10 -0700 (PDT)
From: Jeff Jo <jeffjo@openai.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 2/2] selftests: net: check timestamp echo after an old ACK
Date: Thu, 24 Sep 2026 15:44:59 -0700
Message-ID: <20260924224456.55690-6-jeffjo@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924224456.55690-4-jeffjo@openai.com>
References: <20260924224456.55690-4-jeffjo@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for a gap-filling packet whose acknowledgment has
become old. Linux first sends data to the peer. Deliver two peer data
packets out of order: the later packet acknowledges Linux's data, while
the delayed packet still carries the earlier acknowledgment.

Require the ACK that closes the receive gap to echo the delayed packet's
timestamp, 301000. Without the fix, Linux accepts the data but still echoes
the previously saved timestamp, 1000. Also check that the application can
read all 34 bytes.

Use a large jump in peer timestamps to represent the idle interval, with
no real wait, loss or retransmission. The test directly checks the outgoing
timestamp echo. It requires packetdrill's merged TSecr verification fix
(linked below); older tools incorrectly pass on an unfixed kernel.

Use the existing packetdrill selftest runner for IPv4, IPv6 and
IPv4-mapped IPv6.

Link: https://github.com/google/packetdrill/commit/83f72d3f9085d0e26eb4d206fe4d7cfab5b6d872
Assisted-by: LLM
Signed-off-by: Jeff Jo <jeffjo@openai.com>
---
 .../net/packetdrill/tcp_old_ack_ts.pkt        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt b/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt
new file mode 100644
index 000000000000..f072e5e4c449
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// An out-of-order segment advances SND.UNA. The gap filler still carries
+// its original, older ACK. The reply must echo the gap filler's timestamp.
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh`
+
+0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+0.100 < S 0:0(0) win 20000 <mss 1000,sackOK,TS val 900 ecr 0>
++0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 900>
+0.200 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 1000 ecr 100>
++0 accept(3, ..., ...) = 4
+0.300 write(4, ..., 17) = 17
++0 > P. 1:18(17) ack 1 <nop,nop,TS val 300 ecr 1000>
+0.310 < P. 18:35(17) ack 18 win 20000 <nop,nop,TS val 301001 ecr 300>
++0 > . 18:18(0) ack 1 <nop,nop,TS val 310 ecr 1000,nop,nop,sack 18:35>
+0.320 < P. 1:18(17) ack 1 win 20000 <nop,nop,TS val 301000 ecr 100>
++0 > . 18:18(0) ack 35 <nop,nop,TS val 320 ecr 301000>
++0 read(4, ..., 34) = 34
-- 
2.55.0

