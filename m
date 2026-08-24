Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FC3FBEA5
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585965; cv=none; b=lMnlhgnzg0oc7vap1LnD2iL6axz1AL9O+wWE3T7qQWCUj8sDNd3VgKYxD75Y+qQeDZMpC8mlytrwyLe01at8uONDuzS31Vdl83UOVf4WaYfbtcVIUb1wiBsp1xQdjJ/X47ACqy9EnRP2Ybq+HKthwhQxr+8/A9IYVPMLMEUojWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585965; c=relaxed/simple;
	bh=/wLTxIeZPwObOK4PEyjjT/zg6PoyEzGDiJ5fmp7Nlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5hvW4oGEJBDd2f4yE8B0FC9r3SgOZ6HzpqBTXdNicPrvP8hFD5PePkc0XFslOB4p6eFs8Pon9RGIjS5B2rNA7in6HRv6sbRMWzElJLGd4AbT6HAFFNR2MVt2LgNfU2IBLbul67cmVQQdcl2DtMNAeJoOrjTQuQKThvELVuKQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XQRq6aSC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="XQRq6aSC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce7d2adef4so47466015ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787585963; x=1788190763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CG3B5H6buzpDQgeTL1LRjdkf9pCRkJEx411Xyr3cNAY=;
        b=XQRq6aSCWKY2DK/WJa+jwPXZSA46oVVpMlDFHSiyATRLfBMX8zngjNq6Rpkqn814sT
         YFhB99csgipx1FhAkmlV77RAQ4uymL2FGhIac44JZO2mT6RLLsMhX4EkCRHxHAj7++oa
         +bus3jU+4IvmnP57K4/Jx+gVjubq994dKx+d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585963; x=1788190763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CG3B5H6buzpDQgeTL1LRjdkf9pCRkJEx411Xyr3cNAY=;
        b=WkECmb2E4ldEi56BBrAVR/zWtCXq2mxBW8wUxmrX1yhyxMukQxrEjyoc13I/J/oPc6
         dWjE/wc39eDivIiPQSFIiYU4jLe8x9XktFebmaNGFK8ARemp24ypS6Fm8nVt1yZ9fBmK
         k23phM979KlQH7Orqgsqd2/alD4BCD+4Zqi9B0tlUTdga5heSPZIx/TMQnwEdh06vShV
         mY/I3nqDdvvsUyMkj68lKUo9+/ZuwOqoVcdsRiv7D0RQySlEyZYzemsbTBlWo2q0YARp
         CTpLA4CJLqUa5BLqWoNknDoi9WrPXMox2lUob3P3AC88NdcV9fRbRKj1ovXcelaEpme/
         glVw==
X-Forwarded-Encrypted: i=1; AHgh+RoAiPAOeYHuF5OZIXcWASWYM6HodwPLCh/1NjgOZzuvAfy28KMsLEL1yzlsAls4rKe6r578o64=@vger.kernel.org
X-Gm-Message-State: AFuF++ns+IO4tPlWabQtkmY0gSur9F/HY7OwaWzEQL1MfvgwUEY58upG
	ZT640EyuKGAiO6k6kzLWJvTyfUnFswG3GbEOSMxoKWwBcI4UChOm5W12Carsc70f0w==
X-Gm-Gg: AR+sD11ragtpgut+oCIYxfuxmxZq/C+7m5Z7to3ySf117Ei6SviPhhBkUc1NDgH9shf
	B1iGrOL0F2vBA8z0TT+GgfXaHPcET5vimEKcvCc3ySrTDcVRxhX51cRbv9EPEQ6JaMNyYFFC3mN
	9Tig5n9jKDYYVxVf1ZTwut0ZjyXRxF6EG7yVI6oGTY35GFA2GOYyiglzqai4k4QLpBscTja4ucT
	mzC1cnRUgJGzZi+iZNkXIEDDnbzEuOkWsZDERFqdxqDvTOTpuygmjg+vM8I/I7ES9xZIYsPLc/A
	666WXIWjzPRaQGqp6fnc6yAXkE7UOIc9Bfw1UpDP+AadJk+cl4b2R0PS9q05mtY9onJL0Ao4XQP
	x93pHEg+piTo/gxUOepDzWnzf/fm7qpGd2XlM6dwG+ihH5umUEdHt0ksk3zGNhz9RXG54R1ro2x
	AyGJY3hneXh1B1FpVvXaBe+AukNlTz0ESddepYvMcWGZI=
X-Received: by 2002:a17:903:19c3:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d6dcb8d63fmr331525ad.8.1787585963549;
        Mon, 24 Aug 2026 08:39:23 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767b0aeesm18704585ad.36.2026.08.24.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:39:23 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	baowen.zheng@corigine.com,
	louis.peens@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org
Subject: [PATCH net 4/4] net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
Date: Mon, 24 Aug 2026 12:39:03 -0300
Message-ID: <20260824153903.4143642-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824153903.4143642-1-victor@mojatatu.com>
References: <20260824153903.4143642-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_mirred_get_fill_size() only budgets TCA_MIRRED_PARMS, but
tcf_mirred_dump() also emits TCA_MIRRED_BLOCKID whenever the action was
created with a block instead of a device. So tcf_mirred_get_fill_size is
missing 8 bytes in its accounting.

Fix this issue by accounting for TCA_MIRRED_BLOCKID unconditionally:
it costs 8 bytes for device-mirred actions and avoids having to read
tcfm_blockid outside tcf_lock, where a concurrent replace could change
it between sizing and dumping.

Note: Dumping mirred with blocks currently works in most use cases, but
would break in some corner cases, for example, if there are 20 blockcast
mirred actions in one request, each with a non-ANY hw_stats and a
non-zero user flag, with a listener on RTNLGRP_TC (or NLM_F_ECHO):

budget 180 B/action -> attr_size = 20*180 + 24 = 3624
                    -> alloc_skb(3776) = 3776, tailroom exactly 3776
emitted 196 B/action -> 20*196 + 24 = 3944 > 3776
                     -> tca_get_fill() fails

Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 553342c55cf7..1c98e4d81ebe 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -607,7 +607,8 @@ tcf_mirred_get_dev(const struct tc_action *a,
 
 static size_t tcf_mirred_get_fill_size(const struct tc_action *act)
 {
-	return nla_total_size(sizeof(struct tc_mirred));
+	return nla_total_size(sizeof(struct tc_mirred)) /* TCA_MIRRED_PARMS */
+		+ nla_total_size(sizeof(u32)); /* TCA_MIRRED_BLOCKID */
 }
 
 static void tcf_offload_mirred_get_dev(struct flow_action_entry *entry,
-- 
2.55.0

