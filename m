Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352409;
	b=YAegsptVpsFB4N0EjD819Wua7Sdcx4BEeBQr631Vy5HA23UwlTIuFz5or+Hrm/7eLhR7
	 qqBR8pQNAxrkVriRzBxD+NH4/Kc/HG60IC8IBTLiaeQvXkbSkmGb+Fhiye0lav2Z5Jcmt
	 p8ErlCPK0YFlPQ4+p2ZbNW2SC5OLBVvBU3apmYwu/BYFOobvNdhXICYNq4pUUiD0Py9Gk
	 VTT5K9ZAEfA27xrJ3V3W7eLYmki4obAr3s7iWHpuEgU/+3i1L9Wybi0WbjGtC82iDYzpy
	 Zm/aBpJCEx+zrzkMxYl7/NK65dIuyFQsqlFahepl/i5qJNLASYgvdvhUBjbfC8PhjJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O1zdEmSlr6e17xANOXeUw7jgKI8hal4IZfaLSwVHO/Y=;
	b=Dfh0L0gnfk65+0oQV/64eQqJWlTotP57ef33m8e70aQNmq8U+tpTvPVRrMYqHYU+4VFh
	 g8cgPVrB/LNp8IG9Nog5XTqS26h0meF5Uu3miKdKNntaX/iyYGKQ9edWL6lbJHYpPgWDa
	 gVkyMtbXk45fHhH0Ln6b4IrlUxcba3hJjKJsUlv+EoztwuqLixoc9zyeT4tLl3duQsNj9
	 mg3YuvbkeHg/8mvNrpxtMcL9XLes/zYj59UqcwXPuMhrFVamdy5QJtEY9c2RXyOxaJ2ix
	 qrKkVqe3Di5H2exEuxrjDmaUOh1jY74uehbyf3+6m2eYvd7FlskRReaI/ZvkHDweVJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WUrW97WJ;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6B60A2606
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B6B60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WUrW97WJ
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so1514743b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352408; x=1794957208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O1zdEmSlr6e17xANOXeUw7jgKI8hal4IZfaLSwVHO/Y=;
        b=WUrW97WJPkkiDyaPWBt/Yf86zlfQv6juXMNpHIHZOhnwO4n4cNdZ+rK8h+FAesSqPe
         wRKPVqoPPK51UhGdI1UDJti3+62RmC8UhKVhGWrZabQ9YxO2gHglKNDgQE7fmzsXN03d
         VndWLWwHM09scELUwC2ghDDVqkUR3Futp6OVXvZaNTTqLtJ0Dq6VHMcaZRP0/fUhKmSw
         2kBVtF6qDId2RQqe5g7v5k+XNurLhy/dI4ynNKAIki0DjV0JxZ6jIZdZoJvMzC20kpvj
         8sFOEX85P/Gu7KtP9/mY1NQ2aXlSeg+8LFbsM0IakzpH+jQpc9vwc/zz5Hq2rp9+PoB2
         EscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352408; x=1794957208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O1zdEmSlr6e17xANOXeUw7jgKI8hal4IZfaLSwVHO/Y=;
        b=pVc0h4N5mH3kj9EQvewabBkNmQUWLhYVJZgkt8kUCnnKzOEvGU3CHdlADrEkBZ0G+N
         x0wtSCAsU8dhOQJtHLjbMnDQ+fJJkbUuNLK2oC6+jPaa4sNTI7zZjXwb/PGVJE6QYHrI
         xKEIjeM8WSOOWELEhHE3x8LduFph/3yGlBO3YlfkKzf6K/sR5tOu2c4K393+g3rg5XvH
         6E/moOrwtO1ThRDbit/7WYqnWWHhdfhd5qbKy/YXtBFyfYbLOHCpnVfaWUbSxsTtKo01
         ZmRybHnS2OlReYMCt/x6KpulIx1fR8P1redQN2dJyx4LpTpS/8y+EK8WrothwVsVwBTI
         eFGA==
X-Gm-Message-State: APuU4Z9z6XRr8pdbuIPfRsAlota1aEJNqf6TW05X78p+5NukLhWQN4RF
	oxFHTud7eA7BPNxX75Fjog+bpNtcpVlAP8jBBbSW2yT9AYnVxWgd88n3fCFAVTlBFkQ8Jnz+PD7
	Nkn1n
X-Gm-Gg: AYBFou2VEbLFYu+p5fQv70yTPRp/EPtjv1E7AFk5wfPukyZzhVQpsJcSiw4OYYnHYnE
	IF440p2kCSSVdlI36H0re7ptdj2rIdaFLw0P8nXi89tk/Cmrl4J9F14QisFY/bbNIzeSb0oU0Jk
	qq9eDtvepe2D+Vhrm10wM03brnBmNtMcuchSu/BIPqRcMULSjKgkGaNvSYCHkckL6EW3kP+bd2t
	qr2QKGJDQI697iYbioDa0KyTWbqAaCLTfb75gG5NKS8DJ1HkZsMj7FDPMkib1ZUYuq3Y525BIGo
	FacMtEAfIpg6tZQZbyfqQev2IAIR8PxQvgT6IVtmPGjFx3LDQAUMJ8IPZBfWqWpFHaxSuZQyNN/
	CZ5q31QMD/FNeGVmu3oDVe7DDn3E/Hdk5kqvYfrmiWtYi/fl4ENLMTuHPtr+AdY83V1iKxQ3tg5
	tJHu95oVX2VI+z6Nr7Ng/9YAtAnEqHuuQOb4nqk2GVdcSlk5LRsyRlnulLLyepfARmF6PUlgkoE
	wCOZHqr7UmrF83UfRICybGEMRO/YDoV08KwHdhWYc+EGMf+ick8pcpfm7JgL3a29goDu+NOwo7F
	2IhTaEaRqsMVOPkMHtEicgg+hd+0H89jRNHZMGF53FE=
X-Received: by 2002:a05:6a00:4605:b0:89b:6041:2348 with SMTP id d2e1a72fcca58-8bc1c2a9089mr440796b3a.7.1794352408016;
        Tue, 10 Nov 2026 15:13:28 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b2887sm1432058b3a.20.2026.11.10.15.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:13:27 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 5/5] net/mlx4: flush pending doorbell when dropping a TX skb
Date: Tue, 10 Nov 2026 15:12:59 -0800
Message-ID: <20261110231304.1859217-6-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231304.1859217-1-joe@dama.to>
References: <20261110231304.1859217-1-joe@dama.to>
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

If mlx4_en_xmit drops an skb (for example because DMA mapping fails) and
that skb happens to be the last one in the batch, the doorbell for the
WQEs posted earlier in the batch isn't written.

The queue stays awake, though, so those WQEs are eventually announced to
the HW after the next TX, but that depends on traffic and could induce
latency.

Avoid all of that by writing the pending doorbell in the drop path.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 123071a47bed..3166837711be 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -1135,6 +1135,9 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 
 tx_drop_count:
 	ring->tx_dropped++;
+	/* an earlier skb in this batch may have deferred the doorbell */
+	if (ring->doorbell_pending)
+		mlx4_en_xmit_doorbell(ring);
 tx_drop:
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
-- 
2.53.0-Meta

