Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8844239F
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604876; cv=none; b=HKlXgeWDvAWxkEH0r3pzmgs/FZ228diqbPG7wRrsobLF2ys7Hj1SnN4yt1lk/LrhuVsXIrqZxSnjD0OXhQJD1k9tyI8uE/N3kUGVC/4iR/P6g47CpsAfrurFFHUph3n/Uc0SJb8hb02CtRyG17XZtn9Sn2o9ZPoaLktes/w3g2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604876; c=relaxed/simple;
	bh=3H7DWsjdB2t1XmW+qQclm6nGtSHSe5mjsU+kx9BBsDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUdJ5QrqsUXLneQKsuRRkRrvZpUj2lzRq/1CD1CxrwaSUcw39hT55vFdFCxwZRv/3qPcIhWoOmUDTU0ScL5+iZesp1Sc9erxLBQJLgxoEnc69LgHb8uRV4IpsnIaPNr/sflUaWDICB4fMn+00QpGuXQJBcEPMLMMswp/88bxQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox+SKv45; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox+SKv45"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398a5aad413so1405509a91.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604867; x=1789209667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9d1us5ou1/R6dn+w5YFLXgBK3EMQL/jKg3S7fI7Edk4=;
        b=Ox+SKv45BlaCEgLEb11cuz3fFHPGcjrNp5+W59jn0QCLx7ScN0xBi8gARYNmidb9iM
         YSIfySIz3j8o9LU6RWKcKs3/YcIYecNaE4l0Cb09pykqNr92+mUEQOpUpZg5ynlQZuM2
         lILrZbOqaiKyIUsyPx3OJ8Ynq9S8LcfwjQUrprSadJjI+m3nSNPEO7tHOAFTHYeLzuCI
         t1aSYao4Md0PGLXYGXaVSN88rheZJDNtQh6PT1YhzKU2x3B3gxMoy9me7jmSskVquWn5
         BRsvb1avRdwlV1RMXMbCsB34cv7F4ETuhDFVXeFSyRDGhclxkZAZn5/udKBzxEQb8/fc
         WkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604867; x=1789209667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9d1us5ou1/R6dn+w5YFLXgBK3EMQL/jKg3S7fI7Edk4=;
        b=KPvaSapxpx2IwQ03HRYyF7xUTIjARwBSbpcqZDqzRjAoVC1JnMLbEW9C11RRPO+PJd
         OHgQ1H8NkOdgyhnsjs3kArilwrjiOjjVlPYm6edYiRJvh2XOKUmQD02td+GgOWVIy2VC
         fnGPWvtsyTah1Z2Du7iBgQQ705WVifkJ7zhHbFxoERHofGrzpDZCggWlFkfbR4n4XV8/
         /Br5I5K2UwURyakZzJBRMxq6bIRyHnlF3kJ5dqyOzJQGLJ5lj5Noxg/ceWp4y7vTFjKI
         9KI3NJBF487s1swwAhDfmelJjf3naOjZpgxmIdzomm5sU3Rbq/lAnX6X7VWm9omvqTKk
         aknA==
X-Gm-Message-State: AFuF++mNbUqyl38I525kWn0Fa9IPz9aB/rVe5QuOwFb2NLerBwFU1nJY
	FpTQvIkyKQ8iU6DaP+Xwg++O/Wo2EUxInAq1tg09SqtUgictaR/Kgoqm/+v/gSCstJA=
X-Gm-Gg: AYBFou1OR1wS1qBkeftGHumPACu4EXo9/UNeuEayB8H8o6Bx2JyFysugRQo3OLkt/CH
	57ssOmZBGaDjhQciq8xqUNi9Cs8cUUtPs2fICb9Hxjz1D2TuKsxW8+B4nR/PZTeP+QN+EEQHVGW
	vXzuc3omGb3BF8JM/9ddzYJwmNyGaPu/0HSJmnm2NZW2ruCg7DVKxcCnVdfXCko/w6paTInYhPM
	5KinwPObAXMOq+4pkQWfOOmoUc3VOAP6Lpah/qk/Qwk2jVWAP3x2A/yx7OumArKVCY9W0F+zX4/
	oVQxUJniRmyQ7gQH0JuCxHqpI4B3c9XgHVK3YyKZVzMPC5wqJW9gOHoERjKg82wnBaYa0RM/7uO
	2LN2rRNSm+dTEQL8xFC4LGabDN6dTVvBgVlrWFM32bf0QO+3Pm/X7G8kdEkiqzWvjXIE9el51K8
	1s+omVl9r9uypwoTQJEElo0ewQYh6KZIcQXPIYZ0ymrwT3qYO4QG05aw==
X-Received: by 2002:a17:90b:2b8b:b0:398:c0ad:711c with SMTP id 98e67ed59e1d1-39b26272f0fmr18850197a91.15.1788604866501;
        Sat, 05 Sep 2026 03:41:06 -0700 (PDT)
Received: from houminxi ([154.197.57.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm13559776eec.19.2026.09.05.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:41:05 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	i.maximets@ovn.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH 4/4] selftests: openvswitch: suppress pylint complexity warnings
Date: Sat,  5 Sep 2026 06:40:26 -0400
Message-ID: <20260905104026.3776396-5-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905104026.3776396-1-houminxi@gmail.com>
References: <20260905104026.3776396-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add file-level pylint:disable comments for warnings caused by
pyroute2 framework constraints that cannot be fixed without
restructuring the netlink attribute hierarchy.

After this patch, pylint reports 9.93/10 with 10 remaining
C0301 line-too-long warnings (81-89 columns) on f-string
constructions that match the surrounding style.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
base-commit: 9eab111e765729e93087ff86a2ec9b2ae42d0fa5
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5b29aeb4b50e..5948471ffe63 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1,6 +1,14 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 """OVS datapath control utility for kernel selftests."""
+# pylint: disable=invalid-name,too-many-lines
+# pylint: disable=too-many-ancestors,too-many-arguments
+# pylint: disable=too-many-positional-arguments,too-many-branches
+# pylint: disable=too-many-locals,too-many-statements
+# pylint: disable=too-many-return-statements,too-many-nested-blocks
+# pylint: disable=unused-argument,broad-exception-caught
+# pylint: disable=no-member,not-callable
+# pylint: disable=non-parent-init-called,super-init-not-called
 
 # Controls the openvswitch module.  Part of the kselftest suite, but
 # can be used for some diagnostic purpose as well.
-- 
2.55.0

