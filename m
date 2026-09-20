Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B2439F77
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907314; cv=none; b=tHswaZbrJBKDvcdANP5pfacFlXb3sxa8YYnBLWGjG/IaRqxnY81Lp3PlhUETtP9WSMKmKAlFgoTG+8nm2I1mlqXqtAQaF64HfmDAEeDfWFv5ZWm9PntA+aJvscOjU/UhcvZVk1w/hoG7FqUkKfw9MlD3vvy+PNFS+afJv5ZAW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907314; c=relaxed/simple;
	bh=ug5ivTizQ1N7ESUeK1HC0Ctk7wrSvLsfG5IU53GsVEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThUXJYmoUekYtXBOi5c0eIRnq1ZsCXr04kyExp/Vba6naNF9oEEsvDY23MJhTIxgICdIKWIfUUtYmH0VUMx0sRQCBmVmMBMaFbubgWZzHi/+IpyxLIZJpyVpV9rbSjwNteG1NEU/wvg6T/oQ/uCgkgMWHLiQTHYPHrZNBIVsMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnkmQBfl; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnkmQBfl"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca06a25so14285515ad.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907293; x=1790512093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dV2mf6OjkoqKta420YWVjn2IUO2T2gOHZv0jasF5Urw=;
        b=LnkmQBflNZn6Ywv9y6nSyxsFWOZhHopQ2Fq8MD0pyTfTS7ob6lHf0VvD7fECVe1Ok6
         lP6wNnsACmbxjJXrDmvPAzEgjBCDJdbJaMpB/pBnoq76Bzntj6k0neJhSgLsPALTZG/Q
         JrwbdVItGyWBdw4GyqpE9R7oc9DYsyYzzyh4t3OlDmZac0ryKqcdR8J3syD6mZcJFUdl
         R3hF29u8G4usOdvv+FzTHT6JuD0OIAjru3cYEzABIrKqd9ib6czw2dTkOCYqgwhhqlW1
         ebjOvOYLP0fkZiQuRbp+VjGaw+xNdHJuioYddWwrfqt30pTfgouxlY0BzaOnF1tFDeY5
         Fl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907293; x=1790512093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dV2mf6OjkoqKta420YWVjn2IUO2T2gOHZv0jasF5Urw=;
        b=0ZyFb3IQ7dOqCJ4hy0EZv5OK5IvKNEwADydFNrK8fwC+CnyyHfKdd2Q9jq5seTKiZx
         qUDrDpu3kK3NyepzJPXUCLJ+Ropm6t3/cNreCktdLSXlZgkajmw6Cr2Xvw8t7zUkFHhU
         mkYiOM34SP2fAgywMXh92Yk8TdBNXBJcEAoPmuAqDjkNRoFC6s3Kfh+GuCzc2/IsD5rJ
         GKsXX+PXO+l59fVqThb/72MjlNg0Zdcq1M/mMNPKn2EKm4DfLUiTbEdj8u+lySbjaOiA
         ppyIvvfdBTUnfYrTq4lhbLO3X8CsMSLWRKDW0TC65o62jIagfyksLwOJnCJrDZUsPf4Z
         MXqA==
X-Forwarded-Encrypted: i=1; AKwUvBwt2ejWrL/hhXrCTjU9v7u4cgThuiIKG4CxLeh9kGnavM2H1ts9sO9yeq6FZ96+coj6S7ICCmM=@vger.kernel.org
X-Gm-Message-State: AFuF++nSphmAWl3ucURCEkGG0GFCDyjsF5gt+laRWQhvIrJYulF2RRDB
	Sj4hfaOu2XXSczJ0Y63AdG7WA14wuNPSpQiD+G+ayRK6gWlmIQt+B0/x
X-Gm-Gg: AYBFou3DqeJttCj17QDZ5iP6AlII4seC0pjptSClTmksnebWG/+RGUlJ2HWplYaHBi7
	Be687KRKv+Ribt8ffeq/jwnF4Y/rZSCS9rTF/mxd2f/L9FNqvqOi2btgbHHJFKyS+bgDVa2TVAI
	cXAvjuMFHZmZrQ5yw32tz7VuODOksQ3H4UKfHyUr8hP/A+JyJCPZLGvwjiT5IjSaf+PfsALqSXH
	31+M3GhLoUM+bwP29yg6AE/vsWTMKCya4vNrxmrVmJ7gSHEpH9NpTk04dQw13UnMAUuBwrzr5jv
	zKp4IfZ0jg8WX8E4DJzIFNQJqzjpjDVC+T9ivytihBKt1BFDUsPIi3DuouYwnUBtNyVRNqfZ6JB
	WHglTLss0pJD1Cp77fL0TiXuHFFVUD0wgqIbrWXLN74rp0L4/MkNJY5tl8HuUYfD1YnP3B0Yx10
	WN6bDl04NQdHY9SvO0QvIUmgOoFGaSkaVZSpwzYnBD7nKDICfW90dcQDxaWnhPe73m22FqqXpFw
	aWP7tmJci3q7uvcipyo+00GniQM2bPQJRmmobsi6HH+vUrGYSRtUj0pOAXmdnrAmXnI/ihb
X-Received: by 2002:a17:903:37c8:b0:2dd:c100:80b0 with SMTP id d9443c01a7336-2ddc1008158mr57187955ad.43.1789907293493;
        Sun, 20 Sep 2026 05:28:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:2df5:84c3:962:c847])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df36806cdbsm15428845ad.80.2026.09.20.05.28.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 05:28:12 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH net-next v2] octeontx2-af: remove duplicate SCTP port flags
Date: Sun, 20 Sep 2026 17:58:02 +0530
Message-ID: <20260920122803.6277-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proto_flags ORs BIT_ULL(NPC_SPORT_SCTP) and BIT_ULL(NPC_DPORT_SCTP)
twice. The second pair is redundant and does not change the mask.

Drop it.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
Reviewed-by: Geetha sowjanya <gakula@marvell.com>
---
v2: add the missing net-next subject tag. No Fixes tag, the patch has
    no functional change. Picked up Geetha's Reviewed-by.

Link to v1: https://lore.kernel.org/netdev/20260918060323.53860-1-sinha.aryan03@gmail.com/
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index d422bdd5e..ec004ea51 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -698,7 +698,6 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 	proto_flags = BIT_ULL(NPC_SPORT_TCP) | BIT_ULL(NPC_SPORT_UDP) |
 		       BIT_ULL(NPC_DPORT_TCP) | BIT_ULL(NPC_DPORT_UDP) |
 		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP) |
-		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP) |
 		       BIT_ULL(NPC_TYPE_ICMP) | BIT_ULL(NPC_CODE_ICMP) |
 		       BIT_ULL(NPC_TCP_FLAGS);
 
-- 
2.46.0

