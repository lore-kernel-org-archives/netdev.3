Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1045C6FA
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315587; cv=none; b=MKFQoj3CRLaC10v+hyjA1H6XZm367RbB1YT2i0UKwIqPoF7e64vOyKO+nGhrZZK0PwFI0/Ug6xSQ7x+9N5FjdSzXdV203We16LiK11rnhPzIGtxTJm3xUN504VjebIKrkixhryrY4f/zYvzxuSC4HSvl/hbSDIxzcOY5qJH/nYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315587; c=relaxed/simple;
	bh=ted8Nqhv6voTSYHCl9+q9OBe28/qoGkzt6JgRabQDFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SefhFLIxbWudRPoCKHc4aP2YKMWeSI6zZRBZAnuIUMn2SAhOP0qLnMJKxQ7XpyJpAom60n1aluWT0Ls4zN2YZV+WFFwfw2bWPsIp1cii+YvGyGxW1O1vHor39u5A6D2DN1TZ/kIY40xv915S35M36cwvJk5Cq0Cr/RFphUypiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZJsD/tz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZJsD/tz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso7263735ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315586; x=1787920386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hxifr1UYcEhHY7h9xgxgiO7sFgG/cENK8WDrS7E9Mf0=;
        b=HZJsD/tz9O8KU2CRON0UyUg960CfyzsBHajreQw1ekwVpqqIY6tHFOwAChqlXutdFh
         BpZmIjWAit76mVjtx7kXVP+sDOSeCCewTaXvV+LpwJ2C1aGT1CTPtzCD5ViW1Bvm8dQL
         v8hGU0RQTOWnwcMmHolg3XJxU99npfmFHResxMDZjOXmxIdclSzgYWcKgaKffOifArUL
         7H+qEmtNYssPZoycxtgCL7QofZeLK+I/yPa6ejkhvsDDHesF+O5slJaDzxqlYza3zceo
         alB0LNp/ftPoGokSLVYawVvXVMZlzEgFTri3SHJFyHB32r0+h0TtedwR1ktLaEGGpebw
         n4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315586; x=1787920386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hxifr1UYcEhHY7h9xgxgiO7sFgG/cENK8WDrS7E9Mf0=;
        b=MPlzcymLl8Um9cd5xBqeHxIhGTsY8FyRf52mmfelZQPoOhnbBvIF1MzTefd8mZBnm5
         ZQCCz5CAB40aXrQNDtNEcQcFw4G43dUOKTO++0scPrhz+v67NxzgLgjMrNN7Cin4QuUb
         2iECYkwA+W8w13TwZ7/w7N/LjRqoquS9Xby2L/TwXTRwUobGVoxDg+0ctUhZadytHqaI
         //19DCUP1whr2aWPPahrysH0WQZsvAi3+cTZnT20Yo7uPVvSn+j5vB7wtAmT9FlrJHQE
         Q3aXvsFHHceXW65HOn3o/CovhrplLYvpIS/bPCpMjb7EtV0pMP3a3xPmgA7TqBMO7T6M
         3Iqw==
X-Gm-Message-State: AFuF++kbcL1DBCh62XLZOdgwlpbuH/RS4rmb7gRy+hY8VS+XwHWNP35J
	rHrj5dkITM48PzPe3zZ7Ru6TmgLArcc6ctzsr1qRadNGT1J/kkHVlK7Q
X-Gm-Gg: AR+sD12M5xPFPbRk3Qwe6yihj/aTpKopCTiRZY22cWJxdoCEw9AJmbLLqmVIlDWeDn+
	3Dvno/UIJAF65Jte50UPif+1fwbjgcQ0RimjoevDuapt4mUcPOa/8RsKMse4FDDwlzoNaIZ4Izl
	4O3Vs3SAHLA6g43Ymxfn8Suu49tRuQEjpmI97fqJR3tl4Rrmq+LBSfPd7e0CUgMR2LsvDavaEcQ
	mXj8wjGbnON5Y3DzxOnwcu16wHMTnFbpNBSPiUDDuHwNfekSr7zrga2XVr0MPB+LV9SQMEPxP+T
	YQZ7Uw/tJCgr6p9GMjH/+iuqKrtJV99FNrAnFxOKo3xFAIJ5AQkorYpTTrXWvhF3/NsFY+OuUQX
	KB2KIVvjfrIBcK+6wM8tgNvmKOgtv3/Sf/E3rU+YA7BrxX0BrR3xiaDNizzhbyMRmEynGgn6vSj
	4AHMIjLwLjr1z5n3wL5r2jgm4kYmcmdGmvYAZAl3C5ZO4DDEwaQ4qA7XD8rWOjkOf5jbn2Ew+LQ
	DuD3wrv6dMoJCCbyuR0J88fRwnV/cgaPvyENB6Lip02vCiwBsTrl3mueMvH1XfnI/IpyYXw87Fl
	wVXu
X-Received: by 2002:a17:903:1ac4:b0:2d5:cb05:49e0 with SMTP id d9443c01a7336-2d64b0162efmr128195065ad.12.1787315585738;
        Fri, 21 Aug 2026 05:33:05 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1d8sm18402285ad.52.2026.08.21.05.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:33:05 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net v4 0/3] net: xilinx: axienet: Fix IRQ error handling
Date: Fri, 21 Aug 2026 19:32:46 +0700
Message-ID: <20260821123249.41527-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series fixes IRQ error handling in the Xilinx AXI Ethernet driver

Handle errors from optional IRQ lookup and preserve the original error
codes instead of returning -ENOMEM.

The changes were found by manual code inspection and compile-tested
only.

Link v1 : 
https://lore.kernel.org/all/20260811034715.6034-1-phucduc.bui@gmail.com/
Link v2 : 
https://lore.kernel.org/all/20260813042012.17631-1-phucduc.bui@gmail.com/
Link v3 :
https://lore.kernel.org/all/20260817105241.63345-1-phucduc.bui@gmail.com/

Changes in v2 : 
 - Split one patch from v1 into two patches.
Changes in v3 :
 - Move the lp->eth_irq check below instead of handling it immediately 
   after platform_get_irq_optional()
 - Add error handling for platform_get_irq()
Changes in v4 : 
 - Add Reviewed-by tags
 - Add error handling for irq_of_parse_and_map()
 
Best regards,
Phuc

bui duc phuc (3):
  net: xilinx: axienet: Propagate errors from optional IRQ lookup
  net: xilinx: axienet: Handle optional IRQ return value correctly
  net: xilinx: axienet: Fix IRQ error handling

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.0

