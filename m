Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721413E3178
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604894; cv=none; b=Gh3bmQlrLfVzVOiG4WAfho8+U7YRCIVtTbuOlZFjTKn9St9hlpY9QjMeUalw82HfRu2a2IbcWUiIw5qExjL+RN0tlfZrNRvet8DcZOAMDV8S+XiK/zOD89MSRotH5H2iDOwXPVHeof1pZtEmfPAL0zerwhfo5gXxMxrAsUUi5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604894; c=relaxed/simple;
	bh=lK6SylEY4LAQZljQVEJN4LwYrq5OYAYHrr5rGGnYhXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIkN/CbDCnsPOzCPDDBSTaaPJL6izzfW7UqmUVltEbUMw0ML8KDE5HnJCqqhe0KW5wInsafFxjyqmEi+k+62gniD0RwRHtLCNePeDG0pHE6bfBgx+6pnDCuekM7X/hLqoLMRGJknUbv9rUEcZOjwWXA0eGVCjIg05XTACnpMKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbZdrZJN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbZdrZJN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so16898785e9.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604889; x=1789209689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jxq0uSbWX1tJusqk7o1sA3mVysrnqKqxAe3TJjvp4t4=;
        b=ZbZdrZJNtU1Ua2LMgPCwpjpisRBcH4qHFB7GIZYEypIlrxFQ5GM/I4/SB8hjdfOY2W
         3oin8dF29iy5doVadsw+iovnNBRz1gO9uqt5iuP3xF2wd0gTNy5CBlNsjYQKkJHbrIev
         6owPGdcI5PxHhYrMsmYJMAWEdgwUaorAw5tavGebO34Z82SS/W5hUIbHneemvCUlneN1
         s1DJ8P3i32SCACZQRTiq4TYbrPJXuohqJjJxlEmWuHMBZMS8NLajp/bTchHHcKNkDIAt
         pl4Kki3ukvKPfEyiBoUihaU5WGHvtl6kZym1JZFBm38hk50wFNVHZRptE6ntAA2TD6qe
         jzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604889; x=1789209689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jxq0uSbWX1tJusqk7o1sA3mVysrnqKqxAe3TJjvp4t4=;
        b=a7nnwM8ZrlINA0RPjPVSOnzUoRL9stSCsfUTOT/HP97VJCaIRyDqtLD6ZbZJGjzpWZ
         xgOEjuZlZ27+ekYh4VPAKK8XB8wneQ55wiwH99tQNnCfQjZ15sqTA2MDVHhjlDplY2cs
         0s8edRO/6Yxc7GgHTSr+lY/mVPnsSaHEawSF/TKLQoix8SAbDtkpBKKPCUuCD2N+s9cq
         OqpiOY1vPdsIJ1tlnK36TArlLW/Ta660Gxh5w1Wbp0rMbl9cyBl0G5QO/FitPdUdAZtr
         jMl7L182PPVSIimJjFLaVj5TBkQGCgYuZAw18CK3g/vAs00gXLj9rNMqI8irVtJlByZF
         TyhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHsSetHBL0CezjkCa6a2X5KY8hvMWCruovAuPcxZ5Rm+Vvshtx8xrCMItZBdIMlHllMRUw5q8=@vger.kernel.org
X-Gm-Message-State: AFuF++kSqKvefoIj+XGLgJt+EZc7TEebUTBJFlP3U/jlhBF2itK1EncQ
	/l2KE0Rw3y5Ke9uAUQBFogoQ+1wORmLgjOYvxpjrNyvpR9AmeiPodIAWrOwKa6GJ
X-Gm-Gg: AYBFou1CASkmL+26lgm4SsiT/zpsBCkD9xgyGbkRgJVsTHuBOxwc2tuxA3YbFJV926B
	sHnj3DiEClTqml0c6Gk9KG0LhK7ZOBvN6ptaaUM1sx8FlaVa4OBMcfi0iBrn3UA6FwcJnpFwg7k
	gGHvRVRkSJ0GSvKGTP6ofEDmAuRG4BeRwUD8qmYXEd1qw3u0Za/eAtiN5J0Hr2xUelhvKco14k1
	4wUftdzPuTiqZs7NLJ+9E0KaH8vBpJt8dSU+WT72lSe+qtBGMPzlozawoHgafLYQ0IKoJU5GZTQ
	qbCMopcNJj2CGMuLITxRUtTAUzmsl4hbkBAHtYrYVB0edgrhWOhEACS1nd9qr40UUFjyLefgD+e
	rZwI0yLUgdKSVGDVeG7srhOc7TOPcVejdZZOKyF6aoFiscNn86l+A5jXDoHy9/kyC0q/qqmQbk+
	0lO1MSnpzyDRWOJBnmkCFHfHwt2NyB2HKvVoSiAmon3CIL4duzbZ6wlXXfiLzah3K+5v+iesvi4
	q1aZPb9jzXPQh6Bo5ECQ61Yh1PidT1pjfQf6O6Vr43w9T+r7q6gTwx+lX8sWgk2pPJ9QRMph/SH
	Le062t1ZtGz3WuzXURgGz8QvJkNqZzIpeeLn36pOJM5ym02xdaDTqZQV/Gt4OTy51Gs=
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr117889645e9.2.1788604889257;
        Sat, 05 Sep 2026 03:41:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm179967505e9.0.2026.09.05.03.41.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:41:28 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <courmisch@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next] docs: phonet: Fix the struct sockaddr_pn name in the example
Date: Sat,  5 Sep 2026 12:41:23 +0200
Message-Id: <20260905104123.43511-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct sockaddr_spn does not exist; the name is struct sockaddr_pn.

Use struct sockaddr_pn.

Fixes: 297edb600326 ("Phonet: support active connection without pipe controller on modem")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/networking/phonet.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/phonet.rst b/Documentation/networking/phonet.rst
index d705cc5b09fc..e5551fc45c78 100644
--- a/Documentation/networking/phonet.rst
+++ b/Documentation/networking/phonet.rst
@@ -172,7 +172,7 @@ two endpoints directly, using connect() on the active side. This is
 intended to support the newer Nokia Wireless Modem API, as found in
 e.g. the Nokia Slim Modem in the ST-Ericsson U8500 platform::
 
-  struct sockaddr_spn spn;
+  struct sockaddr_pn spn;
   int fd;
 
   fd = socket(PF_PHONET, SOCK_SEQPACKET, PN_PROTO_PIPE);
-- 
2.53.0

