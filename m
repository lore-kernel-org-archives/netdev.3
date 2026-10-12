Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429F4E0B79
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834338; cv=none; b=Ghs3O9iekEXdjmwoRm/AcXVfCsSJpPHuGw39ZJQNnOi9IDWv+gIVBJhsfUjYFPN08XYl+Nev4sfvfpb/59tWMZrgawcGZ0HH/Nt6dw2PaoiMIGLgcynZmUfr18ZnhYO8kS4UvWcCynExYvuF8h/PRU++Q24WHM44oCuq2FSr/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834338; c=relaxed/simple;
	bh=71tmpa68dTFHAVNFNDnyzoUf4EhjKgVSEgFuyCt9g+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ww6w58TCUwWWo7CKL6tMC+0QWp9ZMYzkj4BX4J8ODn/xl8DJSFlWXosR6m5ApspkSFaHH924AIa78EFSE+ViKASox7kwN5syggG/IAeA0dWCai5s63RuHeV7Mal+r0ts6D9EylqKtJODpXQggWcc0CIGtk2fKRb+/x12lUBdvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQR2r3S7; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQR2r3S7"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so3257330b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834336; x=1792439136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbwQY3NB0m3vbNq+eovLYVWAg6KTk8pao3+SlnS+7QE=;
        b=dQR2r3S7GfraiFjs+kQk0S8jqXoMzTNtw1lrHOPLUu11QjgfV2dMK3yyskBGr0g7JM
         8peWMfCPgyYMgHby/7tLda+rz+bTJgxfXx21SazfZtJG+f9rDERBY9ImS5nTY0Eo908z
         PGibJSHr4DOiuEnJzzN/zXTQMPxx4m8VAcdj+jPS5vI6SoGUcBqNVQIsOU/YXArdztrd
         VgHO2EarS4/HmHkWtSaFy39kEngMg7luyNJGqZMK4vk1EuS213IP6AQChMYnwyCR0G0I
         n43EkDmqUCZaGHQECBngsGIVtSenbwFIae/GEHDjhX2YzVXUMk3lnvGpFqvQYg+35yMR
         7gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834336; x=1792439136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbwQY3NB0m3vbNq+eovLYVWAg6KTk8pao3+SlnS+7QE=;
        b=kXr3rvNDbt6XxNiIH32Y4oa5XOGg9d5uvplSD6z1RrUMjgCFdQgMcx65jnpD0yXly4
         Tf/v+eWfL0svu/20kxaFPkGqGSqJ6+TCMipu23Umt85PA90asRX3l+npOqUQnQlE0VNC
         3vsUBPB/7pgYa72e7XTMwIt87A180o0QpuaxIDvFIoqncfMgrf+mBJivAD5zMN7AT0bq
         cOPGrcYR7Tvnlx9aJTScc26SP41ngW0nixBMyPlgq4ljcx83DRqLx7piTv4ESrlBdbHz
         BhR66tD463HlAmVOngxNXBRwvakgKsrgIiGXWAy4Pcf7b4MHZIXwfJMgkLVkrUeNAiID
         8mgQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4cuP6EcrUnRhU5rC+hXONOBbgr4m8leDaBZXZgyCgDDpOKvF6NGgqd5McZuaPttpRoF32K1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDbTzlGjAHqYXl9tB1gnmXS+EW9zFy0clOYKMb8q/qJagAyYeJ
	B4k18mpVsL6OGpHLe8wysmCuu/qdnJBPEDP9jfxstv8miyLaEBM7qZlqHbm+1B9vshvd/iCZlT8
	qoxSDiA==
X-Received: from pfwz35.prod.google.com ([2002:a05:6a00:1da3:b0:887:f7db:4abb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:301e:b0:893:8a6:37e8
 with SMTP id d2e1a72fcca58-897c49b24b4mr9266835b3a.2.1791834336111; Mon, 12
 Oct 2026 12:45:36 -0700 (PDT)
Date: Mon, 12 Oct 2026 19:44:59 +0000
In-Reply-To: <20261012194530.3751034-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012194530.3751034-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012194530.3751034-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/4] neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, the lower bound of INTERVAL_PROBE_TIME_MS was capped
at 1s by commit ed6cd6a17896 ("net, neigh: Set lower cap for
neigh_managed_work rearming").

Later, commit 211da42eaa45 ("net, neigh: introduce
interval_probe_time_ms for periodic probe") changed the limit
to 1ms.

The limit actually did not work but was fixed with
netlink_range_validation by commit 6d79b223ec44 ("neighbour:
Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.").

neigh_table is now per-netns, and a user could hog CPU by setting
INTERVAL_PROBE_TIME_MS to a small value.

Let's floor the value at 1 second.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/netlink/specs/rt-neigh.yaml | 2 +-
 Documentation/networking/ip-sysctl.rst    | 2 +-
 net/core/neighbour.c                      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index 6b0569aa5d64..92e3c83c0fe5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2438,7 +2438,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 #define NTBL_PARM_MS_MAX	(24 * 60 * 60 * MSEC_PER_SEC)
 
 static const struct netlink_range_validation nl_ntbl_parm_ms_range = {
-	.min = 1,
+	.min = 1000,
 	.max = NTBL_PARM_MS_MAX,
 };
 
@@ -3701,7 +3701,7 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
 	struct ctl_table tmp = *ctl;
 	int ret, min, max;
 
-	min = msecs_to_jiffies(1);
+	min = HZ;
 	max = msecs_to_jiffies(NTBL_PARM_MS_MAX);
 
 	tmp.extra1 = &min;
-- 
2.56.0.385.gd3acb90ef8-goog

