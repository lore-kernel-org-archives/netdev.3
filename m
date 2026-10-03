Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEA35E1A8
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036578; cv=none; b=g4xcwZP5PS8LA/7xQo7DRiGH2vmx7GxTTc7h2NYWdyc/xMPqd1hJWyMLcht6r1tkmaZuGx5iq8ziUIrQzYH+6QeCqid0ixqN2p4bUpkcdEJwDuXGfu1+h+mlfKU59loPpECisl0amnvlw7HxRBqLjY9O37vYFVaxab3xNOiw3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036578; c=relaxed/simple;
	bh=YbyQY7JoE6UOw92mTJzHWd+BaqMC9pONrFNAMHRtJ5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXg+0P5cRojnm+mwub3z/LUMlvTRPfHiYmooJHfxrJPEBqbnrwKHH/ft/Iodoku1j6y1TlejmXfuqda0ba3fTve7QZxnOVcrQg6f4tmghyNsdVC1GIzGlgd3E289Pe8PeHa0jc6zGDhxn6biOyqmK/Zs3nbxago/kyIOEfkMgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGCRv4w+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGCRv4w+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so5457755e9.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036572; x=1791641372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rG4jTd4nM+pkECs4oXcMHGsR3oQ3Ii3v3Uq1Mfg9zkc=;
        b=NGCRv4w+emBtEM2pyi1sPC6sQnAPbo63O1BbXiMnUFsqnYmydzQkRg33rqQ/W61KIT
         jYSKHiM8EUUR77NIfW1MMz0J1To3mAvJZz91/FZ/jbg5PRtTP8WJsjA+bjIV+FW3nNpP
         1QYn4w/gxSrNpwUeOw/wvaEtFiq/vxym0Tp24m3Qg4kIS4/eWJSiF+I5QdxesvpcJF1K
         FxNmY3shlVJ43q0g1JG7B2HyIJdwfmgFOl6in7xohvW2AHMHORunDoX+gBkN3vFciGLS
         wt0jZ3wcB6xVvKJp8BmQLxjChr2QTzzL9BkeYzCQfyQi2oxOWkKzqsLZqk0EORxvD+EU
         AWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036572; x=1791641372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rG4jTd4nM+pkECs4oXcMHGsR3oQ3Ii3v3Uq1Mfg9zkc=;
        b=XSHrLehgzBzr77uNeYXZYfsOKG8gKrNBDcYiiqEMYjzh9hxLTAj8HhhcDVm5AGqtqp
         v0wXo7DcpM/MLUkbQGk04jy8MVFPFUjK3HyJsjEXYGje1ilfTBN07lsNbsezBRoUOYz6
         7K/xArZPROSKRLhZlpqDFzWms4LBMX/qS9D3QrdTt1Rdbe1rV4MdvnBRoiyTDjfKdJQK
         /1rarZTjT/zCleIwzx8U7jiPogNzMEcgPo2PXeDCThlKhFyAf1gYTePUpRxnGcFOJCtI
         WibtQoCxw5nXv25inLZhY4Q3XxoVaXx1arRbvmIU6dP0pWulPA6KkFJInFND8wJ1oHRF
         el2g==
X-Gm-Message-State: AFuF++l8g/rg5A70roV6PHZ3cOGxX2wmwuC9bN5pw7bvZHzlZyZS2kCn
	SsWzkz1TGFHTaiV8UsVCqJJO7bVxkqEGWUJo4SELrIAqKnasWOVOAwduEW99cIkm
X-Gm-Gg: AYBFou24ty85vAla/WE8uSgq644SbELw4M7y35eSxEMvgmghwJyZrSP9a+ELuQ8/+HS
	oaDM93MLOfj5ZqzRt0Ce2xw2e9xFzW8nn3m88m0BE4huV/q93f1bywI90ZJ+5uGpiz3BWwNuGjr
	jya8NMf9GCQrpKkKg3g7PM4RIYupudf7p0193U2ectVKEzEaLXLnL95W7180YT6nIgbqYA3Cfx1
	yfjYuvaYMBOlymCq+FyKC1o+706NbHXauhotsQJtWeAF8l1s8Lhe6Qv598WBh+o634CI43x0ODn
	Yv+Qrz1D9nQ/LXK79Z48H+dmfBByu8ZIRtVhyNM3HshUyshKRXs1tpax8RbwxWCDlNPgEryAuOj
	ZOctZZQAYGbplug83QSSahgX7Q5aXa/ZEZDHZDUXj9bqmr12MtQ11w2aClj6RMrplaKvjGlqTy/
	N+rpSpgqGK2UUYE4qX3dSlpi0sSKYYLpaRWMNPFB53v6h1gtXWZ3tTZjO5Ss7Bp0NjoFkknVeCx
	6q3YbJ8WJVkANHdHQQHlkMHfwWRqabxiikh9PGTSPMYIXkJUDHpG6uHdprmU5sqwkO11o3MiGUl
	O06zcBx/4denmQYVQuxgV0wJAczmJ8vXjjul93srZwMyV4TFooqgk+VdVV4gyXtOUnVmwAQZUM2
	74w==
X-Received: by 2002:a05:600c:6208:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a0278d021bmr94872445e9.22.1791036572164;
        Sat, 03 Oct 2026 07:09:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: cpsw: unregister secondary netdev on probe failure
Date: Sat,  3 Oct 2026 16:09:14 +0200
Message-Id: <2f459154f5bca89a07dc978c834e98198c08c331.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers both netdevs in dual-EMAC mode before
requesting its IRQs. If a later IRQ request fails, the probe error path
unregisters only the primary netdev. Driver-core devres cleanup then calls
free_netdev() for the still-registered secondary netdev, triggering the
reg_state BUG_ON.

Track successful secondary registration and unregister that netdev before
the primary on this error path. The pointer cannot indicate registration:
cpsw_probe_dual_emac() sets cpsw->slaves[1].ndev before it calls
register_netdev().

Reproduced with QEMU fault injection by forcing the TX IRQ request to fail
with -EBUSY in dual-EMAC mode; real hardware was not tested.

Fixes: 070f9c658a59 ("net: ethernet: ti: cpsw: Push the request_irq function to the end of probe")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index aa3531e844e8..4fc59f9f23fc 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1550,6 +1550,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	struct gpio_descs		*mode;
 	const struct soc_device_attribute *soc;
 	struct cpsw_common		*cpsw;
+	bool secondary_registered = false;
 	int ret = 0, ch;
 	int irq;
 
@@ -1717,6 +1718,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			cpsw_err(priv, probe, "error probe slave 2 emac interface\n");
 			goto clean_unregister_netdev_ret;
 		}
+		secondary_registered = true;
 	}
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
@@ -1764,6 +1766,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
+	if (secondary_registered)
+		unregister_netdev(cpsw->slaves[1].ndev);
 	unregister_netdev(ndev);
 clean_cpts:
 	cpts_release(cpsw->cpts);
-- 
2.53.0

