Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08183351C2F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717677; cv=none; b=HDMjQqQ0cjVrtT707vGHtduwY5jbZc3bhHtyLphoSDOAnDmB+qbpdrg6O62JLf5xB6JUXnqCXR7PWhDXeIiH4LCUxM2DywkCUcTIhDFwjKUjj3fUXl1TFCzdpHy0rEfwvhcp4Y8tNWEvuF0H98VDb0BsmhgtpatzxcXrA80NRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717677; c=relaxed/simple;
	bh=qUHUgUmzKYiPNQC4u71VWQui0hQ+9BnACCwQBlBPBD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P1JSEYqlDQpQzCgsF4ntoS6oj7PmfInbN76zRV9ORCuDuHcDVFlqoSu0KBCgJPJCCgsoPerGIRC0l4lj24IejvuN3P7As4X23nVBjnpXtBSOc3SVptT/HWToBXXhA7qqlgOJKHYRwgc7M+wjHte0/o8sAF0wuaTVPK+k7MR1GTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7dCnnYq; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7dCnnYq"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91054f537f9so7440546d6.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788717675; x=1789322475; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdTFPMIQh1s8vKRjDxXEW+8nN5Ay/xA59pNH7vYGVhs=;
        b=E7dCnnYq3rgjkDKvscTBUCrCqeCPa0+SSTYV+CdI9FkuDWjxsT5AlsWj1ZUPmSuF9X
         /bzJOHMe8V0RFFY89I+TXM/V8GgyZPGNZwF9J3dHCZjDAsuahPWFlakR7S4dUsSTOoLl
         eyA0/RuY6UEEZbmep1hgGyISvrI8t5ApLDSiIqW+PtfqDzWMOAxrkKvw9tEvGTSzoNFM
         zqdc91YFebLp6QcXXCU0Wn0dIDKp38xpQhF+sWXe3T+rAf5OrqQn9w3u+bm+xVxGUpj+
         U4kICnXBTwyeq2esb7PGyK7ilBB6X6C95fCk+eHtVTz5R3nZzhikU7zRd8iChRvU89lv
         5Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717675; x=1789322475;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdTFPMIQh1s8vKRjDxXEW+8nN5Ay/xA59pNH7vYGVhs=;
        b=D/N7xYz6E8dyQLAqaEc11eaBjzskssIOKY3QkQ5zU2645IF42/jfkPlFeqdgqrpDho
         Ks3s7vD9jzBF2DiuPS0Qn1kSgXxAw35dZypayW7wfOWcuvku5MfyVYAMvuudByIEZ8AZ
         cnikOTy8849R5dRV3sHB6nzRPX3nsgJ3lRstVKHIUIaHGr17gCpAfwhla60B0hpbTxsW
         51ITaGEEG/b6nuluBsL5EXIlCVotrLPgpiFFm+MAoIo0MeTCsd+KR0a2NmGu7s9MmN30
         3FMCta9/EzfE0mQaDtcbsdCHk9pNV42AKoQNdwXO/kofFcOwOWbaK/Pa90HNXPTCxTNJ
         DNLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZOGw6Mx3qcPEo0WabFOV7MOQwfu5iBCLGXkwG9Kf9MZpMRVKv5p/WiWIiF4d9ydAFZhVkabM=@vger.kernel.org
X-Gm-Message-State: AFuF++l56McMtGBMLi2seqR91B3eKbjz/Z8kAtv0cn1VFQAlDZncMLol
	8U7HjWl1LNEvUOWc77ymcclNd7XilBJeovFrVEFETj10Frpl4EQfC0PwYrUqoijMEOg+PILFi15
	GJ4SUeUTjkeFLHg==
X-Received: from qvjg16.prod.google.com ([2002:a0c:d7d0:0:b0:90c:c519:3d40])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2e81:b0:90c:cd95:1940 with SMTP id 6a1803df08f44-910344511a7mr161923226d6.0.1788717674598;
 Sun, 06 Sep 2026 11:01:14 -0700 (PDT)
Date: Sun,  6 Sep 2026 18:01:04 +0000
In-Reply-To: <20260906180111.1973188-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260906180111.1973188-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260906180111.1973188-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/8] vxlan: initialize _md in vxlan_xmit_one()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If a VXLAN device is configured with both VXLAN_F_COLLECT_METADATA and
VXLAN_F_GBP, and a packet is transmitted through it using an external
ip_tunnel_info that lacks the IP_TUNNEL_VXLAN_OPT_BIT flag, md is left
pointing to the uninitialized _md stack variable:

                if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags)) {
                        if (info->options_len < sizeof(*md))
                                goto drop;
                        md = ip_tunnel_info_opts(info);
                }

Because IP_TUNNEL_VXLAN_OPT_BIT is not set, md is not updated and remains
pointing to _md. Later, vxlan_build_skb() is called with md, which
eventually calls vxlan_build_gbp_hdr():

        if (vxflags & VXLAN_F_GBP)
                vxlan_build_gbp_hdr(vxh, md);

Inside vxlan_build_gbp_hdr(), md->gbp is read:

        if (!md->gbp)
                return;
        gbp = (struct vxlanhdr_gbp *)vxh;
        ...
        if (md->gbp & VXLAN_GBP_DONT_LEARN)
                gbp->dont_learn = 1;

If the stack contains garbage, this causes:
1) VXLAN_HF_GBP flag to be spuriously set in the VXLAN header.
2) gbp->dont_learn and gbp->policy_applied to be set from stack bits.
3) gbp->policy_id to receive 16 bits of uninitialized kernel stack data,
   leaking it onto the wire.

Fix this by zero-initializing _md. If IP_TUNNEL_VXLAN_OPT_BIT is not
present, md->gbp remains 0, and vxlan_build_gbp_hdr() returns early
without modifying the VXLAN header.

Fixes: ee122c79d422 ("vxlan: Flow based tunneling")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0f0dfb4e176a98ca9a01cea6db548116ff8b0d95..34e3563362358bc4b085fdac2a7167d094feaf26 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2368,7 +2368,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	struct ip_tunnel_key key;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct iphdr *old_iph;
-	struct vxlan_metadata _md;
+	struct vxlan_metadata _md = {};
 	struct vxlan_metadata *md = &_md;
 	unsigned int pkt_len = skb->len;
 	__be16 src_port = 0, dst_port;
-- 
2.55.0.979.g7e5102b832-goog

