Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738046E005
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986149; cv=none; b=OyXlQZswGMp52/wuUv58xyuWzirB3mIqhZPKMsIrKUP6l8zP1x0qAt/rR5oIKsGb4asKRoojJ3Qi61iI64+co8eTyKNE0jJ4P8t8GIvdEdJEpOGDvdlS3/yOXqXgrjBrt2oI8zgtrjNrjQlFDx7ghVSB0vlbgtEdunfuqqpHSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986149; c=relaxed/simple;
	bh=4sK6QOW/XuX4PtRDm8Px7ysSOyjt0ZFKOsV7wL7Mp+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knWE1RU/q8YFHxyF/1OGNqzzpOG09nPeln1/yYwKKq035A9sazp/BSUzrQn/vYrJ+TlalZr2Nb7bS0D2/JtbMZqkDtcCwnNXeZDRi6TFEAskBRSsCkdFhgsyeT6lpfnFPfygCXv/lu+5ssUOUmwbqYMQL27CcYFPtTrW2wyvR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J1ylzubl; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J1ylzubl"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so19108225e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986145; x=1790590945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKECQPH61OXosXrIy2gW7bks0SM6RaMxdNnU7t0j8+I=;
        b=J1ylzubl+8fhTfZhwHLYlSeeeCucYeSIAxeHjU+hksTv0cgwzvG2O9+tbkroIyT3wx
         /9B5FmONXfxWjXsnLrIeUwu071p/YEzkrJEVVWAJJRiInuwRVqhC4P/rmoUFbEG4c83K
         ReNn3VpD3N0Zpxy2fNmEMrT3k61Hib5nhiCPo4cSLGGaZE5kGRw+0+H3ITbbWM9wwb4o
         K/jo+RZ7FKB7/sbKXvo0EDLyAh6E59+6/dsxB4i/X0Ft4BwZsE5YLi9Vin66EK5x9an2
         9FJoxlFc8bVHexyUi46nxLhys385gzU0sT09BDkedxVd4p4w5nJz+LMYELUuROS/hYQF
         eBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986145; x=1790590945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WKECQPH61OXosXrIy2gW7bks0SM6RaMxdNnU7t0j8+I=;
        b=EUQ97upXjOqZEQiKAIHkotjuTUALQf14I2p9N9shgbaPelV6QSkBSVjnfaVXbojQms
         KxhQYT9Oj7LXKNTPX/2InTOyI28HXXOnCugYuzGnCsbgVo12zdOq6W69krqxXddnkXTb
         6X0/fbKt1ohZi/DNjl4VXlOeSQolOHFzo5gomx/667Pe1hl/5tsKA7j9g6CESbmUimik
         NQEqQRK6C2/w973fJXl+zZYD2EXYNOH1ldUK/NJN49sU7KTpkJGsNdCwdzjD/bnZI1PY
         MpjjZpAcnOy4Lmum9Lw11YarA9zec7N5H8Vc3FAzvKyxgwloY2W59LoLofcDrpMSG934
         JXbg==
X-Gm-Message-State: AFuF++n4EWQochIOZ1Cz4T6rvmHZF/U8DN7vfN5TRAmbwSsPyPqFjuUm
	la7mPa1q9DThmuezqILov+hNv+nA4+Pp+8bSOTp0a3DbvXgXvoB65R1LoZ85ZVo7Ra86Plh0daN
	WPPeXh694XkxsDf/k7iQHDdMiNgqt5O+WPxLjqOKi5Pz4mA84AaNGrUWneoK+l+ktoOg=
X-Gm-Gg: AYBFou29/SeNVXS2a4I8tnVFh3rMwdmNJ3cUmgp79fqjFVxy7x+tjoX19My4cSszZ1w
	8ymEax90l20yr2FOb3JsMeTo8i/YpLpzBop8k+o8OB6ymAMU3jv6954U+g4X5bJEOayK1w/pCvg
	aawH/6JjZzLsNmL6rwcFhehoLCTBGPQ4yfHTtMSrtbDzIYk/SepjpH78n115ZoQHr3iRnWUhds5
	+oiu36FYPRq93ntKu9nsEyOaVPHiAElKn6HT9Pp6TKB0T/tnt8U2wbR9zG2+TJhHzspSrJo3Rv3
	psYNdLkHg8livLjTp4z6p401IPuDVyH1ekV6Aajtt/dcVzZ8vydaNbFXWJPcBYDX7OAShFsj+19
	pTMhuC2SRRwI/42am9+xuxaG+Jy0dWg+j2uxEDGtzAg5Zd5VqSUW+lp9QSx5I8Ufc2UKOA4R8jf
	XdW48jRrbObpPcpcOu1HZ7w+H7tUoIYusghKUVA7oPkOFECKm5h6HhYNlltouJfgH7fwob63eZt
	L1DPN0GanI=
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id 5b1f17b1804b1-49fc56811dcmr146021255e9.4.1789986145609;
        Mon, 21 Sep 2026 03:22:25 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 07/11] ovpn: always unhash old VPN addresses before rehashing
Date: Mon, 21 Sep 2026 12:22:08 +0200
Message-ID: <20260921102215.3599702-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921102215.3599702-1-antonio@openvpn.net>
References: <20260921102215.3599702-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

ovpn_peer_hash_vpn_ip updates the per-peer VPN address hash entries
after userspace changes a peer VPN address. The current code removes an
old hash entry only when the new address for that family is not the
unspecified address.

When an address is cleared to 0.0.0.0 or ::, its hash node therefore
remains linked in the bucket selected by the old address. The address
comparison performed during lookup prevents the old address from
matching, but the table retains a stale entry until the peer is removed
or another address is configured for that family.

Always remove both old VPN address hash entries before conditionally
adding the currently configured addresses back. This ensures that a
cleared address leaves its hash node unhashed.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 430c6cd48db8..bbd9e17fb0bf 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -994,10 +994,11 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	if (hlist_unhashed(&peer->hash_entry_id))
 		return;
 
-	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
-		/* remove potential old hashing */
-		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+	/* remove potential old hashing */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
 
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
 		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr4,
 					   &peer->vpn_addrs.ipv4,
 					   sizeof(peer->vpn_addrs.ipv4));
@@ -1005,9 +1006,6 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	}
 
 	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
-		/* remove potential old hashing */
-		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
-
 		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr6,
 					   &peer->vpn_addrs.ipv6,
 					   sizeof(peer->vpn_addrs.ipv6));
-- 
2.55.0

