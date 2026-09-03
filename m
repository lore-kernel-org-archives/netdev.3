Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7534E80C8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451642; cv=none; b=n2ZRVnimPW/JGKwcGdGNuAJ8oJplMv+wOsFx5Dwi1sdpae6eoYHlw0ME9pSvrPRi+bD1vKfv6PxH4nJJBoViR/b0Jd9deSBp+kxny33aP6alHlL4+nnLCaMtvlqsJtc1ZSeiuA4cHo6utv4IQjLAls6yxk1c3eobfgwthNYi4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451642; c=relaxed/simple;
	bh=Jzu2KXstYOECbzt9rTNWK4DwBRqC3yCzhFkwK4z3dl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyBTNu8eJWTKH2c7Mv6njSrmC/Y9v4o7PuWcC46EPJ7pJPSI6u++OlmIHxYSe+sCKP2HmjYGHsizL1ykQbkL0EEIbQq/+QK6Z1t/zSn35FnDCZafICWJfGbpW/6wnXIeDWfHGTROXQ949WygqczG3vBEtcIgnhQXjcjvA+XkMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJq5qR6/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJq5qR6/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1154319a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451639; x=1789056439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pk/3OnFOTIoRoKUZw9CsXTCFHsM4oEkvuCZPpwqZeus=;
        b=FJq5qR6/Uz7FKXcPGnqLfKVS/Ps4w0xrTa524Q3/Fo+4tngtg/xL4oTlegQC+tdVnC
         iJRY4l+4g96z+B3WohoayBr8/4u9LzYb9fXA9BXqlm08lCkxzDiiAfQfq3KzDDmX1Qqn
         4bIKSENWUqsxgnsITag7dMbUdRTUdk/DxgZguO7FayIKPNMUId6mz+2b92aIjoPtZErW
         vEzkI1ypFykKNvKA3Q+c6B6f/2I7RUO2kHsXt/HwQk+w82RVLkLeFU/XxXSwcWA9IW6B
         6g4w+0e5TFf9hB8yVedPhk3UI+TXSQy0NJg1wLAxqDxX+W6GiYH2TUvhfaK1AZYe3MMl
         jIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451639; x=1789056439;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pk/3OnFOTIoRoKUZw9CsXTCFHsM4oEkvuCZPpwqZeus=;
        b=W6Jvq8+LGN7QaPDyeQ6mlSEeS186nf15/xSqu2KcW4hWHbe5i4g7dJ7Ml+a4nSp7pf
         56q8Rno+6Np0IwsTs67KCUyr1irTwk1zh111KNsNlfjXcE/B7OT8ZyyI+4FP30k+nsq0
         WMGQgjUhei+xZ8VXHGp0bRL9zEyFJMCTxnWQpD3dGrcakQ6xR0IydMS17D5PunLCe4gR
         A2gt97wKuphmrGC9p3lgNGBJ09yjbuzBJeCqlpv+bU34r+Tgk9yV/u4IiOwrxrT/TtXH
         ZgUtdhGDSuOCrpitv2Oibi6/jhdwiqKTidcZRCuexn/ZbkFynSvS+lRf+To6WLmwFh/Z
         enRw==
X-Forwarded-Encrypted: i=1; AKwUvBwsgX10B+w1JaTHKVR9G4sNgS00ML8xR+CjPqx2u/itFQtHXtk1UsGO9OhW21BRQ/X1T1MXe0U=@vger.kernel.org
X-Gm-Message-State: AFuF++kvm9ggOqs/p9QNAdFl54u+IuhzcqeoVh0XWjZHiHLMu6w6W8Rr
	o0bAk2eR7Rvq5QQVZQVMDn7A2J8hNYuwQD7n3wgf4LpmPT7xpXaiyScE
X-Gm-Gg: AYBFou0YaU2WwGgLtvFl0Vfe/d1pf2aEazxivX3KUFkQlum0yb3c8H0A2rYFnrR5wAS
	tdjbOhlNN8UWsakZCueHY3aSFb8sYh+Ulk454H+65BluMCagSwq1l7L8SibBcqhK/wGk4GCm4uD
	xHm49JuS9q/dAZfsugmoL85pxfMdGJl/KKVYisNkSIywILCDAqR68KAoMQv0vOlM2fHpOo4kB9d
	BBKHXj6JrwijbIMEm8iEmiXjkpx9i0uuTXsyQOgQiKTOtctR5lDvAk473iOxHEx0vZr4/lpOlJD
	WwqKlpDEKfb2QZIWTBy+fIUxwyRHLKdlDQzEFjqUJViyVjHBMlYm/jvFWsyKinOVJOeLIUYARPr
	CywVmNfJ8ZXM5q3BlN08fu/NDVcsu0ceWBL85WliwnUODCDTamDBcGSVpmX/QgMr32s9KaIfB41
	4ug1sVH4O/MEzukBBEQol3Ex9M/kZTQCfFUB2Zp9EqVXQdN3g+dXezoh4p0tTdIOw9pQ==
X-Received: by 2002:a17:90b:3cc3:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39b132d819emr3821453a91.14.1788451639287;
        Thu, 03 Sep 2026 09:07:19 -0700 (PDT)
Received: from mhkubun.mshome.net ([50.34.2.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm3702020a91.2.2026.09.03.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:07:17 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
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
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 2/2] hv_netvsc: Leak send/recv buffers if GPADL teardown fails
Date: Thu,  3 Sep 2026 09:06:51 -0700
Message-Id: <20260903160651.1637-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903160651.1637-1-mhklinux@outlook.com>
References: <20260903160651.1637-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If GPADL teardown fails for the send or receive buffers, the Hyper-V
host retains access to the buffers and might continue to access them.
Per the code comments, the intent is to be safe by leaking the buffers
instead of freeing them.

The intended behavior existed prior to commit 02400fcee254 ("hv_netvsc:
use RCU to fix concurrent rx and queue changes") because freeing
the buffers was done in the same function as the GPADL teardown.
The "return" statement in the error path effectively skipped freeing
the memory. But commit 02400fcee254 moved the freeing to a separate
function that is called later. It has no knowledge of the GPADL teardown
error, and so frees the memory regardless.

Fix this by calling vmbus_leak_buffer() if the respective GPADL
teardown fails. The later call to vmbus_free_buffer() then skips
freeing of the actual buffer, including any re-encryption required
in a CoCo VM.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260731201210.3653C1F00AC4@smtp.kernel.org/
Fixes: 02400fcee254 ("hv_netvsc: use RCU to fix concurrent rx and queue changes")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 5cd084e5696c..449dc928cc44 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -316,6 +316,9 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 		 * rather than continue and a bugchk
 		 */
 		if (ret != 0) {
+			vmbus_leak_buffer(&net_device->recv_buf,
+					  &net_device->recv_buf_chunks,
+					  &net_device->recv_buf_chunk_cnt);
 			netdev_err(ndev,
 				   "unable to teardown receive buffer's gpadl\n");
 			return;
@@ -337,6 +340,9 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
 		 * rather than continue and a bugchk
 		 */
 		if (ret != 0) {
+			vmbus_leak_buffer(&net_device->send_buf,
+					  &net_device->send_buf_chunks,
+					  &net_device->send_buf_chunk_cnt);
 			netdev_err(ndev,
 				   "unable to teardown send buffer's gpadl\n");
 			return;
-- 
2.25.1

