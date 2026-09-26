Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A52C3245
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382352; cv=none; b=gDjRlKXgAg7zaG+7/SoMN2uIjjGnX9gsKa58xjOfnlNNs/VJFnJmSDibUYbG2HZnTbqgN9XxQXE4i845eOjknnXxIhL2reP3IPtt19G3oEscqZwwb0v4Wkxn3qrdArlqSFPZBGQEFwUCvtFLCfsqzAjLTSJJm3NBzPbPbXxoRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382352; c=relaxed/simple;
	bh=/Mu3w2jQBiIHYuFu8Cha441MPHRbnx5oDHIcEBZPBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3Rdkhh5WyyG0Op429TPrqydPVb1ErFznH0Y5TJ9ATWkaHZ3LwjS85g+7CwQCui7hrD2YI1JZdEm9fD08p6MvrbP+1tXZdiA8JABAUW+h+GK1gMfGPHkuOYchfrcdkI4jyvXXMpRTXf9K7CD6XcMCJ1EOncDIBdTXT0uA52jWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=P8K4VlC4; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="P8K4VlC4"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-8177a7fc354so785277a34.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790382349; x=1790987149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1J+/zQedi5eF6J23GPJBHeiL0pHDNjhHH/yQd5LiPlc=;
        b=P8K4VlC4678u/1t5+I2FQi90ruagXYBNLy5BaNtOXrdoSa4UZdmnwPtJFcQg7U9YGH
         xbm4nshIBOd209s5sk1X98jawwsLequJk+BTWBsWrqTirZAJn8dh0QcW7IwGSMnSVBKp
         Ec+Fiwvq1XziWsMf4aVh+pXn5pq2y//7SZ8eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790382349; x=1790987149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1J+/zQedi5eF6J23GPJBHeiL0pHDNjhHH/yQd5LiPlc=;
        b=mms8sKUY+xaRWbAcVvUH362qMv2QVUme5onjDlZEk+f8T/AOjYOkgCNSuZEuqbNGYv
         jUR0XoUCxJudMunq8EtWuB+2eGmPWQ300o2mnw9j5+OfFRh99Mo9fVAVJQXqUUkGw7e7
         /s04c4EkMSbujPNeubmDGpGoKFRrDepDV3iJweY5gzx+3bM2Gvn3KlgQCxGIpBCSF1sk
         Y/PGmPOAg+kl8GTJADU1hzP5Be3CYLctTaz0MHmdQhb95cNZReyGMxOdyqx+88Kl8ABq
         4XmVIbtExavpKKSLLpJu1UhcUvjCrTgPj19WAhI8iXvgdQAy5TkIgo5jQg/M2Ac3Ti/R
         UMiA==
X-Gm-Message-State: AFuF++n52jEOfUY+0llODKIcdU6k5rjCU0E26b3KA1zs2togKH/Y3JTV
	6lnAlJnUEsvsBvONwVrZr6m/p5hr8B0DFYq47yAQwneHGOQa3p3v1Ipm0jL3TviNtwOnBFEbQL5
	s1+1VkWk=
X-Gm-Gg: AYBFou2bppNFdTeropZquRiY/wLJTAAYoGldUVqnR/ZG/ADZk5kDoy4mWxUXGKE1tOW
	Q3WkZ28W8dUvpCGI+FiJNml5HRtDhw/0JAvGQvi1BPjdoIxjYFdn+8cFLY1R7HM7cJlsAtgTln/
	HPIg9glcdoXslXIGCDpnJD5Honb0QfW82cDV0dYyFYbO1JPVR7x2JctI/SmvqHXFoVonJNUKDXT
	PZ6wZJjP7JqmGx4QYutyUy8O8dWX6Vzl4iLbWRWt1wOtnBrjtgWNsBY0CZY/nMJ8+hYq+dg5zh9
	aOfqgBJxATEimmfSX3pf3IBLXOSMCcFnu8TcZq8AAoxrHazWqygFqHnfYlIpiGlWZfE7FoC3JxO
	xfnBtLDV/4zn/LY7GERUk1lD96E3auZ6YOBkAHLPaErGlS01PwNhP/GZalUBVg4GA5Zjf9nehHo
	T4whj63pTfuf5EhOOGWcbKaaq57SQY6eFdpe7aMEqRqcM0X1m4GfcoAJKyEdevDVvyswIQ/Q9bf
	U9SsRAtS8lCIeeAa8or8wjG7oiupZH34Pa/x90/dNOjAYk8g5+DZ/L3ORuoV8PO1Wo7v4f5PbTP
	OPA=
X-Received: by 2002:a05:6809:2db:10b0:4e0:1d24:cec0 with SMTP id 5614622812f47-4e01d24cfdfmr1993185b6e.8.1790382349272;
        Fri, 25 Sep 2026 17:25:49 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbf6209b83sm3357499b6e.10.2026.09.25.17.25.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 17:25:48 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>
Subject: [PATCH net 2/2] selftests: net: packetdrill: test RACK after partial undo
Date: Fri, 25 Sep 2026 17:25:23 -0700
Message-ID: <20260926002520.42955-6-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926002520.42955-4-nramaswamy@openai.com>
References: <20260926002520.42955-4-nramaswamy@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Reproduces a partial undo bug where a segment is unmarked as lost but is
never returned to RACK's timestamp sorted list, which makes it ineligible
for future fast retransmission.

Signed-off-by: Neil Ramaswamy <nramaswamy@openai.com>
Assisted-by: LLM sparse
---
 ...tcp_partial_undo-restores-to-rack-list.pkt | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_partial_undo-restores-to-rack-list.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_partial_undo-restores-to-rack-list.pkt b/tools/testing/selftests/net/packetdrill/tcp_partial_undo-restores-to-rack-list.pkt
new file mode 100644
index 000000000000..c07a2f8a5cbd
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_partial_undo-restores-to-rack-list.pkt
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that a segment unmarked as lost during partial undo is eligible
+// for future fast retransmission.
+
+`./defaults.sh`
+
+// Establish a connection with a 100 ms RTT and a 1000-byte payload MSS.
+// Linux subtracts the 12-byte timestamp options from the advertised MSS.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 20000 <mss 1012,sackOK,TS val 1000 ecr 0>
+   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 1000>
+  +.1 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 1100 ecr 100>
+   +0 accept(3, ..., ...) = 4
+
+// Send A, B, C and D, then E 47 ms after D.
+ +.01 write(4, ..., 1000) = 1000
+   +0 > P. 1:1001(1000) ack 1 <nop,nop,TS val 210 ecr 1100>
++.001 write(4, ..., 1000) = 1000
+   +0 > P. 1001:2001(1000) ack 1 <...>
++.001 write(4, ..., 1000) = 1000
+   +0 > P. 2001:3001(1000) ack 1 <...>
++.001 write(4, ..., 1000) = 1000
+   +0 > P. 3001:4001(1000) ack 1 <...>
++.047 write(4, ..., 1000) = 1000
+   +0 > P. 4001:5001(1000) ack 1 <...>
+
+// SACK C and E together. RACK marks A, B and D lost. D is old enough
+// to be retransmitted, but this ACK reports only two newly delivered
+// segments, allowing A and B to be retransmitted while D waits.
+ +.12 < . 1:1(0) ack 1 win 20000 <TS val 1280 ecr 100,sack 4001:5001 2001:3001>
+   +0 > P. 1:1001(1000) ack 1 <...>
+   +0 > P. 1001:2001(1000) ack 1 <...>
+   +0 %{
+assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state
+assert tcpi_lost == 3, tcpi_lost
+assert tcpi_retrans == 2, tcpi_retrans
+}%
+
+// Deliver retransmitted B and then the original A. D stays missing,
+// and we ACK through C with A's original timestamp, which is before
+// retransmission started. This triggers partial undo, but D should
+// remain eligible for fast retransmission (critically, the timeout
+// retransmission counter should be 0).
+ +.07 < . 1:1(0) ack 3001 win 20000 <TS val 1350 ecr 210,sack 4001:5001>
+ +0~+.05 > P. 3001:4001(1000) ack 1 <nop,nop,TS val 450 ecr 1350>
+   +0 %{ assert tcpi_retransmits == 0, tcpi_retransmits }%
+
+// Acknowledge all five segments.
+ +.01 < . 1:1(0) ack 5001 win 20000 <nop,nop,TS val 1360 ecr 450>
