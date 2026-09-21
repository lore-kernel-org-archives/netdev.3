Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBA51EE02
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029584; cv=none; b=RzlMkqkMbRoSkwB6jMyS0ogFtpekDzrTqqET15Bh//ntyOZKlAPpLVXopFngz0ZdPxRLo6Yi80DpSlgvXQjXDUF0vjD1R4KDBYky4lkTkDzHl5FakVa36kck16+ej+OIDpmtQNwoW3rfa17el2y8CzYNs/qGjX2pdnigS8h1OKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029584; c=relaxed/simple;
	bh=GRZdBlRm1lvsE5c25wt8yPbTEBC5cBBDDLkQAdXfpWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUgLa0I2KixA0085fAjA9R3GiqxB7QC0h+yd9OlAPytaDrCaO8BdikX7kT2F3cgmFrW8XhdPMDJFZVp9G2iHu1CPIKGCmDrS/NgevQbDxaKeQhNe8eNOspTxudjhHZJZOhvOsWVyphJkysbBym5v7FOZFmClCGsCldqtE0h2+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=RRpMlZw4; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="RRpMlZw4"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cc46c4so336759885a.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790029581; x=1790634381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bneTXx7VbqxcZhk0NJHAAHTOdPB67K7M73RJR6TLrG4=;
        b=RRpMlZw4UOONWwAuGZcnkNdfUcmgdnlcyXc2JKBIIqeqOjMFTl2SEq7U7ONsos3TQo
         9o8ZENhwv+J/3VHbTewH3xZ0j8Hm1EkROYutruQdX9wD0CFFBW0j7kbvqp2pyw80i+dZ
         b20hRxhBjlRzto1gMQljF0Q5wk/MLJbE++8ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029581; x=1790634381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bneTXx7VbqxcZhk0NJHAAHTOdPB67K7M73RJR6TLrG4=;
        b=Km+qBn+OBf0id6+IDJoKAArUSn6HekQcZCLc6E+a7ELmv7NHddXGSr5TTZ/62QJCY+
         rk9VyLs5nVRqj12YG8ZPkB7uQ0zmTDn7bWJp4vGSLO3ZvA8NF9FUA9zEmUfuS5YES3v+
         MwyW6iFSU5QF5diPvAVCnnxJD9IyCRvdoy/jLRyOAE+7Xzl8vh50pR4omz3iJNOP+GcX
         LO8UGf4JrQivS8GXAhyqgjeX6C/Y8shQItP2E+KdKAB8pn7caTYYHsvK2vZoUEBYahAb
         yVD4QEyJSra8qpgWEswoMWPWKnH4VQaHqfdIf2tU9doDIg5LjdXQyQT2twPlgbs5ub8I
         gqag==
X-Gm-Message-State: AFuF++mlejVMSyEVHvFo9kE6Z4q/7LiqqgKKDuFld2wfsWyjdqX5ddD9
	TNbMCaiHK0t2mIu5IMkTArr5LcvhOzBtEwjj9fYg/AgguHSK+g2YVNlHPZK8eFkiplwHi5YzogL
	ZQ2dLEkmoEw==
X-Gm-Gg: AYBFou0DjR31PFbS3lhekwKpA2E/hSCM+/WCwNJCpF0TWfhtAetYV7B9Cn5aytk0EaY
	p2Kp+T1BhZbPcDkHn5gJicWCflBnX1lhvE5VEXH6Nqtut4nOsUu6BPbZiJlGILh78lBoVZC3TFY
	y3JXCLwmkTOQxgecP6wywqcDrn6XwqvPuS3lKslPxMBdqZTAF8zR+CqSCLGzDk8XkkXCYqpGNTU
	AotlmnS0UE0NqJwdSwfPHEg4TOlLg5mHHyV4mV527qnmURWFgs4pYSyd5a14BQCu1vIZHPiY+Sx
	XVviHzAe1xCRwZZ63sLbqedfQB5Yo0CMEy62dV1BX64m8LawWO57RXZETvZlgIKYNiYGEn7IM7L
	g61nP9wxX63wJX6lxSsmqxbWzVEW05HfLzDWOuTMIZ+8DlWJaL0tMpr0Je2KVEunbA5FZlRf1tX
	gsS7TVS0BWuWt6cocWHsOAY9r0O05thr8GSxFylugjkb26dUAfqcoqztRMnx3ZPf3BfssrStP9k
	yo317hpwhxPNiv0ol0btuVGImPmFC5Pr+h1Wk1Oa5sNQORONTLGN3mGP2YeMCqy6O8em8/SLwE=
X-Received: by 2002:a05:620a:29cb:b0:939:f522:b2f7 with SMTP id af79cd13be357-93c198e8416mr63207985a.33.1790029580644;
        Mon, 21 Sep 2026 15:26:20 -0700 (PDT)
Received: from com-94485.corp.openai.org ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19bc6f4bsm30675085a.44.2026.09.21.15.26.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 15:26:20 -0700 (PDT)
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
Subject: [PATCH net 2/2] selftests: net: check timestamp echo after an old ACK
Date: Mon, 21 Sep 2026 15:26:12 -0700
Message-ID: <20260921222609.50824-6-jeffjo@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921222609.50824-4-jeffjo@openai.com>
References: <20260921222609.50824-4-jeffjo@openai.com>
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
the delayed packet still carries the earlier acknowledgment. Require
the final reply to echo the delayed packet's timestamp.

Use a large jump in peer timestamps to represent the idle interval.
The test checks the echo directly, without waiting for that interval
and without packet loss or retransmission.

Packetdrill does not currently compare the timestamp-echo field (TSecr),
so the packet script alone can pass on a broken kernel. Add a shell
wrapper to check all four outgoing timestamp echoes in packetdrill's
output. Register the wrapper as the runnable test and keep the packet
script as a supporting file.

Run the test in a separate network namespace for each of IPv4, IPv6
and IPv4-mapped IPv6.

Assisted-by: LLM
Signed-off-by: Jeff Jo <jeffjo@openai.com>
---
 .../selftests/net/packetdrill/Makefile        |  5 +-
 .../net/packetdrill/tcp_old_ack_ts.pkt        | 23 ++++++++
 .../net/packetdrill/tcp_old_ack_ts.sh         | 57 +++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt
 create mode 100755 tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.sh

diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
index ff54641493e9..4695d8258aa1 100644
--- a/tools/testing/selftests/net/packetdrill/Makefile
+++ b/tools/testing/selftests/net/packetdrill/Makefile
@@ -7,6 +7,9 @@ TEST_INCLUDES := \
 	../../kselftest/ktap_helpers.sh \
 # end of TEST_INCLUDES
 
-TEST_PROGS := $(wildcard *.pkt)
+# This fixture requires its wrapper to validate outbound timestamp echoes.
+TEST_PROGS := $(filter-out tcp_old_ack_ts.pkt,$(wildcard *.pkt))
+TEST_PROGS += tcp_old_ack_ts.sh
+TEST_FILES := tcp_old_ack_ts.pkt
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt b/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt
new file mode 100644
index 000000000000..d13f5ea4ac12
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Run through tcp_old_ack_ts.sh: packetdrill alone does not check TSecr.
+// An out-of-order segment advances SND.UNA. The gap filler still carries
+// its original, older ACK; accepting its data must refresh TS.Recent.
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
diff --git a/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.sh b/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.sh
new file mode 100755
index 000000000000..4c4534a81e78
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+cd "$(dirname "$(realpath "$0")")" || exit 1
+source ../../kselftest/ktap_helpers.sh
+
+if ! command -v packetdrill >/dev/null; then
+	ktap_skip_all "packetdrill not found in PATH"
+	exit "$KSFT_SKIP"
+fi
+
+log=$(mktemp) || exit "$KSFT_FAIL"
+trap 'rm -f "$log"' EXIT
+optargs=()
+if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
+	optargs+=(--tolerance_usecs=14000)
+fi
+
+ktap_print_header
+ktap_set_plan 3
+
+for family in ipv4 ipv6 ipv4-mapped-ipv6; do
+	mtu=1500
+	[[ "$family" == ipv6 ]] && mtu=1520
+	if ! unshare -n packetdrill --verbose --ip_version="$family" \
+		--mtu="$mtu" "${optargs[@]}" tcp_old_ack_ts.pkt >"$log" 2>&1; then
+		sed 's/^/# /' "$log"
+		ktap_test_fail "$family: packetdrill"
+		continue
+	fi
+
+	# Packetdrill checks packet structure and timing but ignores outbound
+	# TSecr. Require all four observed echoes, including the gap-filling ACK.
+	if awk '
+	/outbound sniffed packet:/ {
+		count++
+		if (!match($0, /ecr [0-9]+/)) {
+			bad = 1
+			next
+		}
+		echoes = echoes (count == 1 ? "" : ",") \
+			substr($0, RSTART + 4, RLENGTH - 4)
+	}
+	END {
+		if (bad || count != 4 || echoes != "900,1000,1000,301000") {
+			print "# unexpected timestamp echoes: " echoes
+			exit 1
+		}
+	}' "$log"; then
+		ktap_test_pass "$family"
+	else
+		sed 's/^/# /' "$log"
+		ktap_test_fail "$family: timestamp echo"
+	fi
+done
+
+ktap_finished
-- 
2.55.0

