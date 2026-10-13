Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636940D576
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883114; cv=none; b=fZQiANE8IzbsfKsKrHTi/E2Dh9CPW0F0AEXNLicTfe7uLroJOD8SsQm60LHtHkC5oxsLOmtrZwBbZvD9sFapW0L3d5zj7GOKtbdd111Yh0+AZlor1rwCfiHDKcCKfeNNufi7R4K6J6KNTQ6FKbCM4C77pK0YYljDAdQzPYdcl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883114; c=relaxed/simple;
	bh=Qw8zae9NOxAk0It4XupnieJPLdroSQEYcZSuuA8SXV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSpDwB3wEEK3j9b8jUBYf3UVF6Xkcbrt5KPN4kMU5J9LaVfX/DwBv759TtbHAljClnizhPuYHWtO4SZZ9gppkPszB1uwXsxYhuAMfiCuEicIUSKjYTDlc80KxYvW0zinwF3JVfnI+SngNZBhKIGXgj3GgxvJfi4LvT3iTxTPry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRSPCnVn; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRSPCnVn"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3599178221dso52019eec.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791883108; x=1792487908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJeGv4gE+1nP/kqGfhMNUpT5saqR4ArNAelaYTNhWl0=;
        b=hRSPCnVnM+EHmuYlE6ocgu8bFlYbbx0yCbV2F6dkIDyPBWkKHOffX8JJhRlcrv5N8+
         2zga9kSqa1Os9SMjjI/Dp+IA5OU8ID7CsEDA5DIGR1cqp3Ou4cjHYvmb/4KLprqJfk82
         B9RDQdRqMDQgjt/cSOBuD8LRNW4CR142xkWL9vYPOcPkhyX3tD9RwSt0X/ByxWVBH8q2
         Ajc6u9oqWonfo4LMiWOElLSBqwdiZWVKGVGolb029gkYrKiKXEejg8a0VlJYe++z1ndE
         go/l1R8QZjlfOsa6SV9emb7iPHXHaIgLoNeAG2WQOCn89P+jkXmDXXecrNYXIPovevrV
         iBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883108; x=1792487908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJeGv4gE+1nP/kqGfhMNUpT5saqR4ArNAelaYTNhWl0=;
        b=M6ZkhCpF52l8qIVr1ma+jYMEJpROjxlib/i7o+OQQG7xSt91Gi1Wd8PcOqKj0zmgC5
         +wlwNwJO9UBiMay9d+IL4DuUu9iFb0Twfu0h1wHtsdUb51/wrMeLxTF5AQ+3vlRLwudM
         qHdqEs1GvIcrcVbsryfGecZ0lCus4rMfTO7YZqMbRD07H5jFE633oPblBWyGtODi9UcO
         kYVIfwjD2SLG6t0NhFOChvRcodoMdvdDaftxVQAc0PCMLoHBn6kegEFeAOyxNhjIAMkI
         7XeSHbNSjBXZyy4pNUvacQ+jtefwtgNguFAozfezdf6uzuEkW34KzebJUq2G2lV/0nD4
         n8sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfYLGMeOlk1mr0uWNWEKeM2mih21pqR/x/DdUs1XEkA93sPUktFCSg2hX682tNe2HfDQ3+ikE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUigplxhCOaNu3yxfeVO6NpWrwbmClD0RbwQHl5DqG4RJvtOEy
	21hA/us1iCunVK3DMadQh4OHA1SxGh1U+AjARF5/VfocsZauu4Ml+nIQ
X-Gm-Gg: AYBFou0JL9LcMDvyTZwUu1JYN/8NqK6shfrBZW66fIj/LO0kugJNM1WhXh+nftLBo9Q
	yyddZ/NTq1JAGCGE/RL1OphLOkHiB2U8LevF/dIsQLfyLW+Zlho8rWjkjxIM1PxK+hn+BoPPtX2
	Mm0yCS1fVRYNuhf4OLvdkV2PleIMxF6swU16iVjJfSxrQDEU2a/bqnMyFxvqDFWuIUN4b6L6+xt
	mCKyYjyUA+7VRT18QFqI+ZIaa8gBm+86bsF2N/ClrNrt+wdscoF5ih9ArQd87h1Y+dRYFqIJYS5
	sxKhEDHlxOBzXBo4Qu5mYC5bQnqYO/PAEMVdr5bxVyH03ROFC/NPQ76yS07ZwQ+LOW5OZXg8kSb
	iizZDGgdWxJFj/x2py+N3CMgLK5Ox8n1qSPKIiPq5LUHgxnsyQLWo8kD32xFLSAn4m6WYC9alsG
	h6ymcxEkPR/uUg8aRKAK2coTxcxSxjkRWC1Ga3YH+mfLoNZMQMk6LRuy3dizj9JC+NypDOubNr9
	VTxdKPnWkbrWfMlhsC48vf4wVgiiKnzCiUV9MIAl9o5SDXH7hf55bQOklTmlYq0AZ732gvudOs=
X-Received: by 2002:a05:7300:d40a:b0:359:8492:20f8 with SMTP id 5a478bee46e88-35984922315mr16399593eec.2.1791883107751;
        Tue, 13 Oct 2026 02:18:27 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm41437975eec.30.2026.10.13.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:18:26 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/3] net/smc: hold a link group reference for free work
Date: Tue, 13 Oct 2026 17:17:16 +0800
Message-ID: <20261013091716.1210420-4-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013091716.1210420-1-nicoyip.dev@gmail.com>
References: <20261013091716.1210420-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__smc_lgr_terminate() cancels free_work asynchronously. If the callback
has already started, it can still access the group after the terminator
drops the last reference. The callback has to dereference the group to
find its list lock and check freeing, so that check cannot protect its
own access to the allocation. This lifetime gap was identified during
code review of the scheduling and early-cleanup fixes.

Take a group reference before mod_delayed_work(). Keep it when a new
execution is queued, including when a previous callback is still running.
If the work was already pending, release the extra reference because that
pending execution already owns one. Release the queued reference when
cancellation succeeds, or at every callback exit when it executes.

Use the reference-aware cancellation helper for connection reuse,
termination and cancellation of a rearmed instance by the free worker.
The callback's reference keeps the group alive even after smc_lgr_free()
drops the teardown owner's reference.

Keep cancellation asynchronous. Waiting for free_work from connection
setup can deadlock: the free worker drains tx_wq, whose worker needs the
socket lock held by setup.

This builds on "net/smc: serialize link group free work scheduling" and
"net/smc: serialize early link group cleanup with termination". Together
they close admission before cancellation and give resource teardown a
single owner; the work reference then protects callbacks that are already
running when that owner cancels pending work.

Link: https://lore.kernel.org/r/179113886433.434549.10069135669585050618@kernel.org/
Fixes: 13085e1b5cab ("net/smc: fix deadlock triggered by cancel_delayed_work_syn()")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6.1-Sol
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
New in v3:
- Address the independent running-free_work lifetime issue reported against
  both v2 patches by sashiko, with the complete reference protocol in this commit.
- Cover new scheduling, rearming, all three cancellation sites and every
  callback exit while retaining asynchronous cancellation.

Review: https://lore.kernel.org/r/179113886433.434549.10069135669585050618@kernel.org/
Review: https://lore.kernel.org/r/179113886579.434549.12546097168507601074@kernel.org/

 net/smc/smc_core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c1bb284c4233..9b54f873c6a9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -89,14 +89,22 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
 	if (!lgr->freeing) {
-		mod_delayed_work(system_percpu_wq, &lgr->free_work,
-				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
-						SMC_LGR_FREE_DELAY_CLNT :
-						SMC_LGR_FREE_DELAY_SERV);
+		smc_lgr_hold(lgr); /* released by the worker or cancellation */
+		if (mod_delayed_work(system_percpu_wq, &lgr->free_work,
+				     (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
+					     SMC_LGR_FREE_DELAY_CLNT :
+					     SMC_LGR_FREE_DELAY_SERV))
+			smc_lgr_put(lgr); /* pending work already owns a reference */
 	}
 	spin_unlock_bh(lgr_lock);
 }
 
+static void smc_lgr_cancel_free_work(struct smc_link_group *lgr)
+{
+	if (cancel_delayed_work(&lgr->free_work))
+		smc_lgr_put(lgr); /* cancelled work will not release its reference */
+}
+
 /* Register connection's alert token in our lookup structure.
  * To use rbtrees we have to implement our own insert core.
  * Requires @conns_lock
@@ -733,19 +741,19 @@ static void smc_lgr_free_work(struct work_struct *work)
 	spin_lock_bh(lgr_lock);
 	if (lgr->freeing) {
 		spin_unlock_bh(lgr_lock);
-		return;
+		goto out;
 	}
 	read_lock_bh(&lgr->conns_lock);
 	conns = RB_EMPTY_ROOT(&lgr->conns_all);
 	read_unlock_bh(&lgr->conns_lock);
 	if (!conns) { /* number of lgr connections is no longer zero */
 		spin_unlock_bh(lgr_lock);
-		return;
+		goto out;
 	}
 	list_del_init(&lgr->list); /* remove from smc_lgr_list */
 	lgr->freeing = 1; /* this instance does the freeing, no new schedule */
 	spin_unlock_bh(lgr_lock);
-	cancel_delayed_work(&lgr->free_work);
+	smc_lgr_cancel_free_work(lgr);
 
 	if (!lgr->is_smcd && !lgr->terminating)
 		smc_llc_send_link_delete_all(lgr, true,
@@ -755,6 +763,8 @@ static void smc_lgr_free_work(struct work_struct *work)
 	if (!lgr->is_smcd)
 		smcr_lgr_link_deactivate_all(lgr);
 	smc_lgr_free(lgr);
+out:
+	smc_lgr_put(lgr); /* smc_lgr_hold in smc_lgr_schedule_free_work() */
 }
 
 static void smc_lgr_terminate_work(struct work_struct *work)
@@ -1576,8 +1586,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
-	/* cancel pending free_work */
-	cancel_delayed_work(&lgr->free_work);
+	/* A running free_work holds its own link group reference. */
+	smc_lgr_cancel_free_work(lgr);
 	lgr->terminating = 1;
 
 	/* kill remaining link group connections */
@@ -2029,8 +2039,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 			conn->lgr = lgr;
 			rc = smc_lgr_register_conn(conn, false);
 			write_unlock_bh(&lgr->conns_lock);
-			if (!rc && delayed_work_pending(&lgr->free_work))
-				cancel_delayed_work(&lgr->free_work);
+			if (!rc)
+				smc_lgr_cancel_free_work(lgr);
 			break;
 		}
 		write_unlock_bh(&lgr->conns_lock);
-- 
2.43.0

