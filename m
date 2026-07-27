Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B042A17A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171084; cv=none; b=PvGjzyRyvDDF+nY/viOQiPSd6xZhV/+4YRwk8AGPlBWlyst/B31xouCGoHoLbq3GQlNj1c0Aop03hbl6KuNFD7xrTsvufiED3W0jD4z3EY3iNFhu82xzYVBkbq5sBWHZXtDQaOJFdJVJaXS5mz463yVGfvz1bbGn6BcrnQdOqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171084; c=relaxed/simple;
	bh=aIbjj9p0LpeRUO6uWv02kDQ8Vlm/Vfl+BTsZPPvK/oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rf1blpNP/lOFlAVWmQJhQxtsn+FD75wQR2m1R4BTJvfEkC0a/qvrz+TJ6ISrPkuaRVRnr5J5KFTqpzXd3xnlGUq68yBdXnxUscvz4xhhT4nx/bheyUtJoKhXGQxMn6CNG530bpEDUJawMAle03mECwlAE4zWxTL6HNfc+Ex/+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6yc6Wm5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6yc6Wm5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2039142a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171082; x=1785775882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cDnHI30Jpscx24fIhxZkeP/i8DuyUWzJvO8mKX0g8uQ=;
        b=I6yc6Wm5nj7AyuD1LBbY1gprxAQ30e+Jq8WUJQEMeFz8I/NZTlLaykUks8uVK3ilSV
         3VwQIttfm6G4HewVpGIL7Jwe+x1s1mQxY8kpfq0IYCgFxDydXeX9ZcFCF+W6v9ASrH/Q
         WCHEhYKx4JQQO51+8/rb19rh4UC3SnhLX7W3Jbsi827PpgvWMl9OjKhT9EfH3s+SRiha
         d06u6W9Jmzoxm7fOcBKtl8ED3/XPOgI45xDzVLwwrpKj7CCjkVB0KfLRIQNbBNoKF40O
         smy5Not0PajVf1WEExoFODSyT4lsyoa3NQucpGdFR7+N23f19R8YdUEcc8hvJcBvDxLa
         jHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171082; x=1785775882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cDnHI30Jpscx24fIhxZkeP/i8DuyUWzJvO8mKX0g8uQ=;
        b=qnFWJz1NlkO1ehiQq1x+8ciLy288ThNLP2uhSqpEISGxdMMiAopxR8hBhtTY7kHNTE
         HzQtHjXfa1WOr70XJgcZ6L16mz1YIoliHvg3Y/acihjpMkJna2PyQCp4eg64FaC/9Quj
         79u4G2922FWMRo0fep6YpMutVqF2fG1cMYNEbH028CldKKis2PNV1YYtIzpDYZsOlLAz
         sxaRtgEk8Z70h3LpYi2pbseKhgMfDI5jS3aVfb26VzRFWnQ/BkCOnfI6ZdXmMZYwIrMQ
         +RjfEH9a917V/AK0pwo37LTMom92GlEOa/EBf37iSTc44A/KcWQh3r+HTYb0X7iQp8WU
         b5XQ==
X-Gm-Message-State: AOJu0Yw1B+7Zh/VsEZohsxUYKw+y2ZG6Zk3ZAwfuhAW/yeCVShRrkRGA
	J1LJ99ScDQVI3qTay0DtM3SujFoG6jZ8p+FIM9kV54zxedYD0tieUrb21PTXC3/D
X-Gm-Gg: AR+sD13rhCxHyiq7jwAfpBDQEVB7OAgYLzK6Ke5rXynXELFPta6oANRwf2hQOhqaVQk
	FjUnorZEM05Fv7+bnIiZt/Acs5Z+CV5VXXxclkJisSPAHkcsB9nDtFoaxPWAo5Ue9md0nAQHtqE
	tmbZY9TbwxMcAxdah0SuypYHvW5UVXDWjsKLFQW7YFXkNYnarWVMXcMvv0AgoLTYbjZQPRrz+QB
	gJzo1yzgviDd0AKpxLGXPQqdnSZdCaWBFnw9XM3pcvnr2X9ss7un7PNRcbpl4wDzsIWG1eYHrjH
	t6yv6HSx/OyAwcKs69QKSJAQNaBJlwT1vFaBfWiz97LW5go/YswasY+WjRTBcpAn858PRVBRQ0a
	PSSR4y49r517LI0b8iIa+0ho9K9yiLloNxxredL7hMvMw56x8pCgPlUZwVI8yU0EmWmkFEIi+CW
	8FFNvRN21u3DKo4D3zBhqbRAWHnYAmdzUSrMcLA6t3PMSLTSvsXfOSk2vbAjGdfgiz/HykT/U8a
	cXVtQ==
X-Received: by 2002:a05:6a21:3418:b0:3c4:ddc:e89e with SMTP id adf61e73a8af0-3c6c8043947mr369900637.52.1785171082471;
        Mon, 27 Jul 2026 09:51:22 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm33654029eec.11.2026.07.27.09.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:51:22 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v4 3/3] tc: correct tc_pie_xstats field documentation
Date: Mon, 27 Jul 2026 22:20:28 +0530
Message-Id: <20260727165028.106817-4-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727165028.106817-1-hemendranaik@gmail.com>
References: <20260727165028.106817-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the comments describing the delay and avg_dq_rate fields in
struct tc_pie_xstats to match the values exported by the kernel.

Update the `delay` field comment to indicate that the value is reported
in microseconds, matching the `PSCHED_TICKS2NS() / NSEC_PER_USEC`
conversion.

Similarly, update the `avg_dq_rate` field comment to indicate that the
value is reported in bytes/second, matching the conversion performed by
`avg_dq_rate * PSCHED_TICKS_PER_SEC >> PIE_SCALE`.

These are documentation-only changes and do not affect the UAPI or
runtime behavior.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index b99312d2..574463fa 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -920,9 +920,9 @@ enum {
 
 struct tc_pie_xstats {
 	__u64 prob;			/* current probability */
-	__u32 delay;			/* current delay in ms */
+	__u32 delay;			/* current delay in microseconds */
 	__u32 avg_dq_rate;		/* current average dq_rate in
-					 * bits/pie_time
+					 * bytes/second
 					 */
 	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
 	__u32 packets_in;		/* total number of packets enqueued */
-- 
2.34.1

