Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64C3DFC74
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522103; cv=none; b=NDGAbTDZq1X+HIHL7VpTHFd6nGAz0vNe+TEVVwnzo10QTcSADy2N88xkbbmuWlGrzVayTQptHE6UcI4SE5y9x7DM5F07URdBvY6cflFPqeGl8k+6fyN2J9ScjIxGFW5r1l96sgtjPbkkkl03O1/asGDt4BwO6CrHdFu7aMMMmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522103; c=relaxed/simple;
	bh=BmOtsxSk6laakYTGY1vhB+TkeFe46FrgReiAo1gmTcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBFGonxhIEiocaBSQXbrPf0z8kvupjpwxiO4J21Mdqf1pAHPCaWWoxgfyIFH8CEWrEVLJDZ+uba9e4fqzX+DOBqicnf+kO9LO4gj5BZmnLdenDzZkxsnoTg20enZpqIhtZTz9XHhYU5hgaETB4k6LQENI8ShzasBmknJ9PEgVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ze79Uiv0; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ze79Uiv0"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4d198f1a591so1869851b6e.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791522100; x=1792126900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ldnK09uw57VN3jHwLW73euAAgs3EKlu4n6BV+LKVFg=;
        b=Ze79Uiv0x06s/DDZGJZeQM83rAUG+DsrbQ0uX2+9ylJ1Mj5zNB3G5Y5cEC4B4RHyLE
         UtdWD1yz0erOVo/oBvLlrP8xo2IA4o6Una3peAglsgGJqogelROwsx7jXoj2NPyTl7bE
         5YJGNYfVx5kcWEBfZgSUcKEhY2MOWuSmO7giY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522100; x=1792126900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ldnK09uw57VN3jHwLW73euAAgs3EKlu4n6BV+LKVFg=;
        b=xxQJYbEYFEfdj/9GyeFYSBy6puQYL59VKjrfsXBxUb8d1xBv/+fk9uezGAKPVc/I4E
         +C2bDzY8SvLDjPCv8nQ5CYgkRjG6lRe/de63vh3uz9K+zGhVN6sbbOj4GmR5S6HFfl5h
         Z8OO+2R+KpZwl8RT+c1Gg6ebztRXRJTymBFG7T40ql2PM2z7HmYG7fLMUQkewFPWOexx
         bad4LFn6/Pf1bWFhXuPXxSOYYr63aIX7Ou4KtxHdp0+qh40TMRMstRZ5eh08AxOciRoJ
         pzcqBBQgpbjgNs8FTGdp1abrbJz+zjVU4GAe6V7A1KABv6+B2BzH8AnZZuFlqdegJYnQ
         b4fw==
X-Gm-Message-State: AFuF++nAXGJKcqeWJFgwEt6NRxoCrEomJH0UlsVdCItw/zwF5bM+AVhT
	yGDGZcv/DjJXSxLeWFC6BTfQaob0cqhDtl2DOu5V81s4DwTmy6U1qdpj7WBSgd/fHPNP/iNyLEF
	FiSm/cff1Ig==
X-Gm-Gg: AYBFou3+yANzKBDstxtqCK+qqwIdUGSp2pK65kjNjke/fAarVk2EOQDXw+AU0U6gkWQ
	TYKQJX8dkVaoGxqKGrHK1AZUHmjwxtsYWgAjiTYsrfo44n8uwnlBXHfIpIiN3dJeom8JoMcXFnT
	R41XdUJIKIn5LAXrIK/r21Y9GXJJ7JcK0p7N72cdB8jLHygvw+e0L7845AcFVw8mmke5Lbyp3if
	y0oGAqBJlw6o+Wn0Q1eHG8oRh1pIFkcEjUwmC81mTM3sY/dkLZxfBt0MPeN8E/bo3xBq4BxgPK+
	eczK2tZ3cjolq5GqROXlm8YkHMYEF6azM5SgL7T9fQ5Zt3+bI9wXmjZ/YrJPiCRMGi0KjjmIzvr
	6jVkxnxypLkLMe+107G6kPPPBxIgH2uRnhAWr0Bp0hMlXyyXE11nGzRkTnxtgDBU+ENwGHHehW2
	n7uoQn9yA+96CRwBpYsz//ZAasJqRyboH+hF3MjCgSVokeKmjM7HhX5C4OrnPlAkRlP78IvvLSa
	BVDpm9Ohm04qmujNE2lR1oqECyJmdah/ySoteDYjrqpEnVoYjpQVYT4XDoVqSILyhAT8ahUSq09
	A68=
X-Received: by 2002:a05:6808:23c2:b0:4f5:1273:14b0 with SMTP id 5614622812f47-50c59399bb4mr729134b6e.44.1791522099894;
        Thu, 08 Oct 2026 22:01:39 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c1246cbsm944574b6e.18.2026.10.08.22.01.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 22:01:39 -0700 (PDT)
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
Subject: [PATCH net v3 3/3] selftests: net: packetdrill: test RTO fallback after partial undo
Date: Thu,  8 Oct 2026 22:00:34 -0700
Message-ID: <976f8457bffbc513197d6ff5c052ca7c4bd6ed03.1791506907.git.nramaswamy@openai.com>
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

Tests that a segment that is lost but also previously retransmitted is not
added back to the RACK list during partial undo, and is instead
retransmitted by the RTO. It utilizes the fact that a TLP doesn't increment
retrans_out, which needs to be 0 for partial undo (but this scenario may
also happen without the TLP).

Signed-off-by: Neil Ramaswamy <nramaswamy@openai.com>
Assisted-by: LLM
---
 .../tcp_partial_undo-rto-fallback.pkt         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_partial_undo-rto-fallback.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_partial_undo-rto-fallback.pkt b/tools/testing/selftests/net/packetdrill/tcp_partial_undo-rto-fallback.pkt
new file mode 100644
index 000000000000..844895121573
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_partial_undo-rto-fallback.pkt
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that a segment that is lost but also previously retransmitted is not
+// added back to the RACK list during partial undo.
+
+`./defaults.sh`
+
+// Establish a connection with a 100 ms RTT and a 1000-byte payload MSS.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  .100 < S 0:0(0) win 20000 <mss 1012,sackOK,TS val 1000 ecr 0>
+    +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 1000>
+  .200 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 1100 ecr 100>
+    +0 accept(3, ..., ...) = 4
+
+// A is delayed. B, the tail segment, is lost.
+  .210 write(4, ..., 1000) = 1000
+    +0 > P. 1:1001(1000) ack 1 <nop,nop,TS val 210 ecr 1100>
+  .211 write(4, ..., 1000) = 1000
+    +0 > P. 1001:2001(1000) ack 1 <...>
+
+// With no ACKs, the TLP retransmits B at roughly 2*RTT after its send,
+// which adds TCPCB_EVER_RETRANS to B.
+  .400~.430 > P. 1001:2001(1000) ack 1 <...>
+  .435 %{
+assert tcpi_ca_state == TCP_CA_Open, tcpi_ca_state
+assert tcpi_total_retrans == 1, tcpi_total_retrans
+}%
+
+// C is sent and arrives with a 40ms RTT. It is sent after A and B's tail
+// retransmission, and both A and B have remained unack'd for RACK's
+// RTT + reorder window. So RACK marks them as TCPCB_LOST. C's SACK allows A to
+// be retransmitted as A'. Now, A and B are both TCPCB_LOST and
+// TCPCB_EVER_RETRANS.
+  .440 write(4, ..., 1000) = 1000
+    +0 > P. 2001:3001(1000) ack 1 <...>
+  .480 < . 1:1(0) ack 1 win 20000 <TS val 1380 ecr 100,sack 2001:3001>
+    +0 > P. 1:1001(1000) ack 1 <...>
+    +0 %{
+assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state
+assert tcpi_lost == 2, tcpi_lost
+assert tcpi_total_retrans == 2, tcpi_total_retrans
+}%
+
+// The original A arrives. Its timestamp predates A's retransmission,
+// which starts partial undo. B's TCPCB_LOST flag is cleared, but because it
+// is TCPCB_EVER_RETRANS, it is not restored to the RACK list. Only RTO will
+// rescue it.
+  .490 < . 1:1(0) ack 1001 win 20000 <TS val 1390 ecr 210,sack 2001:3001>
+  +.001 %{
+assert tcpi_unacked == 2, tcpi_unacked
+assert tcpi_lost == 0, tcpi_lost
+assert tcpi_retransmits == 0, tcpi_retransmits
+assert tcpi_total_retrans == 2, tcpi_total_retrans
+}%
+
+// No prompt retransmission: the remaining hole is recovered by one RTO.
+  +.100~+1.000 > P. 1001:2001(1000) ack 1 <...>
+    +0 %{
+assert tcpi_retransmits == 1, tcpi_retransmits
+assert tcpi_total_retrans == 3, tcpi_total_retrans
+}%
-- 
2.55.0

