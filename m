Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B13FF897
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598187; cv=none; b=TewL+RAoALFU0noP75TBW0mj6Sfl+pWPmxcFhBMuh0uutKRpGppYTfaXZ+vXPjhVdMc+CvlBhzt5lY9YMKjeTcFaWV98W5m7pIGOxrU0YiO7zykG0ulIJLDDc8v63d5LcVXcGZHJMQbiSrIWJI09+fMD7Hp0ra/bxDYVXDoHU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598187; c=relaxed/simple;
	bh=Cvd62BSbfK1YUoNmu2cB4JDmKSrIffYs7NUg+4REHIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAB+CIVLEI/a8gIJBry2yzLmhl4J+9p9g+N3E2F20/cdzbxnrrNKlphlzPsb8fo/zjBjrqokWxChTNx9y3RfWPmDXRXxtyuzpY1L5cdWDzCHyv/nitqroTldNcWqdaKNmCCMBFRLn6F22aLf4cOsafP4R8dV6u3oCk/hPiD0a9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqUNzFHZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqUNzFHZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efb708b1a0so105819116d6.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784598184; x=1785202984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13+pPfiHFxOsE9sDGlKpSdwFAptP38k5m91XQ1ijMSw=;
        b=QqUNzFHZPzCG3pDpkkATGqBqa6u+IZ99mdtBjCquUHRCYlnlX97GWpgOD+vNDlehgt
         qI5PCOCWiBcWYPk2StSsk9ZcwxD6v8JQvbeb/+kLpmIuHj27AZ3B91+NsFK5Qa+W7QbB
         27/1jFpsKrnxsIgLmO4wji95cSANXGwfvc5ioL2Nk6dxzeSC9xTcHBMWWlodQF6EEhv/
         p4CR/zKXjOTsglJJyw6Wha81teM634eFSsWmtKQs+6RLiLOAQElyxiPu16z1N268G4wI
         bHDP4j9iwM7YoH9YtlR4ebowGSb3vqft1rDxuJrkVeVuXWTHPuRPyMsZ8+zEvv46Z70r
         HN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598184; x=1785202984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=13+pPfiHFxOsE9sDGlKpSdwFAptP38k5m91XQ1ijMSw=;
        b=ft6EWuA9ROv0iKMVefPe6Cw8y7ey4QIbGIjWJslvAeZvY6A620aXK+FJYF2dO59E4C
         8Jz2FbV48VSV1q3GEPYFGXfb0ymKS0Cfi3HTXBoVcQLTDPWCYdH1L2gwc9zx33fmJnP7
         CCEONcAy2csKqT7jJwzUMopv0MlMZd+2GYb2AkfVljB/uD1vkdTHF+A4p35y4xtvDEFI
         rCNUa7UfuCOBhX+VvZKGUmoz7HvIGq7KAZA+L7i+HBkU7IJ2LOB1DurU55WbiA274q9C
         HMe/PzRxXL+u4imfbPF1SIjhWZ+HOnP6DViOxe/xe/Bf6hFvOxZ+vup9eBjpU23/DweW
         PX5w==
X-Gm-Message-State: AOJu0YxbBF6IGmF/2TXLxLlXPhWqufruHwOvC+R+jXyQe5tQ1xI/IcDC
	4bTc/JFyQwenBCrwERe9yzZZpC2L5khIuN/HH/RrCgnFzn0GzrdfuvYkBInGUtvo5v4=
X-Gm-Gg: AR+sD102jqWeKeiIjwcTu2ol7aPGnNlwe47hTC3eLPw2T72hB8hdoyKcnoWpo4dceRj
	nyCyesCGXKm2+cQEbYhsQATDkAWpWSC7sLhPtoFnPcIFOlcM390pf/eDhiGt31OqcXQAPEkq9o2
	813eoGEX2ugXTi4sg4jnrl3vvcUFZ+xQXsabhQSS5FQWv9BWs2EvHoi/lpjsfKHbBL1dot1/Heh
	h/wxCe5wSUrsgTm2tKdj8kdP85m1BC977LOaugpxw+rAL2LNUokcnGIra/4VssHUE0Qcr3uyTUx
	v+YOzvDXZwIx9IjhlVy++avfI1I30sxZJqH8c6lm+BZs1fYyq/O8UkdBbWEyttfKMNRhjBLmpdp
	sdVDHPQV2L+MNvVDCm48zZTj9S2z4CXrIeJZRV/OSeB8zmIIrOndqdhk2JIFlGVLpOX232j4487
	kE/cCMoRkZS0/5k1Qyh74NJsTle/f3BJ1e5fFlbYRQ810YI0CryMkEedfcynLoRFRfxgpQvxnMj
	iVXQZL3sTS6bZWU449RrNCxYrc=
X-Received: by 2002:ad4:5d63:0:b0:8ef:e857:c9d6 with SMTP id 6a1803df08f44-90778357dafmr156356076d6.22.1784598183672;
        Mon, 20 Jul 2026 18:43:03 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-13-222-20-6.compute-1.amazonaws.com. [13.222.20.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871f650sm104418266d6.45.2026.07.20.18.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:43:03 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Deep Shah <deepshah146@gmail.com>
Subject: [PATCH v2 net 2/2] selftests: ptp: add a regression test for the frequency adjustment overflow
Date: Tue, 21 Jul 2026 01:42:56 +0000
Message-ID: <20260721014256.1876-3-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721014256.1876-1-deepshah146@gmail.com>
References: <20260721014256.1876-1-deepshah146@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

testptp's -f option stores the requested adjustment as an int ppb and
converts it to scaled ppm, so it cannot express the 64-bit scaled-ppm
values needed to overflow scaled_ppm_to_ppb() and bypass the max_adj
check enforced by ptp_clock_adjtime().

Add a small test that crafts struct timex.freq directly and verifies that
an overflowing frequency adjustment is rejected with -ERANGE.  The test
skips when no frequency-adjustable PTP device is available.

Signed-off-by: Deep Shah <deepshah146@gmail.com>
---
 tools/testing/selftests/ptp/Makefile          |  2 +-
 .../testing/selftests/ptp/ptp_freq_overflow.c | 99 +++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptp/ptp_freq_overflow.c

diff --git a/tools/testing/selftests/ptp/Makefile b/tools/testing/selftests/ptp/Makefile
index 8f57f88ecadd..dd7376cc9bf5 100644
--- a/tools/testing/selftests/ptp/Makefile
+++ b/tools/testing/selftests/ptp/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := testptp
+TEST_GEN_PROGS := testptp ptp_freq_overflow
 LDLIBS += -lrt
 TEST_PROGS = phc.sh
 
diff --git a/tools/testing/selftests/ptp/ptp_freq_overflow.c b/tools/testing/selftests/ptp/ptp_freq_overflow.c
new file mode 100644
index 000000000000..417c0516622d
--- /dev/null
+++ b/tools/testing/selftests/ptp/ptp_freq_overflow.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regression test for the scaled_ppm_to_ppb() integer overflow that allowed
+ * a crafted clock_adjtime(ADJ_FREQUENCY) to bypass the PTP max_adj check.
+ *
+ * testptp's -f option stores the adjustment as an int ppb and cannot express
+ * the 64-bit scaled-ppm values needed to overflow the conversion, so this
+ * test crafts struct timex.freq directly.
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/timex.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/ptp_clock.h>
+#include "../kselftest.h"
+
+#define FD_TO_CLOCKID(fd)	((clockid_t)((((unsigned int)~(fd)) << 3) | 3))
+
+/* clock_adjtime is not available in GLIBC < 2.14 */
+#if !__GLIBC_PREREQ(2, 14)
+#include <sys/syscall.h>
+static int clock_adjtime(clockid_t id, struct timex *tx)
+{
+	return syscall(__NR_clock_adjtime, id, tx);
+}
+#endif
+
+int main(int argc, char *argv[])
+{
+	const char *device = argc > 1 ? argv[1] : "/dev/ptp0";
+	struct ptp_clock_caps caps;
+	struct timex restore = { 0 };
+	struct timex tx = { 0 };
+	clockid_t clkid;
+	int fd, ret;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (sizeof(tx.freq) < 8)
+		ksft_exit_skip("the overflow only affects 64-bit kernels\n");
+
+	fd = open(device, O_RDWR);
+	if (fd < 0)
+		ksft_exit_skip("cannot open %s: %s\n", device, strerror(errno));
+
+	clkid = FD_TO_CLOCKID(fd);
+
+	if (ioctl(fd, PTP_CLOCK_GETCAPS, &caps))
+		ksft_exit_skip("PTP_CLOCK_GETCAPS on %s: %s\n", device, strerror(errno));
+	if (!caps.max_adj)
+		ksft_exit_skip("%s does not support frequency adjustment\n", device);
+
+	/*
+	 * Remember the current frequency.  A vulnerable kernel accepts the
+	 * bogus value below and programs it into the hardware, so restore the
+	 * original afterwards instead of leaving the clock corrupted.
+	 */
+	if (clock_adjtime(clkid, &restore))
+		ksft_exit_skip("clock_adjtime(get) on %s: %s\n", device, strerror(errno));
+	restore.modes = ADJ_FREQUENCY;
+
+	/*
+	 * (1 + 147573952589676412) * 125 == 2^64 + 9, which overflows s64 in
+	 * scaled_ppm_to_ppb() and wraps the result to a ppb of 0.  A kernel
+	 * that does not detect the overflow lets this absurd frequency past
+	 * the max_adj check; a fixed kernel rejects it with -ERANGE.
+	 */
+	tx.modes = ADJ_FREQUENCY;
+#if __SIZEOF_LONG__ >= 8
+	tx.freq = 147573952589676412L;
+#endif
+
+	ret = clock_adjtime(clkid, &tx);
+	if (ret < 0 && errno == EBUSY) {
+		/*
+		 * A free-running physical clock (virtual clocks active) rejects
+		 * frequency adjustment with -EBUSY before the overflow is even
+		 * evaluated, so the test cannot run here.
+		 */
+		ksft_test_result_skip("%s: frequency adjustment returned EBUSY, skipping\n",
+				      device);
+	} else {
+		ksft_test_result(ret < 0 && errno == ERANGE,
+				 "overflowing frequency adjustment is rejected (ret=%d errno=%d)\n",
+				 ret, ret < 0 ? errno : 0);
+	}
+
+	/* put the frequency back the way we found it */
+	clock_adjtime(clkid, &restore);
+
+	close(fd);
+	ksft_finished();
+}
-- 
2.43.0

