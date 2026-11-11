Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400606;
	b=makUqz7t3nZShm7Lb5Sq5J8stc1R2u071/7D/9Nr3pw/J/A3mQhN7sY+klo4q6YPMCVE
	 sLJkddMOvLDwE7D2wfzxPduAmZSwqVtfUarMGhYaixZn5eDkcc2B4mz8tadW09cTLscE/
	 4VxQ+CqdPoIe7PspDCMuGXnXfZEVQ5YX+FY+Q/929gHRIF52/Uzp2O/Ml9QnSwdQjIHZw
	 0e5Ai45h5qu/+sOn4U5MCCyR1k1JSFIs+sA5dSoOrPNa8zh5J7b4RkllqKHC8dQjvVKI2
	 7Hq1XTj9AiDXLfwWSsyGmZLi0J77nDpNVV8Cq97f6XG7XZKS4ZsRR2XOyMhVZ3wUWbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400606;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=XgGUNqQwKuhtwUK/qpuPjXhc0OhSw1rpXmf3GIB0EJ0=;
	b=tJwP7LVZIVI2daSX5p1LWDg+mkwpEIzAbZ8gpoGQS8JMLgQtr38q+NsWWD79StWl0FDT
	 XiINYfxbw/mrEMd/o55zqDd2wUwYQKLuZ1VKMMkATgS8Z8jmmcIkIQCYkh48KwYp89UG8
	 ECOpFaPpi+/YrXyqo5lFC+SuC0m/qZsINKj3wioRX+KZXtbQmzZ98eLRe+ymWQBKrUP3Y
	 KQD51KEz/gcnKWPUiE5NnaNkTpTgsp3YEZzraJd4QZC6crti4zcjnwgvQPZOhjCbD3DCL
	 F1rsdHv+QRDT4PZiVaRRQMjqbAIBwOHhRHsT4oOChXrrmW42wnBXcXf1Pi3mAWhabYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=K1iwTd+J;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AB606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC5AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=K1iwTd+J
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1434614a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400605; x=1795005405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgGUNqQwKuhtwUK/qpuPjXhc0OhSw1rpXmf3GIB0EJ0=;
        b=t+kQUQhpi+hJHXN1Tcb5RQaB3/ajIVvYVqrk8ikk/mM9y34rT295Q0RfFjDgd92jqE
         KN6MnKD8NeM73CdG95EkaLMGcvR/mPZMTIFrpf5VxRjpOGmZTkGL5MZ0GXKqjXFYRgKV
         BsNjs7VZV4lB/qf5EJMxSWx0TpsSAfg18wwRxJRMsODA5aa1uGU7K0EaCM6zsI0tTVtZ
         bL7ubLknThETFbkaHO8bnGrXMBv3vfEDpiKIJhyP7YkfEXZrym/7RB9aUuHTCthiN2mK
         OyOGPD0dY1fXpevGmhL+z11uwEoEXLogbECo8vqd3NzxbRVYueHY739dYxyGcb6PnHFq
         RAqg==
X-Forwarded-Encrypted: i=1; AL+hErFhUGWVFS20QltRmmpxoEWxIwC4BOsGRshhp536IM3H3pT9OZJ8UFHTCZlV1vAjCKQEn8Xt2bE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/Jb12/yEkMwqmxbiCqHEbDELO5xaYXmexDybJqLTOgssr2Vrt
	Zh0mNsYUKzG0ZaXx9DKeanv3qxnlBMtjv3njvJUtwX/gY97xDmbKXeGHamQ3cVIEv9T+02LZt5M
	sPFZFAnFyc80tTlbLTtBHcVs52foG6J3PWNTbS8YfxeV7IA20Er8NchfXdEecmOV4ikupb43tTp
	ikrEkVlyfXvaq/Qw/TATAOBwKjD88FEiQKviEabOztq/JQI+8i6l+bF4Hr1q39gv77OYc93iNuu
	gaJbgbkFqQCOaJq
X-Gm-Gg: AYBFou26AfXzw22NEGDVN6ByBXJD9yBUHNwWNZgAvtm0EAT/gPKe+jfgugh/gdYRCKc
	Rk1cOVJaII+Az8dwP3AgQCGpfQyh+g1cinch1+tALSpe1lyMkLUsTGyt7f6p4StuDHb0faSIXrZ
	4oW+H8Q1EP/+35ld82VBEbrQagKIXQeTJ5RkI2XEsT6ltKHO9qOeuc9wyJk5CQt3TqfGjoSDgkh
	VDV/CKnFS5QULJgvKEMFttzPFhqRyJrzQJCVDNfz6MS40Lj8LZhk+6ceowdcQkxySEDc0qIiXcP
	pTIDPVfUXSc5ef7e2fd9mHgh0qoehaDRZewGzd/fEPpPlVFk3HlvyWd1qCVYwl76AFS+wMhzruz
	pZWZlSEGE9ATNEGGs8PHIpTgnXxp2gBlDcyku9FeijD64ZDFl1qWMxhw/3IZ4tZDDceRPVMxzGv
	BjM+49BH5v57VhwzUP+071zK5yk17Hbfi5WhM=
X-Received: by 2002:a17:90b:5344:b0:3a0:d265:3647 with SMTP id 98e67ed59e1d1-3b182e107e7mr1943408a91.8.1794400605196;
        Wed, 11 Nov 2026 04:36:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17de318c9sm2023625a91.2.2026.11.11.04.36.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:36:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so6617404eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794400603; x=1795005403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgGUNqQwKuhtwUK/qpuPjXhc0OhSw1rpXmf3GIB0EJ0=;
        b=K1iwTd+J9YWHXaQkmKExwilMz0QsjbAUqKvl70+cJBX54Q+SKxOZg9j+YKgFcYc8Ps
         jT27MVaDLYZy7rOPhu4doopwccRHiUPlaJDUWTb/YB9rXEPNKTbvfwS/nN037JHZ3KfM
         942jewjO7w4n2kQx7LsqwzXhrdbgqhqbRKwAE=
X-Forwarded-Encrypted: i=1; AL+hErHkbv0DHvRGXGwxcR60fg7McWzHPzvATOIjNQrGSug/ZmTFHc3q4juX2smHtTomc6kFGINyfkw=@vger.kernel.org
X-Received: by 2002:a05:693c:62d0:b0:36a:1e0a:accb with SMTP id 5a478bee46e88-37686950cf4mr2985606eec.35.1794400603200;
        Wed, 11 Nov 2026 04:36:43 -0800 (PST)
X-Received: by 2002:a05:693c:62d0:b0:36a:1e0a:accb with SMTP id 5a478bee46e88-37686950cf4mr2985565eec.35.1794400602372;
        Wed, 11 Nov 2026 04:36:42 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm15159947eec.28.2026.11.11.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:36:41 -0800 (PST)
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
Subject: [PATCH net v2 4/4] tg3: Fix heap overflow in unbuffered NVRAM write path
Date: Wed, 11 Nov 2026 18:09:16 +0530
Message-ID: <20261111123917.910416-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
References: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
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
iteration.  Without this, a write that spans more than one page
programmed every page after the first with the data of the first page,
and a write that did not start on a page boundary lost the tail of the
data without reporting an error.

Reject a zero nvram_pagesize, which would otherwise make the new size
calculation wrap.

This was found by an AI code review scan.  It has not been observed on
hardware, but it can be reached with ethtool -E on devices with
unbuffered flash.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Vishvambar Panth S <vishvambar.panth-s@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 4becd1a0b009..7558f4f164ac 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -3379,6 +3379,9 @@ static int tg3_nvram_write_block_unbuffered(struct tg3 *tp, u32 offset, u32 len,
 	u32 nvram_cmd;
 	u8 *tmp;
 
+	if (!pagesize)
+		return -EINVAL;
+
 	tmp = kmalloc(pagesize, GFP_KERNEL);
 	if (tmp == NULL)
 		return -ENOMEM;
@@ -3399,13 +3402,14 @@ static int tg3_nvram_write_block_unbuffered(struct tg3 *tp, u32 offset, u32 len,
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

