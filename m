Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792924465;
	b=DkRHUGTmEe9Ex8YMPYaLg2M9+u9Oc8lt30aMlMnig4cvfii1bJtinEPXbZA7NLffopxM
	 xs8+Nv9VC/JHhpBZRLZeOcOKZuEtDbAypQMVkGzsv2S6+J6/36qqMtHU/SmeQvTTmkp6z
	 R1cK/sO3MY1YbwE6w1lwb5i86PD8Kbp3wDE8vEYyFWKs3mXaMNA0HYpgarEaZ8yqA4iBX
	 9Molj5NRXoCkw9ZjDXYFztWowkOk7aFrVGT86+/4TVNceN/+ojO/D6yqky+YTHu1WHATO
	 gUReHQ440u8f7pBtYnHkogjC3wVFFpd8J56c2pvstZRznmakoZ2g2qjFOlZ5c/0vjig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792924465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3U631olD5XGjdTK9Qq5LKDRpKK91k9qur+dWmWscRtU=;
	b=kvp/v3hkRXhCGLVonluKIdEODIMCqdph7LlkuuQgyyJ1vW1KAaNZjpCYhDIcHAa7a0qh
	 DSLzbEd7aZtMQQHwbRIgF5gAMqu08ZKxPyTpQTKtDzxH4QQFsrtCKqeEie+MkLlj2UGE3
	 0osipWv+g0eNaL4z5hKet+WJ5B9TWrj/P/9UTzDiyl/b46gK3h62WJBCM1CghNIbPoqtH
	 lOoBl4t4qsW4Y5koi6xG282pIOgwpXsYIZDzAeW0pt3Xq0GIJKkIGdDDrV3I2griHQbBD
	 gBvqMKRAYk0fQ4Idi2riT5hTP4XiuxwFcHKc48AzrAiLkWN5Mp27mUk03TEShAw+GWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BOBHeAZs;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182D1606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182D1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BOBHeAZs
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f036b17easo5412534eec.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792924464; x=1793529264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3U631olD5XGjdTK9Qq5LKDRpKK91k9qur+dWmWscRtU=;
        b=BOBHeAZsGadPDojaVWGwpuL3V2EJaYV4LDRPf7jwnsAk93wjkeWNflvjPXL02wijTR
         /2CmGmAMUWvAiuv0H5N4jEi75XfUvWZNiUJFqRi17MBeZIaw53lq8IU/6dAGVVoHhJJp
         862z6h8T20MUxDNrc5MyXURYrLXsd64gQiFKeO2L6zWBfCdTNgnJ5cDrDAEC16HjDeyB
         7Din3m5QxqVKM1poLk/OZ/zqU/GGxU1B7fv1+fRBei+Bogs9HjRxLd7uyIsDdY6fLIk7
         FpI9oteQ/XuAiiEz4K6Cs4eb1bz91K/0a9DAhxNi1Yg+5l7DrnEWb3wsD9hfJkry+fH6
         jNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792924464; x=1793529264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3U631olD5XGjdTK9Qq5LKDRpKK91k9qur+dWmWscRtU=;
        b=rMEWoXYgZPQHWmmZg5C0J/4vSMY+22y2aaXzPMumfZRQsbOfXrtc23j9pMqjlGtAgF
         lV0qy1VOA0dJK3PZ5WJTuStstKbjZ022z9LMCOFLfYgHv0rsRA7xn36Zv5y1cYpFZbO+
         V3rIPnOGFYhbv/HwbO/mavUrlx3ht7G/HJPJmgBhU1SUh6ah+5A04mkRaSg2G9H4Cc/C
         7QwfD7OGjp34/PMdhVc7OlszZY2Sp0TvVmb+eKjRj5Q+1KB03wfmgKUFiR4cZVeUNpQt
         uU65Kr2WiZQcKRsquEpEHhh/XevHYEXUGP/UC4Rs1XkAAKzBNkiSvSQkkIBr8zQtgBcH
         TJcQ==
X-Gm-Message-State: AFq9FYI44HrwV0gDIDvSgypL5aB4PFDvNP62XwYjgj25iiMR+kFbeApZ
	ALl0c6ylZse+rMUwtS87iEns1vY3W/ZdeaaXDxP2d/POXdKsimilX+1aFsKDJzhsUDh1qg==
X-Gm-Gg: AYBFou1Sf0oN3nA9+ZmZLetrGbFk304SEEVvfVcx8MK9EK3VEm+k6iEZxWOlrIfyAiy
	sxFRD56T39s1Hy3Q0fOAcYVaGjeFsoXkmvJEV1BlH2yR+PT6DD0UEESEr7cP/je+vwAy9M3VNpw
	4Icmn7nRt01tWJEGfuGESGX6OeTh9/D8Lhw8aM2JRhbhZ2BleOSAcfOeMW5o3vlY2Bh5TDgczJN
	LqrBTtj/Fp7XbsXYF68ax27khK1W2xnkMkhoA+rshI/npH5JE4RcoihuKkCkkT1FwCYFn1IyWQL
	XQ0n501A48sTVy3+FN6pqUDfiYK+cgbhWGpFKI9gUzUuKWOnXV9awXXAqD/rZtZQbkniJauO5Xi
	iaAPpHg3bxoqGPeRgU/0Os/To7YZ6GuWEsnbE/XA3fZBcwtunbUG3X2GKwPFzWqY7/OZX90GLSZ
	XFRQiHuqvtgFU7hPohI36mCyTtuEOyvKYppy06hWX0IdOTcBrswdFHZzMggQKRaBTstRnIN4V7e
	ZuhjLAPKqHYPZXLREtb7l/6FHlYkYYMnwRqmPS4qN1e4G6IAw==
X-Received: by 2002:a05:693c:894b:20b0:369:fe4c:b48f with SMTP id 5a478bee46e88-369fe4cbd94mr388039eec.0.1792924463993;
        Sun, 25 Oct 2026 03:34:23 -0700 (PDT)
Received: from houminxi ([61.170.150.30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71easm12597256eec.5.2026.10.25.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 03:34:23 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 1/2] netlink: specs: add ovs_flow del and set operations
Date: Sun, 25 Oct 2026 06:34:08 -0400
Message-ID: <20261025103409.3519874-2-houminxi@gmail.com>
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

The key attribute doc in this spec said a key is required for every
request except a dump. The kernel accepts a ufid with no key for get,
set and del. A new request needs a key, including one that finds an
existing flow and replaces its actions, and a set that replaces the
actions needs a key too. The doc in this spec says so now. The same
sentence in the uapi header is unchanged.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 46 ++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..dd403cca4006 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -384,7 +384,11 @@ attribute-sets:
         nested-attributes: key-attrs
         doc: |
           Nested attributes specifying the flow key. Always present in
-          notifications. Required for all requests (except dumps).
+          notifications. A get, set or del may carry a ufid instead of a
+          key. A new request needs a key, including one that finds an
+          existing flow and replaces its actions. A set that replaces the
+          actions needs a key too. A dump reads neither the key nor the
+          ufid. A del that carries neither flushes the data path.
       -
         name: actions
         type: nest
@@ -438,7 +442,7 @@ attribute-sets:
           are exact match bits.
       -
         name: probe
-        type: binary
+        type: flag
         doc: |
           Flow operation is a feature probe, error logging should be suppressed.
       -
@@ -975,6 +979,7 @@ operations:
             - key
             - ufid
             - ufid-flags
+            - probe
         reply:
           attributes:
             - key
@@ -988,6 +993,7 @@ operations:
       doc: Create OVS flow configuration in a data path
       value: 1
       attribute-set: flow-attrs
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -995,6 +1001,42 @@ operations:
             - ufid
             - mask
             - actions
+            - ufid-flags
+            - probe
+    -
+      name: del
+      doc: |
+        Delete one flow, or every flow in the data path. A request with
+        neither a key nor a ufid flushes the data path.
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

