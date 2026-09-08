Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8143C7DF
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911123; cv=none; b=g74yK1W2Lj19XZDvwYW8HruEe8kJbVGld0av64yYJs7XxqMHNxCVAbdo63Wepde57srkV+wvEn9oAFAZY0RKnQNTw82NMQn69IP5kvn00rrtUIU/uUj9q9jWO5Ra8JHiwrUCT9WjV6tu1VVosgVwXLa4q0gu4ZVsiV5wIaypcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911123; c=relaxed/simple;
	bh=NAqErJbYzbVMfkAK0K42VgnPFlRX5e95U/2VfdKXRNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sySz+04Jn4QvG6Qjt/5T354ahwshz9H0MAbdAiyzWGFraZRwNL1yzkTm81Dj14a1phrrvMWzFff3IUrLUW3OxOnNgJmsNtSMSqgw/S2Hw61S2/vSG7Dj7nKAbCDEq/F/RwTxbPnmhKmZP0dFlPNluAP9w/eOcaZ18OcMT07mRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLVQX34F; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLVQX34F"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e03so6617006d6.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911120; x=1789515920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6L6L3ARb9Cg3F9zGE6ufoGiq2DWwbPsHri/Jf9J8RbY=;
        b=hLVQX34F5carL36Ld+o1NkbUhtZ62fUgJIpfUV8T5q+Ve940ZfXUxxXfNUePvTMvWe
         x7Q6MT2IiJuNKTtpqOprQjmkKjRJVVq1SWGGLciOejNVVZGHuO9xjbkqSiPFifoWNann
         K/5X5hVgtxDEs8Gyhv3Wac71GplDkT7P1bOxyDawF0D8p42cTgFJc1pKQ9hvc165GyJL
         YOVx/gpYEKK95T8zvG0OZkZgBcXAyPBfWShc0fr9Q01cwu236WlrTRI4dLkeDJuvMZ2Z
         ghNitJpLuEtwswr4dDCb38Ir7onk07bt8MKoHVOKaY74CLHKAhWYHGfyveH+ty2zrNc4
         W46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911120; x=1789515920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6L6L3ARb9Cg3F9zGE6ufoGiq2DWwbPsHri/Jf9J8RbY=;
        b=rgKDmZzCkvIQi1HGxwUGNIJdM5YryAz7Vwpq/TFNzsYn/bh4UNhPU/FHYsIppZQzB4
         ozD2y5B34udafcczSwYWGa3HREFBCQEyi0994kWQRskMMcmlJO8YeELN/KvOI56VFBth
         NE6Hi/vZggrP9eMbZwIUgXOKdEoAcoFDunjIpo0bbxqomtwf6GjL//xa68/MVureOSLg
         ihTlWBk0GrlppvTgW6PIaoaPZBy3Wn0pDyfsUm9L/8R7E3pwJyE6rZ2X4WUM04ekv0bi
         eTa9FXSz8xLI7lugmOL77pO/ZTB/5dRYviAK9+/7WcYp2ZOeXTpYc9oc+Ya5wIYHSayM
         bO9g==
X-Gm-Message-State: AFuF++kU53Qi0wsSnK5RBUukdZtLZ3GEn7KAfTdyfUTERIwGxSXk6Wo0
	rQCeijnPPG4m5nkpViZaWscTRC9Wo84mypJELESMF2D0UAZ5dT1bzACj
X-Gm-Gg: AYBFou0vTrgDogjBg3U5oF1IR38swym+ta0m8AL3Y4vGF9wqJBm0D3OHKdfHSXbwaPM
	iehFznOKDSkRaJfdVZpSi57CeDfmj6PGZP7hbylEI45oe9tq8jplr3Uu3fMjI60c6f0F34F5lHC
	7fyH6X9hcQSIO72XwzK15nbxvfk78hU1NEC/ZMqwZqhAjKkF96hXOeR5BTNMcwEqFMyS+i9Edx5
	/8X7+cghom9sAJVQDN42aqiGaqKw+6VgLWEbsgM0hkwzbbP0pnWS4yQliHpOkdRv63pK67YTzNu
	iwBFoAuE4wwPPz9B+9SpH8qUkXTmi3WwoSwVtPafwP94KMCDCkH6vsj5Z57fWzVtIGTa6XT4FBd
	ff5poaMZUduWlAvJbCp6m2pMJcyihFnjtv4hHyRZZ9+4pZD2AdA9UydkYuzFnhSBostudY6vHnB
	LEz600NKXrpQJgYdmglL7dQ/Lh1zYMu0Hy34yLle5i4X/5PdvnZDJE2dlleGv2023wEUf18V9qy
	JfWhqJcoA==
X-Received: by 2002:a05:620a:90d1:20b0:939:bb9c:e43a with SMTP id af79cd13be357-939bb9ce46cmr549260885a.3.1788911119531;
        Tue, 08 Sep 2026 16:45:19 -0700 (PDT)
Received: from elster.cvl.swallow.glass ([2606:8e80:692f:3320:980c:c29f:b4b9:c06a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939aff54ae0sm551872585a.8.2026.09.08.16.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:45:19 -0700 (PDT)
From: Taylor Bates <tmbates12@gmail.com>
Date: Tue, 08 Sep 2026 19:45:07 -0400
Subject: [PATCH net-next 1/4] netlink: specs: fix duplicate if/then keys in
 netlink-raw schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ynl-robustness-v1-1-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
In-Reply-To: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Bates <tmbates12@gmail.com>
X-Mailer: b4 0.15.2

Currently netlink-raw.yaml contains two if keys and two then keys in a
single mapping that enforces a "len" for "pad" members and a "len" or
"struct" for binary members.

During validation PyYAML resolves duplicate keys last-wins, so only the
binary rule survives. Pad has not been validated since January 2024.

None of the current specs violate this rule, but this validation should
not be parser dependent and unspecified. Strict YAML validators such as
Red Hat's VS Code YAML extension and Adrien Verge's yamllint will
reject the netlink-raw.yaml schema:

Command:
  $ yamllint Documentation/netlink/netlink-raw.yaml

Output:
  185:13    error    duplication of key "if" in mapping  (key-duplicates)
  189:13    error    duplication of key "then" in mapping  (key-duplicates)

The following invalid netlink family spec will pass validation in the
current ynl tooling:

  # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
  ---
  name: minimal-raw
  doc: Minimal netlink-raw family for schema validation testing.
  protocol: netlink-raw
  protonum: 0

  definitions:
    -
      name: test-struct
      type: struct
      members:
        -
          name: reserved
          type: pad
          # len intentionally omitted

  attribute-sets: []

  operations:
    list: []

Fixes: bf08f32c8ced ("tools/net/ynl: Add support for nested structs")
Signed-off-by: Taylor Bates <tmbates12@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 4c436b59a34b..18ccfe05048a 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -176,20 +176,23 @@ properties:
               struct:
                 description: Name of the nested struct type.
                 type: string
-            if:
-              properties:
-                type:
-                  const: pad
-            then:
-              required: [ len ]
-            if:
-              properties:
-                type:
-                  const: binary
-            then:
-              oneOf:
-                - required: [ len ]
-                - required: [ struct ]
+            allOf:
+              -
+                if:
+                  properties:
+                    type:
+                      const: pad
+                then:
+                  required: [ len ]
+              -
+                if:
+                  properties:
+                    type:
+                      const: binary
+                then:
+                  oneOf:
+                    - required: [ len ]
+                    - required: [ struct ]
         # End genetlink-legacy
 
   attribute-sets:

-- 
2.55.0

