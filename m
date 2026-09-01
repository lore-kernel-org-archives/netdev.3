Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45F3998A4
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246432; cv=none; b=M3ArkrRk/UT1L6TGfa3MnddGjfLgAaXBHoJZNBMkpxX1ZArRjuapGl7yZTOIk1FWW+qDHr1GMtJueUd2YPKBlRTVh7jeT5eYXLnwtuEyRNwVJFo2xJJ9u64E5M0QnuUQSczikIYZfktJ+fdI/d82DXpMOvM6T9cJdPJ7MgcbzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246432; c=relaxed/simple;
	bh=FNflVYT5xQoaZ3kWaV8W1BzYLYuSaQ6DZ80e1DBpVKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFK5mhrCbXJTezkPE0jcs5Mt0BlYJJEsFQiNMrBrhgBMjzA37rUs0tjes5Qj3bBvE2SHC72ooUzXIxFGYaKslXZ/vx5jEU0ONoCYNv+BBj4eCH/VVpnpgBC06cbMSzgRyFAjRuTglL+td4He3SWDdDLxv7Qqs3IDdc8CcOBTw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIfyY3QQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIfyY3QQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caced6038eso8078325ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246431; x=1788851231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vx15wRXdK1l+pFtaaPtI7i08zanEbZBalZduAsGHYJY=;
        b=TIfyY3QQ+zz1LgNS04r9T7G3IpkeDXqMjUZJrjlnvHVCCWPfMHRUbQns6HHQx8Iy/t
         POC8X0tCapdPqgO+sWxwtL4crMMLrzWowZhU7ra+jA9PsW1LxgsiR+KSeERqKSr4ersH
         su0WCJ5mLsHG6gVmgcgobwYuW2sYGXJOoVS5S2IiyFi6OevIKO1rQGfRtY1zTZy9os0n
         pHR3jrl/E20c3Pwjy4lswiXmU3PdKZnBvdstfYa9sHbEjvUX7A8wo1PgZFtMo2Gia48a
         eCMW9uXhf8XDllC41O+VT0CRqDBGreyI1hHekZSnpzsY3/p16VELZKPAutkyY18o9t1N
         vJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246431; x=1788851231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vx15wRXdK1l+pFtaaPtI7i08zanEbZBalZduAsGHYJY=;
        b=FRGralHuCYrvXmXY65q+RcwarP0k0jaJFHds3lwg3PSvU1+o7zzujcgs8zQcExnRQP
         eFuonuHmTh8qihbZwglnULLM5BDgkpugmMD8fw41SFGazEpUZ39U9OmVbe8lFG+DhuqH
         ajGTQ7uCZDOYA0MTZYQJY695E30X9HUhdBOUgrwJ0UbVzSK/8GNj7Lxb3+v2SdltrEVa
         W1nxEZ1qyqgYTEF16FZeTi0k05p59ckMozzjD4gybKDCdMLbrdRm4W1wynhyX9M1Jjwy
         eoumjYLH+3drtT6hgR1Q1c1U51maI4miY7tbgk9y8/tvsHINiu1IlMA6vyLPOp6hLR6D
         I9JA==
X-Forwarded-Encrypted: i=1; AKwUvBwfiyCMAaCPffA4V3UMWkDTsEfoH1W0Luj4K7OrIPOQ9amuiwM7aJfYmZtbeaQQm2T1DcooPy0=@vger.kernel.org
X-Gm-Message-State: AFuF++lD8WjJDGScAOMEm+yJCbNM7bbHtP2SRUEsvq64GCeoHgDQWqtd
	NBk3XR6BVp1rQc2iMciNboDznINhs224tLWrZFwv4T8knGK6yVjlCmN4
X-Gm-Gg: AR+sD13+XwxyR1sxh/sEkvwBpAB6TrrASOYt8JwFOnKQgBJhZ3BY0Qxt9asy9WLzCNA
	m0uY5dC8FPBLvD51BKam+DlSz5TKBJkgz1LNW4lWQGFz4ZtlZ8hkSx4+wzxWyOlSZZWfOjZok8K
	i496K++iZz65bKvNPrEiAe+SF7YkPxU+Qf59cYoETyrae/0JGvr0YyrN4aaLnwLp0kfSPr9pIK+
	K2XnKhbO9NAjINfxcc/AOHtdherlUNSkhX3G64bG61yEXQbbnxzVoYhaNDcez7kr5EJOdeLbbke
	LNENUCnGrvVvdz6xWkrrDAE0Fy9VX/XCO/shU+cDirRuIeRfR7NVAGkE2MNzcu1iJypwtXQo45H
	XP1/q3nkOY9ONHkBgjDJjeHPv/Pkt7/oEZlyhOS10UR5wiNmJzOs+y6KcTYIVVF+E6Upm5wadOp
	//YlPSljxhdYrQ65ElyNcr7YZ+7Y+B3hYDIMyRCI9z87ov29PDsOiz5jkBkqJo3dXNZxARn98TY
	Q==
X-Received: by 2002:a17:903:2c08:b0:2d8:d4d2:d139 with SMTP id d9443c01a7336-2d952960702mr37706985ad.21.1788246430647;
        Tue, 01 Sep 2026 00:07:10 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm36432090eec.28.2026.09.01.00.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:07:10 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Subject: [PATCH] selftests: nci: Fix uninitialized family ID on missing attribute
Date: Tue,  1 Sep 2026 07:06:18 +0000
Message-ID: <20260901070618.3299012-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_family_id() walks the generic netlink CTRL_CMD_GETFAMILY reply
looking for the CTRL_ATTR_FAMILY_ID attribute and returns the parsed
value in the local variable "id". If the reply does not carry that
attribute, the parsing loop never assigns "id" and the function returns
an indeterminate stack value, which the caller stores in self->fid and
uses for subsequent netlink requests.

Initialize "id" to 0 so a missing attribute yields a deterministic
(invalid) family ID instead of a garbage value.

Fixes: f595cf1242f3 ("selftests: Add nci suite")
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 tools/testing/selftests/nci/nci_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nci/nci_dev.c b/tools/testing/selftests/nci/nci_dev.c
index 312f84ee0444..ed306ec23895 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -182,7 +182,7 @@ static int get_family_id(int sd, __u32 pid, __u32 *event_group)
 	} ans;
 	struct nlattr *na;
 	int resp_len;
-	__u16 id;
+	__u16 id = 0;
 	int len;
 	int rc;
 
-- 
2.43.0

