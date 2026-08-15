Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00744156F45
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757592; cv=none; b=Mq7qPr/AZp9JxurBQl9vXAh/TNRZ4sbTrj+tSXprlLTVV0AMYkEKSFk4oKmfFb4svLjRKchWFwZN1gyifelo+obc6cy5qDf4bDS+e/9dFhIm9SSCN8MV8y4f6QEKuBozJSHMceKygAcXNxOCsb9aFm1DQVdMRdYbXtc384zJqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757592; c=relaxed/simple;
	bh=jyYxlbBrAQnAZZN04ajlnh1MSAFrHtyTd0FqLUs6XWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MC73xqdfcMEDS0ES27WKP8xrs+vzJxz5ecS76c6J+Kop3Wie5mKmaVHm1+sMOK9EyYCv372ZMCmX0rKlEr4S9cUaLuD9fBoQsQt+64p/BgGAP0IC3aPJmUL8aHd7XUVJxctljFrN2P5RXwIXfdLDtddfy8Pk8foysyqdz/DhwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve38/Vv6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve38/Vv6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998590d392so16776105e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786757589; x=1787362389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6hUXHl/XBMGrttNYvWX7RrvTYp0xlm1Orl1JfPmVXo=;
        b=Ve38/Vv6z0vdVwFjMw4XZ/ku43aAffw/dwkJlQ/JuVcQeJAc7WY0nfMrk5kZmwS94c
         RFcIQd+iQ7nEh4Um9bAsdvHe+7S1sznMjb1RbB0sMBWRgwV5WMlsAFWppkNUVrHF28ku
         6QkSsBCHTh7VuHPtrHDgTiioNM8de+tOalesxRMPz/YyAeGwJHK3oTfazftR2pB4h9RI
         EMNcU+t2GC8qNO9jCrHO6r91ICWsrBEsrXjOi1s/IVINZNMVAll1cejSJgB+mAC8QSbC
         cmdwM+aIXIfQlh5EpfvKMELcHR1W7Dni9UYBqFRJhuhbXMteH67wKEGTJehI7Y0sby6a
         LShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786757589; x=1787362389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6hUXHl/XBMGrttNYvWX7RrvTYp0xlm1Orl1JfPmVXo=;
        b=bEaBLxSMapd+u/ZwQ5/zom3JGal9KnIkv5sd4i4c9hdaJeENDsPiLYRnKCA3/Z9Qcc
         e0lh22qMcHGlSRIYAd8HYgzNAsymyqDlat9BptaRPX02inKtYXqH6aXnppDgGE7oRg1n
         COh0ODw7//DlDcHHcNlmsf9iZz0d8ip0I3+XvYDKsO+hslBy7PhcVlTFwGev967/3R24
         Ky7+kiBVs6pVMOzHc+V4Aafm6g6HMX8BNX2xjANXxDZu55jq9jragsBYBugjR170nx6L
         algRKkCQtUQTZHURpP2dGQvBEAVY/LGVzzHUYguJxz84o6GzIbNuoT1N09pbDCIf4vnu
         OpIA==
X-Forwarded-Encrypted: i=1; AHgh+RpWwBzmHFkpIV39olb5RXXq5i/drmM6PeGbS5ST6HXqPYmIf8HqZGdVdaJEdriF/VFWgjW9lXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsVwr5A0+wJyR0XFZpqg5T1UgQ2ZCXlsEbJoBOS8DHQWg4XEx
	stKooOIU8G8p0DNxN6EJSlWxYYbZzx5NJtZyHaxmoSGYKaBjEHBt7Ktx
X-Gm-Gg: AR+sD12wce5Nz67+nkKSjipG3eYh6FgF6td1sbgTQ+c6CtMULT6X10vp0jGz0jXC/QM
	u0N3hin1alxc4L0g5MVw8Z0xfW18bXZqb1PKBoEROueO7FgZ5/Lk+4TL/H0KsKxAzVhaJx6XC45
	qeR5gL82wRZSWCSH0qeGmfJ2mn8eCCi5rvjgj5ujOBcrT2Xg3EBebCkJkvMXHVNPMbldTwNLHuN
	275rVoikTJG1hA3WNxTb03Cm8mlfTz7KrQ6Iqqf3Xv2FDa4wsbdITRru0359uEtlZsWUYgOOF0k
	8A0nNQHieuDhjTjtTN8oMyr6uEWtbc0aPcvJBrs83R+t2P+GjjIaCDTk7woBQ3cnody7InHOSCT
	/GsiD3yJPptXbTSzOUn25k32sKsgscX2v5PP/eb3IqJU1YjJmOu9FABPl0DsbZukqddv1mUjXxG
	HhqCF45bnLaawGSGIE7wneZ7SFSLy7L3OksKDmgr7EVsa9VRoWGzMWXbrk5xCNSXb8hc4wbKIgd
	BvJKsfBsVkaCCuJGVrdi63T+RVnnpjJ5FJmsQJIjIod5B8xBL/817GBuRHHXSQXE69fzMK8QpD5
	TbUb3AxQroLxn0DCh5uzRk73DBWD5H2VWz1sl0tt2HKiS2y4FktMMem6WGcj80r38JHw+Z3Fipo
	m18jS
X-Received: by 2002:a7b:c013:0:b0:499:51b8:d649 with SMTP id 5b1f17b1804b1-49987941a3fmr93722545e9.3.1786757588989;
        Fri, 14 Aug 2026 18:33:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d7d-f301-9495-44ec-73e6-1be7.310.pool.telefonica.de. [2a02:3100:9d7d:f301:9495:44ec:73e6:1be7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b1a31esm110672885e9.2.2026.08.14.18.33.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 18:33:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] docs: kerneldoc.py: preserve headings in kernel-doc output
Date: Sat, 15 Aug 2026 03:32:29 +0200
Message-Id: <335fec1cd5a3449687f8b1ee8cd46a0f3e455aa5.1786751700.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1786751700.git.kmehltretter@gmail.com>
References: <cover.1786751700.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kerneldoc.py parses extracted ReST into a detached section node while
retaining the surrounding title hierarchy. Docutils 0.21.2 silently drops
affected sections; 0.22.4 reports:

  Documentation/networking/kapi:107:
  ../include/net/net_shaper.h:75:
  ERROR: A level 3 section cannot be used here.

The same issue drops three Xe DRM RAS headings already in mainline.

Use nested_parse_with_titles() to give kernel-doc output an independent
title hierarchy.

Fixes: 2404dad1f67f ("doc: Cope with the deprecation of AutoReporter")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/sphinx/kerneldoc.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index c1cadb4eb0997..9986df33e37ea 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -38,6 +38,7 @@ from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 import sphinx
 from sphinx.util.docutils import switch_source_input
+from sphinx.util.nodes import nested_parse_with_titles
 from sphinx.util import logging
 from pprint import pformat
 
@@ -252,7 +253,7 @@ class KernelDocDirective(Directive):
 
     def do_parse(self, result, node):
         with switch_source_input(self.state, result):
-            self.state.nested_parse(result, 0, node, match_titles=1)
+            nested_parse_with_titles(self.state, result, node)
 
 def setup_kfiles(app):
     global kfiles
-- 
2.53.0
