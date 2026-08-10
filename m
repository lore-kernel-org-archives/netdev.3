Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0B3E1CE8
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372880; cv=none; b=UnsxB7LRZBdWLwatdpFzNCTAZMpvDx5GvloOQ2o+vqj/Dw50POVTsCytyIS30CnuWKmqhVbKWkSYXc6Jgo8tmB739SXBSyn7/1eQ9mNsIhqUHKgVBrgv3c7oXCDgyV0gOrVX5gUlKB65Ckbk0U2MLCIuKPjQ4AlRyY4YlWgyEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372880; c=relaxed/simple;
	bh=NT4hmTQV7asOzfynA9Axntikhqqvbc1Sr29Lb2gduPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amhHvcVYiLsB+EAHJ5/nbhxoyPQJuAMiNKb/eYJYmOz+Dgep1rQjraN55MO9pg3q8Sc6MD4Cxl9POEIC/HgEZzbzdQ2q2Zpf2TwoCdfQnGzxnJf1FF+O8ygGlHcBHT5bMlx51Kr/ya/XtikOhtg79n9dZBhetVHhHoZo53j9EU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XxsoWo6I; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="XxsoWo6I"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so11264726d6.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786372877; x=1786977677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zF8J7vucF9ejv5mC84LVI8cP3TWHPkQougefaqK2FnM=;
        b=XxsoWo6IbNXsRnCzr/jOsexPMUwAcGetoB/V+HOE6Dtq0CkPgMKlmQd9TLVBCDWLVV
         ixPKvsKftjC1vaF0Pm8s1HebN3Dl6eDoGJL2qkd8CR1ehQFVrH3GAh0bZfHOUGbkFkie
         2YKPYLOloTD8+BaGR9Vzd0bL9Kug8U23iIm6DmKhxGmq4618QWUCMqSNZG3GJa/WYZsm
         VaTbS0MVaKtIQYastOD/QxvlwXbEuMU8pJz3g0Iy+q8pdNV/ndJn6UFN68QplrEBUeXB
         9QV4b0xVNeKmT6i/s9+oVDtp6jevW3o0dt1kl+w/oyeC4hFEGb9Em0dAbqKHFoKEj8XE
         m75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372877; x=1786977677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF8J7vucF9ejv5mC84LVI8cP3TWHPkQougefaqK2FnM=;
        b=hM7D7U9h7uZ7coVN6VFgMHDbTuZo+MRy2fK0WEAH/+2yCp0UdbVFUKbKbReeie8lgE
         5dnxHOu0QgMBXuVtWj4youNYM8l8sJUK5X++Rap04f9Obp9q2taXVJxffu45k8XoELlt
         l4KJOTCmCF1G/q0yfrH4P/zUPwtELtKggN/tzyQFEzHfIossedhlkuV/NEYrKdlQCwN7
         8PT6da/DpLjiuWoMD8K7K/G5PLLs2axoslqO/UkKlJuYNCRAoPBsht4I/5tuau1haNHj
         zr4AsK9Eqihi7TzI31Z5uW2SPbq2upeLqgHPPP2it+8KdIR5nosIbkmo3Fu2qxBJHaSK
         8EuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYkRs30ajNHm5rXi9Qmdujgyl1wGBxk2ZOQkHJMurUpdsvvdTSOZgS9kK038sQJIcPaVkFcok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8M3OvNjmKw6aymwKSwdO2kTXunhm1uP01qN5kST9atc0Pcl0q
	RZafweS3q1Hsc9xWxLe423e4x/d/RfoaDLNZ8zqwBg6UmYVK6697iJ72vfxpOx4S1jA=
X-Gm-Gg: AR+sD128EUAG/ADAp6ZIrJ/mlJ0CQp/T8zWqbqhr0kvu4C3Rhjm8pT3MrrEOSS5v/vz
	5eWI9YvnahWGxDFS+6GeqNGC4KXBzuyi+w3UQvBVvmPCOguPK9idAKFzzvw/jUJEyoOtjx3rs0V
	n4nY+GjJpKsPmiVZT7W06e6tpcWTaFiHxnmRmgiZ/E31ya89yuYiD3J7r083m2ca2i+mvynfh+S
	VaENegCrVRBZ1d+imk0jcMXeXf8O7lL5gWucZymOPBKXWU24EiIBODeDzZP6SvTrDKNn5uvGNPx
	Gm62Hvcs+3WuYgiG9FxOZfkj6LNNx6aHcrY7z/xRF2hIFdtD6OKLc5SXF+D/gCRJtEWmQLXCxD3
	gOqIddZEDgQqf2jsUiUgruW91ojoZUkbKNzpAgPTpffNmuiExt441lAQjPm2wJmQ+G25+sbyM8Y
	eFwleoy6AFRcYdYQxJOcOtwcXiP4zMPHy4mAz1GIwrrWRvM6kdETIHL1IgqNJnaOwlTg==
X-Received: by 2002:a05:6214:4709:b0:908:949c:43a6 with SMTP id 6a1803df08f44-908949c4882mr384537146d6.6.1786372877154;
        Mon, 10 Aug 2026 07:41:17 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908a932a417sm73682786d6.37.2026.08.10.07.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:41:16 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v3] vxlan: keep the last remote linked during FDB flush
Date: Mon, 10 Aug 2026 14:41:14 +0000
Message-ID: <20260810144115.821654-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

A non-nexthop FDB entry is expected to have at least one remote while it
remains reachable through the FDB hash table. A filtered bulk flush
violates this invariant when every remote matches: It unlinks the last
remote in vxlan_fdb_dst_destroy() and only afterwards tells vxlan_flush()
to destroy the parent FDB entry.

An RCU reader can find the parent during this interval.
first_remote_rcu() then applies list_entry_rcu() to the empty list head,
producing an invalid remote pointer that the receive learning path can
read from and write to.

When a matching remote is the sole remaining remote, leave it linked and
ask the caller to destroy the entire FDB entry. vxlan_fdb_destroy() keeps
the remote attached while sending the deletion notification and removing
the parent from the lookup structures.

Fixes: c499fccb71cb ("vxlan: vxlan_core: Support FDB flushing by destination VNI")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v3:
- Remove remotes_flushed and the redundant final p_destroy_fdb assignment,
  as suggested by Ido Schimmel; the caller initializes the flag to false.

Changes in v2:
- Add the net tree prefix to the subject.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.
- Add the recipients reported by netdev CI.

v1: https://lore.kernel.org/all/20260731141311.570187-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN slab-out-of-bounds read in vxlan_snoop() and can share if needed.

 drivers/net/vxlan/vxlan_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d834a4865..0c42cfd96 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3051,18 +3051,19 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 			      const struct vxlan_fdb_flush_desc *desc,
 			      bool *p_destroy_fdb)
 {
-	bool remotes_flushed = false;
 	struct vxlan_rdst *rd, *tmp;
 
 	list_for_each_entry_safe(rd, tmp, &f->remotes, list) {
 		if (!vxlan_fdb_flush_remote_matches(desc, rd))
 			continue;
 
+		if (list_is_singular(&f->remotes)) {
+			*p_destroy_fdb = true;
+			return;
+		}
+
 		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
-		remotes_flushed = true;
 	}
-
-	*p_destroy_fdb = remotes_flushed && list_empty(&f->remotes);
 }
 
 /* Purge the forwarding table */
-- 
2.53.0
