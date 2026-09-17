Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3904ABBA1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675567; cv=none; b=fDzjVQbVPDIfCG6QAJ7Eyu5Q2HIQuR2tefqqzxLf2S8VRReG21Y2VclDOsE8FNQoECwpVfPciHM+vAcgCe+AZAtsTZkwLram8yciN0KPOYVl+0WErr2T7tr+ZS8Rxz08etdjpy2ibnKBSv7C/hbzyyxDjWlBvZUJ9gCg+6Gokdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675567; c=relaxed/simple;
	bh=Ya5PIcZgMLo2zklquipUX7Ltx7iCIZIiOZeby4s8p9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khlWPtWyE4lo5DOjOzfWRPiH/LpOpW4yJliWxWw5/nNxQq+wW2eUaVO1FUmXxxlQhbT/aUSCMqEh4I7Dmz9QJNCiT4adiqvMOzREN2ST33+9om6L/eJqeHkv17ab1OyCZfSB0t7n5I7BLvgOhjElEHKdPeeX9ZPlJmltbjHhJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R14WPr2/; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R14WPr2/"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-470417e5b52so63330fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675561; x=1790280361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DvySyAC5XHW/JX+ir/isD+KikFZqdRSkNS9adXYgc40=;
        b=R14WPr2/iWYdRJDQbWsdnRAA1EjliM5PTEVBiFBpW6SUyoCNFJftmCGK1O4eg2eRmb
         mlEOO27TTnQRbG8Qz+fnPUhDWxdG8uqfSU/wocyDkVp/1DfJt8jlw2lKKMtn5t/snYiY
         I7NHNDAiWB9SMHsp5XIstQb5tGcLe7C5p8/87bc52J2NaQv0IK8fy6YQYB0fzp9q1E85
         NLxpIl+ozUV7/XBSH/ADVgCLteLYvhjBjD5HS5S+zGJNyU6AdVzVYgmKmZh2EvLmqi74
         +tlLEHL978/0yVseWBuHfnhtS6MbitUikyV2BLkPoJm6x7mbIB0DXCgMdvecK4bXRJqQ
         pVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675561; x=1790280361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvySyAC5XHW/JX+ir/isD+KikFZqdRSkNS9adXYgc40=;
        b=TBx2M6G5Y0Vuy9q6WWJXI0f8U5QNstCBXrLOHINo/UzDI7kCkXmvUGbIrUpriRBSO2
         PniKJKOLu9A7DeUkWRVnvBoiANJxHToPNPL429YjpMo42/bsZnlL7Ql9WyBvCwOfw4Z5
         NRcIqFILK0HQfChU8qrv/b2n77Xah1v+zOxqw/7NMGPO46CI1ER+OGXHJQPMhVMr2vMz
         4FIEawd2dc1qJFG2MC5q9bwUQBPBY0oggrwWkRlNr2YM9DLjgT2lUQZ5KV+KpQtGUqQA
         cgzp4GKcwUdDnrQT8IqikZVRzawom6oafXK75HGy+TnAX/TMcIC4Fry6XCwTmB3ViJRr
         HUwQ==
X-Gm-Message-State: AFuF++ngI5moLN5pdGxhN7pVieMPVGjOGmSK0bMWrA7/FG6FP5VtIcCn
	j7RrGStNPhJ4e5nOjBJmvqXiObfMmyRwS2qcO7KA6biqEB8TKjAsfSm6
X-Gm-Gg: AYBFou2cdialvDXifFhN4VRgtz2IgVRh3XpZGoNf0SO21tSLqDc7+WID0bjr1chF4TK
	A15wECbHknfqMYGjpv8mTziM3gxyC7vGYk03ZwTd8qI37LKO1Sw2VusIHbeBKsfS2plnvC5kZ+o
	3vjk3cB/aHp87/wjcCf28LrdW3ceRorBqVJWl6BaiSqAaJoV6et8NFQVdfiWQcVwYq73XvSD1MV
	ln8LHZjVUWJRmS0ftiEzUbutCXN61l4vbULL5jeMHBfPfJz4Xj6zP6+PGi9i1xY8SWm5BBgcyr0
	v1p+kh+xrd0ssowIww2l+/dOkv4lE6USu2l6jnYScpmx0sQBC/NAjpwZfae07QQTzvOM8Fd5jdP
	JNeJQ9n5Qwc+VyX55/NvG0VbhlEsZTBoXbLFsVvEIh4sdtrhwTsBKe2ynx3IUEVx30v5cmZOQce
	00vaZNKVol/FIaMQ5qQOitrEmOIa6e0iWEBJSAiC1/VkyiZ4mtpNKAPB8CCl/KiyAktzIbjGhDR
	g==
X-Received: by 2002:a05:6820:2915:b0:6b7:46fa:16af with SMTP id 006d021491bc7-6ca9d14e709mr70263eaf.68.1789675560669;
        Thu, 17 Sep 2026 13:06:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f72801f2sm4144401eaf.11.2026.09.17.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
Date: Thu, 17 Sep 2026 13:05:33 -0700
Message-ID: <20260917200542.3689605-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
The purpose is to consolidate the auto_detach cleanup logic.

It prepares for the upcoming struct_ops cgroup attachment patch where
bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
(link->map != NULL).

This is a no-op change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bced8e20fa6d..0ce58764caae 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
  */
 static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 {
+	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
 }
@@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
-			if (pl->link) {
-				if (pl->link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
-					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
+			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
-- 
2.52.0

