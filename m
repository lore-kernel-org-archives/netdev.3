Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513066;
	b=dPKVlcHWlmExBH6r8d8LvxOFkxa3GJg5xG/puqeL5S59MI12+Xd4/dgI4Z3N1NC5FehT
	 vKczRUV9etv8EKB8wKV2/lRDI2L2yxqLp/VSvO4R05nj7B1vsLSwIcrWD2oxZtsu4GhiY
	 gpg/L9h9mqZBk8RuZCWMBRM3lFHq33JmatqCdz9YxST5e2AEA4Z8ASxdizwB5drjXVeLk
	 pk4QqEkA66yXV/xyU8u1vXZY7dDYTRUayffZe3jOVj4TVew7pGYPkY+nh3rn6Vbm61hOx
	 XUCd5BqZmimgizLqzXUSVPYqNMuHdUyNqMWx8N7l3gjZIdlrc9g4ZH+XLtgJnS2DjPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4sBh+nBFEA5/3EJyXfrs1yFjXDyle7tyvTdRbgrvWnI=;
	b=3C6INMCPSQ1BPol3XZyonkI9KMQ6hBYcJoa8YlJlCFOjxnJ2T7zNDWUP6FjODHm5W7KI
	 1NSYhfcYyQDyeDVYX2wSqXmVa5pLAy2f4zwrbzJCOQTJWc3I9Nb6BTXNLX8ZtA6n7yvC9
	 JSuK9EDI8B43x2UYdbflseJg3hyN/7PlMtI/eGdrH35y2T5OBI3DM6TTSZOuiQjVJwT/q
	 86YeMzN8X0Qoeeehd4G2BePUFDQiA2DzY08qEtINtCv/bqEOsAkUcVFmewnNyK/zybag7
	 QLtBTMwxe32byBV7Mmd6KlBBkcGFJ7c3SlRl8NF6wbFlLYEwQOgAOI7Yu7ePkIPQXFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdjresWc;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530560A2600
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2530560A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdjresWc
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c506094fd93so8231366b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513065; x=1795117865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sBh+nBFEA5/3EJyXfrs1yFjXDyle7tyvTdRbgrvWnI=;
        b=UdjresWcXLe7Q+ZgY7lDKfKfmMNVkus+3Uz5gVauAKT4odes5eUDTd8KnjdSeTStHZ
         g5iiyw0biPXWG4F8kYC6+eMaL94Or+l3CPzoOKIGFTOQPa/IthMQk1MFw3bkn6ulgYUj
         NlIdHe3Ahqwqi7xKMyPVGh8g4ic0wytR76ZhNhS1jLpMIL+4dx/oYtmaC05MzGXX5qg8
         OHPMc0VY6R3Udl0DiYGHkWnrldEwahy+xt8tuKW7j7Kl/Cx7sFc3oteUu0WsitS4fhn3
         KJhcPbV4A6xw6jh6Wbyz+m7w7LxURT4j+dNgPm4IT2w76nLeSxlXbxjGnxXBy0/e6Suq
         n03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513065; x=1795117865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4sBh+nBFEA5/3EJyXfrs1yFjXDyle7tyvTdRbgrvWnI=;
        b=TFnADAYaatrhtsMbSZaIFIr9bxa4gM15SkP+40GlHQ3kRR4A2wifmlsFlXzef4zAJe
         Em5gVEss6A9+jmeInoFor47qJQ90Zl+Si41fw2A9IBRtIxY8loY3k5eNmHxSqd8+SFEE
         +ve4H3FyKG6QLFdZ4d98fz+hQuPC8pR9d7jNqwRQmCA0+n+nQG5W2GimLsmMbaxmXSf5
         dK5nDKfIRmBYYEU1Tj3uVtlQkWbJgO3fpp4oTfcrV7yLXwMyJVFKSh3y0lNfsrDp9EeU
         9Rbihh5YDfcjNKV/LLccGiucRNBQ26Ac6Y2qIHw0vv8MgAhX3zZfIFG35OenQluDicLB
         +sOg==
X-Gm-Message-State: APuU4Z9ZCJDvi+NNFeH2cbhqa5DyLHheYq1Ia5gl0etDoeSoIIqe+7m5
	bNLG3oCG87FuPkM5gEMd7Zilwo1SgZ4Ve0QzSAfIyUSJlBOdHlgqqaWA/ap6M8b2
X-Gm-Gg: AYBFou03XXQX7HsZfonYyfhDl7KZM09YKKyTtuInXI+k0DNAKRe/O0uJqwkMjSOUoKC
	HWTpbUPQZyzqjqOdPDKjHNC/CGEphTrtvOU3rmkldnnXhRt/bX3EPJM7eC5l6Dk0jE1N2lpu1tJ
	X4V12mbh9+WG+HBlaFrbkmiUIfbppXYi+p9LnReah9Ri6WhJjFnrHrmcpk+L/MO27pQ6LE95lZX
	aztWQefJbjxzHC9FAW5bZBpP8Yq1NHFDzGCf4qR9AGkvfsviex12UPt1ZvhKa2Q0Nwrp4OqcSUS
	AlmrHinQAe0Te2fkRFAXKIfxN8QNj8HOvbhjqnrJBKI42qqar/ikz49DMK4+TGvJHjC1hgq5QsQ
	W1slbbT3x5E291slHVYMiPxpzNK9heH8/RxxRo6fnadRHHxabkTV0ZDlpt9n7DQFmE7RZoIQG6u
	mh8AqXgJ9yiItHlDl5bqS5n6WHcNK003MIAlL80DA9rsNPgHqUMEnrTjgNWW8c0UdI0EJzRxub7
	rKjeIsx3u+/TN7clhVnDfgJ+hHerqWCavBAhj4ZTBzz+dzE5G8ir8InNhjpbmuHgY0X7r9bAtAS
	RFYJDmShFqMdZINAFyE4Cp7ULEOKzQEDP5iNga0U
X-Received: by 2002:a17:907:8690:b0:c40:9b75:84af with SMTP id a640c23a62f3a-c5096327497mr29012366b.8.1794513064371;
        Thu, 12 Nov 2026 11:51:04 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:03 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/6] net: bcm4908_enet: unmap the buffer of a dropped RX frame
Date: Thu, 12 Nov 2026 20:50:49 +0100
Message-ID: <20261112195051.597102-5-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112195051.597102-1-kudzo51@gmail.com>
References: <20261112195051.597102-1-kudzo51@gmail.com>
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

When poll_rx() drops a frame (too short, or not in a single buffer),
it frees the buffer without unmapping it first, so the memory goes
back to the page allocator while still mapped for the device. Unmap it
as the path for good frames does.

Found by reading the code.

Fixes: 4dc7f09b8bec ("net: broadcom: bcm4908_enet: fix RX path possible mem leak")
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index a28adef03..7f80e4e24 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -658,6 +658,8 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 
 		if (len < ETH_ZLEN ||
 		    (ctl & (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) != (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) {
+			dma_unmap_single(dev, slot.dma_addr,
+					 ENET_RX_BUF_DMA_SIZE, DMA_FROM_DEVICE);
 			skb_free_frag(slot.buf);
 			enet->netdev->stats.rx_dropped++;
 			break;
-- 
2.56.0

