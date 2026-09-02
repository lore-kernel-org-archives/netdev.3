Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6C322B6D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321788; cv=none; b=I04JiFQlHQBC/sT62DugC3bhlZAw3oRovOfOK6w+ic9+Ye5lvwoeQ17Z3lgGA5dt1MvMh1jKfT/3r4RCjsu8ILE/rz8kqNhqO/UlqXw0aH53CvoCKhzFe8rzEpaS5cBfQeoVWlyTg8cm+wCiG77LGlee0fIIT1vq8WHDnfeQaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321788; c=relaxed/simple;
	bh=SoxtGtvswyNwmDTaKUcDtA4UnRTDpDqtshYLIYVcMzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLqME/xEgYo3a5zxoS+EFwBfznZUGTN3F6LUyQP0lag3Y9mCVyOhKttErZatL2zgX8KTpoJaf5a2ykqX2mEKLJq3Lg60n6h7DPFw0IL5/unftUn361iZK9tbv3VroKBe6uatWpx0Jun1uycD+u9UMIWkwyRFBBq4foNDtk2VJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzU7mQCz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzU7mQCz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace91f112so5319635ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788321787; x=1788926587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58Y9oKcS4yE3xpNAKloXSFu28tdFsTIOte2A88s5G+4=;
        b=DzU7mQCzLHzKo2tEuaCcc49Geyr9XBUSnyZ1up3aIIo8wkwFIKfsFgzJoq4nY5rMPr
         UepxQDQBGybt5gqSjDhgTS/6PMWmfNBxleu8fClAQTFkOa7WcTSepWGh9mlgr9pL/sRk
         J9CpGboIN1Yw+uUWoA+i1t/sne9lKy8YSBOkDqF7FDDusSTxeR41vt5gI8FTJ7SxsKx3
         oWkyNyAr67CRquRtnevNBxOD3ttmfdWfXntP8EGFpnLkUZ5nEWRlfzszw92ITdIRggwv
         55kkHJypj1KiLD40UFM/jJmLn+DGCZ3fBsW3EJ4iVNI1Tpitq7mxgxLXEU6D4YCwm5vE
         IV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321787; x=1788926587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=58Y9oKcS4yE3xpNAKloXSFu28tdFsTIOte2A88s5G+4=;
        b=XVAULHA480Ph4RKfWEO67+RNzQUmJVYbpefCtA2qRiSoOjfpfZlqI6uQV3+0jUsbW/
         bOjnc+vy5m9dpKx7GHKCkEd493RXX6Wb7koW9A7EqXG9G8GVbLoOXZdW7tP+6D+SYFLW
         UhmKU5mu4/q2Wmn48cksitjPcYQXYsrGykIbgOW+S22K+iKqIheCFjMhD+L+lqhGYKhA
         Y8dmhs3/49ACqdAK62JTRnIIG4CU8f8+mqsLbf/TBfcays9KmZg2ejqDr300VHh5cn+h
         L3NE32nF29peJU0yZdK347mrBcyOnabl1pMOaEZo6miljtIKXy/GwNePkT1iYNOwxqCL
         P8Lg==
X-Gm-Message-State: AFuF++mqPXbbOAQ004SrueqfJxvVK4HOEkhAc50UhVz8VlB3AvtAgXgC
	r2vBuOyAb9S4Enj5krnm+dTjQXJalBYpnjSYXkd9+o/sPLJsqh3SIA+RUBgYo9Lu
X-Gm-Gg: AR+sD10VhMOj8t7q9uDO848Zdo1p+n4SeYS53PE/L/tkUNtPlKRyIvuXMlI/JSeTHwC
	9Voj8anTqGc+3qyoVJgKC9D0hKHKE7I8SGQ5uWbnBHJlCHHEptPx0TFH0SPpXAH6l7cRqSckd6h
	7VPPx3h8hlsEW8jtlz4hi3Ou2OOYojAnYuN8C4v8X1xyJtj3yiSOrKrhvknNqdopx8Jy4LDZSsr
	iSJJwz/okXHwB/xo7ZFb4o4jVkw8YeXuoXwOYq5vA9rhA8A9C/jMmjA6rvyAbXfB04YQkc805ZT
	6jjbPqLo1DjWfxwrXPJTSN3qA/a7dycRv9tSQrjVKBk/HWockNyvs1O9NUIcWhXM7zy73nXc8Y7
	3+O3ebQUKvcUvYJE5SRbHYS2+/sHG50gMPPK9+xyZ/o0cYn/+jS5UG2r6eMG27pEB/ySqW+Naow
	BvxG+SNJZUWWzwN4/6zUHn9nuYyAM8XFFDkLVkojQEWIdYmWXOetWbIKlYLSGvkdzeVbg4AjXUi
	DJ4dh6dUbMGHECIojjbs/q1D4qrh0ZWnyMMsQMIqXrMbASnYDKshRolt/IMdIiV
X-Received: by 2002:a17:903:388e:b0:2d9:49b3:abac with SMTP id d9443c01a7336-2daec7485demr29785965ad.18.1788321786638;
        Tue, 01 Sep 2026 21:03:06 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:5fdf:d463:f07:1882])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3364529eec.22.2026.09.01.21.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:03:06 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v5 2/3] tc: pie: print avg_dq_rate in human-readable format
Date: Wed,  2 Sep 2026 09:32:20 +0530
Message-Id: <20260902040221.83734-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902040221.83734-1-hemendranaik@gmail.com>
References: <20260902040221.83734-1-hemendranaik@gmail.com>
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

Update the tc-pie(8) example to match the new output format.

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

