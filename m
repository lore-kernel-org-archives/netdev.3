Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDAC2BCF46
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649662; cv=none; b=KlEKp4zR5N7T+XzFkkovMU1H+47hfTprCs5a1eoFtBDDjrlp4atqD/0VI3PdjUvHIdR8oxW2/wgrZN1LV8IqlpbVHjUsAtbmNYu+v/FHLd+3H818k3gynwwisNdu5uOmslnLqUFGFR+UOxQeryGZXpmTthlU/RSCDhKa9RmRUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649662; c=relaxed/simple;
	bh=rdM8JPLHYnjPIdq5ik7mhjIN2Q2rhBcNlhqYyfq+B/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+C98K1IOcIPH38PX+2Z9YNotjUsYz8PkdLtmpukcY6YU44iFpOZCx3l2Ak27BYAnoPmyXipAa7QjKuGc1NQQE+AyBXTigmSxNunmJaLwdtkRKMswkd/vVgpMCIKPheJINkyWfxpEDx25BVmI8tF4SJuHRXwdQwWUmflushskOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnVqBEWx; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnVqBEWx"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9dcf09efaso47812a34.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786649660; x=1787254460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x2VaWWslhpx0Xl2aEnKOCxt6NrW6Fpk6Sa9sJa7UQo8=;
        b=KnVqBEWxjrCm7ZCrerYnDDVcVghK4uyGykddPhCmJxPTbCdyIqOP8dysVbh8GpZ+mA
         0c0NY6W4RWEpY12P7MwaeRagPIJ43Y5+XEmx58RaUjiwg4uPZtZO3NuQWq9XADa/O+Y7
         LfwOI+utywoJv7UYFyYo/U1umjRkStGKOJImKX0v3ACGYI+QY9tn22ti5SCpSFZo9TBS
         ZHtl2MDYQiTNH3eygw88Aq7v/sfgPZ43Lfey4DikN787aKafr4EifJ2XdaANzt24uBqA
         342ZnXnwymQaE+VdrCqxJfRput7ZNimF+TmzCV6Bh4QPgwsHmA64k4OzKFMeEGVPaQlx
         mM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649660; x=1787254460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x2VaWWslhpx0Xl2aEnKOCxt6NrW6Fpk6Sa9sJa7UQo8=;
        b=kQ5biUH3dQf94/9H53S88KA47CYACYhhPmHfpqLsqW72PBE1Z0yK3msoDahCRtHNXS
         gKmnaeJScdHsFm6WspAcBEodrl+IBS+8cmG7MWUUQ9hkygVsfuHgoRv/NWHfep60V6Og
         kn98fcJGuGBA/mn4SjgMktdVQOQeAAyvVtF8F9xri6PLaw3QKwTo3rLLd4VEO6YueGSS
         8MeNAqmBcv56QnbS1hZgP4QedK0eE1VNe3GgRlE02dkda5OGNbo2W791+NK6W2kYz7BR
         KY0fvHrYobOEZd9imEN6H+qHDqA8A7hh52nE9jbg37VG8rynegiKyPMeNPfU23HQhTN8
         8T4g==
X-Forwarded-Encrypted: i=1; AHgh+RqwpfhgfUWKHld+ATNCWWDafDj8oqfXx+nTUnWG4HxBAFFsBU4vEsMTT8MH+YMSfCaTLsKGFQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86b7S4BESu1bxYIIFhqgJgdfp6BwcHUc3atp9Lwl+20PiQ0cg
	cQ7TJzJq6uqAk0Sp/kniaAYmXEOAJThkx92ZRe9lUz5D5sa+Iao6m5Lg
X-Gm-Gg: AR+sD12B2hBuKsBHQejugfjJaH1rE5suyS3bBpFwLbENgAmoUPrUnfPMtu+OgQr34wt
	QHlavq2LPus+gjrkXLknvO68L3KbtETAYiBS2x3FcpxkGX2G7OvyJLZwWSPp0b1ffhMzi/BU/sF
	VUh/x7v+hcvIVlzzVmh+FRu4YCbPkSfLGqoZIhoxdeapNVwMgXFaGNhErSkV8ZnwHQZqQMoTiAW
	wDOKET8nPLMIJIBKGXVAjkg1TC7FmuHflbTikHvCLa0pFKgFAI0RBnmDFTU4EsOPQkrX7FxqL9b
	Lfx2zrGQ4Vl6N8oRjGCuPvoGhRDiE5Xkm6tZAdJ1Be9g0cc9KayRWs0pdJX/cjjDqKDWoD6Rac0
	PNHHxEvPR1xutkYKCgfHlBlWyhZGgG7wh03dd/mgxFqSMOFfXjWgieaLY38n4iakGx9bNTPZomA
	hklZ/Y30wSC7bABYY5vsGcd9kWXt5kkpAMRyW8PYbJPksrHVNJMExSmeSvZ8x4QA==
X-Received: by 2002:a05:6830:388a:b0:7e9:d089:d7bf with SMTP id 46e09a7af769-7f3de64feffmr42902a34.4.1786649659881;
        Thu, 13 Aug 2026 12:34:19 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c974c65esm2916051a34.0.2026.08.13.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:34:19 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: daniel.zahka@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wei Wang <weibunny@fb.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net] psp: use unrcu_pointer() for the cmpxchg() on netdev psp_dev
Date: Thu, 13 Aug 2026 12:34:16 -0700
Message-ID: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <weibunny@fb.com>

sparse reports:

  net/psp/psp_nl.c:513:13: sparse: sparse: cast removes address space
  '__rcu' of expression

cmpxchg() returns typeof(*ptr) and its internal casts strip the __rcu
annotation. Wrap it in unrcu_pointer(), the documented way to use an
__rcu pointer with xchg() and friends.

This was introduced by commit 06c2dce2d0f6 ("psp: add new netlink cmd
for dev-assoc and dev-disassoc").

No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608080910.l9KvOH7O-lkp@intel.com/
Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp_nl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 43b066353c65..f91665748dde 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -533,7 +533,8 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* Check if device is already associated with a PSP device */
-	if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
+	if (unrcu_pointer(cmpxchg(&assoc_dev->psp_dev, NULL,
+				  RCU_INITIALIZER(psd)))) {
 		NL_SET_ERR_MSG(info->extack,
 			       "Device already associated with a PSP device");
 		err = -EBUSY;
-- 
2.53.0-Meta

