Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539475;
	b=lXNuaemgAuuZtYBIzHfq3JgscE1uoxHMb/AJ0AW7sJuJj8BjUr1kpJdi1Z0j9Ghry3Qt
	 0NyiLwK3bPiBKo9LsCHSJtcxzuQqP3fuOxsBWNaw73t2+LoPZzYv4AZIdRxv0Ej8bFY8a
	 teqkH5/d4SIDm8U+SkL/4aPTPBjFRnOjGsDQK/2fbj8t6TIQocvRgSEJ2g6XVbFCtAbml
	 1/fXoORCcnkzPqrSzGylhc//dLewNaH1qCsLsjX83GvHFmLm9kiQ9bKoRmAjYNlLWQxUv
	 e5X+BeHitK7A0hrqeZDmUZ+ptKAdQ/uRKdatrJUSr95mEMCwDE7cDkKfmJY8RyVASlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ucoGans+Z6/DkY4UTOeYgSsSSQakdWd0/LydR6karMw=;
	b=V9I35Ouy8JT9zm3Vkn5pPzIOM4AbZpZHjCEpfibdY7zmTfwRY/PktfxIJuqVnK1li+j8
	 esOxvwdhR83JoXkXL1CmHfVhXheVIPG5sJZxNLzbOjlE8rPg8y+hRg7+PazIG/EK8F1ro
	 RZZ7WjNLdcI6wt2RJuGT7YaLo+aNN08LHnZRSO0m/MjgjIB0F02o31avHB9NKJtqhrjIb
	 md05j72H7wwudvSS3XyHFcveKVdg26zurFfXo09co6Q0ZhkQ9yslobLvsUAxelXFA2O3X
	 sjph3P0zkaI4N0DQbNymWeZKveQcVEc25GniRTIcKsuie4tunKWC/Pp0HYZKlhMilNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kA2+fE1b;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722D606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6722D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kA2+fE1b
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so85559f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792539473; x=1793144273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucoGans+Z6/DkY4UTOeYgSsSSQakdWd0/LydR6karMw=;
        b=kA2+fE1b/tPF3YnsCgW3qYVaw/PEioEsGS4BBM8os99u7hiSVu8SCUJG/2vsOvmbY2
         jT4DJs76ooKb3pTUlY8hIINkrtcEt/iK1or1IiPfrpxkaTkcXKBgZkmnvMIIlXMO1TD6
         iQvULmHA05BA6M4D+SQSzzgBTTOTiAF8LVR0yWXC1D22hvxtaStReWxn/slV0xNx/w4u
         tYBFqRAdfahspg/DoU68/3wuJkhXmTw2+DThiDMsDmLvaN/A3yuYDzYmIm/HMVzXCf60
         pncMFfoVwDznSeYpl66IEYBCXCPj2rGUIN3fsAZ463uuYZibe7Fsk4m4xV66UgZkJ4Z/
         U7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539473; x=1793144273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucoGans+Z6/DkY4UTOeYgSsSSQakdWd0/LydR6karMw=;
        b=cZbiC5UHdzHJ7W4L7nyF6SSAEFl2+NDoitNRANrwwAVAfKcBRLUta+UvoqCtuHJOyh
         3G4MV8MF961vPh/ixIdhFXceQww80zrYohLiIrSutsxyGhSo/eqcInHOYXK9El0POlTU
         1Us9OFI54U0JVGzF4EU57VChQhEJF7zVAAN/3z52ZXUFyA4Ihr+y2NK/iTRlZRGUiOpK
         2gCX1OmZ2ylyS+FdF95yG2cOknyuSa1rMeavq1Sg5gxk6fbxOXmWa0vXHVXjWCQmtzl1
         XS+kbbG0f5e80PdU/VmdYGLBzskrXCRhFd8c6a3DTfO9pYay29+FAQnizsSUn08GHeMA
         NA0Q==
X-Gm-Message-State: AFq9FYLo27vjfzAGYfEPr8jhQ9UyTlrDze9kH7GSFNWPSqH08xu1pE0O
	CRO0s4B/hliliYMo1juE54/IQCIhmHQReTi1EzP/54CxOhcdgamTbTYFhwlaf6pMng==
X-Gm-Gg: AYBFou0vYru9FozpL1NkBus0ZjcJ5uGUd3hchjZbHzgGA2qD0YJVXnNN5udsec4tJoO
	XvziOXEXiSSys9LWnJNXJnVcHdjkuRvtdHDtXJfb3m5JJachMt5Fod3mJe1LDbQ54MT9HXPTwHO
	bV9Pyz4MxX2ZNwUjyMMMOB0Ux4ZrU9ZjIlnLH0LXfurESelSn8c7UJsFgWsE3WKuDs6mSoiHdV0
	wCU2ESyuh0A6MXN9aMqNTyWtk+BMooYpEw1KeumHpN6JoQbB4Z3drSPVGxUnWKbyv6EEGkwYqRz
	e9JMIx06NMvNJ94gUANSj678Pa/6s0uecBXn11C+h8FLHEl4eNZ6yKH2ma+XLDYf3hfK/NDS/5M
	9cLXXP2uL0rkUa9kfzt82To8L6VZOE+g1lNJZoKIp/OnqkSano57oitfL42efrYqvIjsJ6nBEiU
	zixSFNnAikCuVU536hswcuFM0/s8+KMtiv0QmUDY3ADoZmKN3vt+Bsoy+fYl7K1fD6lhSMSrTw6
	KvNdZJ0YCUGToC9ulsGCxEs3Zs1ThhvQGUvfuHSyyLx
X-Received: by 2002:a05:6000:4013:b0:48c:58b9:f17c with SMTP id ffacd0b85a97d-48e1e7b672dmr8287971f8f.12.1792539472559;
        Tue, 20 Oct 2026 16:37:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:9d9f:2700:ddfd:9840:a7b7:c1d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258426f4sm1532763f8f.54.2026.10.20.16.37.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 16:37:52 -0700 (PDT)
Sender: Akshay Ubale <akshayubale.dev@gmail.com>
From: Akshay Ubale <akshay.ubale001@gmail.com>
To: netdev@vger.kernel.org
Cc: Akshay Ubale <akshay.ubale001@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	Matheos Worku <matheos.worku@sun.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] niu: bounds-check phy-type and model VPD strings
Date: Wed, 21 Oct 2026 01:30:07 +0200
Message-ID: <20261020233007.71945-1-akshay.ubale001@gmail.com>
X-Mailer: git-send-email 2.53.0
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

niu_get_of_props() copies the "phy-type" and "model" device-tree
properties into fixed-size np->vpd buffers with strcpy(), which does
not check the property length.

Use the length reported by of_get_property() to reject values that do
not fit, and copy with strscpy() so the destination is always
NUL-terminated.

Fixes: a3138df9f20e ("[NIU]: Add Sun Neptune ethernet driver.")
Fixes: f9af857489cc ("niu: Determine the # of ports from the card's VPD data")
Signed-off-by: Akshay Ubale <akshay.ubale001@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 54dd7281191d..fab6af105df2 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9260,7 +9260,7 @@ static int niu_get_of_props(struct niu *np)
 	else
 		dp = pci_device_to_OF_node(np->pdev);
 
-	phy_type = of_get_property(dp, "phy-type", NULL);
+	phy_type = of_get_property(dp, "phy-type", &prop_len);
 	if (!phy_type) {
 		netdev_err(dev, "%pOF: OF node lacks phy-type property\n", dp);
 		return -EINVAL;
@@ -9269,7 +9269,12 @@ static int niu_get_of_props(struct niu *np)
 	if (!strcmp(phy_type, "none"))
 		return -ENODEV;
 
-	strcpy(np->vpd.phy_type, phy_type);
+	if (prop_len > sizeof(np->vpd.phy_type)) {
+		netdev_err(dev, "%pOF: phy-type property too long (%d)\n",
+			   dp, prop_len);
+		return -EINVAL;
+	}
+	strscpy(np->vpd.phy_type, phy_type, sizeof(np->vpd.phy_type));
 
 	if (niu_phy_type_prop_decode(np, np->vpd.phy_type)) {
 		netdev_err(dev, "%pOF: Illegal phy string [%s]\n",
@@ -9294,10 +9299,15 @@ static int niu_get_of_props(struct niu *np)
 		return -EINVAL;
 	}
 
-	model = of_get_property(dp, "model", NULL);
-
-	if (model)
-		strcpy(np->vpd.model, model);
+	model = of_get_property(dp, "model", &prop_len);
+	if (model) {
+		if (prop_len > sizeof(np->vpd.model)) {
+			netdev_err(dev, "%pOF: model property too long (%d)\n",
+				   dp, prop_len);
+			return -EINVAL;
+		}
+		strscpy(np->vpd.model, model, sizeof(np->vpd.model));
+	}
 
 	if (of_property_read_bool(dp, "hot-swappable-phy")) {
 		np->flags |= (NIU_FLAGS_10G | NIU_FLAGS_FIBER |
-- 
2.53.0

