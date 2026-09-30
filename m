Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F951EE15
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793571; cv=none; b=YH9EqRoP0Wo6+R2K5PhfUtiwmqSt+zgeo0gX8txo5JKzvdv6qsLk5bRM7vylkAeEqFV9nsDgdZ24L4iTVGe8DbxA+cYGPULoIoxV71AE3ugRq3q0NT5+i8UXs+3ZMxIqJKJOv+C0WWsJRnFBj713Csq9fiBX1ls2GyLzk+eOjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793571; c=relaxed/simple;
	bh=k+CqVpScWbP1p48LTH2kXVwo5Ssi8+hZEw2CjOqf9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBrnmameMasaZNKqkVn3JZ6utbD8S6NQaM/Z4q92Yl5DVBIuA8hY1xdr50lE/l/AajIUS5wUOCSXtYB4SiVQjNpq2XsEQ58uAe2n5yonpsX/Cwkw1wx+Sv2H9a1A6gfGNWD2Z5FlHkSfxipfTuw0Mr4nQ0x+MXGLNKxJnBN1mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Voo+srXv; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Voo+srXv"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba3feee1d2so760359e87.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793567; x=1791398367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeNCYFzb8b2KgrRiXXEFlWiBLqGLegK23GWQ11tnNlM=;
        b=Voo+srXv2/y9+/yOp/VeMtIKl/SkIPAxxf8TmQ5DYTefTD+6ZgBEg5iuHsjOIkpmD8
         voOJhIGsNlUxnjodRKxNHA8qKbYhy6xNkHoD+GgzEp1BBZlu2ZlhnYzIDhRsQ7vatS2f
         5Ok2vVIzl/q9Auf1hxUf8Fiv9qE6P1gQTiMs5pyvprT7KTrRDvWfB327tEd888Rs9Qw0
         z7JjozJZba2xoIFAEkjpAhdjLmceAaMxdysPaJ9KVoONMbNMcNBJ3pyGAnZLCcxoeSYT
         nasoug/r6ZUBku5NcvCpzm2AQUjv47G3Of7D7SGMPxq6NlgqgMsuKDnS9mNsfgTBLpn1
         eYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793567; x=1791398367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeNCYFzb8b2KgrRiXXEFlWiBLqGLegK23GWQ11tnNlM=;
        b=b3sTpnsnlqMWLENtlsHiz3KSxahfMkLxbcrfA/S06oqbMknaHrSMxD5/lg8DsFb0yp
         hffF+qeMTAZFQnuLnUqJah2R3aaCFxhA1tCsjOZKomg/rn88YcdlPf0+gDh8DOExKoSK
         /6S0k6OsaOXo1Y8NJsq/qPzhV8wxBksivOIpSa4dcKpzsrjjLEpkdCRWHy8lyzINj6pm
         3dZ1gVkKB+6v5mwbTP8ki8cA+3ot1ld/rr3oVTBJTaQyOl8RSrFITLB8FifMQrFs3AYG
         OJFu8T+in7k+hA3Ff/CNvfOxI41eXWmy89hic4jL5kdhGFmZynAiKAuB9DHCEUyUW9HG
         /xUA==
X-Gm-Message-State: AFq9FYK+6zkAOo4HNv8IkmMjUwJnuOM4bxMpRVNyQpH9tUgXzxSBCQAG
	dXuV8hN98HSHxWZOnKtynreaiYYw4xMVNzFIUpVejhQH6C9EFhVhtsiIQ+2i4U3l
X-Gm-Gg: AYBFou2Vqw2ZYLjI3fjd2PeaUH3K5/uRJZWjq1+iQ4K3C9/yeraMdwYNPYtOGRkZESQ
	koE6DMvOP9Xy13+ocfK50gotnEfB6j5l06OwXU5XyNFMQb62avLJwUR5JkuEO49Yp7+DA661ElG
	JtzXToyq8z1MfrDz9DEz44TSOu2/K/MFS0Ahffpd9PJWW34bFt3SGPmwEk/bXdL4g7iMqrrcYpO
	Atr+7K02IrM5xNG1x1JbdEmImyn9v73pIjTXIxj1pepA4Kd7fiFTKzs/57lZi0hzKDuYZPeH/JS
	+hUDI0tw6Jcc0viirdf/I63NWdrGW3ukFEvl81Glqpt1jCrPuTf9r0rqPsv8X0g/OWLbSqlaXi9
	uAUYHwbqdHliyuPxk98MCLsEup5NpefLAyoZCtbCCLfgxm3CuhwLgt1BO6wKchpCXc2RyrXzKxA
	lpFNHF9AXdQfjnvhBOBny08JO4429vGSYLXmXTjXu1cbqjajLF+TcpEEbjQeU8eu0HLc87NT/w+
	1tK69El8UTUOmlvcYevZDWq2v83fAXt0wnkvQ2GlMce
X-Received: by 2002:a05:6512:ad6:b0:5b0:82d:e90e with SMTP id 2adb3069b0e04-5ba405f506emr805350e87.19.1790793566821;
        Wed, 30 Sep 2026 11:39:26 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:26 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 03/14] vxlan: report the drop reason of __iptunnel_pull_header()
Date: Wed, 30 Sep 2026 21:38:59 +0300
Message-ID: <20260930183910.3151873-4-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
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

