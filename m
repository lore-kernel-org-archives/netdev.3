Received: from mail-wr2-f23.google.com (mail-wr2-f23.google.com [74.125.225.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D7440658
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976073; cv=none; b=p4O8NFFmHOcTH0Q5wJe+r0ENHBdcIgehsKgUVyS7yOSEU/9H63xa+oLq9H8Pg7ojP9MZ+NqCdl9CQxWNTTk2bbDNL0FpzANEY34CdIvHL4LBM9x9+R89IMdBcH+cq5TPw/2Lo1p0plEnnJJb8K7syyK8AVWItkT/5UAz4EaVdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976073; c=relaxed/simple;
	bh=t5wWBrGsG33k1BbhMasdkPiERxAa2b8DhvgK5I4BLnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BIQG4J4KozyJ+4SARGM+g/V4nxEbd5X3e+oVuc8nI+G5rjasEmIy8Y7/JI/lXkLN3oIdqPofls0BZXiUKtX/WQ30Z29h5WhHWQjKXZSFsSbVT1x6nz74fsGqtzrfasYrEAfDfAcNMUHGJ9sizSDP4tH+dClP8HiFe38ACEXTUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN8Cb6Tk; arc=none smtp.client-ip=74.125.225.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN8Cb6Tk"
Received: by mail-wr2-f23.google.com with SMTP id ffacd0b85a97d-48b0622cc90so150270f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790976069; x=1791580869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ysJfmU2nfXZTtv2veyVxAaXsizKh3WhPhhl4gdeIEl8=;
        b=XN8Cb6TkH/Is+iiqkQ3xv4bkD7rFfFE+OrplKO6bvz1T4vQF7iyfGSFIpJObRLVukz
         V9J9Uo8mQev43w6WLASe6dAt5NMWGHRtg9++8pkrXC3C1+NAnGRiV88KTDi/sSiaO/43
         DeadgRqPf22qp5wlgGjECpDU7Rif8BrEzrFQ8AR0xiTGVV5IUkIJ6OI0fTdFg8XuTbGw
         saPdx+P7r+KwSf+tz/1oJJrXOCAqh/uEXxt/SDCBTeiI6es69CEJP0iCNkuAh8vfb3WC
         yjZTOkbHrCSO0F7Js8NKYFEhK90mhG8w4z6oodLa9IR0EgugrtOZf+ahz/EX0XugHU9k
         WlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976069; x=1791580869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysJfmU2nfXZTtv2veyVxAaXsizKh3WhPhhl4gdeIEl8=;
        b=eTg1oDT6zt3xbJpxJea4haH9eVns63yvg1u0mhA2mo1DiXMVIBPh008kUutX4YJCcu
         Td/i4kUHmRCDV8MTBpfUoAzRuRzh0xissYav95+qCjId6N0RCwKQpjc2ROhdNAQrEeLk
         vE+ywO/PBIFxi37LMLKde1t9GmpbWFjv2e2IbPdkeVzc8JDd5S92BUj1kwdkUMfGfo7E
         oR8ZgnrSj/9QwkTkxryVk4gXzCBaeXEesUBpRwIpEyvsxnq6dOMECKfOH9wfn2W7zu0m
         Xt0Ao+9KcRo3EIzHYiwVUjneO7GGOzpCgJURk6suX5uRj0qt27Ij/4evzLuOAykqj1p5
         U7XA==
X-Forwarded-Encrypted: i=1; AKwUvBzWLGQUx/kGeWKz2qhZpUAW/5Kd03qNh39OtX3/XKNoUCAKO5dReY0TueteExall8+d2iP87RI=@vger.kernel.org
X-Gm-Message-State: AFuF++nulDlQFFcaTPHm42y4H1OVqTNgoFDbqtd/24ubjK8UK6HQXG+U
	ayX3IuIt96tP/IE2GM1v9EbM9mopyYOcHimEvuk+JfYFiQpdklyWbEzH
X-Gm-Gg: AYBFou2m0MBCchorjpb+NkpDEXeJYe3CFlkf0J7rlGZNp89YCyGZ1XQtXYisD1MZVry
	YBW14ROYGt1Z0vDpngehAVKCdS92blanZwIj17q11VcPiyL57zxPNDRKcO5DKPty9BYxlSjGElB
	AacKFE9EhDmvrFNgWp2gHpU/CXmjSLFTdlgEfYpUUec+mg/H3LGIUI31cryux4cHgs09ERYTKaj
	Z2pa9lnoZxKze0PZcSSEC7aff92eXiwhIXtBLbK2XJP6U0rgWl6WQn2GGy9vpbC2xk7Jf4Qv/hN
	2AuSJY/fP3JOq4aCf4dJbMGvTQ1sfzpu3Bzkh6wqR8pwVwVAvLl55r3Zm+tGXwIUd24ZzguUdyR
	OpVNKvkps2IB3U6nKuFsUZD5DfNxwRlQOCTcg3LuqRE8HqCRfyRdLbZY0mrAJ/1gCbRNzUyYuq6
	ip2uncMe/JN2ZfM7PHWtPwCmt0I2M7U3sEG1PLjJ/tY2xEed8Hd0pJgdBOlDRnRzhTkviVr37Qj
	LXiUXdv6ZNJfH5ffkOahG5mlON7ggyBm0xzRzK84GZsGBZ5Ark6bBTJ+XZMdGQFk7hqkPepKL85
	zGxrea4IzGLXfAL65+QTMhfLvrsayIIs3LtWMbIqmbFO2UxK+tszXyXjW72RG9DbqnqZgn8YJKV
	pGI7qaTU=
X-Received: by 2002:a05:600c:3490:b0:4a0:1b14:e845 with SMTP id 5b1f17b1804b1-4a0274d1600mr67284215e9.2.1790976068456;
        Fri, 02 Oct 2026 14:21:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-af35-1901-81da-eee8-c2d0-ee3b.310.pool.telefonica.de. [2a02:3100:af35:1901:81da:eee8:c2d0:ee3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm111894055e9.1.2026.10.02.14.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 14:21:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: mctp: Make flow KUnit coverage an explicit opt-in
Date: Fri,  2 Oct 2026 23:20:58 +0200
Message-Id: <20261002212058.25117-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCTP_TEST selects MCTP_FLOWS, so KUNIT_ALL_TESTS builds flow support and
SKB_EXTENSIONS even when no transport needs them. KUnit's style guide
says tests should not select otherwise unused functionality. The CRC
and crypto library tests use explicit ENABLE_ALL_FOR_KUNIT options for
full coverage.

Remove the selection from MCTP_TEST. The core suite remains available
without flows; its two flow cases use their existing skip paths. Add
MCTP_ENABLE_ALL_FOR_KUNIT to opt into full coverage, and enable it in
all_tests.config and a dedicated net/mctp/.kunitconfig. Both profiles
run the flow cases without a hardware transport.

A plain MCTP_TEST=y configuration without the opt-in now skips those
two cases. This is the coverage cost of leaving otherwise unused flow
support disabled.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v3:
- Keep the core suite available without MCTP_FLOWS; a plain MCTP_TEST=y
  configuration now skips only the two flow cases.
- Add MCTP_ENABLE_ALL_FOR_KUNIT to retain full coverage in
  all_tests.config and a focused net/mctp/.kunitconfig.
- Drop the Fixes tag because this changes test configuration rather
  than fixing a runtime MCTP bug.

v2: https://lore.kernel.org/r/20260928205352.30502-1-kmehltretter@gmail.com/
v1: https://lore.kernel.org/r/20260925192510.93840-1-kmehltretter@gmail.com/

Validation: The MCTP KUnit suites were built with GCC 15.2 and booted
under QEMU 10.2.1 on an isolated source export from net-next
014d795c7383, with the changed Kconfig files copied from 071876fd5048.
Without the opt-in, mctp-sock passed 5/5 tests and mctp-route passed
21/23 tests with two expected flow-case skips. With the opt-in, both
suites passed all 5 and 23 tests, respectively. On the full
071876fd5048 tree, the new net/mctp/.kunitconfig resolves all requested
symbols and selects MCTP_FLOWS and SKB_EXTENSIONS.

 net/mctp/.kunitconfig                        |  5 +++++
 net/mctp/Kconfig                             | 16 +++++++++++++++-
 tools/testing/kunit/configs/all_tests.config |  2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 net/mctp/.kunitconfig

diff --git a/net/mctp/.kunitconfig b/net/mctp/.kunitconfig
new file mode 100644
index 000000000..4b2969e42
--- /dev/null
+++ b/net/mctp/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_MCTP=y
+CONFIG_MCTP_TEST=y
+CONFIG_MCTP_ENABLE_ALL_FOR_KUNIT=y
diff --git a/net/mctp/Kconfig b/net/mctp/Kconfig
index d8d3413a3..a89678428 100644
--- a/net/mctp/Kconfig
+++ b/net/mctp/Kconfig
@@ -12,9 +12,23 @@ menuconfig MCTP
 	  devices, you'll want to enable a driver for a specific hardware
 	  channel.
 
+config MCTP_ENABLE_ALL_FOR_KUNIT
+	bool "Enable all optional MCTP features for KUnit tests"
+	depends on MCTP=y && KUNIT=y
+	select MCTP_FLOWS
+	help
+	  Enable all optional MCTP features covered by KUnit tests, even
+	  when no transport needs them. Currently this selects MCTP_FLOWS
+	  so the two flow cases can run.
+
+	  Without this option, the core suite remains available; the flow
+	  cases skip unless a transport enables flow support.
+
+	  You still need to enable MCTP_TEST, either individually or through
+	  KUNIT_ALL_TESTS.
+
 config MCTP_TEST
         bool "MCTP core tests" if !KUNIT_ALL_TESTS
-        select MCTP_FLOWS
         depends on MCTP=y && KUNIT=y
         default KUNIT_ALL_TESTS
 
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 31e930a0f..b3ea56f4e 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -26,7 +26,7 @@ CONFIG_GPIOLIB=y
 
 CONFIG_NET=y
 CONFIG_MCTP=y
-CONFIG_MCTP_FLOWS=y
+CONFIG_MCTP_ENABLE_ALL_FOR_KUNIT=y
 
 CONFIG_INET=y
 CONFIG_MPTCP=y

base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
-- 
2.39.5 (Apple Git-154)

