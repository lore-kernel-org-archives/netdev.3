Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4D3DAAB8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522100; cv=none; b=UbT933+5bJrnohGflxlfYsTuUUNq/KU1wjT5HdbGitHcvadM7k5QO/eybvPK4xtyT1OzevBTx9jL/AjGsX0GLsFCkDOFNlyuRCqSdr9huFOILvBBQ5U8UR7/Ek79h0dH3ITc+l2x6aZ6Cs303/s+WFcMAVJaStdL9N2ZdHsLYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522100; c=relaxed/simple;
	bh=2aOVtGKiBak+YEir9vGEflIXTY/GKD/mvSiVxOknZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6+QfiVk7R3HuG9egspSubLgA1s7xIizNlvpH+YTs4UOVeFxkvMPY0skPBFrNeaoQmUtearkZgRrNecV+G//VwthL/l/b+OApuxzpFsSmt6OEZBdDt6YM2+Sktips0+Q51wEXNSWovrOYOokOI3DohOrvM99KRd2wEkN36tB/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=MgLGgqMd; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="MgLGgqMd"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-451a49abd8aso3897722fac.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791522097; x=1792126897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNccfgSxjshaBl7aTQNEsVLhpMSJOchAidbbwac3i2I=;
        b=MgLGgqMd7s8eaBFTHr/8Sl92WVRbdwIqnwduMfDbG5pAYuDs+RQVw4bg9+ao8utSJv
         DZ/LWX1stxVpp0xIVA1QVDHlDfsFnZT9jOkzmhbYW6dLy6ZLae4I36xl+WMwr2FA1OG4
         dtSiFjn/KEdaKXmi7kTdV/aSOQhqs+ETs5R30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522097; x=1792126897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNccfgSxjshaBl7aTQNEsVLhpMSJOchAidbbwac3i2I=;
        b=q6LzjlLCRvKq+jfpRHn8N9ZvyooUtPXOtz4ZkTpjmQrgczbNgCELyFSXBn3WdnOtcJ
         XOvR5/jyVa6mJulpxlPpxu48xgjZh788TDyXw7QlPtz7kn+8b+3zQzwZwPN0fb0iBs5T
         nIRpCk7gQw00XoNxoinbs1f60qR6ajT+ZzXK1/SkrpAi9f+3Q+6hWgXkdszXyFlzfk3d
         LFsbsxbPGT/M8/camvFvCiJU3cSVcEKVsFQMVCnVkB32QOAPLU598drBnIRbYi3mhKOM
         L49Dj3yiCZh9qKUyxU3mcmwGnVuTNgqHQGPqQy+ItDt+TLAY6a5ka3BpZ8AvSafK847Q
         nHPQ==
X-Gm-Message-State: AFuF++m26JTWJm4ZsWeBZkcORhRYGT2DiNjr3GtLmDX+7+rQrCkugZf7
	4Ny4U9LDEeJn8rQK8T9g6VXmzKhUV9umYkWLCh5eadIvyxqc2P+tQn7K8XF90ZzxF7hlwbRrSLe
	qW94mm4QSTA==
X-Gm-Gg: AYBFou25pCWDFhawE3fXydItiXjJ6dD9TUhYlYLKAbHP8UqnWR+1xnLLGiA36MDJ+Mw
	3ZTN3wRC2ALhhplypbFb1xLGxxJ45ROLnyNdGL2NWqBGe0ABNbpVr8sHE2MCpgMNfM7i2C0JNsf
	JgCs5skc68s+Pg0WD1uCvmtxFAMBOVU9EmZZSrSWcEyjf/ndT17nW/i9fqIKnN3iXup1gZBRwKq
	1OF/+KXcCM3Y0X8pTl7GA+0Nh2vhMWZoSvsrqcZ6eXP8+ZrhRrPnzSN9AEQpFS9k4V2An/aeRK/
	usVnuryKZ6USTduAdHDjgxfM61fFLmsN/Pz9YfhFykHvnJZ3ZGmwDRVAz7dWtsuNQ55c/ryNucG
	7tIyPdyFRehfstnwXWUXc6WSKQ1r4iyni5d5NO0lwseNb1IjkPipSgyUTtIXHmbpgVRokGLWlXy
	vfC4DkFcQjA0UCmPJ4zCuWoJKS/RDKE7Fxsw2ywq7QRR7znIYRQFxdFlLTCO2ZGbfbyDv2I8ksn
	RtCUjaZIoBd65p2SYHVtI8aecUUiqz8arHuRPoajUm7w49ep2Ck2eSfYHWm4iJbfhaYeCPdcBnw
	AQk=
X-Received: by 2002:a05:6808:50a5:b0:4e8:2150:299 with SMTP id 5614622812f47-50c50f2ea06mr735024b6e.23.1791522097155;
        Thu, 08 Oct 2026 22:01:37 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c1246cbsm944574b6e.18.2026.10.08.22.01.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 22:01:36 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Neal Cardwell <ncardwell.sw@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/3] selftests: net: packetdrill: test RACK after partial undo
Date: Thu,  8 Oct 2026 22:00:33 -0700
Message-ID: <d0c538a03fb1cabd090927cb30a3b78fb485ba72.1791506907.git.nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791506907.git.nramaswamy@openai.com>
References: <cover.1791506907.git.nramaswamy@openai.com>
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
index 000000000000..e37e1e679e02
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
+// retransmission started. This triggers partial undo, but since D
+// is not EVER_RETRANS, partial undo should add it back to the RACK list.
+// Critically, we test that the RTO retry counter should stay 0.
+ +.07 < . 1:1(0) ack 3001 win 20000 <TS val 1350 ecr 210,sack 4001:5001>
+ +0~+.05 > P. 3001:4001(1000) ack 1 <nop,nop,TS val 450 ecr 1350>
+   +0 %{ assert tcpi_retransmits == 0, tcpi_retransmits }%
+
+// Acknowledge all five segments.
+ +.01 < . 1:1(0) ack 5001 win 20000 <nop,nop,TS val 1360 ecr 450>
-- 
2.55.0

