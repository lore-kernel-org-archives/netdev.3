Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064616;
	b=vkodMo3IcExSTT1p0R7OaaMowXIIJTR207l9z0fny9bmoCWQz/j1c+wzNUAHg7uKsnVx
	 KS9g5y55NzMkAyEdcQACMZjFwduqtWl+SgmQs/zcW8PP3gboH1lnc5/PlWFqgxmHOtobL
	 NiTu+qh+dcmLYl1XuNoKxyTcfX8hpO8XS6OnlPRfLu/qywK4HMS74E4JAtOfn9752MnXh
	 ssS1gU2aK2k1xS7llOtxX9R2tx3G9aFU466e60CwL2CCdMnAW9AF+tY8+wjVELJP3FOUf
	 06LzfBy35hcIbLwHpLeyyE51JT4u5O4f+90ttOutHu3KwGd2qyLkQZTFDOVDS0+Uhig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
	b=WUBgwjEClTv9O/XwLY1hOSK+Ln1u/zUvSncKcl/pI/wEeqxl0VzzEVnf0EzJkCY5WOSg
	 86QgUcaeC9UamfzhEdSs6/iBO80EIlSrV5s0//8BO0tlGUiJR1qwXMluS8eIpLxvogImn
	 UZWk2A3PjlGL0i60mtYsEiw6GTfDI76VICx1zN5LX6uFyv9mSE06SY1GqfFUmm+V/tWhj
	 dDgKvCwElJpN6CkbWO053/RCZzBvSDRgl3RN0x6O4Qp3OiF61lb2yoHw/52BShjl+Tk1x
	 G0zqZyJdpqyTCn34cJ2QIEKH8lhH+NdMAQ9eeWjqD9VABDOFveITwx83hX76QyQOcJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BjWgtbiW;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024B606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C024B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BjWgtbiW
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0db268bd8so24006477b3.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793064615; x=1793669415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
        b=BjWgtbiWWB/ebZwzA+G3TwJ+ah3Cn1chN7V7vbSrNAoxuaBQCzMzK4pKssSlzwlqBP
         OzyTzTnkhBon25TZ4NqvUSE/LJQOhTgLP4b2MXFuKuYAKytiD0QsXwn0Cv6/NAJowIv9
         tXzc7dDmNGkJ8omZSflHpFjloSOm8u0An9xWGwr7blv/DrKG0Lni1Q/ai6H0XOBryu9+
         PAx6OFMPOyfUXANiNlc+wu06NSFpZikV8DFOKsxxxPYY2ZiXNBfBglNob6vqRsVYby1/
         GOeyr60uUY9tc1PkrHh/nhCa7CdV9dNaUIAw/5r/iufrolKmlymZQkMlc4UZRLesJqto
         1MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793064615; x=1793669415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
        b=MvalKg5mvUU8DRQGnrKjTxDyjYXlsyxhJBCUiYP7Fx6ofZoVkNoM/3gMtm1XGxyCQK
         jv6upLhzMc9Pa82fFD0KuD2lCnDEEUrFGcuE54PjNcv/ZvDi8maBE88wjk/sssBSfuRX
         f24hBcMZq8EYeNNsshVXrQe2JxxoIQKbNkB6fiCbF2xGorK6b4zLs3Omx0TKecO9P2ls
         f4dbxQ54rJBMQ5PDIyXqvEZj21cVn9hK4TDTCeDnhZ2/FdjsCRs8WEyJyEdxoOqIRVWZ
         60l/2fM7G7orbNccBLdA3HbdtXP+K4TY2wN5oZbqxkdZYT0IWRM6qFR0XwgKYqQvE6kz
         6ccg==
X-Gm-Message-State: AFq9FYLlzo+MWzWpCrv8dZA2nEJgTnVDHFhwxzWaX8DKODjWzihOwurO
	SIas60VRZKsT7mtpujzs3mZJz9kr3Z1fRhslC/uoBQL0G1A0A4LLyst3
X-Gm-Gg: AYBFou0Td5sESoN/GYCMRwNSUmJOw5srvtMC8Pqktc3g6mNmDNWu7CpTrQqskpV6j8C
	ssLWPtXhxyWeoFhtZL3zZTwBzyfgbgI956OOORAnIrpVvd1uWM3MYMWlcTasbZoa7hJt1vRMkSa
	e/MRwVLQD1tLJZEKNLB+ZHrfbbP0OhXEwLTOyxEfH5Q01ukNOtSw3DCZG3i4FqaUhWEXmZNnely
	MkI/UdnNY/ohpNoXPFuLRsWqPBAAqKUBr1nKcDdbVO/RDqUzGSCFiBuT9/H9v7C4D/s/e43ai8a
	4kuOyO4gzuLMCGDt2Viugc0ysgDEJwRwDCWIbShROAqA0J9k4kd9sAyfQbhtSAwAhPA43iv0wws
	bPqyWElbK7UwDdcV3U1HuZUGBJJRlH8gbLXCGkxWnQi+bghQcpjplxYeniDfBm/64IOLi0bNqUI
	ZYwRO/hQv78qVRBIjvp2VwbAO4tQmRRCFM5mOKAlEughiEp1vkTyLUfjwt3J/Wr+02ibM4C4HO/
	qgPtC0WCeim8Za/Qdn8kuCDV9zOc02GjODlb6Z62YS8jDxlpx8+Az4O+N2LwyGzfoY3IIELoY+j
	gA==
X-Received: by 2002:a05:690c:e085:b0:873:5bd1:98c9 with SMTP id 00721157ae682-8b166c7b83dmr53834777b3.59.1793064614580;
        Mon, 26 Oct 2026 18:30:14 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316:dbf6:fb98:d66b:7c65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e65948bsm4557977b3.45.2026.10.26.18.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:30:13 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andre Brait <andrebrait@gmail.com>,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net] e1000e: fix Tx descriptor field wrapping
Date: Mon, 26 Oct 2026 21:29:58 -0400
Message-ID: <20261027012958.52524-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When an skb arrives at the driver and the header length exceeds the u8
hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
are sent to the card and it hangs.

This was reproduced on an I218-V with an unprivileged Python script.

Fix it by disabling GSO and checksum offload when the header length (and
checksum offset) would exceed the field widths. Compensate for a
software-inserted VLAN tag.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..11714032793ef 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7355,6 +7355,27 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	unsigned int hdr_len = 0;
+
+	if (skb_is_gso_tcp(skb))
+		hdr_len = skb_tcp_all_headers(skb);
+	else if (skb->ip_summed == CHECKSUM_PARTIAL)
+		hdr_len = skb_checksum_start_offset(skb) + skb->csum_offset;
+
+	if (skb_vlan_tag_present(skb) &&
+	    !vlan_hw_offload_capable(features, skb->vlan_proto))
+		hdr_len += VLAN_HLEN;
+
+	if (hdr_len > U8_MAX)
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7374,7 +7395,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features	= e1000_set_features,
 	.ndo_fix_features	= e1000_fix_features,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= e1000_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

