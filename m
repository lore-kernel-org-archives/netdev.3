Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D04B7A2E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379846; cv=none; b=RhLB4C0qf6lVskgh0Z9QOoUxXk+keyS1JK10W7RcWWyErTXKbvwk8esrix1k3Yd2OJqG6oTDEe/dD8z6UF4AG/Gao///udhx87NvnN6y6Y/BdiO2STA9/TDrpY2SUslI/I1kqc4Y+j3MKct91qn03pfY74RDDyG2RUkqUzDx9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379846; c=relaxed/simple;
	bh=h9E2N/3xuG3DTI3/VYyRY1PhWfqwaVE9BFuNs3NHnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmjxtUmfXXTQgrWBCD8siUHmITJi5Yv472liCP1Wt8/yX3rZX+HAYfncqfcfrqO09tLWbHzE3gncV33XUiOSBI6CMhSFIWP74IuAxpNiBeHmLZCsbeCb3SZJTd0/S7FUJWdGMbibrDe0Mx2+b4uRCBCsgq5/cp6Z+KbBYNcCgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HSta7i94; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HSta7i94"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so6550375e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379827; x=1791984627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=HSta7i94jMopksdXLiTXtjkiemcxmvKZpt+YTSvBFANfK7g3QaiOFq042+OU1e1apq
         fiEBj9m1iXWgxGnL5DMKiERP7JgnXLeVwE1vVL/lJ0PxX4DfNQ9qH5nB7YE4P6eOCiPJ
         JbPDBFOr1AVtdgvSLFDU1ibGI1eIzWgQTIRROOXSvs4l/e7xUJGA5tXvnfGZwegs+fc4
         41JSFPDTsgDKutvNTxavRQYAYlz6r1gNFan94KlEO3XL7fgCcRmu0Lxw66xP22wsnSIY
         sOLWT6S+TBcsRWQ4rA77EwisiY9ffmV1Iei2ouzSyN92RhS5hjmzMKO7kCKfClrDDd5e
         Uc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379827; x=1791984627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=EHnRF9fYNzfkP487z5SFzaTWOOtq/XwEnYNidBu+tFJ197YoBkhimWZC0J68uvlyQz
         /9p1V9lEQz/xtBknCfVddWSU1sCCKq8BH1v4/AW68pBAX90/HBaVA3IeCrzwIbSD6CZ/
         lDZPZWcHxYMIqucZD7ZdWdy8zsSo20qEsAgesTETclbj4ae3IOTSQSK1IauOlIW1IPqw
         cpjypbhTljnWcrAfK4scNUXGgGWFvX86FCRrSuf3VMGlQyWDCrqYb826JoBjEtFsfSKc
         lqhU5LB5OYpzb7xmiFH6hi8ixUovZjqyMtulWbJQwaIcARjlqCLv74YptEodUF7iydqk
         CjGA==
X-Gm-Message-State: AFuF++kWxyNk7chEbVO/x0AiW1GGhIxLEC7ALYbvCa/MQLT08a5XFzsG
	4ktUmAp2ZSrAQLUe1ci41qR91BiqF0HcVuIRUKHW9B1c1Uf7qY/Nqd+aMXOGKHYEwO6LhPWYZG6
	YSqSiuMNuhWBtWqoa1CAetOhroq4MA/qf6vFdty0rMJgCO1BriyRCJ73i3g141xx5
X-Gm-Gg: AYBFou0MtQo0gGfuuX9cw7ZQwO27e/1l8B39xdm45PmBpRbenUm+cZ3PDYB03FQ2DTJ
	hhBZlffyPgjHtlH2X9Ivhtr7oIyPasBX5cbJw3083zYxb8lqX/w6fEymS+EdywHaRV/sNWo/Tu4
	srNqDKKtPXLnjAJN/g2+7vse8+A5HhTgwc/iOjxXyGNN4Mj56FteWjm9XtnpIYEfWTBh3jyA+XM
	QkwAu8/QJsotGbNMrnAjSWUF/QOl4NmqpjHEBbnVIz5U7xQA4x7AVmZ9MQpJAnptjuxwseOI6hC
	xp7cabfWunKYkywQTwz8Ke07iVaVO+VhgX48I1XvCsNwKfQXpm693ESmk3hskDO47YTC9cEp9QD
	0kdrAFCKr3SH+zHELk1J60Hg9HEcZjINMYzdjZRg9EBWqugoX+6+Q8VFuaN+oaGX+HMpa6dRLP8
	zSxGcPhJiHNnzfGjmc0k7szX8JIKIqIZkswd3SezW2f4qVrePCkbQjzAefXlWUyYvxbxch2R7ip
	DgLulQos7Q+vMHP7q/k9w==
X-Received: by 2002:a05:600c:3152:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a180650660mr30251755e9.28.1791379826641;
        Wed, 07 Oct 2026 06:30:26 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/7] ovpn: remove redundant peer NULL checks in crypto post functions
Date: Wed,  7 Oct 2026 15:30:12 +0200
Message-ID: <20261007133018.1451958-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007133018.1451958-1-antonio@openvpn.net>
References: <20261007133018.1451958-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

The AEAD helpers set the peer pointer in the skb control buffer before
any error return or crypto request submission. Both crypto paths hold
a peer reference until post-processing finishes.

Remove the redundant NULL checks before ovpn_peer_put() in
ovpn_encrypt_post() and ovpn_decrypt_post().

Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da6..f14eb4e6c46a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -206,8 +206,7 @@ void ovpn_decrypt_post(void *data, int ret)
 drop_nocount:
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	ovpn_peer_put(peer);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -305,8 +304,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	ovpn_peer_put(peer);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
-- 
2.55.0

