Received: from mail-lr2-f32.google.com (mail-lr2-f32.google.com [74.125.230.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947B4DF4BA
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231271; cv=none; b=nXJdZML8Y+oHeWkrkzYrz0qtSjQV88JoumwKSgMhiQ0CfzGVV3ulMpeRMYHIM0SaLnyVnd9fQSYTSOw/hZNQCGMaPXJYZLDUn5dt4NGe4PjJ8gvsopq2reA6/MIm7H6I23zPGJrE9DNkQRIyGjhTeaJakFmIqBY74v3i3+zSaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231271; c=relaxed/simple;
	bh=k+CqVpScWbP1p48LTH2kXVwo5Ssi8+hZEw2CjOqf9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2XE9N/6VyyJ/4HM4jnFEVsZ+mNpxHfolhGQOolhk5e5AM5af4oIm1YLy5gE7Z3CvWGl+MJ3fW0yJ4oXWqRAO/q9qWikQZ/NfWQewuV5XP277Gu49rCBFsMhoFIj6dXbSBb2YzNFCkocaNT7LfEezdpzxoUfNvVBNR6rynV30Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rduv9rMk; arc=none smtp.client-ip=74.125.230.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rduv9rMk"
Received: by mail-lr2-f32.google.com with SMTP id 38308e7fff4ca-3a97ab5684aso18988531fa.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231267; x=1791836067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeNCYFzb8b2KgrRiXXEFlWiBLqGLegK23GWQ11tnNlM=;
        b=rduv9rMkdVqt4blvyIOqQnLVRweW9UeN+3NUfMepxp8DhX+ftL8n8fDPD4q8Q+L+dr
         hOsnk/EyAsvxp8eGHWPBiIOR4VlQfleAezzdyR9a8psOpYPO2HYt5G3HsD0Zs1t6sgbn
         haiifvd7MtZCShUe7YClp9G59/oV02tVAO7d279zhp0W4Sw9nrBi5D4ExghsIEx5X/pc
         KAiSh1EEB9Bk5m/uPTpAxhj0K/z2jq0nCa7XHUWrIJXPpySJiZzvtr4tzqiueIJaEp1d
         zV7TpR+qMIWeAf9+ZhmbAtPJqDr/ujbpRNLvM/15twVzNswMVW0N97DBaLLauctxtBdt
         iL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231267; x=1791836067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeNCYFzb8b2KgrRiXXEFlWiBLqGLegK23GWQ11tnNlM=;
        b=b2Se+hA9XnIlNrVUbCV4KR3JgJl8564Y+eevruo3NkCN9nZ0CGt0RUJxBIo1CnHdNS
         aOSkjWUMTMEZ4bCpoRKdt6mlopUu9tdDHwUjbdxXpQJsbvzEdP9K4x+Y8NEPGPGcqvXU
         hFRKsbANLecjCTp3gl5n4f7dLTSjATk5KwmzuKtDLRlWDc1dBfZvU/UNK1ROM2XXef67
         841aupwjsaMLEZRLz+RmnOb8JwyJTdYbI3sn/daF7uyQJZdkKjNPbzVRhhuEuHj8spM5
         AChCJ7Y39KCTUz3E/mA/N0nqhzH+rtBvodry/Uus8h6x87BgTv45dCNsP+c2AUpC06GD
         fPYw==
X-Gm-Message-State: AFq9FYJFTKDdRkmPBd9tjs5xJlz+9/TtL8kgvjZeXfDqXXTadnRiX0pY
	lAeADzdxieRSyJcVwTYfT/+pD2Oz5jMobCVaeECJ9vKiBvx0MOVE4BznZfRaPgns
X-Gm-Gg: AYBFou08vPinSBhE3aTCsqqz/8uRWxOv+5f8YcvtOp+gaa00fe11CdaMTuoQScRdIOv
	aaFs0R+6hYbCKgUzOHwyHDxchXeQctpIkHCeOq5YIO38CqYOwXs4loQGsLAGMgEbk6G21aeEg9n
	Ak8m5uGs+1Zg+xJtsqUjv6eXWMWhVd6h0BWszTRA+8yKOhxjXo1soBXdGK1XqOARCpJprQe8MfO
	VOWswiDe7s8bPaB0XgbIUTcHxm3FstExe/m6cG15oAEIcA+vhR02cReY4+ZaD/s2bqlotPU94PE
	ctYrnxKgePgY9MIjZkL+FehdVw6UZE87aY9Jy0KanyAezDo3wqephlaROPL4ksNBnM2rsRr0YTQ
	poKMch+XUNUgGDXZjQepWr9/s9GWDBG2pUGWEPXW+EVhmFxsx4dzOjVVfPluHk5o0sA0D51vwAA
	VdT32FAQqyhlbt1hTsrpnugwo5GjT0tcbjKmepZF4hwSPzd/tT6pH5BRHPgeYwPUGVI/tegNG7U
	zAWB8v7umiEijzwYjUXWzl4Yl1JykjAdOT2LCJt2Q==
X-Received: by 2002:a2e:a58a:0:b0:3a7:8058:9e45 with SMTP id 38308e7fff4ca-3a887678bbfmr28808481fa.7.1791231267213;
        Mon, 05 Oct 2026 13:14:27 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e303889sm43114681fa.20.2026.10.05.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:14:26 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] vxlan: report the drop reason of __iptunnel_pull_header()
Date: Mon,  5 Oct 2026 23:14:16 +0300
Message-ID: <20261005201417.906344-4-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
References: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_rcv() reports SKB_DROP_REASON_NOMEM whenever
__iptunnel_pull_header() fails, as the helper used to return -ENOMEM
for any failure. The VXLAN header is already in the linear area at this
point, but the inner Ethernet header of a packet without GPE may not
be, so a packet whose inner frame is shorter than an Ethernet header is
reported as an out of memory condition.

Report the reason __iptunnel_pull_header() now returns instead:
PKT_TOO_SMALL for such a packet, NOMEM when an allocation fails.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 35a47cc27200..0d98e29e2d72 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1743,11 +1743,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		raw_proto = true;
 	}
 
-	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
-		reason = SKB_DROP_REASON_NOMEM;
+	reason = __iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
+					!net_eq(vxlan->net,
+						dev_net(vxlan->dev)));
+	if (reason)
 		goto drop;
-	}
 
 	if (cfg->flags & VXLAN_F_REMCSUM_RX) {
 		reason = vxlan_remcsum(skb, cfg->flags);
-- 
2.47.3

