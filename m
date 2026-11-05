Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875157;
	b=JOZRM3b2zjSMZwGwzQlM6NdwqjusJYAOyDotO9v1+UikmD1/AUqStV3fLPTF9IciOQOs
	 AAiNx2ExMQlbM5oU/mPhUAN1mjywdAlrfDd47XonyjiYgUFVD9IxjhiP/qK7+pQaWyPzx
	 5t2YUNFrhfZUwWSjK6UbO9WPTNVHO791a2eHFunLH0csGyUTfzKNe9Gl4VbhJzR36vfc3
	 63Mq9XNHi2q0IZ81voiH+yAt+V5mWKaCRa2md4nrPSrL9gwIfQjRlYp6ylOUUFNYru5zU
	 g5Wbd9pO2letDCY06vcbzm/WXnJH91fTSOE1Kh++xDfE3O3HBYv7QgE6/mo8DNt6SRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lNM3+b6l7cj+vrA9YlqTwqxAWDbif1TufQothTfjcdI=;
	b=S79TnaqS9LmYGU+xtIJRryCKQDJcnxtUHToulShg91S4zoM5sHAp1U9s9wp2HrJUSrHt
	 n25GntIJ/P4eLRSx9XrLNmT3xkqzeQNRV2x+w179Rrp/xgtGq7hxlxQMPodP4IZF9yeVg
	 fWC31XDKXLK/Tl72C5s6vEHMRFKp8sV3V3ONct8D9ICAaQwCdlrgOKe8jQhmDwEYl5Vmx
	 9V1d3Tkn6Zsd1bajbwoE+5fuV6kEYlsmtlJ10WXeJApvHvaXgSoYVCdTRs8L/ypRK7OTj
	 b0Fa23KP1+V5T8j4DedyzwtiEj9OxiobWx1CPaTQaciJ0VwEBDW/n+rLCUIvlhXsgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjCh0fq0;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859E606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8859E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjCh0fq0
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc147d86bebso338559a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875157; x=1794479957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNM3+b6l7cj+vrA9YlqTwqxAWDbif1TufQothTfjcdI=;
        b=pjCh0fq0qx+RNgxteK0ZIrGAFkwaK45cQnfyhJnWe9tGbhkOh1qz4FAwd8ZB3Az4Wj
         GNum45Q/Z6wdUou/T+LuctSFESp5JmHqKQwpdqhOSOvmFBt1QU4PDhvZyapHupyEP74+
         /kH2qFPPlVrdL97cDxTh1BXqfJw2EgEv02fjjMT94KG+Bqke/ueUq0Cio+ohZgFlxe5n
         UcO6uvd8wyhS4tZMCQhCyi4uYcy8NQxSkJs+Jpg8g9aplG7nRzykcOFycZX9lqCfeXkp
         w3zbCh97UVSKQ/eOR0wnRX1ICDV6gnSsMXl1N8yO6qv5qXhvIKy2WwEeSupt5eNFlCWu
         p96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875157; x=1794479957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNM3+b6l7cj+vrA9YlqTwqxAWDbif1TufQothTfjcdI=;
        b=ro9hPfHXZTTMVz+lFS/pZLfvn8tKB9Ipr9fMBd6d266mTwMUQbxIu9L/GPw9U2s4QG
         nYGGBmEr3VR8tsTknG2Uh8rDK1IC/czDWl1oZEpZ9XBHleJn7mRU9CRh7ooZj26A/dfV
         2EdBvYlKOtiLXGd5rCaWYEqB9gVxvXmupHhSfYUPOPsradLxFHW3PXnuwGh4meCR+m4K
         3MJysHlW/vPKX6OjxpEt2a6thXa9sYQjhsqYnmgIezhWzrF2naLW8Z98xwPW28feekcB
         2ut2ZbykGktxnDByZeJpGMnFCUYpEf67qKvOuTijnSJVYxonwvy7AAl7rBwWbLHyETJw
         epsA==
X-Forwarded-Encrypted: i=1; AKwUvByYRGVU3U23YjQhYsIhkaFF6q5dHPcsI/xyYAdgNVjD17N6tcwH3K3Z66JaXJbll8lS1isZJYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uQD8NLzrFHfG+gM4WMBkxmkPmUsGL3mmE7v3DXnMXUTuoaZiF
	CiQgSQ6h6hSih/OIQ1Zv0EOJst2aY1QZP3yFXN0rfmj2hTXvDPpQnDe2
X-Gm-Gg: AYBFou3+19phTmMW7c6bt0LjK3qAwhOixkdvoQaJZhiEbEBPtYBP+9lN9oNMJdIfP8k
	q0EP+2H3hXW0W1DEdvEtCWcfiFPlhslHsYDRD3jizp8NqlOIfqQl1XsFj4LykdHSdrrh99ofak8
	6csUJHXSbfndtN4592K5aHJt8cgN5foCXbH3cpYHbLB+VuB0xS0+J3XdkOsKjbGNaraVbhMQF++
	QHFPoTGn9WZkyy0w5ebJ7JMP9FD09VQTfSN9WKPsGBkqp4nEkqj8pGPC8gfI00f3TK4hzd7NxzY
	9kIgCGOCxbWFmqaIh4q8+Iy/DxEqCZFkYYnuwia6yOBAyTaGkyxUyL4xh+onB6spi/A9cOKvpg4
	uLjPM1uKiYpJs9z5GEgy7//ML2wmtQPco6vPR7RaXz0jJpQStLZbfIEttaZe1ob1xdMBdd38jZf
	FJlHFpOde5Or5p7FdLvn/hM7MyNFwEBr0pQMefCa1+jNsS+2Fn3q5KbH4/63hVheHc78wT6EZct
	WQ6LrsqekUd4FdgDwdCP1qCQLbhtPiESWTiYjC1GDdqBOzuX/PQSfF1T6fvHtpfPbJY6GpGDLt7
	yb/iM+xwnEjYfYmhi7oGibPBnZ1S6qvx6wOrxiLoG4Z/shdL+lr61T0V9HCYV4LKrKsSPQ==
X-Received: by 2002:a17:90b:5590:b0:3ac:9098:f602 with SMTP id 98e67ed59e1d1-3b0afbedfe6mr1784736a91.6.1793875156797;
        Thu, 05 Nov 2026 02:39:16 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4694a0e0sm2150791a12.20.2026.11.05.02.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:39:16 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] nfc: pn533: validate response length before parsing DEP ATR_RES
Date: Thu,  5 Nov 2026 19:39:03 +0900
Message-ID: <20261105103903.1440114-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

pn533_poll_dep_complete() and pn533_in_dep_link_up_complete() cast
resp->data to a struct pn533_cmd_jump_dep_response and read its fixed
17-byte header (status, tg, nfcid3t[10], didt, bst, brt, to, ppt)
without first checking that resp->len covers that header.

On a short or truncated response the handlers read bytes beyond the
received frame:

  - rsp->status is dereferenced with no minimum-length check;
  - for a success status, memcpy(nfc_target.nfcid1, rsp->nfcid3t, 10)
    copies 10 bytes from offset 2, so for resp->len < 12 it reads past
    the valid response data. Those bytes are then handed to userspace
    via nfc_targets_found() (netlink), which can disclose stale buffer
    contents.

target_gt_len = resp->len - 17 additionally underflows (it is u8) when
resp->len < 17. That path is mitigated downstream --
nfc_set_remote_general_bytes() -> nfc_llcp_set_remote_gb() rejects the
resulting out-of-range length -- so the subtraction does not by itself
over-read rsp->gt[]; the fixed-field reads above are unguarded
regardless.

A valid ATR_RES always carries the full 17-byte fixed header (the
general bytes, if present, start at offset 17), so reject any response
shorter than sizeof(*rsp) before parsing it. pn533_rf_complete()-style
handlers in this file already length-check resp->len before use (e.g.
the ATR_REQ_GB_OFFSET check in pn533_init_target_complete()).

Found by code review; not reproduced.

Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/nfc/pn533/pn533.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1309,7 +1309,12 @@ static int pn533_poll_dep_complete(struct pn533 *dev, void *arg,
 	memset(&nfc_target, 0, sizeof(struct nfc_target));

 	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;

+	if (resp->len < sizeof(*rsp)) {
+		rc = -EINVAL;
+		goto error;
+	}
+
 	rc = rsp->status & PN533_CMD_RET_MASK;
 	if (rc != PN533_CMD_RET_SUCCESS) {
 		/* Not target found, turn radio off */
@@ -1929,7 +1929,12 @@ static int pn533_in_dep_link_up_complete(struct pn533 *dev, void *arg,
 	}

 	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;

+	if (resp->len < sizeof(*rsp)) {
+		rc = -EINVAL;
+		goto error;
+	}
+
 	rc = rsp->status & PN533_CMD_RET_MASK;
 	if (rc != PN533_CMD_RET_SUCCESS) {
 		nfc_err(dev->dev,
