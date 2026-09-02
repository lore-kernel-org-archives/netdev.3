Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F930CD85
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309244; cv=none; b=IxEToqujt5qMLxHjGC7HJk7aRkzBSdb6/5n8p8IV8puvXdxyE+FGoXFjJv1UnmqgrZjMJwq7tY2qqVrS92onFN50us5nrkFcovsgHyw0YHq7+Olfd11IslMk+xutuUvSHxo+FIc6IIHjsmH89EE7cXHXc/QjZ1JcUwkr8r5gKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309244; c=relaxed/simple;
	bh=JDBhBl5Pw3qwOnmR23OUEOhePvlgKFj0eXeLXDvHPgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YJspituCVRlQkaUWVBqT98iFJHnbdQiBSMUCjllOyzAlgPzKxTlC38jgczc/C2G5NkHDVQkTdO35cf2q9HUVw8YxdQ8DxUtMR9929Tr8hZY9YnZf7gXsjQKEmczk9LufUqoMCcSYax/24XxtEkVIWao4RTcoBTKIJMJ9TkAYUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hX4E/BNp; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hX4E/BNp"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936aa34873bso81602385a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309242; x=1788914042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8XTRniNXlALRsL56vWMmMPdmCSVfFjF7AQO2dLzqtk=;
        b=hX4E/BNpAILCdasDrESZV+opAxqxLdYpBtMwdzU/yjxEGRCk+zzGqzbCt7f3gFa7XK
         HBGE+4SkAzvloo/KVzW3EjBJgUo0lmfsxF4K/odUJIWIqttrF2vE4+EatMluBbIgFPZy
         Q2VNzIcph8KqX0+HKExQ7nnkoSiipx39dwaszx4yCwFBOkAbDH6RRZA8guIzakSbnERH
         FAMjO8r0CizK45/AiABcSR2o4EHK+GLln4ruKxBFCZDLW929UCPNCgkwXQPqHVKPSpvs
         sWEmt0uIBBtqTBIKmp7IE4W0AS58bqogyAFkz3E3VYJJ8lYeuiL2NtWazYnZQX19DlSM
         pW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309242; x=1788914042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X8XTRniNXlALRsL56vWMmMPdmCSVfFjF7AQO2dLzqtk=;
        b=ZFZwXKJVW3LjA4ETHwH5Bci5921MfErWwz+Du5jeuciuOk2MppMzjuHsDMcqda7cy4
         N6KykH3MWuTdAaPZNoglaobWhYwNzVuEKKrALTuxwgkCZYqiS9c0keZccSD/Qr+yREPi
         WbM4xF1mfMwqKnHYplKkW7Th/9WWO7ZkYYr8c5W14CSMUwZ8hyI7uj2u3zifoHOA4t2r
         1+qte5S3EldokU+1QEOvXPEW30ihm9o6X236mcHpR+0Q9MAyd/wM0Hqhl7IOZ1WRQ7yj
         E9P6yoFbZ79w/GrHeXmjFFIfI2x9vMZln6Z9rLRPurTEXP8Llf6gj42xOWXdBL7neL6+
         eJXw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4cgYLBRHwdCnvOLiImkfTQFf00jqqhg559aX3SncTmoynQbVvsqk2mCQ9rkVyG85iMR4mHew=@vger.kernel.org
X-Gm-Message-State: AFuF++kJD3qT5sMJV4WkHXUvtLUlqHBEj2tM/T3RZltWx3WHr4qWckyW
	Kk2moreX5Lzf6stGsQIl7QewdH1l2ywrPSMNnqTNVhjpoMa/Edy1EMs5Gv0u0F2Y2IJ+DxXxgKk
	Sc6evX1I6mato4g==
X-Received: from qkgv9.prod.google.com ([2002:a05:620a:a89:b0:92e:6943:2e14])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:47b6:b0:936:576e:227b with SMTP id af79cd13be357-93960f3c98amr134407585a.24.1788309241481;
 Tue, 01 Sep 2026 17:34:01 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:44 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-11-edumazet@google.com>
Subject: [PATCH net-next 10/10] ice: do not assume mac header is set in tx paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of skb_mac_header() in ice_xmit_frame_ring()
and ice_eswitch_set_target_vsi(). Also use skb_checksum_start_offset()
instead of skb->csum_start - skb->mac_header in ice_tx_csum().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b069e6c514fb1279ddd9e941e76271be0e72c912..387e8fa8e924c64ce1146e0d86e0f8a853640085 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -244,7 +244,7 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 	u64 cd_cmd, dst_vsi;
 
 	if (!dst) {
-		struct ethhdr *eth = (struct ethhdr *)skb_mac_header(skb);
+		struct ethhdr *eth = skb_eth_hdr(skb);
 
 		if (unlikely(eth->h_proto == htons(ETH_P_LLDP)))
 			return;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 31303ab5be175a5ce698f16715ea8d75eeea7bc5..5e73cdc71a68dc23022ff91d10b2c8c872939ff2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1743,7 +1743,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
 	    !skb_csum_is_sctp(skb)) {
 		/* Set GCS */
-		u16 csum_start = (skb->csum_start - skb->mac_header) / 2;
+		u16 csum_start = skb_checksum_start_offset(skb) / 2;
 		u16 csum_offset = skb->csum_offset / 2;
 		u16 gcs_params;
 
@@ -2219,7 +2219,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		goto out_drop;
 
 	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
-	eth = (struct ethhdr *)skb_mac_header(skb);
+	eth = skb_eth_hdr(skb);
 
 	if ((ice_is_switchdev_running(vsi->back) ||
 	     ice_lag_is_switchdev_running(vsi->back)) &&
-- 
2.55.0.966.g6673acef38-goog

