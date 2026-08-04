Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402C427FAF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877676; cv=none; b=I591SH5y1TVM0ZO1E+FMxDHnlI6xQKQrjASXCwFB5IZtNtcuox+2NoFlsfasZ1CKC2ORg75NFAgmk6LLpbh0iyYHvRgrF6dv+kONz2m7Gsv7qZbnYYL5rLGrscyw/mpuHUpKdjc33/2bTc0uIPC9p+oGtfL8ke8U2YezhKEOzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877676; c=relaxed/simple;
	bh=E9SBvdW+/KiAZtFTbyHkjkv0EG0f1ZJd0WKHjYFUkJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkJ+0e7QtBExpvTITpX6GZbKn1Q8/nrN41U0goajTUNsojkHgit+B/RTUBDxFBiOHDvBASxYyLXRjKyqdTJ0kl0CxbBNgR3ZiTvk1qN12sGY3kGGE63UmHwZYzn6UraU/XgdqPFN8qkjd4yctz8KYxjJtiS+1mroAlmZ8NCxAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQy7pB6I; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQy7pB6I"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso170593a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785877674; x=1786482474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=76fbOMML2BB/JSL2cFNmUHBc2T+2DJy3Cef/Dsg9aWg=;
        b=qQy7pB6Iv6YICiTyAOIGA9cg0UW/xbTzurpujg0Kpq+jY1zd8q9Pkc3h/drAoHSH31
         chtUKuLUe/XJbOUR3fuzr+sSSGwcOdg+KfAAp+mIAditSnj2qTRfq6AynbY35f14OD5z
         JuunxPuDxwinRr8Nu45qGRcGUBRK/VCWT/K01tDkFiKaMYD3ai3sATt/2HA1Ha9BwOmT
         8yAcZeh+MCHBRCOEB8Z09/wOte8HKYWEi73NQAPBrsRTt35fzWE3wdL0HAbMk7d1/7kK
         5q52ViZ/w82L8KWVAjprYZpW/l0zJDBq8zVYw462XG0plWO7BOd83Y6S/U++VClsLEqC
         pwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877674; x=1786482474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76fbOMML2BB/JSL2cFNmUHBc2T+2DJy3Cef/Dsg9aWg=;
        b=RUkbiE2TXhLqUikXxR8SnKRxLLd4HgOY9c+5/rItJY9Hcc0/fOSTKTtd5HGRYF1Xj0
         3QvYdzcTu9lZbozrXH+vME2i4aCYLJhw8s6vcYGAipGHr0FJV12s8bEPuovXiq5vz6+V
         NLkd1BVE3cvFJGvqrqiES5ZRg0v1d5ZDeoU2NlmMPUcBHTsTz8ZhuppbhL441XrCK67w
         j5UyeG2CmhVVas4VE8H/fPZkndGg8PY2LJ1AGaUyXJuL0O4DuD89nvgq8t+H1SPZ3LgB
         mV/ZJWs5GBktDxX09LhWuoUpKLb7ok5+iE3U0Usxer8Ln904o1kIf4yGF9ubBPOi+Iok
         zawQ==
X-Gm-Message-State: AOJu0YynyAnjMJb7naitfdLU70vpurl4UbJLpor8KGoiKCtchw1kTbV7
	nvtZ55G4xAcxcCCyNQt/Wwyw4Ta9wJ33xZb7EEQJMmxg34sCW0O8YLM2pDsy5TcT
X-Gm-Gg: AR+sD131RJZU8v461PjIzXhls7QSGP01BP749YNXDYf1VWyZXT3P4OAyn1SJqKDnEc1
	Q6Z4HTeMAfJLDt2MmeRVXsQcXskNgKXflM/D3/LAvtGxXRuwPWKAKZ/qakiYNDCYgczBeISIBsS
	I0Ob85I9Di/0NPx9lgqQpHHc73pMkECRTUoO02KoWNG2NvBhFy/g5KoMvS2LzPxmGwOsFRZFLvw
	xuOJgnNPxLObPkPkYE84Egqc9OPBsOvFDCXKL8yoUlOAG+3UAhTZCt6L9QDRCI43vqsox+nDDbd
	3aoCEQR4tS6E+sIBztL4kuJ83CUhKJNbK3eTZD7AXa/cEgruZZBnnOyplkx4DdmI7YRqqfjjMQP
	JYN/NrgNHH+BjGoV83G5I/5zYKVU8lzabOqXJ8UxfM0jPiR5cEpdqMRNlw9LEurUPONWjBaEQoK
	Icv2TPXWGlLPcSAA5Wx23VLVn32cu0nJAokMwTuKxNVZtPYWkxo73jZiU4BEn4xqarzSkeYG63a
	cMCGbQH2+kt7Q==
X-Received: by 2002:a05:6a21:7007:b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3cb85ffca47mr1802919637.35.1785877674192;
        Tue, 04 Aug 2026 14:07:54 -0700 (PDT)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm12142151eec.11.2026.08.04.14.07.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 14:07:53 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] ptp: ocp: Fix board ID over-read
Date: Tue,  4 Aug 2026 14:07:51 -0700
Message-ID: <20260804210751.48248-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EEPROM board ID is a fixed 13-byte field and is not guaranteed to
contain a NUL terminator. Passing it directly to
devlink_info_version_fixed_put() treats it as a C string and may read
beyond the field.

Format at most OCP_BOARD_ID_LEN bytes into the existing local buffer
before reporting the ID. Use a precision limit because the snprintf()
output size alone does not bound the source string scan.

Fixes: 0cfcdd1ebcfe ("ptp: ocp: add nvmem interface for accessing eeprom")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
Changes since RFC v2:
- Split the safety fix from the net-next feature series and target net.
- Use the short Fixes hash.
- Reuse the existing devlink info buffer and bound the source scan with
  string precision.
- Limit the change to the board ID over-read.

RFC v2:
https://lore.kernel.org/r/20260803205011.1249-5-ahmadexp@gmail.com/

 drivers/ptp/ptp_ocp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78c..3d26ec1f7b9ec 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2177,9 +2177,11 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
+	snprintf(buf, sizeof(buf), "%.*s", OCP_BOARD_ID_LEN,
+		 (const char *)bp->board_id);
 	err = devlink_info_version_fixed_put(req,
 			DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
-			bp->board_id);
+			buf);
 	if (err)
 		return err;
 
-- 
2.50.1 (Apple Git-155)
