Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513655;
	b=OXvPZ6+oD78uGqS5RI3JdKQOK7mfggZf7rcAXpdP/z8UuRnEUBU08UdkKWs0+3hCW9YN
	 JasOK8WeyXjfLoHhLcNj6JRAy4VyDaabrvv5BVz6dehqQTKorpZp7e4tuXXqHZUyUTuJO
	 i8RsedOpWBov/5vV9UZKGMwyCZOlofxUGMc2uEgfQ78DrO1fsQr6FsCo0mg8EDBQ/0eG9
	 +hMvLuQ0aq+9PCUo157LsT2rsXMZIqwGDAcP2jkbSjoMZc7esXg9YakRTGh7CiGpnuyn6
	 8VNZr+Zu4RTT4h6tMf/im03F4Af9l71YQzybilE9JEg5m32oCHpcJr8EmT0gegZjr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=24lMsuypZEODGJ/XVVAC7Z9OPdGduan4+qU1+RS/WR0=;
	b=FfwI7Q7IZI/uMWlec6ezF+ifKEIRMc8AJf29Q9GWFPtp2DeRZaggb1liNBaljVtQjXI0
	 faSYwCgf49ixdo116srFiYzBWGnNeQexJccdD1StLOL+bQb9e8PU5SIojkt2b1bgzv17S
	 aSRvhpcu9sYQEH3YBPIYlLv03QXmJnzGrjKVkOS8DeQcePKSGcrnMV9qOiyzSE/cdZ1C3
	 ddGUGAJGpEV3gjO/RCOph/og4Vj0n7Ox1vT3cozEkJiK8n2wq3L/np4H1ebjBE+0Ik8gD
	 B8h4a46N74s3RPR8uBk7dJ2cIRjM1lRp61fW/Z9137E3w27LAVwk9mcPxD01gd4GjcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=slLy2kJw;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2B606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB2B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=slLy2kJw
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9eb579c0eso1552735ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513653; x=1795118453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24lMsuypZEODGJ/XVVAC7Z9OPdGduan4+qU1+RS/WR0=;
        b=slLy2kJwmnsKIomRWAjs2yETifuY/LgyLpo/8tbsON90IK4cGjIOHU9tUCGHlId9lo
         tTtCb6rxn5wpQ4/B5dubdIvoKiDyVnF1HhJetXKapzahcu39ZYkfhJ+wDUrxBgtpSrqN
         GrrRCS9tErjarun28Ydky24w4xAtuBNz/npjz5ZBxjQXWdBCE0BsPVKABX79NvUaOlIu
         U2qxQD+XundnrfhB/8f2dRnaBW3mD6L8Kpk2WOm4H9hk3/FA6izVTuGpzN2KOa6bcPZI
         scq3jy2Mt0HMn6McYP3Ys9ZCJ2GxK0I9JEk6QDzE1bXV8BJ67yvYGIO+yn5U8a2tCeqk
         bz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513653; x=1795118453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=24lMsuypZEODGJ/XVVAC7Z9OPdGduan4+qU1+RS/WR0=;
        b=XN4U1y3Mhz+YqNacXgoFBPwQ4s3zAYVqj3ukxcZYiQ/SOQH8x6UVQu7uOY04C8/ma9
         DAoMwFozRgZ1SxTkPTuCOjbtA7HI/hBZkfLcdX1d+7QB8LTqmgmKgrpqk7mp/qSK9x3j
         BGZXrcSVo7nIoxEZ0x86mN8eS/E/zVYgyBk+Nf9g+InLv1qGW247SeVz1uR1EVlQPV+M
         qV3mn2WqwzYfnuH6Cg62TVi9kcBns9xukVxV5lYp4bT7MKZa7lw+OwJtARUEFKZeWqLc
         J/w5Qomg08N4kiTneu9gFNndxSgUm5KYWeqXl9TP4bOXc7mXtNcK/jXFK8tiXB+QRUcC
         DblA==
X-Gm-Message-State: APuU4Z/eVrcPCO8TtKdSDLc1Y37TO1pcIvXXaSETlLjXGVmi9acpxjEa
	/Yzahh8EqiX2R/CjwSYzkQhMHL37IV1Aj1JtIvmdsSv9slNTBvMp88tSHJ4ov74HCvk3ntzhXB+
	ZgrROYyA=
X-Gm-Gg: AYBFou2qfVz3uvcQFPMdtypz5KtgFoPuasRhDLaK3MbDDJegBjwCFr7NQAeoB4GlBo0
	71c4Hhs3v0RWZaoN8MHyMBBgDMuDiPc8TTw62H+966AnfoRC4yzyHfj1alqexuG2MrrSVx+NC51
	64NvTG4QzLxkkEpGdl+AoKfAILP7mQrwXxgcdifC2RONbCDcam7DH0Vxow3RiFyZiaoLpDEWzNc
	5Bqq7BOXDUmw43/s2SA6unyiHP8emLN1YYpI77v/nQ4x9KR5VnSIJGnCljCP4rZ+fb1qLrFtHdC
	PB+HW5xgQuA3na1Gca/gb3+Z0GXEtx29fKXNM9ct5tuCZoZ3NfzG4+1ilYZqakdJ5J0e78oY2E9
	5y7xc8zvZKvrbJY71hkM9Mb8qEEdoW8MuDvqgoW63i2saATUaPA0Nm/aFkjhrvo2tmiFpZ5xH0L
	dK8ruUBvZxinjbMR5u5qxRzpo63aHMBtTP6k42AYiAhavXZS1G5h8tT9r2+QLr2HMQrWRfvls2o
	TkF9bZrDmrsWyE1NX666SoW9ML4zyEj6C6XzHS82BOerE3T+3pvs7iyd7ONj4wttQHvOXwAesgw
	iVzaaUUczabk51iHDXlhKFMLExmsR4OxrVXctY9+zwG4TejBAUfKwlS+Xp/xnAJaftBL/nM=
X-Received: by 2002:a17:902:c40a:b0:2ed:4b23:c417 with SMTP id d9443c01a7336-2ee0da7f4cdmr3741345ad.11.1794513653510;
        Thu, 12 Nov 2026 12:00:53 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 05/11] ss: replay all dumps in TCPDIAG_FILE
Date: Thu, 12 Nov 2026 11:59:18 -0800
Message-ID: <20261112200046.2164391-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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

ss -D records an IPv4 dump followed by an IPv6 dump, but the
replay stopped at the first NLMSG_DONE, so IPv6 sockets were never
shown. Keep reading until end of file, and apply the -4/-6 family
filter, which a live dump applies in the request. The family comes
from the file, so check its range.

The ssfilter test expected the IPv4-only output; add -4 where both
families match and add IPv6 cases.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c                     | 18 +++++++++++++-----
 testsuite/tests/ss/ssfilter.t | 26 +++++++++++++++++++-------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 3c538a4e..72de0742 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -444,6 +444,9 @@ static void filter_af_set(struct filter *f, int af)
 
 static int filter_af_get(struct filter *f, int af)
 {
+	if (af < 0 || af >= 64)
+		return 0;
+
 	return !!(f->families & FAMILY_MASK(af));
 }
 
@@ -3943,8 +3946,8 @@ static int tcp_show_netlink_file(struct filter *f)
 		if (status != sizeof(hdr)) {
 			if (ferror(fp))
 				perror("Reading header from $TCPDIAG_FILE");
-			if (feof(fp))
-				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE");
+			else if (status || err)
+				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE\n");
 			break;
 		}
 
@@ -3977,15 +3980,17 @@ static int tcp_show_netlink_file(struct filter *f)
 			if (ferror(fp))
 				perror("Reading $TCPDIAG_FILE");
 			if (feof(fp))
-				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE");
+				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE\n");
+			err = -1;
 			break;
 		}
 
-		/* The only legal exit point */
+		/* One dump per address family; the file ends after a DONE */
 		if (h->nlmsg_type == NLMSG_DONE) {
 			err = 0;
-			break;
+			continue;
 		}
+		err = -1;
 
 		if (h->nlmsg_type == NLMSG_ERROR) {
 			struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
@@ -4008,6 +4013,9 @@ static int tcp_show_netlink_file(struct filter *f)
 		parse_diag_msg(h, &s);
 		s.type = IPPROTO_TCP;
 
+		if (f && !filter_af_get(f, s.local.family))
+			continue;
+
 		if (f && f->f && run_ssfilter(f->f, &s) == 0)
 			continue;
 
diff --git a/testsuite/tests/ss/ssfilter.t b/testsuite/tests/ss/ssfilter.t
index 4c2315ca..cc0f01a5 100755
--- a/testsuite/tests/ss/ssfilter.t
+++ b/testsuite/tests/ss/ssfilter.t
@@ -3,21 +3,27 @@
 . lib/generic.sh
 
 # % ./misc/ss -Htna
-# LISTEN  0    128    0.0.0.0:22       0.0.0.0:*
-# ESTAB   0    0     10.0.0.1:22      10.0.0.1:36266
-# ESTAB   0    0     10.0.0.1:36266   10.0.0.1:22
-# ESTAB   0    0     10.0.0.1:22      10.0.0.2:50312
+# LISTEN 0      128          0.0.0.0:22         0.0.0.0:*
+# ESTAB  0      0           10.0.0.1:22        10.0.0.1:36266
+# ESTAB  0      0           10.0.0.1:36266     10.0.0.1:22
+# ESTAB  0      0           10.0.0.1:22        10.0.0.2:50312
+# LISTEN 0      128             [::]:22            [::]:*
+# ESTAB  0      0      [fec0:42::24]:40520 [fec0:42::1]:22
+# ESTAB  0      0      [fec0:42::24]:22    [fec0:42::1]:44248
+#
+# Each test filters to one address family, so the address columns are
+# not padded for the wider IPv6 rows.
 export TCPDIAG_FILE="$(dirname $0)/ss1.dump"
 
 ts_log "[Testing ssfilter]"
 
-ts_ss "$0" "Match dport = 22" -Htna dport = 22
+ts_ss "$0" "Match dport = 22" -Htna4 dport = 22
 test_on "ESTAB 0      0      10.0.0.1:36266 10.0.0.1:22"
 
-ts_ss "$0" "Match dport 22" -Htna dport 22
+ts_ss "$0" "Match dport 22" -Htna4 dport 22
 test_on "ESTAB 0      0      10.0.0.1:36266 10.0.0.1:22"
 
-ts_ss "$0" "Match (dport)" -Htna '( dport = 22 )'
+ts_ss "$0" "Match (dport)" -Htna4 '( dport = 22 )'
 test_on "ESTAB 0      0      10.0.0.1:36266 10.0.0.1:22"
 
 ts_ss "$0" "Match src = 0.0.0.0" -Htna src = 0.0.0.0
@@ -46,3 +52,9 @@ test_on "ESTAB 0      0      10.0.0.1:22 10.0.0.2:50312"
 
 ts_ss "$0" "Match (src or src) and dst" -Htna '( src 0.0.0.0 or src 10.0.0.1 ) and dst 10.0.0.2'
 test_on "ESTAB 0      0      10.0.0.1:22 10.0.0.2:50312"
+
+ts_ss "$0" "Match IPv6 dport = 22" -Htna6 dport = 22
+test_on "ESTAB 0      0      \[fec0:42::24\]:40520 \[fec0:42::1\]:22"
+
+ts_ss "$0" "Match IPv6 src:port" -Htna 'src [fec0:42::24]:22'
+test_on "ESTAB 0      0      \[fec0:42::24\]:22 \[fec0:42::1\]:44248"
-- 
2.53.0

