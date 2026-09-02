Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9553EF66B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340235; cv=none; b=VTJMfJ7hhLR1gmMcIwHHjupF92Evt3uiIvhH/ww7JdbU6NYwvJDhZ0nIAfxRvGsF5VVov1xLTlxkNuurn9dCeuRRUMspR9rvy44XBCNrc3NvfFkLbHeNpP7Sa1k9ZlqNistwvHwLmyLlsGYlVCfsmAmN6vRyhjiUiq4VmwV0MEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340235; c=relaxed/simple;
	bh=vQdzM4rvKFPam5dovDbIDl+CNeWDCL+2DysFzbO4wt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKgmgz67w/8UViTEhTgVH4P/J5EjmOU+Q6HA5WBUUvRBYkXq2uzeeP7/W7v+IkpN6DOjZJB4qYAm12M4HAOBnivJaYwwzyVHzjZxGXONbKMfqDg3hoswXsc2TqU6Jsm3E1JThK3sTCKZ0fNjGFKSqPi/qYZPkwaonU1pMJ+ARnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAbg+gr9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAbg+gr9"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so899294a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788340233; x=1788945033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3pzX1jjiPX5m+fIujObi1ijyr2+XOPha2U23/dw054=;
        b=FAbg+gr9i+wiFkWbeo59b9YQ7nkLxmCR7uwFjfn5SyL82Mo0orLeIwyiAXdqcAKpNL
         sfRxw63Vrp5bujlnEJfRdlvFrHN2vBQTZNidxUXkIucnQhgv739m9kzuYTauvzZTkVz4
         6bJRBl/ATelW7LcDcFHWmcl1KNx9JgBtOmthFoQ7TKho8JfdqiAVPMJ0DCt/fCMLiraC
         HbTQVlLPhewUwkf6+ZjGOKFe6quhlEjCYdgZIR7NuwpJcIbD3ZO7d4VI+Ck9iRlRR2Eu
         Ws+m5zQzviM11PEP0QtMLbTU+nrAj8yE9ZFV6TBDcoxYUqE3tx4HYjC8qh5/P8qpzrd8
         eEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788340233; x=1788945033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3pzX1jjiPX5m+fIujObi1ijyr2+XOPha2U23/dw054=;
        b=V4tuyDhOwkXYyD7xnqfvEX2M+kBVHT3ucVtAwo6r0xbWjYE4/FAhO7lpXXMpyBST7h
         Ud9KHG6p1Tbqa0N247OrVLBqOWJVpz6IYUut/rQrHE4i3niHZ5ZOO4zUgzXnnCUG9CcR
         Kq+Uup4h2IIjeIOq6e78XrcuUT02nJdoIKxhnbvMTgA0n7MVs1y1lhN5BcRoQyYRTz6B
         1xc9gvaeu7UmpuF0ebFrGFKon9scnEsTncMj4/Y7AzLshhSFHEYkKBTVrRIldqZvnuL/
         Lp8/ecGGwSsdaNpOtdtOlodJWYO5dD0Bt8YCr5quEA+111/PPw3a5XVLCXduDUZ54RwJ
         mRLw==
X-Forwarded-Encrypted: i=1; AHgh+RqbEZzEFsOOWRcXxssU16suNxrj7nMgc1r42q6Ady/25Lp2yvn7vaaDWbzrQGT7+gcI/md91hY=@vger.kernel.org
X-Gm-Message-State: AFuF++mXGMhD2EMDkuogBgLJey425RXid+KYkyLcKX1zsZO0wQiG6Ss9
	3YDYzfdcGXsA5J0pgv66GKtz0qEn7QxvkZAU6nqIPYAfy9BRNDDwo5Bi
X-Gm-Gg: AR+sD1227AQdlbooH2HdH8Gb+H0VfNyvPSHhWdadBL/14eG2GuYGW5tvcbUHHiuTHzs
	sijxmD3ACifhslKQIO6gQr80qYz7krb9qNTY7CsGFO4YKc1xCoJ53OmAuLovJwAXJjk7YtKHVnT
	7PjYp6bHh1cjuf496wjGNB/hDkj8o6DRixNnMjAH7AiRe4ebfAzo4zvj+kTfasoP+6EV1HdXRI7
	YVwEo3r1daauu8DUwd3V4vVWLUyc5nop5hQnVr09sp+x7vvCzAAVfbhXytEbVapPMrZatyTAYa8
	PWham0y3cBYHv2gE82Wkswfm/z8iXKSyhvv4VD502/y5uu/nH+eduOem1mVbFmAWZMeXdGN9thF
	ts51NGu1SRhlnl+cS0HkDtHgR75z1o4CGB7aIicQ1KuOtE39sz/RPfg3j2N3gJT/OSfbGIc7aaU
	0f9cciiUciWVSop6OmiDq/isQ8W+aCAtb50cHum+geEroaoKERCbeovTv5d4Qci1hjlmtoFPOr/
	xjTLzqBnL2cl+h1EU8yeO9xRkpn2VmitBrflGWtCvCwRHpCeBo=
X-Received: by 2002:a05:6a20:430a:b0:3d1:3c2:85b6 with SMTP id adf61e73a8af0-3d9ac8413a1mr4882102637.5.1788340232802;
        Wed, 02 Sep 2026 02:10:32 -0700 (PDT)
Received: from baaz.tail58d41.ts.net ([2401:4900:8852:4cb2:4c70:f750:2a36:4165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34e371e0esm744502a12.28.2026.09.02.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:10:32 -0700 (PDT)
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH net-next v2] net: mana: remove unreachable dead code in mana_bpf()
Date: Wed,  2 Sep 2026 14:40:10 +0530
Message-ID: <3d8b67307df6fefdc18743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_bpf() has a trailing 'return ret;' after a switch statement whose
every case (XDP_SETUP_PROG and default) already returns unconditionally.
The statement is therefore unreachable and 'ret' is never used.

Remove both. No functional change intended.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2:
  - reword the commit message: drop the claim that an uninitialized value
    could be returned; every switch case returns unconditionally, so the
    statement is simply unreachable. Describe it as a pure cleanup.
  - drop the Fixes: tag offered during v1 review, per the guidance that
    net-next changes should not carry Fixes: tags.
  - no code changes.
v1: https://lore.kernel.org/netdev/DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com/

 drivers/net/ethernet/microsoft/mana/mana_bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 53308e139cbe9..70bb8c9dc3413 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 {
 	struct netlink_ext_ack *extack = bpf->extack;
-	int ret;
 
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
@@ -262,6 +261,4 @@ int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return ret;
 }
-- 
2.55.0

