Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C027FB1C
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956781; cv=none; b=QBVnddjKVlAxAyM9sSRtKATrcaHzbDCvv7xIIFnYwDvQWC7yQn9rT/A/hlmTrEgm+qCNQgXfDpPOsuv1OR+Asekn4YjOeWDAm58uVLQJMSN8oe/tTwqmDPYPqLYQicCg+QauSZuoj6vpAecqEAE4z0JWgTv05qPYlOHh4ZaVhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956781; c=relaxed/simple;
	bh=DMNfYlMwDzFMT9MKWuc7BGVkd9GqxzgPKdtOv8N0d6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3i69G9IBnqAGpMutMqkVndrAvCrqYJUAOFFBuOL8FJV4KO0BnXA7lA+AunFXXsMuFn0aU/6DZFOOs52lAZ0a9bLpaZ0f4OEKFROB0Y2reJfQwU3pziSnigrH2YG+FUKxhjyIloSYZlS2haW9YfztoriZNivPQqnXmY7aQCHLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvXML6M+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvXML6M+"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba357a1929so3458718e87.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791956778; x=1792561578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+5T9X62m2XyH/11b9ZRGWiO9yNW0NlBwsa5IZJ3yF0=;
        b=DvXML6M+HQtzDKlYSPeCA/lT1kcDCuWDtRRTnya9JH62cR70C9hMZa35P3pKhcQlD8
         QMU0hWQpEJD0uIslHaRqf+rSew3orOYW0y3lbg6Qd3qKymBPwD8qlNI9LgrIPvorpFWG
         mjopF7e+VHcOviRaP+KYheFssoV7lYcKRMLegkpT1vZ4yug7+XY4C3o/77PqbycirweM
         Uu7mJQ8h/eFAVXPlX+7Cmw5cLd//0o5KjGJEKiDSKolnQInDDSneK/CAIGLcHlk1FQvW
         gHAncDKywvKKzyDNkDqCIhfHtURF8LpWGWpT5TjmLeTLK05KtKFWMGzL/Ogf51FBy38+
         Y7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791956778; x=1792561578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+5T9X62m2XyH/11b9ZRGWiO9yNW0NlBwsa5IZJ3yF0=;
        b=1cdcvCed1nWJ+TqVOHca5pVDifkBbWkM1y8oPRkc16J05mn/GqkO7KZ2bWK0dK0yCY
         wGKzuLeg2m8YXiEH5Rdw3OB8Vl2XqmU+GHPxSPSpFEb7Fdny7HSze8Ho9Xhdse84EWOC
         Fd0zboBf+eJb1MpPJdYZkG3UFk6SYXW7X5vcZkVD8FRTHCuwm+wFGnxHA1m5jajSmYgi
         r8ku+hOalLsVv75+sVbP2qI2FpVrgTOXbkihFDXM/Yq0URWsbggdNiJRxIgf6c76SYq7
         QNXdnKdHgtrkWVKojcqx8otj0Rc4+rAh+LADfum0grcFqQ16LJyLGf/KPj6x5Fxh6Gjn
         7Mfw==
X-Gm-Message-State: AFq9FYInRdKcDa0lmB1qe71Kmw7mL95+w7XAPHZoObd2WJCr9ibNhrvk
	87RSsVP7MhpOLj/eyEvqqY6XKtAyVDwjEOazTsgiyMaKa7bOkFL2ZGY5oGCi/IC2GGg=
X-Gm-Gg: AYBFou0ZXKK6xZ49HcLsA9G6sGRacz1LvRIYBFKd0WMWdex4HA6n7K+CDTf9/96KR1Q
	XjthkW7b6+YwnVpXAYKY+3KLgdlotWV068MAVCMTvT87dmf6rugRcwJjV4vZ5KF+GObcAmLpRvQ
	dd4pdgfHMUlKCkr0X0qzuFkRGfRRAyGwLkUXsb485rNBumKaid1Om9ZNwLYPdEnKZ/F18ruJU7O
	LmzT11o3VEIJAOMnM1Rkcz6mnga8oBNvspgj3GiY+tcadJ+cAYbTZP5i3rDXv7yv0Qmk5Zk81ix
	NXGNk4sGb2L63Uys8vKc5JBxUpugmo12rJPOmjKEI5X1NTJhvDbSZ62dQxoJj2KQr3+tnNsdyOy
	WjXTAVv1dyXWUbhT3D+NfFmeE2R7dgUUACUyBbhbtIqG4Swu0vxe1SIXnEjmLSgzIAmcYqCBzci
	pWusbi4KoMEVSgZv+A0C8euvH767+Zdbz3xhciDO2r2l2B4X9SCigKoHfWTvZxUXwjGFQqY4YQU
	8ACjv1XbOfG/aHGGNNo6NsgxgzUawetzYTGUifE9ffnbdHJnGUK/DJdT6PS7Myq
X-Received: by 2002:a05:6512:308c:b0:5bc:f0ab:1f3f with SMTP id 2adb3069b0e04-5bcf0ba663amr3547827e87.42.1791956777495;
        Tue, 13 Oct 2026 22:46:17 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d8fe69sm392928e87.57.2026.10.13.22.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:46:16 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3] tun: use pskb_may_pull_reason() and remove SKB_DROP_REASON_HDR_TRUNC
Date: Wed, 14 Oct 2026 08:46:15 +0300
Message-ID: <20261014054615.1656074-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tun_get_user() is the only user of SKB_DROP_REASON_HDR_TRUNC. It sets
it when pskb_may_pull() fails to pull the Ethernet header of a frame
written to a TAP device.

pskb_may_pull_reason() reports why the pull failed: PKT_TOO_SMALL if
the packet is shorter than requested, NOMEM if pulling the data into
the linear area fails. Use it for both header pulls in tun_get_user(),
on TAP and on TUN devices, and remove the now unused
SKB_DROP_REASON_HDR_TRUNC. The pull of the IP version byte on a TUN
device with IFF_NO_PI was reported as NOT_SPECIFIED and now reports
PKT_TOO_SMALL, for example when only the virtio-net header is written.

After a successful pull drop_reason is SKB_NOT_DROPPED_YET. The later
error paths without a reason of their own, the unknown IP version on
TUN, the virtio-net header conversion and the path that finds the
queue detached, relied on the SKB_DROP_REASON_NOT_SPECIFIED
initializer. Fall back to SKB_DROP_REASON_NOT_SPECIFIED at the free_skb
label, as vxlan_rcv() does, so that these paths, and any later one
without a reason of its own, keep reporting it.

The errors returned to user space do not change.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20260923145931.GA2859441@shredder/
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v3:
- Rebased on net-next. Since commit 44378d02c5aa ("net: always dissect
  GSO packets in __virtio_net_hdr_to_skb()"), the virtio-net header
  conversion runs after the header pulls, so the commit message lists
  it among the paths covered by the fallback. No code changes.
- Collected tags.

v2: https://lore.kernel.org/netdev/20261003132340.4175269-1-littlesmilingcloud@gmail.com/
- Also convert the pull of the IP version byte on TUN devices (Willem).
- Dropped the Reviewed-by tags, as the IFF_TUN conversion is new.

v1: https://lore.kernel.org/netdev/20261001093925.3529772-1-littlesmilingcloud@gmail.com/

 drivers/net/tun.c             | 8 +++++---
 include/net/dropreason-core.h | 7 -------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8b82a7fe6ec7..d4152c9ba8df 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1903,7 +1903,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (tun->flags & IFF_NO_PI) {
 			u8 ip_version;
 
-			if (!pskb_may_pull(skb, 1)) {
+			drop_reason = pskb_may_pull_reason(skb, 1);
+			if (drop_reason) {
 				err = -EINVAL;
 				goto drop;
 			}
@@ -1926,9 +1927,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb->protocol = pi.proto;
 		break;
 	case IFF_TAP:
-		if (!pskb_may_pull(skb, ETH_HLEN)) {
+		drop_reason = pskb_may_pull_reason(skb, ETH_HLEN);
+		if (drop_reason) {
 			err = -ENOMEM;
-			drop_reason = SKB_DROP_REASON_HDR_TRUNC;
 			goto drop;
 		}
 		skb_set_network_header(skb, ETH_HLEN);
@@ -2065,6 +2066,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		dev_core_stats_rx_dropped_inc(tun->dev);
 
 free_skb:
+	drop_reason = drop_reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb_reason(skb, drop_reason);
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 664249924219..fa2fe8990557 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -82,7 +82,6 @@
 	FN(DEV_READY)			\
 	FN(FULL_RING)			\
 	FN(NOMEM)			\
-	FN(HDR_TRUNC)			\
 	FN(TAP_FILTER)			\
 	FN(TAP_TXFILTER)		\
 	FN(ICMP_CSUM)			\
@@ -427,12 +426,6 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_FULL_RING,
 	/** @SKB_DROP_REASON_NOMEM: error due to OOM */
 	SKB_DROP_REASON_NOMEM,
-	/**
-	 * @SKB_DROP_REASON_HDR_TRUNC: failed to trunc/extract the header from
-	 * networking data, e.g., failed to pull the protocol header from
-	 * frags via pskb_may_pull()
-	 */
-	SKB_DROP_REASON_HDR_TRUNC,
 	/**
 	 * @SKB_DROP_REASON_TAP_FILTER: dropped by (ebpf) filter directly attached
 	 * to tun/tap, e.g., via TUNSETFILTEREBPF
-- 
2.47.3

