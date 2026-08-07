Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB83DFC92
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096856; cv=none; b=DuT9hyEVrNaTYOYWl5EHD2dQkLQ2PGNseGBi+lceMX8L4SYcmaucLpeFAVaMypQ9CsK+al+bP8YVwf2lQyyvCzpJr40yVM+lmokXFcjWD9ubib8pa/onOU8GwZaHocHHdVgLrtgaRVNjXG4Ac7d4nXX1pCZP0Nt0yPKemfv/l4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096856; c=relaxed/simple;
	bh=MCXM2XKBVlX/EwXo9DZCvLtvoatevzZ4S5wRf3peb1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luJ43FBK4PtL+MSmq0VSn4edH+Ngu+ZHnxT7H9ZnVpmmc8KfX2v9GxxpUXHonogyS51s7R1zKqGe+rLLfeau1wMmFqtCoGM/uS0394fteAIVyfOAXJUL/JKQWVIHO+vqpl7dMAKAVR0wEPF9ZeZQtWRf8wfWObLnOpAtw1Q5WHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG+rNtPy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG+rNtPy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf452def93so15111215ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096853; x=1786701653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXJlW9JsusO8To5K56BmONAgJx5Sdd1b4tle9i9ZWE8=;
        b=bG+rNtPyUBAtJ+cL2Lq+M5Zt0zbQ55t7q+ccSZlAhyytJZjsNcJ+WuafaI7kcLTd/K
         ZtBUpIVy/cJq18W/WSuhGRJSSfZtUWAKIn6dZEp8D7wAfAfKnvV6tZ6aU/Ia2YdG+3yQ
         0cC+7mnhptf6ulnAeZ/FtHjgKUkQRQyPOAF/Fa4cdQSseYE9lZA5mJsgrBpu1JOyQHBV
         UNni/TagtlBMIuJ8FYcbiMRhw5nhPjTff2HwkbP4SBJ8sTf0r533rJ651S01heP7cOEp
         /xqvI/14JGC+TS+2ow4MV7lRN0VJpajYb8mIHiiAHVyj5f7PRH3bIzzHVyx3XQr29V3I
         b3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096853; x=1786701653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXJlW9JsusO8To5K56BmONAgJx5Sdd1b4tle9i9ZWE8=;
        b=W+zXVbzFTbct+NGKULZVfccpxb5L1zXiyqJq+vF5UyK5WiuG3kg9k6NbzKPGZHeFXv
         c7ucGOHcoecXvhWJ4NB4pkjjN0euP8OSZRa3OO2vPA4llVeKAn8oeoZlm4qgjZ0VBMBF
         r05Jq5cxj3Zot5zG7UAmXQyBqX7hrcW8sJRNvIcAvE3FjGMJckHXH/8G7C/qeMx8kBt5
         3yndBUnBjY5noTYyCjy8QKfzZwvEBvziHbJK967Iyiheyw451SIstazj2Q7YH1bRFt22
         tsC0Mwbnm6Fu/hQWNaHa3zuYdIhiVm/HqTVLlJ4d6FnxKwepmcBqJGz+PeYosQJDvUOa
         kqEA==
X-Forwarded-Encrypted: i=1; AHgh+RqHh/61zJyaagUupEq7DrTC4aBZu4j2oXuw8dHui+KBNRaYs/FMQyc9eSXTiRxaPX7bnWcD348=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGhqwKTZg0mihQaCpZe+zsPrT9TXeinPAcomYcD4fkC1S6lNH
	Hhs+7FJNAJZwMGfFjiMs/yjYxL1OeTCr7zzbDYUvdZoGC+Mqi8AzXsUX
X-Gm-Gg: AR+sD10VjtGv3BPYrocu7hc0IG4n9jZY2wP/s9A2N59ubiA/ko5PQ6sF+S5JhfciLPV
	0NW5idV/agMX5wJNQBJiTP0FIX53YE3Nn5ukWJ5iYeCKtwDhUOdJ0LWrP7nLJaE3GtF9EWOkpe8
	HfI1hFGfK8L5dTMWPEu61EJE7MjAR8JowO1KBWeOCGvrEjbys0knPQ9QmI9g+c7KyGkt7Rbf3/A
	RLERUJ5XdziH8lk0oXtcRiLwC1ngD3aXoM0aUkfGopaBCzoO5eFifK+5c4znzB9fGEdAFIcUK/M
	fRr/+pGZn5S7B5OtRORrbE1KSQZVGOKXfbQHERwkeFNT97Sr3VcCjSx2RtgioWmI7nqlcUGslW4
	7GaZVy6th6jn9g9wMDrtR2dbndB5qvVUq/5p+91C8T8a5qTi0GhRDr9ao6zCks06EVBMyQ0oE5m
	U54csbP6ngZfa+JnzRc+Zj7VACh81VkQH6B+jjDzJe7wnFSdZuEpWBKjazfBPDq3UYbgeLVIzR/
	Wj5WuP8q56KAwkV0DcI9mzyncxNRP2iacTB9sYzKNtrEzWsn1dPcck=
X-Received: by 2002:a17:902:ce0c:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d0f704ca37mr63534455ad.1.1786096852750;
        Fri, 07 Aug 2026 03:00:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:00:51 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 1/2] vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
Date: Fri,  7 Aug 2026 20:00:24 +1000
Message-ID: <20260807100025.19750-2-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807100025.19750-1-yuz08559@gmail.com>
References: <20260807100025.19750-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_set_config_call() swaps the eventfd_ctx_fdget() return value
into v->config_ctx before checking it, so on failure the field briefly
holds an ERR_PTR:

	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
	swap(ctx, v->config_ctx);

	if (!IS_ERR_OR_NULL(ctx))
		eventfd_ctx_put(ctx);

	if (IS_ERR(v->config_ctx)) {
		long ret = PTR_ERR(v->config_ctx);

		v->config_ctx = NULL;
		return ret;
	}

Commit 0bde59c1723a ("vhost-vdpa: set v->config_ctx to NULL if
eventfd_ctx_fdget() fails") added that clearing, and spelled out the
invariant the rest of the file relies on: "we consider 'v->config_ctx'
valid if it is not NULL".  The window between the swap and the clearing
still breaks it.  vhost_vdpa_config_cb() only tests for NULL, so a config
interrupt delivered inside the window hands the ERR_PTR to
eventfd_signal().

Check the fd before installing it instead.  That closes the window and
matches how vhost_vring_ioctl() handles the same failure for the vq call
fd.

It also stops a rejected fd from tearing down a config interrupt that was
working: until now the swap replaced the live context and put it, so
after an EBADF the device silently stopped delivering config interrupts
until userspace installed a new fd.

Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vhost/vdpa.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275..e5e47f6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -529,18 +529,14 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 		return  -EFAULT;
 
 	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
 	swap(ctx, v->config_ctx);
 
-	if (!IS_ERR_OR_NULL(ctx))
+	if (ctx)
 		eventfd_ctx_put(ctx);
 
-	if (IS_ERR(v->config_ctx)) {
-		long ret = PTR_ERR(v->config_ctx);
-
-		v->config_ctx = NULL;
-		return ret;
-	}
-
 	v->vdpa->config->set_config_cb(v->vdpa, &cb);
 
 	return 0;
-- 
2.43.0

