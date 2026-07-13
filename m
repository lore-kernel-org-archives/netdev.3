Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FA3E1713
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936678; cv=none; b=qcv3bqJiMqjSV6kw7+ia4VhGqrADLLCf3nc0NfAz4ds327L7Wh5UuSf6bOm4kY79SSBH/q3IN7DGN5JUY3L27hf3VYq+adxBAkGVGTNIjchsV9+5HX6bEiI96cGQEfmaJfS2j6kxFg84nPeflYUx+KK0N0TtApC5VMsKX+8E5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936678; c=relaxed/simple;
	bh=l3UTbUymYlRN5imGRu4IpkEBSuVXCR++q+L9zDNJTN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEQkhHSEo9y6IxS8dZtSMLic0a1+2NyALRw1hd52uUqHGXZyCx/U/R60FK5d5g91jVu+iI9ctReEM4rCN9cT265eCBYgTwY2j6kllnuTZzzrTKf+dvGHT2QLaMbX4/bH356AeBDvm2dodrAbiko++A2qqrHgx95I2kyIZmWG6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CIJHWb9f; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CIJHWb9f"
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E55893F2D4
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783936672;
	bh=APSxiqpB9sfMOUfH2IGy4ikKFokKYtX5pknrKsKxMHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=CIJHWb9ffc6zxCJxAfa7Vg3jzwQ5rDGFbTA87yaMc3oRXEwT7lhFZ6i5PRdDEMfWS
	 a2kLkFWIftrAstway2E93YV/o6xq8WumsfPGSxAcfOIhQsDvHcRl+QYnd0FHsuXG/C
	 E1yVIuvyP11nLWeJQPeNVi6+7ju9yymbFEzbNjQ8tNcvdtl+JgQ4r8uzycIU3qU+sq
	 QxJqrml4j6WSJ73PF2GuXOFOTQ0eQHZp97NMkLlZlx8l8IhoZ120h01QbWoJXGaHTY
	 hj0LkngzGZqpm4c2cOtGFQRgxLLfU0OdSR0aF3BYm1Prd4Kw+I8/HB2W8PzWG4Rv0l
	 wxkcLvzoVdQl0Y6mYNUuMt7TKS4TQSQkJnZuGiwnOoug+h5Y7aM6jrkHLZ47KURTmr
	 kbWHHzQrSVfDXCwbwFtfzhQgJPfk0qvyZfhHboTJ0dsvgzJQm4h/FJPNay6nb/GUnd
	 5DoH/km0LFrJ4A57blCaH0OZ6OkCDr+22pY2qfoeA+G5tOLaeC00ccoTj+FSNnkXrR
	 8BNnjP5pXDmK2ufiCIf1rDL0XYWzlPrw+8RU5s4PuzpW4Y5HE63CDXawM66WgO61+j
	 uFNAw05eoe/zVDnJG0pb+oLyTTBuq6qGcZGcZqYGWZ77X6q11jufWlub2Ux9l5xXKT
	 QoIXazt2Kl0KHEkiL9mpXoEI=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f2b84db9eso1718112f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 02:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783936672; x=1784541472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APSxiqpB9sfMOUfH2IGy4ikKFokKYtX5pknrKsKxMHQ=;
        b=MbFZylfSLu/qKD+yZogioIAF/eeyvVjMAtCjOcfuyUFe0c4UVW6tSYFe73U1mX2VBz
         nj8kpZ/AlyvkAopchIIhhmM4xKs8IyNCd0zJT6qSYgMzmSxhyafDrTbjhN5sqdrQ+VZI
         lNXDKaKJEPu1rxpmSfE3kf8m/fKWz67je9LG0Xj5jGJLHjIbO1L+VAgO1M25FRGstXJC
         DUZUlOWPnCj3KBCNQqbwKg6Axk5YzLly5DsSCiD+9/GxYVW2AP6CaBheqm4t64O2LJYy
         7TE1GeuWk2kZbPebRE2sA/XVmHGpT9uaISc55VZ+9Mdl2ZzxurOi9d5Visi2jDZVU4To
         XWNA==
X-Gm-Message-State: AOJu0YxidUeS8v+aN8uZQGa7gpnpN0qioEXKjSTJoeXzFLtoW3s7/huU
	w1zUfDW15p3QPmrir7su8ODFrAVxo2A3fKTtvReNdQCWXGvLyyiH/47NYs4JibphKOHV+B8rBLD
	rQaGoSsHU3s8qVbKAUErGzo/U7mWUeezNxHlE5wg3HnAe3jTuVJWS0cfg/ZByo7M0ziYq2GrG31
	LcmgtPlw==
X-Gm-Gg: AfdE7cleHL/EseLE2UIXCQqwCdPtqgiWvkidcjU1rMfmcAU60uVIKchoefsWgyhPscy
	m9fNfKo0uo1gnEcsomyt07960IhYswlmOOANVKU6UycViHoTe23vgDL1H4595pna6DlQXTAQdx2
	e/oKHJ1QxWotH7wQdEwKj77nNjlUapw5VaNiANAoEeoHUlW99mv9KLwKF8sFjz+JTP0r1Oc9qHL
	u4xyajKSyue4V4xqHl5WgrRHjIjnVCBRFGAoBzlolt0XtMnUvB3j2bJc6tOoep3NrS2PreOAYfd
	FpCPltjBSmx7wB6touw+z8ChPERYQFJrA1mYCmjB9zReAVAila5/+CwuJdRpF16jzUhqt6FMtnb
	hRt3z3f2x9PpFU+eAZjEgOm1dbieFJO26Ez0EM9430tdMfFL/kd3liw564srsdtz2rNDrTbqEKY
	B4UM8=
X-Received: by 2002:a05:6000:4713:b0:460:3233:beef with SMTP id ffacd0b85a97d-47f2dd016d9mr8632713f8f.43.1783936672535;
        Mon, 13 Jul 2026 02:57:52 -0700 (PDT)
X-Received: by 2002:a05:6000:4713:b0:460:3233:beef with SMTP id ffacd0b85a97d-47f2dd016d9mr8632685f8f.43.1783936672160;
        Mon, 13 Jul 2026 02:57:52 -0700 (PDT)
Received: from localhost (93-40-44-74.ip37.fastwebnet.it. [93.40.44.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm84973523f8f.28.2026.07.13.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:57:51 -0700 (PDT)
From: Alessio Faina <alessio.faina@canonical.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Alessio Faina <alessio.faina@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next v2] selftests/net: Skip srv6_end_dt46_l3vpn_test::host_vpn_tests if iproute2 too old
Date: Mon, 13 Jul 2026 11:57:50 +0200
Message-ID: <20260713095750.2671173-1-alessio.faina@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case iproute2 is older than version 5.14.0, released ~Sept 1, 2021,
the End.DT46 support is not available and the host_vpn_tests test contained
in the srv6_end_dt46_l3vpn_test.sh file is failing in some kernel backports.
This is the result of those tests:

################################################################################
TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
################################################################################

    TEST: IPv6 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]

    TEST: IPv6 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]

    TEST: IPv6 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]

    TEST: IPv6 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]

To amend this, check the current running iproute2 supports the required
feature and, if not, just skip the test to avoid a failure.


Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
---
v2: 
	- skip entire test suite if iproute2 is too old
v1: https://lore.kernel.org/netdev/20260708152745.2430714-1-alessio.faina@canonical.com/

 .../testing/selftests/net/srv6_end_dt46_l3vpn_test.sh  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index a5e959a080bb..cd7ac03e3907 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -536,6 +536,14 @@ host_vpn_isolation_tests()
 	done
 }
 
+test_iproute2_supp_or_ksft_skip()
+{
+        if ! ip route add help 2>&1 | grep -qo "End.DT46"; then
+                echo "SKIP: Missing SRv6 End.DT46 support in iproute2"
+                exit "${ksft_skip}"
+        fi
+}
+
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
 	exit $ksft_skip
@@ -546,6 +554,8 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+test_iproute2_supp_or_ksft_skip
+
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
         echo "SKIP: vrf sysctl does not exist"
-- 
2.43.0

