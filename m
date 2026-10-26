Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999481;
	b=L6Ebuq3jENLbCqY2OzI8TdMAH28ATYs9mRff74i4rgk7+5VS23aqLsZW9DGs7u3eHB5b
	 KuD+wzNkMOt7QuQgJHm4+IpGYembX/a4qsV3G4hVR6APuNoCO+iqWdn91i2cXhPjmZ+bn
	 6hsUizY4HeHyKGcZgeQgF9KXy+E1ubdkpvSNtmX3auY12v1yGrjMyG1EYlLQW1/id4vKa
	 DNLJONklxnf6b8lKK3g/8Vt2KGO9w5cfwabQ98+hVq+mvrFtp7QT0Bz3QmIyV3bCO1ULz
	 Lz0B1ylO9A7y68GCtbVknbgl15Pt+9+zNAD8BstZEX+TDQQvf5ori8/mUCuxiO/CkiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=UDszjkP3e6J/ldj/IovXua14w3FrBtTVVtfldVBDnUA=;
	b=Akvveqbz8or3C/FWXRFlAafRN666exeuN/iv9Mik/TfQTo+VOhbsI6tylHX/rcBBuTP7
	 QsH1D4ZPU3MAO5Tx237WnHlkGd7vDJpITveJUGR9am46JvVzwIyCUlimmOzXRA8lOgAFf
	 lMXYaZR9AR7w88ZUdfds6GU5rI/F5AGI+uZqim9TqSxPlYK4PDLUk5e343r6uMearZpmy
	 OBRBNVuEQAIOGQ86WZlGgGxV4ptUnH6FE8pQsFrntX70Olwv4VQpXkjf/xLwgxEew7WsU
	 tTjVEkUOl7LkO18vqKS5GmA7ze8GpGaGdqNrWwEbXRt/CuqXkwxmRRYxkaiiHQj4kSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=avNXL6TY;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27096606A323
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27096606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=avNXL6TY
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e985106c0cso22600115ad.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999479; x=1793604279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDszjkP3e6J/ldj/IovXua14w3FrBtTVVtfldVBDnUA=;
        b=avNXL6TY+rBzI1Wn2vgVg7teTpH9e8dgKMBOUIqtV407BaQ4QQL32MO7rbkwVFr21e
         rzAdGjabcTd91zciV2U9a1aCJUz6s0cm/qVVXLlbdaLGOnV/YSwbWi5ckmm9i/EZJBKj
         MF1KuYPwWnws+S8Kq9/y0d7WaUqIB4UT+sbsH5cGrLgRf3OMzHiJPJ8kLg1BTWnN4/KS
         Z0uCk3WxezZdhuPO83UDmgs1Y6x+16cak9DODPbynXjJFCgiPwi4jPZ28PxEZpu58YKu
         KjDtybBYWbNVWJG2QZroyiUrjCOPP+e3zR6HirfjXk6lfnaB6q0iggU2IX0QJ7oy7Mnw
         dS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999479; x=1793604279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDszjkP3e6J/ldj/IovXua14w3FrBtTVVtfldVBDnUA=;
        b=fA09bdXqYqUYLJmzrIMESfAWB8NMUAcTumo6x5/QBj/hmgwlCVo8xhts8nX647/Kzv
         YRtjhHF0uFCjX5c1g2ybAaMp9kKwvAtBHKI5th47/xq/8LK4Wyw9xfNKuT2d3zyMNQjy
         dWmFfnCszy4X3wPy8LOsaiHKA/kx7Rz36Nd8Jk1dSghHpAzO1eepHj33cMUUTk//DlU0
         34N2GA6K8Xv+1AuQjLUU7g/bPf9ucHb5ZxsF2+gFG5rRQoYQZLr2R0tBbzU91dzenXZR
         IuytDi4LNFSlN892ktIwbmkzZkG+LCzST1tqCK6G4o3obM7LP8AvCfuwSr/d9txjYbw3
         mAiA==
X-Gm-Message-State: AFq9FYJjGkbXTxMtj68ZZD0Grkf1PqTGA15n2eumzw/UoS9FgxEcu/Qk
	VvV23lsn4CJKOJr1X1xNJ9WhHexvDPSRJXIF5f/A0MDgRjy8tKi5r2pb
X-Gm-Gg: AYBFou2+cUY0SMD2iXH4OXGPS6ek5AjTneczv9tD5wnPT/jR204Pts2WeFDsGE1uwnL
	i4mvoif6mPOx/shQolAwfCZixxyodkvLSTDVWcLtiss0qr1+b0hgr1mKNild7lpXAxdz8FS7/mV
	h1eCO92SVpPtHjrrcxZMx2W74Rt/ahoSQ53JZl8Pos39FI0qTw2vAC6EUX1l3p/26ttTB4EZlma
	6TYV6fe2STlGqvlNpBXMuQQ5qlPwIU+1LZE8aXYF/aGkZaBhUZJB80Dp6XUITiRtSusIOdXjfKv
	PrC99djYn0tzorT+5o5y9M6CdCeuqBDgp1eu832NxBV+iW3paej5NC8O+w/gWjtNIRg7GdOI9xt
	ZJaDWBHd0pj7jbSDt9miBfQq5FKHykdeQFG9kyzhN/8NX+UTfmn2SCcfYcIekxCDLNyw2Z3x+h6
	uWrZJVQqeaWL5sMYxAiWVXg1ShAi21Opa91U9/IFlHDRIpfu/EbSgmdXJsgXSZcfnIfGsuu/NJo
	NQt1Bn4OFBg0GffZF2HHFG+rN74Mzacd9mx6bQELA1r/Z82cRRzFJFl5QbVvu11oGNK/yto5bwd
	+5XwH91lnRhaX/MPQcTQX1DryjCEcnMaH2MFem1a
X-Received: by 2002:a17:903:144f:b0:2e9:a16b:c251 with SMTP id d9443c01a7336-2ea9c03ed20mr54617845ad.3.1792999478994;
        Mon, 26 Oct 2026 00:24:38 -0700 (PDT)
Received: from 1137-patch.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1210f0sm12617335ad.25.2026.10.26.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:24:38 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: [PATCH net 1/1] nfc: llcp: fix use-after-free when purging local
Date: Mon, 26 Oct 2026 15:24:07 +0800
Message-ID: <1792999447.107874-1-xuyuqiabc@gmail.com>
In-Reply-To: <cover.1791171477.git.xuyuqiabc@gmail.com>
References: <cover.1791171477.git.xuyuqiabc@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.56.0

nfc_llcp_socket_purge() walks local->tx_queue with
skb_queue_walk_safe() and unlinks matching skbs. The walk does not
hold local->tx_queue.lock. tx_work, the LLCP send path, and other
purge or dequeue sites mutate that queue under the lock, so the
walker can follow an skb that another CPU has already freed. That
is a use-after-free and can corrupt the list.

Hold the queue lock across the walk, unlink with __skb_unlink(), and
free the detached skbs only after the lock is dropped.

Fixes: f31652a58bee ("NFC: Purge LLCP socket Tx queues when being disconnected")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 net/nfc/llcp_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf..500c65e2a90f 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -47,7 +47,9 @@ void nfc_llcp_socket_remote_param_init(struct nfc_llcp_sock *sock)
 static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local = sock->local;
+	struct sk_buff_head to_free;
 	struct sk_buff *s, *tmp;
+	unsigned long flags;
 
 	skb_queue_purge(&sock->tx_queue);
 	skb_queue_purge(&sock->tx_pending_queue);
@@ -55,14 +57,20 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 	if (local == NULL)
 		return;
 
+	__skb_queue_head_init(&to_free);
+
 	/* Search for local pending SKBs that are related to this socket */
+	spin_lock_irqsave(&local->tx_queue.lock, flags);
 	skb_queue_walk_safe(&local->tx_queue, s, tmp) {
 		if (s->sk != &sock->sk)
 			continue;
 
-		skb_unlink(s, &local->tx_queue);
-		kfree_skb(s);
+		__skb_unlink(s, &local->tx_queue);
+		__skb_queue_tail(&to_free, s);
 	}
+	spin_unlock_irqrestore(&local->tx_queue.lock, flags);
+
+	__skb_queue_purge(&to_free);
 }
 
 static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
-- 
2.56.0

