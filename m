Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF84B8DF2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552889; cv=none; b=PYbIbJEJj0talbRJxaR6+A2TAH8Zz98ULpJ/2pWtcc8hbcivHl7TgwKqe45JfU+xcwlYvfitxZWiJFnVRAUrfco3hqdprCPqLslJ60jRe0Gko8gmiW5sv/Xz9MNFmbGfluKl6Pv9jJyBCdZLMdu67icsmQa9srBknsGAg2T8W/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552889; c=relaxed/simple;
	bh=liQCnC+7llIdd0GbDQgAcy+Lo8oCdyPjuVg2jjY+iJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1Dg8V/LeH+UQGLJeRY8BOKBCAxpW6548oxZ5nL0vH7ysA1k6F9fDuklBpLiR0C+6I1FEq/PAjbzGib3u/PQ+isxfYiilEMkUdpDrt1qkQNky37N5rBodaHde+sGvrXWuD8asj46TXAYSwnENgyxSS+tDSfxOEYtd4nCo6JJB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ixdVHWsx; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ixdVHWsx"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530e28a62abso9582231cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789552881; x=1790157681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTcGH5T/cFDHbJXjhA+gaILzByIxBykFt4Pcjft5gX4=;
        b=ixdVHWsxIhCA1PMF0QqGnh+noZzQ3OWF7lW/lnOmtL7OKYGTdWy+AwU16OQYmfBhFZ
         Me5RGubz8tV8YC+opjc6E7IAotPViH6WgjG3EtwAiwTyrnODuqJiUrmI7vv3aEI9+qBl
         AsQm+nk+JNgwKx9g3Fw06MNpb5QLVR6tbFM7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552881; x=1790157681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTcGH5T/cFDHbJXjhA+gaILzByIxBykFt4Pcjft5gX4=;
        b=NGWlBdkJIUGz4DAB7Y/08FyFkf+uWb53OAHccilfCT0Yqof/IaId5hyRuXtvf9QPVV
         X7cVE7VCO40U/Epzj72CP+Wj/F3t7P6F3dWRVOYSHZSqArGeBsbo+skSXFxaCVDXJzfB
         LuaUGgceTL6R3Zv+/tP/8lmVFXKnUBlXcXU8LimSqBaNK4P+2w9L8SIgWgsfBTPG63Za
         3XfC9q9iMnpGB4VED/hzQK7L+UOCJzGqRvkjoK5/CLnPwL7CIbtsjR/k3htH+TGB+WGP
         Y+KrSSG+r5mKlHJ2y7FXNR+Hl7ZaNZy729l25A0ulhThwhiz/Wt9qFpJlMZL0jzG9DJV
         Cv0g==
X-Gm-Message-State: AFuF++k5g/pypd5FOUSA1MF6V4PkjZARlWSqwoSwufXbmo/WWv65d7xT
	nYIuePSub6StktfJ5Mnhoa3TRGA3kMQXV5fMAdCcVLweBejB8mPRFvtbMMNYVe0qgGh0S1L429J
	fUfd38A==
X-Gm-Gg: AYBFou02NSnC7EavwhaXEkyMyFTJ3rJzazFeeHtqDqtz4OZ7F61+hD2ykh0Hjit8UAx
	AaxaPWM8zgKhq/XRvp7aGVNcX3Wf/gygLTi0SelL1yakonR4PhmGVcv3ZIXoSLed+xCON83mUHN
	VPdoHX1BLdKgk3b378QFSnBEqLzVU7Yr4IjwbBGhaG1jbrC3D8HKuWKgAQgEhGqNxloKvXMaRcO
	JgJpeSfZGhxaFJ1M2cAZ0XMM7KlZ99CcgouJCeIK8399BjlEeFOn2B0zzvxq6PFn49xFnHN8Wq1
	A3cEi+yC/hSlwDxJizFJ/H8y1mBvrMQAZs8aZ2Gw+DydjahOXxyrDIo1aqcqkZCY0bSP7S+raxE
	NYSejcHyULpIk5h/hG2Qk2JWhE8vwB+r7zPC/tA4kngsLkg5THEH6SuonB+MCw9M4bUol1U7uau
	exBcDietpH4wbwOJsYxItewcTP7MiKZgHjY9LN1kvw8zcayiJNtoCsfRaIZvghGLvsE8LO6bxce
	1T2MYl+0GIJO3scrHoid1ZzlaTqSMyr9jl4YCa/UUTiB635
X-Received: by 2002:ac8:7f04:0:b0:52d:cf85:aeea with SMTP id d75a77b69052e-5327eeb282emr31030541cf.24.1789552881166;
        Wed, 16 Sep 2026 03:01:21 -0700 (PDT)
Received: from mbili.ht.home ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53262021a9esm18026851cf.14.2026.09.16.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 03:01:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle IDR aliasing
Date: Wed, 16 Sep 2026 06:01:14 -0400
Message-Id: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A u32 hash table created with an explicit handle ('tc filter add ...
handle 801: u32 divisor N') keys its IDR entry on the raw handle, while
the destroy paths free it under handle2id(handle). The two key domains
disagree for handles in the 0x800..0xFFF htid range:
handle2id() folds them back into the auto-allocated id space (1..0x7FF).

A manual table therefore leaves its raw-keyed IDR entry unreachable on
delete (a permanent leak), and its delete can drop the idr entry of an
unrelated live auto table. A later auto allocation can then hand out a
handle that aliases the live manual table; u32_lookup_ht() first-match
routes lookups and TCA_U32_LINK for that htid to the wrong table.

Key the divisor-path alloc on handle2id(handle) so allocation and
removal share one key domain. A manual handle that maps onto an id
already in use is rejected with -ENOSPC, and auto allocation skips ids
held by live manual tables.

Conditions to recreate:
  ip link add test0 type dummy
  tc qdisc add dev test0 clsact
  tc filter add dev test0 ingress protocol ip pref 1 \
          handle 801: u32 divisor 16
  tc filter add dev test0 ingress protocol ip pref 2 u32 divisor 16
  tc -d filter show dev test0 ingress | grep 'fh 801:'
  # unpatched: two live tables with handle 0x80100000 (the pref 2 root
  # hnode is auto-allocated id 1); patched: the auto hnode takes id 2.

Also tested with a poc with a live u32 table on the block, add/delete a manual
table 'handle 901: u32 divisor 1' twice; unpatched, the re-add fails with
-ENOSPC because the raw key leaked on the first delete.

Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.")
Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@mojatatu.com
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_u32.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index a3e65c8cf29e..76ce2d124079 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1003,8 +1003,16 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 				return -ENOMEM;
 			}
 		} else {
-			err = idr_alloc_u32(&tp_c->handle_idr, ht, &handle,
-					    handle, GFP_KERNEL);
+			/* The IDR is keyed on the mapped id, and that is
+			 * what the destroy paths remove. Ask for it here,
+			 * so a manual handle colliding with the
+			 * auto-allocated id space is rejected (-ENOSPC)
+			 * instead of aliasing a future auto id.
+			 */
+			u32 id = handle2id(handle);
+
+			err = idr_alloc_u32(&tp_c->handle_idr, ht, &id, id,
+					    GFP_KERNEL);
 			if (err) {
 				kfree(ht);
 				return err;
--
2.43.0
