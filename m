Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D243AAF60
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255132; cv=none; b=X9xiuD9V7yZxU0AasxPzv9O1FfOlPoOzYgY+OR7sywWbJ+RCpfRgqbXIJnZr3fW/tegSxG8R6OCE3br43EHSNfEUOE9u8XU0XvCByQc+6+WK/9cT1j605o9VUKDJy1ad10w9bIgKSLrgCkTt1eDQ0MQWpuwuH1Yv9MSPFMuHxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255132; c=relaxed/simple;
	bh=Er/uTSUJqJwQFr/bT7JAFBRgV8FEqRpD4CpEtcK6xpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDQ+je3Mm8l3F6Sll4a7s5TNlIiFMw69n2969/zGs3N5k7/xWg2lRF5Wx9HJKHNFoz4YXVHGo7jiS+vxmYIXhKGvsAPqpIrKECVt8sPR7RC4KKZQVivicXjAnlQ13ywq2rLi4OCRO2JH4uYw68ceJxHCxSPDweKuxu+SSnbW81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlzZiVuw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlzZiVuw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e987a2ba0cso6129335ad.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255130; x=1792859930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iELm3bTnzk4B+pnNJ4263DpWkNBrv9oDYGlQ98xR3Ik=;
        b=XlzZiVuwot0pavBETp1r2opExtv1Fq2MrPL23kQTvocuqrGJa08Cp0FmLnUJru5Jps
         Ht2iwYwKAqJE+0NBShaKeeAvSsQy/CE5cMNG6HycyfimTLaRtlVi1WYQpMVgpoc18WaT
         nxhqrZCKPLsUCgBo9bvunlkDOu1xiYCH7x/FYBQPHXaejT7inafNm55KfzRbYoeukZiN
         oOMnXd8c2y5HRGAQDtYgr+or5E19ZAF6O9Glvmn0ECq0ztq45I6Z+57P/lMx8YIOza6T
         pdVXeuTocbPd3B2SWKzUlpjhzZnPpLdKjfdZhKRYLrhmY24SuGb+WAoQXl6uhIdIrO5a
         9dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255130; x=1792859930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iELm3bTnzk4B+pnNJ4263DpWkNBrv9oDYGlQ98xR3Ik=;
        b=OztjvAVjVi0G3jyVRlf2t4GaJRKq2l75lvDGEERNerJola07VfSG4PKgmaKjFngiL1
         ycP22BJFvx0tJ/LYnc+2ztZtEjHl4ISSgJL52j6zEtqVysvL08ZpQN4VuPlyB74M9suf
         qJGrBlDIH/iln7avOuhETCZb3gsMpW7asCa7gsvjGWZHxKNv25nwVqaez4923X8yekpN
         70R+B3B5EX2vNBV7x8lXF46yFyaod3nEjJD98Lh9TMyrAkB7WnNaBuOFfh2KZzTeGjt6
         Z99zDIqR90r+E3LG2Xg5U9lfPcLisEeK5t93XgIeT72A57bkLmVALvmNDLgUlQBX8C31
         kk3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzW2m1yOfQ2WHYWx3aTLNqNarU0T0jWC1b1vTScmReX/yGPoD8niM56l+eNCVzCH+w07cfU3Lc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMx6eoQbYeV6l/s8DNQVg4k7Ff45Hz6muUEx6WFFbpynyOIqNM
	GD4rpsUKbCF6hHIfgi6Oh5axv0XvTW08VYdOYr9HrOjeQOVvBaYDcOM2
X-Gm-Gg: AYBFou1p6TEwhf4DiuBGPmkiVQ7snozp80vFXhdbfGfcKK/B2g/TINUIuxpFAMIbHd1
	NfVitOH4vIp3qsl9RKqLzs2AkHwbpjCsaMy4oGT/hJhRA/iCINJ7SOkrVyNOPtQJBdIxHuN4Xbh
	xzUAngLBunm+UMUJDmvMgOwReY+I2D73ffEg2i/AdDoI+R1kU3uwG9IzM+KKWmqHrQc/YaGA+nl
	j4Z/uPJxNeLSDeVS+ySqOWXBz8qX7KCaxFaltI6cG7z26KxF6Z7D80pzh+79nskX/ECJQxDvgrL
	GhDor54J4VJS2wfZYcR5lkJuBwkdHrRYe0vdW2gqN0Hnb5g+Gxg97AhHDzjm/BIAeblIWqXDu6O
	xrVFXnK9PBfGa8XFuAU1JO3FAcEO/AsrMCXW+mf5uK/AKa87NU/hWSaOLYLUg1bNiSSVLYT+r8G
	SV8AHQOgEzyUA8tDTU6XkJMxig7Y/COSktC27yo7Y+MTDsn1wdRq/R3O2De7EouSo4wshwSUANi
	ln4jxFsTcQ/7x3q1tF3DeA+T0YeIIwC1YMisXxfxHyPo72+INlZdEkeXrevzN0aOUgWcp3EOtCw
	pkoPOYT7iBnJ7ANnCcWBAKZ8Ei1KD6HboVNhbgjaAZCUU/rs/kbUpQ==
X-Received: by 2002:a17:902:e5c8:b0:2e9:3395:cca8 with SMTP id d9443c01a7336-2e9a6d242f4mr28899175ad.46.1792255130228;
        Sat, 17 Oct 2026 09:38:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm22734595ad.63.2026.10.17.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 10/43] bpf: Don't saturate owner_refcnt on the last unpin
Date: Sat, 17 Oct 2026 16:37:12 +0000
Message-ID: <20261017163745.3341787-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_local_storage_map_free() pins the owner with refcount_inc_not_zero()
while it uncharges an element.  The pin counts when
bpf_local_storage_destroy() could not get local_storage->lock: destroy()
then goes on, drops the owner's reference and spins until the count is
zero.  So the pin is the last reference whenever it is needed, and
refcount_dec() takes that for a bug: it warns "decrement hit 0; leaking
memory" and saturates the count.  Unless destroy() happens to read the
count between the two stores it spins for ever, under rcu_read_lock().

Drop the pin with refcount_dec_and_test().

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_local_storage.h | 13 +++++++++++++
 kernel/bpf/bpf_local_storage.c    |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 9e4f5c45c974..6c643ac51079 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -104,6 +104,19 @@ struct bpf_local_storage {
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
 };
 
+/*
+ * Drop a reference got by refcount_inc_not_zero(&local_storage->owner_refcnt).
+ * bpf_local_storage_destroy() may have dropped the owner's reference meanwhile
+ * and wait for the count to reach zero, so this one can be the last.
+ */
+static inline void
+bpf_local_storage_unpin_owner(struct bpf_local_storage *local_storage)
+{
+	bool last __maybe_unused;
+
+	last = refcount_dec_and_test(&local_storage->owner_refcnt);
+}
+
 /* U16_MAX is much more than enough for sk local storage
  * considering a tcp_sock is ~2k.
  */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4642da062f0f..7721834e4bff 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -199,7 +199,7 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 	}
 
 	if (pin_owner)
-		refcount_dec(&local_storage->owner_refcnt);
+		bpf_local_storage_unpin_owner(local_storage);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -753,8 +753,8 @@ u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		while (refcount_read(&local_storage->owner_refcnt))
 			cpu_relax();
 		/*
-		 * Paired with refcount_dec() in bpf_selem_unlink_nofail()
-		 * to make sure destroy() sees the correct local_storage->mem_charge.
+		 * Paired with bpf_local_storage_unpin_owner() to make sure
+		 * destroy() sees the correct local_storage->mem_charge.
 		 */
 		smp_mb();
 	}
-- 
2.55.0

