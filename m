Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD8F43A819
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171076; cv=none; b=Wknab3AP5eKaCamciejstZBNIVp0EwpfLG661aUwxLRLS829m7XWyW7IWzDgKh8zBZS67mf063ohAVPS+sBWiPQVdB3F1GODNX9RXQKETIboQA04uADumbIo6WkPb/Lra1i8wbuD9+4ycDF1cf/LK+hqYmdai8s4hhFFG566F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171076; c=relaxed/simple;
	bh=w+gQggLz2ygVklrRNww2PKnf2qaN8SGXtfmKjVAzLag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/dnGEl0NEbkxhmCs4QVCTmjWDDjNIh2Tn92j5SQ2hW5CAMyc5miwvCMmOlrJNXQ8ix1/oa9KtgtYkyQG7OIbbN8qV9arMkNGlH2agcItxPcgcgBPSIh5IeJhRm5vZpBqNMwD115lh8VgfruapRxEP6xEAz37yZp2SJW3JxlL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBr2LNfP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBr2LNfP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1721347a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171074; x=1785775874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0YoW7rq9EwGAe6gmsjLI6Ji7Fb/4VxS2VhGlxeHw6s=;
        b=NBr2LNfPqBQJV3Q1aWGTXZaLwn3THxzzsbSgWrIYzelddJBvUq4Wt/bcyujUtedJU5
         p/O5I+swdETcWT9VYWtmo7yIvgXJ3Q8cBpFicRV5ZKd6lqfStbjd1ed+kGaU1XuTgNaL
         g3Abar7oSl6374FFIUG/PSTVRAzddc9/cywlG5ke3ApBxoq52l+WtsiOQ3fdXo/XSdHR
         Ku9VyqxnVb3+34PdUziVfLdUvNpe3IUOhMccWwEkfZ5r7soba4pTuyRNzc6XoFIcIF95
         7ly3sxS45b11r4IMesIByQM7yo/gUvq58TCDllSEEgv2rHyw8ExboGBgIzuPTv2mA+iG
         qV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171074; x=1785775874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0YoW7rq9EwGAe6gmsjLI6Ji7Fb/4VxS2VhGlxeHw6s=;
        b=Qe6dQ2j2dYi7I2gDzc8H+G3L8Ey0AfX87J24ebkYSlv/FuPzOxZbX6avL5MLhdN9K7
         C1c16z5MA8nYmoADqfCBxvu8oELzLhjKBlnFruLXMtYyUFW8A1Pq5VacQJ+hbREF2OAf
         iU+6o2SBlvktLfu/CVuSlMC884YRyYspFOZWCMdmiP7zcyKyTwbyEAIuaw3E8Td8zlFl
         Bh6+e32yDRBozpy3HrqzENNbz9Tm99LcRFnlUR7OcDjTP+5/p+DyvdBkobBllXm/Y1ob
         cxhAq19tJ/LoOYmnYmi63oEF8Lse4i7CARQPNBpso026Nv/xvPmKMpL/8Vw+YeZhJBdC
         htdg==
X-Gm-Message-State: AOJu0Yw8mgBTmgXF0IRrc1+k7nXO71yLJPBQCCtRJsUOjuwZteKRmL6I
	0Ayag551YFDdtCzRRZ8oFczbMuXn3+YPxyxZg9havBGv3kAhIsb+aFLzTbQLfZJs
X-Gm-Gg: AR+sD13QqeilN6lYxq+4ixoFYhFkj/RiBnavvAOEZk305UuBGT0i9HDaC2uIo+Ud0Ad
	LT6+gAr1Pynem/5q7TjJ+ot2+o1XsLs5Hf/CD9+MIipfe6MJzTFIdOtjJ1kydO2MS8FxWm+lDL4
	8ILVLhGwTjyu699I0jmypF6ARjsuH2vxo1AoQWt3K9/52PZk5rcZ3rhsHvUFhlgG+LTEn2nvzcA
	hdFOXl7vwf5dGuYyTkTvn8wl8gZz8XAR9Srq1NJenRwxmZakeqR47MYCTDPn9+Bdlm9zenjHQr1
	ERBfFxgQdakr1yQRTn0NixBU0iJWe3hfsPSdgD3+OED/p/bgofjRCTJc7gIlAQr68Q0GU4YP0wF
	n17eLG9I0AU6EZ0eR79Z4DOK7igg2MFGIk6OtpIjWUzH5ji6fViaYqRG7pf8T0vvTvDx7l6VxEC
	krFVAyurlv+BfwwfUUug36u0VbvWE0e+iICI1DWM5wTZSq5Y922BC7lGljmae/znE4nyEijq4dr
	91JcHbdK6O4e4Nz
X-Received: by 2002:a05:6a21:9cc9:b0:3bd:4698:e7c4 with SMTP id adf61e73a8af0-3c67df0ffcfmr8009665637.42.1785171074159;
        Mon, 27 Jul 2026 09:51:14 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm33654029eec.11.2026.07.27.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:51:13 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v4 2/3] tc: pie: print avg_dq_rate in human-readable format
Date: Mon, 27 Jul 2026 22:20:27 +0530
Message-Id: <20260727165028.106817-3-hemendranaik@gmail.com>
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

Print avg_dq_rate using tc_print_rate() instead of displaying the
raw bytes/second value.

This converts the kernel-provided rate to a human-readable bits/second
string (for example, 10742Kbit), consistent with how other tc
schedulers display rate statistics.

Update the tc-pie.8 example to match the new output format.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 man/man8/tc-pie.8 | 2 +-
 tc/q_pie.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/man/man8/tc-pie.8 b/man/man8/tc-pie.8
index 5a8c7820..f3a09616 100644
--- a/man/man8/tc-pie.8
+++ b/man/man8/tc-pie.8
@@ -115,7 +115,7 @@ is turned off.
    qdisc pie 8036: dev eth0 root refcnt 2 limit 1000p target 15.0ms tupdate 16.0ms alpha 2 beta 20
     Sent 63947420 bytes 42414 pkt (dropped 41, overlimits 0 requeues 0)
     backlog 271006b 179p requeues 0
-     prob 0.000092 delay 22200us avg_dq_rate 12145996
+     prob 0.000092 delay 22200us avg_dq_rate 10742Kbit
      pkts_in 41 overlimit 343 dropped 0 maxq 50 ecn_mark 0
 
  # tc qdisc add dev eth0 root pie limit 100 target 20ms tupdate 30ms ecn
diff --git a/tc/q_pie.c b/tc/q_pie.c
index 04c9aa61..abae1ced 100644
--- a/tc/q_pie.c
+++ b/tc/q_pie.c
@@ -220,8 +220,8 @@ static int pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 	print_string(PRINT_FP, NULL, " delay %s", sprint_time(st->delay, b1));
 
 	if (st->dq_rate_estimating)
-		print_uint(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %u",
-			   st->avg_dq_rate);
+		tc_print_rate(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %s",
+			      st->avg_dq_rate);
 
 	print_nl();
 	print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u", st->packets_in);
-- 
2.34.1

