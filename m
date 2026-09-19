Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDA39CCFD
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857277; cv=none; b=RWU+eEdAt1rqwN1UlYbMpKdQ4yIHujnCHbGs5XVVSiLFVJKxs9TLFT2ypA5rYSq6WrAgRwQBGDamkl2JHsrfW4h+oW3VqsPWcSIO7z8yN+hiphFdZxVgp9y0p56TRrnBtkkrlTx06VFBCAj/JNzl1CUqc/juuybgGTF4r89+/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857277; c=relaxed/simple;
	bh=gC++OOJwITlq+qev6bTeZbXJeu2a9jMkJnQkZiZRxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFVWl24e76gNWDA1chbYrxXCcH11QOx6Wv8iI8MV6eKHnNuAshTda/b5Ltxz2moiaqa6v8+8sjxHd7ARO9K7K2PnLaPRlCo7NHtWZdgigYs3Dft0sI+sz75hEFTu/IeCkbGSwweZ4/kqpWGUXIXf7/ylAocz69Ei/sRaz+hP7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZkMsOId; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZkMsOId"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so11950685ad.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857275; x=1790462075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSJfvpEKhzICZxDdQza9cnVlC/TEEQOPCzrF6sAEcIk=;
        b=EZkMsOIdO+0LhgnkY4ay5xCg/Kneba/HcAzKKT7jzc/HKLEcfgDHUfCzd+pfH7rH+p
         sQe3xM9Gb6D5oMBr/kCHGczhQcNdpiSWaB3fZbFvomksK9wu0GVIBfhxafZT31dD7NnZ
         ZuTKOvscPSj0dSfrdKrrJdAZJrPjd7wXgfW7qExNtK6ZaDH5Y0QG7M8J4u6r/4evpEf6
         3AKuRiS89TneJFRP6t3T8zjKnU2NEm22eQRofOx1QtuILm+IBhVpSbcPOC4RYlCM/DzE
         ensnA6f8N1bNcHiANlPCv1OOVsWHtWFlDdkFfUh6JNJTzPbq1N1bCd3PYFwD1aJxY0YW
         1F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857275; x=1790462075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSJfvpEKhzICZxDdQza9cnVlC/TEEQOPCzrF6sAEcIk=;
        b=eblzM+LUrJvZ6zMeo/4YamruWMb6NJ6++P+ysdmd3BRYWRdsXib6CdQlTreJJr7kuO
         ip2B2V9F0A+mwC/atPk5z52R2pauqW+/mDNN3O0wcXlomtX0nWgR2P3VzHwM2gPWtqgU
         g4+WvXfee7j3J9hlwRZFwrmBnBp+e7HyHBb4lBAY39Rc/7QTjosllq+A9VTQOIAzsnUD
         VLA/iCaygqa95ETWD29c5Wrt+W7DT67I0lKXNDTHkKLaUIZJrhU6OhHNIrgZk41YM48h
         +a4hYoquvHFRw5+kEPl8zWvl1RHsNdS25u8NRuKIAqV04QMSS8OGlLgF7E+dnBnITaxN
         qBDA==
X-Forwarded-Encrypted: i=1; AKwUvBwY4dGdOPdqNOTQxzBmhVK4eUzzAP3UmmnPjJk4Angrftzyw7QoymIRk31IZys6QOIsA1j7SOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l7fQHZMmCgYV5+JLsuo37VEV7hZJvCmAcTom9nM8AutvO2naRX
	eXzEysthR6QLFljafV1vdvqwD6WfPDBAMlReWwQX/K7LD2CSi8VVLl/L
X-Gm-Gg: AYBFou3rKslc5lEpBlrXVj9hIF0uONHse77awLnNCDvtfU6PZuA8ekqGFTcvEoEe7UI
	gakDIhfyqqlpx3VQKr7hdr77XQpX7jJ28huOOxbFDbI1uIgCxFHcdZYAwyjyQrytpzh4cJkw34Y
	0fq28rI8KrbYkIZsOqOmI3qQwGQ6ArL0fRxYYeHdfLIqFwhuOk+T4vrORhrsn7ACUTbFuxXBHSo
	+2EbboWg8TPPDhu2ZdKsiFlXU9pYGjMNt9jQ90vaUkLNZcoVIL66Wk/AzZLx7VgYPHdvNk1YToL
	UhjvqI3JNYLPBK138r00IkDmStmNsHemt85Dq6RGdM+B5WG5o0uej3NAiIovRON4r0bevyYJ6WO
	hVrpO7dSz2GQ0fS250SSwhRGG+STTAQq4L3TlmKSIpzkfN1eNINPEe2ZuGtU/VsZ86FL3IgRuNW
	y7IIY/sMnfH5+zp31Wnq5T2fVel7EFeF8WBWFV6yr1QZuL6r8+3lnggKBBQg62peiXGvMYyJCa0
	PEE5OnCRFkxkbB0GIyycQaM18hoGmLi/ae91rN1N1c6S+kOcsKEtCi6Qi0heckIsIjgIP1Dbaka
	6+fcZA/Z6Q==
X-Received: by 2002:a17:903:298e:b0:2dd:c100:4b7b with SMTP id d9443c01a7336-2ddc1005f40mr50972745ad.50.1789857275552;
        Sat, 19 Sep 2026 15:34:35 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b471fsm13287455ad.3.2026.09.19.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:35 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: hwsim: fix edge allocation leak and netlink attribute validation
Date: Sat, 19 Sep 2026 22:34:34 +0000
Message-ID: <20260919223434.3882824-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/net/ieee802154/mac802154_hwsim.c, clean up allocated edges
and phys on error paths and validate netlink attribute bounds.

Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index a9bd1555d2dc..1b325d665177 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -987,6 +987,8 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 
 err_subscribe:
 	ieee802154_unregister_hw(phy->hw);
+	kfree_rcu(rcu_dereference_protected(phy->pib, 1), rcu);
+	goto err_pib;
 err_reg:
 	kfree(pib);
 err_pib:
@@ -1003,6 +1005,8 @@ static void hwsim_del(struct hwsim_phy *phy)
 
 	list_del(&phy->list);
 
+	ieee802154_unregister_hw(phy->hw);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, &phy->edges, list) {
 		list_del_rcu(&e->list);
@@ -1013,7 +1017,6 @@ static void hwsim_del(struct hwsim_phy *phy)
 
 	kfree_rcu(pib, rcu);
 
-	ieee802154_unregister_hw(phy->hw);
 	ieee802154_free_hw(phy->hw);
 }
 
