Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE50436377
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788167; cv=none; b=UHrvHyeKEa6sBvjfjVJLg5zxMl+pOU13qCyRueQtTjUVtymYJnzv+kEQHOeg5PR1Xalogic9Eri5T0G+fcE4GyOqFgeJ42sv61Q0OTT/slH+Ot3JV0aTF6iW5XPk5jiB+KKeuD2VEnieovNBrgouAKBflc3gu8fxgizwsIsayxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788167; c=relaxed/simple;
	bh=wq9LjaHC25uzueKjo38CDdE50fQDIv7YR9Rh+AIzOQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhylWALoDfkTdUYJiv/FXA4dgeUdJsTf0iOQR+cATsijqGnuBVx0WwPs2J3y4LtHVPDPBHFS0l1nO1v/a1qe7mpwGhX2fPhXDImjRZ+GgrJREuYvLXAYxyZVA/kJhq/0Kq3+9E3hDk5xwKuhMmMnIJEIxVBvt7YtMscI102QPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ompA+xjp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ompA+xjp"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-888cbacf70eso17152197b3.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791788165; x=1792392965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1J9nUlqHHAtSfKkf6fyMdm5ZLjWs1fX2p5xM45lxjX4=;
        b=ompA+xjpeuYf4ykepd38IplkrKgi8BStpUd5MIJqWH/1kRHkaIp89UHFL13z+NWYhn
         IMxTL37wcPFZoiSNphHazzyPii1UQ8odQJqTJuOqKDnrIrtUSCfPU46bpb8gUq/QD51S
         NR9eea5kaEIsEQUWq/VUo4+OpTBpKoQDckk1WgGBgpXxtTvSPDEXbed/WzbJGrI0gHBy
         yFk7FX+/nt8N+Hpl2x121TSVX/KobJWc7yt8H0hFfaKqmPUp+DRa3Q1XRszPyNmjm7B3
         rf0TUcWDJ45G/gcPxH+CKjIUEnHmHgXKH+nbc9tfFFbK77QOqbKGSuFxe+KwGFHqiBOL
         LWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791788165; x=1792392965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1J9nUlqHHAtSfKkf6fyMdm5ZLjWs1fX2p5xM45lxjX4=;
        b=JdzcsaFZGIxvQor2IK0mCtDHzVqRto08Wb/PJ+NwqlC5iDAvdaZdI0NU3yCw7HnoV/
         KOdhmJX/IfVm61fjmQETliLDv1WbqRM0hml4AjSyOPlvoS3NRrIL+1ymB9jwRcCxc2vw
         /V1aHI0IT549/XX9bInx+jRyQgRS2+iP+RoX3zn0AVy/1m3+khVWZq+/8UqVm7a8vZqK
         Ln1fsMd/5d/jw+rrLbcOBevTm+LBRhR4gpy5AYWfbcjsxCrS7JamzsAF9ttCA85FlcTv
         q8mvput5g8exmxsmUh59ObM9GbxS9SVzpwbkXGzInOXDmLb8RoI+sOEF+g+btCRnXjgi
         w+aQ==
X-Gm-Message-State: AFq9FYKgOGRUI+JJsvxxo1AVkwOVDr2GOW1H4UvIxYWiK+LYHc0bRTUw
	GCxJTHLZsNRmwzvhyKx5UKodJ3jSm0ZZgGL7Ldv39IxZc2dg6gNfvHZBr3hMm0VpCpOjmw==
X-Gm-Gg: AYBFou2fvFFneSBq0euvuLq5h/SNarMSXIRy9f6Yq2nz8fvUSpydjuS3YNOyfFe0ujl
	QcnbGnbktTtqNk2s4vaoweK9Q6aPwCBpppKvc6FpbDLhSnsEA6jr47TXOVlQkKKiOzIWZJr8rNx
	ze4304Ca4PoAMnYcyTkNwgxN8rTP9I/c4Vd8N2PKXFxDS3UK46DQ9DlKOxEaVnGwtKvpqqW5J0x
	nnHWAXGDgEhxoe75Yy/QPfqEjTBRh9oC/Ph6hbR39rvEjWpVI/Pn1boQ5L1haRgkhR5gm8qsUZK
	dBb15RhuSwgFoNYruBXN67HbvoweQ9h4CrWd8BfgJnO97Q1T2rQuj4qM0cLsdE6M226Q1BBdDwW
	aWpvFYlZXPK1ZB0XOA9BPEPPShhCBlSmvYjanrsG8JRLSLyRXzpmBdzvQ1izyL8QqmBmNhGmHgf
	w2iGzwoGkfuYq+JSJGctljeiUdQjDPNX2bxxJWafCzTIdAixzsq+a8Lz16T6/NUfQg
X-Received: by 2002:a05:690c:83:b0:871:bc3:9856 with SMTP id 00721157ae682-8b07ede5a10mr23868627b3.33.1791788165190;
        Sun, 11 Oct 2026 23:56:05 -0700 (PDT)
Received: from houminxi ([61.170.159.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f25ae62sm32256867b3.43.2026.10.11.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:56:04 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v2 1/2] netlink: specs: add ovs_flow del and set operations
Date: Mon, 12 Oct 2026 02:55:51 -0400
Message-ID: <20261012065552.2426415-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012065552.2426415-1-houminxi@gmail.com>
References: <20261012065552.2426415-1-houminxi@gmail.com>
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
 Documentation/netlink/specs/ovs_flow.yaml | 35 ++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..b1c884b4115d 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -438,7 +438,7 @@ attribute-sets:
           are exact match bits.
       -
         name: probe
-        type: binary
+        type: flag
         doc: |
           Flow operation is a feature probe, error logging should be suppressed.
       -
@@ -988,6 +988,36 @@ operations:
       doc: Create OVS flow configuration in a data path
       value: 1
       attribute-set: flow-attrs
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - key
+            - ufid
+            - mask
+            - actions
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
+            - probe
+    -
+      name: set
+      doc: |
+        Modify an existing flow. The kernel rejects the request with
+        -EINVAL when it carries neither a key nor a ufid. Replacing the
+        actions also needs a key: a ufid on its own is not enough.
+      value: 4
+      attribute-set: flow-attrs
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -995,6 +1025,9 @@ operations:
             - ufid
             - mask
             - actions
+            - ufid-flags
+            - clear
+            - probe
 
 mcast-groups:
   list:
-- 
2.55.0

