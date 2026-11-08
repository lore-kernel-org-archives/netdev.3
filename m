Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120792;
	b=mzzXmLdZmpgAUAH5/j/Yy7c3v1Xo7G5XH0aTmTJ9XuCMl6hSm0cuNgVHRY4IVSJbY2gY
	 0vsJJyhfO6C3czY1StFJLliGxJf40qOx7st1kycr3OFHzGZOpqpIgiRi9tqjK/weFD5jn
	 h/xDG2Z4i0QJ7R4BP4AN6oax1okJLsD6gbUylkYy/yHujdiKvxmKU2spn9I6ke8+naqNl
	 qWQtsgmkrNXzMf5g2K9afSNOj9eY5Yg59x26OTGOkqaIlEH/wQQ9U14ESqTwL2+0HklR5
	 79O9Qruxu7OSEPA4RzpGKhDhsKDw66f3BxObIe7Yf/Mj3jrFMW8u+yjIIt1aMvNsf8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120792;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=8fMfiOGweAcQIPo4dT9V+NST5hjS1PFasnJK1IH2aqs=;
	b=E7WlUHQf5hQSDnDbj+ryPn515Y/gT1I9BWP4YGrI0T6xMzplZrdTvz7ZnN29cctQERCW
	 O8UtVtaDYIH5p8gkryXyFKgjQaG06jRbRdCYuSHc8zqbHfmKE3PQEnuM9nLPw93yn+fvb
	 949wjGnK/2qNzxaLe3s3lf2IKTFiwcrqvJqR59PHjZU+dcZQQTI8KY7Xnt1L1DSKyTF7F
	 eKsSVG2UCmVCZhjMcpk1JawYsXmEfSKCEuWzj28WwVxff/s/V2IoX6O+LtjM1/qFYoOlC
	 SSsiIZ4Tce2t9AXbv8h4t1MepPc4wL/G0Qsr8+hcWMKRH1/3UXFIDwzL0YSq5RMylrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LIk53qWG;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD624606A31A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD624606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LIk53qWG
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso89766a91.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794120791; x=1794725591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fMfiOGweAcQIPo4dT9V+NST5hjS1PFasnJK1IH2aqs=;
        b=JM3mONkvy+6MZEi2v56e/JSuRNfrJ58kZ0sJ4yNlMR9C8gL0aM/ldq9e0ZYxNrnmXy
         b3xif9tl+YtdvFbv1XjBkbmicSur008DNgivAQmLaBNOSwE1yMgdg0e9uY5PjCoqxhrG
         PUG03s11pedAW+UDkqxpSLTY5Rrzp0iCBP4+r7n52jfJqavIP5TLdR1IEFOmgOSJ1q7m
         Z+AxyLoUjryvIf8c0M8dB26M1zyaf+24ZzICJi4smJkooobwWxXV1oBy7Q+H/Bxyj/Sb
         Gcnpm6HDCndQ6QC0b6zTkqyuP9Y01bueCBidf3xMfTVhB08IXyPgAjDFnNeG2YEb27r+
         AHwQ==
X-Forwarded-Encrypted: i=1; AL+hErHvP5be8Q4b/CMTbcJUA+27J83QFY48TYm8/zW61mrQOmeYYoFlwSd2S20VqHR7S4oW5F/hRLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fv2rqfsZ1zRcatmhoP15yd6BQ5eKR3Z8LE9sFWgjc0trpD7EC
	5m70ehSl3fc7bXf/jXW3gPtQADvnndkg0jRTeAJBgtp0RrgOxer2b3/fWZhxdw8duG3T9s78CW5
	82HozkHi+6Q/8WcxfcwpeRlFo06108b3evCx/al7Qy4F1ELn1dtEMRtkB21oS3d+7kUaqM7w2S+
	uOBuWuBrKyMDnc6jWmX04nKioL8oF9+4biilLLCXhRxj6YcF8B8EwlPMGtq4m5cRhqYZhojZnf+
	tAwuEFHlSx/PQ==
X-Gm-Gg: AYBFou3LqOUKA/P9ksTRW8f8H9fDLH4i64gGBMWCslniO+iYrdTFLhqUmc/W+6kwl4L
	Byj8JiYPPG5EIhlCYOzzM3wrZ7K6vhTgM691KEnFheSfgeamGKovK2JA1px56Z2PUJK7JYOpxAB
	gS4G15jkrW1JjSlrKvErqUW0i1dO5DUqwNN7z3Bd8KqIyuRvwfoSktEGBDWwehmNuiG7mCWJYQN
	fnBTc+df5dhQurSLZjt0VNQj0dxzymlego0/bAVhNg2Iy8gCiTi8xMYYaxGGfX/8Vj6Ay7/F+aV
	idzrVSlnM4vgZrs3Ej1bGH1AJR+vwJwDGbSULy5xctzXI8t+ZNTYE+FLObmZivQX5x3PPLtkx2j
	QaIEj1gF5gU3bCtPU19Ku4jBF7sF/PscT7tujxK5ghg/BztYgV/HhS0NiwrMyhnziqsTw7bvDHz
	MPwAjUDMS8pzBue8CfHLlveeGVPSUwuTqFAIk=
X-Received: by 2002:a17:90b:55c5:b0:3ae:9944:3bf0 with SMTP id 98e67ed59e1d1-3b12d4bb729mr579028a91.34.1794120791126;
        Sat, 07 Nov 2026 22:53:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1058d66absm3253298a91.4.2026.11.07.22.53.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 22:53:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36ecd5db581so1316265eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794120789; x=1794725589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fMfiOGweAcQIPo4dT9V+NST5hjS1PFasnJK1IH2aqs=;
        b=LIk53qWGWJHLFPqPWUqPVuIkaojnY21FSLewFFjWJbtXBA3SOhO5iXGltDWaLf/+z5
         gRMXJEygv2KrkNDUVTZOunkYxh/JHvy/9xlHaeoDDQ2ZZIvCIcCbRmb0kOinapISej+E
         xuJRriIIuWApUDwKImOx2N+Ma+p2jNQCGZbUM=
X-Forwarded-Encrypted: i=1; AKwUvBy6KXn17LbMxFfmNyAy/6skvRX1I/4giB8uYzElxjUjUbybCaygNXmvOFv9Iy3Urvv7YKkNfFw=@vger.kernel.org
X-Received: by 2002:a05:701a:ca05:b0:196:aa86:fcf3 with SMTP id a92af1059eb24-1b39fef03femr1339177c88.26.1794120789332;
        Sat, 07 Nov 2026 22:53:09 -0800 (PST)
X-Received: by 2002:a05:701a:ca05:b0:196:aa86:fcf3 with SMTP id a92af1059eb24-1b39fef03femr1339143c88.26.1794120788655;
        Sat, 07 Nov 2026 22:53:08 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8a27sm3497993c88.7.2026.11.07.22.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:53:07 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Vishvambar Panth S <vishvambar.panth-s@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net 4/4] tg3: Fix heap overflow in unbuffered NVRAM write path
Date: Sun,  8 Nov 2026 12:25:26 +0530
Message-ID: <20261108065526.710152-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
References: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shravya KN <shravya.k-n@broadcom.com>

tg3_nvram_write_block_unbuffered() reads a whole NVRAM page into a
buffer of pagesize bytes, copies the caller's data into it at page_off,
and writes the page back.  The copy size was clamped to pagesize rather
than to the room left in the page, pagesize - page_off, so a write at an
offset that is not page aligned, as ETHTOOL_SEEPROM allows, copies past
the end of the buffer and corrupts the kernel heap.

Clamp size to pagesize - page_off.  Also advance buf by size on each
iteration, as the data of a write that spans pages was otherwise taken
from the start of the caller's buffer for every page.

This was found by an AI code review scan.  It has not been triggered, so
the issue is theoretical.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Vishvambar Panth S <vishvambar.panth-s@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 16f8368874e7..5b5b21d759a6 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -3399,13 +3399,14 @@ static int tg3_nvram_write_block_unbuffered(struct tg3 *tp, u32 offset, u32 len,
 			break;
 
 		page_off = offset & pagemask;
-		size = pagesize;
+		size = pagesize - page_off;
 		if (len < size)
 			size = len;
 
 		len -= size;
 
 		memcpy(tmp + page_off, buf, size);
+		buf += size;
 
 		offset = offset + (pagesize - page_off);
 
-- 
2.52.0

