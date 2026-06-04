Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C930D40D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610950; cv=none; b=FbEg6Ta/Lrz2qTntkqk63wMbBNUi3sAwKcP8GOI3pJN+iG5fOvyfZk3sTuMdhqNuEjOQ8BmRZ7NaKQ1M7zD5y0LGbuYOtGtiDzHvJ1wbOOA9uBFHH29q/CS+KhNBcg66Nf8E8kRjM4K4p733KeQrQsW/69Lc/pjUdCWAKt81BoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610950; c=relaxed/simple;
	bh=+X+9TfLYSycM2HPO1ZGliaygiNyuXO2Y5PqJSerkc/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADWnqjDu3HDH9uNxI0inhkhSmdRQupQzJIhdLpyROxVJMlqV/ppZNUhsBuVzTnkeRhpw3AqIpr8xIEm0rxyTl2eexQ69tMJCV1CblhDmKItzE46rX8euVyGl8IxWTTipyLFG3Zc4oQRQ1yWmxeci6kYt+tRKUh2LtUh8miT+tYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa8226pV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa8226pV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf114b0cf9so10356705ad.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610948; x=1781215748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH2Bii3TFDEbVaIm2aZbVbUnROsdfZJZdTJSpnjysKc=;
        b=pa8226pVlwEb5CHS+a4dqA9otNVMvoFguVGYT1vZ+MgSJF2vS4OWaCdfouz06czKMt
         4XMvfeo1sdLqZP+/5CO/MAVDt00yV85IsZi8XvrscYRwAv4hz42xXVvVLJglO76YYSOa
         da/GhdPA8W3GyrGNV5SB5A2qasEGCiqsCzS/ZB9iitmf5RXIExZRBJKtAUbEzfkkkBqJ
         B71tV5s/DTa51+V6FZsMx4jpJ0KmWJFqdeNXrAdH9OnQuQB/7W6Y7A66ZtmcDhN0K9FC
         0j2FM+oaVKkCoNdC1EhCQI9iI57/j8bydS8UPE+KiYAjxTeHlUpNnXC3EuomOwdO1uy2
         5wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610948; x=1781215748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WH2Bii3TFDEbVaIm2aZbVbUnROsdfZJZdTJSpnjysKc=;
        b=Ta6jjpAP6Onjl8R5rm/n9ruJapQqVFzFeQ7/CAEsOWt1N+CBVRAg2PIos4JenAsrjT
         uXjl58m0WGffK3nt8bA5/W3Vnw63ylN4ChqOyfBrv/28QAN/M8gVREGdSf3SSIUY3zWT
         j3swiEaj6jouf3ZhyGyV8PGWJXF4Ycd6CImo+2UnqrfhTXPCb40m5mo/86MN/SmtUxZ1
         7pAG8koDGuVOqa2iYMxBIg8JWGB0bxuzQ35Gk7f+AaEEpvqBwdtySTfbCoKA3fB05/xp
         +tv0uj04jIN6LekAW3dPQebtDl6uCF6daWQ6iiGTVHAFVqdJgtrXpHsPDtalr7Sxtkoe
         mbDA==
X-Gm-Message-State: AOJu0YyYp02hOOD91wNzu+fp16qahis9z2ud+MCD75BWe2+zjzDXgRtr
	poZJ/t1QA2IZ9P5s24vacRI+MXjbj4tRH8eOG/6XM1pwy0k3sM1SIX5MOK9B5w==
X-Gm-Gg: Acq92OHgZC/3i/AqgT25Sb5qszdL43cspv2SMxanZY7rbgUwHoW/Hyfusdlx9loW+8h
	bpYdMRaIG+ibCI2sSr+JzcYOqBZaajE6Lz7nLrJG0t1QPyGphrGXs5uYPNihNkVnMplpzYVeLo6
	8wAMirAL3VawZ8jNYdaiMdM9DDZbP4jYN4hcaUn8W/aif7D91j57wdFClAfuIJA6KQSEWfZ7a0o
	1ilqDheeruG1y+TFF/ZUN4y51T2+d22puHa+PKNJvvEOD6jNQT/9gT1OzF/ggXeMtb51KckDMBL
	vnl6jF8711NhxeKPn/wsradPptOTq8NYh1JlBCC/yus/pf+SNvNDLQphsa+lPY+nxEboiteOYef
	P92rwD4eXXybnuPBrQSqCRBk2trPMlsGCNH4BVs90spOX9gcDS7TLaQdbqBujm/lJUCWkMS5eM4
	s3skJoTg7DHmBT5PBbkpd/QxW7bVl8bpYrng4=
X-Received: by 2002:a17:903:4b28:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2c1e89579ccmr3625675ad.35.1780610948100;
        Thu, 04 Jun 2026 15:09:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609ed97sm70195545ad.41.2026.06.04.15.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
Date: Thu,  4 Jun 2026 15:09:03 -0700
Message-ID: <20260604220904.1032145-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refsafe() compared each reference's id and type but not its parent_id,
so two states whose PTR references differ only in the parent object they
were derived from could be wrongly treated as equivalent and pruned. Fix
it by checking parent_id too.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5945956a7573..06d9ae24f006 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
-- 
2.53.0-Meta

