Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94EF36B05E
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787529155; cv=none; b=iOVBUEFMeCe0ktjy92CQUnl1cD+r5wyDtBIMhVZD8ZmvwCWKdzLWHgLx5jpMlHmrUPnR2fJoN8znyX5rd5iXe62HIKJCtA1spbG6I+hBU6x8wqASXi+C2nz7Z7lKfQa4ZyN3dtTrBh6YMYu7U95JiJId/5m76V7PlBhli14VKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787529155; c=relaxed/simple;
	bh=t/OPT3pWpKYRuKSRpha1Lc3hzigllwaU4ETH+wRWcm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD5Tf/RYn407SdhJevvp8cnm+ZSjfdGKYgKhcfFb8wzLKFNvJGeRFlAp9+zr2HsPIrOgHbe/QFK7cYZviRgM65DRfwLd+/HAX9qemvZ80cgC9yP4VqIISik42uEl3UPrqI7gRYzRxUlCKKvN/REX68LplcVfcY1NR3vb5jsLAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=N6NQGyI/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="N6NQGyI/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so2191342b3a.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787529153; x=1788133953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s74vR1kUeu+rXO5wVY7Z7ocj5Gw4elRi9tTNm04N/tU=;
        b=N6NQGyI/p9yxRpCzp+KptrJBsFx1l0m8iXQlzuJjonSSkyiQtomCf+HltPwJ/p4Wq7
         jHoEcMUVzc9wvA6omMIFBBPNrUJk3PqUx7gjsfb88ZzND6hiCOb+pInUI/8bez4d/dlW
         0MB7YT3SchakNNFDkjf0nKojduJa1vWm6rsypPM7KhlhsC4AfX4K3UaU/uvPOkzqOkgO
         puzmppfphkbyn3uQcl7p8zV5SxvqrH3owPNob+mSdbrXcJkgEWFhK6Cl0UMg/tjDivYW
         A7WnogMbLJelOsmLND2ILXOP1thpTtd4g0GDEgMLV+LYFxi8m0pAjn4eOA1UQ2zUM4Vr
         Amfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787529153; x=1788133953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s74vR1kUeu+rXO5wVY7Z7ocj5Gw4elRi9tTNm04N/tU=;
        b=lpGZDEtiIp18wblZUS6FszQSQ7Bzl3ahK4A7tsaKDU4h3lMpa2KF2+xnGubpmkT+A5
         nAfBDkvWRMUBX1RvzwJ8NpER+2wiyrYSiIAy1myKaf7PsuuXuDU7lNFx6OgPpRPE3Zwy
         HniWhzA4aJQ7lZCvxPCKxHG5TW1O9B0YDkwH7X3UAvYh9ozrnnKThur9YMaE3yNUNBSv
         vf+glDkahi/92EUtyLWH3jOt0N4LhYPMOdWAPGqJHqwdbYGQ/N0AdFpO8PIo5Nh0B2hd
         VfRjDUnYzi8G86wwSBYALx36O6/PPlaR+cbAoulI/KHVA5wdCJQIcgCtng6qmlJYryPO
         T3hw==
X-Gm-Message-State: AFuF++nvYqs85OLd5s4b0vDHMLQD24+9E6bjS4ykEvbX7irTx1uOSP1V
	YFl00DzQYUzXCT8dWjMdH1ebVvZJGP+YD+cdu1p6aNpkIuIe9Fep0wfdZ/2wALprjuHQgocNonu
	Z8XlV
X-Gm-Gg: AR+sD11iMP7SClQwyL0AlcXDApZ2yqDAcJ6Nwilw+6uh8UJ29Ci6hzbuK/mp7BqGmda
	/HblHUDAZNsTpSE1TtF37DMZB5jXtSRR3QAiWrT18zwQOm14xhqqlkohjXvmu0JeSCXlOfEjdop
	xHJPFIFgftg582nKx07C65HdHq5MN6vBxsPED+Lw+T6dDsem6J2K50Tlrttjl2aab/vIe5AIbjy
	G8hNIYERWxBrPyN6D/LOV2/EHPYjOlqGuxS5neecHsGkRXy6gnPlpqUUUFyOORtMLo5GnKftmdG
	Os9xd2LgtA/JBp2PuhpHyW3nI7gKPoZuU5PoZuRTdJgZuofMifYr9pSVOYtUTBOw3fedbTclD3X
	xcQY9PzOEcmZK/lo02MQ+3SPno4w33tBn0NURmcQegWujkMtiP6dZVwsyu26acru8CigRvs5ZJm
	mubSg+5QezVqiQvT3tOJLyjyOqyeh8Ln5qhwFqu2dRSSqzmqQLVmXJ1co6NHx9WjLilDPbSZNe1
	RjDwXy/BY/jxXWH6Am7/nWC3IY=
X-Received: by 2002:a05:6a00:4088:b0:842:708f:39be with SMTP id d2e1a72fcca58-851f9aa2acfmr39303982b3a.5.1787529153078;
        Sun, 23 Aug 2026 16:52:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed243csm1387573b3a.12.2026.08.23.16.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 16:52:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/3] lib: fix warning from ll_addr_a2n
Date: Sun, 23 Aug 2026 16:51:32 -0700
Message-ID: <20260823235220.79790-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823235220.79790-1-stephen@networkplumber.org>
References: <20260823235220.79790-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent versions of strchr() propogate const char *.
This triggers warnings about lost of const.
Resolve this by reworking the loop parsing hex values.
This also adds checking for garbage after the hex value.

Also:
 - arg is no longer modified
 - Trailing garbage ("00:11:zz", "00:11:") are now rejected
 - An address longer than len bytes now fails

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ll_addr.c | 52 ++++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/lib/ll_addr.c b/lib/ll_addr.c
index 7a9eb3a4..851a5be0 100644
--- a/lib/ll_addr.c
+++ b/lib/ll_addr.c
@@ -7,6 +7,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <ctype.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
@@ -45,8 +46,12 @@ const char *ll_addr_n2a(const unsigned char *addr, int alen, int type,
 /*NB: lladdr is char * (rather than u8 *) because sa_data is char * (1003.1g) */
 int ll_addr_a2n(char *lladdr, int len, const char *arg)
 {
+	const char *cp;
+	int i;
+
 	if (strchr(arg, '.')) {
 		inet_prefix pfx;
+
 		if (get_addr_1(&pfx, arg, AF_INET)) {
 			fprintf(stderr, "\"%s\" is invalid lladdr.\n", arg);
 			return -1;
@@ -55,31 +60,28 @@ int ll_addr_a2n(char *lladdr, int len, const char *arg)
 			return -1;
 		memcpy(lladdr, pfx.data, 4);
 		return 4;
-	} else {
-		int i;
+	}
 
-		for (i = 0; i < len; i++) {
-			int temp;
-			char *cp = strchr(arg, ':');
-			if (cp) {
-				*cp = 0;
-				cp++;
-			}
-			if (sscanf(arg, "%x", &temp) != 1) {
-				fprintf(stderr, "\"%s\" is invalid lladdr.\n",
-					arg);
-				return -1;
-			}
-			if (temp < 0 || temp > 255) {
-				fprintf(stderr, "\"%s\" is invalid lladdr.\n",
-					arg);
-				return -1;
-			}
-			lladdr[i] = temp;
-			if (!cp)
-				break;
-			arg = cp;
-		}
-		return i + 1;
+	for (i = 0, cp = arg; i < len; i++) {
+		unsigned long val;
+		char *endp;
+
+		if (!isxdigit(*cp))
+			goto invalid;
+
+		val = strtoul(cp, &endp, 16);
+		if (val > 255)
+			goto invalid;
+
+		lladdr[i] = val;
+
+		if (*endp == '\0')
+			return i + 1;
+		if (*endp != ':')
+			goto invalid;
+		cp = endp + 1;
 	}
+invalid:
+	fprintf(stderr, "\"%s\" is invalid lladdr.\n", arg);
+	return -1;
 }
-- 
2.53.0

