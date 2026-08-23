Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060135B64C
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787529152; cv=none; b=Ri351WOd9TMV6xvGTHxbTeFjrEY0AFjFvAFy1MmpFodkQ/NG4w5E5ORHPIUNhS9xpzNwegf+YnLYlYi88/a1VabN1TmfJ9su20I9ByTKvcenpj7kWJFFFMk/OFtnWgsm01r73f9zuVlvCsgvzPhe/x9Ll5RdDUWQ8MUzqfey8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787529152; c=relaxed/simple;
	bh=zzKrO90xzPL3WBLezCUl6cJ6lXxx1K3D56Nd/xcpspQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG//gGzl4nWhFf35MjF1Y08vb9dJMrPxdnYSFVyRQkbwheLVkXZzzpphcrZLUhHCc9pGHcRf5RVn/tCghb4fLuhSipC7YfvkrADHaUmZVaZNyElhFfRdxoxpbVOyL6wyoAtF6VjqcGdE1TgpmY4RYn2z2m1HJe+Q+kNwKoSz6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=eUd+6gyI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="eUd+6gyI"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2371722b3a.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787529150; x=1788133950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/IujuPmuN9axjPmIvxqPM4TumvofjMMmxlfKB1RkvkI=;
        b=eUd+6gyImQAYw8Zcen6xmj/2DbDBgNLMOmjrSJOB0DHeOb3aTbN6fGUSTzri5yBYNY
         PHNyeecUDjg3zbKL0C15nuWKdQrMnYizU3vM6/y1lkdxhNQd4G+f/IYMMRa1s3Q9E7wa
         CUw705RvH4mUt6AAmPomhUoOrssv0PPpAI/9WHDyCeXK6mRfE9IHVe7ibxyQK8A6r9SS
         F2L4mVYUJ1lcXa3T0d3Fi2KMdA7z6IgYAPV7WJuPohtQKkHK1TC/ehJ6lA7IMfbtnHta
         97wbCd0cfUBQYqWOzqdH97es+YNIrmb8FDqd6SB2kTXC7sAqLlne7doXP6BgNeZe/MAq
         bTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787529150; x=1788133950;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/IujuPmuN9axjPmIvxqPM4TumvofjMMmxlfKB1RkvkI=;
        b=rrbbadtt5JmIXXVBHarsA15o8otnAqoli3SOuLLFbHu9V0m7TJoQzQ/DCbHtn59OX+
         gyLzP4lGFkXrQu/1NRK1t9pQsRLgAOBlsSfMD+hUa/Vw9ZmAFxpS6MAF9G3XP14yOr2n
         R3Vxeioy/rZSxAel9z3VYbt8Cgz49FsrWbM/tCus6weyT/xt0O7nTewz/57x7sq09eOS
         LpdNShfxz+6GqFQKs0BCFO7Butb1RZ+11+bkRtFP/01KeLk/ev2uDiCgBEPKfnPhu9I1
         WikP95kt6p9AAKtWqMlwhwLUPegbCIZA3NJmcekYxKGCBu6nqGAtjPAIUMSDlP/wC3Hh
         F0Ow==
X-Gm-Message-State: AFuF++medWjIE/EHZuE11p5gGXh0tk+Bu0g18hKU0xVc2kxp2HXBD3bw
	ydCeClbptcU0BG4zBTEUU59/FYN4tddk1x/SlF460nnMeG3z0EPFzu/H/2Z1PO1NAP4KOwRIoO4
	gBJz7
X-Gm-Gg: AR+sD12caBveA6CcEp+7QM563Teb3t0z70fAlrEC6NBiDjfHSsnBNnLnryAeJEVkUPf
	y7F+lCMKqKnMWByHuz9PQRekp18sC3Gunaxx/9s6okoU1yIzChsluabA2Zp4ZO6/5eZkGvSlpUK
	eoJogRdgkMhOgmV126bMBSoYTrCa9y+SC8ZE5dOlIkWeIecAy8dgw9Zpge6MWz8nhwfN3/+1I/Z
	/U606DZHE5PczLgJIC/imCcR5Vk73FJ9THY9LYW2hBuKiBf0j333rb+nSAwOafoofKt6D6Ud19M
	F1TUdBmPSazDC40fbzGaSOU4LDWYRtkPweIXzHOFH299fnP++ZaEfsHNKPg9154buPJ8ib0smq/
	FfvBqLgttIuuuU3y4R7Kh65erIuLBWQKjc4Xw2pCjKDkcxkhJdcbZiS2iUkfEMsmuv5b2KYjyHh
	pY50UebWds/ZfHCu78MjmC6yImd2dXacjh6SudR5lFIy8D7OCvKIg42WwQtc7ACcXXPQLYpIF/1
	71XSyC3c0QCTIp+0dbngneHLuM=
X-Received: by 2002:a05:6a00:1407:b0:84e:c851:a058 with SMTP id d2e1a72fcca58-851dfa0ac9amr27606935b3a.10.1787529150573;
        Sun, 23 Aug 2026 16:52:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed243csm1387573b3a.12.2026.08.23.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 16:52:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/3] json_print: fix Gcc-17 warnings
Date: Sun, 23 Aug 2026 16:51:31 -0700
Message-ID: <20260823235220.79790-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823235220.79790-1-stephen@networkplumber.org>
References: <20260823235220.79790-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lastest version of Gcc and Clang warn about value of 2 in
logical operator. Example:
 warning: use of logical ‘&&’ with constant operand ‘2’ [-Wconstant-logical-operand]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/json_print.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/json_print.h b/include/json_print.h
index 6a458189..79d8d4ff 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -15,8 +15,8 @@
 #include "json_writer.h"
 #include "color.h"
 
-#define _IS_JSON_CONTEXT(type) (is_json_context() && (type & PRINT_JSON || type & PRINT_ANY))
-#define _IS_FP_CONTEXT(type)   (!is_json_context() && (type & PRINT_FP || type & PRINT_ANY))
+#define _IS_JSON_CONTEXT(type) (is_json_context() && !!((type) & (PRINT_JSON | PRINT_ANY)))
+#define _IS_FP_CONTEXT(type)   (!is_json_context() && !!((type) & (PRINT_FP | PRINT_ANY)))
 
 json_writer_t *get_json_writer(void);
 
-- 
2.53.0

