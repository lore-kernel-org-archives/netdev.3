Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91537DEBF
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812311; cv=none; b=VgTCAMSy8FL2loBh14tJT9lDTJoJHgbE1Iy0WN1Eq0MP8Anr8DZJzr1xst0FZhXpyambCCd1En0k+/fJrAA2qnVeWJ5kx+PbJjXoO89Gq6Sade7f9vgYzkL1LhLqSfd3Ao8fnDnghSy+6pVOUQHZFvwfiT1LYCwWIIDnpqfihEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812311; c=relaxed/simple;
	bh=h9E2N/3xuG3DTI3/VYyRY1PhWfqwaVE9BFuNs3NHnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1W4A30agpWNFQeUAb8m7mMI/bkymnl+tP9G1ntvhwCfN4krwfF2mMcSIPI9qbFgmYB3AnKEHBh45JgPGuvAE0Uq9NpeIAhXWY965iXOd6KFBKsFgQwLZnC3Ipi4hIXXWZHCBxTwmvHFCgbKJBxRChhti56RQrMkxa+BxC5V/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bh9g25wt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bh9g25wt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so14790065e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812308; x=1792417108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=Bh9g25wtXUDPDKVRpbPIm7sPdfxcSgIu6KfBBBXfiU7N+OMg3Ix6kGYJtvXFMPzD4W
         GpVuTOlaB15eq1DmLDxketkh0c4ObW5pS5pSHb5kj9QbSD67WapItpGStT5vtOYvxrPc
         lOCNJ68Ufe8Org4TR34Dbum7M1Jo2vUdAEAc4RwbZ5lZLjM+FoV3lPS9h4wKL2Dk2KM+
         mn+I74fiBpM6X7Kx3wOGkOxwuTXDi3ZIseRLIJwv2kyl1COqFBUH7KSltbJH+FKoVZIv
         qn6tzEjQJqvTzH6vKa9k3uDyg5sez0qwbXF+EoozO8cfK6XWVTB2tnwbqC6rScAdClq1
         YUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812308; x=1792417108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=bXeDdf3N//KBveGfzUTdybAkXjh4oyHU5MRYvW9pxvsnDB02vLA9ULVx3JA3hF7JBg
         s5NzKcmfEU80R8ASWLwRKSxzmlNnmVpShd0XVPmUBbSUhN2iGeMjXsaYGXNxC6nqcLN3
         PKkfoC06f8n8dB9f1p37adySIGxO+uIrY8inrjIEXbxNmHyY9UEx7Wvv4rNdG4xUXEMd
         HONrJFsTreuaaLZBswFigivDdjPQozWuzHJ+aRSk0gJiSQI6obOMhLtJCEfYKJxF47RP
         2FV9Kl0vP4zKGBNhA9tVsDCjjltY8hf4pqM6iBu5negSs+nTvRjLW5bYE2LpubJQz0A2
         HI3A==
X-Gm-Message-State: AFq9FYKPpIxXmEtg/fBS8LE+wWUZZYQkr1rhkdlHrxL9tlL9juRDkW2i
	pc2XQQ1W220JtZqIByngT336CF9ikrg9qxC4Ns2XqhbOnw/P2Cw8wncq4hwAsZ7VpEcMwzm+Wt+
	kVbkSE8TDDy7x9OoaN1WeLOfwRoJ6+lgKZN+4W6zCmDcVsWHdyQVC948GeuAkPteK9To=
X-Gm-Gg: AYBFou1yHv9Sc76bDPeaqeP9DHke1nDAcmnwrHZHf1n7FZ1CKfxa7p2tFkuKRDVe1NP
	t6lHgsVjreNJb5/3gmOAlkHgudOtSqSEXwq1Muq9UOGnAA+ogLe2yIRNOGryy0kr3Ju+gSpWxpp
	4faAY46IV5Vktc2PsCDUxbmRwJXFlinvDgL2muh6A7HgBnHfBmk6KESmAtoZ/uc6pV2UR08kldg
	B03erykr8gh9LcngxESiWNzAKVTaMvsVXfFkkZDIkWYphWVPokghYv6BzyxZ0C2ctxxDxPuU+xd
	57oT+eVkNj4Zvgo8AXXJVVWpEMZBIZqodui982xuhbw9iCcNg4X6hK7w8T45ShZR6xcT24F94hI
	SR/C7CUx0xh5hlcfq8Pon+zyZif/RKfHG5RXAyzEvAML7q9ICVbhGEKLaPndp2s5+Jy5otIk/X/
	vVvAVbWSrWzFvEJ50bDM2SBiG4wxIcfsdLFTSQJsJDOA0bW30uQZ01yZbBaCog6jvfkOhbnK81o
	Er8BGWYGwg=
X-Received: by 2002:a05:600c:8519:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-4a18e4a16femr170904515e9.10.1791812306330;
        Mon, 12 Oct 2026 06:38:26 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:25 -0700 (PDT)
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
Subject: [PATCH net-next 3/6] ovpn: remove redundant peer NULL checks in crypto post functions
Date: Mon, 12 Oct 2026 15:38:00 +0200
Message-ID: <20261012133809.2477063-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012133809.2477063-1-antonio@openvpn.net>
References: <20261012133809.2477063-1-antonio@openvpn.net>
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

