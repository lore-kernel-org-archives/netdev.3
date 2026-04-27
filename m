Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17C26CE05
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282598; cv=none; b=jNoheU6gVmnAMWNu10YPmKHLK6lWrbm7s9rSYQGvRDp8X6/AvnXqW4zFiUzafMW9c/GMEQb2mrEvZR8/7AUeGY7cx2TkCvrPvAlzDRMIMm0ynY+DVfxdbOc6vZBkjOSwayfPfZ7xoM/wz0jcNsml0dsXREjsFmJnfOvBmy5AY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282598; c=relaxed/simple;
	bh=F8Bv+5WXV2kI+LpHXF6w+smjvUtaDDO/g+Ir6e3MAhQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CGcCVLZK0VjCGV4xm5+mc+nW9GAbhfBCrhz7U/h4j3BEACjZFITteg2bq9pzTfr0WadbHOoISFD97ZJqdst5/0hHZ16xyojMnToUmkKAZyNEXfDbKmf2Hl+cPNV4AiwUFrBYXcquxcxqjUedzG6k+bIYNX4od4ySztBG2WyXzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuriooSs; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuriooSs"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so176999101cf.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777282596; x=1777887396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3BCpQyGC542SKFUih1tRe3mSFZl6FqftJtzrL2ByEqc=;
        b=DuriooSsSz2uTYQONpgaUv7NAQ6q1zHulJPO5/FUW/abPI4e4DtQgKJioP4S5NKSet
         DBOff8PEfTcjeZqM4hg3oCElnAz+tFB5+TBDo1EqDoTgx/s9HTbzGpsMYMKwX0+ct6B+
         tEEfOg6T1sOI477d8p/UZzDfLTLaa58fw84qZfEKDSOgho9QTPGgltU9rZRmUi0lZytJ
         KDM+JS9lc/le+ZwPJJYljuzKvjUlg2p1Ud44hee+6/mANEq6wRxvwg2dhCCov6oCOuf6
         TgnShB9TnVl77BZGNFOouXZ9baknHu9jC9ud85USyFPCavUEmcCyh+99gxwH8ONQiaxF
         pTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282596; x=1777887396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BCpQyGC542SKFUih1tRe3mSFZl6FqftJtzrL2ByEqc=;
        b=Ht22SrJTr/7eiW8AJ4uHQxtOgxEGvMfsF1oC9xrKL4hRuPXuK40oK5rRJTyL/RiJZQ
         Z9MLOv0XMgfUYED8o0TlmvIaz6fUPjFBbIRkBbIB8MIV3kSsdz3iOPGR/0wBvMNvoKlm
         uaFPcbi8dYDcRL+PmHnPbTc1unYZ1YdOziftbUytoq/hwquiS4gCgtzUi7yf8aIKh4Tw
         Gn4kdM7gnqrW/Y4kEO1L9wqw2Jzlqzo7shLjrollVLh3imAY7vUSbR5iJg9ncp8n4aHA
         5/IRPNicuMuUMFsgaPakhss4zF8KYVo5N32p9bOEfxem/7PnXZAOZI0wNKvZqOZg2LNh
         /FOg==
X-Forwarded-Encrypted: i=1; AFNElJ+oAIytP7Vf/np5NkdMIlAYaR4ExTsDXVFtoPmXItEoPyY8len47FD/qRljD6DGNz6jc6aRcsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4QUj81bfA5sD2g2s9r1xBwDae7qnUsHKe13ms9DGsI9kc6JM
	wSyxXqfUMNm7Z3lwJEC467febepm4Mrg/jWsJy0RFhCmNzPIIWOw50G2rJO1wcsElO+ssVNf1ZK
	8FTV5dhfbhrugkg==
X-Received: from qtrj19.prod.google.com ([2002:ac8:74d3:0:b0:50e:6306:12d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2615:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-50e36c122efmr620258881cf.38.1777282596218;
 Mon, 27 Apr 2026 02:36:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:36:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427093633.979310-1-edumazet@google.com>
Subject: [PATCH net-next] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipvlan_process_multicast() runs from process context, there is no
risk of stack overflow if we call netif_receive_skb() instead
of netif_rx().

This avoids some overhead adding/removing skbs to/from a per-cpu
backlog and raising/processing NET_RX softirqs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 1be8620ad3971d281fb36fd0770efd67b566ae60..7ad12dc7845c836bdd04395f153b2b4b397797d6 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -286,7 +286,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 				if (tx_pkt)
 					ret = dev_forward_skb(ipvlan->dev, nskb);
 				else
-					ret = netif_rx(nskb);
+					ret = netif_receive_skb(nskb);
 			}
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
 			local_bh_enable();
-- 
2.54.0.545.g6539524ca2-goog

