Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B72DF134
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424578; cv=none; b=sf0WHzHYjayjIby2BsdfW5EILoGvwF8+ezUw/xxi7MdYNrxszcZ4u3WajfNgDf6kC21ePflAcsmXz5Yj9Wp6SHdPU9kysBT8K75r/w+4znqpB4fxv2OzUjTWvoAmZNOrVh+N/zdjbQWCrBUO04rsH8BxWheTsHGbkHLg8yPGDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424578; c=relaxed/simple;
	bh=foOHSdJTOJhU6+yYWGeeQMxkB0Vsh9TMpxUCdttflIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bem9HFgE4krY4ihBSXp1gGaEwiGUOUGRo103/zm5YCIOWpEshjGbkFv5B7/rhD5YJ8gM1ydHDJSTzAMJVyoL7uEuc0f+XuBN6dpV99/sKeHDDsMglRa/pYzMkfO2hbfNHJxCvYG5pWfkIaFn0s0rSu+iGP8Orzu9ojSOOi60q1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn2h3Z2u; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn2h3Z2u"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so179990185a.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424576; x=1790029376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYIfd78aSnlkErTq0YH0tchJ7mjAaSn1gqbunL7HHbw=;
        b=Pn2h3Z2uok70LqsU4yQ/B3TILoLDCbxMRrR3zovCCuHHObDc4JUk/uZWyGZsdcOczJ
         N3/Eh7eAGtQ6bQpdEwfVtohbS3U7L2+s+BVo8FbzKenFSImnCiej50fgaobG3rCgLr6Q
         JajI3aGB01xda2hlCMOHwXR7aRfVegKP6RVEPNMw9no5hip+iA8pfjNv6GaZXVcrAZU4
         CSXKTlZf5j3vwznWwshJbvQ66zNwKV8+BZgNoav2VNs6+bRyBWLhd93sQzI+tO9SllxD
         dZ0SmGttwYDbg81hWtsQQT7ggYCyjwj9aRMyvDQPMIWFUHnE7U4CbkjAUEnEfzNcdaSX
         bTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424576; x=1790029376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYIfd78aSnlkErTq0YH0tchJ7mjAaSn1gqbunL7HHbw=;
        b=d5quhw4SQGSURo9GRx8UwPYm8/hExIn0HK3xjK48WgUr6gHE8UeVup0wfvNfIyUFSF
         WondpkuelJPquW4XzXqaDN+jM+sNmasIjYlJroOOgVXtc0+G0MJ7Rl4egc8IAME3WwuH
         h0XTGlkQc8esOd5LN8FQ1UwmU67/31SanZ70WrmQrY+W9q3FJXr+xSrg+uCHU28SQNR2
         GIWvFLXdiC8JXhrrfRvrtJRNBpQNt8nV4q/yd/PlDa2y1fjYqxP1WhCNhnh5My6f002e
         zlfu2V35Hx753Ipm1rh1rTV7Mh8Y3RhKfa8+RNlLzQu+z36DRQJX86P75HaAa8Eoh8T3
         HgBA==
X-Forwarded-Encrypted: i=1; AKwUvBxXwcb5fV6L3td636gsX/eo5ItGgPJP3sAtkgMXXyDEv0NVMUx8vhjdpzDGcde43Diw28rpgSM=@vger.kernel.org
X-Gm-Message-State: AFuF++molVLbxrsMbr4JSkN4e5bL9rx33k4UArk8HsgdSGQbq6S3/59x
	jYUM+F8eP9e34A8JflKr8l/Yb+0KfdH3/y9EoEVuqEThmf1NnHzZwrQ=
X-Gm-Gg: AYBFou0rRHMMShw8gfokpXCWRirLM5U5JwlHyiXrYEwlKadCy2wB3KYTZBqkn5S1jl6
	rHQPdUtWNbTcnXTNR9YcYPMIVMqRZD0KZOl+kDuFV6p0rK+LVNBpeYr8RfcHAgBH5AaQj/sqZeX
	PR/1OQpQG9Y4GHG8YzdIRf5Y6lIVIb0HqIAoL+XlfxBXr/GxIt+wEFZ6oG5+VRNkcZ54dCeQdOW
	IMZkknP/9+NsVQlpaSbZhyCc1U+B2i2oIHykHlAKUxe6irdwO8mnBl4E6Hne/FUgbQJ/mL245is
	0XpM5xOUONIZJW0gDE+3dVXItfoBrMht4gD+8glG5Fj4S8ET9ZWjrbKwhrFUw29c/xexgg6Oi0g
	4mnCH7I8E/N2/YhuGM19Dk/6CpxhtRYSfyG3X0QU5lofajxyP4tyP9DYonbTa/1kpIPb761u9LD
	4BoRD2NGQFYl+nchdAWqAuYQzSKTH0xxudYISZ2WHZ0CB7bx8dbZzLWONpNTtZ3eVjvoTI6d0Kt
	C44GoNus3c0b+vfg/MbiJ1pc4KaO8I8KQvDhwZdu2UY/4yT+ORQH/WVrDW5AXACzDHbuJgDJbJg
	K3Zwrs4e/8O+o71jRKkHGyO0lIVm5St6VCw9khxuGJYDSXhKN4ut7Uvice0WLszBPL2fJw==
X-Received: by 2002:a05:620a:468b:b0:936:623e:2603 with SMTP id af79cd13be357-93a2985c9cfmr680154785a.17.1789424576182;
        Mon, 14 Sep 2026 15:22:56 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45adb3sm104283876d6.9.2026.09.14.15.22.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 15:22:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] tg3: clean up PHYLIB resources on probe failure
Date: Mon, 14 Sep 2026 18:22:46 -0400
Message-ID: <20260914222246.29761-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tg3_get_invariants() can register an MDIO bus and connect a PHY for
USE_PHYLIB devices. If tg3_init_one() later fails, its common error path
releases the mappings and netdev without undoing those PHYLIB resources.

Disconnect the PHY and unregister the MDIO bus before the remaining
teardown. The existing IS_CONNECTED and MDIOBUS_INITED flags make both
helpers safe when initialization only completed partially.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 158d7abdae85 ("tg3: Add mdio bus registration")
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Remove the redundant USE_PHYLIB guard; both cleanup helpers already
  check their initialization flags, as discussed with Andrew Lunn.

 drivers/net/ethernet/broadcom/tg3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b..91c7ad997 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18047,6 +18047,9 @@ static int tg3_init_one(struct pci_dev *pdev,
 	return 0;
 
 err_out_apeunmap:
+	tg3_phy_fini(tp);
+	tg3_mdio_fini(tp);
+
 	if (tp->aperegs) {
 		iounmap(tp->aperegs);
 		tp->aperegs = NULL;
-- 
2.47.1
