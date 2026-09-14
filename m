Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAE346FB3
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368708; cv=none; b=cwpKzDCN19wtZy+mj4GGwJhLuWPmmuZDqnJ0HsV/TbyegCTJPy+4bz0vNr5QH93axw5GkXDY71f5Wh94dRz7sGxcQv4uLGkRwQLP2dIRJMVHSYB7+L0KYSR0Ge/3d7UQkHILCw8RtRFAdW14X3E3DmMIUj7WRTPjRMbnRyKr7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368708; c=relaxed/simple;
	bh=RBAqUG1/rYQvo2+3aglV3aYZs0VtlZNFDIZJVBBBAe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/AXyRVhQ5aGUDbTSYtVeVeWWax4kse1NTKxr102GjLnJUUwpJaAV099999VuXl2H3VGdTdhNKeG1ymXxK4U1U9mL3ibGmgLrPwUU2MC80EPaUxmJXoQrwo9+J25HZJ1b+Q7i2fSvjQ0yhYt7phESBei7v0aiRCI4LX45t8v3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9FZHFK1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9FZHFK1"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1615369a91.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789368706; x=1789973506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EB7ws+vzvMgHerfQFUtDEGbSPttpE6gsLvIoSmUAzmY=;
        b=f9FZHFK1rhbDmilm6mt0MG+25E56R6jDQGAu1k4Dqih33sPA1z6RwzDrXqh9byVxBZ
         VUsHEacwZZuC5w1O+o8HTX/2YCcmrZdVhBxTJ1Tw8ogo5v5MZebKwEcqzO/mSo4B9WNW
         W+pP20+nxZq2i6ERt3jlFP3BmrzgtRKJlDrpMlLfqIiV8wcfXbRt8sYEGka4OIC3dOai
         gClNgC9OPrHvM6E0UJ1sSYCT/6XF83SK4NScLosfidW39HceU1EjVFJUAcIN/H7hRbpL
         aM8tMZMElDUx9+pMYyLwTXGMaDXnFeT/bWfXcL9TAX98suuLvTNA5c3OXNoQPNUDxnOR
         u4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789368706; x=1789973506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EB7ws+vzvMgHerfQFUtDEGbSPttpE6gsLvIoSmUAzmY=;
        b=W9d9wUewKfXYEOZZVkWyvM4YYyu9REEgln9/U3as9fwYctM2wMvgGGUNi7Yw+LCIhV
         7zWjd8Q6FTkHWpPgJ8lLbTALfyhMF2ocAU2vDgJW1QMMuglLJcEUlYRG+rTEyIi0RCQp
         Chmk7OQfPljL1BgyA6O9xUd/g7SGD6aEAjkruKYGpJiQNYQe82T7c9m9SMwo6zUzDDJC
         xCBEL8BVzzsgTeYDloUo5k9WlccA43U30PtyfhWYDrQ1kWMrUTarjQUcprQtgSDRloql
         n1vbVodChRGGGi43uzwMgIT/jpMl1abCYr+fvYRgyZlZoUXXPB54mqFWLQ//RY/Wdqoa
         Dtrw==
X-Gm-Message-State: AFuF++nKHhx9uY5cXArzHxk34mJPvJn7wtE3Oq5MkQDxIDF04rF7ggmi
	7hRHD6bsD9BVppKGFYb1fmeg2xz8P7pWqhJs9EruHHsgo5NLI3/cN245
X-Gm-Gg: AYBFou1kTBFRoJffl4aSh4/zK+8q2OG0UOrom2c1if8ZyT66HNkJgMf3wMOzfV8R++n
	41eJtCJoHjG7Ai8uMUI0fK8gF1aXdwNVpTw0gNYBzukGsO206LaM84WF7BhCJaa8pSelkbaAJBj
	whRD/h7tkFx5biE+mLmBB7umNA7h/gSeRJ9cDcHTCS6AuxFgUQ/f5+zR+Y6p0ITwqHlwNirW9++
	juhCE9pvLDn+pUw5yLEqjeCfxu/rIemojZBDA1elCP7WiQuTPd4R4E4OoItSUXYuepPJFJ/NcC2
	zEL3FDHbVszONExevcOzxD40vFi01RfWDQ85eZlA2etD7w6S++vs83RTgbOj7ssmO7UCvhpBEc3
	VsxHnugwz6nydlPCcCVJ/XKzCAhT8iBxLDxjBwgsjUWaDTjn6yDufallsanLR+pYsqDGhkpIl+u
	/yC8WlfGfnx5GzGcpW1qEgWLmi8vVmhB08PBYaB865yFPJgs12ss3tWu2VRw048n5zS5smllxwW
	3TbQatzcDpBQjze5CnVMMVJQGPmcDE6
X-Received: by 2002:a17:90b:3850:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-39debf93d7emr2935563a91.7.1789368705991;
        Sun, 13 Sep 2026 23:51:45 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39db996bde4sm13262288a91.7.2026.09.13.23.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:51:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vlad Buslov <vladbu@mellanox.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/sched: reject IDR error pointers when deleting actions
Date: Mon, 14 Sep 2026 14:51:23 +0800
Message-ID: <20260914065123.4109709-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_action_delete() drops the reference held by its lookup before calling
tcf_idr_delete_index() with the saved action index.  An unlocked
classifier can remove that action and reserve the same IDR slot with
ERR_PTR(-EBUSY) in between.

tcf_idr_delete_index() only checks the lookup result for NULL.  It
therefore treats the reservation as a tc_action and dereferences
tcfa_bindcnt.  A hardware execution breakpoint was used to schedule the
interleaving without changing the kernel source.  KASAN reported this
decoded trace:

  BUG: KASAN: null-ptr-deref in tca_action_gd+0x5b9/0x1010
  Read of size 4 at addr 0000000000000010 by task poc/150
  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002
  RIP: tca_action_gd+0x5c0/0x1010:
    arch_atomic_read at arch/x86/include/asm/atomic.h:23
    raw_atomic_read at include/linux/atomic/atomic-arch-fallback.h:457
    atomic_read at include/linux/atomic/atomic-instrumented.h:33
    tcf_idr_delete_index at net/sched/act_api.c:766
    tcf_action_delete at net/sched/act_api.c:1859
    tcf_del_notify at net/sched/act_api.c:2014
    tca_action_gd at net/sched/act_api.c:2064
  R13: 0000000000000010 R15: fffffffffffffff0
  Kernel panic - not syncing: Fatal exception

R15 contains ERR_PTR(-EBUSY), and adding the tcfa_bindcnt offset produces
the address in R13.  With the guard applied, the same reproducer returned
-ENOENT without a KASAN report or panic.  Treat error pointers as absent
and return -ENOENT.

Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sched/act_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 19501dc99..eabe612b7 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -758,7 +758,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 
 	mutex_lock(&idrinfo->lock);
 	p = idr_find(&idrinfo->action_idr, index);
-	if (!p) {
+	if (IS_ERR_OR_NULL(p)) {
 		mutex_unlock(&idrinfo->lock);
 		return -ENOENT;
 	}

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.55.0

