Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF18386C08
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465385; cv=none; b=Biu37FQj2MY3sHH9urkRGjo/lJ1LQ+tm8WoKPZer00vMcS3qKQBC8i9TStC4ajGOxT6FYlMZ+jZfzYdqKvgOInGsdTGFbck+IIgKBu03FhYrwFuAnsEXG4B6o3Q9b04UFYJ00gZWuLdclV54LYHb7czEmexINBK8YJsG6JlIc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465385; c=relaxed/simple;
	bh=DSm67Fef0PwVMY0lwmqgSFdetPGHsbit/KuByND9Tmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrZSdZOSjDbWl+KNUfT/CJWpZh7SSzGs+qSBclbVL8+rxrUmf5HWTWhgfW7b3KM71YGFR29lJcW3FD8E6dxRRU84AmbArsQvNBrIppS31PO/4YFEo/m14ASEaOgreycPJjoy0NU1vCIlWylHNmbYOaIZrtzyMjlMijNvgXTmncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI8eZHYD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI8eZHYD"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca06a25so490655ad.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465379; x=1790070179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69mrxJexhH+mB0/KG77Jb3FUWESkIXl1gYvn5Rky+CA=;
        b=GI8eZHYDA8tr6ZKf7vo/6vL2yl/VSbS98x3fvHXa0oiyucAXH2adJ0jcM85gSlU+QQ
         BDSf6ajoKmgp4gmBETr2zw0CvPAlUNGpaCYXS9oA+ZBJ50JChUHGpxrJ0joC3NaIUrKQ
         IvZJO2mXNPvlQ+EupXmUO+ldGvUxDCa98ch45KuO57WIZt3yqRXOgRPTCUIjP+rX6D0M
         DMQu469klJGcSAyvWifHxFglHtGlZxS1trsK9zhptDGIXrzlsBykmrUVE+FY7yhfQIsr
         DCZYnm+fw8Gp09gSkM8ad4C3aERvOwWQvusYNw8Gt3CrjWBduIc/JXVTrNRovYiZwRwY
         5p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465379; x=1790070179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=69mrxJexhH+mB0/KG77Jb3FUWESkIXl1gYvn5Rky+CA=;
        b=0zKT0Nlbk3LtKNtQw6r3OoJZNpD3rbJR2F3KfR2fx/B6//2F3kCAqy6UfEJg/rRfXY
         DI1pQXTVxDKRlVKW+TNQjXTdOKxqpSzWwF9WDQxVu/1sKb9+/wi438wqtBsRex80S4X2
         Cg0Mp5AuJrrAy8siZVvS8IszbGyfDrVBrPWNAtjF6pLyk+t3kaaDAknBon3uFCO+NjDc
         yisZI5zB3MOxElh0MWKu74xw7xGwBb69gDJsWpZXnRKZyPtr7LVDlk3svnUPkiv2+ZCv
         lD41Gig1XgByKXnjDV2AtQwyGFKIt/q/VoPUIqyGyWVLtkhBm4vb9v7OgQ71s5eH4jma
         0jQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpoCoyPt3WZMgWop3cRMsLYCCrvstTDjZrZD4+BjheYQsGmbuTEqQabC/npyaRP6z3R5nFw/k=@vger.kernel.org
X-Gm-Message-State: AFuF++nDuiJdVmlIKGn6zpO1lrGyW6bnMVWWtUjfw2JdbDE08SNDO65G
	KsfVCgjfteEnclN/aKhcyoT8rsRbfsdYnJTY2HjscR4uxPVlLg8Mol8a
X-Gm-Gg: AYBFou1Tk41pzwsyrhkS4jIN0quZYHbfhWTxbginx7rQHYFmKC99eX+qZNQb0Uiq6Px
	UGBzrs8C48cXQIPHqe/g72a1jWpSU8oKAU6C7TuxWKub/3IutUvdz5cQ386V1JMm7en6UWV4PN3
	8Qfw1YxBz555Ww693ySu5/K/inZdkZ4eAY1PGFuzN1bmJNAtLx1Tlce+lzfFRzgo0tswDzLNSfL
	Un1mahVpR64A0W5At6UpRp2TsplTV/LO5Wza2aERsmItafxx1N7XTmcsd1FlahdUOVTr9MSZ+ey
	xGlSGipUBoMJRjRgvsiNFlnPSVcVKKOxiiqStP9tnwc5302ICO3HURstK/kzUWpe19coSTUXCOg
	kECLxfYvJoWUS9emJzVAbD9FnNSuDQCckgx/d3Gb2QLp3KrPcEPdF4lrwZqzM+FngRtHjYPZm9e
	9u47lrmZS8Pfwj+Cs5zy3sgJ9k+2qYTpAsMVVnliNSFbG5eepEaMYRoUEz8FXbMIw=
X-Received: by 2002:a17:903:40c6:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd837a6aeemr5238465ad.4.1789465378664;
        Tue, 15 Sep 2026 02:42:58 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfbeca2sm63625345ad.45.2026.09.15.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:42:58 -0700 (PDT)
From: physicalmtea@gmail.com
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	nab@linux-iscsi.org,
	asias@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vhost-scsi: preserve event ordering
Date: Tue, 15 Sep 2026 17:42:43 +0800
Message-Id: <20260915094244.7900-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915094244.7900-1-physicalmtea@gmail.com>
References: <20260915094244.7900-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

vhost_scsi_send_evt() uses llist_add(), so pending events are LIFO.
vhost_scsi_complete_events() walks the detached list directly.
This can deliver a later hotplug or hotunplug event before an earlier
one.

Reverse the detached list before processing it.
This keeps delivery in enqueue order.

Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a32..37f681aab 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -637,7 +637,7 @@ static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
 	struct llist_node *llnode;
 
 	mutex_lock(&vq->mutex);
-	llnode = llist_del_all(&vs->vs_event_list);
+	llnode = llist_reverse_order(llist_del_all(&vs->vs_event_list));
 	llist_for_each_entry_safe(evt, t, llnode, list) {
 		if (!drop)
 			vhost_scsi_do_evt_work(vs, evt);
-- 
2.34.1


