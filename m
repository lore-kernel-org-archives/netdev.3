Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB1155326;
	Fri, 27 Feb 2026 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150879; cv=none; b=MOWSqbKuAZ8hQ8ycx1GHnd/Bw3jDxBv2PIt8/PhGgcbB8GEepIrI0xEvCc1F4SsPe7yYg2/9rJxP3rr4t/SuvraeXGaEy7Vvnxcukq9Cl86MqS/5Mhz/NYG9haWS4mteRofkDrfNzS4PhzzxdJhSqIadPJZ57ddFBxtNxzSvKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150879; c=relaxed/simple;
	bh=KKfWeAfSMYTw6YqbPmajJtN7Du4yXNH1wQhGmbdapdU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kxXKHYFnw/avACTbCtzZIN+Z4uzG9WXfFYSsxSzJWj6M/mR0UaRJCXipTCJ3P7rbq1kEakFHNhI+Q1ARZFBSDhdW/jOsJ6bmeGp5VhkHBOL+uSxyfOLSswzTJFe6PMNTqbT1VpjsoX1pVDxk/NZJL1qDOJxJyU8bMSfXAs3VMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KeJriNgC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KeJriNgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772150874; x=1772410074;
	bh=KKfWeAfSMYTw6YqbPmajJtN7Du4yXNH1wQhGmbdapdU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KeJriNgCfNeFHN7XmN4qytrS8zVDM18LbmoUlBrkQIUzp+VJrfdPNaakndGudTqgk
	 AXzpN75tLGf0H5A+mL2jaSp6WPaCO/mlO/40nCxko2Rg8xvhYTik7KD415dQi7mcM5
	 9wOylN5P95NDy6bqNA30woWrjArwlZheoBe6gs7P2Y31mnm8I8xGE2fuIqEFNf9sd3
	 o4w2TBvIqMj1JMNdudX8pm3gaQQ1DNhgzh60VCUCoYywerBrL6k3SlWVsbquiFcRhP
	 9tq+VrDNtcTHphTuM5I/LF/uZlCQFX4Kzrkr2E6gYjqO1tyHsNh3LY4bG8c2+Z67I/
	 CFh3gkXEFD44A==
Date: Fri, 27 Feb 2026 00:07:47 +0000
To: john.fastabend@gmail.com
From: Leon Kral <leon.j.kral@protonmail.com>
Cc: kuba@kernel.org, sd@queasysnail.net, chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Leon Kral <leon.j.kral@protonmail.com>
Subject: [PATCH net-next v2] net/handshake: Fixed grammar mistake
Message-ID: <20260227001151.41610-1-leon.j.kral@protonmail.com>
Feedback-ID: 184191534:user:proton
X-Pm-Message-ID: 26f61213add1de94c233d76f67e1a18efca4491e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The word "a" was used instead of "an" which is grammatically incorrect.
Fixed by changing from "a" to "an". This improves readability of the
documentation.

Signed-off-by: Leon Kral <leon.j.kral@protonmail.com>
---
 Documentation/networking/tls-handshake.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/net=
working/tls-handshake.rst
index 6f5ea1646a47..4f7bc1087df9 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -7,7 +7,7 @@ In-Kernel TLS Handshake
 Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-Transport Layer Security (TLS) is a Upper Layer Protocol (ULP) that runs
+Transport Layer Security (TLS) is an Upper Layer Protocol (ULP) that runs
 over TCP. TLS provides end-to-end data integrity and confidentiality in
 addition to peer authentication.
=20
--=20
2.53.0
v2:
v1: https://lore.kernel.org/netdev/20260226000915.27898-1-leon.j.kral@proto=
nmail.com/

