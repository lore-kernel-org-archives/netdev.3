Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684811;
	b=5Sgww1A4u4Gr797UiSVTnEK314FXQ1Tlch4ehmD3yDioQWmdru+um/4EtyVB5PKDNtG0
	 pKOM78pBALu5GsiNzXk8jzvAAgUHAEF9257zKByL/CHH6kDfN8+P/zAsSxE+WGES3ctqA
	 JbocEFRelAy4jNj4mY/busXrWqbGEQ1lePUZWzE944RDfXY3ZF18m3LAz6vM9gD648VRm
	 3dTL5GtJ/EvNikQV/8vQ0LDN0szXmknAJ01HyZJ2R/3RKAyGOsrAA57Me/qpW+2jQliCt
	 roL74n3fcH00WiRTQfm97Ub0DIV1DJyNQJ5CQyQAwe59eZAeXnFFDqRsJrUMsL47r7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lo4FCreUTiir8SKV7eM8msqoq5RBMwL2rKg855Qwhvg=;
	b=NIoFHunbgWi6pxeseWIY0J15UGL1SvnkA6RY9ujwdMcFlDT2HfMmhhzmJlosoe1DfSVR
	 t9Lt39Gup8FHkwpTNURaOkNmNEkOdxSFmBPMpWkM0ujVkgH8Ug5b4XMqKM1Vm49AdBrw0
	 LHDNpTlvSGMO7IaIFylR9xDtWvwzqXv2WnVcVYyhZo+5WU7vyaaBz1PfvqSXAvwCKy5rB
	 mh0YpolPKE7V2+COX5NC1dLp6lN3v0LF/pWbjr3zaURI+k1Ac1iQaFi5ASvzFJClydf/2
	 VeJKmEUklqERaUMoUmnUYAsehEqzv6rZmppRnrtJN7aVPKkopSIqJYzQ3xNz8mxa1bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nDIvaLrV;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C9606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 087C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nDIvaLrV
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so835281a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684810; x=1793289610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lo4FCreUTiir8SKV7eM8msqoq5RBMwL2rKg855Qwhvg=;
        b=nDIvaLrV53bR4F/MUemVE+cfZad5WD81rvNvPGjnY5+oSyyou6RnuoFJaqHKl3jGeC
         2lc8XE0lsXENk6qTpZClnwWIUHKxrzc+NzkILamfd1kQKU9UpECQwmQS48RFQSO5U2eh
         C4IirFlmwzcEhAh0X1xcSBrkue8zn571e07gzKJQ75JJTCvB5oytCwfRhW5GGCjyYGAM
         b5rel3jVamtoH4YMKA5ZpEBaZMazoZ9OUWbYNYxn0ec4j7shlqZvibM2gVnSO1rIN8hJ
         4CIpRrAq54d7Gch0M0VRT50Z9l1ZP8KZrpuhapzCvP7RcWhWh8HDmTQl2FIFjRfmA4Tx
         igmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684810; x=1793289610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lo4FCreUTiir8SKV7eM8msqoq5RBMwL2rKg855Qwhvg=;
        b=bH2Bo9cOL7CNJNWBpb1MxmjSpTIyJgVSdd66vO/Ho12TIu7SKcSTq52uP0xKcPU10N
         Zw7ct5cEcNeNzDEb2Gnv5h9gDIt+e9wCINosoYSZ+6cn+WTy7gMnpcqUE9o3VSdi9RW3
         rP4t5oY6pRyI+kRhom13MvDvLFia1lPxUNyK06QtJk+cG9BySpnpT8tvDNyUaFppXSW8
         VTDCWr/F3xHRLRHSbhxupBEoYpa3AxLEHJB8Y18lZkiHI+XZxLfYiKx2fRd1ZTAbkm6t
         JGImI+ZGsk//X/LhbGN1i/MRCPHmR3nIgBdXgjMqw8UXQxXOhUVlbJOHMneOh4aL07Cb
         mB9w==
X-Gm-Message-State: AFq9FYJho//PiLf4fYph4YsCkmIIX4aPOBbpwzYzQgJgUYbXRBMDaubn
	065ZlObLnNavvlRgjihofri7YDnykLinQZdXEv3gLRO24QBnvsrXaYl+tgPw1MQ=
X-Gm-Gg: AYBFou0n7tjXgZRL+e4ey5HfQLNObzlP6AF3SZbKsMNCde04Gp/qCLTLpOIvowXXNwn
	D4HLNWn7W5E0l0gCPIqZH9ptsVVf1YFDcvo86aP01wz/yCIWPo+fRxmKHgWwV/oSYPcf4TJEmOD
	3bVyWn0ZphcF693MTihWizjESLvc9YxAT+a2ZUcjCee+c5vx3O+45ZE1hYApE/bn1xMGmO5mXGx
	/fPtbGofmt4po4vWqmN0wbEGv3Z44+SbyIDs25gTMft5o0QVHWFuxvgTjUyqglfH4hSxjoW7OEy
	2UkqP/CMxOqBiXV0cVQ5vQRxVL3PunffV89KhAzrAfrkQI/ez7Yz8aGvmVrDLT+Ts6T6lcHGiXp
	Xw0g/PmWzHP9cgOPRRrdkwXcrrny2AiEIi1zZnWnILpaMmNqIaQ6bV/hn3RYSu+dWK3CSeMScZs
	QwhDbeRvAxd/VwgwiK3yVukCrF1u6HsKIdv+LK5pqio2hJo0zPSs1OyS/zG9DeH9orY44BffJan
	NeSiTWotIZDdlwiRqzYsm+UkZ429n/KeUUgPJKwj6DS37tvISuzxO1kc5dw24V9JD2fXzlJIC+g
	azlPkhABvMNuiwSJ
X-Received: by 2002:a05:6a21:7e84:b0:3e2:8f28:461c with SMTP id adf61e73a8af0-3e28f2850d7mr3429241637.60.1792684810211;
        Thu, 22 Oct 2026 09:00:10 -0700 (PDT)
Received: from localhost.localdomain ([2406:3003:2002:639c:c9:b354:e289:b472])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b85d56c4sm1369348a12.16.2026.10.22.09.00.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 09:00:09 -0700 (PDT)
From: Yige Jiang <yigejiang86@gmail.com>
To: netdev@vger.kernel.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH net] net: lpc_eth: release the PHY device node reference
Date: Thu, 22 Oct 2026 23:59:55 +0800
Message-ID: <rc-review-20261022-ai13-13-8a866c920a94@gmail.com>
X-Mailer: git-send-email 2.50.1
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

lpc_eth_drv_probe() obtains a reference to phy-handle and stores it in
pldat->phy_node for lpc_mii_probe(). Neither PHY lookup nor connecting
the PHY consumes that node reference. The probe error paths and driver
removal discard the stored pointer without releasing the reference.

Put the node at err_out_dma_unmap, which is reached by both failure
paths after the phandle lookup, and on remove after unregistering the
network device and MII bus. Both puts run before free_netdev(), since
pldat is stored in the netdev private area. Earlier probe failures do
not pass the new error-path put.

The PHY device reference discussed in the linked review is a different
reference. This patch only fixes the node reference, which was also
mentioned in that discussion; it does not repeat the proposed PHY
device cleanup.

LLM assistance was used for static ownership analysis and drafting of
this change and its changelog. The review traced get/put pairs, error
paths and teardown ordering. No runtime reproducer or hardware test
is available.

Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
Link: https://patchwork.kernel.org/patch/14502432/
Assisted-by: LLM
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on net/main (305deb54c6c2).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
Both allyesconfig and allmodconfig completed kernel and module builds
on the unmodified baseline and with this patch. Unchanged objects were
reused for the patched builds. No new warnings were found compared
with the baseline, and the changed driver produced no warnings.
Both configurations used CONFIG_WERROR=n and DEBUG_INFO_NONE=y;
W=1 diagnostics remained enabled. CONFIG_LPC_ENET was y and m,
respectively. The unmodified WERROR=y baseline reproduces the earlier
arm64 syscall-table override-init failure.
No LPC32xx hardware, runtime or fault-injection test was performed.

 drivers/net/ethernet/nxp/lpc_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 8b9a3e3bba30fd95258a9f58699af4a8f82ea04c..69098845baac0e4d1fbbb062c2a767acef7d266a 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1397,6 +1397,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 err_out_unregister_netdev:
 	unregister_netdev(ndev);
 err_out_dma_unmap:
+	of_node_put(pldat->phy_node);
 	if (!use_iram_for_net(dev) ||
 	    pldat->dma_buff_size > lpc32xx_return_iram(NULL, NULL))
 		dma_free_coherent(dev, pldat->dma_buff_size,
@@ -1435,6 +1436,7 @@ static void lpc_eth_drv_remove(struct platform_device *pdev)
 	mdiobus_free(pldat->mii_bus);
 	clk_disable_unprepare(pldat->clk);
 	clk_put(pldat->clk);
+	of_node_put(pldat->phy_node);
 	free_netdev(ndev);
 }
 

base-commit: 305deb54c6c287e586bed92da2375ae1220e8dde
