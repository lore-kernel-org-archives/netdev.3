Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2793F58DC
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563618; cv=none; b=hJ9F7K2wQfBdnz1iWnWmmm4QFsKXPCJxDcEOCvICF/gT2c08w3tEvA4ZVxQL6qwJ2NwaRPc8Neemq8f2ryXJ8sghnxNcPvyWIpCM7P/bma9B0J8+4z5Lb1xG7xnXpB9lFe4MLcqij192vQ7S3qjZqXx8TP88TVkePXwcLOQCZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563618; c=relaxed/simple;
	bh=uBKOtoSytIa87hb6P4JZ8OQ+rSgfkcaH5ESrlGek8bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6Bh/LliIsxBp8JRQJs5pPrwni5Pu4Ha/n+vclWwLNFI+7GkYzjEY0O1pg+d25dAdE+xKplzbJeuH+wYAU3zQjOu4nr0B+Q2/V2bmEknmUaaoppb9jMg+nRcvE8nkxqDyPwTLPWOM2TTGDTz86E3M9NM+zHg9Em01/SOZtUERng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5ROvZjv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5ROvZjv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacb8416a1so68728935ad.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563617; x=1785168417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1b/iXtthE0NdNXxVcrsPqsvYfRN7KhJFOgx8+/tTAY=;
        b=N5ROvZjvLUG+mxv4q9w/WkYq5UYoiKm6vAD3xeToGIyIAinjJHV+B2shXH/E5hNB7b
         aKTSdbd8b7AiJQD6yTnAsyUY3LXoiNSvYMw1Gqe9wTrn6sPbjVixth1OXYToAQqiUXmG
         rCjQ7+TxuekQf+og+JGB60xYqPATzwev8efupdwxv1oC2RKeg/NdtpiXOkhoHdeeSV9s
         TyNf/X/JthoZgjjQ5w9ZnmNlCfkEyx+PzIPN/ikDUnZ6rncXvPZ8wkPUBaycyroi2ZXl
         M6VMlrymOMbKGhG8lmbHl5bTnOOfqg71VrRNWAiOPlIih1WyiCSHY6LD4knppw+lEbgK
         odtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563617; x=1785168417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1b/iXtthE0NdNXxVcrsPqsvYfRN7KhJFOgx8+/tTAY=;
        b=cNxMR48ZInNWJKBhKzn6dbOraTB3EUKd/sv++ESmY11b7RaHr6ihpHGPMTdZZIuBic
         ubqjKFMpdv7fjuQKIYbs/yGZ+VCGz1x5NbkUHXJrQfYyi7eN2uMFyiec9Eik1f9UvQYQ
         O7S9m4Uxmdpo7sveSAFn8hxSynYQ+/yquZB+q+9rGSDk8mSk9+9Vx7Zx6zrlvs2WLetH
         uGg9tatvm8FOzBf3qu5d+5ypvezRmBAVidUyDdP5mHQo9KMtWk5YPNVfpgCkLc0mb1xW
         njKRmVw1t5HwjvEY9VCAYV91GjXzzYId89r1/yrnV2B9MCMO6STMfIrdL+RoNAQSJahd
         oLKg==
X-Forwarded-Encrypted: i=1; AHgh+RphoPF4U8IUqjfJiUFcyqHfbYx/RtTRMIlcKOv9+tuYC34DgCFJuyiQUEvHCLxdpQVMzEtknT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0rFDrZhUM70pUeElFeFWBbo0TdzmgCHCu9xElrxYi0MF6gik
	D0Blgig3ljQ4rvFXtAmrsYC20aQs38yao2GA6qPdHkwMgf4OdZw44zpl
X-Gm-Gg: AR+sD10IycdZxu4Ta9Rnl4JaYKDerZnZA3bNP3wusl1qy1sXDkPG6VJ4djkqtgDCNkN
	3DOPRn0iuGdYg3A6NppIyIMLVMCbSn4qHRWvcI7SjfyFayS7ESozINifOJt03CgM5EJECzODUQx
	gXwIRXEaceV367Bzaua7dPhL1wNT6w3ufa0KIZtgxoVEmEv+tTx60W5a9MsJtLx/2l9pTwv11IB
	7N5lILqb9uPe/XB0Y8AykHJYF99HVOK16lGY145o2d3Ujo8+R5+V0Hv3ZYIlDG0WXONTNSnrzRl
	XFaW3Fdcs6cw8HSI5oFJAJ1qwQDKX2zlPOv1tjle4KwcTtARVOE0IHBkqlOzKr5FljrADnvvqpL
	8hl0D+teyr3rKZBwsusZ1rinBH+vrh8LMfu+nzowgqASKao4XGzHxkNpxbh5uvuIwHkUivjyEpB
	eRo9rNCIQ9m3lQ3V44Qn9MMOMTjle3kHg5yYqdww==
X-Received: by 2002:a17:902:ebcb:b0:2c9:b48c:fdde with SMTP id d9443c01a7336-2cf3496cb62mr160713345ad.26.1784563616336;
        Mon, 20 Jul 2026 09:06:56 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b16d4sm59389985ad.20.2026.07.20.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:06:55 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>,
	stable@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vxlan: mdb: Fix source list corruption on a failed replace
Date: Tue, 21 Jul 2026 00:04:24 +0800
Message-ID: <20260720160428.249356-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When replacing the source list of an MDB remote entry, all existing
sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
is then called to add the new source list. Sources present in the new
list have their deletion mark cleared, and any sources left marked
afterwards are removed.

If vxlan_mdb_remote_srcs_add() fails partway through, its error path
deletes all entries on the remote's source list. That rollback is only
correct for its other caller, vxlan_mdb_remote_add(), where the remote
was just allocated and the list contains solely entries added during
the call. On the replace path the list also holds pre-existing sources,
so a failed replace tears them down together with their (S, G)
forwarding entries instead of leaving the entry unchanged.

This is reachable from an existing (*, G) remote. An EXCLUDE filter
that loses sources starts forwarding traffic that should be blocked,
while an INCLUDE filter that loses sources drops traffic that should be
forwarded.

Mark entries created during the current pass with a new
VXLAN_SGRP_F_NEW flag. On failure, delete only those entries and clear
the deletion mark on the pre-existing ones, so a failed replace leaves
the source list untouched. Retain the flag until the whole operation
succeeds and then clear it. Also stop vxlan_mdb_remote_src_add() from
deleting a pre-existing entry it only looked up when adding that
entry's forwarding entry fails.

Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
Cc: stable@vger.kernel.org
Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 055a4969f593..af7a0d7f95a5 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -42,6 +42,7 @@ struct vxlan_mdb_remote {
 };
 
 #define VXLAN_SGRP_F_DELETE	BIT(0)
+#define VXLAN_SGRP_F_NEW	BIT(1)
 
 struct vxlan_mdb_src_entry {
 	struct hlist_node node;
@@ -844,6 +845,7 @@ vxlan_mdb_remote_src_add(const struct vxlan_mdb_config *cfg,
 		ent = vxlan_mdb_remote_src_entry_add(remote, &src->addr);
 		if (!ent)
 			return -ENOMEM;
+		ent->flags |= VXLAN_SGRP_F_NEW;
 	} else if (!(cfg->nlflags & NLM_F_REPLACE)) {
 		NL_SET_ERR_MSG_MOD(extack, "Source entry already exists");
 		return -EEXIST;
@@ -853,15 +855,16 @@ vxlan_mdb_remote_src_add(const struct vxlan_mdb_config *cfg,
 	if (err)
 		goto err_src_del;
 
-	/* Clear flags in case source entry was marked for deletion as part of
-	 * replace flow.
+	/* Clear the deletion mark so the entry survives the replace sweep.
+	 * The new mark is retained until the whole operation succeeds.
 	 */
-	ent->flags = 0;
+	ent->flags &= ~VXLAN_SGRP_F_DELETE;
 
 	return 0;
 
 err_src_del:
-	vxlan_mdb_remote_src_entry_del(ent);
+	if (ent->flags & VXLAN_SGRP_F_NEW)
+		vxlan_mdb_remote_src_entry_del(ent);
 	return err;
 }
 
@@ -889,11 +892,19 @@ static int vxlan_mdb_remote_srcs_add(const struct vxlan_mdb_config *cfg,
 			goto err_src_del;
 	}
 
+	hlist_for_each_entry(ent, &remote->src_list, node)
+		ent->flags &= ~VXLAN_SGRP_F_NEW;
+
 	return 0;
 
 err_src_del:
-	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node)
-		vxlan_mdb_remote_src_del(cfg->vxlan, &cfg->group, remote, ent);
+	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node) {
+		if (ent->flags & VXLAN_SGRP_F_NEW)
+			vxlan_mdb_remote_src_del(cfg->vxlan, &cfg->group, remote,
+						 ent);
+		else
+			ent->flags &= ~VXLAN_SGRP_F_DELETE;
+	}
 	return err;
 }
 
@@ -1069,7 +1080,7 @@ vxlan_mdb_remote_srcs_replace(const struct vxlan_mdb_config *cfg,
 
 	err = vxlan_mdb_remote_srcs_add(cfg, remote, extack);
 	if (err)
-		goto err_clear_delete;
+		return err;
 
 	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node) {
 		if (ent->flags & VXLAN_SGRP_F_DELETE)
@@ -1078,11 +1089,6 @@ vxlan_mdb_remote_srcs_replace(const struct vxlan_mdb_config *cfg,
 	}
 
 	return 0;
-
-err_clear_delete:
-	hlist_for_each_entry(ent, &remote->src_list, node)
-		ent->flags &= ~VXLAN_SGRP_F_DELETE;
-	return err;
 }
 
 static int vxlan_mdb_remote_replace(const struct vxlan_mdb_config *cfg,
-- 
2.43.0

