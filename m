Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D2386568
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599423; cv=none; b=ENpsB/s2FpiuyOdjgSGKe8h6vyQtbsV/tCIjQysoGMgOfZ5eyfTXHRp+Zxr6uuADow02Mjs/zDHmRUqHyi0pTPJmgt8lnorAUzfv7Nup8UxozhrggMJ5CPB+VrDzA8/EARVMnjPLYqWYdXEporIlycDFTEt1YMquguhzJZRfxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599423; c=relaxed/simple;
	bh=ONLdhr/Y4nYX7wFkQ8sXxf6B9vapCHPAGDs65Lf1O6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFnTQaRYaUaobUAieprkpH9BvjKDptsLuTmtPGbN/pDdyQXMf2Z47jC2SAV2eQzXe9UK9gvIDFzOPPT7MIkuK6iv9rbvdWhCuDeImak3fMSK51c+MqfGTrXoxC5zFepBy4m52zI7qZ72mL4yLM0GIQHd3r/sXZwEQ8N1OCm+DvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=LdbHomI8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="LdbHomI8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad617d5b80so29931495ad.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599421; x=1776204221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THgAywrnhldemc4bjm/czm0V3psmUXX0LHAppTDJAMk=;
        b=LdbHomI81dlBOweQG2TAPXazkivkug1ZppJIER0wdSn0o71XnJiV1aKxDxFjNwweAa
         PBfQsAi3bdiCuyiq8IGdpOmDyED88JmZk3pUaAX40QVvjoDXul/oB0dxWlKiBbZ0LaX/
         oCWLGtlKyQW8gZdxZlxPOMppd5sRme+FsxqZFAcJ0m3P+GefNfBg18lLTWt0PFPsJw2x
         H+CxHhLmkgL3tNqJe+pq0bDrlXG4R1BPh0HIStBMXj6SqO4BBPE51FxCzF93+En4Eus0
         1kkg+fHgTxL8LfmKQQdr7OxxqFSRVWa8PMq1aEcbLB+bRZ2jmMI0QOlqi9aJoHf1bOPv
         jZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599421; x=1776204221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THgAywrnhldemc4bjm/czm0V3psmUXX0LHAppTDJAMk=;
        b=hg8Z39xCQEk+PzvkHegxjkk+UoN5hprp0CVRXbuEoNLhrc6kHDGXCL2Loi43BnB7/r
         6IHpJ9SxEVfR/gJoiKI6LlPAGJ2bOHPxsVKWxVz/pimdYrt6JmMcgrFHQczLHFdisoIW
         wMIT1eqPJq2BALneZP2AoW18TIa4pkqosrbHQR083A/h1XXNfvcm+uBO19IibgwaGz3A
         v6KsCxcFZhMjwZR/sQLXbjlGPJyM/3N2BC62xyxPr+UfIR6xYEFuBhu+/LH749B/8WNA
         0YBarloWveyzeKndoqdye7Qs6bVKOp4InFX1YvP9moWJKfMVAMXdtZdq2Epp/4frJmPQ
         V6uA==
X-Gm-Message-State: AOJu0YxYracKhcT9Q+6kosPXzLoEiNDMvjLBONyfVlbSRc/cqzfEerLH
	pPwoaNP2l8KAaVI0C0HwzB7nu7aWrBvCrquOqQKcMZmcSYRQazaoGb7k0roqIP86fgtMmthpA5o
	SiD/ngEg=
X-Gm-Gg: AeBDievcD7OWAPEErXN96Bi3xWsyZbglMo0TPU8ULzD3cXX0eRMLqRMkd/3ILYcPEoz
	2jHK4seQpA0jZ/FxLAa69V6+Oz1CCM+OqHkRGrgIYc9EgXJKVJ6p/Ge63CIhT3+HZGG6tpERv4/
	lxGzkt8yzhBZiCmsug08D6ub7RvIVCEnjdakikRB4ezvXED7SSs4J13yWxWXLz/ICVLIOioMbB2
	rDMTIoFBzf9EFZYGal/QXpYMh4kipt3TPe259Ct9OpfE8SDcVrHJocPUHZi6Dk005C12TIrtk7w
	p3bl+s1NNQLCoKAtDCnSN0E0IJsQMHIgCJfEYxVEobeY2KKvgiYmIOVp85yjnMNJD5i0dXXYWse
	NAmyUqwoXQBP45Ja+f+FxM+m/7YQUOJY3Dsm4r8Tgb/rvLMH7tEmZdnYaKE5MZN85zqlBC1gwGe
	giQ9Fv
X-Received: by 2002:a17:903:b8d:b0:2ae:fc60:2650 with SMTP id d9443c01a7336-2b2817b24c3mr185205665ad.39.1775599420843;
        Tue, 07 Apr 2026 15:03:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274757fa7sm179153485ad.21.2026.04.07.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:40 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v9 09/10] net: bnxt: Dispatch to SW USO
Date: Tue,  7 Apr 2026 15:03:05 -0700
Message-ID: <20260407220313.3990909-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 73e692ae2253..68cad2951fe0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -508,6 +508,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 #endif
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
+		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
-- 
2.52.0

