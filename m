Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A03B2D00;
	Tue, 21 Jul 2026 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667364; cv=none; b=sKdIlIBKmcISbB+djCHefKCWBYr38TK7dPAaqw20R6RgGBUOnjCDgO/MR6q01ZY4MaiNm72I/uVkt5qh6/8Y7eaXq6YooPKW/xJgK/ifsP6IubspXV6VNvsDHBr02tuesU56K/ehLkIGSOvmaYEBKB+Wkhv2TsHruMhAJT4Ac4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667364; c=relaxed/simple;
	bh=8WwZUZHgV6BKGjvURsafFo6Styzh3h63JJCfboaQHfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5o8e1WhLbBQZYNxh0Upjjv2Q+f9iLKSb67FrBwG1F2eszu4YnTVyCBu5j+ejXt25xrc8LZMA1gGTj4FndFTOJP1WHIlInLU9KiU1J7bcMzRs7RxIkR7MY6GXn5kb0FR1fZXA/NQw9jBWMT1yY0RcM2iFgzuKbykZ42SE7dkutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhNNjynq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhNNjynq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A21F00A3A;
	Tue, 21 Jul 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667363;
	bh=G0ZJTgnfFz9Yp+8kiiiPakH+8l1ObaaD7R7zp/zYrJs=;
	h=From:To:Cc:Subject:Date;
	b=AhNNjynqui1xlYFXdJoyIFRCOTpLKD1eg2uNve/JFRctOy6XGPue+nHzkDziauRKA
	 WS99Zdpx7fhkU8l1aLDmg3AbNSXfL0gqbkkaf65ukarIYRY6vPE1arstRVU40mtaJ0
	 YyZu1qpAUt/C9AYXfkCCM+qnWj15jwOOaXJfdU+A01iUrwmRodKkE7+uHUJUiD7SK9
	 p6f0VV93SV4upY29LdQmjgSTNNVKo/GOKPQ/a8upQdsqYqCuixy8Uvir8ezJVl1ncQ
	 Ng22JFTyNIvO3V673PBe+qilBHw4to1Q70pl66HtKNzeGz3jy0PvAhJKQ2yNaWWj3F
	 nAOk9F+aStaTw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Subject: [PATCH net] MAINTAINERS: add nci tests to nfc
Date: Tue, 21 Jul 2026 13:55:55 -0700
Message-ID: <20260721205555.1020513-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCI is part of NFC, so include its selftests under the NFC entry.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: david@ixit.cz
CC: oe-linux-nfc@lists.linux.dev
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6940aa3d498b..ead6aaa95398 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19118,6 +19118,7 @@ F:	drivers/nfc/
 F:	include/net/nfc/
 F:	include/uapi/linux/nfc.h
 F:	net/nfc/
+F:	tools/testing/selftests/nci/
 
 NFC VIRTUAL NCI DEVICE DRIVER
 M:	Bongsu Jeon <bongsu.jeon@samsung.com>
-- 
2.55.0

