Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB04377AAF
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785623369; cv=none; b=uBhOxekM057LBt1lDL6JD6/pUcMbPStbEcSbDGsuAPCQgHvfpC68ndmxqg7uD3TclzWZRNSDlKLEZw83nSOiULkMn+ltB0/0sQbezxjglSteIcQh3rkJ+DuDgDbzDAxU2bx5J/XtMCIzXJfK6bh66J1m3VF4VhQbzr/WazcWDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785623369; c=relaxed/simple;
	bh=0frn8/1E2g2P+fUpThAiML8loGGJ8rAIh229UyRnt74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtoSE582ShUVbyXKvjNDsk7E8diFzNvXaMlOCzuodU01Tc3V7fC1EPSk/Iz8wkJyF+OIv+EV+wPMfyFJ+HLWlUsSVa3EKAcIobwE7Z+D7dY/NCriL2lNVAyYaR/yWkNO19NSs/58KuNBu2G9yTI7SCyCFnqyWt516Wejd/QUOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBlg+Mlk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBlg+Mlk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e67555e24so105646485a.3
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785623367; x=1786228167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qri4zx3w0KdMvYOIUh/Vq3TWzAXXnzlER5xidoSLn1Y=;
        b=MBlg+MlkAFUMBfyEWZAemjc3+jM744G7Ixr4Wc9R6rQJnb0q5X83hePfWtlD2+8AYH
         ufPjIn9M987+DvpXsTgkAgLOLYrfYU20RBpcSIBEnG2ncDeli+3o1LMXUmSNToz/3gaq
         MUgwejhLJUlg3TT73FXl3XUJW8vFa8HeIilzMmZNb6Hwyk9X7qxsA6MzOb+8gItGwCAt
         U4B1/CezRFCYKgXAs8D9fsjPNnBlzDwh3EeGgjwFnX/1jMMQRtsKSjDrjzahAyj8Mn5L
         DElxZrprZN047cOYH8JPzzFXcruLVi748QUvjtoOfC98Nl8xmgmhkEITQWH+b50eNyNO
         o+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785623367; x=1786228167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qri4zx3w0KdMvYOIUh/Vq3TWzAXXnzlER5xidoSLn1Y=;
        b=dEfELjXlkfZ0wBEixBwKFWlyf5Dpxp1TbXOBAifJ9Vm13a+qA3AaZBMPRiZhNy3eOo
         EMoKKGxVkokgkqvTsgZNjbNUrRrdmxlIBfSSRyKb1hwSNRvmYb/jWGjhk8ylC3XfR9w/
         jeebVbSQBB2l5Um6PwaQUZeX1yJKudI3Mw5uhVcEkRt8eDCqULWp+lGHEGMoNEyQaONR
         dNftT383s0/CwuL44PWE22VoWwJ42kbsptSw1btIcDTh496os16qXwglY3b583x0qzI3
         vbi1CkYkRyb3q7i+CO/SedroLktpysyhJROOmWr98mtKIqrUchS80ktDKUeL4wFGsO8I
         EaLA==
X-Gm-Message-State: AOJu0YyqDcG7eR3MWKAMzl/gq8IEegPTqEU56pdn0RwfFObkUKMiDYpQ
	iwO7xiGOZOdU8btxwzyAxzJamm7tUAI68en6ounBPlOhJjPNXgSTYfESo2T9cLyOXHg=
X-Gm-Gg: AR+sD12WIpKQcCTnJDu0ERJgyXRgG4KZEpUg1HOuF3IKidJ7dYn20WOGDJF0U94f7Ph
	usdISFSwAmT3RetOjNXOtT8LTNNIZ/v8eIMc9QFZKDUqxo7vBgIZ5z4tY+Snr85vaUzp97viLBI
	ypgrf6kuIlPXs/V/gBqpO+lecCix0gaZW1cXpouoBi7JNSR63Zrhk8WZHx6RaHKC4eycaVxgVFA
	cf7O408YkqXLCHSWJtnwHAQtg6vG4Yl6ZBndAK9ChnZc+8g8cO8xIkHuDK4RE76oVKwJOMgUEZM
	mpzMPCnST1HAK63nw0aHmOU0/0V7leIA2QubKUSDFl24Y65f+MxAEPH9DxzwoeWieyJFymnM8f6
	+4LaBY42OSpiQDSPNZkNN3K8JIPd7OiUy/SE9GRA/ZIIdtNgY7H0znKOR3Gn52JbQ0Fsrh9BEbj
	LkHg0V2uwOP45nRzzLtHNtbpXiA+9SKayhzcIY+72kwKWhTARJS4yd9OwuMSS191E4eLjXDQXxI
	F15aAKKPXj0LpWf7gfcoow1bGOXLwICADkr7heG0F7NX1sXMX8sntdJgQGaEpqQK+gv+jJ7Mfh6
	ku50n8A32by5t3So2G8ElYrnOQ==
X-Received: by 2002:a05:622a:1f91:b0:517:7b6c:4465 with SMTP id d75a77b69052e-52b56752f3dmr113230701cf.22.1785623366788;
        Sat, 01 Aug 2026 15:29:26 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-32-195-55-166.compute-1.amazonaws.com. [32.195.55.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb956c3sm33403831cf.22.2026.08.01.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:29:26 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] selftests: ptp: add a regression test for the frequency adjustment overflow
Date: Sat,  1 Aug 2026 22:29:23 +0000
Message-ID: <20260801222923.39017-3-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801222923.39017-1-deepshah146@gmail.com>
References: <20260801222923.39017-1-deepshah146@gmail.com>
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
 tools/testing/selftests/ptp/.gitignore        |   1 +
 tools/testing/selftests/ptp/Makefile          |   2 +-
 .../testing/selftests/ptp/ptp_freq_overflow.c | 101 ++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptp/ptp_freq_overflow.c

diff --git a/tools/testing/selftests/ptp/.gitignore b/tools/testing/selftests/ptp/.gitignore
index 534ca26eee48..e63194b44395 100644
--- a/tools/testing/selftests/ptp/.gitignore
+++ b/tools/testing/selftests/ptp/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 testptp
+ptp_freq_overflow
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
index 000000000000..e90477175958
--- /dev/null
+++ b/tools/testing/selftests/ptp/ptp_freq_overflow.c
@@ -0,0 +1,101 @@
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
+	 *
+	 * The cast avoids a -Woverflow warning where tx.freq is 32-bit
+	 * without tying the value to the width of long, which differs from
+	 * the width of tx.freq on x32 and other y2038 configurations.
+	 */
+	tx.modes = ADJ_FREQUENCY;
+	tx.freq = (__typeof__(tx.freq))147573952589676412LL;
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

