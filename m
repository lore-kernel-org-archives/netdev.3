Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A9376A1A
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789798407; cv=none; b=D5waZ0yGfyxMxuMWhgQlqCmzHm8Ov6P5qaZrSebX8NcieQ1JdAwgWye0EBAk8uSwZiAvjhZmXjO6lhRlR7k0I8c2HKEPw9gfgBEhdM6hbcPfO2FX5fvFoLv0FJX/9y2FskABA+gLG3p7O5L4+sO8cELkOslcNowpc7vjrj9+3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789798407; c=relaxed/simple;
	bh=edSqkUf/Jp56J9Vg7c+aqfiXzucyWX6M92AvRsKUe34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qw1fNKTCSeke8wo1Cqi0GSNUPIT/3asGPcZw2IMZF1kPP0z8UcWYd+ADOdbmkNjOhDEG6GsCsgAFpbMWf44+nEoqCJxCsXtA+W1WSBYF8c1lAYH+JPsn4fCOAQj2Q7fO93eW2amC2SxSQmtEQQ8EXFLqWgU5i/2zHhTUzcAZllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7dIayXf; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7dIayXf"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso1176412a12.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789798405; x=1790403205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
        b=e7dIayXf96ImzZiRGXgPZ7JIpx33TIts2+m4uHQjrqDBzS6byEltRiCJN87NMJtZA2
         JwuMKBECJAayWlxQEMV2CfkEjTPtUM2ySfNfoK6Lc+PhA4sgRpN8EoX7aHvL1k7+Jl7e
         /uSBoUYiAfPSDbcDVfLTZa4vT8lqsRdKrKtGygPkWrw1KcO14Ebfj1TXidz+XKunJdd+
         98CeSLfG2vjvGu2pRQVTlHxuGbmsnmqOcbWA7Z91Hjk7BmSvbnbTjBUCJnCk6N/jGXx2
         Ly1fwjVIDKXeGyAGz4FSeHoKIBjTCCaT6HUXtGXqw+glE3k2SU9/+NYvlhNz1KS2rQMa
         lw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789798405; x=1790403205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
        b=yn3b3sipN3Pzwh59Bc4QQFk5Pzi2EypIr4RZGA4U4OZp7w772OK/WnI9xve0cs2tRB
         PsyTXdjgyDLi8O+an7xLGEWe86pL2+nnvRJ8wjdea3Sjb5x8cMFPDVbzYF/wjWUSZ0x9
         zh2LG02dGQrMGIu1AjV6mW1pKAzu1C9rD7spSryVeLBQRGgjcyRD81G6o9brePsxbbof
         EltW8Ph++UGG6LZzEF8u1UOoIOp14zJ1fyf/+FAZXaCQrsBcbuZDRePgnwFGWhFL/Fmq
         Z7gfm+BdgDIDT6mrA+2Sip8yjthWkcD9JKkigJYiXeou00//d+tTBPnWWjmZac3z4rSD
         aqDw==
X-Gm-Message-State: AFuF++mY6SjYCkdRb9DVXKYD7uwE9XRcsjLO2+iRp1kad6Ejfip6aN1H
	EyafT3G+mIUHHbQtf4Acy1Oxe8CaoFp5cVD9+ae5KdUBkdXeNo2zcIMc0rQC7ZEPbqw=
X-Gm-Gg: AYBFou1M+JvOBS04nBKa3TwFRpDXQtAZtOKWy36jFp2bhdE7zyGUH6NvCzHsWgEeJnA
	fU5ClhZvv3YdTTeG6FLPNUNPzCkSMZYRtxAgUonBDmqD/1p8bMDDb/XI0qFpDfyrFvDi5da8bge
	1+Yo3tH0QD3CbeSfKS6NBYoma5sP+xYSiTH6xWMNunzq9ICi0obATacxI671VOicrWecMiLga61
	SX+Jd4lZ1WpTrKoLJuEgs9VTYxCehmoyJg29MX4geTdr34XKXQ2xJ55eW6IDOQHEmSXWDWGJcA5
	hLnO3C0Euou3qpJCCljCZABobdL3VFI0m8jwDviiSMk6KUDz+dSocjFZaBFJAL8aHcoeTLUTSzq
	10e5jI+GX1aoLBiz07Df8cbFg8HESu1UCECjIhQutdcnmtLIB0D+dxCeJZwSNcAf33aQFCGXrz2
	/1aEuSx7rJkFan8rCvsmnqm4rQtRMrgWKa8l4lsb5HyiYhLDDbogERcj+djbmNr7ruLgBqISZHW
	hnPZshsJxmmZKptUTKRTCMD1TLKdtKn24kzJr6uPEWL+zbElPq7Meni4JT4psYB8geVk05K714=
X-Received: by 2002:a17:90b:530f:b0:39e:4c80:44be with SMTP id 98e67ed59e1d1-39e54e277d5mr9452265a91.33.1789798405070;
        Fri, 18 Sep 2026 23:13:25 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:d11b:773b:fa83:c49a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55f299fsm5781280c88.15.2026.09.18.23.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:13:24 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v6 2/3] tc: pie: print avg_dq_rate in human-readable format
Date: Sat, 19 Sep 2026 11:42:53 +0530
Message-Id: <20260919061254.39678-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919061254.39678-1-hemendranaik@gmail.com>
References: <20260919061254.39678-1-hemendranaik@gmail.com>
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

