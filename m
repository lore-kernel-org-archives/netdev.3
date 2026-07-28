Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914B1C3BEB
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214701; cv=none; b=C1dwQHDnSUrd+8tiNJmDQdapzBJpH2RmSFT6PGAf6c5jUtD6QdqlGaaz5h8rHwxflk+XXHJ+6HxrFrEB0xBCHKTQM9dEYUBF/9tdBBaAmfei/hkfUVCf674bWIXEQ+D703SAOCyOaOJYz+U2rqkJGVw0azGMcHMZ5pgKHR3nRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214701; c=relaxed/simple;
	bh=ISP610h0pIjGjDJdZJ9iKEDs9O+oLvjm3WkEqRp142A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTAxt0v6MiESUfc3WKKmsrClv4AH9Q6YqlX/xRRlGrp10aMOHrj+g+1yaOh6qb1tz8678LCPZEPYLKSKrvIEqlx1VfwRV36bBGgQ69oIOXeo0fH05hHN+960tiFQjIuQ3KVaeSCHNmKmfGKsFbrvbSbJ7K7LJpQqBZMHG0eGGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jexUxzSF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jexUxzSF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf41bab353so49399625ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785214700; x=1785819500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZfaESFDQ/TT+cWft73CT875+I8BWbYNhIvagQldErE=;
        b=jexUxzSF2IHF01HRtL3KgMFwuWYPLLE6NCOQvvOBu3meQyDUNtCEB4naSQbhYCtEzf
         kQ4I4D5aAxnXCN5l7wX/8H1+CTicqzZIiZniq82qn+PbuMpQmmbAsXgp8T5oxW9oA7Td
         EpSLfLWmOLgFEbZN+PoDzTjIkFVqzfKOoZ3at2qfd8AjFMci+Da5ldYXAgQfri6VZyyT
         flZ0NDQDaA8KD8Y+wbuGqi/zDvpJ5Ip+Hk7lEo1GPjBC9UOPKN2259oOAi/zzuOoCmVe
         4XKArr6cn4Z9mviSpjCuP5tB4BhcZoOR19lRK5PIkPEAfx9niBVAhVh7e3QIQsTNVnO4
         rZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785214700; x=1785819500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZfaESFDQ/TT+cWft73CT875+I8BWbYNhIvagQldErE=;
        b=Uyw125dRdBcj/9QDHfaRwBDvmWziFa1NlOhkm1vgxOug6LVt6/bJvR56ByF0M2Tl2I
         OoQhjzRcXgf8YlNeiA+0CztgCJob3iY4fD0LS1zP9AKoz6Q854cW1csliqxpzfQX+sM1
         dL5U5tBNDsaNM7K2BamFGGwJmgTQk/qF9El4gX9Iyt+X5h1CbOcODGULk8Kn02nzUlA5
         maMgwNhF6azaUiZFrkyqeOG8N/ig93sQ1zFRhQZ4vooCkHkTShGjkZvmjjelh9LLc6tE
         2feIi5LutabOnmBtg/4V7tVGwZsxkBV4ba9A67/ONixFWSJiiScZJv74BXLKHrwMXFUU
         3NfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNScDfb+S7NnXACNtpJ7pEozFH0OekndYb7Efah0khPLo1Q/QMAzrMuBPCCo+9/RoDBvivlqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpW/tYPF8nHAaEIWex/mnxZSvJCJf8jBfuXjPsIo/oz6D0lDOv
	Joor4RGyhJCOXVFVx/vRJmw9288A17TPtq5xLgq+oX2/geXg2H0WLGc=
X-Gm-Gg: AR+sD13FWwJ9cmkxh+nledGIHFry/4Wl2ETJTuaEt0yvelKJqtdeTbEDDxc38eQIZE4
	nrLFGMPVqigr9S9EYRO/D3O6Sxup3qXhwmntJ4UJW+WKU4wUnUzNmLpLX3ZhlyIRrutgnzusywL
	E4nJpuFFFnoUmJhTC/DdUgOiD1VLbRkrHLQ/OQLtsnm8V2k3uQd/osUJP1o4tvsH8QcmnN1smjq
	gsSJG7Sf2wTQPduDtFiHtk8Z08ya8zx5LM1V8SGBcJXBFYoMNtRuCH4Qyjzs4VuzitcSj038OhT
	39s30zcWI0vPRDWaupaQ1usPWTdA1LWcs9qUWOE0QcT9gmjxRG0oBCcWOTXiuDIYXBLjevpT6Tj
	TtLzWTaagrI9N2IYzWb/LhagNaAArLSXYV+2fZw442K+vwI6G2DwJUwV8ZKrLfft1Z3E5LZzEav
	T3/T0v
X-Received: by 2002:a17:903:2ca:b0:2cf:7bfe:6043 with SMTP id d9443c01a7336-2d015c6db69mr9102575ad.19.1785214699707;
        Mon, 27 Jul 2026 21:58:19 -0700 (PDT)
Received: from localhost ([2405:201:8018:1843:4ab6:2030:c63a:e807])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc593b57sm56187202eec.25.2026.07.27.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:58:19 -0700 (PDT)
From: Ayananta Paul <ayanantapaul@gmail.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Ayananta Paul <ayanantapaul@gmail.com>
Subject: [PATCH 1/2] fpga: dfl: fix spelling in sysfs-platform-dfl-port ABI documentation
Date: Tue, 28 Jul 2026 10:28:02 +0530
Message-ID: <20260728045802.9551-1-ayanantapaul@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "responding" which was incorrectly written
as "respoding" in the Document/ABI/testing/sysfs-platform-dfl-port
ABI testing file.

Issue identified using:
`codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`

Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>
---
 Documentation/ABI/testing/sysfs-platform-dfl-port | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index 65658267fcc0..40e555abca20 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -84,7 +84,7 @@ Description:	Read-Write. Read this file to get errors detected on port and
 		to clear errors. Write fails with -EINVAL if input parsing
 		fails or input error code doesn't match. Write fails with
 		-EBUSY or -ETIMEDOUT if error can't be cleared as hardware
-		in low power state (-EBUSY) or not respoding (-ETIMEDOUT).
+		in low power state (-EBUSY) or not responding (-ETIMEDOUT).
 
 What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
 Date:		August 2019
-- 
2.53.0

