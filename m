Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EF5505F0
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111553; cv=none; b=DdLv6Wy+wFwzwncSShYMVQjwZcMxsbFRX+RoHrcmOxNB5sImRHmjJ1TexenlMb84tE6FOhdjHCMBNt6DWHWG0mACGPbqKQzxl7xGxWDGFvatWwkrFSo6SKQq/nZd945Qet13HFUGcfJr89hJHLfp+jdqLletnCuy2H+gGFvzF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111553; c=relaxed/simple;
	bh=edSqkUf/Jp56J9Vg7c+aqfiXzucyWX6M92AvRsKUe34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVBDFI1sWC7i387z/dtSQcl3CXqLCKE0BqxtmLGrxRnhyoobq/H+ouNLe7akYt0OUOcnPt3WqjusPyOqaFTeaDYLaNgeNn+7acfe8uT+HpzmV38K9r7mLesEA1HTmCCClzFbB7olEeJ9QXGPm4s/P6hfh5NpGYbUcfpaziVeFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5r2OhKo; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5r2OhKo"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so141240eec.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111532; x=1790716332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
        b=Z5r2OhKoH2rzwFHmTAe2GsTvadG1fQs7fjETvvVPNSbJ8BiQznw2QS4t+hJi/7drwp
         MLM9mtIePDA7bWYiP7GnZhCAepR7mxqUHhh4S5pFVazpbzWp2ViSDHygGEeVxvGK7/iU
         EiIADIz0SUQR6AN0gsKlqIk+ZpWUSnQiDfmlU3n8yp6b6iRTnHufE/BGZdFAeH5IOtY0
         rIf+BsAbojFrcw6kYhvRIk9Kk3u9AHgDwKiToZbOsxjHfSbg6WUc36orDgyYz7Uznff9
         5oUunf3yg19ZsK4hYy6Lmnbl9oSNa4m2AyoDG714wU+IcZ2MWeTXllOrt1dVvIEqT16C
         bDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111532; x=1790716332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
        b=b+XeC8AU4ySt1cRSvRQz6XmoIrgmMAqNxV+BxHhyfdd7EXKkLBHZp55/FOpQg1kpnO
         DchjTvFV/mp2GhuUMrUCgg/M/+tUXCExEHHEZWAz/g7FTYazI4j5MKRT4hQtEpbhfvU/
         Ydwa7n9A1dVbPdP2D+RFMqHhp9yeZuT1gyAJVJDY3gFUgBIQVVjJHRKwGvzdHZT0oUis
         mSU5wmKUmhzIjh7nZP3UytLjJS69mKbkzXo1Zgxn7ZBCt9SGCbxiRmKT4xBphC87VgMT
         MOtidGbhbFnUQrAYh9O3VFY+upqHJKjB6xcP3eLX7UPJAlfqPPU2/pvcCjIasRNtwOiO
         vPew==
X-Gm-Message-State: AFuF++mqfQWxgr7c1Fye3BIpd747ocHL3DEt4rlbY5qKtykqKWLBxc6S
	IW3E9JxnCXzSl9aG64Leq/npSN1eLaj7VWMbUX4GHDj7UVmjnaazIXCd3WcXh8UV
X-Gm-Gg: AYBFou1sd4DTOpUQ7n89/fk3Kzw/8lQwyvcv1UGcVmhm+L88YRcFNeo1muo9otJEY0V
	3/RyO4rUxH2N1QUYbVPuPm5pNAPT7i0wBOkKoNr2woWA/2pnPK376qpuFvHfDb362uKEaQP6nsJ
	V9CIptLCqQD7Bo6c9V8BEernDr4gCULGL7Y1J80w9mykcL+76Meo2fRZfpy2Xaw6jAl7rrvmj2k
	Zfg77c0wZjepMYosjkEE1xm2u+pOtHb9m5qNsJJ+PVmL46k/u/Y7IekBdbPp+3X0XaGRIPZJM0K
	EuePF+Bs+jJB+l43skpBdMo/TKKJp82cq/ur3uN5phdqO3HwR8u/wp6eamjdlND9RwOz7lBYIZQ
	RSC1DrTd6QO0byXzXDkfY5n0icIxkjwzJM2xrYPPPTnFKiGWBvflhzVIQBzJRFArjW0ohDFh+Ot
	PNyVpJma8QvtjOnWJclsbXpVV/7vncGuhrMLIgifwXZlMwoED3YLekBFOxJYMYblf4Dr7kP1WQG
	wXoMDqlaQI8wRYmubzHlrrPKX7JNQ5O6ow1zA5hDk7Rl32jlaHyXF8p7jHSbu/sUVhxd+0+nuc=
X-Received: by 2002:a05:7301:3a86:b0:33e:5c4f:f46e with SMTP id 5a478bee46e88-33e8d8d2598mr486297eec.30.1790111531511;
        Tue, 22 Sep 2026 14:12:11 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:f16e:2102:25ad:9cdb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm943147eec.4.2026.09.22.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:12:11 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v7 2/2] tc: pie: print avg_dq_rate in human-readable format
Date: Wed, 23 Sep 2026 02:41:39 +0530
Message-Id: <20260922211139.38570-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922211139.38570-1-hemendranaik@gmail.com>
References: <20260922211139.38570-1-hemendranaik@gmail.com>
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
index 5a8c7820..ec0d4af2 100644
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
index 04c9aa61..97690d49 100644
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

