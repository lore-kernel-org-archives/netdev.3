Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066C38B9B6
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021269; cv=none; b=aSQX+vzu7BVdzQ5gtVAYeY+Sg35ODIeY3Jy+qE/aMDxpYjZojVNN8Fu7NvKi1iEmfg5es/iDyLMC4lAfCO8GFDXrBOnwIgojIRQQrPKjq3JAS5YO4Qkq1wtw/QwYYeP+uieohF4SrFh5LfGDSry6U7q1sB3tHpQQWPHjB3/bhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021269; c=relaxed/simple;
	bh=D6Yyt9mJNyPjj3ih5ntUNxqQuk0ywkubOjyJELeEG04=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMXuSHbxLzgCUs7X5EhU1A8v41QCkraR6KMme3ICEeyq5PqjBa1f4/YKqWoA9QNeDPxtEdRfDX85bDHN5lIdTPFgb0zCQ+rB4sSsdO/qOtc1hisKOqvrYS2pI4NNm6SGMFoImsOYn3LqC50UlHLlwoAUfrECf5V56YQYHtcHjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Vlv6Sc2k; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Vlv6Sc2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1769021259; x=1769280459;
	bh=rHMVPKl2AAFuu+Uzm988Bz0I23yJv6HWmEa8ePr+Ee4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Vlv6Sc2kk0i/L8B2aU9BU0pBt+KLo+dKHMiKrzxm4Jx2o4LFcCXSvkrcCh3v5gBvR
	 baEjyTwN5FCwr+in9azNOuj2mKl/fB5LNitKaFHXRvzXbNha8oM0W9LElKkLUpP89Q
	 YJWnlqCUAo7TDxK1CrL0ruUBpfvYHg2BfzZpCaW/zKEECbCu/KX63ypbKqftfmIvR7
	 gDClmx3WC767wk8zmRPS9R3X9nsP2Wfe+wrQYFM9Y7jQVUD6LBbDMF4Ua/icwtPRFz
	 XboFzNPeLEkNQ/chjGjh/Lm2bg3GLrthPrRC5Wq99RNVknxynK3ZS9Ty7e85ib5B/w
	 yJ8pEt8E6Hr+A==
Date: Wed, 21 Jan 2026 18:47:36 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v6 1/6] doc/netlink: netlink-raw: Add max check
Message-ID: <20260121184621.198537-2-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-1-one-d-wide@protonmail.com>
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 0944e501e84432700ce17ed40164bc85ff785af6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add definitions for max check and len-or-limit type, the same as in other
specifications.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink=
/netlink-raw.yaml
index 0166a7e4a..dd98dda55 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -19,6 +19,12 @@ $defs:
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[0-9A-Za-z_-]+$
+    minimum: 0
=20
 # Schema for specs
 title: Protocol
@@ -270,7 +276,10 @@ properties:
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
+                  max:
+                    description: Max value for an integer attribute.
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
--=20
2.51.2


