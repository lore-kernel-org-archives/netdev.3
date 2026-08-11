Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052F2C3257
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431799; cv=none; b=ZbIa6ohwj+GHu4tYNZ70SsX6f2sMt8HP3MKtAkwyRIYHkS+EDPQezdwaQEulxc8IdQaFD/cbQaH5+7kLTI4OPgNnSccNZCcD9Wg+nockDd3UzDiumt3a8TApyZ15Eq+0+svKryvv9PjXghMQK8EpdBoRAXx8Zl6cMAAs4Y0ywXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431799; c=relaxed/simple;
	bh=89iSOBFmAKZ0AVgeFq0hQz2LWETbyEQ1COJqJZZ6Fzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kfo13kT16eEH/Zw1senDihbX3dT2c0AKU/X9lUJsRIuMuY0Pz9o/jzRN5AQvXYsGMxB3fBQF4brvW75lMcW7XvAEiJME5HUUNKztxH7wpWuLlZOHPYrvxBOymIuaKCIDzPn4RRR3lnYzfkhh1o9muI78F1vHAHtxPmXwIdwkPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCphGJEh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCphGJEh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2273504b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786431797; x=1787036597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TowDT+Kc4G5/QaKhkzSWN2HrnNtpLmoEVbOwh7MwDKg=;
        b=LCphGJEhTueTscfw89A7fvaB6XLV9bPL2jGBVNAUuK+do+wUv5o0zpKULfPpwKseD2
         qab8z+qBOnZoj2obrpFSiZ8XgvuujBuflm1laDxQ8h65Od0ZLaytkuORGdjVhkJ57kW/
         JrwIyVSPz7CzuchVSoVNMO9lVbfOwYmXfgKrSJ3KjqrkbNLgVYmGrfRtoMmOxki0bQGr
         0pQtWgKtYpS6W0grR3YzCTQ4jNyskXJNJvWAAaUWk1fawsMiXlR2q51vmWQsZZqiQJCm
         tAJY/ia8MWOYYSi6QPeIrxffLUmt69U9M+9asXvJy2Q5igjJbkQnwUfi/fKlKYFYhdOe
         mfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786431797; x=1787036597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TowDT+Kc4G5/QaKhkzSWN2HrnNtpLmoEVbOwh7MwDKg=;
        b=cu2+/WPWwpFYabaQ8X5JppZDOIbUFjF/56T23uQw69mCimR7xYHgoojHsKu16qGfHP
         8tol4Zkrc6nnmSeugLAtRus0rUdZ76bTI3UibOzxIFH1g0zdyRZvjBg4yCjTi86+sSF+
         XnwX2pxCECS2sZ+BJ49IlpspBS8v0wSOkHzjOAFkcPuCsogAJ/3X/Q+OwbmlEi4Px2cO
         eRxltWEAEi1yaVi2AIzPqHmoOGQujc/ZoUSZR80p4Pgi081QH5zS+nCC452bQqaAMFgZ
         0/++vtQGQQohPAJL8x9M/0RrSkZ0w0JS/L9CMvu6isVjXQcVGbu+y+J1hEtcdeadx0e+
         K95g==
X-Gm-Message-State: AOJu0Yz9vzQbfBwUMwHF7SzlkAybHX9F9jg5ir1wqt2yrwPe8JUaec7p
	D5t8qhaJMEIEvYu6xQxxaSNC6inLK41zEXhxysTPPzpEn4RetKeDYqqi
X-Gm-Gg: AR+sD12URM5/+RmhErQeUHvJ2CGX3IjJiOP6cpJHgkehyNFAwxYVQmvXvC26XCPforx
	FCzGhhfoI210PpDlnHi9ouCJZMU8BefceODExUVAT3SOwhWbGQ86rxPlG4qYoyOnzyZZJud0f1k
	ptExsj+9Acn08bLzd+WHpersZ1Advh3Sh4LRPh5u8zS8U1XqXCSOaYKjDJg+oGwK5cVAVRjhAVs
	gQz5/+KXmF+cdAUGGPiW7wPdTwRCTfe1YQOmGmw9KvXGPfFw/0s6EtuDWB84Nd3yJfDvUuCwVdp
	nTNWb6EAl9kTa8V61pgPE0bxRqST1Ieax5z9OgEdZXJM3YnCrNkhc1UzW/VPQHcoZdNtq9JEVor
	8iCbrgMQwJRGAYheIQd2+FJP2PECXCxjtlmyQbf09GjHx+OYvLJgCEHFgbIucqHgtNcMl2LrgEQ
	s7mTyd4Laog66QunekSZs/WynYzBzzp6rPnXAu4dxvxH3jRb2ph72ASW5hsycI94VnfPh0WPW8h
	Rsmc4v/PVK2SA==
X-Received: by 2002:a05:6a00:430c:b0:848:7552:3d86 with SMTP id d2e1a72fcca58-84fa872e616mr1164869b3a.23.1786431797031;
        Tue, 11 Aug 2026 00:03:17 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84fa954db66sm197999b3a.48.2026.08.11.00.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 00:03:16 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] net: tipc: replace deprecated strcpy with strscpy
Date: Tue, 11 Aug 2026 07:03:06 +0000
Message-ID: <20260811070306.59127-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `strcpy()` function is deprecated and moving towards code-tree
elimination. Replacing it with `strscpy()` fixes potential buffer
overflow vectors by ensuring safe NULL-termination based on the
destination buffer size limit [1][2].

In `tipc_bearer_get_name()`, the 'name' parameter decays into a pointer,
meaning `sizeof()` cannot capture the underlying array bounds directly.
However, all parent callers allocate this buffer using the
TIPC_MAX_BEARER_NAME macro.

Replace strcpy() with strscpy() using TIPC_MAX_BEARER_NAME as the
explicit destination bound length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 net/tipc/bearer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..951bb474c7d4 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
 	return 0;
 }
 
-- 
2.43.0

