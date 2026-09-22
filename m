Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031537207F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057344; cv=none; b=ddXEPzcH8m3uJZJZaKHWPK7y70hSkV5JGrWGijcCPbkNI+vDuAUVf7H3OdovHQXYCUlO1UC8GnJ9C68SIGK+rzAfGkHaPxEQEBcxxlzBELhMsd/a08ZSttCxjLSsXd8wsxf/JBoyicM/rVGl4gSPHFY9/S2bQkWO3yaoQqluOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057344; c=relaxed/simple;
	bh=h9E2N/3xuG3DTI3/VYyRY1PhWfqwaVE9BFuNs3NHnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwNlUnW/DVH2eyvfCTzYnmbsT5Z4xe10WrcesPbsimek6xU42y4aVAz1jTz6BkjWLB2Y0WOzEEHkwWsYee8bWRIQve2i/5AL4ZdvdvIUEXkupcP6xptDpFaF+jDNqaaB0SV+QYcRX8qv6KJxab+GbgUeSu/IgR2sjQhdMfGOkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KXDryCoa; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KXDryCoa"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so50120425e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790057341; x=1790662141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=KXDryCoaljX8d4XMvDT/ZUi2fMcV/w+9MH/iqrZzac1ESncpQCuJFW/+5vqdbrLjVm
         coqzZiQk7trSUQV/LyO1EBHByU581eTv14ku6NlDwieLWrlSQWhOhnfCtbxLkz6oDolr
         l21xHg+ZHzTFjiaxdUXrI0AQkL+qoSic+1Gw0moJ4rBCpDV0SRT2rF2kav8nVd8Vbabs
         vsBsEtp96751INFy4ye6OdKW7EOVIJQxKHnQPXItkzenX28cpXo9zL4iSJZitMsHyf9h
         gHx3jBUbbmwykwK5WN2it+U8wgoNerLNDT/Fux6393vBmIz1NUscrIiOp8+gC02EgyEV
         Xy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057341; x=1790662141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=00lXsjbQsOuL5wQ6V26S/55PO0yQ9ykd0ZMVEmbqNo12+FHEDaULf3lJU4cIP+2BBI
         TpPgxMMbXnJGrsHYufqTuTpevD0L4aj43raNcihZMMtt7V9/0Zy/m2HiVLd2hIFC9FIv
         s4kSBJ8VxWfn7QUE+yYInKbxakX42Mjt9ETQ51dJvCwawVH/U+cyXL+Os1y4r+pK2Gc9
         1XI7C8FLedeBuZf+eN2Jt0D6VSKae7imboK4DGQcfTLaK53BUp1NK5eQc0Yrkx/viEll
         ypZGR02RqbpGZ/ScJwb/qjCHjD+EpdvCq3JxUgL3P7kZgxaGk3eaj402KtL1vVMZGO5d
         XqKA==
X-Gm-Message-State: AFuF++mKd44xCd6ap7lkpMV3jUujSukTX5+SJlbhQSjEsd+W40pa4loS
	Yh3omUTCcerl/HOUhfg8XkQ8iCGBFomS4fgGxi/9CiaSvewFDzLX1ORuogvxKKQkxYH4yokvjv9
	biLm1hkvGPklfazY0kDfqUpJcYS7vHm951xFPcTh3dmb6izuVkmoLjlsva/25HLR2WXU=
X-Gm-Gg: AYBFou12l8XRp5RBkwKWQvOShEMi/Vv9yuJr8ayyvAV2OzD7FMykc2VtqU3W4pbLmz3
	8XuLXez4zuxBuNRhQ5lG9q9FaN5gCu3kcfqUQeTkKmntP18HqgevaPGFE3ZiAGh6ZkUwdV4dxix
	h+jKeIx1DYnvk9ImPaKiJvk2q70TVmFk06vvQN7cTB3GryKW8jUstR32Dy22hknOgOoRSEYgYof
	f73gmoA6iOO9y3CUcNRKMid11q9yDCcdk89QAfgTUl2H30AcH3tj9U2cPrGU0VJTZKgK1pvVQLZ
	lUuuAeKSRtfjSOj1YobvI3JnKHMrcKboCoRlsjJBQRhOndhcKIsDc6WU6V6PbbfH5jo5qaI4EsE
	HRQ47AyOkGGm5aO2xCotu9xoWzClXdCVwE+uryOhcGkjq3TGsmYy9G/1P1JZMFojnbIB0oP6yBP
	eHsuNI5RxInC3STGTzBfGKMVMZJ3IbaDP9bY7xOqV4u5EGlFPWgu/Lae+rptQEJhGqxoAhfuul4
	2cvZ+jhz9E=
X-Received: by 2002:a05:600c:6214:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49fc568129emr174183735e9.6.1790057340852;
        Mon, 21 Sep 2026 23:09:00 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad6306esm25814125e9.15.2026.09.21.23.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:09:00 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] ovpn: remove redundant peer NULL checks in crypto post functions
Date: Tue, 22 Sep 2026 08:08:49 +0200
Message-ID: <20260922060852.2266148-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060852.2266148-1-antonio@openvpn.net>
References: <20260922060852.2266148-1-antonio@openvpn.net>
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

