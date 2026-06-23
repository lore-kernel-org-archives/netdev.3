Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F23911AD
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237019; cv=none; b=G1JAsPXfaC3fawrMjOpyPzVHnn90ZH+flfg1fe5HJ21vz/yLHgUUfZh6B6VewHC6kZycpe6Z4onu+LRG8wlkAd8EBas021pTY3Af4siFDLKO4PmxROrp/qqykCj6rnb0jschg4tpoTvfs508FdfGnw/DE7WPo9vBJkrgeC2e53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237019; c=relaxed/simple;
	bh=XcqovPOaKYkd+iBiFy/6igrU7RFiqU377DoT/XKPiqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdEzVMPMjZhyytmniRtJzVZht8h4VGAh9SgBCYH7GF0HTJgmPdr/4EZdkONAeL2jPTKleMPxfG2N1vBDTl2j2TAPfMZLNiKbZq9/2j1WbeQRGRE3NwbMkd+Zejy+4CcuVCyJv7R1KrL1ccJyj8UMl7QIVRddR76l7UpyE15BVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASf3xuoQ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASf3xuoQ"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a0eb989530so89864eaf.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237014; x=1782841814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8soAYOZk2vTD96d7XVKF7iLBauYSdEF+qrXftHgJTD0=;
        b=ASf3xuoQR/8rlYKvr3oI2Y1WoEujfXLkrFO5keT2+WiZqDDYc6EnPQjGnkvgXlOhEw
         U1fIaFuJvVccRrHR9x3OmMfIUnTZlooeBqYK6gSXpvxzm63HlMkAjogF56qOSTygUtp1
         Tcn2F5nG0oNgzN1c4RblABtbePPKfNYExbIe+LRo3o6xj1Pw8sb/PkIwC8UJofMgjPiT
         4cCwc1Tljr9LiCOHrll561CZAggIc6UV9nTxrrTit9y/Odhfuq7oXLVirR59Q8sJub1/
         jEAKbWJCiDHLwkDzjO02JTVrZcHQRazP1kh2EbfEjEIno2rmNa9Jvj5r5cuuiPcjquK9
         ukNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237014; x=1782841814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8soAYOZk2vTD96d7XVKF7iLBauYSdEF+qrXftHgJTD0=;
        b=GTNBLnqgVZINxAkjtzJGQ6con1dEGAM7flwhGMNyZD9nG7I6FIxRy9tmDfh6Jzol3w
         8VBr2TmQib65VkVyLq8OmPi5U/u74wjuQ06i4hR/QUysOTHZfSH5iJZqD8d9wMm2jlTS
         YRSbAH1PHsw3CnpikXB2CX9PLiuP9o9kQqJ9KKPA4Gy2C0FEOC3ppKxuwoHv0LFz4OGv
         VKUWcEuz4iwfy8Mn8x21L30L4PwE2/AkYjvC2WevebD1WvuT4w03WZpsOHM6whqUInnT
         Af1PO4wQLFIjmfDTvITw6jWX7CgB5UegEAf1BH2GF6dqODA8Q0ICzzwmJ8Qf1FuCz7aX
         g8Vw==
X-Gm-Message-State: AOJu0YyH4vyAFeZJulGzaK6w27cQ4iuSf1oUV0CdfA2csAqbbYCVukNM
	0i/0WS6NSnjNB2lKMFuM7uY18ikpRtQZ2IeXdmg6Lr69EdutchU27Ll0
X-Gm-Gg: AfdE7cnDf0KCrB1FC6XVnlBs16M4G1+HBgpSqf0xiigmRItbQFVspFIS2wJytwIT4U0
	8ktwJatxiSCVkh2DZ/FLV53ucKWNaEW9//q6cSBF6nOp+Rfpuq+dtXFm1/PGp+HIRqxeMywC6GQ
	dwRkCLtiSk+wWrLhRO3zsun6MaFanp0KLXIkCYnvmfftec1noqZKbYId21CAirwVqPPB5LtaHzr
	FDYR9RVzLiVArl878PMFQpe0Nt5s3R2my+0thWdt9QmpidQfq9IclDfE95jCi9skR5d9vYjYw8K
	zCrk8tCy4L1+quB/QZN1dl5o00rJns562JlajQTMESAH6i+KOuY9t19ApImokTbWIrxZTLwLHaq
	JsgBFOnjtbVTbMyzvY+x1n3wSg7vdxYPCWh1gly0FKsJWYc1Vx18YF5z99QH8zIvvjFUuPktU64
	CIm2kGAe6nfnQ1wQ==
X-Received: by 2002:a05:6820:4c12:b0:6a0:c6fa:5a04 with SMTP id 006d021491bc7-6a1160b0701mr2351440eaf.2.1782237014116;
        Tue, 23 Jun 2026 10:50:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0eb8adsm8476735fac.18.2026.06.23.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 04/15] bpf: Remove unnecessary prog_list_prog() check
Date: Tue, 23 Jun 2026 10:49:52 -0700
Message-ID: <20260623175006.3136053-5-ameryhung@gmail.com>
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

effective_prog_pos(), called from replace_effective_prog() and
purge_effective_progs(), tests "!prog_list_prog(pl)" to skip a
'detaching' pl.

When detaching a pl, pl->prog and pl->link are set to NULL in case
the update_effective_progs() failed.

However, replace_effective_prog() is not detaching a pl,
so the case "!prog_list_prog()" will not happen.

In purge_effective_prog(), the pl->prog and pl->link are restored
before calling purge_effective_progs(), so the case "!prog_list_prog()"
will not happen either.

This patch removes them as a prep work for the upcoming work
in attaching struct_ops to cgroup. When attaching a struct_ops
to cgroup, there is a link->map case and the prog_list_prog()
will not consider the link->map. The replace_effective_prog()
and purge_effective_progs() will then incorrectly skip a pl
with struct_ops map attached to it.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..b64f6757096c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -965,9 +965,10 @@ static int effective_prog_pos(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
-				continue;
-
+			/*
+			 * No detaching pl (NULL prog and link) is visible to the callers,
+			 * so skip the check compute_effective_progs() needs.
+			 */
 			if (pl->flags & BPF_F_PREORDER) {
 				if (pl == target_pl)
 					pos = bstart;
-- 
2.53.0-Meta

