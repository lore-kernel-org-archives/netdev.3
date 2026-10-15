Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B937DAAE
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091736; cv=none; b=FFhse3hl+Oz56gjfxDB1yt8+Y4TrCKSdV0qqrMGwg4aA7oswl+D8LHJG8L8h/z8SfCbeo2bgllcs6od5oR8sJmdkHaXoKnX7FNVEM3b1NZLRocmctUnLWOIBccKIZ8OcwmUvzGmHwjMfJ6Sm3rQUZuUIrzFHDZc3wO98ltPm63M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091736; c=relaxed/simple;
	bh=Jp4pH0Td7L6ri7tat8z0EeT25X0PiKCVcnDPQdO3Bn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFFzmUPdsQsqG7WEn5i9DGBUgEoY3dVew14QKNWL4udaCxBtNotr6HHsWTVGLKdUz0KQzk+kmrBVGnNfQaMv87WgYofeR771JUJZr1jA3m84sJV0hdo2jGPZoM85PJYN+SGyIwXlMrUS3oW9K4Es6coyzuVIsLDK9b8cRX3wxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gveaAnEH; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gveaAnEH"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5e4d95e3e55so684838e0c.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792091732; x=1792696532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZF3bLXj9CIqUg/WD3T8ieRXgzuioWGRz8bfYuuLDC8U=;
        b=gveaAnEHMF6RyrNfGKzMxKcu2DRdgbCHxw1GuwbB5Sew14HiCO9m1RkLxWBD5Eiw4m
         c8zItxoVeXVIlpc7TIBuW+7GcZBUJ1RUDKmZYAgPIJBVC/hUn7aID/2ifvQUczFmv7UA
         1Wlc/UpQAkQy0IM8Ai72U9LFF7W596Cihq9Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091732; x=1792696532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZF3bLXj9CIqUg/WD3T8ieRXgzuioWGRz8bfYuuLDC8U=;
        b=Av4YUgQNrdq7O4r8oUHCrhROB+o+fupTRR4y8nQWOZTeQVFEjjN0GGvpR6YeVTtBfp
         VBjG8HUdLszoDsSZnNXPQrfupyjHgj2nlDvd27UQ5ie6TykhxMGdI/G3nsdMrsB3Z70k
         JxZj4d2UwZpNVTbXoH4kLe7x1Pa2jxF+jZjppZhBlX9FbN3U2RPdFC+nxbaXpkA2r/2D
         7nL8FpOXbVMBqapeUaLX+DwnXkZyuo6pLuW12v9uBNtc/ZFoD5VKuMmALKNONdwj+HIT
         9DQsn0Fja4oV1tHPaOikVwD+SiMvkWcwGbhHFThFgTbeBCt+RDGEeVfpp4kYWy0nPGjk
         Ux2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKJ8meJv9UFzCnwbp9aifiK3JSpud+TxulinsVpIfFmGQ7gSOZPODSMFx8NjVuUo1+H12dCjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJj+Y7ddFS96CyfuiMdZ6QUHLiZs4J7qhykEV/1t0Qclh+0EsFg
	fCxSxKGA9UUncuuIoyEVtcasri1XcDygiQOAiymrwXv2ck0jMYtdixmRAMNsVQLvDg==
X-Gm-Gg: AYBFou1KWHGTgu/qk+bpKI2nYhVo8r0reqCy354u4Wqg7phF3azPbQCBG66vFGAAzel
	ifj65m3hSoay81F4EbXn96kSkl7DiNDFQnVnMSlVz3Vusx6idC3bmb6KaizemmW3L1OnCRFKu08
	IIn/Xc6AbZp/Cups8pEyeD6O7tt13kSAerLq4uCoGYzsLmUcVwuT/ZIl/xLhlCbE2T3aJIhnCjK
	n4T+vMDJ252W3KK/xBQVzeP6d4joiBzhlkANhDyx7Y7W/g6J7/mLvVC5dpRhD7zEzqDKVKTHP5q
	OAEX4qN/oubGpa0kFXKRz1/RBXBaI7lWZxpnd+BpWMJS23Mw0vFZBRwsexPl2nZ7u0DUW0NvTZk
	lwAJLPs021zK9rEWGJrCTqU+QHuaalSjYDNE+yLPUDFFEoI2Xmm76vKcVp41y5iNca/9RuwJO5j
	B1RkE1uhLWJ5z4pNATf3mawrB211p0NnUK3Enkqu0ooxB9TY+9NmkyMPCk6WZxDlZcQzkB5zgNk
	TX9
X-Received: by 2002:a05:6122:130d:b0:5db:4749:1730 with SMTP id 71dfb90a1353d-5e91f4bc6d0mr6187781e0c.14.1792091732028;
        Thu, 15 Oct 2026 12:15:32 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9943caf9sm411962e0c.4.2026.10.15.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:15:31 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] selftests: tc-testing: keep IPv6 autoconf out of exact-counter checks
Date: Thu, 15 Oct 2026 16:15:24 -0300
Message-ID: <QDISC-L9J8.v1.r0.20261014162217-1@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tc-testing cases assert an exact bytes/packets value from a single
injected frame, but count every frame that traverses an egress qdisc (or
match with "protocol all"). Every case creates a fresh veth pair (and, for
the gso_skb cases, a netdevsim device) and brings it up with IPv6 enabled;
a device whose link-local autoconfiguration runs then emits neighbour
solicitations, MLD reports and router solicitations for a few seconds.
Those are ordinary Ethernet frames (0x86DD) and are counted too, so the
exact assertions race with the autoconf burst and fail intermittently. The
$DEV0 peer of the veth pair lives in the init netns, so its frames follow
the init-netns IPv6 sysctls.

Conditions to recreate the bug:
Run the affected cases with IPv6 enabled (the tdc default) on net-next
(7.3.0-rc6+). 4e6b fails intermittently (4/6 here); the four netdevsim
"gso_skb" cases fail intermittently too (fb6c 1/25, 0235 4/15, 476f 4/8).
1922 did not trip in the sampled runs but shares the same setup and is
fixed for uniformity. Each failure carries a stray autoconf frame, e.g.
"bytes: 98 != 188".

The Fix:
Fix the affected cases:

 - actions/ife.json 4e6b injects only an 0xED3E frame but matches with
   "protocol all"; scope the filter to that ethertype.

 - The four netdevsim "gso_skb" cases (fb6c, 1922, 476f, 0235) create $ETH
   from within the case and bring it up immediately before installing the
   qdiscs, so the autoconf burst overlaps the measurement. Set
   "addrgenmode none" before the link is brought up, so the device
   generates no link-local address and the counter holds only the injected
   packet. IPv6 stays usable (a manually added address still works), so
   cases that exercise IPv6 are unaffected. On a kernel without IPv6
   (CONFIG_IPV6=n, or booted with ipv6.disable=1) the attribute is not
   available, so the line is made non-fatal like every neighbouring setup
   line.

With this change the affected cases pass 20/20, and the whole ife.json
(51/51) and infra/qdiscs.json (48/48) suites pass, as do the protocol-ipv6
matchall cases (filters/matchall.json 0596, 41df, 8bd2, 2a4a).

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/ife.json  | 2 +-
 tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
index ece7ec41bf99..135e9fdc6e02 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
@@ -1408,7 +1408,7 @@
                 "packet": "Ether(type=0xED3E) / Raw(b'\\x00\\x02\\xaa')"
             }
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol all matchall action ife decode pipe index 10",
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol 0xED3E matchall action ife decode pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC -s -j actions get action ife index 10",
         "matchJSON": [
diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 0cf12c50fb74..556a1dda1047 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1555,6 +1555,7 @@
         },
         "setup": [
             "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH addrgenmode none || true",
             "$IP link set dev $ETH up || true",
             "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
             "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
@@ -1598,6 +1599,7 @@
         },
         "setup": [
             "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH addrgenmode none || true",
             "$IP link set dev $ETH up || true",
             "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
             "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
@@ -1640,6 +1642,7 @@
         },
         "setup": [
             "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH addrgenmode none || true",
             "$IP link set dev $ETH up || true",
             "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
             "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
@@ -1680,6 +1683,7 @@
         },
         "setup": [
             "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH addrgenmode none || true",
             "$IP link set dev $ETH up || true",
             "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
             "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
-- 
2.43.0

