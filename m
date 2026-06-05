Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3179E3EC2FD
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684557; cv=none; b=Qjd5aHA7qYESnB1j6GR2s7jKxMCT5v/9BTJrVFo0g3xylAUC+MG45wZXSqsIwQ/L82QR1hbn30Wa2UB6aDOZsFKvv1q1jX6VnW8GJYL2MEaG743rZYXHOR0ck9Te9p6EhJZP2mmq8BXWulm9TKSFNcIR293TR2vNnHK19guOLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684557; c=relaxed/simple;
	bh=VVADNSV1X9wTkRBoKH71hQL9qSar8jZgE+dZ8EZnP3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei/fYC0r05E2AZdLwuEDT+iDuyl/uCxHgA2cjQSoCX98c6vlZi5fa5j+G8UXdFzQ5DAFdvwlQcuSLcFKP49pDXEwgUoWJpu0g3kxVANqeQrCMBNKxAOEiGU1UkIJzn0am4T3RsKdyu8a2CCqrnqKqHgxW/vN9UVmHAJm3+9e0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlboEMWO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlboEMWO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so2287682a91.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684555; x=1781289355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=BlboEMWOWKmYDDGiMzxNk0pjbSJCeaXVg3A9oFzpsXNlcWLqRKc8yAcrLV1y6+VJxc
         lEc2KNS5+vrMvWfLq5yve6doTy1lQL3gD/3F3XSUooQ+Xopc5N0iAOQjCVmmRZN0VZ8p
         jyRM9PlPQa54a5F0Qp0ELsizlOLy5H9WXiDO+1MJuLgEMt4/QbWjVEz5b+OipUwiWYgS
         LEx+PT/as8EA3iYBEqEnqzu5zgpEAxbl5mt+LSyYay2Iw5uTpK5YzJ+GtPzJSfCYxFOY
         shdMvLEeQyffZZZ4Bg7BA5uMUnOKj/UcxvLPfHfpxLd9h6YrWaH3TTToIBP+XK8DYhUQ
         e1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684555; x=1781289355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=bjBSlvXX8D3HL1/bLsQ/pJToQZjEIKLq0qgWsZ0AnmQ6ileDOhPdiMjLOV8Q/bScDK
         WW/hieGI02P3h85VXtB5MNT/u9rjuOnDjBLLMKW0w/jewYNIuDe03y6h7+mDkzAyGxnY
         2r+7aq7onEbIbKvnPVJiRDBOLLXP8o5D9D1L+1UwTqkO1Kl0Isl5yUqCx3TRGFEbdqHW
         0gJJQwZpOpdWuFEgEnIdoP5WQqacSHyx+XlcwNO03Av+7p9BMon2BBNt0DergN8FJVGy
         vt6IGmTHQKpi8Rkn2tEgXK7hR1HOXIaxUnhYhLX8jefjtxQx5VJnG/PTIb7YvLlaEJa4
         8TuA==
X-Gm-Message-State: AOJu0YxOx1x1mM2rzzk5tOwaOukBo3bj5nvpoYmou348+Cse2YniN05B
	tqz5lLiqYbJoypcAV7oa4511It7BgGfiUM/UaEyDL8A/8CGi4FSiqwwc
X-Gm-Gg: Acq92OGI6a3F2Nbp8eSeqtmo7Rsnm6HozlF/bw1/4zwg4KbFiM+q1OsY9lMJlt6nghN
	lVFqsSakUji39Dd7zilanQfcW11UJxD13nkSeJCXzl0MVRIrNDSAOpUZ0sfyugoaIarx6u5oFAZ
	dnK/vpaBnykV/4SLysicNXoQsjeGXv0U/zHxU0Kvqww4vKFVN0mCvyLPl3N2P6/M2I6gY3Sdts1
	iuHjnrrN9Zn+c1A5Sf6RspzBIjsosqJAX5YYncDaYG9qMQVR7mxQ4BzglrKceIIqbI3z0X3vgV0
	OEIGGCyISo0iHo9VR+Le3spYUu7DPuHPV9vRyLS7yqkX/j05kJvWfzCRyipXj1Fg6fRtBb4G/aX
	CJYgABLj7w9dQvSTIKbWRVLdTbbj9C3AXNP3QIfgAUc+tDxILJB4GnWSo3fsxSKrLTJ+0dhehHS
	ORGEMVw3y23Q8CxUgA3o6WAnM=
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr5225778a91.8.1780684555542;
        Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c668f9bsm7340861a91.7.2026.06.05.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
Date: Fri,  5 Jun 2026 11:35:49 -0700
Message-ID: <20260605183551.969144-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
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

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
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

