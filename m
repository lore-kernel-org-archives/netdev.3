Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912A444713
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781900; cv=none; b=FEAh/Z5u0BNq2o2VNIUE91Ql1wKbdAf4Hakjq62sJ3IrZ2gzCoJfYj9ExDcA8qOEOSodwLlZtyAfUxw3s5NVD/Plb8KjxW8GRHdrGy2qGWfMid6U8kZgFFOLkamm83q2TmDDzVZVzSTAmYbq/Z8XqQbdJsWW0Zhc6vFPFw3n4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781900; c=relaxed/simple;
	bh=FF5GpjGANX5AK5OcRxrqub1zd1QKVWSW0xCxSxzcrm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUkcGuEhC2vUVaEtH+wJBj4MQAE5WseuoG7pclqBTg2VtcBIX8mjxvtuUbXQIH0H0YNgnyt1ez6E97CjgiWUoqurenY0wtUZxBSKm5zZ3X9k/5vrMmgwb5fQvesfvuyuKANkRMWKmSesi+lEIUSQSL4klkJKYAFQ1z1Ikwud8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so165740f8f.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781896; x=1788386696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXH0qC5tsPyVyIeDeRYkK9RuneuxwblawRlIIgMj1Cw=;
        b=pymtECr7YWxPgsMfBjmbJEMOBzDZ0inkTk7CkSHOGOyVkQMdOeJgfvuB7xxk6ogyoq
         5upm9yszWMFEJox5KMk0nZcJ/njKvcnuNMOjFbCEsbsL1keJoao1Kk2Jyb9g2/qa9c/1
         Mq3KeOqDJTKi94jPJpmKAuWs4L83Ny2CK3icPsK+jrQY1sP3+UUfCzMpNJVC2iCdKOqi
         UVqICBYNbA7TYjuyy3qMz6omEWr3dF8QG6tOistk7A0VBsJrn7R89pgK6UxNH7H1mAwM
         YqEl0zXi5Yx2wSnDwqDM5ZkdS9T+8e/7ZzU3atI9IrP8qA2mX1b5gJQAal8fxNFWwOhJ
         YUaw==
X-Gm-Message-State: AFuF++mY5SGwgiuDuocRPudpOwhYnVLfqqBWCcehQT5+i5xIDxpNQLLF
	m3QWoyglGg1GltkAjOzGCPB9ZYrn61OqT4bqrPhjId34H8obtAPvzmrvaqbxe2Jj
X-Gm-Gg: AR+sD113VIecbjiq3ozLRsoiWskjxcr9rVvAYVmfR6Z7/aM4cTtOmQyI2Xk0QDXTM+U
	ysR4i5K4TrHeQ170YByNCHIZnz3yY96MAGDH2UCwBoi1SX4EMd/njV/vfgOWGSMvJjF0+ISR2/S
	PsM3n6JnxvjCdALO+ixn4iAO3lqpiAQGNU0eWTnCqt3odh9JohVsKHnQFb5MrNb/WTfz0zT8RqA
	gNAZL6LJCAvIFS5VgbsWFCzlMTy33W3pvqt68Mc3IJJjV1Wf3jAToKFOtssFnI+NbNTJksB9glq
	vQnzGV5/Ogd1XFQEmZgEldoFM4QQDiDF66Kygf7gJ2S5yNKYdx8DZFUSMjkvcv/njTwzgrzBMNo
	wNdD4jwj+WmxFWNIOnmyLrrmf7/J7yIKmPo4umwpuV7uSrJegNGF620nlhQK8K5rif3G3TvnyQF
	CbCSblCcJWMOMVkUFAEKH33tKy58ZPiCFl6HFyS0kL68cGP5zAgY3h9suICPj437x/Tvd9WTh90
	pbZwDSKaBf6KU3mVw==
X-Received: by 2002:a5d:64c2:0:b0:482:e10e:58df with SMTP id ffacd0b85a97d-482e26d51e8mr11792199f8f.21.1787781896114;
        Wed, 26 Aug 2026 15:04:56 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27a9f0esm4446370f8f.10.2026.08.26.15.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:04:55 -0700 (PDT)
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
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] netlink: specs: fix the conntrack filter type
Date: Thu, 27 Aug 2026 00:01:11 +0200
Message-ID: <20260826220444.4054714-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826220444.4054714-1-i.maximets@ovn.org>
References: <20260826220444.4054714-1-i.maximets@ovn.org>
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
and CTA_TUPLE_REPLY, which are also missing in the attribute list
for the dump request.

The bits themselves somehow are not in the public headers, so not
defining them in the spec either for now.  Once they are public in
uAPI, they can be added here with enum-as-flags.

Fixes: 23fc9311a526 ("netlink: specs: add conntrack dump and stats dump support")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 Documentation/netlink/specs/conntrack.yaml | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index db7cddcda50a..6ba28cb1c2ab 100644
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
@@ -591,6 +602,8 @@ operations:
         request:
           value: 0x101
           attributes:
+            - tuple-orig
+            - tuple-reply
             - mark
             - filter
             - status
-- 
2.55.0

