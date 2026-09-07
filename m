Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43243E9F5
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817759; cv=none; b=T1gRR0/JsIE5ZM9nNyN9Op72Db+jQ4K1Qg4C32f7awkdf8KJj2zcHdxIS4hERAxhxF/ALwT/U66wwlF/akPS4vS9oKYdxfmTi7f7RB7kpPNWsefPl6jOJ8hMzhrngEGgI3OklKOyPUwsp9YwOgMSU8bZU/Yl3uFFGXpXeyuyaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817759; c=relaxed/simple;
	bh=fVuHR95eyQBF/J4ZPzTKaixieq9sGMY2hzLTauqbHGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5qZuKH82sa8IBk0HxUAVIVqjktBTrGLuetOfJndA7JISl2dEn5IzlJJNVMSoFH+LDdXBwda3cyKChgN9qMKYTA06uk4kxTVbD8Da6rTMA4sbYMUqsh3BypXEMyIGx79CLBTJkqlQkc1UbVPylj1lyFIzLz0ZOphJ9mkMWXC61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQw0x/KK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQw0x/KK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d9201076b3so43942975ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788817757; x=1789422557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDegtlqKtEOKeiIQ94BVj7MD7abVeAxCvSrqyvKKvnk=;
        b=KQw0x/KKI3DnOgg3iS/CXtm796gzxJkDk9ToqVqnN0bU4XbmOVNW/TbU2RMnOvvb5S
         t+iOg4NYd4WwFmfMHpZgdcGc4VzDHmWXjgy6LzE0nDCoU6kjurf+Li+GJJaJ1KZPecjA
         sbfQxSdwgGEV/jGhGcF6ui+XXyAzng19F2pZ5Fap++0ioc9pq3vgNsUkU/I8Ps5MTxo8
         OK2A1O5eSklvMreLdbXHJ9kSyGH7W8eRrtXI9I8WnfCIYw+ATtPWkZOSEthR88DzYBqP
         Ru8fRWyM2ppm6DvW5cfV9bFwj/nRG+bSp8ZmQjND//F7YtYqvLwKBQlo+9BdkZDzFiw1
         6wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817757; x=1789422557;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDegtlqKtEOKeiIQ94BVj7MD7abVeAxCvSrqyvKKvnk=;
        b=NyOl2w6PbQjP1hfXkiZBRRreEBaMz1ZCVAXnMoupCYfegZ8Y7Rv6w0A9xJs0/NTeWy
         TKacmiSUYbR9IueVzUzkqc7edMNUCvLQhANZe6G8UEwb1PV0Zs273/yt0jZsDYu8MG1S
         v9QL1qZATG5MJLhgLWPwNkU71rNDaYpuQlFczfJChkCyB71uLJOACCdVtk61ZrCtBWNk
         bUIZuQtmpGR/oXhSBbaNduBE67CPV10pbhAN+KmrRGXTp+0TgCNYsfPAypABBXZHuBzR
         IDAckL0KxkQ8ULW9+MRqvjW+UvaU+iMxHaA6cOMT9LGRaqcq2BWthMJkIXenC1KElvrD
         Vo1w==
X-Forwarded-Encrypted: i=1; AKwUvBzWyonArFEIt7eHyOhKcnZeTRIlZUKYpJTGIuTNqos316NoKJGN/QxGm513/nI0I3MugICJSRk=@vger.kernel.org
X-Gm-Message-State: AFuF++nKp/7PdYhnb9J31QYVvUpMPadsf6PSzfGvCq3z8sM/TaYZSt9C
	M7lIL9t1LXCcwc7KPwLqEx+B+oSZ8JjVBvKbTQrPjbdBb1wDO5STZS3h
X-Gm-Gg: AYBFou0tjpV4W5lQE9KDv7caEd6Tc/IAnxweoEl2SoPCu4mZibqZrXRFnht205S+lzy
	GBok8fOkHM5lJ6OdDEsDH77MSgBy3aNZnhVaA2Xg/WocbksYGrR5oc+pfyNhnIw4pHSm5yzd8YI
	EOayEl/qt5zA/sc5hvRtnw3jUt8xWcjVG88Y1e5Bs2lDXbysd37eZJsWy9coT5gfXBaGdmoGNlz
	dvYaYXVM2bxfbOtgOY2Yr4vMtJrCSl0yb9E5rUuGlHu3TRF+GkzGuFXyB95MDvxjQBVTFJHMvX5
	2YJif+Q536m30R3418Y6BWIEArwlr2KgUWb2QmrP1ObMbC3cbH8fdMMc7l2wXKRJFwSbNYawgzJ
	BefEy32S4I+YC5+skMSXzT6wRmAuJBNfKo560O1OoObbU36q/PzzfC9j42s4wy9FPkHTpYiTHX5
	gIFxla+h6eWGZm0XCDPjEAmL5akRPTMIu2u8ZacB7m3vpsbmFJqfix2TSjIQ5tb0uuPmaThEJg0
	pDLd8PQKZ5OE+oGHESJ1qj6fTWFuAa+M1CwFK4IDkE=
X-Received: by 2002:a17:903:1a08:b0:2d8:d4d1:3139 with SMTP id d9443c01a7336-2db126289c6mr374641315ad.16.1788817757159;
        Mon, 07 Sep 2026 14:49:17 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841eaasm48794155ad.8.2026.09.07.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:49:16 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/3] Drivers: hv: vmbus: Fix error paths in vmbus_teardown_gpadl()
Date: Mon,  7 Sep 2026 14:49:00 -0700
Message-Id: <20260907214902.9046-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907214902.9046-1-mhklinux@outlook.com>
References: <20260907214902.9046-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vmbus_teardown_gpadl(), the return value from vmbus_post_msg() is
overwritten by the logic that decides if set_memory_encrypted() should
run. A failure from vmbus_post_msg() is lost and vmbus_teardown_gpadl()
may incorrectly report success. Furthermore, if vmbus_post_msg() fails,
the GPADL remains active on the Hyper-V side, yet in a CoCo VM the
buffer will be re-encrypted anyway.

Fix this by gating buffer re-encryption on success from vmbus_post_msg().
And if either function fails, mark the buffer as decrypted so the memory
will be leaked. The decrypted flag does double-duty: in a CoCo VM it
indicates the decryption status, but at buffer cleanup time in all VMs
it is a "should be leaked due to error" flag.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260904160724.82AB51F00A3D@smtp.kernel.org/
Fixes: d4dccf353db8 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f4370617deac..cc86e8505ad0 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1059,14 +1059,14 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	kfree(info);
 
-	if (gpadl->decrypted)
+	if (!ret && gpadl->decrypted) {
 		ret = set_memory_encrypted((unsigned long)gpadl->buffer,
 					PFN_UP(gpadl->size));
-	else
-		ret = 0;
-	if (ret)
-		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
+		if (ret)
+			pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
+	}
 
+	/* If error in ret, mark buffer decrypted so it is leaked */
 	gpadl->decrypted = ret;
 
 	return ret;
-- 
2.25.1

