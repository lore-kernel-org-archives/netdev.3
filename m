Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A62DB7BE
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362645; cv=none; b=X/OW51dFFg4K1v19qhAWXx8N4G2ZHXiTLau9gxxC/Q5jeMglORGfDlE/HATWOAmfbD0vTn8Q1FH0e7p7Yw9kyDuM6rCgLIB6l9AHPE/8s/or/0MUeZgZdh3ZUPBx5BLkHIQAek2vvQfSbtYkJvi/Hjuhe7XUrpT0M7JasSrg328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362645; c=relaxed/simple;
	bh=aXygDM+VTYBD+bNZSZXs02M9hT65PduMe8k6EMsjVeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obwBRnyLNHEqj7EwywASr89u7+zjfGMruK0miQFirmDVbsm3dB/9yV47qn8NnJi/f/NtSp5ujutY7WNEm+HZaFa/Fr/lBI2CHYCGyvmqr1LvObxdjCNSi4CbQlIqcSGuOZ8TLpnBgg9LnIcZH/vvNOympLwZDtyp3tBMdW26jwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2T2em7j; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2T2em7j"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1206582a12.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 02:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772362644; x=1772967444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/PUY/W2xLVyfoFf7iYt6HuXRzFvXPfeO6RS8rO/tLc=;
        b=P2T2em7juamaFKAu79SLRXws7f0BT9BU+VJrjcmK9C/16hBwg11/iim6yuTcRXqQZH
         RFKMeJTry06/yL0+F66jWWDeZ5IG923tztE/bxMlujWMmHd6pB1GiPOIiBvx5c/VPwht
         w/GgpuPTSRmuv/gdOKc93aWcuiZSvLaQgg8aaQ41DCxXPnO2t5g0AOHamjJMf0fr3wMV
         KswUPdiGcWH6e6Sb6666k87PmuGF3ZvWvrnpw4Q/KVOI+ukYQvINJEIz+MU99V53i6oG
         7ldegbG0NV1ektI/gKthJYKxbfQjJyhs/tgSqRY/nLrtFAseGihdeSSAUB+lnB1nxNpP
         htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362644; x=1772967444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/PUY/W2xLVyfoFf7iYt6HuXRzFvXPfeO6RS8rO/tLc=;
        b=PEKalMYqNyDUESfiakhmym+h5zP1RTMt9BBIzioAaoxQOs70qoBLMWVpdYw7nY3QW5
         QeyycFNw/Ga+AEAHAq1ryne1aA3Ezr3b1BLvYewfSWIcrp0nrBf65WUMLgXUfl3FtK3B
         4FCRLlyf4oI2rpTCJp39bEKuILyo7KmmTLvOiEbhQf/OyhkzMGFEpMFCmL1wqdLV2V2w
         zGCqmxIun19pf5r5ICAId6m4EWR/RW3t25rLUGlDOtwoBfHkIoZcIkqfzUwUJN6vtNJ7
         63BwkD1BsQeS8RatHNO38m1VXzXPUFOEVbCqMlCbqT4J6cuOGeXVLXd+csz4YXZApqGv
         t6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTrYY1XaSdi8ZVPIL24b7cvBJvcwVzsnAbFZ+UzPO8DsLpqSbW29VUI31Oa5zteDYyG59VCW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgivCrYN9sKa9VBrgxtM+j1poUVhkf/PXz5izpUqnNiYeJSnn
	WaDfKU/Gm50NqblSkBRkIjcqiF8fDWXEl3jE1n4uGieha8qUKkBG6LMe
X-Gm-Gg: ATEYQzzhuw3BZeCvUZzMeLp41WOYkMHeszArg50De3/hzhlA+DMRU9QvgSZPH4TjQ+F
	BfqqQzOFjanhk9aql1u6JNONg3fdZV3uPaKNou3FqWDU3dpkpeyH7Auq1N0zA4vfvVA/ShK+ymC
	VwU1YXnJ2NPchY45H2wWoEZScPMxEui22Ue8tk7cCpE12kNlRKoxDIDh0AUW4MoKy3npA8Qjkqh
	zfTolIUQD2iwR4kXTwTiv9ylJF7QZUw17Uxzxvgs02nqMgitKM8qzKs/FPXrrI2y76BDZFDE33+
	n3Iif9BXMKAvg4C2GsyXWR5njKHNeP22j4werTNJWH0kaiPpgHIAZzQ4x6cwvmNLVe4yYO5Ylzu
	gULlrboiLXNneOErzY/Ni8T+AOYOcc2pNH5oeYgJSvmSBRaLvNiaBEOBqtg/5hu8KIrNWoocxul
	k3ghshYIscvOKvDew=
X-Received: by 2002:a17:90b:4fc6:b0:354:c3a4:397 with SMTP id 98e67ed59e1d1-35965d02b63mr6792314a91.32.1772362643916;
        Sun, 01 Mar 2026 02:57:23 -0800 (PST)
Received: from hope.. ([159.65.159.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359833ef647sm2220754a91.3.2026.03.01.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:57:23 -0800 (PST)
From: Roshan Kumar <roshaen09@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: chopps@labn.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Roshan Kumar <roshaen09@gmail.com>
Subject: [PATCH] xfrm: iptfs: validate inner IPv4 header length in IPTFS payload
Date: Sun,  1 Mar 2026 10:56:38 +0000
Message-ID: <20260301105638.11479-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation of the inner IPv4 packet tot_len and ihl fields parsed
from decrypted IPTFS payloads in __input_process_payload(). A crafted
ESP packet containing an inner IPv4 header with tot_len=0 causes an
infinite loop: iplen=0 leads to capturelen=min(0, remaining)=0, so the
data offset never advances and the while(data < tail) loop never
terminates, spinning forever in softirq context.

Reject inner IPv4 packets where tot_len < ihl*4 or ihl*4 < sizeof(struct
iphdr), which catches both the tot_len=0 case and malformed ihl values.
The normal IP stack performs this validation in ip_rcv_core(), but IPTFS
extracts and processes inner packets before they reach that layer.

Reported-by: Roshan Kumar <roshaen09@gmail.com>
Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 050a82101ca5..4cd0747367bd 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -991,6 +991,11 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 
 			iplen = be16_to_cpu(iph->tot_len);
 			iphlen = iph->ihl << 2;
+			if (iplen < iphlen || iphlen < sizeof(*iph)) {
+				XFRM_INC_STATS(net,
+					       LINUX_MIB_XFRMINHDRERROR);
+				goto done;
+			}
 			protocol = cpu_to_be16(ETH_P_IP);
 			XFRM_MODE_SKB_CB(skbseq->root_skb)->tos = iph->tos;
 		} else if (iph->version == 0x6) {
-- 
2.48.1

