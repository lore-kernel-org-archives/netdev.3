Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1811521886
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925107; cv=none; b=EMYvp09hp5PCewaDovVylNOB52yXeqx3kQLNEajTiHYTSvpXxmiAIGzgP0cZkmOIPO5TNbq4AW6mvfQ89ZgP+r+EMDkZ1TUN1kOyWV6sujd5iWqKGdVOfto5jKJtTVkeyAIFSgO6KGiOCxbZ2+ZGE3WBYcW+Tn/JGMdby2HlWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925107; c=relaxed/simple;
	bh=mzjkFrHMjPSaH9K4XUyL4+zfDdT2nFqa6L/+SofktWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0BLyalgcgycJCtLlBRPTKiSnyWm9T7vJeBzinainPgch95HxHHaEQ3q7GaINXgZVEi31rQsqhWpNsLXB+Qa6ntG6b7vcABKrb+gtjZcKoAi5NrhcfAeop4ROFe34bXh1h9/4Wf4Oi34AOb3+OnrTiv7vbb3eKwz38PKEuX8iU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6T45uUR; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6T45uUR"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc435388657so3879918a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791925105; x=1792529905; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LAvZtS8Ld4N8dcodE0MzB2CFlloDV8eZtDQEhdaME8=;
        b=R6T45uURWQEnID3InpC39zehEYx3yqGEjFQmxpKTZhQeDpdntxbD0an2oz/JpaxQFV
         FFtBf/FkarKZNgCXxI2vJEH2tunte2LZh949Min3iCkeIX68GzlKS3FJdgzyTaClg+It
         KE1H4/U0XHqlkTpdnJLavi4c/q9u3AOWfKpg9doeFiY4thnw12OxEu1HYdaRD5OSBRs6
         5Mmo2KIHZ0hyyn5Jms9VljUYBw2ESWMyCPs7QvNojcHtJgqlywJH0DUuoXBPxHAC2ebF
         Rgvd+4NYpVptNr8cwd/K8w9QyCQc07FEuuF08O/an69RRfhb85QXI9OlFuoDqw8mLEZo
         S4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925105; x=1792529905;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LAvZtS8Ld4N8dcodE0MzB2CFlloDV8eZtDQEhdaME8=;
        b=Wn7+CtzqfxUGFaeApdinO2lfSQ1mjnhEtYSmAPWGpVTHzFIncb6nhiFDnAhb6ACv5c
         aUwrwEV6cKqyooIb4KLaf+vmrQEt1kDSq/Hn6REaB6qo7nJ62O7EcZfmk0tdazCV+AcW
         mF22cOp2JEtEQnFBa9yjwRelNp7I31s/p/BmWZUpIehuCBjB82oK4liM06Y7jI3/bZ8n
         MDC/70qYnEHO3HCkY/s23z3/rpopzMR8hIfghmJr8VVTOuNd4Yf+WKjenwF0/zHvMo5v
         6A0rko3WbFyOvpak49kkRglQbaV7BQHcXWrcUI6jytBbVPsHnN0Vt3Imt9uL5LqSFCfl
         41CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJYUzdZXtPzlxj4bm8Ata/9vZLvbf2Qmq6rqjfrhtYpqF5TNqXK+cFStLDYof7ArWpr79+jeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIExxw/aR3M/7K8wyPYcJrR9NEepNCdChHiNJPA9jdwHDStuO0e
	oLZemoN2wxSEGHEjeQY24VmudBCTLI1nEKB3gFnkVvP9qD/erCJUkVgxNaElND5334lvqMc/mFn
	g01Fp2w==
X-Received: from pffi17-n2.prod.google.com ([2002:a05:6a00:c291:20b0:88f:2ad7:b21c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:7081:b0:898:b925:f467
 with SMTP id d2e1a72fcca58-898b925f78bmr6927030b3a.6.1791925104929; Tue, 13
 Oct 2026 13:58:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:57:31 +0000
In-Reply-To: <20261013205816.1642597-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013205816.1642597-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013205816.1642597-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/5] neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, neigh_managed_work() was not rescheduled within
1s since commit ed6cd6a17896 ("net, neigh: Set lower cap for
neigh_managed_work rearming").

Later, commit 211da42eaa45 ("net, neigh: introduce
interval_probe_time_ms for periodic probe") added
INTERVAL_PROBE_TIME_MS and changed the limit to 1ms.

The limit actually did not work but was fixed with
netlink_range_validation by commit 6d79b223ec44 ("neighbour:
Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.").

neigh_table is now per-netns, and a user could hog CPU by setting
INTERVAL_PROBE_TIME_MS to a small value.

Let's floor the value at 1 second.

This is a user-visible change, but given we had the 1s floor before
and the default is 5s, it is unlikely that anyone but syzbot is
setting it below 1s and affected by this change.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Update commit message (rephrase 1st and add last sentence)
  * Add and use NTBL_PARM_MS_MIN
---
 Documentation/netlink/specs/rt-neigh.yaml | 2 +-
 Documentation/networking/ip-sysctl.rst    | 2 +-
 net/core/neighbour.c                      | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index c8e55c98d564..7929e667cc7a 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -342,7 +342,7 @@ attribute-sets:
         name: interval-probe-time-ms
         type: u64
         checks:
-          min: 1
+          min: 1000
           max: 86400000
 
 operations:
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 685c84cf543d..b00bd77363d7 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -248,7 +248,7 @@ neigh/default/unres_qlen - INTEGER
 
 neigh/default/interval_probe_time_ms - INTEGER
 	The probe interval for neighbor entries with NTF_MANAGED flag,
-	the min value is 1, and the max value is 86400000 (1 day).
+	the min value is 1000 (1s), and the max value is 86400000 (1 day).
 
 	Default: 5000
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6b0569aa5d64..aa3da886eaab 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2435,10 +2435,11 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 	[NDTA_PARMS]		= { .type = NLA_NESTED },
 };
 
+#define NTBL_PARM_MS_MIN	MSEC_PER_SEC
 #define NTBL_PARM_MS_MAX	(24 * 60 * 60 * MSEC_PER_SEC)
 
 static const struct netlink_range_validation nl_ntbl_parm_ms_range = {
-	.min = 1,
+	.min = NTBL_PARM_MS_MIN,
 	.max = NTBL_PARM_MS_MAX,
 };
 
@@ -3701,7 +3702,7 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
 	struct ctl_table tmp = *ctl;
 	int ret, min, max;
 
-	min = msecs_to_jiffies(1);
+	min = msecs_to_jiffies(NTBL_PARM_MS_MIN);
 	max = msecs_to_jiffies(NTBL_PARM_MS_MAX);
 
 	tmp.extra1 = &min;
-- 
2.56.0.385.gd3acb90ef8-goog

