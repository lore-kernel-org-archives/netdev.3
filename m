Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F035C6B8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673550; cv=none; b=YNmX38KM80GB3rnYeZ/BiaSu7Mg4zLV6vP12RPTeXe7+NXWXbUarT/2dI8ocrZ3um54AZG5vnea3Wf4L6DTsvVN3eGalceM7I8afvpN0kzt6CychMomxyWO5X8oDzrDSpKn4DzNqaWXYlCuXO2EsxgsUGvof0rZpqKjYOprXy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673550; c=relaxed/simple;
	bh=RRut4CcXzZ33X43C9H5lQOu9ePxUARCVaLziJt3a6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doQck3hzLCxTfkdKNVL1xTns1pHRY3MmBDBWagd/S7zvKztnImc+JN9lds+MDk0yvRVt+xJydKVVQSNF6NsgL/3CakFG30GLQCBcrGGezAk6cjguPcSb1PdzOreccz7n6fndsJG13cfUvF0tyR4xqzaXh6918S9FXLIYIdeJpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15e0279316so221167666b.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787673546; x=1788278346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wr1rmaQc3zAX/KiOiWAbKtWPn8dgUIfKo9r4PXcz4Iw=;
        b=G/K/fas792lknpgjqS4go84kvFRIz4QtyQ85gWWZz7F6Z6uFgChCEO0KvpBj2G4bTK
         AbnlKtZ5z3WHW8vZMdJQbtm4Dg8Up6L6nAPOHq7Bcx7pWKuuG9q5m3CTO3/NyTCND5AG
         N0GEPzX1pvTx0ReDldWoxhfX1DTaTKKrpxFE5Ty7Ox5zIINlUFSSB1UQvx6YUD2iZPH4
         hnz24DVVfTtpa6ZtC1DaZA89cEXol3l/5Ci7fdTluh0D0dKp6i1rRMdTQ8nryswuDB5y
         SXa0k1RtwpHzv/0xBtUB9uBvKwVFekQ/C3HzZWU+UK1+MadkmbgJJ61lLeqdCQSweeFk
         wDaA==
X-Gm-Message-State: AFuF++mgba16HJVk5lXIBgAGgZlfIZuj86w639/RVKATs9hOkx+oJAmZ
	A8chhQfGKoWKLAmE7sceJqc77by2QtnvdygZny2w/IoyHeIdAC2G5ul5emG98Nqx
X-Gm-Gg: AR+sD116FNpyGzrBOLzbjOCToszEzPsi1nBH7SNwcShRpcr7Q7GdrhHyUuzc4b20GkN
	ArUV98zhW5rHrPdL3VxR96MwwfBL3ohiW4E9FRe4lVmv+OPPq/MrHSh/i+fh19GPtifqPCmnvvN
	IMOKl9L1ZsNvKaigVjRXXpJjG6gMi70Fb2eFPIbMNHrDhjxV6hsWz34gY9M63FbOfQD5YBnSJzN
	5QXmZ54FYaCBhmEg0LCbWIxQ49BuoVGcmiLceCG1ys8I55VMqB4A1RLzSrU4SMzxwLLNlGOdtsI
	T3p+pPoC07alDIdUDn5bTOKry/cWTCN1bbWJZC/b3EhteqlWJcHe0gr5x9+kWJXX9uhWUjye5rS
	o1vExJQ/jQggTtx6K9AXWBAaTmsXl53dTVQo6jV3Wfswu0gK1kn4mCCNOz7H0Y56I6l9ROU/tCD
	XnFq2eHqj37qL80Vtu28KKObYHk1fXAGLFy0uEfTgj4L1dT/cuOyBotKL6Te31ndZd6VCIF6eKW
	MSQY/4IbKOooMBrBc/L
X-Received: by 2002:a17:906:f588:b0:c24:d430:3929 with SMTP id a640c23a62f3a-c24e58cfc2amr923308066b.1.1787673545645;
        Tue, 25 Aug 2026 08:59:05 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-33-32.nat.epc.tmcz.cz. [89.24.33.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ac7fsm23088866b.30.2026.08.25.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:59:05 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net] netlink: specs: fix the conntrack filter type
Date: Tue, 25 Aug 2026 17:58:00 +0200
Message-ID: <20260825155832.3685714-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CTA_FILTER doesn't contain nested tuple attributes, instead it
contains bit masks that specify which tuple attributes to filter on.
The values for filtering are taken from the top-level CTA_TUPLE_ORIG
and CTA_TUPLE_REPLY.

The bits themselves somehow are not in the public headers, so not
defining them in the spec either for now.  Once they are public in
uAPI, they can be added here with enum-as-flags.

Fixes: 23fc9311a526 ("netlink: specs: add conntrack dump and stats dump support")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 Documentation/netlink/specs/conntrack.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index db7cddcda50a..46f1ba880745 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -360,6 +360,17 @@ attribute-sets:
         name: tsoff
         type: u32
         byte-order: big-endian
+  -
+    name: filter-attrs
+    attributes:
+      -
+        name: orig-flags
+        type: u32
+        doc: bitmask of tuple fields to filter on, original direction
+      -
+        name: reply-flags
+        type: u32
+        doc: bitmask of tuple fields to filter on, reply direction
   -
     name: conntrack-attrs
     attributes:
@@ -466,7 +477,7 @@ attribute-sets:
       -
         name: filter
         type: nest
-        nested-attributes: tuple-attrs
+        nested-attributes: filter-attrs
       -
         name: status-mask
         type: u32
-- 
2.55.0

