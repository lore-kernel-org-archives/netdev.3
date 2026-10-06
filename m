Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCFC4418D7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291979; cv=none; b=pt6yLG1/L5iQ41lO1qske7xX5zn+8kkMpI+5rUbpHdbsNLxX2RnZs7tlq9sap9c8qHyICA9T11sn8Ubijx3NM/IJOMYbZVxzmMrqH34EIWlywebSJ1AldIXBzGNnFPlckWsJRkP7XhiB5idUymwHdlKE6bg8+JMma9RxqoagJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291979; c=relaxed/simple;
	bh=RebiLkL6e6eSy/yucX4SCf1nZkvFwcQydNlEwIypYtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE9J97gtwvbqtFgaxpHYXVc8VcW6ctMjeYS8LLJsJmEb/LbBRezUrcg7mK8UyMEYKY04PxWIti9Cye2mLo/H4zj2NhEnrf8WHI6acOI7nePQacBjMc0waSoLBV3VP9cuaaniywS/D//SJCbQlj0DgMkCAahkmIG2xpMnEoNxZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjQnU+UF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjQnU+UF"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-914411dd7ecso8932876d6.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291977; x=1791896777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7lFUR8NuWBC8JY0Ri3PFnQKBKUqbq8IeaicpmQmoME=;
        b=BjQnU+UFrG9Q3PTtw2yw39MgCpMbSrGiHnIWaaDAJZ4Rbfm44ZiOWhbsKIjFO/pHAl
         OK3Sop0jKewhGVSFMfG3tF470Jey9VoCpQ3nXA6KC3CqKfvG2j2WsueduX4kQiJEYwpF
         A7RqbFLxlFJcAwxFDcMVjSp4kb3QXK6M+4EGrCOLgkjYGhAESgeI69iM2WkN9rcWOmhx
         ZM0ePTfeGrA5jHGJid+VSheG16c+PaMBusaTF8oPncY0k0wZyOEHueMoJmQKJHPv7ZFA
         X12viLx9/x9KSOVUfenkfAGz3pz2cTHUBPcEuJXe17GOLa31euADMQDKS2JzWTahM336
         TsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291977; x=1791896777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w7lFUR8NuWBC8JY0Ri3PFnQKBKUqbq8IeaicpmQmoME=;
        b=jxcfSvCnjogyIXFn9IGmMrkBAHfoXxwMybXpNm0bnF1SOOH4nX7B/KE+7NO056Kxao
         HLQK5XhpY1/h/sGt7qVEPmoGDI8VW6uDf6UaXn+Hg2Es9oTSan2UTeK31yLOr0pK8n0F
         yJ5tEBzepTi0ghyecWCVChD0sqB/Ef5BsU0/mYKE+nAO/OqMkEjYqJHW/03er7KTkzn0
         jQ3tYK3GJBr4sdtsN4vWtKcEMYUybr89efHFFVmhlii5vmAQSCU40rbVlnX9HKVZ+9Er
         iFrMLt6WqHIdK/JUYpskzyhg46mT0nEFKr4VWo5HzoXshNGD0O9S7NSwGcuM3o97AuhQ
         GVpQ==
X-Gm-Message-State: AFuF++lNM+oHYpN8MFq+S7fiShD+Hq/IW/MgSVF9xWbk5u0KM8rkQLKN
	zPLiGM0Fqcn8Plv0P/3MkwK4CLOKSOnRmoENKjZPH0wisAua1pCkOqfLdGMI/NfBUG8gjw==
X-Gm-Gg: AYBFou37Ae/lg7arHkDYJXG2wIKOlTKZJaJeu3rUCaBfl6AwQo7wERr+rmAWjL1f55V
	7fyy/HKqVFbQD6sK1ihMrKS6J+Col3qU+F8eeZ8SPUSJxgyiHHFsxFwTS6PLJESZhbsaaXRfaOE
	y2ayBV32LOfpjAzOCxSUOXfhoNbPRifGaAEyDVp5ePIj//aXYIMTFSTc+dc/OngkAILEH4Wh9yX
	oNBP8RKs+wDSbhNl99wChsakMsuUM+TqaYcZE3PB2Bz2Xe3Z3j3KjnmwJ2rzRAUlBMEou2BWQ48
	AyLuiUGQrdPPGhv5ak9Z9hHJZolGihTB2McXhY6F5zHLnedQPKDcSLkB+l1F7quWhR3d6wHc0+1
	Kf4CmNe9XrV4x/KENSAWLq2Kgx35s7BUYUZ2wUfz6N6d2dX2xCAWT36uyxERDvz4FVCekDu0kLM
	q6lMHXB1aJOYCX4dUOLKuAvm5cXlnjPc98EqebrLOhe3tU65+e+2ku6QU6gWsKOE/B
X-Received: by 2002:a05:620a:4010:b0:93e:5534:e63 with SMTP id af79cd13be357-93e8f350b11mr215293785a.13.1791291976618;
        Tue, 06 Oct 2026 06:06:16 -0700 (PDT)
Received: from houminxi ([61.170.182.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca263708sm1102596585a.31.2026.10.06.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:06:15 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/2] netlink: specs: add ovs_flow del and set operations
Date: Tue,  6 Oct 2026 09:05:32 -0400
Message-ID: <20261006130533.1620706-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006130533.1620706-1-houminxi@gmail.com>
References: <20261006130533.1620706-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovs_flow spec only described get and new, so a YNL client could
not delete or modify a flow. The kernel has had both commands since
the family was added: del flushes the data path when neither a key nor
a ufid is given, and set looks a flow up by key or ufid.

Name the attributes each command reads. del and set need CAP_NET_ADMIN.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..87984bf1fac4 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -988,6 +988,7 @@ operations:
       doc: Create OVS flow configuration in a data path
       value: 1
       attribute-set: flow-attrs
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -995,6 +996,36 @@ operations:
             - ufid
             - mask
             - actions
+    -
+      name: del
+      doc: Delete one flow, or every flow in the data path
+      value: 2
+      attribute-set: flow-attrs
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - key
+            - ufid
+            - ufid-flags
+    -
+      name: set
+      doc: |
+        Modify an existing flow. The kernel rejects the request with
+        -EINVAL when it carries neither a key nor a ufid.
+      value: 4
+      attribute-set: flow-attrs
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - key
+            - ufid
+            - mask
+            - actions
+            - ufid-flags
+            - clear
+            - probe
 
 mcast-groups:
   list:
-- 
2.55.0

