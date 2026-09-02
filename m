Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D272EEE79
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317847; cv=none; b=AlBNQtCfNwLrTiUsA3m4dJUa9GkLjPbjkd5/T/Tpe44c027lWggNPxesxxTk+KKh/WicTcBBMohJ+4ajd0Z1OgGCazSFnHNDNlUNG8WJQVIzutmY6AeugZacI9+DHNc2sEzMfT6qgmW72kRWt1PRR0zCnim/WGgLzwm1No2Yd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317847; c=relaxed/simple;
	bh=Wacwy1JfwsgEA3A5mIO2ES0XTmule57KnlkCPSaozM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpcLc7Nq0xfmu87TU7QmjyjOuXcqVsO01wwxT3T774mxms8CzPVJUbYD9hB9NFcL/T4hELkjZfIuQNzObUFLj91V54S6triZ15/vRhk2lUBMfvuvqb8pwFz72kzvdK3RtpGFZn0JPVnESJU6581eQjGXrP0x9E594l83mvwiwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCKdA4us; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCKdA4us"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c5a818a3d6so482638e0c.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788317845; x=1788922645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xL6daxuFfPtbUTZ7m5s4y+ycihoWTWIL9QNv14bsFBM=;
        b=PCKdA4usGGq87vxrWyUSAYkhme9ysHB/QBtJf0zfTkVXidlJH8dh3NWh1MyXUuNsc9
         vzS4/YfFO8UsrA3qVxko5VhFh0bLVe1BLaEfGYi0QULoRGdZwhZR7UK9LXduazPuT3XU
         LZSHzMIpaL6Dl+bT0dX5IBQk/eVcurFgqjci24Jlqyh7NwW0exPpFI4FQ3xTGb65PrlU
         Y0KMPqOfawcYPF6hSDyamnJlTmfKNq8De4tIPRFgGa3gYqQ5qC5ZjMXNPmcgW1Lhpnad
         RJrQl0IxlbCIlFijtvLHGs/iyyr1H/xW2ciSuo/CsSoXhZqMwl0Jo3NqrZ9BwV+jwh82
         15AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317845; x=1788922645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xL6daxuFfPtbUTZ7m5s4y+ycihoWTWIL9QNv14bsFBM=;
        b=hmD24PQT3khZKsyZ36ofiqu7MbvXvXYEaBSgsQksPE3fEKaxSeXcL+iHTYO10aL3fR
         8cb2rPMKEUm+v+2UomDFo11xqG7oOyuNUZxQRgmboBc5MvG8lbsLnA2R46n+q1g6noxH
         oGMCsQg5qMywY1mt8xGbEpWuGOUao2khX/mdfh8lls2d/CdDirQrYV6XSBI8dhPd4edN
         4XEmR7brpBnmM3uqc0DBkwA3jQ0PquGW59J3SPQbJYrexTQbJ1FkAUD/3a1RlfKy7n6u
         tHSkkD3aKEXpAboTx+iIMixT4yZSkWwTudZNwRPKmZfBbdXDhk60OJWikI+pwwbThGNQ
         XGuA==
X-Forwarded-Encrypted: i=1; AKwUvBxFbxj48SAkg9Ng/osKtMjs106LLaxXRhMpfYWN8fiKCGqk05KFqpdxac6qYFLXRpeezFqdeoY=@vger.kernel.org
X-Gm-Message-State: AFuF++nvhgTFgKuaKUKpS+Nwj6QpiD6vINIMDR3wujsDgBu+gygiy9mW
	u5eNDN9kP3R8dx8ufPO4fAZDoldsR0PEZ4y0ZMoY7lnv5rPK9ZW8g9od
X-Gm-Gg: AYBFou2hnUUXIovDuggYqmYVOJeGq1+/BiehpmFopvTozqYAF3iWe9uKli6Wul5XX8z
	fINcG7kvkZF5EdBYiCafy1OAvYET40IrGxTsxOb9x/UBEZU5bxGRN7E786AZEReaimZTppBjFqv
	QBcoVUXBupd2qlt1A6psxSuE70OlKr19uzS+xdZJ7x6nY6gfKpC/CdMwqh8mrgNDxW+kNlkLuY5
	NdlmEXRJoCNCMAAVzmZfnv9TQ64+H4GevtmGDDCHFQPFrqpLWvUhMIEq5s+80UahzCKcUsF5FKR
	mmUrE4HDPfhVyZKVBVl1eGMx2p4/YesqxRn9bpWrv3YWG70SAP/2giAu+JtHgCtWTB8FgWDISCN
	zrxUyqlsZQT5enSvbmS1MTNxSdBbVrm0Tn3PyTPzONQGjgZ0Rjib7vd/rNr9tyya7qpkENbM2Qy
	w7SnsyFv0CMi1te2kPXXfgyodouE6f24l0Ta7pW31Z8rgwxddcTYuB
X-Received: by 2002:a05:6123:2ca:b0:5bd:fb77:842a with SMTP id 71dfb90a1353d-5c7d27ce781mr669879e0c.7.1788317845047;
        Tue, 01 Sep 2026 19:57:25 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd8cebaesm1154343e0c.12.2026.09.01.19.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 19:57:24 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+989ff6506f5c6d1ff56b@syzkaller.appspot.com
Subject: [PATCH net v2] netdevsim: take bus device refcount before registering device
Date: Tue,  1 Sep 2026 22:57:04 -0400
Message-ID: <20260902025704.34606-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsim_bus_dev_release() drops nsim_bus_devs when a device is freed, but
the matching increment was done in new_device_store() after
nsim_bus_dev_new() returned.  When device_register() failed inside
nsim_bus_dev_new(), put_device() invoked the release callback and
decremented without an increment, driving the refcount to zero; a later
creation then incremented from zero (refcount_t: addition on 0).

Increment nsim_bus_devs in nsim_bus_dev_new() before device_register(),
and drop the bus reference in nsim_bus_exit() only after every device has
been removed, so the completion cannot be signaled early.

Reported-by: syzbot+989ff6506f5c6d1ff56b@syzkaller.appspot.com
Closes: https://syzkaller.appspot.com/bug?extid=989ff6506f5c6d1ff56b
Fixes: 6aff7cbfe7bfa ("netdevsim: Block until all devices are released")
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
v2: https://lore.kernel.org/netdev/20260831183952.1345042-1-adrianox@gmail.com/
    - also drop the bus reference in nsim_bus_exit() only after all
      devices have been removed, per Jakub Kicinski, so that
      wait_for_completion() cannot be signaled early

 drivers/net/netdevsim/bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 5c55c308487b..b792ee10b1c1 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -194,7 +194,6 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		goto err;
 	}
 
-	refcount_inc(&nsim_bus_devs);
 	/* Allow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, true);
 
@@ -465,6 +464,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
 	/* Disallow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, false);
 
+	refcount_inc(&nsim_bus_devs);
 	err = device_register(&nsim_bus_dev->dev);
 	if (err)
 		goto err_nsim_bus_dev_id_free;
@@ -520,8 +520,6 @@ void nsim_bus_exit(void)
 
 	/* Disallow using resources */
 	smp_store_release(&nsim_bus_enable, false);
-	if (refcount_dec_and_test(&nsim_bus_devs))
-		complete(&nsim_bus_devs_released);
 
 	mutex_lock(&nsim_bus_dev_list_lock);
 	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
@@ -530,6 +528,9 @@ void nsim_bus_exit(void)
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
 
+	if (refcount_dec_and_test(&nsim_bus_devs))
+		complete(&nsim_bus_devs_released);
+
 	wait_for_completion(&nsim_bus_devs_released);
 
 	driver_unregister(&nsim_driver);
-- 
2.51.0

