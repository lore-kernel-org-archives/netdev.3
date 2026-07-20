Received: from mx0b-00115406.pphosted.com (mx0b-00115406.pphosted.com [205.220.178.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53881421F18
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.178.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572917; cv=pass; b=P4RefzjHohC4/FXCCAGc4MKiUWFSrLKZiXD4l9bwt27aCx19G8Ef6877dQdK8EQ8HB8FhZ2L8Xa2pbK+cFg0+ZqNtDBfNPefMovLWvRL7gcu6ZeJ3jvOI34M1xzeUOwVKvXH2TWvw6y/upbpM8qQ93BWuWSK4LSyHjcJx9knd70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572917; c=relaxed/simple;
	bh=lXhOJQY+io6raY/GtbhX53sbxU6/Do4c0Vw6oHu/iWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKkJo8U9g3czc1komQV8tDvQgokAsOY8JyLBLMEY9eFwek6NtwO3EUmcaGGwZ3nFyV62DbgLIEkUs1b0oJ9kw9Nb7Zjdz5mAheEI+/MKi7Gp6Xo93aETWwL+Ct4rW+HmrYIyxXuzuaXztYvJxBZDejkuVE2K85d+1nio7nQZP90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dish.com; spf=pass smtp.mailfrom=dish.com; dkim=pass (2048-bit key) header.d=dish.com header.i=@dish.com header.b=Q3vZlGPh; arc=pass smtp.client-ip=205.220.178.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dish.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dish.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dish.com header.i=@dish.com header.b="Q3vZlGPh"
Received: from pps.filterd (m0495109.ppops.net [127.0.0.1])
	by mx0b-00115406.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KH6Uhm2888720
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dish.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=ppt1; bh=c5dVOyQfaReZO89IgHAyzanGEqVB3
	4DooxeL560bXpc=; b=Q3vZlGPhfjyW/enFM70y4wAedX3wNifzAJDg3jro/eKxD
	2h7hA1n421wXXYo6W49eqaq/OxwwAyK7uiEvtx7Vc5CWt5v8xAxf0Dym5dJduIUM
	vJOFK/D8SUjBJSXokHgbKL3Z6TjejBQNim98VVUyXuHR+Dd0tSK5CED9eH1ZDh1m
	0yHYOggcb6A0TodnLcmnrn7jbqd+cb7OAb7/6KXkHTKzBsdZVk2qsB5DaFJs3T3Z
	aKkjs59LRHLgy03iC1kUtRck7qkn4/YjeNWO4vMgJNzFuPPYGeRyvoOA4GtQ29Fk
	v7Z2s509E51EqxSYFPH56sulyRc0poTvIn0bQImjw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00115406.pphosted.com (PPS) with ESMTPS id 4fgnaaa4e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:21:53 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e8577d187so247162597b3.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571712; cv=none;
        d=google.com; s=arc-20260327;
        b=S5YX2ppTV/8hQqvmLYoCoB0moLWOlG6hTBG/4gZI4Z/eAizgRXqdLZplODtTzx9XN4
         tRr0/Rg6ueUhi++e6/3Wcg0NI/J/GE68uyunBJgQlJZ/UxpRIT7d/Icz2icswCE/OhPY
         HOXmhww+tNS7WIkWkO8FJdt75tdJTVnhMwDe0S9cuxsIIOWZOm3mkosiv9WNEl/FAnbR
         5jaDB8RGlerHfzltXT2w5BToShxoZxvkuMOpHzg80b/CyA6pix1JMVfuaZ6rULg+dVVM
         VdCLZosNTaD6MqdHRhUQNG44nEPJuNBsCcMKaajmGKqL1aODMWfKazbT58muV/sexwiQ
         4PiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=c5dVOyQfaReZO89IgHAyzanGEqVB34DooxeL560bXpc=;
        fh=aLXdqiAAOC8NHOU6jiCvJE8hg/p+dQ6ipJkYgqKk9BY=;
        b=dvGet8Fr/uT1n+HuLGrWqkRt2iIjsVl6NqgrnaQdHMcI7C6n3NeZZe2ua9zgzOIb8W
         qtRT0v+S7XiPj45yh9FdB83bKIuwg2w+rMI3vuRKhJc/aijTSCHd4f+d590DFzDdDpGt
         U9WVeb5GPeZyqSPbAEvx3CfsC4AJHG5S+bGO2Gu0tRUqc+dIEAYWFClJhcduXCushJwQ
         us5GL7/DCse9KDMB7jW8XHXBQ25K68ScToPy/kDXqOFA9VeX5g0Ob30AhOU9tGAOfLvT
         FI4Nz/+x6op7jZeA3b2iE2wqxTKXE8Jy2nTEoHdnlKKt6zL781QYY7klrxC+1qSuD3NL
         3MRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571712; x=1785176512;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c5dVOyQfaReZO89IgHAyzanGEqVB34DooxeL560bXpc=;
        b=KfssB4wiSLWuxSMC3cL28/WtFTAbbwkCnMoVt0+GJ9+HlauHp2erKyc89Bei/qrdTt
         O4on1DgdMBNxdN5i7ZXiMGserMyJAaFRk1Hk55YGucLOu3ExCp0WTBGmFVc0eldKWaVy
         UnjNGtQJfh9/rmtjy5m2KA8DbkqlHzvCcsWJoJUcniDz3s/EhbshXgiFPVfaAKAoHRC3
         8Pr8nJdZkgUpxuN4iVpfL3A0muWBUqfMJoy7thT+ZnsWGCX71F6jdZyRAvtZGnQqmGf4
         ctpIyZoDdOx8jGEilf6t/m2rHWKBm+b4wbpcXyCvfe/cDtDyDfARW/adQCKGUtb/2sZe
         NlVQ==
X-Gm-Message-State: AOJu0YwYWb3tW5URkpEWrLaE6z3+qBAO0GVRXJ9WwokOwuUk3AfoJZ/Y
	TB3hsLNA9H6Q9OuUauspej3hXR6Hdon1nZIgjI6xzySHrTDr6ysC7apoEiGaQ6TlYO0sVEvRMKJ
	Zv69FhH6xmyayuppFN27KgpV+Fw89Dbi4E5/azjK1/uXV2mtjxkHVbloqKgaQQJhk5spHPAp93p
	+flhUPZsP5g73krNoOJ9wa3cfaRq41n+nQt4MoGCLgeQKmeA0=
X-Gm-Gg: AR+sD12cyewP+3qJwkjDVHg1g18mQHR1uNXryTziLzQwM2ny6b3YtElrv6Z2GEticfq
	F+5UHTcc4ebNUR1lx5TxWLhsPbihoL8APejeo20ji+awqS/uIyU0HNZGV6eo29mIxGSRvw/RSgL
	JrZZoKseruzgbYfJjREUjgf/IwKQ4y9NeG/mlEMuYflX1QEgvWOWa62irNHg==
X-Received: by 2002:a05:690c:4508:b0:80c:6dd5:21c3 with SMTP id 00721157ae682-81ef25eb060mr48913617b3.24.1784571712274;
        Mon, 20 Jul 2026 11:21:52 -0700 (PDT)
X-Received: by 2002:a05:690c:4508:b0:80c:6dd5:21c3 with SMTP id
 00721157ae682-81ef25eb060mr48913447b3.24.1784571711700; Mon, 20 Jul 2026
 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPT8rhu_NGbLd54RFWRxO+=7BHhJ0pS5yeOgo5kNmq4qtQ=t8w@mail.gmail.com>
In-Reply-To: <CAPT8rhu_NGbLd54RFWRxO+=7BHhJ0pS5yeOgo5kNmq4qtQ=t8w@mail.gmail.com>
From: Tim Wong <kanman.wong@dish.com>
Date: Mon, 20 Jul 2026 12:21:40 -0600
X-Gm-Features: AUfX_mzB4IkMDyq-8vCv0uYwhMyQQa6Sut7SqWcvbynyhmy5uiiLyRtGbmhlpj4
Message-ID: <CAPT8rhtXa4q4wwaOUtfY0MMVmMSg_MRy2DaqoC+4u14RYxNd+w@mail.gmail.com>
Subject: [PATCH net-next 2/2] selftests: net: add test for IPv4 address scope ordering
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: FlTj48e50sL-fszjX2TBT8UXrhQLt-lx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwMSBTYWx0ZWRfXyQ4DlADauTvK
 hWClIHNkktCog5GDPJNQT2gi/dK1HWfGSd9ivtQMcimRGAj6aSBYamftFDIbbUKzILPcUGUhgyv
 AIpvUCVSgaD+IERuZs9iZO2iYP207kIjiaFVCAVl33VUZxAfBj3W
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a5e6741 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=XolNvlvVfU_khZ2SZc-R:22 a=THJZACkQAH-ljx93NWkt:22
 a=BZdJCGVvAAAA:8 a=KodXEU3fMOHkBKOHQYkA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=U3TbxMjcxCISFbQIaatt:22
X-Proofpoint-ORIG-GUID: FlTj48e50sL-fszjX2TBT8UXrhQLt-lx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwMSBTYWx0ZWRfX9tWMZh9HKN0N
 ZgZg4NqVwah8sJoK1UTvaUhP6Mf3EgagMlAVXXpmEL0xA2KXWRwp+ad/VC8OlFhp+/53xHEQltF
 Hjq0rsg9rXZAWoIE3wKCpWyCKi3G2z2F6zF21TUsZYVq+MPa2pbXXgpWRXopPLnLDQhbc07Kb8t
 0biHG/SQvKhASCUjUID9VB5iHm8Avrgpql/LQM4fsM8Bk8ZzQueKmk19ymX/4Gtuv1czUA4zD/b
 jWImyurvKViyTvyaM0TPcEzYdLG6h/abwtkiW7l4egfUknYqX75KCA9nI5rHg7uGJi9aWDWmft2
 58Ubge1XqXvIXnGkCh2AegLr0U6VCEEMpUUsfcmb5limJMYmgV9/lIKgmri8PYuTFHXrfTiv2xP
 W1nIjTOAYm+ijjYi1s6aDFFiuTOn9jCfwOFmzqXvB8CUI4Vhcf1ywD19D0usKBpXyOFPvYZzvOF
 copjdVJU/JcoPQtTt2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200201

Add a selftest verifying that IPv4 addresses on an interface are
enumerated with global-scope addresses listed before link-scope
addresses, regardless of the order in which the addresses were
configured. This exercises the ordering fixed in the preceding
patch ("ipv4: devinet: list global scope addresses before link
scope addresses") and guards against regression.

Signed-off-by: kanman.wong <kanman.wong@dish.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/fib_ipv4_scope_order.sh     | 55 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100755 tools/testing/selftests/net/fib_ipv4_scope_order.sh

diff --git a/tools/testing/selftests/net/Makefile
b/tools/testing/selftests/net/Makefile
index 708d960ae07d..66a79c915961 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -33,6 +33,7 @@ TEST_PROGS := \
  fdb_flush.sh \
  fdb_notify.sh \
  fib-onlink-tests.sh \
+ fib_ipv4_scope_order.sh \
  fib_nexthop_multiprefix.sh \
  fib_nexthop_nongw.sh \
  fib_nexthops.sh \
diff --git a/tools/testing/selftests/net/fib_ipv4_scope_order.sh
b/tools/testing/selftests/net/fib_ipv4_scope_order.sh
new file mode 100755
index 000000000000..3bbb7eefa2d8
--- /dev/null
+++ b/tools/testing/selftests/net/fib_ipv4_scope_order.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify IPv4 addresses are enumerated with global-scope addresses
+# listed before link-scope addresses on the same interface,
+# regardless of the order in which they were configured -- matching
+# existing IPv6 address enumeration behavior.
+
+source lib.sh
+
+ret=0
+
+setup() {
+ setup_ns TEST_NS
+ ip -n "$TEST_NS" link add dummy0 type dummy
+ ip -n "$TEST_NS" link set dummy0 up
+}
+
+cleanup() {
+ cleanup_ns "$TEST_NS"
+}
+
+check_order() {
+ local desc="$1"
+ local order
+ local first
+
+ order=$(ip -n "$TEST_NS" -o addr show dev dummy0 | grep -oP
'(?<=scope )(global|link)')
+ first=$(echo "$order" | head -1)
+
+ if [ "$first" != "global" ]; then
+ echo "FAIL: $desc: link-scope address listed before global-scope address"
+ ret=1
+ else
+ echo "PASS: $desc"
+ fi
+}
+
+trap cleanup EXIT
+setup
+
+# Case 1: link-scope address added before global-scope address.
+ip -n "$TEST_NS" addr add 169.254.1.1/16 dev dummy0 scope link
+ip -n "$TEST_NS" addr add 192.0.2.1/24 dev dummy0 scope global
+check_order "link added before global"
+
+ip -n "$TEST_NS" addr flush dev dummy0
+
+# Case 2: global-scope address added before link-scope address
+# (sanity check -- should already pass even without the fix).
+ip -n "$TEST_NS" addr add 192.0.2.1/24 dev dummy0 scope global
+ip -n "$TEST_NS" addr add 169.254.1.1/16 dev dummy0 scope link
+check_order "global added before link"
+
+exit $ret
-- 
2.51.0
