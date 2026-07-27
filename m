Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6041A55A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170565; cv=none; b=i9GRuBoskLymvrOaJ0wwFHJaB+vtwlxm25CxfR6/VgjkqYE4O1CAL9SnPxE4YsOI7gEql7eZiumhGtyvedSwv5siyFRgkeMZVFNfLiL3vvxJbU9gmVg0WhG25XUZf/JK+cgvvX8uiD5u3o+WP0wwmRgcgC/kBDutm/MwP3uoY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170565; c=relaxed/simple;
	bh=5iDeJYZCeHlUEOFlUtiloIg+gGjFgM3gS9AjSTu4e5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjyqotCXlsHEoSsT7z4475TIciqN7WSG/iW3C9Xg/m1l6gRfnRTqijB2DwKCbRKeS+heVnul5WO5qulqk4HpMaCoXCoP1sHrZ9WcgoiE1J264pp1N9fGPZj13a26L1oz8y4mSbbq/z5gHGp4r/fqW+PICXRjX+NM+Vxj73JpkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2MdP7yZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2MdP7yZ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso2129461a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170563; x=1785775363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/mja1ICKKRcKhj2TUV69tW/v5dEq/nIAR10ed1zRw0=;
        b=N2MdP7yZHLFHzG6fCLYxuMZgxmEhx/+4JjL8qelSZ9zJ1qIStq9nCq1WP6DP3PB44Y
         Cw34711FTKq3/nBVZWJ4mNcJNUsMlR4VTWdYPcYWNJXDgo/2JN+QgxfSpDa39ShB82Rd
         kkoR9W6pahkeLcnroGzmJBzmyGmf2Ml7hrKqRZUeWNGkSrf7X/Rydnbf2GprvGkqRSeJ
         heLxevUAgC8Pv9iMUpFyeVbgM1oSjdOlWKRBFNAG0lgigqRF9gXNNnHsU7N+OD4+2lul
         4gOdXYDn0JUHhHeJ47jdx+f9eggb0vpPLFCCw7QN09e3zgDPoUNmzAG8QA5NgypHMZsp
         wzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170563; x=1785775363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/mja1ICKKRcKhj2TUV69tW/v5dEq/nIAR10ed1zRw0=;
        b=d00y8IjSkBWo40ckNbCI+9qcRmVcDEnOgHuYQKQyUK+hMBvrLx7JfLUhVFBvuV4VkW
         6g0YgGmkH9l9vA7rRAVooJaZtKBbUW3bV/TZo1WKXPSREQ0HCfy/9FJXOVv4ii90ZPm+
         a3RtxMbdr1l49PsPjqZf0b8zEU/UfHpcN1DFttJHf68jlbztj+lEPUPLgExocsOBAHvA
         gkGLgZ0Q/y6lbFiqiVG6MmPorODbwNXr/KoO//QXPb6TtjHDNTm04/yH1VOotN3Vil4t
         FnsxqxFcBa+xhuIhxkJQU2wOq3tWZhVGai0UreW3XdQyHG8px8m+70KHWGg7DbokuLxh
         mRYA==
X-Gm-Message-State: AOJu0Ywzn51WxHX85FKyHzxiwxjvqv6Rhga0iTQhecURaAecRc/UfQpA
	cLcppn99hHODBgil6L+pqlnlnrKagyuVGTnNXhYs6XfRTFhepRCC0r2rZd8UFHy1
X-Gm-Gg: AR+sD120LpT8RPLnVQ67Yt9xIiMNUMQ6QXIqARuj/Tkt1Mdx2D+oaI046jHUI1wOn4/
	bQdNtwlqSHk+FPrTyX3JOllLVmLLHEWWOmBH0fvyCjlsrHpnNgE0AB4etyq8oDC67qQtVIxTlsx
	MhzgVKFcfp1vwyvTlPh4e6pzpWZQl1dYo/dPWE2+93ptyJipe0dPEkA1adLZnhAp7iU5CVe+WLh
	XQp2KlwxXO4wzNVlZXS8tOOguLCGjDkr6+pxoNDXfgp8Tz4GCU+Bq4ZysHisVtyv09szGjVw0qZ
	+laIyDXYDdVJ2sNsaurkegf3HGo98gJYy3Y07DzziKsSefLMZ6izyUKWhr+hSRMrnzxlk/Sk8K3
	TaznUwzqt6nI6pNIxKqXU8NNebsbtFb0XQu/gcVtg+PmX2HdZHSMY2if+WsQgKBkA7lahtc8aan
	5EJtisD/4ZfSjjb2u7mkH07XjSV/cDS4BvOvLnYp3+JAb4Ueuuk9ronKvvpAJ/T22MZZGdQHG5g
	4FFRsk=
X-Received: by 2002:a05:6a21:700a:b0:3c3:98d3:c20a with SMTP id adf61e73a8af0-3c67e06200fmr8594388637.47.1785170563078;
        Mon, 27 Jul 2026 09:42:43 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc59cfb4sm33227566eec.26.2026.07.27.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:42:42 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/3] net/sched: pie: correct tc_pie_xstats field documentation
Date: Mon, 27 Jul 2026 22:10:56 +0530
Message-Id: <20260727164056.106203-4-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727164056.106203-1-hemendranaik@gmail.com>
References: <20260727164056.106203-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments describing `struct tc_pie_xstats` do not match the values
exported by the kernel.

Update the `delay` field comment to indicate that the value is reported
in microseconds, matching the `PSCHED_TICKS2NS() / NSEC_PER_USEC`
conversion.

Similarly, update the `avg_dq_rate` field comment to indicate that the
value is reported in bytes/second, matching the conversion performed by
`avg_dq_rate * PSCHED_TICKS_PER_SEC >> PIE_SCALE`.

These are documentation-only changes and do not modify the UAPI layout
or runtime behavior.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h       | 4 ++--
 tools/include/uapi/linux/pkt_sched.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 9a86fa4d6846..26b7e6964adb 100644
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
diff --git a/tools/include/uapi/linux/pkt_sched.h b/tools/include/uapi/linux/pkt_sched.h
index 587481a19433..9bc190f0b3cf 100644
--- a/tools/include/uapi/linux/pkt_sched.h
+++ b/tools/include/uapi/linux/pkt_sched.h
@@ -847,8 +847,8 @@ enum {
 
 struct tc_pie_xstats {
 	__u32 prob;             /* current probability */
-	__u32 delay;            /* current delay in ms */
-	__u32 avg_dq_rate;      /* current average dq_rate in bits/pie_time */
+	__u32 delay;            /* current delay in microseconds */
+	__u32 avg_dq_rate;      /* current average dq_rate in bytes/second */
 	__u32 packets_in;       /* total number of packets enqueued */
 	__u32 dropped;          /* packets dropped due to pie_action */
 	__u32 overlimit;        /* dropped due to lack of space in queue */
--
2.34.1

