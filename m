Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434493;
	b=S0chKmgm3ZrGPbl+BwUO7n5+yA8ZAdJRJDScIz2BcVgqBeZXu+KVMUudbb/aSjhpEcNL
	 jrSa1R9vdV1cOUIyqiUnOXgPnwN3ECndWOnFyM6qbd+ZBW8gRfxutXu+jAszmu8mXPNNx
	 1AkHG4pHzgpxhcS0TDsOC/SmeZt4DUfJwMb/5MzEU+tjCFWSKCrmD+X1te/LQmxGyoy3e
	 Ssf0OcPhy2mNYkFrONgFCSNPCYyNvt5H+bTELH+Fr524aJPDBr0gCPUVYqPLI8rs3+nmv
	 BAevnfdLdctQz7M2HPZw/GP3Eii6t446VdyAGObeToZD9EhZ8YoQb7fVXfguW47DF/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8qP2bK3GbwJQduHJIewrlWs9VNQJnAZ8VpGGRTyoXN4=;
	b=ENGtVXI3i5fbgA+D93RRRavSMxbiRs6lGrhzzupF1cjq9Lx9TB3JFy99CKOezOjx63XK
	 gKaol2HEJW+tXJNHaspNC53KYVwkf/H94h1aGC+ZUus6Aa4eKiYxeNRJTvUnYqfXtxsJl
	 doQnMYLS4exNn2yIiM+1Pj6sHJzu9fVADeGSBDKa/YWufnWTCVw2YgJ+LGaWT6jVp0Blz
	 FZUfZRVUwQI/uhyBML6gNtOmD7TYKYdbcPjsivCB//UHnWMs0H1lOOOexxmRBHj7VSxLO
	 8YfiE9eIymcKdwEqC+Vbg3n2ANTNJu5M6vfzXkMpZThFw9XwWbKsEITrJLvOS3CXImw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqKGOAVW;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9C606A89B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E9C606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqKGOAVW
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so1980126241.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434492; x=1795039292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qP2bK3GbwJQduHJIewrlWs9VNQJnAZ8VpGGRTyoXN4=;
        b=nqKGOAVWt/myjDKGoj1Da/idlljIDawXIfbtDS6uOnQFe1p99qk7eIVc2/57rsYIrQ
         9KdXan6GkBY8We+aLPDRrzAYsJkZ0Hn4VAJB4bBSxUkFsP2YKx8sb32Vua6uOEoWm4Ea
         6OT1Y8CGIZGJ0ZQ2hf8OCdN6Wcl2bKb9psa3yZ/jeoRSpfafW9fJ+NrWiL9ueSx2+6QT
         FoqP+JwlHpPYmCcnqb5VfKkumTE46Ce8aLkd7MfRYqOCiXfSTYCwmb4gIKL+TBC54mgQ
         CwXUp0zeDq4uT12DubmRye3vThR3vba6UhGWMSkaNzHO6tjXeYc51KB7gzm1l3XrU+J9
         GLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434492; x=1795039292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qP2bK3GbwJQduHJIewrlWs9VNQJnAZ8VpGGRTyoXN4=;
        b=wYnr/1D4kZfb5j9vVJKEr2ywebldKp+9iLEuWt61JNgNQTk3ueQY2QMftxW8rzLNK1
         C4a/9Dl32eRKA12K0nteFyXZjXWnXroVxAO3MvaEcQ7YbNHGBP7fJVPRXhxgV2C/QScE
         I7YggmGM/jOE8Y+8fYSwLLpPAJO9JFhvpweCipr+H/MaJsOnkUNqV9KpRyWYY9CukLNM
         jlptNyV/xusSUgrxrJ380VrvtQb9i4a9U1k+ZokmVrFl9DTa6aVFySTQSDvNiyZo4UWa
         v0Y5Uh4EXCClcmHos3IaXFBmt7pELESnEQHbI/LI818RYBnfKz/9jrkA5RjEOSBIQnTA
         faCw==
X-Gm-Message-State: APuU4Z+rjoQhNhWDhT0+3YHWaOYUdRTInLbWosV4F95F2q/HivT75oz0
	tax4EoYS1jmKuwtlIQ2YaNOQt0JDnBB7xbD5m4P5/xDNXRvCs6RHarZ7KR/Yb2a9AlA/
X-Gm-Gg: AYBFou1REN2SglbAXcKuuZYa7E2fpeM2ZYfjgPrgsmrDobjOrgjBXrdk/ZEwFXnCaNw
	Oww3m6jN7J4c+C2+tI/2b2326ATQx95F0y6fU5g8KGWfO1EJ+MInIzLC3syK6/hmd46oAFhPUgG
	FEqBnzKX2j+TGd+jWwKOwoemMAPy6bOyJv2AvUlBvB6HmeLYkJHXQ+ttHCUOsGw1pLzTDs5IWaG
	JQl+kI8+qnYAG+rLaERlNmtDQeet2hpujXyi/qARwIKi+sNFxWV3SqUG0Yc1TbAbOe6tQIeGft9
	DzThB/0UmdCbehDTJ/6evUV5VYOcoLl4YkjsZULpKKZxeiexipIrq5Uz/jh0nOUiLtQVu9LIGPM
	PDiFYcjcj5y2ief4zm0CmTW9YOm0ZyCBvvLLydWRzSuVnoZO5b2Ns6QexAumcMFF4jS5bI+5k1n
	NHTEB4xZesWP4n16KyLFDEW6m0FcYmyJ0NXiBiyV0UGb5GBOwO0455vY9KfLYGrG8S/Zf/K7e4h
	O+Hv/Fdr7Qtm5dyBH7nnAyXmbWYaIfG77W6nqCQ2owEQHzsinVWhOQK86ofE6o475eWRw8zHAS8
	Gz2V/r+4iylG52GMtYDn0qD/kkiS
X-Received: by 2002:a05:6102:14a3:b0:7cb:70ed:ff90 with SMTP id ada2fe7eead31-7d5061cf252mr1699656137.26.1794434492280;
        Wed, 11 Nov 2026 14:01:32 -0800 (PST)
Received: from Ixchel.lan ([70.49.63.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm4557992241.4.2026.11.11.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:32 -0800 (PST)
From: Vlad Banea <montrealtango@gmail.com>
To: netdev@vger.kernel.org
Cc: hkallweit1@gmail.com,
	javen_xu@realsil.com.cn,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 1/5] r8169: recheck the TX descriptor after a vector-map interrupt
Date: Wed, 11 Nov 2026 17:01:10 -0500
Message-ID: <20261111220114.3863505-2-montrealtango@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220114.3863505-1-montrealtango@gmail.com>
References: <20261111220114.3863505-1-montrealtango@gmail.com>
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

With the vector-map interrupt model the TX interrupt can arrive before
the descriptor write-back is visible. rtl_tx() then stops at a
descriptor that still looks owned, and the end of a burst stays
unreaped. Once the BQL limit drops below the stranded bytes, the queue
stops and the watchdog resets the chip.

The legacy handler reads the interrupt status register before the poll
runs; the vector-map handler only writes registers. Do as Realtek's
driver does: if the first pending descriptor still looks owned, read a
register and look again.

Fixes: 677f8f8c4c5f ("r8169: add support for new interrupt mapping")
Signed-off-by: Vlad Banea <montrealtango@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cd4ebc654dd0..6bd137358d1f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5228,6 +5228,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		   int budget)
 {
 	unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
+	bool recheck = tp->irq_nvecs > 1;
 	struct sk_buff *skb;
 
 	dirty_tx = tp->dirty_tx;
@@ -5237,8 +5238,19 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		u32 status;
 
 		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
-		if (status & DescOwn)
-			break;
+		if (status & DescOwn) {
+			/* The vector-map TX interrupt can arrive before the
+			 * descriptor write-back is visible. Read a register and
+			 * look again, as Realtek's driver does.
+			 */
+			if (!recheck)
+				break;
+			recheck = false;
+			RTL_R8(tp, IMR_CLEAR_VEC_MAP_REG);
+			status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
+			if (status & DescOwn)
+				break;
+		}
 
 		skb = tp->tx_skb[entry].skb;
 		rtl8169_unmap_tx_skb(tp, entry);
-- 
2.53.0

