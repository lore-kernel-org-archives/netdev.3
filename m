Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602532;
	b=kGrDsfcLVTL2tXLXtyZ+EQDxMuUAvQ+mHV2zZFVFa8V5dAJOJhUEsf3vF3/wMiIDHJhw
	 2Kd0T9X/n5lbcf2IEMEJ+Q7NSs0AHgdqOZ/J55VGTNb7uWQxu/lXrwTNxeteUVMf90wgh
	 jYMmC4S3c4xQuHAe2Q0j4MP8pGtXYnD7rv8xhqNgM6e8j9q3R4hxSDid1zIrHVL8hH6hf
	 0Cyh80JlQV8UKi6bs9A1rTyF2vAxfMpGlAoxYDLEIfQpGx99QVuYsJdFRQzXwVzL+f9hz
	 xSnfpYoEKzDHP/93mSYGxESrlQ0UrF0v3Jf1FCVhxFFaQrKBh5Az76gQvq0x1NBGw6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=sV+HdYVMMEHC0OQ8zbugTeBoUtFJiy4lGJAqfe9bpwU=;
	b=bLU3HnoyldR0vFwgB++NrZ5a0qaS2y9miA5Ca8sKnJKol1kc07UHeYPfRwN4WtG9xlok
	 nHz7Y+DoaJ7j7NCWj/t+Ym3sdgPyp910tq9Wo//ZXZ0Uce18zTIg9uYmvgDcHUASNnEIM
	 4ZvDhsC6Vc+mOCiplGh8WvVk8K8G85dU+Xr6yxY+ufS4feNVUSI7WpyINw1fNzClFk2Y/
	 44rATdJRb8U7l/m8gSQX3pBe2WdQLWkb3BJJcpBXKZDof0sItRy/YAsy+wWZFjV4v4Xys
	 tCyZDqMKaaiKpByTeB9FN4jrrZ5VmkPFSAkD2uUlMXqYGKkFZwBo4ObKPDfCyN5X5Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXUreyO9;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC6606A899
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DC6606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXUreyO9
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so1673879a91.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602531; x=1795207331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sV+HdYVMMEHC0OQ8zbugTeBoUtFJiy4lGJAqfe9bpwU=;
        b=dXUreyO9lY8J6rVAnRlJfDyxuA+MDszLQAkNpBPfbZWiqkN0oliRbpCHEUZ6AUG/lz
         efHQD4O6tjzRz687XHxyitXetZuy8DGNY05FvwiKYruaFxrzynr4CAL6S4UKZluE9BS8
         +wUXZ+IUTLZHEvyr3GOVTr24OY0rYaKp7Xq1p93g1fhswjhyZhFcbAZJ0oeqDXEYBaOP
         4rS3Noo79ZjbyglVjsCZC+J+V401FzwHdAQHuoQSOKr3h+zJEeW+rpQBYhvskGlbMz7v
         vKQFf7Zf//Whn423XyIMRLnFUNc3fTMyeiqfN3GmlCUkj7UBgdX12I2RVbF/KSgQE1v0
         jogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602531; x=1795207331;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sV+HdYVMMEHC0OQ8zbugTeBoUtFJiy4lGJAqfe9bpwU=;
        b=kkILYC8Zmiu/B7NTVkywIvJB2Rq2fK3m47IoQI+zJa1FeYahgtI3Wr/jxZqlGyAWbU
         dQ4cB8ib721yCtWDGG7MZpffTsclRgkVfNGd6uIcW/AlSfqMjtUaJmQox6TVo0oRTpw0
         lVCp5Btut+537v0tRJew8HG6U9bE8v+NIlxVlGgrM7fhtKh+3U+M47zWGxtBzOuDBAqP
         B1xQnpzwXpp7oRK3WZWzSL2NcJz4iji1vG7u7PeoFYRdcfgsydLN7xj1R0Rla209X+1C
         iVf7Q/4rLFurvuS/2kB7FJUQxXjM/AH3dW8lp+xAUcqqM6NBQvrtybGJTI7+xi3gtVev
         NNSw==
X-Gm-Message-State: APuU4Z/LQjxVcHmkvdDAU1jCv0BJUUxM++PSFkZPwzyte2AtU89mniP2
	UyDbub3S6ou8tImiUDEZGPgTZXdxy/ztywxOLZSZuFrCFMaS/rtQ/EF7
X-Gm-Gg: AYBFou1WZize2bZTAOLgsYt/3Gb20X5oC5qHw/B20627xn1BkHD+tLIfLux+vudZKeX
	P2Sp5xivsLi1qqJD+XvDrpvqztkyY/HTI+9XxapyAImPQ/+p8BtKJeyxqrpYbhmdrzL4ilnYGDd
	EBt+m93VrqSQTmoan9Bw7KkORwwirnAAFanx5GIhtcPWRQBerDwuM4gOvSofTxRWyB1a1MjD3mc
	QQvtQwEWAeOp52xKpCguuV7Q1NzQugTgadoqq2eEiKvucIAL5NmPnelp+gK3TGs6aOntYV/vvO9
	Pe69SD2sx7CmJT8/IfrgqBrYjts01z0s5lLzTbl6EurcyRjdJ+rF3/hQqfCqb852Wwp7CnLvgYu
	E2rv1/3Q5MBt688qCpUiDs88d8H3TuArICOA3Afgkepgp68ILqjt3uaDS9U95AZlFPQ7+6APyxI
	IYFxDcX5obHCfAqUSEpYWghSKhrLPq+PWsKlUPFyadSGBfwIGD6lPtoEfkVR6oCWKb7rb3r/g5/
	x6fyIokn4h3J6Y7/SlhJbTYhbWsSVrypJpLhPmrmJyc1XLRrsQpVLGEY8xDZqRSbgk24Uh/uKoE
	0DDWw6cdcEfCwqOmyGOM5+i2zJcbv09BNFckL/3nC7ePzK/XGQgrBAL1SmsKN2GLureFZToZutG
	QN9VvGYXtt7+u2O8CamZO1J/7gH3Bb9ipeYewlDUxpvMzRKwfHQfrNoILozOnLV2tx24=
X-Received: by 2002:a17:90b:4c02:b0:3b1:922a:7b22 with SMTP id 98e67ed59e1d1-3b1b0d77ae9mr3493152a91.60.1794602531231;
        Fri, 13 Nov 2026 12:42:11 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm11195538a91.9.2026.11.13.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:42:10 -0800 (PST)
Subject: [net PATCH 6/6] fbnic: Allocate FW completions with kvzalloc
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:42:08 -0800
Message-ID: 
 <179460252839.8819.6136127951599786768.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_fw_reporter_dump function reads the firmware coredump into a
completion that carries the whole dump, allocated by the
__fbnic_fw_alloc_cmpl function with kzalloc. A dump of a few hundred
kilobytes makes that a high-order physically contiguous allocation.
The dump runs from the devlink health auto-dump when the FW reporter
fires, which happens on the service task with RTNL held, and a reporter
firing on a missed heartbeat is most likely when the host is already
short of memory. That is where such an allocation is least likely to
succeed and most likely to drive reclaim and compaction hard.

Allocate completions with kvzalloc and free them with kvfree. Small
completions are still served by the slab allocator, and the coredump
falls back to vmalloc instead of failing or stalling. Nothing hands the
buffer to the device: the mailbox Rx path copies each chunk in with
memcpy.

The dump size comes from the firmware, and until now kmalloc refusing
anything too large was the only bound on it. The firmware keeps its
core dump, header included, in a 256K region of its flash, so reject a
larger size as bogus instead of allocating and reading it with RTNL
held.

This was seen on production hosts during host memory stalls, where the
auto-dump that followed a missed heartbeat logged an order-6 page
allocation failure in this allocation.

Fixes: 005a54722e9d ("eth: fbnic: add FW health reporter")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |    5 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c      |    5 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |    5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 0b653c4c20a7..f63cf3224510 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -414,6 +414,11 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
 				   "Firmware core dump returned size 0");
 		return -EIO;
 	}
+	if (size > FBNIC_FW_COREDUMP_MAX_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Firmware core dump size is too large");
+		return -EIO;
+	}
 
 	/* Read the dump, we can only transfer TLV_MAX_DATA at a time */
 	index_count = DIV_ROUND_UP(size, TLV_MAX_DATA);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 3465f0139883..96cfe0b4cd8d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -382,7 +382,7 @@ static void fbnic_fw_release_cmpl_data(struct kref *kref)
 
 	cmpl_data = container_of(kref, struct fbnic_fw_completion,
 				 ref_count);
-	kfree(cmpl_data);
+	kvfree(cmpl_data);
 }
 
 static struct fbnic_fw_completion *
@@ -2108,7 +2108,8 @@ struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
 {
 	struct fbnic_fw_completion *cmpl;
 
-	cmpl = kzalloc(sizeof(*cmpl) + priv_size, GFP_KERNEL);
+	/* Can be large, and the device never accesses it, so allow vmalloc */
+	cmpl = kvzalloc(sizeof(*cmpl) + priv_size, GFP_KERNEL);
 	if (!cmpl)
 		return NULL;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index f47669129c9d..52f69274889e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -40,6 +40,11 @@ struct fbnic_fw_mbx {
 #define FBNIC_FW_MAX_LOG_HISTORY		14
 #define FBNIC_MBX_RX_TO_SEC			10
 
+/* The FW keeps its core dump, header included, in a 256K region of its
+ * QSPI flash, so no valid dump is larger than that.
+ */
+#define FBNIC_FW_COREDUMP_MAX_SIZE	SZ_256K
+
 struct fbnic_fw_ver {
 	u32 version;
 	char commit[FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE];


