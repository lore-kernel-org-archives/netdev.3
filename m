Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDC3EC804
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338618; cv=none; b=Krp7ZaEBy6S9bE1/dX2X+U6hPt0/5jkpU7lu5xXCDwdO9o9kL5gUaz7vGyFVfxT2gK1sNFbshu7uBWNa3cOgJ9gukrPKPp7ypxGTnbHkUjRAYg+xefGCGJkoI/lPIbS/aS38DBnTYUSyQxnkn5QD1LlTnHW9d7/P1IR2xVlp2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338618; c=relaxed/simple;
	bh=7gH+SD8eLuCh344QK/gV4nKDBevSAhteXMbkV3w/8Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/x0Ti+p6wXqbQBcpsXr4+4WIUjHqz4yqZa94Fxsy0cuu8O/HWVuN/3cvuU8btrx0Kh7otyoKG8/JP9Kmb6TX+zgCdwGAKwpUPbpYM5mjzB+GLfMS2If1BSQm1EO10lTd61EYMmxalaSMLdRmuqVcTxhXoXrfWJkKULC7grAXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA+iZwUd; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA+iZwUd"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so3307995ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788338615; x=1788943415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHd6n2JrNGVkpcXl+ihkA+tOmim5HyAzQwTnMpLSpuA=;
        b=hA+iZwUdz1KC3O26wBF8R5Vt8imodPssKKl41h9UiApcUCjFKYmEiwJi0zPWqjdrSS
         ObYpLAImajdYbpqNqHPkVPZsXovqgFm97bjvOlLjXxep0JSBo/Y2Q9+Xfn7NMxxRZs11
         DXekszlaAeKxr+Tz03ZYd4gk3Uh8wUSez3BE2gfFJrXK6nqa6SIIFxLTzuu+I7Y9bQoy
         Z0ZVVXw4HGfT08Lmmvw5dc6rDi91xM7ByuL4xoxwzLF3Y7mLmFl45aGi59m4ETqxoXjH
         AnzQ6jBFTKymREWcYSdunBLxQHPJSN+57U6WL4g0ZrDIcHz2Op4p61dwsT3VxeZNcrwU
         w+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338615; x=1788943415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHd6n2JrNGVkpcXl+ihkA+tOmim5HyAzQwTnMpLSpuA=;
        b=afEUCK+Drbh4ZHbdonzID54ou+apYAQqBR27lyj7rJSkPBhWZ7H2jV/psCVENWEh7W
         /h2l1HfeqNpBmcCflY74JhKCKqwcGntUXQjKJKqa+jK4K5VsV4Qj237cgV1QNi43KIJz
         Eiv5QtNdWhhXy7XE4ovCgAXa9pP+7qBx20vSA7k4UVJUPpSLH9ISiGFoy6cx4bttRNIq
         UB6FIw7YlRFy5PRLGmkYIGz1WucRAT4pOXQu0VLxSTuWQwxp3xFCDexSlYqwAuWjMmXe
         Vr91kQsc0OymctPZMh8tYb/9FIR2lmy6CO6ErpzF7YMCt7fJ1KjmYSPehRmgGW6SQsfL
         NQBw==
X-Gm-Message-State: AFuF++kypqYi2yl36NEE8uab3Ll/Sk0ZbZ6KwuzFsyb8+FKuVoTDyalN
	YfrW0bLpDJ52PNH1wtRBegnR5cK7+nm/SH2bMbStprpYaIMexabnIwvY92QdR6IbYlQ=
X-Gm-Gg: AR+sD11mW4mv2dwjwiQQcaptmjQVoKo9w4puNxKsd0ERVQSK7LoPz9/MsjP66iDnOln
	bsfMfy72im/CTd1qUyfj8fZiymkAxbc7Fi1eEeQpl/zc0ichNwvSSiG3KqjNKwabVv/sC8+RR5g
	3BbYs+Qu1FO2MTMhMMQCQjrXN0Zg9TS45oG63RfeMmTknNSOTWnoMoQ3N+K+ByF9fHHx2spvaVj
	9jielxNw+FZ8ooU1KM2U4E9wlizT5EshgXOLz38cBS6vhzuBPME274QjHLgKoWjvCs+Ly92MdoK
	XvJu6Go0v7tZDwQFqSuvUG5/KCSzKkJzgpR/fQ9yx+O7mDoY6DbldZ5Kk7I0vOxPZkGiH1ATGvn
	C8Rrm77usqrHZsID9f60URbz6RiKTVV/5L6Ay+pGN6V6T8Y+CUVC4Oyb3GMeWH8YrzI1QDVHGrA
	yMOMXDVD0iOsXCBr4IyVmqGA/1xjPZMYlI8MgE1O5YzcdZJSkW/8ycVEig/w==
X-Received: by 2002:a17:903:1acc:b0:2d8:d4d0:7931 with SMTP id d9443c01a7336-2daec76359dmr54463095ad.21.1788338615386;
        Wed, 02 Sep 2026 01:43:35 -0700 (PDT)
Received: from fedora ([59.172.176.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd35dadbsm9622825ad.13.2026.09.02.01.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:43:35 -0700 (PDT)
From: XingWang Xiang <v3rdant.xiang@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] genetlink: pin family module during policy dump
Date: Wed,  2 Sep 2026 17:43:17 +0900
Message-ID: <20260902084317.4092542-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic netlink controller's policy dump keeps pointers to the target
family's operation and policy tables in its callback state.  A dump may be
split across multiple skbs and remain pending after the initial request.

Netlink pins the module which owns the dump callback, but in this case
that is the controller's owner rather than the target family's owner.  The
target family can consequently be unregistered and its module unloaded
while a policy dump is pending.  Advancing the dump then dereferences
policy memory from the unloaded module.

Take a reference to the target family's module when the dump starts.
Drop it from the error and done paths.  This matches the lifetime for which
the dump context retains the family and policy pointers.

Fixes: d07dcf9aadd6 ("netlink: add infrastructure to expose policies to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: XingWang Xiang <v3rdant.xiang@gmail.com>
---
 net/netlink/genetlink.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 0da39eaed..41d37442f 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1513,6 +1513,7 @@ struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
 	struct genl_op_iter *op_iter;
+	struct module *owner;
 	u32 op;
 	u16 fam_id;
 	u8 dump_map:1,
@@ -1555,6 +1556,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		struct genl_split_ops doit, dump;
@@ -1565,7 +1569,7 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		err = genl_get_cmd_both(ctx->op, rt, &doit, &dump);
 		if (err) {
 			NL_SET_BAD_ATTR(cb->extack, tb[CTRL_ATTR_OP]);
-			return err;
+			goto err_put_owner;
 		}
 
 		if (doit.policy) {
@@ -1583,16 +1587,20 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 				goto err_free_state;
 		}
 
-		if (!ctx->state)
-			return -ENODATA;
+		if (!ctx->state) {
+			err = -ENODATA;
+			goto err_put_owner;
+		}
 
 		ctx->dump_map = 1;
 		return 0;
 	}
 
 	ctx->op_iter = kmalloc_obj(*ctx->op_iter);
-	if (!ctx->op_iter)
-		return -ENOMEM;
+	if (!ctx->op_iter) {
+		err = -ENOMEM;
+		goto err_put_owner;
+	}
 
 	genl_op_iter_init(rt, ctx->op_iter);
 	ctx->dump_map = genl_op_iter_next(ctx->op_iter);
@@ -1624,6 +1632,8 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 	netlink_policy_dump_free(ctx->state);
 err_free_op_iter:
 	kfree(ctx->op_iter);
+err_put_owner:
+	module_put(ctx->owner);
 	return err;
 }
 
@@ -1760,6 +1770,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 
 	kfree(ctx->op_iter);
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
-- 
2.52.0
