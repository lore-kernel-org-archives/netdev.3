Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319C35B63D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790821897; cv=none; b=Cp/TA/0GCpQaiWOlT22GLRNnNcombUzcueAlCWDCQgU6UTb27iZQ7/HPEMbImeQPP4x9ZOyvZd2ndjLfs/297wZgyoSgEIYH3nKI1Iv+U8Rmq9llyj3YpZsI2Y8RMbKAq7fN+nvmFQJHvnD+HkqOVvBt1aa/V8YKYPIOFnWD/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790821897; c=relaxed/simple;
	bh=Mi+sR7T8uLGfyn6qMrt1y2ibMSC71vXwT1uQ7XO663E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaPdWXjaE2rqlt3KQBrpA8u77SnpliP47ZPjGWET7SboSopNUbm9jb6uooxgpyk3br9zigSNPN04WZG/vdSXRBjPDc+NVRPVAmKmNwax9105B4xXmNABWvBunfC9DWHYfQamzUjT0SkmApuiY+ZeTk6g5AwbQSxzVUoS/P0aO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgRkBJSA; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgRkBJSA"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso3071747f8f.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790821894; x=1791426694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/GgC/KrLQtv5iWyscj0ycYstoTjf/7MQMPLI7kCjI3M=;
        b=bgRkBJSAjXaYbLYGe97GE6zrWd368BWU/uP7fOCiW3K49B4b7fSO2PGxtSUArwZWfJ
         qV4f+a2XQKxVFoXGpT8s2hgANjH7MMfX/crYQHnUjwqFCcnEA1kGUI4q7HrPa9mZBbFC
         Gvk/paO9m3ILBdb6+la+dxXDWs86HKm23R7bvgDFrYdzGtYagC0eSkP74ud/aRN4yMMh
         ou8COobqrZ1SefVVNCu8qGUEz94k5cMLsynIMxfG/g6s9FJJ+XzYk0YJPGK7Hg8DxiDp
         jOLrKYkTNJzKeBdvzNZCwVdheqkVsyDDhfmRDe2SyS6QXPTCsXAWbi32+9sYpI45fH5+
         h7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790821894; x=1791426694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GgC/KrLQtv5iWyscj0ycYstoTjf/7MQMPLI7kCjI3M=;
        b=CMo/OQXCdHA9Oexih5biyR8qf8MUrAJaeq+dC1m4aQZJOkW/hiJ7hvpOFNqAQSdAB+
         noFrXVd3bIjuOIGGBPQy20h/qKkKfQ9ye92qSkWMibiuY63JbQrF7OXPRipQaoQcAD7b
         Au4tou6hzRiAEO69DeDPOTiHjDOKlW0wux325oCsADpFuPaIg/KLU/sMo9ZyuG48r1Qo
         eW+2Mwopkr9brANd2YtLoB2LqLiEWRBinZ3fIOTnMxlUWLSsmnu5FrMCqkpAJECppC+m
         y19h6Khuh904ATxrArjCtWm+Azs4yve8bfNqhmeiPTFnp+9lq/LNa9150DbuatjIugQI
         2iFA==
X-Gm-Message-State: AFq9FYJDSrJzYUzTT3TgR93VnXGpfGeNrwE5arsSK1/OLY+Pbb+8ZVnq
	cYAyL4tcXgJnAfJ1DZdT8iH1eRgAjwL4is+I7Mz66VpERcKJq2wISjrReWQ3rA==
X-Gm-Gg: AYBFou1783sQGxFmtvqx8F05nla3+5wcmCHemTZu0WJz4EXVlTxIfXGzSaGy4soexVl
	IXcg9hPgkVhJjqQR/glA2RGb7oGKzMOW0O6YhfT+/D6axhLlfdAOyC0oVVcyClXPIoYUwMaE1Iu
	Tf9fyKUcIr62Q7nZz2H+RncqMblxY48/9qagjCkFvH7usN11TMDch/JiNBDOD7nzhdkb48JE7hW
	GwA3YNCQwYP1PqP/KqqloVmMmThwQzk8avtd8kqpsF/WgI4NJDaZoYHkbDU2YfZ6pKMs2YEJXBm
	weasJuG6t0zgb7UPCFOmh/5h0qVLjxn2TqRWeX5O3LbbDaaIbkspRR2l5i28QTxAifYqkPdrwDp
	ai6uwMsfGbruwerG2LL3tflVn/hjUTHM/qFoct85Lj3jcnsXP4bW1z8f4SqzEYgxcWbaQG857Ur
	aKolvocpPZ5Q5CIqHLaIgGDvuzKNInwfdmm9eXIguE28ExZUQ9MDHy3Op6iCD7fnY8zA6q09uWX
	MrRv7hE/7WUkQXINHrrb267+Gow6/la34nHUOZhM8Xi6A==
X-Received: by 2002:a05:6000:3109:b0:48b:9ec:ae3f with SMTP id ffacd0b85a97d-48b09ecd00bmr886326f8f.3.1790821894346;
        Wed, 30 Sep 2026 19:31:34 -0700 (PDT)
Received: from yam (ip-B9F9A82A.studo.glasfaser-ruhr.net. [185.249.168.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e721sm3333370f8f.20.2026.09.30.19.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 19:31:33 -0700 (PDT)
From: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
Subject: [PATCH iproute2] lib: fix memory leak in getcmdline()
Date: Thu,  1 Oct 2026 04:31:29 +0200
Message-ID: <20261001023129.290059-1-ml.abusaleh.ml@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getline() may allocate line1 even when it returns -1, and the caller
must free the buffer on the error path.

When batch input ends with a missing continuation line, getcmdline()
returns without freeing line1. This can be reproduced with:

printf 'link show \\\n' | ./ip/ip -batch -

Free line1 before returning. Valgrind reports 120 bytes definitely
lost before this change.

Fixes: c2f3a0f94de9 ("Fix batch mode, allow continuation, comments, etc.")
Signed-off-by: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
---
 lib/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/utils.c b/lib/utils.c
index 50602e59..6388d981 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1372,6 +1372,7 @@ static ssize_t getcmdline(char **linep, size_t *lenp, FILE *in)
 		cc1 = getline(&line1, &len1, in);
 		if (cc1 < 0) {
 			fprintf(stderr, "Missing continuation line\n");
+			free(line1);
 			return cc1;
 		}
 
-- 
2.53.0

