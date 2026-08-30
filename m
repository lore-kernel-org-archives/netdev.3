Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7A391E78
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076705; cv=none; b=cU0OS65WxyCy2n6sLy5TexwNXrABRMF42arqrqDqXPoqicFOMZ/fpoihhsyoA0TW0EM3yINDR+lTNF2gGw11YGy8jLOZdF0Q1hL1S0SwpAnND6fPg9fy6J3OYetEL0toXRWX6UKbtt6R2Ci7PxrtnSgb3M9NjFz+DVky15UWh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076705; c=relaxed/simple;
	bh=jegzOw+EXJIP4W/35cQGumTCQXocudJkdz7vv0uyPE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goYKfgAZXnCS9SqZK6ZNFd5xoMrqhzevM5YIRMsI1ekhcGBx3YsZeAtmc5ivvhhnJVgxDnfEIlK2lGKm3Cvc3GmrvSURC7jUPouhTLrmPhFkCMkQabiBAK7Zm91jQiClUbr914hFmVGGZ6U7tGjtCw6wX4ScNeGy8OsQptRViCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIMGFTD3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIMGFTD3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso26022755e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788076696; x=1788681496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+j1AD6ZP4+NwsaE6HRfrB5G8mDdyvb/fqBpbDqu3VZE=;
        b=dIMGFTD34cL9Vp75CFV88Ji/ud6Q61woZTjg2Bh1TNJjNi7ef1uJWzbmNQy1TDX2aM
         yeK8qjhzkGiZZAuNS6xwGRmUe4kNbgKCL0FbhRTTm2vt8ZSWLnrXo92j/gy03NsPtT17
         GrUwmZmIUkczBgUU52rALxI3qa4QbaqK9K6zy7glSUgz5QMZwaXb1uI+vui44B27WzrS
         604b3ER5kPVzt5NGyOcZY73Pl6FfaXUTL+EMmy45RHIjD4MPVUzJaju34ozBTshwE17q
         zFtSfHbyhFlJUlWIMjUQ+8hahc8Vbl4A1K5a/RjQQcz/vwciaWgMbyqgtjtO+Wp38sTW
         ddsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788076696; x=1788681496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+j1AD6ZP4+NwsaE6HRfrB5G8mDdyvb/fqBpbDqu3VZE=;
        b=YCTMP9Y7Vyh+xFhY7zAU3zptWWSCEdzmXD5aCkwGNuGIruXtldmlP3vDZrRi35TZAa
         R9K44XRvj6t1r5aFApyRvpb6bw0511fvO2HJaNrikadKO/kZQpurDGMCQjAYZGmYyWUo
         q9CJPQWNMFR+K6SmnZev6ivM65jSMP9tWW4If1u/JmvPcTq2q/QvxoixEOffs5Fj96Ia
         kBozLfVgQdDPSVuo0sAWj4rOSZAG0Op3s7XYypJjcJ/irIiTrOnsyy1XdHGb0MUGmeee
         LHULJu+a3NXQWugsTmLpsdwGMZNLVChIpNBq6tOT77HZq3dgxoJnwi+h0OuAvf+6C2Ht
         7cPw==
X-Forwarded-Encrypted: i=1; AHgh+RoURWo+RsCDCNq4nHFTwkNXvXQWT6NJCLn6Dut8Mlb1zpfMDggsTypBZeBlvGiyDxkIgWsybLU=@vger.kernel.org
X-Gm-Message-State: AFuF++lr5egfXcWyof7g6elZDKB2XTS4l3qSKE03AOZipkLvu5TD3v36
	l1ohrlA+3U9j8WhwtwLWSCJGYEIjaICJ/0rDg0wTKyfGnzahkM4SrNg=
X-Gm-Gg: AR+sD13vk1Z9qiJdJVA4FeDi4ccU2oDcjHLE7aREUSr0d8pTR3AaGI/4+v78wv+YVTT
	vrncDIvxbl4STFW8irKwb8hHCIiD8pUZjay4nL9bK7PthbOUASIaoNFrcKe4efd4tDmCoINK3rD
	EAzXU4sPkv3f+o7g4UtjW50kABdEkN0jTL06i/GxNGJv+dy7812W2xC6xxJmMb5oHQiu3zpAfYQ
	JLyNB+t+GjX3rGyxSyxD87fuxkcnnDSsIfnaAQKOcWRoM21+6gNk/0NYD41omHmSLsOfJy8G0nS
	KGiLXwNUd55xfBTTjfXEXVwhOETKiNlUPVikLs53adteL/4LOWUOYaC6Ws0nl6suBS4h/wMq7uL
	iaKobmQtNdXT7gd3e3IZASmAoJdt9KRv3QB8oWi0MdhDDCNApiB/x4+2jMsGyXCfpwfNCrU1/Mi
	F41SXkthodICltVtwXBlBZ9pk7RuQMH+v18yB1szdTRClt8vgcLhg=
X-Received: by 2002:a05:600c:8b35:b0:499:7a19:408b with SMTP id 5b1f17b1804b1-49b91c3b71dmr267281245e9.11.1788076696142;
        Sun, 30 Aug 2026 00:58:16 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd53a4678sm14757875e9.13.2026.08.30.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:58:15 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net-next 4/4] net: airoha: grow RX ring 4 to 128 descriptors
Date: Sun, 30 Aug 2026 10:57:17 +0100
Message-ID: <20260830095717.37218-5-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830095717.37218-1-sochnev.v.74@gmail.com>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ring 4 is the shared "force to CPU" ring for a wide set of protocols
(BOOTP, PPPoE Discovery, PPP LCP/IPCP/CHAP/IPv6CP/PAP, ISAKMP, DHCPv6,
SIP, LLDP, ...) and currently falls into the 16-descriptor default in
RX_DSCP_NUM(), same as most other non-hashed rings. The hw completion
race recovered by airoha_qdma_rx_check_stall()/rx_recover_work() in
the previous commits appears strongly correlated with a ring going
from idle to receiving its first frame(s) - exactly the access pattern
this shared ring sees under protocol negotiation bursts. Give it the
same 128-descriptor allowance already used for rings 2/11/15, matching
the other rings that see bursty, non-hashed traffic, to reduce how
often that condition is hit in the first place.

Ring 4 and the VIP classification that forces these protocols onto it
are shared driver-wide, with no DT/hardware property distinguishing
one chip variant's ring 4 from another's, so this isn't scoped to
AN7583 specifically even though that's where the race was found and
reproduced. 24h+ stress runs forcing repeated PPPoE/DHCP renegotiation
on an AN7581 board, both with and without the two preceding fixes,
completed 570+ forced reconnect cycles each with no regressions from
the larger ring.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index d6591a779743..cd75c16d8d0c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -41,6 +41,7 @@
 #define TX_DSCP_NUM			1024
 #define RX_DSCP_NUM(_n)			\
 	((_n) ==  2 ? 128 :		\
+	 (_n) ==  4 ? 128 :		\
 	 (_n) == 11 ? 128 :		\
 	 (_n) == 15 ? 128 :		\
 	 (_n) ==  0 ? 1024 : 16)
-- 
2.55.0

