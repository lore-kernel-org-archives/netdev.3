Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93940DFA6;
	Thu,  9 Apr 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739202; cv=none; b=kI3jGuQBPfJzFHiAaP5q1CsMQgKaMC3NtP3dEl6gImOtEvspn8ecowfx9lA0nwVihslfq5HMzWpg1LQp+ByxXDgv18vcmubZZJ3otOACM6h90qYPAp0tf5iMZDtZdkGZaky+4t5PtgRLqheTJiSau9JYQPC2MB0MzC3uqnVi0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739202; c=relaxed/simple;
	bh=LW61lYCpkysaz5n8/6MOvuMhnwcPHyK1fg7J+XtCC3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dEQx7wuZHgQhCqttumHYfw4XYeErZyN05LzWlofRrVPFJZ6Gkhct+42QXKSOOxiZ4cUx9KsejKe3Mjm8ND4Q5WPUKzc6D5uwLf95O3Q5N7dwsqgrS8KRG4zoJIrZn6trCYJ5ob3gWinjwWpnXqxkTmx3Dx/KJpVWN2NEq5dQtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SAtXMcKD; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SAtXMcKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wZ
	wwe4DyHbtAi+hv3AkRv/sNWKzP3XaahlaurKiPisk=; b=SAtXMcKD2BusVhXfH5
	9p8a9l4uHwsBoyDnpSw1kOY0YZmB6aE8ocRuNoqvL54/JS7Jx2UBOKmzHQdXYbpV
	Dj+g9+t3m82nFnMLPuzrs/QpkvvNABUOu7qayDbOzfLFxC04TkZtZJojbomsjGpE
	+nu0bsDj/GOfgI94kz+xOC4ok=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3f+XVoNdpEK1KBQ--.47655S2;
	Thu, 09 Apr 2026 20:51:34 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: jk@codeconstruct.com.au
Cc: yuanzhaoming901030@126.com,
	yuanzm2@lenovo.com,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net:mctp: split mctp hdr version to ver and rsvd
Date: Thu,  9 Apr 2026 20:51:29 +0800
Message-Id: <20260409125129.9210-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+XVoNdpEK1KBQ--.47655S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw17CFyrury7Jr17tF1DZFb_yoWDCwb_A3
	4xWrWku3y8uFn7t3y7JFsIy3yFk3y8Cry09wsxtrsFqFnYyF1UuFn7Xw1IvF9agFn7u3y5
	XFn5JFyUCr13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRuNtIDUUUUU==
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBsBatuGnXoNZtHwAA3J

From: yuanzhaoming <yuanzm2@lenovo.com>

from spec dsp0236_1.2.1.pdf page 26, the mctp header contains the
RSVD(4bit) and Hdr version(4 bit).

mctp_pkttype_receive invoke mctp_hdr, and get mh->ver whole byte 
compare the MCTP_VER_MIN, MCTP_VER_MAX. the reserver bits may be
by misleading used.

Signed-off-by: yuanzhaoming <yuanzm2@lenovo.com>
---
 include/net/mctp.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index e1e0a69afdce..80cc9c63f6ba 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -14,10 +14,17 @@
 #include <linux/netdevice.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
+#include <asm/byteorder.h>
 
 /* MCTP packet definitions */
 struct mctp_hdr {
-	u8	ver;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8	ver:4, rsvd: 4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8	rsvd:4, ver: 4;
+#else
+#error	"Please fix <asm/byteorder.h>"
+#endif
 	u8	dest;
 	u8	src;
 	u8	flags_seq_tag;
-- 
2.49.0

