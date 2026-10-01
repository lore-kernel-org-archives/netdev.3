Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39D3E44E7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879857; cv=none; b=GbdTpd1FTtbLXnSGk8fxUH2LfOjy3BuKBvGn6JcnphWPSjPNJ7tUi/bjMh6KrLePyTv6NAyu7JNU7YcuLC1XntHLGwX2P9HBC6tvdMgDgZRJPxJAd91A6huwbHjKeVSKOKVRl76Eq2bsJNu8tYks84ED7Bio23FTuDdL9TyS1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879857; c=relaxed/simple;
	bh=YWun8H0YR2nw0WXj6WVMQy89qE6RkZv/6Uw7G0VTBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oD4ZYYEJYlCcRhBdQJx4Ch6c7NVBsmVnhhBr4T3BAwgl1kTllQJjNYCbw9EmwmqaMZoox46ynPHq6shZQluLya5aVydllth/OY120AV8DGfPxrcSoC1wRoqLGoG/FB41VTqFDEGjygv9IqI3pdpgEqInnoNabJ8UE4c//4qsEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=TmqQFLg+; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="TmqQFLg+"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881a3a28e72so2756734b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790879855; x=1791484655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+a/r8qcYWYjYyyBDFMdHDcTb8pTohi1Wmi87SGaPW+Q=;
        b=TmqQFLg+UIMDun0qsdewqMQvuo06K1mMwJ5X6vNZnrpeMOKeJD/y5BrZd3ptIgPNOP
         HcFhwRoJlofwU7QVvuRuuC8AGUbHjA09gk9RjvhPQEnOSt0o7G3PUFT0Ciit0FHsJjgM
         VmKIKcRgrC9wMRYzqwurAFKnnptn9DPxmjgNd2FetFPgyQaBomXBPg03nxdpBDxwGIDm
         YwH0I9LAcmY9JV7eVHNakFsraheSTyWKk/BnA35OUM+xrbi2hEcz6MEM9bLTCZH3/vAN
         9BZWNBWkGq5q7q3n8Oe3rEr+2n2zD/Vl3eZEbfJB75qFrZ3fvasCAStItSjG7VCYl/6g
         P+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879855; x=1791484655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+a/r8qcYWYjYyyBDFMdHDcTb8pTohi1Wmi87SGaPW+Q=;
        b=VLght8qsrd7/1qkVuVtwbE1tvSZKDVJ1+F8v9pQARE6H1QElwa5ssoj3yvlH9pynKH
         WE8VUSRDCSE68yd4PFC9LTyKxTlPorhdJCeolwmdF6mINcxPMCUxV4L/LoH12iEtPEVY
         bHdrjx5hfVksul6BaBJSuPQwjG3UrxBu5M3frT94eeasa9KyX3vBTgrvF2HsOiASJlkL
         x6Azo+rSjUzcpLITwrqIJr6aYxpayxs9XDk1dLiu/gb8k4x3mn4hT9O1/YtLOF1m8iqm
         9SygX1wg9AhiZpObdcZYn54eWy/lxQtdGg53W78/JLcsxhKDgkVV8fRuTOAlABoIUT10
         ijXw==
X-Gm-Message-State: AFuF++k0zLd0bXpSajZ94KS0I8NGZhoBboWd5vyWA+HwdkMXO6K0TuFa
	gCFjR3ad+Vlr8n70NdeOwMZ5Hr2oMDV/jzr8xp1SLuAj5HYN4v/yVtnlpusQJfpwPPR+9IBPB9+
	IWapmnKg=
X-Gm-Gg: AYBFou04r0E4SgsXyZGMk/KHxkQSbWKrMQLpA/O4zf8mYnsf9qJb6neVVvF/dfoLJS6
	LactJHTp/5vRgUCF+9vJZ3I9fposRamTidV5tlMztY/527kfnfmqHiHg5M4T1fn8YviYTlrb4qO
	0RcWZayliRSyAPruKLzTSWlLfexRw/+ORaeYo/z1dGliTwXNpOg3jYKJlyfOAe7cugTBZ/arf80
	fSqZucr1o50N0CYDWurjgG63/lBL0bFaVbUvr7RRMQaqxVsEbIMP+u3QvygRPI2PfHSV7wzrDfN
	W4NkhJxQPaNCnxmnopky8F7gH35ZiIc64H6r0cWKYUYHxAx0pOviTCFyAJlnBCNL/jmg760POnm
	22Sqn/r5f23d/8akVH8LEVxiAJSk6FFuyzEoitFR68yrFNGK6yb2T9Sai2aa4lUQ/8fbOZSm0vm
	0Fk44zM0wocbm6T0qvBB0yCoyeYWUHzD6lXMq/ynuMOTobz3C7U1UhmBY+87BqMhxin5qOuw5eI
	5XA+pvnqCCixQHLTP8FDowrAe1lyeFMuX51AUE=
X-Received: by 2002:a05:6a00:138c:b0:845:bda6:574b with SMTP id d2e1a72fcca58-88af258b861mr506813b3a.5.1790879855534;
        Thu, 01 Oct 2026 11:37:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0b8f5b20sm73839b3a.11.2026.10.01.11.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:37:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] lib: fix leak on realloc() failure
Date: Thu,  1 Oct 2026 11:37:31 -0700
Message-ID: <20261001183731.2282758-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If realloc in the getcommandline failed then the previous
partial command line would leak.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/utils.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 6388d981..c4cd3c3d 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1368,6 +1368,8 @@ static ssize_t getcmdline(char **linep, size_t *lenp, FILE *in)
 		char *line1 = NULL;
 		size_t len1 = 0;
 		ssize_t cc1;
+		char *line2;
+		size_t len2;
 
 		cc1 = getline(&line1, &len1, in);
 		if (cc1 < 0) {
@@ -1383,13 +1385,16 @@ static ssize_t getcmdline(char **linep, size_t *lenp, FILE *in)
 		if (cp)
 			*cp = '\0';
 
-		*lenp = strlen(*linep) + strlen(line1) + 1;
-		*linep = realloc(*linep, *lenp);
-		if (!*linep) {
+		len2 = strlen(*linep) + strlen(line1) + 1;
+		line2 = realloc(*linep, len2);
+		if (line2 == NULL) {
 			fprintf(stderr, "Out of memory\n");
-			*lenp = 0;
+			free(line1);
 			return -1;
 		}
+		*linep = line2;
+		*lenp = len2;
+
 		cc += cc1 - 2;
 		strcat(*linep, line1);
 		free(line1);
-- 
2.53.0

