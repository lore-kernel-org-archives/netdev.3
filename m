Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568C3E44E7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887681; cv=none; b=P4bihX949sVSDUR+e/w7NToIEFL/HXBAaNGODW95eVEOgxVz5gW+Duo5JVMPr6temJVNZQgSHyiPGOOHKvVbM2PdzuE89r7HZfiMc4A8HSudfqxPRSAgPASXeeaI3FoMYpBdOG1+WeWK+3+lwUgjzEOR7yZz2mC4BtMZPn1P+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887681; c=relaxed/simple;
	bh=dcjK2bl2066ULKHIbXAzg3w9O+be+QnikT8sJOL1e8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jUKXEuGzjDAmcS4Cxps38LjRNCkMCG61BhORyZXD/XZQ/uI9xUY/syXh7J98NoP24tpZ7pD0rvJU5Sv1AnT1opVPVloGXKz1UjJSD+04HQrfyMBktADwZBpuqc2WGcnEq2DoW7Gz+Tv853pQalwmk5sCguITZoYyA6GDVFbjJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWZLleow; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWZLleow"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-395543dc382so7344891a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887680; x=1791492480; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7GiJgEnXGSeka5EiKcMV0/hHRHF8ZLbheE0i6DvKseA=;
        b=FWZLleowtc94a21L2mKgJSYAXYPcF+o6kU1aYOE3mm5+ODdVioU5zaQh38+wb8ZgV1
         fzlbBcsnuidYcIkXGasFYr3czpKGpqwF040ZSVEyz5nU8WGB+jhDnuGrgyMBjy4cNxgZ
         5+eui86aw9MtpqJYBkbYnbmdeg3FXEYHvmo61BiCphK5d+8bROps4IKbCMDmEgxkxQQM
         VlbEbRg2BsCXMf5xXdQC5skeVM1TgWUaKzxyGlEPEu2Qrj36B3zn/344YpjVlImJykwm
         vTHSlkqWOV/Tm37nwZGaFMaWMwDD0dAfP3yP0zV0s56tbOqwVCFBol9kbmmdgKhcR2IU
         mztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887680; x=1791492480;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7GiJgEnXGSeka5EiKcMV0/hHRHF8ZLbheE0i6DvKseA=;
        b=aJ736neb5N3afR1+cKjbkK/qKDiFnGclA6GVDVfxM9lZ1mbbUR50Yb4YTGwV9JdCpe
         Ko3L4wsXwVgCkNaziaVS1dXRTvUzQSGWlcbZkwcUce2OuO7lGfqn9HYEUCNfCJErPF1l
         WZp9y4uN8kMdJi6pu0bd88MdsRkMK2/BsW3KvI1w9yKmLWT1d0FFQOeSQBSr8W10hZPO
         3zfbxNS3U5H12WXsPPC2GEpjdL9dodOBbCjXvCdYvlrgm6cmQmn/CZkjvZO5rnWdTRzT
         TXBSW+MfnlAHz4zvW/vaAKb2VlsgOZ37IuH78R1R5L7u4vgVVubnMg7T/hWGZw6FS/D/
         9xLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPxXPG6f/a6IUfQuA1nV74Oemctj91nLzyA1tyWeREDDySjuX6V++vOj8CV2eJHcDlEBsgY/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVUoZ0qT27gd0gXqzQorglslxHgeP3DH8P/tnikhA2P9hKzKAV
	H5fIn7NAhQq2dsP9DKnmxvR7piTlfg1nebtQKA53KJfpQp09oDn5Ryhfk+t1p/HzHmyiOWCmtwV
	yo6aAWQ==
X-Received: from pjrx7.prod.google.com ([2002:a17:90a:bc87:b0:3a6:d8f6:71fd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498b:b0:3a4:bbec:b4b4
 with SMTP id 98e67ed59e1d1-3a6ce78f166mr280543a91.26.1790887679421; Thu, 01
 Oct 2026 13:47:59 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:16 +0000
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 4/6] xfrm: Check netif_is_alive() in
 xfrm_bundle_create() and xfrm_create_dummy_bundle().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"

struct dst_entry passed to xfrm_bundle_create() and
xfrm_create_dummy_bundle() could outlive synchronize_net() in
unregister_netdevice_many_notify().

For example, ip_route_output_flow() calls __ip_route_output_key()
to fetch a dst under RCU, but calls xfrm_lookup_route() outside of
that RCU critical section.

Thus, xfrm_fill_dst() could add a new uncached route after the
first NETDEV_UNREGISTER notification and rely on the rebroadcast
in netdev_wait_allrefs_any().

The following patches will move the uncached route flush for dying
netdev from the NETDEV_UNREGISTER handler to netdev_run_todo(),
where the rebroadcast is also skipped due to dev->dismantle,
making such late additions problematic.

Let's check netif_is_alive() after fetching dst_dev_rcu(dst)
under RCU.

This ensures that xfrm either finishes adding the uncached
route before synchronize_net() or fails with -ENODEV.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 513c9f228334..9ea60c7717ff 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2772,7 +2772,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	err = -ENODEV;
 	rcu_read_lock();
 	dev = dst_dev_rcu(dst);
-	if (!dev) {
+	if (!dev || !netif_is_alive(dev)) {
 		rcu_read_unlock();
 		goto free_dst;
 	}
@@ -3066,7 +3066,7 @@ static struct xfrm_dst *xfrm_create_dummy_bundle(struct net *net,
 	err = -ENODEV;
 	rcu_read_lock();
 	dev = dst_dev_rcu(dst);
-	if (!dev) {
+	if (!dev || !netif_is_alive(dev)) {
 		rcu_read_unlock();
 		goto free_dst;
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

