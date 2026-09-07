Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2043F0B5
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818339; cv=none; b=I6SlSHZ0GmW8NXTw9uAw38xhrcJwSpwmlzjLC+VobuhS+27kx/iUQT8UWGkWuj8NW6LvJc0a+OLQztRAIMabiw1dYXUyhUU5W5O593GwUv97B7poNYIOVe6K1kaiWVLBa1ttNJO8wOSzCyYps6M8bT94zYNhm8P3A5VOxdW5jN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818339; c=relaxed/simple;
	bh=TsO42b6FeBvw1nXkwd9cNgEINCqZo/DypTdoGaHnHeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fiST175uBXHMwSNseRZXvWcO1ZqZJkTd1XPz6ESEcaaGv+dL+hVx2gc7Xc7Zqvom2XVrYwu6M70chE8LuW2PijCva6I/AFFzqx3tZSrYWmW/8M/wOCKe0jzA0QsUQ0KczdOdqqIsvh5ss5oLtdMyhH2WBzG6idTLqQflzcv+pZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdM41H2p; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdM41H2p"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so4696384a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788818338; x=1789423138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWDCgKmH81AOB9wvN2cAYrwpMj3g0Dtsh9K21Z2qo/g=;
        b=AdM41H2pQJ6k3fBF+6eqQr/zFS4JRxvv4QsPYEpAo724YBOAatN6kIUxJV6kazig7u
         i5p4KBHCtUAPSnK+mNRoeGkz15nCAO4Eo0l5ELIqp2UcRC/KVrCJiu1tDA/tjZrjsLZu
         mVF6fRyS6EvJmvGeq7YJL/WDv0s1ppfsAxzLa+xM5dTrEg7raNdx+WRR0WBtzpABLMTM
         WaWIuJn9LrRI37K4GCLW6ZwVsYCngdrLNJgZDghrVuEjikQxTCcGFHt11TAOA++7DuKx
         y7i1x8IirQEUQnieb71EhXsxUsI59isftKSMbcbHLu8uh+HZ/4uXBVTjD5u5/MVY3aA+
         SUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818338; x=1789423138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWDCgKmH81AOB9wvN2cAYrwpMj3g0Dtsh9K21Z2qo/g=;
        b=bypVLUbJgaIsW+Xo3VUsitBV1GDRADKUYx/M3VdyTyyo3vxg2F55Yf03tUYFVKQ2xL
         m7prEHjo1/vJ6k0XRhLcqaMIUH9wiorJaARphfzVQGDttlM0CCIYRZnt4GqV/7/PSsgW
         vI/dEC+i3MzpmFk17n/s4poKSjHuOfZieJRKDXfKPCD9raFTpLJAhiXMuznKZpF7gQhL
         M21MYZaIsN1rcb2DDPgdOL6zTpZOYcH8T4Tb/FuDnno86s7q+pHBN3Lt8+8+hxmgOO0C
         hRvTdGYWhez0mAcrq2koXD4r20knm6BmV9ivyEdAZ7fu986jbmVNxuoW/n4KEy10Z6TH
         HSmw==
X-Forwarded-Encrypted: i=1; AKwUvBzDWynFhJnxABjBw65l88Ra2Iz1aorTsjlgKyGdzdD508PmQPj6FJ6mshuH/IiT+wTKxWjrwO0=@vger.kernel.org
X-Gm-Message-State: AFuF++nZxICGKRlegtcrCN+huQ1qQtr/Me9H+Iwin4772HqvIQviiKrc
	MidPWXYhXgMoh7JkZjAQ4A2jJQxrR0LfdxNg0MpMvXPnYQzfhqHr8Gi5bWcLxH/ldW6qjYwK3TZ
	aUhwnBA==
X-Received: from pgbdm2.prod.google.com ([2002:a05:6a02:d82:b0:cc1:c1e3:7ff7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4310:b0:3d3:adbf:777c
 with SMTP id adf61e73a8af0-3da3a0b7121mr37094566637.24.1788818337390; Mon, 07
 Sep 2026 14:58:57 -0700 (PDT)
Date: Mon,  7 Sep 2026 21:57:53 +0000
In-Reply-To: <20260907215853.3709987-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907215853.3709987-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907215853.3709987-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
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

Fixes: 211da42eaa45 ("net, neigh: introduce interval_probe_time_ms for periodic probe")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Currently, the sysctl range check is not applied to
interval_probe_time_ms, which needs this fix:
https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/

Cc: Yuwei Wang <wangyuweihx@gmail.com>
---
 net/core/neighbour.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 4b17c2a15594..454a8b8f3aa0 100644
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
@@ -3670,12 +3678,13 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
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

