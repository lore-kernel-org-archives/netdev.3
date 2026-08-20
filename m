Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995E39E6F8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219569; cv=none; b=qf57YG1VrIjmFSJBw98z1/GDrMjEGTs4hOkNAc9woM5xdbqgecYlGDnBfVrt8CdAd4vLRuwLpkcG3LHZW6rQukGpfqB34gu2/QUMCMGdO1y8n7m67l4LnYc2EI7ARMmIuyssmbOnvAFOw0IZC52w14JkZnj4YxmQph3rXhdhO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219569; c=relaxed/simple;
	bh=68V8U4WQDih+Kj/9G/1ue48Pi5NWSScT3hTceWvBxJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HW04m2nMsU9TtTzVdK/f944i+ZU1CWuWYcpdjZ8lgIX3rZ4QORlvVCvJbWi/em6lIvoyjp3giX0CJFL+3Xvqhw1GNJq8OvLh5w/4dnnFp7cpSqqJxgW2WkHKxYW7GflubRmCEJpnW02e8QvU3HAsssMj3gk5vXPwA70AWokj4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gwss7Tn4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gwss7Tn4"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b1bf68b387so1174085b6e.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219564; x=1787824364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NkqPyRMbCqdK29EZqFCfmFaTaPXyrsBFpJa6vBIgB00=;
        b=gwss7Tn4wmtKijb8ZCyihLtnSMX6bBuuvrbE1MLtdSKNicMIu589B8oCGkBx0oj13P
         Lz15bVtiEN4wLuYvNX/+inTxB+9GXx7c/SHMdJ2i/zXfcMLo7sZ4SU/KTIejHdMiTaes
         1Krq6rEF+DjDYs00wUNAdVf9I5pStG72jgP5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219564; x=1787824364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkqPyRMbCqdK29EZqFCfmFaTaPXyrsBFpJa6vBIgB00=;
        b=NFldLJg+oNqbAlT97HVJtzGT5OMJ1yXldvgkDVbRyPo+N+W8qQHPwQ0stbhnwFU77p
         ebHfvcYKDB3P3PM85vJjb+UWurjA1Ygbr9bd1LbQMcjx1+EfbqEKsspobw7n5QdyL71U
         D8V3HWUsNLobew7NVOGCMJxyr5N51v6JZCGtrAEsCAgGckWl7mV2DFI+ueh+izbhlQ1h
         qhzOePgj2RVXKUraSaZAI8mEGrS2EDUQ0tvWoD7FbWdHrubrrEnHSZWg9sTI/GqscUc8
         qW3AqV8lmwk2AdLlS1oSAxuvQKsph4hgpx+MmndBwJrWZANnKj6s2kqR13LsgRa2M8jD
         JZKA==
X-Gm-Message-State: AOJu0Yy1KJadQi6ZJVYaWrcURZB9e8NMoU689UdBi8m/MVN24hE6s7jL
	57s5t5higO/6zuLkT+kpxz4jkZXvYCSFgfcPg/XwVdC/07iwnm0tzQqkQU0KFxlVRyr+cMhO1vl
	tJH5jzg==
X-Gm-Gg: AR+sD12fPE6QbdepZtjUJufIM+dEPwD4AoutrRGyap26S3CEF4wyMF4lO1/qdLEeusg
	lgvOAqY6YHDva6LNDeRwOyjsbUL20lVzSfmIAipeg6FACSnoKQ9lFSSpbbUwzTWC8svW+xKuI1/
	6Uogzgu8Nk2tFEaAneYpc6Z41GzZXB4qNM+pGLxHk7kGzQbqm1D0YCnkWccfJ5QWVjbXXwK91hC
	gqmdoKGrs7tWM2pDGe1Lu2LRIPTzrHVPtVxIkgHiuXYbKafhznasLQ3eBtSCdHTX2nBDCbftxeF
	su9KP7roz0ltAS1XSnQDmklouTDWut8RemOclYei/MJDE29jXOvRzeHIq1aCINgSxY4ou/O5pqT
	5IoNHjAkwm9dSSx+aOr3H3gfyQjsydTRMq0izCErd1KtEQ0nhdeYSMynohybJB2Wl3D95n559Db
	nsCYwzdDg4VG4IAnh0JKXa9i07CpSZxXOocyY9NWAq3ol6GChce9A1Zv14yEwS3In8csuD3zP53
	PQiNiDB82SAeTE/JObwDTcqtso1wX0r1o3cpo5aA/zXMimxGh4oPNxTjK8lVQ==
X-Received: by 2002:a05:6808:5290:b0:495:ce61:4e0c with SMTP id 5614622812f47-4b2bc8b86f0mr9389578b6e.3.1787219564293;
        Thu, 20 Aug 2026 02:52:44 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm1286981b6e.13.2026.08.20.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:52:43 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: cls_u32: fix duplicate handle when node id pool exhausted
Date: Thu, 20 Aug 2026 05:52:35 -0400
Message-Id: <20260820095236.68390-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gen_new_kid() tries two idr_alloc_u32() allocations for auto-generated
knode handles. If both fail (all node IDs in 0x001..0xFFF are already
reserved), it silently returns max (htid | 0xFFF) instead of an error.
u32_change() trusts that value and inserts a new knode with an
already-live handle, breaking handle uniqueness and allowing the table
to grow past the intended 4095-knode cap.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_NET_CLS_U32=y, CONFIG_NET_CLS_ACT=y.
- Create a clsact/ingress qdisc on a device (e.g. lo).
- Add 4095 u32 filters with auto-generated handles to fill the
  entire node ID space (0x001..0xFFF) for the root hash table:
    yes 'filter add dev lo ingress protocol ip u32 match u8 0 0' \
      | head -n 4095 | tc -batch -
- Add a 4096th filter with an auto-generated handle. On the unfixed
  kernel this succeeds (silently reuses handle 800::fff, creating a
  duplicate). On the fixed kernel it fails with ENOSPC.
- Reachable from an unprivileged user in a fresh user+net namespace
  (unshare -Urn) with namespace-local CAP_NET_ADMIN.

Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_u32.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index c297d7dbcf91..13ffad47cad4 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -695,16 +695,19 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 	return ret;
 }
 
-static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid)
+static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid, int *err)
 {
 	u32 index = htid | 0x800;
 	u32 max = htid | 0xFFF;
 
+	*err = 0;
+
 	if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max, GFP_KERNEL)) {
 		index = htid + 1;
-		if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
-				 GFP_KERNEL))
-			index = max;
+		*err = idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
+				     GFP_KERNEL);
+		if (*err)
+			return 0;
 	}
 
 	return index;
@@ -1079,7 +1082,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		 * handle which is used to uniquely identify the match entry.
 		 */
 		if (!TC_U32_NODE(handle)) {
-			handle = gen_new_kid(ht, htid);
+			handle = gen_new_kid(ht, htid, &err);
+			if (err)
+				return err;
 		} else {
 			handle = htid | TC_U32_NODE(handle);
 			err = idr_alloc_u32(&ht->handle_idr, NULL, &handle,
@@ -1091,7 +1096,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		/* The user did not give us a handle; lets just generate one
 		 * from the table's pool of nodeids.
 		 */
-		handle = gen_new_kid(ht, htid);
+		handle = gen_new_kid(ht, htid, &err);
+		if (err)
+			return err;
 	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
-- 
2.43.0

