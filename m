Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA42463B88
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619492; cv=none; b=Oszrf4gODp6BeUxGbUnGQFG7amSuBphtwyc9CSynKIj/Wg19fHsqsRlHhhWYutIY5M7gFw598J7DKq3kut6nbdRIunhoJD3W9IsATtExfE/u6qYngCgK9HK0N+8lXMIqWiiCKHuiitrFSP7mjUO3qiYkEVeeAH3GFWNeuGEwDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619492; c=relaxed/simple;
	bh=L8eLq7Qm3UuoGSC4UXqkZXfZADebiinqp1i2LamOE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjcuaV36PdD1apjxfoOK+TAoVC/slTErhEzkW4chQJD4PS8l9M9IibTmg+Ntu9494ACLs06vFCQjTKsoEpuJaZ1B+4/+yNmC0O+q1N1DUv4UFigYw0Il8Lu15rsbH9qKatDP1hynfG5t/Uha97S1OgQEHcq2xWIYr5I6horwCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuLC3MgX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuLC3MgX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbed97fa26fso636078a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619478; x=1787224278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=syUOEB5wjw/fo+IZOovdWljSkz71q4FOla3Zkj+XcFQ=;
        b=BuLC3MgXJyXZZj1bxeOLtBbzFw6dRauxW1QRaRjbv5wg+6ml8caNRbPgnVen3XNSBv
         tAGzPUB47TotcN7/KMjzWn0eNZi65cCmLXAVxGYCL87qFYILUcU6A+eKJh79Ams7itok
         YGo3UilhWYE5VZ3NUdsdaB1I467pZLaI2C0dECRkZzlni9EWnuIJANmCg67hi+V3ThJW
         NlGMM5Ky3jEMUjrYtqsoTi6W3dWS5lNoD4OhTy3PoWSTOqPHD5yOTDOY4x89MuOqlKTe
         6PC1KXep5UGGG37fRnT23i/RrcwgN+RRzKx/Kct4X0PQ07HlGoFfp9nGqj5wpE8Xs323
         vjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619478; x=1787224278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=syUOEB5wjw/fo+IZOovdWljSkz71q4FOla3Zkj+XcFQ=;
        b=It5t2h/YQP3x0kB20fK52g3xIu1/N0SpEZzId7l3iWxVPwwjJb0oRonmg1FNPP/l7x
         x8ksSH2iOY29JDpJjP6uoVsuyVg1mTOD7FL3ory8oHN8pMVDIT5+foRqXRdQ/hYJFkZw
         DG4weBMyloFJ+P+cTIIbwJBRWKm5iZJc7xQ7cAnRIuUReoQfIHCJTrNIhbz0kIm6sT3d
         7JO1wcBiL2P2tbzg6ScGcnNvHRXfcY/d/i5/6zj6SnSfVpkoJG5ofXV97Vc+WP2UYa7P
         qZUTsa3FQV6T3ONUgKxYbPJMNCANZfzUCtZi7VrosNt3oSnfcreluaFVqLALtEEp97Co
         lgQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxZtu+rtWKUQRWwrrdhoguQRhheIqSlyPCBT1N93QI06I6cJ3Y78NECr0gO2FHXSA2s2et09U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+r/Y+HJA1DiYkXiT34PI93Ogoe86fEHakIV3dRY2Gu/oWwXw
	Kp9vvJyhH+m8+AFKh/3tRvznfsv3nxo8VC1GEoeYq8XGPD2w06eV0oMd
X-Gm-Gg: AR+sD121IsrucG/JtnjITPFS6Q8p1Z0Ji6JXpD5Ioo9V7FgSzQPJ3L0WbaHlYWRAyLs
	rczGS2POolCh739D694LDji1wJcNUL18aFsIPDSpvjOaWsVmU7qZxX0FbFOnFx5snOTqgvDGYV7
	EyTl5pNQ1tqOcEj7yqItdAMV6/YRDkgk83S7IqBXoGP0KZ6/Thkg8gR96cUaa3DZz57tvc9VQqO
	zFmKZYw6XRihQjvA7lZkCchQIVcc1rnGqrEh6YTBGuuIvIg0bW/OrSyPHXM6N9N8i43s2/KOlQF
	7uesYohw+OnIrpS1h0J2n24MuNYkr8ZSIrs9Wx3bsrYhU69D5BY4BsNDfQB8mHPsumESeyhtXC+
	YznpKbTYoMaiVI2e/q25wPadOpUwHGTsOCrX1SCGLpqJ7G3+k5KHp52nR05M2JPOY0Anbsc8WLX
	PhMRanSVWYm9La2lK+PzMNrzElIqg1ecjbUFo2Ai20RSatkNC4eK8GQPvkNTuFQbGYz2PevhBAO
	SVA+WV8eQXywqnWQoiNtPQfIHwmzluFnIFLNONZS8GNH6NK0UdsafuKgxjzwfdhgVSRBgmIgcX2
	IBLfTQReNcbv
X-Received: by 2002:a05:6a20:244e:b0:3a2:c9a1:2c26 with SMTP id adf61e73a8af0-3cc57372d8bmr5402750637.7.1786619477495;
        Thu, 13 Aug 2026 04:11:17 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d961e39sm12653976c88.11.2026.08.13.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:11:17 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] net: ethernet: ti: netcp_core: fix device_node refcount leak in netcp_probe()
Date: Thu, 13 Aug 2026 16:40:58 +0530
Message-ID: <20260813111058.500-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When netcp_create_interface() fails for a given child node,
netcp_probe() jumps to probe_quit_interface, which releases the
"interfaces" parent node but never the "child" node that the
for_each_available_child_of_node() loop was iterating on. Normal loop
progression relies on the iterator itself to drop each nodes
reference; this abrupt goto skips that. Add the missing of_node_put()
for child at the error label.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 drivers/net/ethernet/ti/netcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index eb8fc2ed05..a888aa35fa 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2271,6 +2271,7 @@ static int netcp_probe(struct platform_device *pdev)
 	return 0;
 
 probe_quit_interface:
+	of_node_put(child);
 	list_for_each_entry_safe(netcp_intf, netcp_tmp,
 				 &netcp_device->interface_head,
 				 interface_list) {
-- 
2.46.2.windows.1

