Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB07391501
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237019; cv=none; b=JX2VueBfdrhF/qxImlzx9j58S3DuLV00IgB6Qb6mdwlZ12vSnxcxjbCt8lK26oX1yBJxLL8jIAqCu65UUCDhh1PxPcX7dcFsoX1vzGvsgdUK+Y9sLjYIJkhdktnAXIrWQZFsrkxQOKGIkO65YqJuy9cCtsgwLpQHOnwMdFvAd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237019; c=relaxed/simple;
	bh=vPK7Vn/omoySwDXOlGbKupOxZsD6+JDynojrGEu2s/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsnDCJPZMc9uplC8rVQFZVmP7G3I1knYUfUxLk5sPI+vNXcPgQtsefiVVpKBewuWV8PMHAQ0tFQgWoL0kx9xBWn0wO0uYuvQn30/IppQBj3JoubcDS2Ps9A6tA2D/r25UEBoJE7CB7IWeHJAQ5jaB3qrfk/qA3w6yjIeO50ZWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIDnmo7I; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIDnmo7I"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-486852c7b68so139141b6e.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237016; x=1782841816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ8JjxxRbRZTB/xdTCcikhmUU/ER5vgkd+n59LPEpXE=;
        b=aIDnmo7IEhgQZ7DieB+wMJ3/kSJOprmRvPklW0Bot1KhcicPa/Z44YFVsWcltqxxNh
         X8N+Tc5tzemlSW5fadzal6jGcvDUfGnozlwJsV20JMuTcmD7PQ1TxrsVaLcB/MFDbEbB
         DIvUzP1xR8kdDJRncW/qVjFY5fV2GhTH939ZTbrBp7OF6MTEq4CbhVQEekNAXl8fbMOn
         ZA4/wcW0Fzds2+7kdhG25djg/Cw4tUdTTJad+lF2Pc3LnwjvUA7gCBwpALvDWKZBy42H
         tYosXncHiTouo2EXcBLVVm98Gh8omPZx1jgM48MMIS7fnNVHWlJiwquI8TMV8u2hFO9k
         3aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237016; x=1782841816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJ8JjxxRbRZTB/xdTCcikhmUU/ER5vgkd+n59LPEpXE=;
        b=gdcq5ssKg0Z2xdyqyZ6l9ebjgTMFieoTdi2anBJUo+ZGKIamCRhsgO3h8DG535qb6c
         hMq3TpYuTkgYRSPFktQxWICZPrRUz6lLYKqFf6efwsT4nas9fZAS+HSUlZnIH2xopskp
         32pg9HS0cPYG+5bjVy0R5oyhVYDBjdMfLEni/dIg88WLbX8D/gR8euHfgiLAAjuZ32VI
         n23v11dsnxS945xDabtdDq9DGYIDXPY8WnZKZqHmHW3XaeX3Mb97VmYt4DIHXqnMHOik
         zOaJ55rD6HVzPSh8pxmwPOBBRPHmDIkowRdfdWKgPQj+5MW/pXBWVBooa46j3ceNnkmt
         tnlA==
X-Gm-Message-State: AOJu0YwOCEQqqE0npeV9nIzEl/uJgT1w3DxXMKqxaOltdvFaVH5CAnaG
	AsFXiz9W0hwSODAMtzXIqAp4imPyqDko6KQ68RELNb1yMMfkQNIt0Wfh
X-Gm-Gg: AfdE7ckcRIFdDM+tWHQKLPSdnyvYWdWjxIvbNqKjNexW9YI6xDXx2Ty3XYsY5kNfOVX
	FzHAwkzzV+/yLCElbQ5URXT4gi7O4hmvsRe2QzOFR6Gx9xTp9h8VfyaZR2H+wgEdhCRLsuBnjzv
	jXGqP1hbby+mRlqpWNSW1DmM9S8m1wPZoJkyNjiMDuTLIiGM0LnGxXOSlugausho2H/OPqfjM2o
	Qd3bUMt2YEyHhrMA++TqL9fp9ghe9YgNX26Ws8ih8wRCWHF/nG9fS/BPrhxNPU8yNrhHbWWSFxF
	By8/15efuI9QUo1HYF/yOdvvhESEgtkZhMnIf6QXjsBf343VSL1PRjd7TMx/BW0Vjx+ytIypIfj
	nqFdzv1MInZIPu8Mp99H1KtqL8Apha0a8PoXupmR/ArNWeBAWoK/5LQNfkAencaMAToI3Dayx5L
	DLrA==
X-Received: by 2002:a05:6808:14cb:b0:47b:c2a2:1c79 with SMTP id 5614622812f47-4896aa06ea3mr15642770b6e.1.1782237015659;
        Tue, 23 Jun 2026 10:50:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf23f7bsm7180537b6e.11.2026.06.23.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Tue, 23 Jun 2026 10:49:53 -0700
Message-ID: <20260623175006.3136053-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
to skip a 'detaching' pl.

When pl->link is not NULL, prog_list_prog(pl) returns
the pl->link->link.prog. This does not work for the upcoming struct_ops
patch where pl->link is not NULL but pl->link->link.prog is NULL,
because a struct_ops map is attached to the cgroup instead of a BPF prog.

To prepare for the upcoming struct_ops patch, this patch
replaces the prog_list_prog() test with the
"!pl->prog && !pl->link". In __cgroup_bpf_detach(),
both pl->prog and pl->link are set to NULL, so testing
"!pl->prog && !pl->link" is the same test to tell
if a pl is being detached. This change should be a no-op.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b64f6757096c..b100c04cb9c8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -408,7 +408,7 @@ static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 	u32 cnt = 0;
 
 	hlist_for_each_entry(pl, head, node) {
-		if (!prog_list_prog(pl))
+		if (!pl->prog && !pl->link)
 			continue;
 		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
 			(*preorder_cnt)++;
@@ -482,7 +482,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
+			if (!pl->prog && !pl->link)
 				continue;
 
 			if (pl->flags & BPF_F_PREORDER) {
-- 
2.53.0-Meta

