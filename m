Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AF314A74
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829659; cv=none; b=ntjdABFw7brCNouGCHEsCWyhxNtKsOjb8UBdE6R7Agc32VR/SRxnHfWykSgcDbuVowZiXhww1YuLFny5sbawt8HskWz2Xb+b3GLZSwYOfpSaoguftjKtm69FuvDgPsIi1oDnCkNOAVOi69htQDiWPC4TYHLacQ1G30gommnUEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829659; c=relaxed/simple;
	bh=ffIE3P4fa/fPncCz2g86l+R6RpAgqTDBQzGHjiQI8M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI/85kZkNlg8rTtx/45pr9sa+gmqS3vgsiCuY6ketfJoPJJzNg6R8uGtxaQ9B/b870UMODxOkDcnAdkDthuKxgwJnT6KRY+3gbBVyeaGFv8zr6lw+6GlPsNibwl9+IKDinbLibiIiEqDhMERc2w1K4uKqmpUDocDkFERmDLYZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xGG1vaaB; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xGG1vaaB"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b8675d4f93so4015410eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770829657; x=1771434457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETh91+dN7ZjIX1disw1c0KqDX3nHjAAGAD+RLQJAbVk=;
        b=xGG1vaaB9ua46JfXBH9vdTGiCgdyLFR5g/9nxmBx7o4Aw54QkAuzDc4/+Pb+I4bdrB
         CufrEWx5qCVhw2EIb4rYq6AagnIeECgkJzsT56BVRLF8+BQcLc3vdQgfUaVBSTjghIeh
         XpeXGTFuf65/AdG4yTXU6XXIoJu0lupM5Jybahjn83/72MfRCzneLfyHhLs2G3+lirTK
         9GqNquf1C7lozgk4iyQlh5E4lar58Bhg7qaOdHilwc+drBgJGmZV2BkjIUuNJSKFnbGL
         zg8S2SH6+0ScO+Qi1IMHL6CT+UYhEsh/hM0jYdX/RM2PVfqYk4bO9UN5bVzVWYwWqKji
         ERVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829657; x=1771434457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETh91+dN7ZjIX1disw1c0KqDX3nHjAAGAD+RLQJAbVk=;
        b=cz/EG1cEeWfl4zjNGCrh1+pmQnAwoZgp1uhWO3RodE79fC3x4wBKe7ghVQ0uj0R3Xb
         faIxd6MKky5QnM0m0yDtyPdR359tIUGRB9mWQSNKnNOD1x8H6SQ9QxZgq2KvmhHoAhQ2
         TG4Y5eE0M3dqSY3onXnpiAhbFgIAqe/uYrByeAodyt+svJWb1ahHhzjzuzOk4TKf1j2f
         +TvKxEJAQp2jYT7smgQMGjr1VJvCh/AKXSK7vKr4nZva9AavtT+pZMsYLhx8RPIrOzU+
         8YggYaB/icX2LqX23Bwk7jxos7pUCs+3XyaMnWydHKyi31YO67Dg8fzYdqqHiL52sHpM
         25LA==
X-Forwarded-Encrypted: i=1; AJvYcCXDyc4KrlXFaPzZQsIhBFExLK5tt3Y1ECNJhnpcJ02Cm3oYCdPqPiDE9FzxYkqHId547Jd7iPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYA/4xYauQD93VAdVcbIX7OsfXyanKew0pZL5MehbSSxwGIwz
	qRKZOFikZzYbd+JRKu9Ht9AeH1EkcC6siAWdS4FqjYPTKrGDXbXgOdXtWdTEMU7bHw==
X-Gm-Gg: AZuq6aLEN13mMuI7m3QPQ/AonUT/jFwmf/GAoNclURGMquEG0AiHp7v8Lo7GgBIIo90
	VTLOJw90q3dzUnxb7miSg47EOEWe5XrmwvNjrtTNqOANZpNhPfvrfLXN7u8mpcIZov88mJl5d0n
	hNz1J82gHmyIS+ehzZD6wR4dBvZLoZSpEk57BhuxAmt3KXBAidxFdXcWzv8g6xmTl1KrKEByheR
	BowNtnok/Ua/SfBJk2hSwCjmam41VUHwdDdWuErAnctv3hD8UlunoksXGDrnY0TAU+/fzHd35lj
	N2hd4ljkwxynWyMb24fQLfmvch4p8CHElFwf+WXC6AFpf2kOsW2HT3ZKQzLPHya/X20ou4PGU7g
	Uou40wzR4/t1ofJT2x5VaOYP2K8BSZ5jjenbEu+/4IY6TqPcQLQ7jjlcwbPuuaxOM9Q/tuaF7Uo
	zKw8m/4eXeIfLj9ku0ONrMdqXKfjk1HtKaabpANOBJ
X-Received: by 2002:a05:7300:cc12:b0:2b8:711:ae6e with SMTP id 5a478bee46e88-2baa7fae41emr1934eec.1.1770829657494;
        Wed, 11 Feb 2026 09:07:37 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dd00ae7sm1649496eec.31.2026.02.11.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:07:37 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: dsahern@kernel.org,
	stephen@networkplumber.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 3/3] tc: Add JSON output support to multiq
Date: Wed, 11 Feb 2026 14:07:25 -0300
Message-ID: <20260211170725.1514427-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211170725.1514427-1-victor@mojatatu.com>
References: <20260211170725.1514427-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to multiq.

Fixes: c91d262f414d ("tc: jsonify qdisc core")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/q_multiq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tc/q_multiq.c b/tc/q_multiq.c
index 63fffed4..08a2a3b0 100644
--- a/tc/q_multiq.c
+++ b/tc/q_multiq.c
@@ -51,6 +51,7 @@ static int multiq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 static int multiq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_multiq_qopt *qopt;
+	SPRINT_BUF(b1);
 
 	if (opt == NULL)
 		return 0;
@@ -59,7 +60,8 @@ static int multiq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr
 
 	qopt = RTA_DATA(opt);
 
-	fprintf(f, "bands %u/%u ", qopt->bands, qopt->max_bands);
+	snprintf(b1, SPRINT_BSIZE, "%u/%u", qopt->bands, qopt->max_bands);
+	print_string(PRINT_ANY, "bands", "bands %s ", b1);
 
 	return 0;
 }
-- 
2.52.0

