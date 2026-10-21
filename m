Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609293;
	b=j6AgT6iM5SKOZhljrbj4ku2zhRqOTVHiIA4SQsFaYgJxMgaJeDTyLOkyfxW+8ORslDXF
	 LJDiSL2nBaHFCyfLDpu2VHptpsJ+xntn07BWymT5ONjfof/TrjJjvOTnXiKIhMkwAVXGO
	 4X+WypRZvEniP40VmAlr8coxPvcZhg1iim/8Y7tpaxdKJYtLiMJ44jhqFQW2o6KY2qn0p
	 DUYfWPlRQkB4uAAAzsfqh6ClTWrB6JtH5h75wS6xw5XGnMajgexfF0EcUSNdWHO5pP8eU
	 fY49rAvPCsopqVj8tbm9dqk6Ox7ic3/ipigB899aFIUssDN3BOP9MtL6sSNF7iqgZpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+xiuBG98k11v38WJdNTju3R21l2Zmo4Yv8wf7MwifCI=;
	b=ULlu+kU3ntJjBi+SCHuA9ol2zlmh/lHDFMndAa1hj/MC51B8B1MKPAd6ZYny5jmauvax
	 24I6IzWx/UfgbDiE7RbJ/mNxA0PBW4H6C6xAZhIrECBO78LxYk8hReFS2qg48flJJA8U9
	 ZHE8oqbUk/XN/VKYPv2VHzgrRFbGHO5wQDST1Ep8emjmC6t7L05v8xQhlddLPeyl0nvqa
	 rgZea3BrWHeI5m7VWOvju+FF4edI6SRG9S2UeI0RWfJqtY4a1HpR8E7aTpqJcNJom/KJP
	 50h+QQlmCCPqigOX4+RNyaf8GhTzfdtGXc08/cmVg8zDj8VXQvwCUV1jIIOFjuMMouQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=GR24Dh8e;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D3606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295D3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=GR24Dh8e
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1438d9363fbso203390c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792609292; x=1793214092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xiuBG98k11v38WJdNTju3R21l2Zmo4Yv8wf7MwifCI=;
        b=GR24Dh8excjC9Z79WSjYtICN7aA1M6cWQwDyo4rtr8fvM3cAZyHUGUxo4qhqvkkDi0
         9bxlkWwLKE3z5W31rJGW+LUtDXeHdiYHRQCM7EQhUPn4n/utKT9Wv7EZawdFGonbWGFL
         al8LsEMOhXppDmd4RSkibI+bxfI/JLlXT+K1SQcXPLo5svEHfxv4Jrel3RAuBiYBGIAL
         tnSVoJi46DHNS9ZAOQY1U5KGHt2BjYw1/j6L83Qe+W3sUCu9BY9JrgJhvKiYb8qrOlJs
         QIhUOn38DFziZMEYfn7AmKCsAKkSumgmMi6/Gs7UJBhNpRjzYQ4BjygqsnOUXbXdwYaG
         Y2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609292; x=1793214092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xiuBG98k11v38WJdNTju3R21l2Zmo4Yv8wf7MwifCI=;
        b=PW/vZGCvJcp0EW5S9fOg3IqK5tsXW3fhd6QqyO3C1guPdterwb7zr6xpf9I8uBWtRq
         5iwxP/3vT4GwKqp7jEG60kL4JdKLZ8gbM9E1BYjkBDcanLtWa4+lCWw5DpqRSVk2ZLo4
         y7AqZtpLdd9Z13kXvmOu1Q/NEOrRqiOMdamQb6/EyneliNbGNMUaELWPm4L3X9la1rwP
         vdXWc9w9xmgx288E1JPj3VEDCo5Qp1bbHM95qkWuf3ThM6VwnmWFZmgnoVH5zmiMSpKB
         taL0L79r/zNcbCw9jEngQDzUXxTbEWlLFrhr24P9AKO5T76+HttnewIAPQ+Nipe2a0at
         DtbQ==
X-Forwarded-Encrypted: i=1; AKwUvBya+Eu2Yo1oCIwofho8Z2GDRq2x8+eM/QXxYV/uEsqa3h7RPX9GMHPzV776EfXyCXN7AMXjvYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJaGnkf3uagaCKAScPJAutCM0/d6dVq+QNjB3BqH211ypjw5QW
	5zMe0wOlO6RyD/3JcJwx8l630SaZJz7UwdGKpdWTS+M42/u1h4HBFOcs10ixFLA/ndUt
X-Gm-Gg: AYBFou2g4GWpmnu54MnYOcWVm1Pk4gbmxienmjV+O8VZYTh3XZ6KNt9wa4Y84yGSgne
	66+v38/CPhyCmjiczF/GJfgAF1etGHQc+ofBVR/5nXtJXBx5lENoZ5gsm7eMO5F3bRzmzFFvnvw
	NcRnpXdkgBHefA4qvR0eyH1Ofy5W8ocwcyE4gdOIK96H5ne6pr/fyMUzFEyYYLiV3LRBTY4Ourb
	VAbXJElnJwkNmgAq2leCX0fUIas4ndDEWtKXAtte6S1Mdy3N3nQVmRkHvKsFS1Mh6q+U2W3FAdZ
	gjiPQ2DcrMa8ZuMts3e44dmJoCai76GPIkJMIn9U9ckqkFeopzTu1JdjKOUR+HDiGsbE2Sp1NCm
	on8SgSv/MqPrIeTIrgJiWW20UwJkIEpMXrh1xqDa3er6+oMY49ijBK2vyjUBTYVi4EoRmfasy99
	/2BtbL8QGAdsPotlErDbnax3OQ+bStap4MI/8ba54lGOifcADsPqOLoDNuD6dgZo2viKB8Hwnzy
	M8r91yOnQ7kL4PSA01ioPshKqPIZBt/0UrA+9vJQdrbXTJZ1DRCys3AWNS4EbdIbLSN3WE=
X-Received: by 2002:a05:7022:eb54:20b0:151:7831:e403 with SMTP id a92af1059eb24-192ef933695mr268807c88.13.1792609290274;
        Wed, 21 Oct 2026 12:01:30 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm7581797c88.3.2026.10.21.12.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 12:01:29 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	namangulati@google.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] ipmr: drop packets with unknown ingress VIF
Date: Thu, 22 Oct 2026 03:01:16 +0800
Message-ID: <5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792608753.git.zhilinz@nebusec.ai>
References: <cover.1792608753.git.zhilinz@nebusec.ai>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A packet can race with VIF publication and make ipmr_find_vif() return
-1 even though the VIF device pointer is already visible. The parent VIF
device check can then pass with an invalid ingress VIF. For (*,G)
entries, this can also let the packet be forwarded back out its ingress
VIF.

Drop packets whose ingress VIF lookup fails in both IPv4 and IPv6
forwarding, before checking the MFC parent device. This prevents
forwarding with an unknown ingress VIF and avoids the (*,G) hairpin.

Without the early check, the negative index can reach the IPv4 offload
lookup only for an skb marked for L3 forwarding offload, currently done
by mlxsw. The race is rare; the supplied PoC reports only the UBSAN
negative-index diagnostic.

Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr_forward()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Naman Gulati <namangulati@google.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
  - Drop the ipmr_forward_offloaded() index check; the earlier ingress-VIF
    check in ip_mr_forward() prevents the invalid index from reaching it.
  - Rename the subject to describe dropping packets with an unknown ingress
    VIF in IPv4 and IPv6 forwarding.
  - v2 Link: https://lore.kernel.org/netdev/23ce70e99d6c710bdc4cf065d70350b754ed8f66.1792476942.git.zhilinz@nebusec.ai/

changes in v2:
  - Add ingress-VIF checks in IPv4 and IPv6 forwarding.
  - Add a negative in_vifi check to the offload helper; removed in v3 after
    review because the earlier forwarding check handles this case.
  - Clarify the mlxsw offload-mark condition and UBSAN-only PoC result.
  - Add the IPv6 Fixes tag.
  - v1 Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c  | 3 ++-
 net/ipv6/ip6mr.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c452..de869a6ac011f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2064,7 +2064,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	}
 
 	/* Wrong interface: drop packet and (maybe) send PIM assert. */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		if (rt_is_output_route(skb_rtable(skb))) {
 			/* It is our own packet, looped back.
 			 * Very complicated situation...
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9d8116b5edb17..faaf04f5c4f33 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2218,7 +2218,8 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	/*
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
-- 
2.55.0

