Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1947CA74
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117398; cv=none; b=pwreIOonw/58sZmhBMJS9EIY6GYYtJzg1Q+6haNEZq9HRfOQVkO0fKM+AXieTwRp6p5PMlhgLDyf95CCX1GWxs0VQYEl1/J91rJqGQxmUA+EKpB6PVUsS3h+C5G50Mh4G5UOfbxvTBsFsfI5C55fKO5iUFzLsQTA6J4Fk2bf7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117398; c=relaxed/simple;
	bh=sIcsjrh3MH9EuDeKD549BsDxo3xiGU53UWbR2KNkN1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQth4pp3NyR30gFO7JPvqwd3/CBZ4A8Nx6+5dNaU4rY8r9lgqdTvig+jry4jrqPXXja0M+2WDgTMNRK+vfi3xlkPoTiLPUQfUPtE0RtAFVgOOIemv5T6sSUWMAB1Q4uW2+BJGnYNxJuDLNCPW/d3nTR9n+zJu27eNb4z4vXaC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mrr9/LMe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="mrr9/LMe"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487088510aso5248870b3a.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117395; x=1786722195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5pKYgl0EEakig5CEJ97UrLZZaviPOk3/DiqE/UOWoM=;
        b=mrr9/LMesq+LdnutePcLrDsdvR3bmt3ACQljIqUXte+7WZFpOJ8Y4sypxPOgSJLuP9
         xXAoccIhxrFvzpeFm/U+eurAhUpZbC5+bNfonEWhBazp+R0QHm2O85drmRSXob3SPK2q
         H0plrOo7Ca6Ms7SmBwrE1YJRMNIwYiWSODX5JusYWaTRav9l6Dw4KcQbIJJ9irKT1Yys
         LgyYSp27Whg1RcrVvdK6OZdrGk/LnMGgK9IYa+YknjOyckCqczPU+HZTvoIORHEjFfav
         h8IRbPq+gLDgV9t4mxCD3Owbffp+wrzR3Ou/++ILWX7XA4DkscAXn8bj3rq6XVVp1Ah2
         Hrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117395; x=1786722195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5pKYgl0EEakig5CEJ97UrLZZaviPOk3/DiqE/UOWoM=;
        b=PUgw9GSugk/k1imsnhQvUOJ1mGMgcx58noVxmzytzUAUslsSm9OJN4gkKHZTK5HnOt
         5RY7EfD3GB+cHUw00R2BJGIeQG9CxNnXawLCfGkS9b/8GKNiwRKnKH/Mu8mF9NZNGnlo
         LjTFf7vAUpAbp8GI8GU6sMWPsHkdTMZEt33fJ+fnTaWuqfg0hlCG4TDLwatwU6uD0Ywj
         ecPOub5qAYotrddqu+oT0+B1exxP5IM34Qx82BWP/O1V0iBmSAK+Ap7np9BQ/37YWjOv
         OAxZFv+GkVjd1pFZeAOUEqJ+lwL6lCaq9X7bNc2RzqBOEr0LGI7TtHnAmoJs8BpWAaeB
         6TJQ==
X-Gm-Message-State: AOJu0YxdIzteEJr8NipsyBn2yUxv19QgxjN1XZ451UujMLh86oy4k2uH
	lq3hnXhQbUfWKwrHIObSJxrWrLKVXuMLryrQG2uor02o0onRq1bw+uBxN6xHneUE52d7Go8mBA3
	KIy1y
X-Gm-Gg: AR+sD12YVJSduwv/qJXRpVNJuhGh8J7fZjdO52qrrTVKV+sFtb/yG/DzTGZ9fJFoq1P
	Q512G1UKldn46aqLfRiR/SKwMZ4au5IL/NyFKh7L47hi34ZKV7PpENisR4bl12yrx5hFbO0cgoq
	FkkAt/b08KbgRM+k1LERCrPQ6QaP4Bo3kGnuTH+/Y1JJigTNm4sPUcRGeH8nc6NOBy4vyjas9B+
	12kbhqtcU7Y//Vr5nZtCE+18h7Fxfd2Hg+4Sou1zf6KOIbn3bu6Pm08GjMcvfB5AnadB3QGUAht
	sDXEGEkoXkiGVfUswjHd+YY4OHfah91be4I6rdcxudurgtksv16/VkAJoRT+P+h/JBf7GMIdwTc
	9YSoUQnCVCp1IaTDDKYYMh/gkJ/FiwcgCSeWtbt9hzHRzeqVmZnnD2gBZ+wvPS2rCnxaUkcxwaf
	aXRttzbb35b/VsE7ZJ3J0OWMiChPATsZqvD7WzJUyQAPMoFNIJlNHvgFA+gQvKw6n2jJeOR6qf+
	6sY99MQUsS+yv0ebRDHeDWJeWw=
X-Received: by 2002:a05:6300:8941:b0:3c1:fbf:1e2e with SMTP id adf61e73a8af0-3cb85ded99emr31060853637.10.1786117395048;
        Fri, 07 Aug 2026 08:43:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 6/7] genl: put help to stdout and usage to stderr
Date: Fri,  7 Aug 2026 08:42:29 -0700
Message-ID: <20260807154306.111200-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807154306.111200-1-stephen@networkplumber.org>
References: <20260807154306.111200-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar change to other iproute2 commands.
Syntax error should print to stderr and exit with non-zero.
Help command should print to stdout and exit with zero status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 genl/genl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/genl/genl.c b/genl/genl.c
index b497a3ad..27b679df 100644
--- a/genl/genl.c
+++ b/genl/genl.c
@@ -7,6 +7,8 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <dlfcn.h>
@@ -90,16 +92,16 @@ noexist:
 	return f;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: genl [ OPTIONS ] OBJECT [help] }\n"
 		"where  OBJECT := { ctrl etc }\n"
 		"       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[aw] |\n"
 		"                    -j[son] | -p[retty] }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 int main(int argc, char **argv)
@@ -122,7 +124,7 @@ int main(int argc, char **argv)
 		} else if (matches(argv[1], "-pretty") == 0) {
 			++pretty;
 		} else if (matches(argv[1], "-help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			fprintf(stderr,
 				"Option \"%s\" is unknown, try \"genl -help\".\n",
@@ -146,5 +148,5 @@ int main(int argc, char **argv)
 		return ret;
 	}
 
-	usage();
+	usage(true);
 }
-- 
2.53.0

