Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7312931D2
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032109; cv=none; b=Mtwt/FiF9UlXH9jMwXvT5w5FhwJPoiNWTM+aoFfPkxGYq/UPrzlURGcrvPWPepHiQGCEbLucbxcz4Gdv38CRsoUxvwqrhzSDxVr7iuHb2HaTWx7dLV7pEbXgJ2QH/PvHi0TqFSKrf+SCmz7829xbf4NhBgcqw9Hbm0NmP04lJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032109; c=relaxed/simple;
	bh=dO1gS+V7rjOGZbV9WceWrnW9g91bTAjayMKq5Kgj3W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvlRf9ujdcAtRlxmXjQtJ+zHdF8i6/Jg4OUhSGFhSIg9fc5WIcdpqJyR1aVm1mrY4MWt7y4wI3Rv6frkk488j7kQ+OalGLZqY+KKtin3F+2NTKz4YQHjH72Z5bQKcuOfIYHLAuBjBOx1SUBtFqw6z34vo1GbXiqfqpjung8g5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrQGnrnT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrQGnrnT"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-81ae6aefdceso1357446a34.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032106; x=1792636906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhir5mfJ+S6FKIo+ZY9zWb4jkeGKyv3et9OGrx/eCdY=;
        b=TrQGnrnTyOoa3vitEYRnTFTE+DOOwgvLgGKt6x7ujBB4gV+aqJtc/ZDTKR2YSBCnIp
         UcR05oHFN+thOqyvBdN/nU0XLmwZ7TMornmGTIfM73IKFPft0SWuvzadSjdBtwumzAdQ
         wR7VdPOTstNGpHoyNZBEN7mlJD8VwhmSRkK5Rj21YBAD3YA+XZtkJGfGFzWJJl0W3Sfb
         Mlzy3uZrgPYD3qhE0LGGr3PSPb8KxKCM3351KttUi41CvDIyIW0tAj0sng5TxBgoXM5c
         oXsLoJqpH/XW1FXxCsDsWnYA+Ifb10L6z7VSnogXT+pYBloy2b2IcRLDaNPBGJkA/QnW
         jdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032106; x=1792636906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhir5mfJ+S6FKIo+ZY9zWb4jkeGKyv3et9OGrx/eCdY=;
        b=z0vbDFTyMEVLO4H6grvDsZnsJvfQjDBbZt1cqNm3maWGvJaWHTwG7KZaAqLpO6sfB5
         tUEmcNXbtRVbnk/kIKGrmvEkX/uZtN9J32wU+rNR4X0AUXUQAIeptjALc7ZxliKtb17L
         ZuEGth7dV2HSZxIim0fqwL6ojZRif541iXzztoEWkoOqbJjBJPgC21HESnDKoFfpRwcl
         ggCKXsgTVa4yD65FMteShaZ8yblFZkPI3Av8pc+7j3yiiP20mallI6ys0ln4bhfJmtn9
         rQ/PCFqh/UMbA2XA29Ny2SyqF6s5fyu4fBoFC32STxu2D+XMhbxOiik48j1kfDhVUC65
         JCqA==
X-Gm-Message-State: AFq9FYJV2OZqEjjSHkyJ9lfWPaywqN8vEPCOfxm4Qyzi6lwU+5Ks6pNp
	5SLNWidKY9jbrAjKkPYrJMI8zt8iRhYqRrnwvrhkhXKs6y8PmtdMB/YxHHTLgvq7m0aVRw==
X-Gm-Gg: AYBFou2FeFyz2njP9W0+Cag/NNn2YQtzTMY6PqJ4ayzFiqbki08AFaGcFgeh8l9tyEq
	1bM/19MHPCUMsIWxL4mE2de05X/IrW2h9U2+n80K6+P2E6jWM4wySTmks+UlQL8rzgVfYXRlXf1
	8kg9zRIvJ9xR8iES5GEOCEJbLOf6j9j/cq9AnjT6pqENERJP6UUIWYdybAmqphzAel7SfCSHXNJ
	3kRqJ9cu6Ku6sLKoSfV0M7KEPyMQ72Wv2Y1unbcLiRS4IlqPZx1jXn7VZ2msBvCCe0+G9CzonCU
	pjxryiCuf/JUiofxIvXfY2yU0ID2j/ZOsQGZjl+wJ/fDE4hK8kGESbogYrVNdfE6ffQrIQjuclQ
	S6KIn2erb6O1wfrPzHJo/c/rKxZD4blI1iphPFe4BS7Sej+iuDp0iC8FgqZxHFZlM89wxVNioEy
	2t4csQ81ISJReXsD4SKKUqQKn1oDIy8q83wFXVXWcjcpl2k4GtvXvCpx+zDV2ojv04Eg==
X-Received: by 2002:a05:6830:380f:b0:806:9a8d:4b9b with SMTP id 46e09a7af769-830963f4b30mr16162064a34.15.1792032106556;
        Wed, 14 Oct 2026 19:41:46 -0700 (PDT)
Received: from houminxi ([61.170.152.244])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9cb0sm16720024a34.4.2026.10.14.19.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:41:45 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v3 1/2] netlink: specs: add ovs_flow del and set operations
Date: Wed, 14 Oct 2026 22:41:30 -0400
Message-ID: <20261015024132.698658-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015024132.698658-1-houminxi@gmail.com>
References: <20261015024132.698658-1-houminxi@gmail.com>
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

Name the attributes each command reads. new reads ufid-flags and probe
as well as the key, so both are in its request list. new, del and set
all need CAP_NET_ADMIN.

probe was binary in the spec while the kernel policy is NLA_FLAG. It
is a flag now, which changes how a YNL client encodes it: a false flag
is left out, where a binary attribute was sent empty.

The key attribute doc said a key is required for every request except
a dump. The kernel accepts a ufid with no key for get, set and del, and
only a new flow needs a key. A set that replaces the actions needs a
key too. The doc says both now.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 41 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..e5e110b6ccc8 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -384,7 +384,9 @@ attribute-sets:
         nested-attributes: key-attrs
         doc: |
           Nested attributes specifying the flow key. Always present in
-          notifications. Required for all requests (except dumps).
+          notifications. A request may carry a ufid instead, except for a
+          new flow, which needs a key. A set that replaces the actions
+          needs a key too.
       -
         name: actions
         type: nest
@@ -438,7 +440,7 @@ attribute-sets:
           are exact match bits.
       -
         name: probe
-        type: binary
+        type: flag
         doc: |
           Flow operation is a feature probe, error logging should be suppressed.
       -
@@ -988,6 +990,7 @@ operations:
       doc: Create OVS flow configuration in a data path
       value: 1
       attribute-set: flow-attrs
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -995,6 +998,40 @@ operations:
             - ufid
             - mask
             - actions
+            - ufid-flags
+            - probe
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
2.56.0

