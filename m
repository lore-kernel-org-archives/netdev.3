Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208718;
	b=uONx2MBrWMIEDsG2mRiLQEb/IeEcub8PdLzsarvyPUTmNc9tcagr+Xy+z3BL0zTLurWE
	 mQ/0dMYRT3TWak82iA0LiD4541VXipr7unDhFpHA0JuiTiDoBquoHO6DR4VRyPZg/YHIv
	 ZkLEVvuMXSVJ4qaMZgr9cuzCd3jvlp7aL2wu3ttBPzJxnsiGX450dsnhjCIrnbhgFFGj4
	 0e/nRfFulG3okouBHs3Fm6DMa0MOqQmOkm4cDuBmJWT6G80Jm7CJ7Vpz2qt5wT7MBig8Q
	 dmbv6lr5+bDY5YasTRy69HIlrR3iXWuGInUddYpGa3W8nniQaXDSfu7KK/VN1ZM00/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
	b=wjPdwmSK58sSk2AbDTplp4Wm3V9sVmWeHT5lkurqu4hst9FdC7rrh92P20bSi5qA6ULl
	 6hsOHlAeG4VuqW8hxSYzygF22HuIrKCL16xE2HGtK9vGZvJaPQP673U9sbIp0VoNySwVH
	 Qfqq07Y0V8DjEd0ivm5Rn/Cgq0aj9MkBN5Uj+35B98bucvExoJuIqs+fNbVcxH7uL9Vq1
	 UJTqNxe+meHOSxyD/2hWtizXqyDbS70YaJKfCzf3EF3gR5XrjNVTy5zJSrLwh+dYa5VKY
	 QiahBE8YqW2UddHrnRCZR9LcExMQwEQPYXM6PtBzIjJB4tuyspGL1mM2aBE42f2gRrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aP68jvnT;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03B606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C03B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aP68jvnT
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3704d30b84fso696687eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208717; x=1794813517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
        b=aP68jvnTbpZapy6Yzp+j0XyxUT7J1SOhBVWtMR95VnYqQPS5Ve2hHUeJATDAC327Ux
         j+JDR1vrVtkmXc9+AQrzIwJr/fTR54c/URDXPe1dANdXYQ+8Plxeo3pm2DtQm6lfXMou
         hnsIJncFZOosC1L3nPs7pSRaYJwL+5BcKnUXQuwTzW019LkUzXRnT6eJjVTxkbGKkykL
         OeNWRzW+yVU+oR8MQf4Dz2b3+AJnsEzTGlVbGS0BK+6aAE3fm73zMcN8Bz5NfNZQdI55
         Ik3OattFwra8KE0SgUHXhTpVgNHHlASe8EeZwOtvl7Y/TNrdlHqahd+bnZ6bL0SqLRZZ
         OYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208717; x=1794813517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81pB+7IxOj1JIFRbnFGuG+Ebf120vc1g1oVisMJhAcQ=;
        b=cNo4+yNr6e5xanBoBFFV6cOB5ksRyhcFg7RpnHqxzsOXUeKcAU035Vvcc4/R429wtM
         gBLX2eqFFGiudq02cb3NFq322CI5/EiqP0qyz7e7BI2wdpE4PQ6jvxVvDWhrf/V171yF
         xWVj+tT6meAtwwdVOdITg7tSr0Mv5zinZSVzJmRF4s4l4ALT8bcnq4ZA4UmUt3X75cwy
         FhqtqYBAl7rxlysHy++Lbj5Gys8SH+Z85e43FKoUzYjUrn/N1xTHDU6IQDHXPFhzy/0g
         SGl76jscVY1vZ6AgAC5ADjCBkzxhnsImYi8Dov2m7HVBliB9nvlPJaymS2qt0vBpRh38
         627g==
X-Gm-Message-State: APuU4Z/IMAwueRMRk0rK2AMyVxaKjT71blTDCXiClL2FhYU81qhqqmy3
	O2FX+EJqr8q1zjHdHDGV6QDLjp5LXDr+5hQ4DBLDfbpCa1aqtih4YFR9Q2QtUf0lQQA=
X-Gm-Gg: AYBFou185AGTuhkTfwpHFC4CJfY9kAq0crfzmHV2WoPkcckKFGATy4xvn7izmmjvRAT
	bYPKBmHpIazjeXOwvLf2jHv+XLF8iObvtEJpcERdY1vixOwX7++D5kC2VCWn8FxEVI11m2aukPh
	8sVtlAKBL0qDk3/P+8eegkOyMmOanHN/I5JMMsxHBnYTej7xg9xtbmLSIXrTZKavOxGT7jBsjnZ
	z0PVGo/yg9z2XKgO/0Y4JT27GakvGbF1yeZroOcoAYOVZS3Zfk74oxatvtLxrUzAaiq/xsA+/eO
	RjwORjHZPbjXhSvaj9q1YHHLVDAxXD4pQSfL6SJyu2zDGdSNdFNKTAzrOHJUAkAremqz/mbYTrx
	B/gUIJZEqOqjjilZC/jhZd8IfK6vTlGwAMz45AIAEaa+auQZy+ib9qdggMYDm47rdIfj0MBFaJc
	sV8o+ho0xl9/a1xrEL2kw6mI17P0zQ3YsWvV92KWcnw7Or6NGYXA6Y26kehKodMYKCEXv4DVFJG
	2/wuEwe0Zl6qpHwJzMtABtC2AzkX3JWRK7flhbO3gFbIcjQZWHV17w1YVlb9gr5s9io0ANyVnTX
	4MGPMW1LJbPUHUgLIKeBlgRJ1IvdgcvXWm9ld1w6AjZQNiihIKDIoSWG3s33cPkeabwareZ0j1M
	9GkanfvaCNSKWK1jxdcnvyhsZEU1l
X-Received: by 2002:a05:693c:6219:b0:36a:3ac:b15 with SMTP id 5a478bee46e88-3725e53e215mr6020332eec.36.1794208717503;
        Sun, 08 Nov 2026 23:18:37 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12878306eec.21.2026.11.08.23.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:18:37 -0800 (PST)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v9 2/2] tc: pie: print avg_dq_rate in human-readable format
Date: Mon,  9 Nov 2026 12:47:48 +0530
Message-Id: <20261109071748.438946-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109071748.438946-1-hemendranaik@gmail.com>
References: <20261109071748.438946-1-hemendranaik@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

