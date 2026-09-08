Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465673D954E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902065; cv=none; b=F/Lhi0IAryNq41+I5gN9z6ynEbyOHPbp/6z0r8FUK8esFuywWvTpDq0wWb3y0EPiOe/tv4sCIRTF0XOQkjiGlLGmxcpzV/pgf8n6/Kyumj6q4MYUIk5WjGdU++HL+4KMv5iBQrmYkynlZa8B9+edrTeJB/FNug+oPeOyMEI+kx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902065; c=relaxed/simple;
	bh=G0+NgtQU/CJ7H3hxZj+VkX4dCf1sn6ogQd97DbdmCY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hkv9A+OGIz3mV24dRHJvlgsa9D1Q9Y6aovrvIQ1X5Ain6y1qvXpzNkczP5e99f48EwzWar422vX4x2wJTaY5RWCmBXzF2mzzkYHHlFxIcRwC1izTs+jgo5Sf+V8+gU18P6TXDMsRMHhr1C2LISDbQW7sXSGSXhRLLapRMCIDe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GA8yTOpz; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GA8yTOpz"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so6244009a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788902064; x=1789506864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sUOSZczDY9Xc5l6d/FcCKkpTpL8hZTISac6ljFmXFg=;
        b=GA8yTOpz2uE8dr+vzq/lCFsOzteq/4i532ue35sqmmsYVGiXmdaE9OeTaiMvlW1Kd0
         K3kmrh4msUC3XIqY+ZJ7DSlViuZJj1xZU731781nNZExSDIUqAfboVzKjy6kJrW+/yld
         f65N0W4A7nY5urDER1tzGV49AogP7axgBSQAEok6OA3/4rJI8HuYLowXCTUfdxxiJ/j0
         skbeovIFX0yABHZp/KHWkE2dCbFvPkFHCqOETrY04IFQLdlwQg/bs3pQBsdPeZjggSvU
         IioTmos3/QZDQo7h/bsaBp9tyvSRhQJg5zChCFGuQAtvbmiIXAi28iK3jwhYsZe5Ykvv
         8H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902064; x=1789506864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sUOSZczDY9Xc5l6d/FcCKkpTpL8hZTISac6ljFmXFg=;
        b=Kd5nUA+BBDXcIid2RV4fqsMeqxw+06cesS9T4hd7kBUp3I4rFSNujmzC3gdBk/7+Ne
         AcxWEZ7B0b3NQxwZvzIAkPKgvj9apHzFkcKuM0ngQ+aGYLndHZihtdNfBZLmQouTZv0r
         6ryxcp2w6/jIyrNMVnNZZX/1Go3DAnZzkwHiOgMODytkQSrcM3ntgYz8/d2DK8WvyWCG
         F5OBC4EieOhnkkwkJQDS+ZsUr9Ac8zC82XMBUv7NKed+CrdX07aGHqoYcCGm4kCJJzc0
         0oamcXtG0JL3vNFO6iz5VPa3a8n0WcQxwwdflD1K4W2njb7azASXCY5GR+rKjHTuPmza
         wiCQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0d6Bw18O3K9mWoDl8AAnBFnsLIdHo5nXxyelyf/JM+qh8PmUvHgp4BxvPtXgEqwP+JAD1gsY=@vger.kernel.org
X-Gm-Message-State: AFuF++nIbxlyRKHprGs73SENz30b2lKXQxksxX2DbrYuiOPF8PGA8Ah8
	pfBp4sf+P2vQP3quB6ROBDxE958TJZ9aTyITrzBCD8K8xxpevLhHL+HXbI5I0yXatUiLKM3JLhJ
	Ub3YK8Q==
X-Received: from pjbrm1.prod.google.com ([2002:a17:90b:3ec1:b0:398:b3a8:ed43])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ccf:b0:398:a2a3:b631
 with SMTP id 98e67ed59e1d1-39b262aaf3dmr49402292a91.19.1788902063336; Tue, 08
 Sep 2026 14:14:23 -0700 (PDT)
Date: Tue,  8 Sep 2026 21:12:46 +0000
In-Reply-To: <20260908211419.882954-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908211419.882954-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908211419.882954-3-kuniyu@google.com>
Subject: [PATCH v2 net 2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
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
entries, and therefore the max of 1 day is unlikely to break
any deployments.

Fixes: 211da42eaa45 ("net, neigh: introduce interval_probe_time_ms for periodic probe")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Currently, the sysctl range check is not applied to
interval_probe_time_ms, which needs this fix:
https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/

Cc: Yuwei Wang <wangyuweihx@gmail.com>

v2:
  * Clarify the attribute is for NTF_MANAGED
  * Update docs, rt-neigh.yaml and ip-sysctl.rst
---
 Documentation/netlink/specs/rt-neigh.yaml |  2 ++
 Documentation/networking/ip-sysctl.rst    |  2 +-
 net/core/neighbour.c                      | 17 +++++++++++++----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 0f46ef313590..5ec57d95d7f6 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -341,6 +341,8 @@ attribute-sets:
       -
         name: interval-probe-time-ms
         type: u64
+        min: 1
+        max: 86400000
 
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
2.55.0.979.g7e5102b832-goog

