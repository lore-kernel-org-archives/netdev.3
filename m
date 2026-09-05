Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA872175A6B
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788598041; cv=none; b=AuB+QAM9RA4owwqvKjmeK3fwidabfwCQU0wRaqEEYbEKTmn6CIAhslYuM+ekUT90+A5YP/v2JOvYE+ONWP+xbNuGywPpmsuJX3QtiNMEvQUB00PYocZnkhiQkrp3/yTVhzGXZ1y9xEGnOwgD9lPdC07VWwFbOe7R1qj/Ia/muv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788598041; c=relaxed/simple;
	bh=5P8lBcnY72RfMeCPYtgutQ3A/2HLslyf3RfBjOagIBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jOU1/JybCaTsPd9KtirqUudTyYStn22BRkKBKCXcix336KdpCJFOpZNQ0GCrOD/9nPWVDu5Lx9wLtL9/uQumjuhKHZO1V/hzb2o1iufwhrqnGvzlOJH7GFykI343LtKqXpd/6OFUSRqOyqUXqMN29CUubsRSvgGczcJSPVgSrUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKefBjae; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKefBjae"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso15691505e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788598038; x=1789202838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAPnfFUNF7lq9CSa9bFXP56fVVdhSMxJj+LHsOxtOD0=;
        b=nKefBjaeBU+GKVREFGbXqDa+3VEM4BlrfHU9ELEzDzwbqRv3/32MORvxDWyt6VWvqE
         lEFjaVmHtWPAcx7KtgqS8EJ6kWaroXaRuXSm2PSAlKq0i+8HP1o5ife6amIEN8EP2tF/
         YvYw2h5hrsU57aEOSxuACmj3TzskvtzCbM8xRcMF2EnaYjYwOUZQEqoye2Ljlkn5wPj3
         zbfcg9gTCT+c3JljnRzKIaSKi9YXiZPHzN6/2abJ1rGmSLNta1Ye+h4f4usPHspiHmlE
         GxYSbzUCVdAFc0Oaha2VA0C2lD4yc71PNVNnDjelJ2xk1iWM4o+rg+/vbSKYc/xXlarU
         6qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788598038; x=1789202838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAPnfFUNF7lq9CSa9bFXP56fVVdhSMxJj+LHsOxtOD0=;
        b=l+kwhVoFMRFa80YYe1k9DYlFCXmJMIqQD20fFszXKiC3uFcwnOyYaW/82Bx7W6zWZ8
         Avvd3dJ2n/856PIonuXuOO8AxwXRH+KBQIiG2oDkxKCi1LcDGy57toiOLgmTtpFhFjjl
         XfEtjPV422z113HuP5uL8zUHGvN+acOVU7sStP8z6gp3ZWygVzht3NZLQSoAnnNR9S5U
         Px4uMiOvZ+RCLbfnv4qoLiXU5+LLF1b+pLJVWprCTo4YuewatdpbEDFzUD5oj+lDf2ve
         AoB/Onm8RClCYzH/ss7RZ81Kt9lROZUwGY07NpStBzzzjJufcsAmeud+xo75cQwZMuvb
         K+Bg==
X-Forwarded-Encrypted: i=1; AKwUvBxIZ9r8c3cXsGIRl4xUI0Gig6le//irUX7xZLrNOnDUeJRZ3QPZXN05Jjl+G+4f1BU1FfxdGt8=@vger.kernel.org
X-Gm-Message-State: AFuF++lGy3nnwKGLjT2asdW6Y/pegSSougBUOiyJFEUPwrKHiBDk+CzV
	ODub13/vEyKLmTmQZnyni4ZkimpGyLR6l2BnDigct/UoeZ+M/H3HQB3B
X-Gm-Gg: AYBFou03Tp/HWarW9mHQGlqGpAenQ0L22aTKNBBFxKFb4fg1xyrbHgsyMIcFx63EpW2
	J2OfpM3ldqvpdxDb811xA3dyAiVOzPRWUmKpMee+q3DQMbt0smRXoKmcYS1E3ttihHB+S5hOqr6
	ARxunKlchxL8xMrwXe7IV4ywKorQfvPj6P42aTn8sKn3NwElU3kif4UaS+KRTRQhp5Us2OCUD3R
	DVaCteGuHZHP6sGw87mWHYNp8OOc+EMMz7ne0lCz+VEh/8smLs+NQlVQa/5DLm2zw62DF8PoKGW
	hD1Redg5uYp7mdRsqSWt8W0vmxsqFO6jnUb/322l0gzOFsihhpvClzNJEniV+lHxqhiJl3Bc6xs
	VgEmD4J2nYkaxKU9Mv3VgvRGnGUid5TTvLIEmPqwtVm0BLhSU0oMEmEhkY+e72Cyx/4CCq1Citz
	3sAGSxBUkEXpbPQDSIvRw16i7Iyb5ahXoktmnW4VGqQz4aSOjtJT57Rsf+3igQMUDiQAo/ywdGn
	YJ1TownCqkD1FY9dttVN3jKmGq0YBX3Ws1SA4Fn9wqNA1gzmV01u+ineIWvXaxYDdgP70rvC4Au
	xfg3UZMCFVsz75ma8s1xvvT9/EzYTSZY6IE0572qDif1p5cufw+1/GDZeO8U4F4Iv4paOs15mOD
	PBQ==
X-Received: by 2002:a05:600c:8b8a:b0:49c:ee08:6ed1 with SMTP id 5b1f17b1804b1-49cf81eafe6mr118482415e9.5.1788598037748;
        Sat, 05 Sep 2026 01:47:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm105314675e9.11.2026.09.05.01.47.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 01:47:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next] docs: networking: page_pool: Use page_pool_put_netmem_bulk() in the kernel-doc directive
Date: Sat,  5 Sep 2026 10:47:11 +0200
Message-Id: <20260905084711.40105-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool.rst asks net/core/page_pool.c for page_pool_put_page_bulk().
Commit 024bfd2e9d80 ("page_pool: make page_pool_put_page_bulk() handle
array of netmems") renamed the function to page_pool_put_netmem_bulk().
Since then the directive finds nothing and the bulk release helper is
missing from the rendered page.

Use the current name.

Fixes: 024bfd2e9d80 ("page_pool: make page_pool_put_page_bulk() handle array of netmems")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/networking/page_pool.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 817f8b78d246..d0be2b800a06 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -83,7 +83,7 @@ that NAPI context, the page pool may safely access consumer-side resources
 		 page_pool_get_dma_addr page_pool_get_dma_dir
 
 .. kernel-doc:: net/core/page_pool.c
-   :identifiers: page_pool_put_page_bulk
+   :identifiers: page_pool_put_netmem_bulk
 
 DMA sync
 --------
-- 
2.53.0

