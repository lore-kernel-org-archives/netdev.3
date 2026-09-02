Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612A32FA30
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321236; cv=none; b=CZCg1UBwLZXPChpofwEkhGblG8I0SeNcayxXK+1+xeu1vuCtnnutUjbSMqRpU3W/fAY6+3FmB6ZLGnl7HyEQM4lzWFEUVATpXcgExmx6csTbMygL7dYIf1DWec8yiUkix9D2ftRyRHfnaCfJPSJLXP5orJs5OsRnX35R5PYBkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321236; c=relaxed/simple;
	bh=8OHaoavkJfqqCCpDDJNEQIHd13lV+tTEPVC+AXbCG3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsRtRxoWjIc1FTpcvKPCqBMg5B6n7lUhoyZoFMrmSwJ77Rj4JKGTC9WDl5ACBbwlaBM9bdfp9Boa+k4HaRubJqYB1re7hcBUFF4iKFcBl9xonLOQw2gHPS3BPwabv3DT5HrcP+cnZeo7ssdFvl99f7hSY1zjbJF3KcJc0NnyWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0ogsTNW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0ogsTNW"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39647184c73so1771026a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788321235; x=1788926035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zCkQQ3XwE7D3s7Qt8JOH3Nc/gZ6WzlcMVINAa0yLzs=;
        b=X0ogsTNWiN1CoFxDldQUhFPdLlwWvhV24MVCG7rc4sP7CbTHj+RJbG6dMRm+8vUld7
         W73m4BtyvhNX+8fBr+KGlnT6vdCTqKhfEjCFmRFKwxl8xt5Id20wOvcfUUPcyt2SBGKu
         NRD97JGVxddg5K4w+SKtwWeQp+DBQRvg43WdHOLUyDyFMxXhh7SD8Vjt2AcsoKnBqWkt
         ZoQVYjyupLtF0XWH+8/MNAWOYwT3+mYaZgtjLPHy83DEsm6Ylh1/TyMuSvnvJywGgdvJ
         yacLoTSbGpgnQOws+wrW+RnZ6g/AJycnAidwceXE3Q969kKGUarJsISgeqWlkTgaza27
         1JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321235; x=1788926035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zCkQQ3XwE7D3s7Qt8JOH3Nc/gZ6WzlcMVINAa0yLzs=;
        b=pFPBVpwnpnm38UTOYLhsDz0BJAT5krxpxksQgSXZR9SAoCaCaj/wX7PMNZLawxSIF7
         GXbv5OzMQ73XNnFQiM5S5+WEHEn9/yQt0PHIzNM0qccZ5xu1msz4yLeoiskveZNSzG/7
         DaGrfRqwA7vh3UoZJ8vFOcDuO0SrbBcnbKeElG1zeNYVmb9JuMfRuKvKpPxp3P69YYa2
         zjP5e5FgoUS21iH4QfmxNJef5gU7EpQ8YYqYEB1o1evaXtT8aKlS50BUMvHoWLcMEHW9
         HWL3KwGQjo07UfrboE6DwfdTxf2z6fgKBXU2XoPhMztzRkjRzfGKMMKQXS/F1B8CGSqz
         xNSQ==
X-Gm-Message-State: AFuF++l5ybeUjzyhY/py206bp80uKLN2qHMWlZkdOFq4htq9WD3CO5+N
	aJdh7+ZkHZyNV1he0uRjhtRiH6oQosDs9uy2Yy2gVhdEPvDgvINhs1Z4/KOqC+l6
X-Gm-Gg: AYBFou2isKbA/GbfDwZKMv4N8mB0m2R3GvIsp/EznV4VlqKkk8v2Jx6w8UNrYrT1dMl
	JAwB6rsXlMo5b7V7ErKxesEaqe5jNLgMHJu+cNTz7DR3wk+64dN3YHY2DcLeHVK/aXj1fmwLbyj
	m9MNHSbiRemJ+o2v6X9UUjoeCPLCCyJUy3CenIi81NlWgxEWPwkvMnXF/Gl9OORn8koBDliexjp
	0EaTpouvGp40XXCHlPIDb3X4D0ndXB1CZNRgKyro8g2fV9WExJebbTW6Q62erfJkRxcq8NKSx+w
	QRXBxJRC4lVScTaHdQdUBA2LiKzxHbTjwMqj+MAD8NOnH6tDr8bs1lSri17sgnXdx6hXvPir8Gc
	Vjm6565FtSRpL/B37ajkK+86a8NiglqCgDXr1PBYk/zN5inDPTeZnqgtbgH1EFCWf77rP/7WIlA
	KNwxy0fDxq4ssGkxJ0wclcF15H0ee2yE2/lrd7loA+VuZ+qC06BkHRMys5dbJLO9hA1PJC8wWBk
	zRjELbyqF8f+AR1zuA8dzxwE3P5Dtn8zX3X0e4rsiIbOooWKY0l/FVJon3edTc9
X-Received: by 2002:a17:90b:2891:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-39af6480827mr314795a91.17.1788321234802;
        Tue, 01 Sep 2026 20:53:54 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:5fdf:d463:f07:1882])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7987csm2502377eec.16.2026.09.01.20.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:53:54 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v5 3/3] net/sched: pie: correct tc_pie_xstats field documentation
Date: Wed,  2 Sep 2026 09:22:31 +0530
Message-Id: <20260902035231.81866-4-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902035231.81866-1-hemendranaik@gmail.com>
References: <20260902035231.81866-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments describing struct tc_pie_xstats do not match the values
exported by the kernel.

Update the delay field comment to microseconds (PSCHED_TICKS2NS() /
NSEC_PER_USEC). Update avg_dq_rate to bytes/second (avg_dq_rate *
PSCHED_TICKS_PER_SEC >> PIE_SCALE).

Documentation-only; no UAPI layout or runtime change. Touch
include/uapi/linux/pkt_sched.h only

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index c6373f410d11..e3f643627c05 100644
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

