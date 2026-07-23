Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0057361954
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782212; cv=none; b=fgGCVANkb9yvx62P/LM4irqZqd4piM9lFU3dFoT9n8dXWASwX3RSY+uZTZAhVbArzYSKbZAXYoVu3xV1jiecNpJDKraLVp25yfugvNf+KeUZawm3WJ0P4JNYddqI2NBNVtTXzqIzGwnCuwA9dSCSfXuIyetAyvV1+FljYdIvujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782212; c=relaxed/simple;
	bh=TZ7U/AHthuLUnoGERTF8l5T/F7F9mFbgJL5SpGEqH5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sugv4HKRvN4uwIlahzxLlN1vK1lhRiIsrFKHFIEslcQKWpUh8KcXT5Hu2QV0mCbsICe4qRj6knznybv8+HorIPTDrgNdWdaoZby9nFqNf03PPyqKKTJrJbGPETcU/7Hk1wxow05mfU1UEYK8a82hVTSrQTzio35k0wCx/na2UE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8LBxF/x; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8LBxF/x"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6688acd1a51so184419d50.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784782197; x=1785386997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oX1J+3MeCS3KsoZ2FoZ1r+rWkZZmYHTG9sCtmKtp15c=;
        b=H8LBxF/xtpoUgX9O4J7in9pZ3xqtM9eRrSAn60Eev8Rh3um/3vOrKflO0LFGJXlXjV
         HodDOay7c7wjY9pEumXzRcbbJt+Gl2Ju17VcWgt7ryS8QNpeeFeE5diKsxumGPibkAI2
         Bs6+x+UkIrCV6db7e1yGVGkZaQUSAQYubnOXsCFEozUfRcZHbO1XvX8mn2EvhgVkKBoQ
         vWCR+Mzv1+rP8UOrqbkSWDt3yc7K1Iqo/I27JhV7cx/85c7R7ARtBo6Y/+m+hjdtDLoI
         48s7ghJnWgPKJ5R8dJPbadYeiUQBzSlGoYLMhdRCRKbhwhvMV/E9KxYTmfKleGauRB1i
         7kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782197; x=1785386997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oX1J+3MeCS3KsoZ2FoZ1r+rWkZZmYHTG9sCtmKtp15c=;
        b=nmUp8AK9EAU4FMxEEBp63LtM2FSHzBU6od1+mWXyMa341wvwrklePALOck4wr4pqRR
         1lqkFwY4l9HKA+A5xe9Jq24jCz9jJi8XP5KeIe1O+AlykHKYFw7Ufvc5uBxlgqDdheFO
         CuPsz4qnSaKTJ/AB8/V3g2dQhowj1cVZlwJg3e1uaAQ2krFKpW2t32ee8JWHaBFLTyu2
         1YAiPU76Gt6U5tPuRSp20c4taNQn8icFK9KqL2cWBCR3A8aCJ7pGOe5962lRLeEJD11/
         FvOSujzSgkEr5oMf8hkS2mTCuspfh3PZyu0xcdE4oJJnUGuzSVGdFc4aAp48sBmqkX3s
         2w7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr7hSYMiDu0v2siGbSkId6Q+j2DRX66kCJ1E1Vqr7BIrj+1mDWv/S8+XdNr8KWkeGwHmVg8Nj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1avsYMKjGc/lSdaO6E4gTOkgxayEiqNdrAprRXLLiA0WaYp/
	pFPjTxUBrxSPASR9s6em/jXFhXQ2TI8vFNVEGm82zQIVdeXe0waaY8/c
X-Gm-Gg: AR+sD12nM8gjNd7peV95htBl76vckxgzTLrWNegd1EUq1Sha3b4rjUGCRZuU/gCFOkg
	WdRUXsKccU0iElsMh94PMgc65zVsnyadxoiIY/I7jiB8NeHznRYfYEW7tuAL0NdEN34bEHITWRg
	YebgX5AEcP5UzWkBp4LWzuL7qIKHJXyE96IysXVGmqjBExgI2J5Vb6klmZSPGQUWyTdeqZejvd0
	vK/bfRPL9+QrF61ypyvxVJxn99ajaIOFXrgGqF9v6TN5U+c4Bsb3UlksLJrgMjZbtCdR6/syrGy
	/iGMO2eT7Rl8uTdm+dIr/47F6K6+PKzD7fzmNkvCHtJoHcG19LJqCBSo8LFUyCA5B3aXYQY9sEA
	FgyrEY13PtbdHSUZ+SJZorWyMlZao3gQajR0Hs3fGuM+ANd+D4ta71Hyvy2r6KRYjgKcwip/dwn
	Vp4IAeJxIRRouzSiTCsVJ+RHwd0Mp34F9VGeq5Wq2BvASZ0WBuuXhH9vqK3W801IG9OixDXesOi
	KV4LqxczX7KjQ==
X-Received: by 2002:a05:690e:43d9:b0:668:91a8:d44e with SMTP id 956f58d0204a3-668a5001e98mr270017d50.80.1784782197160;
        Wed, 22 Jul 2026 21:49:57 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6689052164esm2502133d50.4.2026.07.22.21.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:49:56 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2] net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds
Date: Thu, 23 Jul 2026 00:49:55 -0400
Message-ID: <20260723044955.89471-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

u32_change() copies the user-provided tc_u32_sel.offshift (unsigned char,
0-255) into the kernel knode object without bounds validation. When a
packet later hits u32_classify() with TC_U32_VAROFFSET set, it evaluates
`ntohs(offmask & *data) >> offshift` where the left operand is a 16-bit
value promoted to a 32-bit int. Any offshift >= 32 is undefined behavior
per C11 6.5.7p3, triggerable by an unprivileged user via user/network
namespaces.

UBSAN: shift-out-of-bounds in net/sched/cls_u32.c:236:43
shift exponent 32 is too large for 32-bit type int

Fix this by rejecting offshift >= 16 during filter creation in
u32_change().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: AutonomousCodeSecurity@microsoft.com
Link: https://lore.kernel.org/all/20260720034514.23053-1-blbllhy@gmail.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
---
v2:
 - Drop TC_U32_VAROFFSET condition as suggested by Jamal.

 net/sched/cls_u32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 8f30cc82181d..ac98b1c2144a 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1107,6 +1107,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		goto erridr;
 	}
 
+	if (s->offshift >= 16) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "offshift must be less than 16");
+		err = -EINVAL;
+		goto erridr;
+	}
+
 	n = kzalloc_flex(*n, sel.keys, s->nkeys);
 	if (n == NULL) {
 		err = -ENOBUFS;
-- 
2.53.0

