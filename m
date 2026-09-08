Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAD5328C0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868734; cv=none; b=aSghPdtBuc8nT4kMfYiZ5bVZ2+nqaY1/iVcjICSvlPLVHj9+E9qmSsozIYLtUBvS5X1i9u81eBZxEloionFxp3b4ENiDbImxZ+ZMnybbeEJwdNFBkbn5tI/A2NPqH4CRijD3+JhFCK833p3yKvllvEcoCs59MGirJqq3hhT5PeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868734; c=relaxed/simple;
	bh=2qPyWET3trPzTgVqWB2JmqQ9sSYlsEXWGFMqfTOJbLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT9obh0Qm/SVLvNdIaFVA/HQj+Z+Et+c2nFbWNAs43N5e5f1uwqJpPjEXOxprtQem+vX7YwPKbwYU9sgmFdgdNTbf5N2I+F9nyXdl4i1/4JQP1df/wzTZg2CQWTuDiIivEoOJCeXWXDcTiHSLTTW8Kab4K0d1caU13XmIIKBnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Y12V9EFr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Y12V9EFr"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so3471858b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788868731; x=1789473531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFIwOj0sP1GTzIynCtDi+0y4dNanYu++LBe/7IloGpU=;
        b=Y12V9EFrTt8W2D8L4UAC8FTUsrgEHncE2c+qTojFIiDe6XESmjofpzawzQsdRr50CX
         5/n/NB7Ed633mXoY4XFjd6j2UNBVHK2AK2mtQ4YJ930S7XoXwFqdav3zIVzPD1MbCJXD
         5HWBJ8VX1UU9c2ysshSWVViFctb9bxcTOEZHMJWtdl6sDfJ5osp+zmbTBH31IQ+ADAZa
         Y1JIHG6F6Y4Yx5gMt5wG3vph94k+SMVl6FjI/SYrspkT2lmRvIlDUFfZ08cMCMdGnPwZ
         v6Ict+HCEyLVpqXv+g6OkqZ+vjL0c7Z+PF9bssmAM1HWk9j5NTb3p1xtC+A9Mfn58fC2
         0MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788868731; x=1789473531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFIwOj0sP1GTzIynCtDi+0y4dNanYu++LBe/7IloGpU=;
        b=jzx2Je3la3BVdsp5Ykann7A6+6BqqubH//PcxBQ++kW5zmlxvhv0TxDQhzLI1stYxe
         FvH60EFO4PLfXsycDVTT02YlJ5T2sxutrH60Ejwq4Z1Gz+P5DWpbU3mH14klT0A8hUs3
         ApkBTRQkDBJjqv1XaTJWqUlkMd/0sOf3gIC6EfBZZL2GKk1QVpNlPjgSZj9PEK1d/YmQ
         KjxGraVywWqKrn0GnH4+sv15ctenNCFJGc44KHsnDQGQ9XwAoCkkNbbReTiiaV0P2cGg
         Mb3TdRfzBQBRxPiOdbp8nNuLA5Fikz+99KK3lENxLAww87YzsyMzfVi2muJ/oxLJUei6
         kp/g==
X-Gm-Message-State: AFuF++mvm4F4Lnh+CLFpa5KpAumBXQH1vcNJAZFEa+xKtaNakTPo+LuN
	IcmY7dRJ7MX+nwBHeoeRV9MjkLyu9trODEJf5yJfafQMqOQZHModQhcmliaenAb2CHnISiRGmJm
	Iy8IZePXm
X-Gm-Gg: AYBFou1HbFpU2D50INWYIcrN4kk6YlE2kXnIpQgwyz30kmTKmLbEU09tdUC4GdHwXY0
	bcjGxpJwy7mfRGQ/eld5l9NrRwFLOzM3odGPTBlrCYFoTa9FCJ1qnpIwox564FLYjBboqpp3UpS
	gx381sCjghCNKpo5ROt7PikFO7HIF7E4LOBODEhlBnGfsCAZHggEa+HHO+gztxIprzRD4jlKZjy
	i/n2pAAgpjUNXVoErERfnGLvy8qdlN5bP+NSXr71sg5kcVQOHE8u4dagkhrNSZsCmVKSjJgFH9H
	FOLvniLeTIJndjXyOGHUMOYeWbGuaNoY9FLJCShHQWUGKen3duv7mbsZNJxFOK3x7PwLBTemH4c
	lFLNCekkuF3M3OePSGfEJi0oHv0yzjyMQTX1R8f4z6FzHLirnafK6HBEK+eggZ8/QnDNmtLwmDx
	vH4quK6TCjGsry5lxL2QVG/IA4HWxWT/NTEYxxZJM62OxG7Jt7iuxyQnc33KiGHFIOv3fzTEAp6
	wiaXs7D0kmokt/61W4=
X-Received: by 2002:a05:6a00:3020:b0:85f:d76c:e23e with SMTP id d2e1a72fcca58-86169676529mr38474570b3a.23.1788868731079;
        Tue, 08 Sep 2026 04:58:51 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-863884ff3c9sm3512837b3a.42.2026.09.08.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:58:50 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v4 1/1] ipmr: account multicast table and route memory
Date: Tue,  8 Sep 2026 11:58:39 +0000
Message-ID: <050b58f7fc6b45da0fb12768ebb62d18fa46133d.1788784801.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788784801.git.zihanx@nebusec.ai>
References: <cover.1788784801.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netadmin in a user+net namespace can create many IPv4 and IPv6
multicast routing tables with MRT_TABLE and MRT6_TABLE. Each unseen
id allocates an mr_table via the shared mr_table_alloc(), links it
into the per-net list, and leaves it until netns teardown. Those
objects were not charged to memcg, so the host unreclaimable slab
grows with the table count.

Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
handling of IP addresses, routes and alternate interface names.

Unresolved MFC entries are still allocated from softIRQ with
GFP_ATOMIC and are not charged. They expire after 10 seconds and are
bounded by the socket receive queue; see commit 0079ad8e8dc3
("ipmr: remove hard code cache_resolve_queue_len limit").

Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v4:
  - Reword the opening paragraph for IPv4 and IPv6, since
    mr_table_alloc() is shared by both families, as suggested by
    Ido Schimmel.
  - Note that unresolved MFC entries stay GFP_ATOMIC / unaccounted;
    they expire after 10 seconds and are bounded by the socket
    receive queue (commit 0079ad8e8dc3).
  - Point Fixes: at f0ad0860d01e and d1db275dd3f6, the commits that
    let user space create these tables.
  - Drop the 4e16880cb422 archaeology paragraph from the commit
    message and cover letter.
  - v3 Link:
    https://lore.kernel.org/all/cover.1788765185.git.zihanx@nebusec.ai/
changes in v3:
  - Drop the table lifetime / unpublished-alloc / empty-reclaim
    approach from v2.
  - Charge mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
    IPv4/IPv6 MFC caches SLAB_ACCOUNT, as suggested by Ido Schimmel.
  - Point Fixes: at 4e16880cb422, the first GFP_KERNEL IPv6 heap
    vif6_table. 6bd521433942 only wrapped that already-heap state;
    d1db275dd3f6 only expanded the table count from 1 to N.
  - Cover: unfixed evidence is Slab/SUnreclaim growth with RET:0, not
    a host OOM. The memcg OOM log is from the patched kernel under
    64M memory.max using poc.static.
  - v2 Link:
    https://lore.kernel.org/all/cover.1788622674.git.zihanx@nebusec.ai/
changes in v2:
  - Drop the shared mr_table refcount / list_del_rcu path that broke
    the ipmr forwarding selftest.
  - Limit the v2 approach to net/ipv6/ip6mr.c.
  - v1 Link:
    https://lore.kernel.org/all/cover.1784795838.git.zihanx@nebusec.ai/

 net/ipv4/ipmr.c      | 3 ++-
 net/ipv4/ipmr_base.c | 2 +-
 net/ipv6/ip6mr.c     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d2..b9c544d48c452 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3376,7 +3376,8 @@ int __init ip_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	mrt_cachep = KMEM_CACHE(mfc_cache,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
 	if (err)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 867b24beded11..a0ec6d19a237f 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -52,7 +52,7 @@ mr_table_alloc(struct net *net, u32 id,
 	struct mr_table *mrt;
 	int err;
 
-	mrt = kzalloc_obj(*mrt);
+	mrt = kzalloc_obj(*mrt, GFP_KERNEL_ACCOUNT);
 	if (!mrt)
 		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb5..9d8116b5edb17 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1427,7 +1427,7 @@ int __init ip6_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN);
+	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT);
 	if (!mrt_cachep)
 		return -ENOMEM;
 
base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

