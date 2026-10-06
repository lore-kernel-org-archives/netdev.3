Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930638E5DC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791263794; cv=none; b=OEKeyK9ZJCWXkjYORv0AyZAxfFBtZHgqcE4AW1w9MuQypKoyRmr9rU7Z27Wu9GZjdzNgwBvPyTFs0QOF3+Q5zqqvlJXukq+siBdxneAicoMcHuqRlKQCSpNBmwhxM8/ikZUamyqhM2jJMAED6fxoCj5WsTGPk1IhrXCT9qHgljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791263794; c=relaxed/simple;
	bh=ySsNflPIiVU4e/VJAHgT4i2UWfIvcR8w6R5BsUuP8Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FptfNsIklLYVr8N3p5ekTU/QGGpHYxVHuPGH1UlfsI937CyyAn+HiYnlsOJlRx3HqheFLCAe3ae3o1Kwi0X9+bUlH8bJi7eMg7SyYyuW8tH2VgHi1i8yQf/QzNvJvV0zOAU8JDjk5Vy2faqGP6OvI0jgnYXTaHoocW1cR56Hsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=G/zP6Qsc; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="G/zP6Qsc"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-82621039b6bso1225419a34.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791263791; x=1791868591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aSQ/O3PgDhZ9woaoobq33A5AiSuAlUPvQPd+XWa5fU=;
        b=G/zP6QscprRwchv8Fm5FJu9YQeilgUg6NfiX3JQ9w1p5NdA1eo5dfEwLHKREqpWA0d
         KgpFrJokUaRD1WzwampmmDkB/rsKq6fVdx14LY2bSf1G+4usPp+Tf2jElDYkbOXdTD4X
         Ll6RMeXyMabb2+45+PxQzef68Md4cx9Jym2Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791263791; x=1791868591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8aSQ/O3PgDhZ9woaoobq33A5AiSuAlUPvQPd+XWa5fU=;
        b=RGZSnA3pzMgpSqaq0u9g0mDHiH/Pc2JRylR/7m4Xs+cEC+KNd9C2rPN7C8mY4Xuwu6
         pgkMVvaAlx2OtsbQtBzL7qxCRcoWwWKkEvtyPYx1WAkOTYhU4Ay5ZZEeii37TZVZgTJH
         sMU7xelzbPPsAq9JrhW1tm9zZp/mi7+xWSmfQaMzX+dV71X/llnzv6MnQ8Y643sE6BkV
         OMWjsD/PHuo5f5bSKYhJh2ymryUXOH/yvnWXiD7WvIoauVFvYDaXMUDkhWl+SP78f3ZY
         4QAebENi/y5YnmIGvUqyqbx6hRMFOg6iFUH7wfozaujSke+913WjvGJPv/dtAXvuVWXz
         en6g==
X-Gm-Message-State: AFuF++mdbb7Q66em44BYBd7o1iC/xaojMCtsspubvKyj4v/k+KFaJlLN
	58LnE2HoxBDN7osM4W1pfqOaCpqlJ4NLrPYUfYFrrUVWLFmF1SgUni+cFe9YdeFCmCCb9/m4Idf
	K3GwGEy09wA==
X-Gm-Gg: AYBFou26dHmgwpAGS+Cr+6MxsyknDiMoonw6UmN+2fqVzXzYsCoYCBTYj7u8WA4cQfA
	NF2nb34OcGBAgQNdtleDLdfjOfzsUf2/l3CutGAjk2YdbPcemk+xM90qY+mBA8Q4PoUQSgO2E6h
	/g93Iug34ZSfEFqYEmsfOABenm2jq4QC2YX9gqoObN0PBN72yVhe+9akOZjWcPIBa4/K6d6NFhj
	m7m2/skivZHCvJ/Wc1/yoO5bbVoDNKIIWnA3s0puph5mlp6hQdBvmgZ1JwxIo9fPl1vlOiEeq0s
	fl2smIaenB0w+upcnNEjrTHWCPinkCk4xcsI7pbS9+QqTc2hN3eAAEfEwJNDHgXN91zktmc148j
	Cnho0WaZoc7xekspDTHMLGCCqrFH1MfoTW+Oa7LYZ+1AKbF4Vf6U5uYg3eC20GorVdV+zfajFqM
	EXa2N12RMY4WQdGJdHRNnxgMNcReX8croPBFeK+8NGq+FVj8ZtwJZUwEz1SxDc6VJVK4Ifmpve1
	rii9r9QKgKUVso1F0znIQnqPysB5/MkkpCxQPbtyiiSFHk3gOp26vPTp2hXLgtZkPCmfweMCO6C
	M7s=
X-Received: by 2002:a05:6830:6d2d:b0:81f:22fd:6ed5 with SMTP id 46e09a7af769-828a264ee0fmr220570a34.21.1791263791527;
        Mon, 05 Oct 2026 22:16:31 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8281fcce238sm1622898a34.6.2026.10.05.22.16.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 22:16:31 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
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
Subject: [PATCH net v2 2/2] selftests: net: packetdrill: test RACK after partial undo
Date: Mon,  5 Oct 2026 22:15:27 -0700
Message-ID: <79f83ccbd303db0a3d7c7afa5c94c7817549bd9c.1791248202.git.nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791248202.git.nramaswamy@openai.com>
References: <cover.1791248202.git.nramaswamy@openai.com>
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
-- 
2.55.0

