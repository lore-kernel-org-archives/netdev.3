Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D4480967
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326916; cv=none; b=A7VKifHVy5yZpIUVLfvRGgo0kzn/cbQd2r6yPGGwplFasTmlaLBJXqAAeUpzkBt66946ECNqOz8eADNo7SHydHi+7tAlnPzmUenl9OyCHvk9f12U3yKKN+2Eo3rvdx2bnzOSdubBQyHa0EJJDygp544OThuCQItnjy5UQq2Ld9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326916; c=relaxed/simple;
	bh=VHfJas5G1hm4G/6uJzExDbk4H5ni2AcFyXoOU/WQt3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruF2KG5TodnYuPNnVb66MeWDtJm0PSdSbUX6upM0bx3FUpBTcveRBU2X6zOBOO7JU+BY9usxNvkUA8JRuYQjE/NgTMIW5ZQWv7VfXfq1dcqR1Nr0fpSI9/ThJJAcny9GgIUk3u3xORRLT+mEcIkxCZ2FopqOPjpDR1fq9KiSQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoOwwoe4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoOwwoe4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848593533cbso458444b3a.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326914; x=1785931714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VN6bNMzINjCRTy6YbkAhGaruRxjHLy2GlBKqmDsGGQA=;
        b=aoOwwoe4W1bnQUYFnnwps8YufP3g6M1h5W0+7ydDO8c49BWCRELsRf2/FCs/X/qmHs
         MfhVo7Wm//IWBYKYIAp4ZPKlaDj7DotjsuyqYizfoLm6nCdoR6/q5+VYjlvpCsU6pkAW
         1kby7Lj4P+CNk0173/D4umZfUu8d9tIN0ztF/wGRny/jsuYfzDZh4aYWOeiuQtGcyRkX
         CQvdgCkMXCSVPucKTqUihQvnxhN6x/3P4f8vU26Iz6oFv55wFgue+FPkAThRGUYAFuhW
         0reTczzupwygAb1UJb4X20sk+uIbnCVVc2MDnnGIIfwInNonbmnc26R0avN79iwASxhO
         EPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326914; x=1785931714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VN6bNMzINjCRTy6YbkAhGaruRxjHLy2GlBKqmDsGGQA=;
        b=F56gCN67woN/g+CN1jSZznVoEGhbcCHx2409GAP8eEuGXEADZDlQxnQrBnNnzwDByN
         bpxjrQOnENKLoMJqqBLW6Ha3ty8x065qykuQ9+jLM13MIIdgeGRJTewf8SWclYoJwdtU
         8kurv0VPjwlTvwX5pBGKQclDczVmmCC6rv96UH/ALeYFHQoHYh1TlQ+HF3dPiGx3Qqfn
         Ej9NjfX+ehVOWcyJW+t0bJmH7jShv5s4w3q6DLz0+cXvPl1ONzsxwDC300SYicBlVeAf
         pWto5mh4IgtAuNQtWOkzyx9Ut9r0PvPqUWlN8XRdxcQ3qxCdd6Y6V9YgHBC8EtIfWCYL
         cZCg==
X-Forwarded-Encrypted: i=1; AHgh+RpaYTpwOMKvoagP90bsZpfLEee4zxN0IaKhEpkBEN0LESv8JANtBIYuwa3XkWNFLHUMV12yHc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWnDSnWRdfpXEZeuQVF4OR/AqQmZtprobevb3Fu7iRyyNbYrC
	DqQ1FmGsO4rrStFDvYt1xKulCK777l7WJ1hywoiboUdrhLglkRvJ4QZ5
X-Gm-Gg: AR+sD120JAZVr5wKWWZgBmopBeMi+ok7kPuHKrgpy8CoTHJDMge0CUD5E+33bqtJMv6
	ODCunW8/kk0+o0wNPT8ElnKz6pZ0dYpApCu/NRzq6lySRIUQusE6d9NBoNPsgRcFi0cfn+oBcB/
	LWrBeNdYOQgDKzHNIFe5WYvDjj9tWhiipEQ3Bp6AV+e1tqHSNFQ0aaqo8oA5LI/P8z/HuRNVjoK
	p/Kc3w2IHOpmA2L9ro6ghs/AVSm/KqPAfH8SVvq/k4srVyx/dhJFSHg1Xv9/PVFdl0MrEk0W6We
	FFNEdq/vZBj1gpIi6WVxANKkSzaWECPsam7QbHu0V5KMREx7V7mRVQxhSI3K/h98OplL7lBd188
	0LMWQchs+Cd0tIkYet0bWMg2cT73kSi+3P5Wb33DPnkp4QUTJEl3zjMBLirKUEQXZFeL5Sg93Jg
	bbm+0pFKUlS3uBzlI7c80XG++65kFC5B8chktUjlb5EysWr/4Vc5X9BWZjoAtS8YzcHS9SdM61q
	cwsrDd1m8rOIOOlGCnVPg06E/lmjGwJeGBHqdCtqFSiYp7K5A==
X-Received: by 2002:a05:6a00:1795:b0:847:8e98:9a4b with SMTP id d2e1a72fcca58-84e9325bb83mr6935459b3a.34.1785326914268;
        Wed, 29 Jul 2026 05:08:34 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c705:d3b3:a6d9:8512])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm1263482b3a.35.2026.07.29.05.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:08:33 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 09/10] netlink: specs: rt-route: add the route deletion reason
Date: Wed, 29 Jul 2026 21:07:38 +0900
Message-ID: <20260729120739.47880-10-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729120739.47880-1-sigefriedhyy@gmail.com>
References: <20260729120739.47880-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the del-reason attribute and its enum to the route attribute set,
and to the getroute reply, which the route notifications reuse.

The attribute is absent from the newroute and delroute request lists.
RTA_DEL_REASON is above strict_start_type in rtm_ipv6_policy, so
encoding it in a request is rejected with -EINVAL.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-route.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 9f4a1a253676..e37a1301ef1d 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -78,6 +78,15 @@ definitions:
       -
         name: rta-used
         type: u32
+  -
+    name: del-reason
+    type: enum
+    name-prefix: rta-del-reason-
+    enum-name: rta-del-reason
+    entries:
+      - unspec
+      - expired
+      - ra-withdrawn
 
 attribute-sets:
   -
@@ -185,6 +194,10 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         display-hint: hex
+      -
+        name: del-reason
+        type: u32
+        enum: del-reason
   -
     name: metrics
     name-prefix: rtax-
@@ -299,6 +312,7 @@ operations:
             - dport
             - nh-id
             - flowlabel
+            - del-reason
       dump:
         request:
           value: 26
@@ -313,6 +327,9 @@ operations:
       do:
         request:
           value: 24
+          # del-reason is notification-only. It is above
+          # strict_start_type in rtm_ipv6_policy, so the kernel rejects
+          # it in requests.
           attributes: &route-req-attrs
             - dst
             - src
-- 
2.43.0

