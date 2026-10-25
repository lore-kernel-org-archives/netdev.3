Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792924468;
	b=E36RiaXrIv2fpddFR5Knn4402E+bLsXf2ahu6/mJWUIOaO/keQAiMu6IE3N8BlEikSbo
	 rHD7jG/wgVwL96LuAu3WErXTEQFQUNgMJhBTYsJ+96iGHygBNwLAb3YKwW+vbUiVGWqZW
	 C/+Aje+GGhwLn0TSD42ylqdnVPbsnpdoc/2yCYa2CzBl/S6PCkgezsRncn/dSGVfAvYtQ
	 RwzjR4jrCK/PPRhDi9vPHI6QX0qHZsv5oNyuXvzksdWRMqLLdPFbOMo26xOoN6/wpACJR
	 QM9IyVQgpCda4ZMj88IbPFQh8pHmxI3Tc0Q9xhMbFfUXHwZh85FsENy1oNo/RWMj+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792924468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YRfYLJJYd1L0c12a9Vplu1prrhSRzB61T2SM2N76MS0=;
	b=jrA7ftjz5NYjsRC98+lMItZ2n5SJ+UwflBUFDVFOD6I6i7Kw0PnwuDHoIoyV780r9Q4M
	 HRG3yZC9k8guE1rhPXOlY59SukVyaWLrUKVNK+KePv0tkiHpi8FgNz3aulWhc50uyoaoe
	 pFxu8GcMFnpA51ZLK0ktLkn2XsamQtsEAjX1PoAOoMLbGdg7zKaiYl+ZcHLXKci1odUt1
	 h302C73pKxGkzs/YJAA3GK4wmU9wf/aoQib0S2xjdSgNoPiCE3gFMydU/psb9Zj7SOaZJ
	 XUDjevPUqvgvAQ7RBjFc50AKi59grXOPUAzmBk0NIqauhucFXvJCqdnlKlPb26Vu0Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VB3atq6D;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DD606A31E
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8DD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VB3atq6D
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so5100218eec.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792924467; x=1793529267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRfYLJJYd1L0c12a9Vplu1prrhSRzB61T2SM2N76MS0=;
        b=VB3atq6DfavtIUlgWgp/ACfxg/bdmFKvcckbOdSXA8SzRhnLrmotmZ11liKAQJt2Vn
         b+zKv9uD02G6epR9roDvQ2FpoEtJC1kx12LFsbDvykQdHfh6niSWwrafDVUjUmc8Ky9S
         VrdU9ZYTbmeNLHkxopjSCExOaSEnhpkL9Xx4pwJwHGSZA4DxF7E3UqGZyRCiJeiD85RH
         OixsDaGcHk42N1aWvda2Qh6V2Xgws7g/hIkIKC1AHObVI5NNHKmUbJ6INIuR5cpgiq8k
         TFIWZucxT+qhsE/09UNvzLtYSVArP+vGcreaYlP0IpJbicxdtWGuuF/wcXvO3aw+3Tvw
         H5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792924467; x=1793529267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRfYLJJYd1L0c12a9Vplu1prrhSRzB61T2SM2N76MS0=;
        b=h722K5Uu6363ukR4L2HiSzyoTxuM+VlLCKxGmc41dsmuFlVmf1hLA6+7ZAFsRSqVkS
         pWA+H5Fffhq10FVN34QJS+IzWqN4VzmPstPFLzdHPOGfR85Hnv7GHoRdK0lc0On2yAJm
         BAEqMTKfc8EiZKn5bmXoJkvPTyWQBaFFDUaBG3ATN+DPwMOprynpJGxckNeB52JIiftu
         Z9vmTCcIS54NspE2KUtK09DyFPbwkiyQg28pphRK071YkHuqBoTJCYVwQyzoabbXLTs5
         bENlvfREKXMxTWdcwRJg59AZnbJIJ57Lq+fHTXJIh41zfmpF5oJ9bNp6qcH1QAauhKmk
         mKbQ==
X-Gm-Message-State: AFq9FYIBw/Z7Ji4wpRWGOpPVp1kYlh0v/j8HnVHhlSmPZPMJJZlNuLS/
	JV0Vo7p8esrV3gMxPNZjwv4jMO0buhxIXsg66SJjbLugu2wwvyR2mCCqfzQHmemkEpdmdA==
X-Gm-Gg: AYBFou2RIneXVcs+Fyi9b0pddY9JVq7fwiwd/nI1BB0Uzz8yXmp67oYRUlYZnKvWiNp
	wYHoU3GJ8mxtyZu/ex7ErwYO5yXr84rtXm6XQSMfVY0iIEj9+hUTXPBACqcK8b6CfzqyYpnOazh
	KarsZI03NJbzmyvk1lQREnAFrm2E68BOGtcLqzo0cKzPtzfTVTLiUreE4bB9QXCOZHixTHc5OD3
	pU+OU5TBvBRVDDtcFik+dNGJ1v8uOJ/7NPT4j69BtOxP8foAv0R6At5XXbeFtTD0ZNjyhfzydco
	0lrv+Akl8qQ/iuxTpE9DEfBDNSg3lEIGU11DuHg84kkR76RIo4goq7PSELJm4IFbNhM7V0Vm8fj
	/2cprd0AH+iYiPFIB0T9CIbqmPkqtgw6+sXZWYrMy9QRrZdl5UH1EaEpVCh1eoYPaehDBa1Qqhz
	YQiYGovJRX90asYY26VFJi7I+WkZbBcrmYdRT9lmaRyw/Jhw/xu2UVU3glMU54NKCEjaOYVeFmD
	+IZrNPY0+uvkNPi5tik1mAVgKoFhUZHKVvDxYXvs50+sulDjA==
X-Received: by 2002:a05:693c:8352:b0:35a:5153:ab24 with SMTP id 5a478bee46e88-369e845b07emr4505740eec.9.1792924466662;
        Sun, 25 Oct 2026 03:34:26 -0700 (PDT)
Received: from houminxi ([61.170.150.30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71easm12597256eec.5.2026.10.25.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 03:34:25 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Sun, 25 Oct 2026 06:34:09 -0400
Message-ID: <20261025103409.3519874-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025103409.3519874-1-houminxi@gmail.com>
References: <20261025103409.3519874-1-houminxi@gmail.com>
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

Both families register a SET command that the spec never described, so
a YNL client could not modify an existing datapath or vport. The kernel
handlers take CAP_NET_ADMIN through GENL_UNS_ADMIN_PERM.

In the kernel, the datapath SET command changes the user features, the
masks cache size and the per-cpu upcall pids. The vport SET command
changes the upcall pid. The kernel rejects an ifindex before it looks
at the type or the options, rejects a type change, and rejects options.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 21 +++++++++++++++++++
 Documentation/netlink/specs/ovs_vport.yaml    | 21 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f7b3671991e6..83f6b060ed75 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -138,21 +138,42 @@ operations:
       doc: Create new OVS data path
       value: 1
       attribute-set: datapath
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
             - upcall-pid
             - user-features
+            - masks-cache-size
+            - per-cpu-pids
+            - ifindex
     -
       name: del
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
index fa975f8821b6..189cb5b99aee 100644
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
@@ -165,6 +167,25 @@ operations:
             - netnsid
             - upcall-stats
       dump: *vport-get-op
+    -
+      name: set
+      doc: |
+        Modify an existing OVS vport. The kernel rejects an ifindex with
+        -EOPNOTSUPP, before it looks at the type or the options. It rejects
+        options with -EOPNOTSUPP, and rejects a type that differs from the
+        vport's type with -EINVAL.
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
+            - port-no
+            - ifindex
 
 mcast-groups:
   list:
-- 
2.56.0

