Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D629489FD9
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996708; cv=none; b=Mhp3P7P80D7usyjvNg3/TOfVjCfCVuzabTx4BFY68TvDsFuAE6by36NgMqS0YPNpq6xA/D2kCrFVqL5x7sz5/UP8/RAcxLhEPLFxorItj5vi5MEfHn/acMRM7PMX4BY1WloTbJO/cnymWL4YtsFFOJ1c+/AFc3KGDJ/p2pGsgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996708; c=relaxed/simple;
	bh=Uiqw9yZRLMD6H21/5Al6tFCLGlApalkennA2TVEfjVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XBXe5BYFzENuZz3fzAHvVOx6//lIGuPYFAlAxa4Zpojb8xEq8zbHC3UZIb4i/g3f1cwsnov7woCXTNlw461xInb52utNpA5y7jFQUVnymhbV0jvkYCscg0ax/0dCpHP7J7yjAyG1AEGp8fwHJEKQ2kcFc9hSZ34UsJzbxG0eNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1tglrqO; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1tglrqO"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc44d708055so10703547a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788996706; x=1789601506; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jg/9qMJRQ4p0MLypIiRdNyyGg9yilAU0et1ULaHjUPE=;
        b=G1tglrqOMXMqqaz6ZzkhIaJg88rwzpEZSMwmc4P30ui1ws+pDnEgU58E+8kzLmWqEt
         YKxmYaQMTndek4syuY1JeZXRMy/LwwIaq++c2xkaCRppAeM/gsQTKJhz8br6wsBn38uL
         O+hNMvNMLBq02yZNBhc1pDBodic1IW2H7SM8Gvc0r1chMbUCjeF7r3jCAaIrVpE99J4Z
         T3b0uKKq9Z/345AzTCF4cfjKQ5dpXY+T5hK0c8R6w0eldO78UH93SIMGTWRaXVj1kEYM
         EqqvOStAtkKKNg9BjyTM4mw+d6kv9S4R9Ks00bseIaClENiD0tNUkf1r1gyTRVj7yFTm
         Lmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788996706; x=1789601506;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jg/9qMJRQ4p0MLypIiRdNyyGg9yilAU0et1ULaHjUPE=;
        b=lJ/jEkUPdhL2Fa6DVOD8XAzDjvmU68WerPmBBanhJlstC/o+A5e2C+VsMVBkrm6OcK
         gu789mmdKmHkgQoOQw9fh/p52icoGZagu4lNsjQ9GQs+yeUGIZ/6lWBr7PiwcZfl8MmB
         LmJj+/L9psDzG5pWTQkCTqiimRCGNEa+ppq61KPodDpkJ8OUpyM8BmcaoO2SkdtCaxAG
         l9J9RUb55u0vQv7/Z2oC2ulRrEkmZMDbqJli0naG5kkQc9q+WnwhW105ChlfBHKi2Sfw
         chS/k0mn0SYe4jtKN2mFmmP/+WclM+ADOtAZOWOwlNNH5m5CBLrHAgiJM4EwTAD/V2bz
         t2tw==
X-Forwarded-Encrypted: i=1; AKwUvBxNAtMTOF9JBlnEYsdm3L3+T+/bV+i7SL1TQOIPHarUfiuNMa3qhc4kXal634+hSYkDUlHeVSE=@vger.kernel.org
X-Gm-Message-State: AFuF++k1cUsKYSx1dc1EuUxidFi+4UZ8Tz9U9U37OlC2Ok051JJBicak
	X3M1PxOqDSeEUteH0mDl6DTkgX/0Pm3b4ysTevkn3OfLLjTypRlbtAHOPGbVMP1GAWuWbVM/vtn
	b2vaGcQ==
X-Received: from pjbem13.prod.google.com ([2002:a17:90b:14d:b0:380:6618:e058])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e703:b0:398:d843:cad9
 with SMTP id 98e67ed59e1d1-39b26226de8mr58409113a91.19.1788996706371; Wed, 09
 Sep 2026 16:31:46 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:31:24 +0000
In-Reply-To: <20260909233143.2401847-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909233143.2401847-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909233143.2401847-3-kuniyu@google.com>
Subject: [PATCH v3 net 2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yuwei Wang <wangyuweihx@gmail.com>
Content-Type: text/plain; charset="UTF-8"

NDTPA_INTERVAL_PROBE_TIME_MS sets .type and .min but misses
.validation_type, so no validation is applied:

  # ynl --family rt-neigh --do setneightbl \
  --json '{"name": "arp_cache", "parms": {"interval-probe-time-ms": 0}}'

  # ynl --family rt-neigh --dump getneightbl --output-json | \
  jq '.[] | select(.name == "arp_cache" and has("config"))
          | .parms["interval-probe-time-ms"]'
  0

Moreover, nla_get_msecs() uses msecs_to_jiffies(), and u64 is
silently cast to u32, so a larger value can bypass the min check:

  e.g. 4294967296 == 0x100000000

  # ynl --family rt-neigh --do setneightbl \
  --json '{"name": "arp_cache", "parms": {"interval-probe-time-ms": 4294967296}}'

  # ynl --family rt-neigh --dump getneightbl --output-json | \
  jq '.[] | select(.name == "arp_cache" and has("config"))
          | .parms["interval-probe-time-ms"]'
  0

msecs_to_jiffies() returns MAX_JIFFY_OFFSET if the value is
larger than INT_MAX.  Also, INT_MAX ms overflows int NEIGH_VAR()
when HZ > 1000 (Alpha, MIPS), and passing a negative integer to
queue_delayed_work(unsigned long delay) causes sign extension,
which wraps around the expiry time to the past, resulting in it
being handled as 0 delay in the timer wheel.

Let's use NLA_POLICY_FULL_RANGE() and limit the max to 1 day.

The same max check is applied to sysctl as well.

Note that this controls the probe interval for NTF_MANAGED
entries, so the max of 1 day is unlikely to break any
deployments.

Fixes: 211da42eaa45 ("net, neigh: introduce interval_probe_time_ms for periodic probe")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Currently, the sysctl range check is not applied to
interval_probe_time_ms, which needs this fix:
https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/

Cc: Yuwei Wang <wangyuweihx@gmail.com>

v3:
  * Nest min/max inside checks: in rt-neigh.yaml
v2:
  * Clarify the attribute is for NTF_MANAGED
  * Update docs, rt-neigh.yaml and ip-sysctl.rst
---
 Documentation/netlink/specs/rt-neigh.yaml |  3 +++
 Documentation/networking/ip-sysctl.rst    |  2 +-
 net/core/neighbour.c                      | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 0f46ef313590..c8e55c98d564 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -341,6 +341,9 @@ attribute-sets:
       -
         name: interval-probe-time-ms
         type: u64
+        checks:
+          min: 1
+          max: 86400000
 
 operations:
   enum-model: directional
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 208f46967ee5..b05829e44d8f 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -248,7 +248,7 @@ neigh/default/unres_qlen - INTEGER
 
 neigh/default/interval_probe_time_ms - INTEGER
 	The probe interval for neighbor entries with NTF_MANAGED flag,
-	the min value is 1.
+	the min value is 1, and the max value is 86400000 (1 day).
 
 	Default: 5000
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 49dd7df149ef..0db78a0dfb51 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2359,6 +2359,13 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 	[NDTA_PARMS]		= { .type = NLA_NESTED },
 };
 
+#define NTBL_PARM_MS_MAX	(24 * 60 * 60 * MSEC_PER_SEC)
+
+static const struct netlink_range_validation nl_ntbl_parm_ms_range = {
+	.min = 1,
+	.max = NTBL_PARM_MS_MAX,
+};
+
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
@@ -2375,7 +2382,8 @@ static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_ANYCAST_DELAY]		= { .type = NLA_U64 },
 	[NDTPA_PROXY_DELAY]		= { .type = NLA_U64 },
 	[NDTPA_LOCKTIME]		= { .type = NLA_U64 },
-	[NDTPA_INTERVAL_PROBE_TIME_MS]	= { .type = NLA_U64, .min = 1 },
+	[NDTPA_INTERVAL_PROBE_TIME_MS]	= NLA_POLICY_FULL_RANGE(NLA_U64,
+								&nl_ntbl_parm_ms_range),
 };
 
 static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -3672,12 +3680,13 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
 						   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp = *ctl;
-	int ret;
+	int ret, min, max;
 
-	int min = msecs_to_jiffies(1);
+	min = msecs_to_jiffies(1);
+	max = msecs_to_jiffies(NTBL_PARM_MS_MAX);
 
 	tmp.extra1 = &min;
-	tmp.extra2 = NULL;
+	tmp.extra2 = &max;
 
 	ret = proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, lenp, ppos);
 	neigh_proc_update(ctl, write);
-- 
2.55.0.1003.g10538fe699-goog

