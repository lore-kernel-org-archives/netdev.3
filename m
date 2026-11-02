Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622235;
	b=nLIKLfiosTgrPJK+VXyDggxPFbwuylBoQb3O57+6N+8ILlHOB6GYGF1lJabedDYzw2ij
	 J+YeM3wM7Moz9Y0/UWQRZicDkZ/ztQbF7Q+OWkS+SjLkakdMjP+ph72aATRaxabLLVJqH
	 AxIllQH+k+lLlxMiCYI8cb2wQxnm9UYgomdObbDMYZY+F8w8QjhhtaMzplY+4VP/r9Lgm
	 FSZeZIx1yLQUBG5rlETpf0FUGVNEoxkWacVcGiHEzhbqf4OrUHFkGUnJgYzoXlPVWK3YH
	 fN2jXzU1TziSOFFA2UZ5gnbOKtHpwsarGxv/0+PAjCG142oN9itwh9ltQzurucnbj6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2QoSKh2R8YzTVuDYsIBEYhU9o8xQeiipmodiv0jofHA=;
	b=WA0Xli4wQv0AZYi20NJjXqzrYFLjf7t5ILWx+ULQ+k2cwcftZicHUY0VQHq0vkdoYL4d
	 GsyZ6lbFrnN+4xe04fueQ6/5buQhoPfta0jRpAK5H52fmI47WBFgLFAaxE0eQ4ywFL6+Z
	 F89Vy8dEraUfJdGCpJuxIVFh5wJvwSwIewOg6kp5u6RxgTOF4rDX+JEOAmkFxdd+Okujp
	 7qwGhsw7DkgXwymsCzKSZmbmeXB7WqhohHGZn9kVLYdhmv1r5LObTPmGsmkUgOVeXupGG
	 kbj550xvoC5COxwmTSDvJZwKknKXwyTVpUho6BOLiHUmc+20N+csyimyYORdgKKWyzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q7ESpj/6";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42799606A7B5
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42799606A7B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q7ESpj/6
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a208d93758so31340665e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622234; x=1794227034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2QoSKh2R8YzTVuDYsIBEYhU9o8xQeiipmodiv0jofHA=;
        b=q7ESpj/6KsDzr7j6XAkPlgRK2hofnMaxPPC2GiXQ7ITo175PoIJfr9ADgdo47qiWYi
         TvdfGWmfAEpLNmZwsf0QL74yGDboM7evObCV4bhUSvvhihGrzxYVME5MgOViKEbFdRjw
         4bZiTugSkcSJ0CLzRIrzL8Iwt+1ut4DhmSs58Yc2329wrSRSr29ea+cC4KFcfbFATCJN
         AjZ1TNct8upx8WTi6vWRPZb88s3WR4Rg7Lmtq4BA+2vQnNc7O8Q9VwY2DfIcXK6bKjYx
         PnXY+qlU+DFLs/wGZ44UHgFcpUwD6sYwl39JHuUZET/pS7sYvQcFFRZLRgeNfWcWPf9d
         WDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622234; x=1794227034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2QoSKh2R8YzTVuDYsIBEYhU9o8xQeiipmodiv0jofHA=;
        b=G+SBr4wEhSaXcUkMzq0oc9RGov5qUjHiJRrSaTXG6f28KUVDdyPQxkeOuSxy0sl80J
         Z9S7uTCrNWR/ER/sipw7F/jKJg5ZOfwjXTuu5ITPvXUlBscPcXcGSBv8lqUZxMmxPPuD
         wV/R7iT93x3Li79ATZF4hiVHbYk1LTWDsMF6Bz9seQ8xfZQPWemYoCwT2b9ZvULYbXoV
         sTTAXvThPJlz+TZ2AY724DTLS0pWJnX0eLlfTLoI1xR7KejDF30KAXxFgHoFfcUEphbx
         IbC/Jw/mDLGt//80RAU7YmJsVkF9MAFLf2uf00dAcdqyFL0VwWwE9mCp2nLe6oy2MCSR
         ZSow==
X-Gm-Message-State: AFq9FYJPv/SHW7jUJR1RHCYFYHZRV+lo6srhUwcBvRnAqZPu95t3zFiI
	3x3xyxaCwKY9pkBp7PRAd4PCC1qiFAZJZHrggmsxI3MbhZKfvrFP94ef
X-Gm-Gg: AYBFou1S+CoAE2ya5n2yUCvdh3DcMxt7Q3KltkcaEP8f8wxY3ijkUj7xF2ZVli1HdIg
	3Rsb3/biGJLhS3KmJfFhWFDL28v6WatrvfMQ/8+zXNVUXXTUOi430kVvDoWDPexhGW6wB7DZRuD
	ks9JxMHPmLLr1a3qdeHe8uV/EBocZeupa/ET1sYjVbI+BXUfoi6aJza57BEdsNY4HPPHHriQ4or
	uO9B6LRUqifa7uUbqdV/M1yl4SWGtxyxUV0rq4WzTakoFlgBWMwzQuQje29K4pVqRmrmiKRwPEf
	sWtkzs4BL7inUEKpcbxZ+xFzEOCcTCIDNC8dkuV1AKFsyK81eariINdEZKXVaVtVJW+Rg/2D+84
	ZyN1CFnfZ66XQRvnb1p6in8IIl3amG0e0+DGSS5/+jqAhCO1HStrXMiO9MQ2CjPB78OySjW5sqH
	b5OK0ZM0BCAImgLt9xgum4K8vMihjhSQyrFPCvNTkXLqEaRo878Ky4SouP9GNwZX9mqVTbEJ1Fu
	eQVlLbcwTJQrqg0dSMI60KawZSBXXVRP391BeROX+J6531AlVH3H1/+Bzc1XjJi5hW92TMuysDH
	+Yv2+029wsUyeL6NWTV6UOXw4HTFxMgnhg==
X-Received: by 2002:a05:600c:8183:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4ac180f2ba7mr215223755e9.12.1793622233480;
        Mon, 02 Nov 2026 04:23:53 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:4773:6f00:e7fd:cb78:efe4:a8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf723b5dcsm271952215e9.14.2026.11.02.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:23:53 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ptp: Report clock removal to poll waiters
Date: Mon,  2 Nov 2026 14:23:40 +0200
Message-ID: <20261102122340.1160733-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ptp_clock_unregister() marks the clock defunct and wake
timestamp waiters before posix_clock_unregister() marks
it inactive. A poll waiter can consume the removal wakeup
while the event queue is empty, return no events, and remain
blocked until timeout after device removal.

Identified while reviewing the PTP polling and removal paths.
Using netdevsim's mock PTP clock in an x86_64 QEMU/KVM guest,
the unpatched kernel missed 8 of 12 removal notifications,
while the patched kernel reported all 12. No kernel
instrumentation or forced fault injection was required.

W=1, ptp_chardev.o compiled under allyesconfig and
allmodconfig on net/main.

Check the defunct state after registering the poll wait
queue and return EPOLLERR when the clock is being removed.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index f63b45f5ee6a..01adc70ad97b 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -593,6 +593,9 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
+	if (READ_ONCE(ptp->defunct))
+		return EPOLLERR;
+
 	return queue_cnt(queue) ? EPOLLIN : 0;
 }
 

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.53.0

