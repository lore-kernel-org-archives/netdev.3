Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74D3E63AC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291984; cv=none; b=lTLOhFS5OGoghMBo2WXKcRwPo4rriSEU+i+/lLUflRfwou8iK8nqzM55tyWkVZCqzDLDnZnBxmmCYJyS17uCnOT3FzA9ByV0mT01luG4p+9h5lHdia0kqjS0yLjimt++solo+99Gidf3dN/k3agSeZp69Evfus/AMYTyUCZzGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291984; c=relaxed/simple;
	bh=BhQ1su3GLOvkp9tx55OqQniqMhtS9s4uUiSJ6x8BiH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAYISC/A8LpGY6uYObstjjgLXVj7fKJNBwpojqrjMK4lz8+a5/FVTmnOkMw1Ucjf9K/2ERyLAvGwJb8aA353rZJpk/zhXsYKfePLwH19KEel3OX5+XxQaZhcPp4OedjLoH3yp4LTTCTI5xAf4p6P2Zk3vyY46HGxmrYHquzSaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dV+HRCUk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV+HRCUk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e6eb77f0bso184988985a.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291982; x=1791896782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arfHehwnVNWEiP/K3p3WQQQWME7GeLnPd5u890FVddA=;
        b=dV+HRCUktFnV/QlgXQ4WYdTr9dfvWfzoO8CZdR2AUQzrdA4V88E09j+yjfyQXXMnkz
         KD6mwGLvbjU2e4vGFOHLaUTK8BKiXkWOmSyT/vtGOJllagQiyBXSlLGxkFeryvSRNR27
         zdd/Lm5f2m53jjSlhLY+TRabGk4raPfOWL2yNzJc8ti65yW8zWdX0UZFhWM2CsuPnmW1
         wWCrh8od5RgVcIQiArxQ6RJni4oG9Izq1275kHv8lgtZRdNICQHGwUTZRS7B17/KZzk/
         lTDQU0PdnogDMUQfGDZj2HbM4rF1xEpVWZOPWCgGpzX/ePvAYaGxCvsUT6Axhz/glQwo
         X3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291982; x=1791896782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=arfHehwnVNWEiP/K3p3WQQQWME7GeLnPd5u890FVddA=;
        b=K5AvzU1brvuJta92PUj0Juzjxi1ZfgZ48ScedENeuREVTTlXvSWFYWdswb3blk00sh
         LXJoEY/rzW7qPKChWVcn1505e7xnKf8uWiJhmUknSqjDqbfWzGgnoPcuV1ubkyGrBIaI
         5QDjgRKNW+DyQGFpsjNDUzdqd+LUQd5xUPrYQY4ylve0USWII16um75oz1nsQW/saPwk
         A+VKpklEs6usB0TiFAnksQT9D3uqKdi+FwOajm2hu5Y8rQEbf5cyFQ/+5upr0xaYVZs8
         cC95zBYRktXvMNT9mTXueGaduw02EkTCq63nSMP38TyEIPmCOYeuMkUAmL+ZAdhxUiNY
         GbCw==
X-Gm-Message-State: AFuF++k2GKJmBYxuymY4L8IDq0n1RcaFkNUSP1lP3yhgRY0QI6Po9VLa
	WW/IPFeZelrsoYYcFbr19UMz+8LIE/ykWK5A7IWWeAbL260cnfFuwMiZJOHiGBain34eaw==
X-Gm-Gg: AYBFou0osVI49t2/2D0oAeYUcQhAPKayUTpRR/GwnxYX4dbSxUPdi1F/EG8z5jGrVHu
	XtCwgivI1OW4r86bKYpCs/FaijKplFxI1FoGcwr6JAQuY9mCVoy3D4HF77lJt1z9czh/BAaA5b6
	rlPqZMzt32JKLCFKhaCi8eL+A8v7xbZ8/HFe4sFl9WVMbR4mnFfMqUO5jS905g/RlgBtCJbUVia
	yIHxH9qlaAAzCF9klE7EFwv1qAVM2rCMJIzJ2vAvcWTpi8jCVAQDHokpmYKloQU50fLaUntTSWc
	8q6EonrCNZycx5jk2iqnM2y8CwdyAX9s8J5h+9PBIOmPlSX8YQa89G3AN+4im3080ybu3npNuBI
	WvceoUZMnVKBLwo8xgvh4JfbOTzygwmhnMys4bw67x1tgsLYzChzUbl6bg27T8iY/+zEumtUWbj
	trJEH1ywoDXSfrGSXTRxU9134m4uIyVEsfWZ22pOjVTjjjZkaj2V0a/OqqBwMnWr6p
X-Received: by 2002:a05:620a:172b:b0:939:6c9a:8f8d with SMTP id af79cd13be357-93e50fea739mr1980986485a.28.1791291981862;
        Tue, 06 Oct 2026 06:06:21 -0700 (PDT)
Received: from houminxi ([61.170.182.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca263708sm1102596585a.31.2026.10.06.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:06:20 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Tue,  6 Oct 2026 09:05:33 -0400
Message-ID: <20261006130533.1620706-3-houminxi@gmail.com>
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

Both families register a SET command that the spec never described, so
a YNL client could not modify an existing datapath or vport. The kernel
handlers take CAP_NET_ADMIN through GENL_UNS_ADMIN_PERM.

Datapath set changes user features, the masks cache size and the
per-cpu upcall pids. Vport set changes the upcall pid; the kernel
rejects a type change and rejects options.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 18 ++++++++++++++++++
 Documentation/netlink/specs/ovs_vport.yaml    | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f7b3671991e6..9c33d6a2f05d 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -138,6 +138,7 @@ operations:
       doc: Create new OVS data path
       value: 1
       attribute-set: datapath
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -149,10 +150,27 @@ operations:
       doc: Delete existing OVS data path
       value: 2
       attribute-set: datapath
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
+    -
+      name: set
+      doc: |
+        Modify an existing OVS data path. The kernel treats a missing
+        user-features attribute as zero and clears the previously set
+        features.
+      value: 4
+      attribute-set: datapath
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+            - user-features
+            - masks-cache-size
+            - per-cpu-pids
 
 mcast-groups:
   list:
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index fa975f8821b6..63a0a41a1199 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -128,6 +128,7 @@ operations:
       name: new
       doc: Create a new OVS vport
       attribute-set: vport
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -140,6 +141,7 @@ operations:
       name: del
       doc: Delete existing OVS vport from a data path
       attribute-set: vport
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -165,6 +167,19 @@ operations:
             - netnsid
             - upcall-stats
       dump: *vport-get-op
+    -
+      name: set
+      doc: Modify an existing OVS vport
+      value: 4
+      attribute-set: vport
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+            - type
+            - options
+            - upcall-pid
 
 mcast-groups:
   list:
-- 
2.55.0

