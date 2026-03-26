Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA865316189
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569178; cv=none; b=MBF/FPoFD41zl2vU9WaELphPnUfy165uWnuJNcZU9AExirtkjYvBz2jEPWJDJYGw2hwfi2i7MtU+El6K3NM/KjK33O/oC+oqdktzk6eqiDF327K1GeTFNTmME3PrlKQmfld/VKXRWfw4e2HMlbXfjeUX9RKHd2KmpKlWDPQGwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569178; c=relaxed/simple;
	bh=PObDd+bQYo7v1Saf6REGaI4JZQgWug4Wiiec8tmVByw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIAQzcKbOdkbzHwVLa6w+8iZArOUmGN1ObVweYgo+hrpvt5wCqOLX5/Oi0tVFc6jnSGAgW8vqOdjm1Ngx3UKlYS0OE2ZSFxU734LsmRwV9Wh7fzF45ew7ZGsInuqCNkBUKfLq18Exw/xG3yctJDyZnEN1eJiSt+BQZEWgGO9OpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=KOJ9Q/pC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="KOJ9Q/pC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8299f1ca894so788246b3a.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569175; x=1775173975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eSWMreP00fEku+GXIEh5WPYlQQ7pdeSpk3DZrhNvfk=;
        b=KOJ9Q/pC6KG9lk0BV8nI9jmZGVJE352zZtYWJ5iDayo8cxIR/iD1Pddg41ehVDmled
         KqAW8Va8wUbWGdxNp4Zu190ZIQPVrIRuv9ULf0wMYIHPZSDTV7fJUHjpqFsMytlKTD8b
         AntwlEQTFM4g6lUnQagwSZtoVb6wo0h/4ffh3lH189cL1sh6tdAjVDlDlhQ7TbrqtVTH
         DV8i9CE9sIyAcbkWRb5JMxge0mwoC3yjugVNAjRd1YSJ7L3zrosoc5PQ1FGpDZx+a2hi
         0Mbgd5zPOdWYb+zXyzvDBevhCMg68OlujCyKnUdC2g6FWKVJe6Y8xkJc+oZN9XlYllc6
         WG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569175; x=1775173975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eSWMreP00fEku+GXIEh5WPYlQQ7pdeSpk3DZrhNvfk=;
        b=I+kjtvd7I/j0pJWwz5876A6064srf4aAR24V65h2T9fmN/bJxKQ8ZyOwTNjZjmj4vU
         78K/n1gZEP50yfxjJ0XUJSihVpPLu0Mm2x0xgD91ghvNYhtF1hzN2gDIAM3MhwZo5eM3
         6nYBV8+oFWCVegMVW88oJorazwFXNj/H6UByXnjFiW6GNbq5G77mxmW68KDJRTcJn6D1
         WSGwKdOZZvntbT3nBaSGPmrTziKq455NKfkUck8akK4aeggrOb5QJ4USLrR6f1NhHzeo
         TqyChq9DzhvNCAtqxgRedP0TElm6iWmY+0qlBcNOueljzSUdBubScwfEQua3sPhANP9s
         8Tmw==
X-Gm-Message-State: AOJu0YzzQQycIVXxQp+l8rQoVads3yOcqR4epcX3Ph3Pb4zORN/LYE4/
	seh1hVkXPBp/cGbDYNARFto1WuGnKGDIjqX9sfcSn5dQ5JlkVUvPZ+cCrV+DGJgasjcejMcnh92
	J8f7S
X-Gm-Gg: ATEYQzx/C02kNFoG27nqrIeiR2jOSuLr+GyAMc+whc96tFvKnBz/Bl08BAiOi26lKfI
	ssRIJsIRL78eXIySi3wyA3CFQuueuBnw9Sab6QgHToremqeddf7rpg2Ctd2ka7/cf8QvcP0tEYi
	5U1pEqh6h8nx9ZRD79lRaQLzeyh5iXniiXO0PMxtcK2eANqI2kmo+pQCK+l/Fm02D2ld93JLz3+
	wMk/wjuRdMuOzyeJ8X314Ka6/ThfcfPbPFVUF8hB2NClfraPAr1mKaji/Wy92/9eIRsUjH0TYvQ
	1225hbqmZqXoBotzpJ2OykoGtpcHsCsK2eke/WXsx2Hkgyol4+i1HDvT8doKf9RP4xuYx/BW2QZ
	GbJ0JGU5EdXZYMEk6VAQipJQN6+ErgP1FsnmyshEaIPENQKOuYqP0ct3vubPdFfwvvEw3HzSu1Z
	ySEF8=
X-Received: by 2002:a05:6a00:3cc6:b0:829:9f46:280d with SMTP id d2e1a72fcca58-82c95d42bfemr376957b3a.1.1774569175505;
        Thu, 26 Mar 2026 16:52:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3894d0sm4758396b3a.30.2026.03.26.16.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:52:55 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 03/12] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Thu, 26 Mar 2026 16:52:22 -0700
Message-ID: <20260326235238.2940471-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 84eb53b4172b..dcc83ccc3bb0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -447,7 +447,7 @@ const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
 };
 
-static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dd0f6743acf5..d82b0899b33d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2950,6 +2950,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0

