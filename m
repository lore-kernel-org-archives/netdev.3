Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DE48C8A4
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431767; cv=none; b=eLmMdRZTH9b35XObKCtpyDgiRGtEAewueLj9/mrQ6UKxD5FTNHCUMWsIlFXioZk+2BsRNJAKgACYFyFARBC/x2Mm83p86K3drtzMTYzvwCWPJ/Vn9MDKFx4Ax35UzCztgXnAlOVTfW0jHpsCXPsYbSarXLtKpWuowI+4kE7VJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431767; c=relaxed/simple;
	bh=oCZyy8cESa1CQw46kQlW92KVpEPUeUQ8pnzCsXZVcOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc3Cxj6uQu2/ZPk4l5GjprTNUQ9bLqxIwVrHD8vwD0i4lHHmY/9KEbRUvRyytSu+ZlJDU/iOFNfSkRPf9SF3LIS1grDLlDmol5I99aXc6zFSyZ07jyJmCJUdyL0p6rhWB7+OdkZB3eS1s6zczV285W+RIC/koLQNTHEerdOB8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=mIqdakbF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="mIqdakbF"
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E88044B97
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788431749;
	bh=pRApGfPAXtPOCs+RBxplz3SPHgBy4a8d2R4AbBpaGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=mIqdakbFeFZuHZ8MMUgmrKIkGLoeyuVrA//XpCsooHxuv2GE1L/V8dsqlmF8kO5FJ
	 nN/Q8e/CohBUWGpOi0v54v+6dSN9B+CmrP2K3aP/kJ9EaCplfKJ4PNQjsN8NcKksiQ
	 E8qhf96yDBgt7xReNZskXiN505/5SBIcqUl5N2M97b1VUs2BtBquX1Twu6Zqgo0bYy
	 DC6Fq7Uexzl9WbLNtKF1Eky1LVt7d64KKfOW+kXyU53JEjvzIlWJcstu02PAsiIf17
	 vmDPfX7yZU7tuKHEnZhLYX3/Cv3LjOPqbusScYrU5xS6tgIRwWuRcaDVGdqbrCqofL
	 ganOtiI/ua+EaubbL5XRjot1kUEOio9FE4D2ggjCt/8RrZzqYlDZXv7lqV/d3UBxYu
	 ktofO/gSMBtGIfED2moqqxMPss9iZoI72p+yLMYXKW1st1GnWBHTf3QEVKTjtJXPp7
	 kZlihwsFOapiRsD+MRrMgRxUFRKC64h32DQhsiETijlvGpSKlIWsCKBHJnFKQ5f5eb
	 5HyMWu4i8sEp9oNDn9Zx98vxxPycdo9Wc1BJ1cgdswWe8xjwhI02eYTBIbjpVhp0DR
	 bvJLNLpwUyQB2m/Lx783+QtZZBE4ZzSq1yLOKMXXQcxiZBNbu9s6ZJBsguMOBflr1u
	 /hLgpNMEzhrWgEQ0h1bc7u1c=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b0d7a07acso23843475e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431748; x=1789036548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRApGfPAXtPOCs+RBxplz3SPHgBy4a8d2R4AbBpaGlM=;
        b=GNMF7pTs4W1hc3zAtP3JC42ZLS18WrHfnx3TPpt7YZIXfPf/RpFCMhzXwPHc68zl6d
         B+NiiRCnvnrB+qXEhLr70WplzGaxGxv5WHDU2PhzMxwkfN7y2JdXRo6fBmWsvJDe7cD1
         fnbhgYQ1yb/YzCMPUngcG5o6wMHLnWXGKGnWOhn8W2FzOrH7WxIP/L9G55KiSIHjn/Ae
         OfxipNvjGLUKpXBuD8GYRzSNezt2cI9OBHk2Pc7VuCWuVk/nNrNV6DOViuLfGtN9rKiq
         3y7/xQ53XFKVVf5u+7XtE40NFBgbYm+ddYCEm6RbgnEvs5ajjq8kMDtLsNcnz0rDXDan
         tGpA==
X-Forwarded-Encrypted: i=1; AKwUvBxoL8l6ZNxmJEuTZmgCzq3aehdLbWk9kOwZx33eGkX9xRksZbzLtA9k9sPzY7y4JpyPTSEPyYs=@vger.kernel.org
X-Gm-Message-State: AFuF++m2fjc7Ifgm4Z7okYCLQgkE/Viv9LeOsLP7lMz4q3HlEkhYhVDb
	l7WatXgxLVcNBUwE3RP7nJSmodf2gMh/5ZWJKekU3oyFKFbTG/kGZw+CIcZaqtIq8dvB16mQBds
	QCYdGP4daQumPNdP4D2TR3peU9I57oAUEWJD0EbIqPZ/+AsshbjmvKHVSAJmCLUS9HBQqBWWueA
	==
X-Gm-Gg: AYBFou2Mw14F1Of7tTyqNRALRAU6i9+DcB+Svt9UGCwNQs1l7tiv22z4tOO4NRqn3uw
	2rYHQwUKuR/yAjdjghqWj1JwUeyCIg+eZvQjxVQzQ0ez/JIMQnPg2BTcYqjQn6U8YUJU6Gs1x0P
	yJu/SXr0V6g3ND/f50BCLCwtrc616p/I8W5Vn1jVJf2MXzqJsvAiLFNgoggt6jYTYjIwUKRzRY0
	wDhMuo7fVdU0IAtFcsYU3tXq7xNIZviurNXWIt8mbSltTW+1UO8DlJkJ/e/w1Zh3OkVn47ogis5
	R+Nxse8RbaBld6Q6V4NSpCtLU8zVnDZFwSKB6eWZ0h+pSBlqmUNrbmXDmDmavb35CMRWjiKtl87
	SW34xFY2L0IjwCZL631CGoywel9EtI12wi4hxiT0JDfqFW1q6wH5Sx+7XxXSPn3MJjkg=
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49ceb160bb1mr110957205e9.3.1788431748674;
        Thu, 03 Sep 2026 03:35:48 -0700 (PDT)
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49ceb160bb1mr110956765e9.3.1788431748364;
        Thu, 03 Sep 2026 03:35:48 -0700 (PDT)
Received: from localhost (93-40-88-16.ip38.fastwebnet.it. [93.40.88.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d9db2sm62799975e9.8.2026.09.03.03.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:35:46 -0700 (PDT)
From: Alessio Faina <alessio.faina@canonical.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next, v2] selftest/net: skip srv6_end_dt[4/6]_l3vpn_test.sh if vrftable not available
Date: Thu,  3 Sep 2026 12:35:45 +0200
Message-ID: <20260903103545.1325276-1-alessio.faina@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case iproute2 is older than version 5.11.0, released ~Feb 23, 2021,
the vrftable support is not available and the tests
contained in the following 4 test files
 - srv6_end_dt4_l3vpn_test.sh
 - srv6_end_dt6_l3vpn_test.sh
are failing in some kernel backports.
This is the result of one those tests in an unsupported environment:

\################################################################################
\TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
\################################################################################
\
\    TEST: Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)       [FAIL]
\
\    TEST: Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)       [FAIL]
\
\    TEST: Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)       [FAIL]
\
\    TEST: Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)       [FAIL]
\

To amend this, check the current running iproute2 supports the vrftable
feature and, if not, just skip the entire test to avoid a failure.

v2: - remove dx[4/6] tests
    - test if vrftable is available in the installed iproute2 application
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260824091537.2305107-1-alessio.faina@canonical.com/
    - initial approach by testing DT[4/6] and DX[4/6]
    - test if DT4/DT6 are available in iproute2

Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
---
 ./tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh  | 21 +++++++++++++++++++
 ./tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh  | 21 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index a649dba3cb77..037e5fe1da2a 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -469,12 +469,33 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+test_vrftable_supp_or_ksft_skip()
+{
+	local nsname
+
+	setup_ns nsname
+	ip netns exec "${nsname}" sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
+	ip -netns "${nsname}" link add vrf-100 type vrf table 100
+	ip -netns "${nsname}" link set vrf-100 up
+
+	if ! ip -netns "${nsname}" -6 route add fc00::1/128 \
+			encap seg6local action End.DT4 vrftable 100 dev vrf-100 2>/dev/null; then
+		cleanup_ns "${nsname}"
+		echo "SKIP: SRv6 End.DT4 vrftable not supported"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${nsname}"
+}
+
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
         echo "SKIP: vrf sysctl does not exist"
         exit $ksft_skip
 fi
 
+test_vrftable_supp_or_ksft_skip
+
 cleanup &>/dev/null
 
 setup
diff --git a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
index e408406d8489..9a29e0d6c912 100755
--- a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
@@ -479,12 +479,33 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+test_vrftable_supp_or_ksft_skip()
+{
+	local nsname
+
+	setup_ns nsname
+	ip netns exec "${nsname}" sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
+	ip -netns "${nsname}" link add vrf-100 type vrf table 100
+	ip -netns "${nsname}" link set vrf-100 up
+
+	if ! ip -netns "${nsname}" -6 route add fc00::1/128 \
+			encap seg6local action End.DT6 vrftable 100 dev vrf-100 2>/dev/null; then
+		cleanup_ns "${nsname}"
+		echo "SKIP: SRv6 End.DT6 vrftable not supported"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${nsname}"
+}
+
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
         echo "SKIP: vrf sysctl does not exist"
         exit $ksft_skip
 fi
 
+test_vrftable_supp_or_ksft_skip
+
 cleanup &>/dev/null
 
 setup
-- 
2.43.0

