Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A82E92B3
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637718; cv=none; b=U/71+u8sPcSjZZHBfQBMxty9OUdGVtbiHA1iVoaj3s+3MYpHN4tnYri9+FXJd8ly8V62DfQ9igkbCac3peAGG16Ud5WZ0UPxxyt8QPgtantM1UbHy56qMPGJiQZbd0LGfGAB92Zmc0dNiLZf+MVtPTl5UkUo3Y1RHFB5Orc1nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637718; c=relaxed/simple;
	bh=zZqRSdRVzBOcjcDUhtyUq1mpFZmKcLHBt8LfU9cEZio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXEyhr/0QCkyMiiRyRnre/c5nzUd8ylYWyvEk5VX6u2xacs+6oIi0Is2jz/io2fXyeMs4DoAds73fhgljzMCernbFYHqyfYjsAAH+w8ramtFaLb7ZomTSUb7kMEZLnroFpH11Ab4HvdTLDUUt6T4O7xP+MKDn+W392z4GspA77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcO3uWGw; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcO3uWGw"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bf959b820cso2088330e0c.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788637715; x=1789242515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuWHZWx2knaUk2C1quRHTj7/UzJr/0Vfr5UpvPiZUWE=;
        b=NcO3uWGw7C/mkWfpRsqWuLZj59Kng4p59gUHWLnQskb9BCVfFP4AySLkMSrFkYb2+s
         1OHZth8tK8xX2p3/K9KkrjSp68CFKcnNOsLRE/gRUHIQiH2dpUO3FLcQYRG+qY0X1pDH
         ujHuJEIKM4Yc5uHJiJsO943+6U7EvHFhWgsSKVIP27vp+WDCw371ARP7EziMnoUY2zoX
         nrONJYDiSSeLWGI4y9+M96aCxh8Kf6RztRRqlQgpROlN69SwKwJhwMAy0pc62t/dAHA6
         d71/LjdeXw3qUqByPs4eaiNbot1SreeDgJkA9Pur9OdgoClxQNn26+4cc3BdKB3Ueb4e
         1ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788637715; x=1789242515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuWHZWx2knaUk2C1quRHTj7/UzJr/0Vfr5UpvPiZUWE=;
        b=av569JAtWWcOrhbuzuAC6mmdFDVK+hb8kxpnnA8rnZwE/Hid9unjWwBn2SaDdTbZI+
         w1vxgrC6iTLrfhb18zPMjvyvh9YvbwFu/zU9oP8cF2Kpb+R9lwORcSabdSOsQk9RXr+z
         NLslvoBS+Sfi3j0bdCh+ML587jmH++9RRgLCh3DMfmeuPLHc0wq/TZRVYH09fK5yFc30
         GazOfJ5RC4US6jnMY8cUuu4DaE5gKx1+GP8a7g3H35j5ylPwLiQt1jjA8DEvK/cCeyxE
         q8zNz0E8cArZq6gYSvx1dmKYk4vdmOipAMZ+ZArPG/v4/H5lDKZmM0pCGZVSrFITIH+y
         688A==
X-Gm-Message-State: AFuF++k4LlLjcxOZkhGPFWpjaUES6Fttpq5Ju8eJQIlzWBvgCjTkRp0s
	f1+6Yflcz4zIkeNg0enb5w10glhzxojWbmTs+fquHnIyQK6VOcNvysWU
X-Gm-Gg: AYBFou2/sRsN9d4FIio40KsF9RTLCPT3XGxEg0A+cIOcFmIeaybhO8s02i8asHRSWBD
	H6X3HJILm+lxt0BvqKuxc73iF+hgO9NxdQLuNPezDxVhza0SLUU5sopf62OqimPgixU1bMDrHKM
	5XlfhnIW9G5JgIn3p5TBESh+6KJZv0nqFNjw1lJfOH1QLSjJaGJdcwygg5Wq8/r2hufN3LUFD4v
	bARS9qR8c85jgFHkCScqMVLa61y+IDJZDrNphKPg6QZ5DWLpxqLHI0nsn3/R7GYyEECU5bQlLn3
	sFbOzOYrwFld8uXlB1Py0HoxuRZev1kJ8u1gVR/XhIBsfiN+jtCZXHH6sVKFAJKaa/JA+hdpqLW
	2QHqNuAgfD/kZXXWSPOZjSD9WZpBWOGBfI8dEkxicK0C8bFWxC6iAkVEe5DmNnITalsT/805r/a
	iVJHUv02m0T7CbI0DnKvdQfshxAOziYgquHJQhK+TE1jSN1rwq35sOgzbrafdyBmc=
X-Received: by 2002:a05:6123:22:b0:5c6:6c75:81c9 with SMTP id 71dfb90a1353d-5c7ed7ee91bmr5474604e0c.7.1788637715443;
        Sat, 05 Sep 2026 12:48:35 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ecac1033sm4678437e0c.18.2026.09.05.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:48:35 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] Bluetooth: bnep: linearize skb before sending
Date: Sat,  5 Sep 2026 15:47:25 -0400
Message-ID: <20260905194725.284347-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_sendmsg expects contiguous data. Check the skb is linear
before building its kvec. Should be already linearized by the
stack, so this is defensive, but drops the dead block and the
FIXME.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/bluetooth/bnep/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5a6a49885ab6..497eb1d2d6ee 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -457,13 +457,15 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 	}
 
 send:
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
 	iv[il++] = (struct kvec) { skb->data, skb->len };
 	len += skb->len;
 
-	/* FIXME: linearize skb */
-	{
-		len = kernel_sendmsg(sock, &s->msg, iv, il, len);
-	}
+	len = kernel_sendmsg(sock, &s->msg, iv, il, len);
 	kfree_skb(skb);
 
 	if (len > 0) {
-- 
2.51.0

