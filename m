Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639608;
	b=vuxBPb+fpTGp3xZV1n4TAO/RRppd3ox4OV/01yboSYbi+6PgrRIrxHlihtGjyHVx17Kd
	 q9vbLw8LHLVfjyCMCspw2FoneYotfqCe4dcQ4Ya2KYzPGuN7Lk0CMntEv4goAbRSBAKAo
	 QAx8q+Mors1n5JzqsrgKRs5Xf47nW4+4iKIs+WHztRvODoYjz1HN4IOaPVVTgGUISILP3
	 ASyZGUIYKroDcF5DytDz6sMl8JMeOhvlcEs0w9wsEMldCe9tmxsG8K8h6PFWru4BUY4gq
	 noHyA6pspmCVf6DXaMwIeKngYHSXSO9AAHSJr4V7ZK/bRaz0IzcYXAa4R6lpF7+VWjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=RTU0GqXO0v09/wvq3q/okf4+AOCgqZ21ovd0A51lLqA=;
	b=dICJW1TB5XWVzZ0XjOuXy6MYDSXT0CYad/4zKBuOKi515csoqUQdj8Op5djU8LpSAecw
	 NTtKT3jBFeRH93i8nEttHk1RSvdCwA/B6+6fYVRoG7yeSQ59eZlhB7IMqm/4XDBdgmJ0G
	 gblbIY6ejr+EwIeotgEj7TpqsZ/5sC2fRATrpHsug4VcaLaW5owprzJqUVJ0ozuLOIiro
	 oAMbSrzB+VSWKZ8dR5y/JGHt8FwrVUFSnRCYDyq53PEdYSbO57aQlqeSK7osyY08ab9dW
	 p6u4C4+2bsa8rRnP4HG2rn2pJ6Uqw6YV0DOVzYUokqPQF1gPbkWlfEAZ46QEpqc9Zsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rWuQvC8M;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B2606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C2B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rWuQvC8M
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9400d26b5so1808475ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792639607; x=1793244407; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RTU0GqXO0v09/wvq3q/okf4+AOCgqZ21ovd0A51lLqA=;
        b=rWuQvC8M3vbhWL0gwShgWn64eK6HHwV7WO4raPHOcTNpPtHBSzlm8HZ7eaHZIGpKg9
         N+cv+LdHK0Are1PSv5VLBPTCuV4qTpg7k0NHKFj+3swK89uNg8KuCObV937eNoAh5dEa
         725mp7Ow03ThF6dI3YCxyGflDwVXh0+DTQi2sil4v00m/lwpfaLyiZhyhq2VshS41yP1
         laJE/1MMNkqRzqFgJ5FtL5X5dqjWzqUUACxjppjPjhZmTjoJdbESvHj09QkIbIUk5fTg
         jwIINxeJkwZXsBFAKzWbFDWOQ/+OMwniorKciuU/vMPMoS866NswpFzTuErYmwyhapur
         c4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792639607; x=1793244407;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTU0GqXO0v09/wvq3q/okf4+AOCgqZ21ovd0A51lLqA=;
        b=vPstcyXap/qge2DXsEsKLS4GJlo/+T/5MvEOGBsraCD9kQ2dbJUATbTHv96yFdH746
         eSPpdCN0hbqyjmuiDALSpvkHTPqoTYih3V7508c2HODLjpsF6BkT48A+PkByd+6Z8u91
         kTd3LXgscmIz/5GbGrj9YrqLUuvHgzNmVEjor6Mvi7XELHvmIxDOgQds2uvqkv4d3MaT
         TglGrodZUuPCbTooi+Myi0PpN7Ap0J7Ui1Py9btPN5mzyxjlaKZKSXGLZCpxRVSUwAkV
         1wJvK2gY0kv7Agx6KMwm46wPFhtmywUiorbaD7Qg0VHpodO4IXDEsQd/xWO7rvCaegH8
         18nQ==
X-Gm-Message-State: AFq9FYKIdRN/xzkkUQI1WGApaIYtKn2eQfMq3+OB3ip92sfGrbhLiB/S
	6WIOxxSMLPFLMnXr8rSV863lVGUrmH4o+/ibYnCsPPXYk9T8fbyvilFp
X-Gm-Gg: AYBFou2eyalkb0ZRtrTxjTfgR6LAVo4CKrRJn7gwOQ7Svhk8QU9c3Txb3OvaSnoRNY/
	S8nbfeCiWOJiPv2oKeaP7GmuOSViHmMrnnKurSKO8QUhEirM193xayDh3rXlMuz6o1UDfaCo4Xp
	VEeimb0jqjVlWc1Sytr5Z7jDzTTH8oou4amAnfXHvp+edzNHAWntQEGOFbG4f3XxJvLWxd7fCID
	N8JzJIxXEs0RTdrEJwGI8/tRvHOSnxuFRBT1HUKHhMyqzwN2EdYDfzcbfi7uh4w69BKr3qGjWo+
	wfx4RMI016IFpx1f703gh7KO5MiChsiSZm86EdTH/Rfj5W//ofU4ef6WRhlDy/DBOehdy8ZhceV
	lVe/2SKc1KN4nBEJxmNEtgCTpcwKzxVzigi5nqdhfGYcYgu5d10W0z+uLGomMd17gtEmbo6rB0g
	b79vFOpJdddpN5ElGwcw2eLTWpA70eoaB3zKbYQYsdj0aqHzJAoE722pYwWp2CqfT9JpD+gSlBK
	0vQR71mqMI1g2Vps+RCorggRuKgzrSRysYagd1bxOcQKM6CqJgB26gEEM0Ryt8IEA90A48IS+7+
	+Rwp7vBluLsRCQLJPYKXJg==
X-Received: by 2002:a17:90b:3a50:b0:3a8:1759:2217 with SMTP id 98e67ed59e1d1-3ad86dc96d7mr5811919a91.2.1792639606844;
        Wed, 21 Oct 2026 20:26:46 -0700 (PDT)
Received: from msg ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bb6f1sm2001732a91.14.2026.10.21.20.26.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 20:26:46 -0700 (PDT)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261022032129.16118-2-q.h.hack.winter@gmail.com>
In-Reply-To: <20261022032129.16118-1-q.h.hack.winter@gmail.com>
References: <20261022032129.16118-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 14 Oct 2026 21:17:00 +0800
Subject: [PATCH net v6 1/3] xfrm: run the receive callback before dropping the
 skb->dev reference
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The drop path in xfrm_input() releases the skb->dev reference that is
held across an async resumption before it runs the receive callbacks.
The callbacks may still dereference skb->dev, xfrmi_rcv_cb() reads
skb->dev->ifindex, so they can race a concurrent teardown of the
device.  Run the callbacks first and drop the reference afterwards,
like the success path does.

The early drop for a state that is no longer valid releases the
reference on its own; let the drop label handle that reference too.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5ed87d51392a..94de4f698c33 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -496,7 +496,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(dev);
+				async = 1;
 			goto drop;
 		}
 
@@ -779,9 +779,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)


