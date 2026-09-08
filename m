Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6658F066
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886463; cv=none; b=mDWgLejf4dQXQOCj4FoAw1aIK/GeGzQyoLALiXCfDvN8wWsI8+sA1bA98KiEemU11YH/u9E8epIyf2VNlVhJ114dkSysiPpljQEgFcSP+BQQzccRVx+zW9DRSnEklIH+sKkrNEl7hHYt+8knwnSlbwWbALTxk9MOo3ECsXdm/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886463; c=relaxed/simple;
	bh=vcvOvb7CfSolquWCtsTU/Hekl6HvtR3StQ5xpcRfncw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tY/PxA2gjQX5M4ZE5zLLhQKPD8GjD4qnxhvvMdXNpZ2qo+qsARrP5wB/t0haiTefk5EDFLf3/mn1Lcfb536mU2KHpFwv/PLSpXfp3toi4i6hNPqaJNOWp5MdNgWCgowMgKm/CMD1URuuCx0vpWL65C/ulu0WyBBOY6yUwZRx9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXgQhtcW; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXgQhtcW"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c79c9f7b54so2595600e0c.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886460; x=1789491260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFZiJhCz1KLVTjd7DyHosxf2D5OIZoZsQdKvW5PZrSo=;
        b=UXgQhtcWV3gGTC6N/2A0ccnvmD8cwsYx7wapTYHiVwhbYbVH7QS3s7SYQoRdKTDHJr
         kQ0QP1TsaxewZN3kh/J4hmJzWck0NNyLeVJMdFFkf3PszlPW8c45Y7xeCM1+wAyBSifl
         SBMkJvqMG0txbbXouZXafAX0n39fdv6eSVslOGRBKfYNL1rhOXlUgzEzPbalHsDeygj5
         hFFdSjKX+WF2FVUIOvjVxiZkgz5wDg8Qv6rE8Yvh6hCpdU9jWvuuzuR1CXjCwsVG25R4
         mFJM4IRKJqpVIcFdDE4HkqqZLxqUuUxQbpzhpCq4CfWde+mlITeXfh1vMvPYl3WsLg6M
         txvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886460; x=1789491260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFZiJhCz1KLVTjd7DyHosxf2D5OIZoZsQdKvW5PZrSo=;
        b=G/W10AgcU8u/H8DNhAhoMK0PZmOkAMbu6aPBJgBJByOOtn1wlKrUlazMzmf6uZprGf
         xcbQz4hwyMspFDqUO3+zfMvGJxadPMsS9a1sh10ec+OepIJo8Kd0eZuWoeIqULG9JXq4
         sWuifBzfxj0w8dERal1UmUPjScdWHb1Ytoya1V478G6gZnuXyUNOXevhQPLPGVvvvryn
         ts6Ay5FliMTtPcZoW+YhpQa5mGv7uvpnS6vvtvlDsRK3K6LBTYOlJBZNUBa+qOTMgRm3
         YaVEPsoh8Ja1QIyArmZEMSwKABs2nVg0hbSXcMK6VtZyxXO4TzgoGcHWgHAR2r6/WXJ+
         njdg==
X-Gm-Message-State: AFuF++mT8o8ad76eKAwrR0xAjXf1JjlPOs9o9Entvx+l9zYZw8+EoBqD
	N6h599ADAmVdwvSNvoVgXJ+VAgJE1mQUneQ1PekI3JQkYPJCJ2/f8LSM
X-Gm-Gg: AYBFou1LwXiZQes/CDMH4IGQjijMjLmVqbP3PrBD/25Z1LyMqvnp+7R6SftMojwSCgz
	X4lPJclbmU1PSbfiU4+o+nO0gbr6CmptJQoi83gNc4MdH6txfWR9GdlkoBMRagua1aEOZNqrhsi
	ttc5PjUPnVuDHhLWZEqXi/TCIk5NidfrXlgpMeUpCo6nkQRKHrwrUm5VBm89dmSnk8VtfIaifo0
	cwwYWhLeEsYnrERHODTn/Ge+7DNbvBoJn5Ae6s7hncGfXf+E9aFgtM8INgt5ydneyCSDJDiG8Bz
	cz0xClRON11RpTLbKVnLWi80jmbRDdU5aLFaEKFrhETGO8tXJ882yY+/Fo1+JPZi7ZvWIyBn6Cd
	GBW3QM0WfzyN0Eqn9gKX6Q2tTfGoqiQCodH/x+jmxxUhAFDbaSdZb1lo2cdb38V05A3ioMsYP4z
	AJ4YKBvBCS25okudwOfcXYLfSJAPOvuGYC1XGS6/cYWMwN7m44o3dqqKOjCz5a5w==
X-Received: by 2002:a05:6122:e189:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5c7ed3d6e42mr360785e0c.5.1788886460411;
        Tue, 08 Sep 2026 09:54:20 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:9be0:137d:43c4:cc14])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm2668280e0c.11.2026.09.08.09.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:54:20 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2] Bluetooth: bnep: linearize skb before sending
Date: Tue,  8 Sep 2026 13:54:13 -0300
Message-ID: <20260908165413.75026-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_sendmsg expects contiguous data. Linearize the skb in the
bnep_session() loop, before bnep_tx_frame builds its kvec, so it
is not split across non-linear pages. Drop the dead block and
FIXME.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes since v1:
		- Move linearization to bnep_session loop, before
		  bnep_tx_frame builds its kvec

 net/bluetooth/bnep/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 0dde82e9a085..e8b4672628dd 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -480,10 +480,7 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 	iv[il++] = (struct kvec) { skb->data, skb->len };
 	len += skb->len;
 
-	/* FIXME: linearize skb */
-	{
-		len = kernel_sendmsg(sock, &s->msg, iv, il, len);
-	}
+	len = kernel_sendmsg(sock, &s->msg, iv, il, len);
 	kfree_skb(skb);
 
 	if (len > 0) {
@@ -524,9 +521,12 @@ static int bnep_session(void *arg)
 			break;
 
 		/* TX */
-		while ((skb = skb_dequeue(&sk->sk_write_queue)))
-			if (bnep_tx_frame(s, skb))
+		while ((skb = skb_dequeue(&sk->sk_write_queue))) {
+			if (skb_linearize(skb))
+				kfree_skb(skb);
+			else if (bnep_tx_frame(s, skb))
 				break;
+		}
 		netif_wake_queue(dev);
 
 		/*
-- 
2.51.0

