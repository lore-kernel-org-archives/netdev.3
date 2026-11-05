Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869875;
	b=QMWaFc0obrHMmR0fY6W7K89uD0P2ZR7JU7tAO8zdAkoqXYUCAWHq7YWH9S8YzyOmfGPB
	 tMdEALMU1ZCILFpCS5+aPAXioqwDL2LME5VsDVt2kxyKTMLs4LVrQMvRYk2GauykKGECb
	 Nax7uFb4xXQ44NWHvCpgSRcZgLdbDaxyayq0/C8ZZSo9dFy7yTKx5Lf2EERYBmquiDzR3
	 2QxGWr76wi09Jyl8lEqxvh/iGQH8zjOROQrgAUwAi8SPrw8QlPJwOKh4C7qkw9qZv2H81
	 EuJme+vD5RtCsdjzzLjZesQ/XyyeBOuabfstcAkuJsHhouUNPBsQSaEUUIdeoPCK9UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869875;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=hE16CvVTuGg8PBhy5lWSCBxfK0aglpjCX03ajlgSRSI=;
	b=Qm5v/oTUdWT/Ogr66d5VCMy4dGaSDiYGm8D6rATnVb7bfI+b563DghWtK93quARivzFK
	 qMo8PS3KhKL1+exqeJHaN/4qgaVAB8CJ1WDO/ovgMI44Dm/bAnZfwvzGDut64PSrbNqY2
	 KGGAA45kJi67AE2ilUvFd5NG78Zz7bA7EX4iFmPYbqjBWqIDfBW3JDR6yimnMXxWOD0DL
	 zxSmiwSItWKqFWO1sEuxWzFnz8fznS9G7L+VqWmukHceF3nT5CVRLiUnzkLZAoX5UTDxz
	 TipIuMqEWxJpWWjZBROodGmtuY3/RNcNUTfyVbRXfH7GqzZpZV3z2zZUQDl2VRI81Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g+FGur3n;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC292606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC292606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g+FGur3n
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-ccca948203aso735116a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869874; x=1794474674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hE16CvVTuGg8PBhy5lWSCBxfK0aglpjCX03ajlgSRSI=;
        b=zDIz6YKKI5upAj/Jgsv+6p9I8P9iVsIOCJ+cjDF51nInzHcJNLhuNsBStpbO5VdUWE
         xQbpIFChabcOd3zt3xZ4sIExxW/oWMKpnUwKkM4xpEGroXit0yu/519XmGrkGK9S3gHl
         J/ZFCZQyrqhUNYD7NjN2ah5j3sJ72I3m546Ri76UQZ2Q1pCPyCsPg6BcJrJQPqv3QZAc
         xrc6rvjPNeYu3b6sj14lQ/yYzESdJREnHJA0uZrUAp45XrCFGkckmOzVmv2xDNy2Msdy
         U6IS85f3Zh2yziR2mvTMNA2qFrvLaudFSOtB3dOiLd0pPx59PgL5Tn16tILRXEW2sRER
         vkQA==
X-Gm-Message-State: APuU4Z9J9G62oFySrAffsjbZslMlCwKKUThlNyrVDPHqjRLmxolPfttD
	0ssYK+p7+bALw1p77IXfGLEZ0MesM6sigQyTlU23wvTM9BGnDSqnCDZNyPt8qDFbnt/dupPCPoC
	TyJ/0pTOmErSXHovfAvlkQBw9wg1LL7v02iOTRl5/Qy41nuSBN4S8XYjios4v6Hj4mpVca/xdYd
	Ee6Isxaei1M6xZxbAAbrIfctDZx5iJtWhEodq1P481/MQRzTbV1uwwmK66kydceloEEyjTfJoeB
	DO5hh8wFg==
X-Gm-Gg: AYBFou0tdcPKYZN2GRelrrOcq3t2wPFK9Wc3nWe1sQfOsRXnAVOpxJ6Q5aBneyKrA9l
	VZX3menkWTR1EMJCoI0AFU7PPDoF6DQ7+8kxCNgPYpgJopzj43hVNZrO6tjmItaDjeQ99c4//Ta
	wqSWleYlNpd1ED7pdK5yxNj6EEAy7GKpXkGpgnWMbLtpqCB52u9Y/4HvvxCPbONqHmh7/6+0YLF
	vTgVmtXptio1ftQbGvVLM4ZZXiwSjkVu8IojJh6ap9di0aRxTrooQn80lsUk9PaMxYpPVljDY6B
	+XKXEOEd2fv/dKbl5qI981Qm/eI8mcXEJWAqMCjckPEUj1ec42Ihm7U3qx2iUf7+psv7J6iT8oS
	is3iVlyFaTPY9zhm6uj/a8+NGYYp3J3dvBFJ7AIz7Ij5w16aT+rrzHpXcljnvrZyP5dr8XiU/wO
	rRziaZgUJiaAZ8pYS07HKXcM3AYmtXbbVefA==
X-Received: by 2002:a17:90b:3c4e:b0:3ac:9925:72ae with SMTP id 98e67ed59e1d1-3ae89766636mr13770931a91.31.1793869873448;
        Thu, 05 Nov 2026 01:11:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b327b8b5sm1512175a91.6.2026.11.05.01.11.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:11:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5337ed1ba44so36286251cf.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793869872; x=1794474672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hE16CvVTuGg8PBhy5lWSCBxfK0aglpjCX03ajlgSRSI=;
        b=g+FGur3nQFqnCBb7kM3xzZ/Wt2sPFEeW0ySvQ2NEbygDsk+X5a9bo60mzeI0aLapUr
         vItvFVFLg2bseGspLeQrkeX5X2Ozt5j00/ygc2soTuqZleYpmSOVNonlXufG/W63494k
         lEjtUgoKbitmlqLELlkcZiIyu51ZuH2KnDcMQ=
X-Received: by 2002:ac8:5a16:0:b0:536:600e:843d with SMTP id d75a77b69052e-542b781b1fcmr291258701cf.50.1793869872020;
        Thu, 05 Nov 2026 01:11:12 -0800 (PST)
X-Received: by 2002:ac8:5a16:0:b0:536:600e:843d with SMTP id d75a77b69052e-542b781b1fcmr291258471cf.50.1793869871409;
        Thu, 05 Nov 2026 01:11:11 -0800 (PST)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm47298591cf.6.2026.11.05.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:11:10 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	sachin.holla@broadcom.com,
	Saswati Das <saswati.das@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [net-next v3 2/3] bnge: Update HSI
Date: Thu,  5 Nov 2026 01:01:53 -0800
Message-ID: <20261105090154.1293846-3-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261105090154.1293846-1-siva.kallam@broadcom.com>
References: <20261105090154.1293846-1-siva.kallam@broadcom.com>
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

From: Saswati Das <saswati.das@broadcom.com>

Add support for 64-bit doorbells and Mid Path Channel (MPC) firmware
commands/completions.

Signed-off-by: Saswati Das <saswati.das@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 include/linux/bnge/hsi.h | 161 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/include/linux/bnge/hsi.h b/include/linux/bnge/hsi.h
index d4fe662d60b1..834db3991691 100644
--- a/include/linux/bnge/hsi.h
+++ b/include/linux/bnge/hsi.h
@@ -12644,6 +12644,43 @@ struct dbc_dbc {
 	#define DBC_DBC_TYPE_LAST          DBC_DBC_TYPE_NULL
 };
 
+/* dbc_dbc64 (size:64b/8B) */
+struct dbc_dbc64 {
+	__le64	dbc;
+	#define DBC_DBC64_INDEX_MASK        0xffffffUL
+	#define DBC_DBC64_INDEX_SFT         0
+	#define DBC_DBC64_EPOCH             0x1000000UL
+	#define DBC_DBC64_TOGGLE_MASK       0x6000000UL
+	#define DBC_DBC64_TOGGLE_SFT        25
+	#define DBC_DBC64_XID_MASK          0xfffff00000000ULL
+	#define DBC_DBC64_XID_SFT           32
+	#define DBC_DBC64_PATH_MASK         0x300000000000000ULL
+	#define DBC_DBC64_PATH_SFT          56
+	#define DBC_DBC64_PATH_ROCE           (0x0ULL << 56)
+	#define DBC_DBC64_PATH_L2             (0x1ULL << 56)
+	#define DBC_DBC64_PATH_ENGINE         (0x2ULL << 56)
+	#define DBC_DBC64_PATH_LAST          DBC_DBC64_PATH_ENGINE
+	#define DBC_DBC64_VALID             0x400000000000000ULL
+	#define DBC_DBC64_DEBUG_TRACE       0x800000000000000ULL
+	#define DBC_DBC64_TYPE_MASK         0xf000000000000000ULL
+	#define DBC_DBC64_TYPE_SFT          60
+	#define DBC_DBC64_TYPE_SQ             (0x0ULL << 60)
+	#define DBC_DBC64_TYPE_RQ             (0x1ULL << 60)
+	#define DBC_DBC64_TYPE_SRQ            (0x2ULL << 60)
+	#define DBC_DBC64_TYPE_SRQ_ARM        (0x3ULL << 60)
+	#define DBC_DBC64_TYPE_CQ             (0x4ULL << 60)
+	#define DBC_DBC64_TYPE_CQ_ARMSE       (0x5ULL << 60)
+	#define DBC_DBC64_TYPE_CQ_ARMALL      (0x6ULL << 60)
+	#define DBC_DBC64_TYPE_CQ_ARMENA      (0x7ULL << 60)
+	#define DBC_DBC64_TYPE_SRQ_ARMENA     (0x8ULL << 60)
+	#define DBC_DBC64_TYPE_CQ_CUTOFF_ACK  (0x9ULL << 60)
+	#define DBC_DBC64_TYPE_NQ             (0xaULL << 60)
+	#define DBC_DBC64_TYPE_NQ_ARM         (0xbULL << 60)
+	#define DBC_DBC64_TYPE_NQ_MASK        (0xeULL << 60)
+	#define DBC_DBC64_TYPE_NULL           (0xfULL << 60)
+	#define DBC_DBC64_TYPE_LAST          DBC_DBC64_TYPE_NULL
+};
+
 /* db_push_start (size:64b/8B) */
 struct db_push_start {
 	u64	db;
@@ -12739,4 +12776,128 @@ struct hcomm_status {
 
 #define HCOMM_STATUS_STRUCT_LOC 0x31001F0UL
 
+/* MPC macros */
+#define MPC_CMD_HDR_REQ_TYPE_ICA   0x1UL
+#define MPC_CMD_HDR_REQ_TYPE_RCA   0x2UL
+#define MPC_CMD_HDR_REQ_TYPE_PFVF  0x3UL
+#define MPC_CMD_HDR_REQ_TYPE_EVENT 0x4UL
+#define MPC_CMD_HDR_REQ_TYPE_LAST MPC_CMD_HDR_REQ_TYPE_EVENT
+
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SA_ENABLE                  0x0UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SM_PSP_SA_INIT             0x1UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SM_PSP_NEW_RX_ASSOC        0x2UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SM_PSP_KEY_ROTATE          0x3UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_CM_PSP_SA_INIT             0x4UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_CM_PSP_KEY_ROTATE          0x5UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_CM_PSP_KEY_SET             0x6UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SA_INFO_GET                0x7UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SA_STATS_GET               0x8UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SA_STATS_CLEAR             0x9UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SA_RX_MATCH_RULE_SET       0xaUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_ICA_SM_PSP_SA_SET              0xbUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_QP_MODIFY                  0x0UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_AH_MODIFY                  0x1UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_QP_MODIFY_CMPL             0x2UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_AH_MODIFY_CMPL             0x3UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_QP_MODIFY_BATCH            0x4UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_AH_MODIFY_BATCH            0x5UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_QP_MODIFY_BATCH_CMPL       0x6UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_AH_MODIFY_BATCH_CMPL       0x7UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_MPC_TEST_CMD               0xc8UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_RCA_MPC_TEST_CMPL              0xc9UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_EVENT_RESP_CMPL                0x0UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE                 0x0UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE                 0x1UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY                 0x2UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY                 0x3UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY                0x4UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY                0x5UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_CMPL            0xaUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_CMPL            0xbUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_CMPL            0xcUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_CMPL            0xdUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_CMPL           0xeUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_CMPL           0xfUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_FWD_REQ         0x14UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_FWD_REQ         0x15UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_FWD_REQ         0x16UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_FWD_REQ         0x17UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_FWD_REQ        0x18UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_FWD_REQ        0x19UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_FWD_RESP        0x1eUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_FWD_RESP        0x1fUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_FWD_RESP        0x20UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_FWD_RESP        0x21UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_FWD_RESP       0x22UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_FWD_RESP       0x23UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_ALL_FWD_RESP_CMPL         0x28UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_BATCH           0x32UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_BATCH           0x33UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_BATCH           0x34UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_BATCH           0x35UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_BATCH          0x36UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_BATCH          0x37UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_BATCH_CMPL      0x3cUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_BATCH_CMPL      0x3dUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_BATCH_CMPL      0x3eUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_BATCH_CMPL      0x3fUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_BATCH_CMPL     0x40UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_BATCH_CMPL     0x41UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_BATCH_FWD_REQ   0x46UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_BATCH_FWD_REQ   0x47UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_BATCH_FWD_REQ   0x48UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_BATCH_FWD_REQ   0x49UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_BATCH_FWD_REQ  0x4aUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_BATCH_FWD_REQ  0x4bUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_CREATE_BATCH_FWD_RESP  0x50UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_CREATE_BATCH_FWD_RESP  0x51UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_MODIFY_BATCH_FWD_RESP  0x52UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_MODIFY_BATCH_FWD_RESP  0x53UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_QP_DESTROY_BATCH_FWD_RESP 0x54UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_AH_DESTROY_BATCH_FWD_RESP 0x55UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_ALL_BATCH_FWD_RESP_CMPL   0x5aUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_DRV_RGTR                  0x64UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_DRV_RGTR_CMPL             0x65UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_DRV_UNRGTR                0x66UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_DRV_UNRGTR_CMPL           0x67UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_BUF_RGTR                  0x68UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_BUF_RGTR_CMPL             0x69UL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_BUF_UNRGTR                0x6aUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_BUF_UNRGTR_CMPL           0x6bUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_CMD              0xcaUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_CMPL             0xcbUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_FWD_CMD          0xccUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_FWD_CMPL         0xcdUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_FWD_REQ          0xceUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_FWD_RESP         0xcfUL
+#define MPC_CMD_HDR_REQ_SUB_TYPE_LAST    MPC_CMD_HDR_REQ_SUB_TYPE_PFVF_MPC_TEST_FWD_RESP
+
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_NONE                   0x0UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_BAD_TARGET_ID          0x1UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_SA_NOT_INIT_ENABLED    0x2UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_HW_CMD_FAILED          0x3UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_BAD_PSP_MODE           0x4UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_BAD_SPI                0x5UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_SPI_THRESHOLD_BREACHED 0x6UL
+#define MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_ACTIVE_QPS_EXIST       0x7UL
+#define MPC_CMPL_HDR_ERROR_CODE_LAST     MPC_CMPL_HDR_ERROR_CODE_ICA_ERR_ACTIVE_QPS_EXIST
+
+/* mpc_cmpl_hdr (size:64b/8B) */
+struct mpc_cmpl_hdr {
+	u8	cmpl_type_reserved;
+	#define CMPL_TYPE_RESERVED_CMPL_TYPE_MASK         0x3fUL
+	#define CMPL_TYPE_RESERVED_CMPL_TYPE_SFT          0
+	#define CMPL_TYPE_RESERVED_CMPL_TYPE_MPC_CMP_SHORT  0x1eUL
+	#define CMPL_TYPE_RESERVED_CMPL_TYPE_MPC_CMP_LONG   0x1fUL
+	#define CMPL_TYPE_RESERVED_CMPL_TYPE_LAST          CMPL_TYPE_RESERVED_CMPL_TYPE_MPC_CMP_LONG
+	u8	error_code_mp_client;
+	#define ERROR_CODE_MP_CLIENT_ERROR_CODE_MASK 0xfUL
+	#define ERROR_CODE_MP_CLIENT_ERROR_CODE_SFT 0
+	#define ERROR_CODE_MP_CLIENT_MP_CLIENT_MASK 0xf0UL
+	#define ERROR_CODE_MP_CLIENT_MP_CLIENT_SFT  4
+	u8	req_type;
+	u8	req_subtype;
+	__le32	opaque;
+};
+
 #endif /* _BNGE_HSI_H_ */
-- 
2.43.5

