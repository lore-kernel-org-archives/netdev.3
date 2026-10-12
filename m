Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A5472535
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807108; cv=none; b=NdMqKXwWwhOmYmznEHOtBz9bEX6ypXSxntLqboS7yd1GhxxI0oy6AnpecZvJWUj50/5vAsS+ZxsEnZEK5vNmXOiV0nXXOTPkt/Frj0iyq4pFbhOcuAJIBvke/StraYiIpveh+4RvurIKbAWFCaEapEzA/mCOYS9lq5i62v9yvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807108; c=relaxed/simple;
	bh=rJRyqsVFQ5O/gwaiMQNwRrhpcjKtpLZTgSfCzqO+3p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2nDXbYnabnyusYUg+fzcscJcrEMw9ixBBVvVwuNar01rUz1DRIRoZIT8xDUWt9qRGnd/kHkcHAG6yCNID/ipUmQMekM54f7b4cNRTc3qWTRn191XFDLsM88YCn5Rt3jtHD7BZV9FHFCH6rZnMa+hSgbScNKmGGMF1+Z6ap7a0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Apgy63; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Apgy63"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398b3c37877so818695a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791807106; x=1792411906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OV6YDNYPeiFdz/Nxte2QGUp1Bj1LDwNwasKSm/sFXFo=;
        b=b3Apgy63FWMLwVPmHN3wh9f4xzAM3GdDB41jXVjjSPnyDpvq8kxFe5G8PKoB9pNgjg
         FU42D1aBCglELYWhmFByaurhcZRfkJgL/uPvu9zMCV8e1bsUwY2BLblrbNnvkXK/8H/E
         1+4dahN1WxCjexnvTU40+oD+EZxkErHT9ic96Y22ExRC/OWA0zz8pOrgtH+6GMhxsy1j
         zHmfKsCVcmiINLV3kNZMHRY1MLSc37ZaFPiTEqQxDcRPTZjIlnPbFUd5inNJliDT3zPW
         w8Fpk5ilfdtu63IAiG/zBdWbO1AEFqx9D+ThYM5buU/ip7BhDl3xS1L6ve2zv3K6pljc
         CIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791807106; x=1792411906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OV6YDNYPeiFdz/Nxte2QGUp1Bj1LDwNwasKSm/sFXFo=;
        b=HVkSD3uY7U9uwOfofCdtFHIgmwXEbo9BzwKqWPnju5jpFgH/xj3ISVCvEhPz+Iuwiq
         GeLPA2iftF9S5+5EtX8G+iV6AC+o1lGmIyvH36maauPvRGplHg/IU3lUBDqZifNx5+0m
         uNWMraH/QotTnpfbPeFfV4/kuZWPfVeBj9AkT7yP66Qj/bN0JQ4ThbUlnUbV+Z/GogiC
         a6WjJjs2848PWFuwb3tET+GOdyDZAATaZhcQ2cMMEuInvtaUEr6Br2WZRAKfUVqCGvPv
         /9MXZ7u7dPbqqPrcuy5Y9tpII7UXmBnTnwaMcC8nxcjOMhEEn/WtmStKeSLHORvXRSng
         dZ6w==
X-Forwarded-Encrypted: i=1; AKwUvBzMIEdA6X8fVFyhvPu5jaBsJpSY+4XIaMrs37qMZwRGpwefxba/t95c8cX8XIDbAMyZw+goNEg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVMsat/87Lg+I3L0x8RF7Vlr4kFvHztYfPr1QLPeMb8OUTGd9l
	NRW9fJ+euS9u1s9QMjb/EKjKlY63lMnnVhdtGmlFcai41VwHWb2A7ka7
X-Gm-Gg: AYBFou2ocK4SkXaRS2kuGc6INPJtXOp9zeJJfYPgzd35szKVUXwnic7E8oTK1Re7l0l
	1hHrfpcuWznsq8XXAIUK4djtoQSLVtYH8gmGe96RW338BGrJ/s+WgaDcTO8amnfAPDBB5sIIGdd
	VRRZ21RvpUft4fCJMv6G8W4K13l9hcY+xeegpw7btskD787Zd2AOsGw6yivS1Hy9ulmi02DeSRi
	E9TRXK8oyWfs/cMfhuXIw5KC/Y/n50pGuXSJ6btik78qwbzOs+mYeLtd/ttk9p/XgiH7DDGXWc7
	rcOFHhOOlCmw6fQ9ZFGbDbIO+A8ZcySs2zNEBcsFYFPonoUuEOf12HtAphLfEJVVBv12oRTUfW6
	d8NpvIDJs5Rbdx49xqCDrSCk+HiZBQ7J5rTprlbUG8S9no1JwLj1SxenGdCf0SIZavW/GKxlkC5
	VQQ2jkXfibmh6eh+TPWqDLrsa/GqtsOe3VV6MfPm1bI3wT7/eUsn8EU3DcVZzBKLUeKzX7U2pKR
	ENUbk/eTpF49vvH9QYR/mURytUhfFyxgb3sp2VF
X-Received: by 2002:a17:90b:2d0b:b0:3a4:945e:bc33 with SMTP id 98e67ed59e1d1-3ab3af7177amr7138783a91.47.1791807106338;
        Mon, 12 Oct 2026 05:11:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f2:102b:51cf:2018:b37:8e19:d019])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38fc9e52sm16255591a91.13.2026.10.12.05.11.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 05:11:35 -0700 (PDT)
From: Aryan Arora <aryanarora.w1@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Girault <david.girault@qorvo.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com,
	Aryan Arora <aryanarora.w1@gmail.com>
Subject: [PATCH] mac802154: Cancel scan work synchronously during hardware teardown
Date: Mon, 12 Oct 2026 17:39:34 +0530
Message-ID: <20261012120934.64632-1-aryanarora.w1@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scan cleanup uses cancel_delayed_work(), which does not wait for a
running scan worker. The worker can requeue itself after cancellation,
leaving an active delayed-work timer when the PHY allocation is freed.

Cancel scan work synchronously before destroying the workqueue.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Reported-by: syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=19cbce4cc656ecd4febc
Tested-by: syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Signed-off-by: Aryan Arora <aryanarora.w1@gmail.com>
---
syzbot reproduced no crash on 7.3-rc7 with the PIB teardown patch [1]
applied (base 08fa34e14e2d).
Test log: https://syzkaller.appspot.com/x/bisect.txt?x=128c8f15580000

[1] https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.com/#t

 net/mac802154/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572a..5a2ab501244b 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -283,6 +283,8 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_unlock();
 
+	cancel_delayed_work_sync(&local->scan_work);
+
 	destroy_workqueue(local->mac_wq);
 	destroy_workqueue(local->workqueue);
 	wpan_phy_unregister(local->phy);
