Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAC224AF9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.79.125.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226411; cv=none; b=FM4s8nFmWMWYZt3Yt9eiuFDx8bH9i33yLyqX1zbs/VnTjpNsw1HYoQTiH5o5DSx+9BvvsEykgiDMXROZiwhnaixXJ5SmDUMGLA6SSWmiNUACOM4tVyNS7OwGNc0or754MTLgrCBmCnQHH20SC+ZUKuqZvsWatlv4fpPtjgTARjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226411; c=relaxed/simple;
	bh=ay8xtbdMvuuzUZzX9sXUdRTLSrzcksf3vbU2qhUehek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FILv2zY3q5Z8A0vKPwLQsGSUWX1cNHzO96itA+e+X40Zz7ix2WISXERZ7eQLLuu7g7//v8Ln4Hm1bDymw8pSxjO2Dn7/OpplisDtrrgPIwkmnoIDuh7JguI0+u2tXcAysQSek7q4OYSbdZsE5mvyBqAgM81srTQxhMrY/Yj+V6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=mYsa95mE; arc=none smtp.client-ip=5.79.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="mYsa95mE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1785226405;
	bh=ay8xtbdMvuuzUZzX9sXUdRTLSrzcksf3vbU2qhUehek=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=mYsa95mER8/3rIUMTYTMvYjlfC1ghjCF/M6cobYPuYeCJx38iIhRuOgFLPekDN8V1
	 M5B6Dov2XLnPiiM2avv1LysRSNnHMU8ijeLssrUl1rLHNkVFhRTTku/R3+/45v5hqv
	 Aa1dKE2v3cr8Jf+P9tM+f8fzFJmglF0KYPkqFjEpIgOQEMOagA6phNP9AiHfmCk2vY
	 SRCUVUT1BNp+if7ERTg1sOGR/Nmn0Jrxiw0LqmG53sssLfRJ4Ac9vx4RWY+knMfIsD
	 S5/xTmx43gvyqlH2GgzCWO+49HIVPRqOlkG9p+Lg9bgjFkPl5bXG6ygCLB6YdBgKps
	 hACvo0O1XcUfQ==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
	by relay16.kaspersky-labs.com (Postfix) with ESMTP id 4CAE9C07C56;
	Tue, 28 Jul 2026 11:13:25 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id CA445C00082;
	Tue, 28 Jul 2026 11:13:24 +0300 (MSK)
Received: from HQMAILSRV1.avp.ru (10.64.57.51) by HQMAILSRV5.avp.ru
 (10.64.57.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 11:13:23 +0300
Received: from HQMAILSRV1.avp.ru ([fe80::487c:531c:bded:f724]) by
 HQMAILSRV1.avp.ru ([fe80::487c:531c:bded:f724%2]) with mapi id
 15.02.2562.045; Tue, 28 Jul 2026 11:13:23 +0300
From: "Sergey V. Frolov" <Sergey.V.Frolov@kaspersky.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "sbhatta@marvell.com"
	<sbhatta@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"bbhushan2@marvell.com" <bbhushan2@marvell.com>, "gakula@marvell.com"
	<gakula@marvell.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"sgoutham@marvell.com" <sgoutham@marvell.com>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Thread-Topic: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Thread-Index: AQHdG2cbGfNQf8WH/02d6/mTYwc6LraAhrYAgACLSgCAAQyDAIAAejG9
Date: Tue, 28 Jul 2026 08:13:23 +0000
Message-ID: <b4d2412a4d2549ffb1bbc3c50ea39b8c@kaspersky.com>
References: <20260724121941.2637908-1-Sergey.V.Frolov@kaspersky.com>
 <ambQOBLp5yYDbRSr@rkannoth-OptiPlex-7090>
 <159a6806dd1ea12bbd559f664ce30d306cdf1178.camel@kaspersky.com>,<amgmTvxY7_Z_u7tq@rkannoth-OptiPlex-7090>
In-Reply-To: <amgmTvxY7_Z_u7tq@rkannoth-OptiPlex-7090>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-kse-serverinfo: HQMAILSRV5.avp.ru, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 7/28/2026 6:22:00 AM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/07/28 05:51:00 #28574293
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

> 1) Fix the off-by-one boundary condition by changing:
> if (burst < max_mantissa)
> to
> if (burst <=3D max_mantissa)
>=20
> 2) Add a WARN_ON(*burst_exp < 7) before the else branch as an
> explicit safeguard. This ensures that if max_mantissa ever changes
> in a way that reintroduces this condition, it will be immediately
> caught at runtime rather than silently triggering UB.
>=20
> This keeps the fix minimal and correct for all current platforms, while
> still providing a clear safety net against future regressions =97 without
> adding unreachable code paths.

Thank you for the detailed explanation.

I like the WARN_ON suggestion. Combined with changing
`if (burst < max_mantissa)` to `if (burst <=3D max_mantissa)`,
this looks safe and clean to me. I'm happy to go with your approach.

Acked-by: Sergey V. Frolov <Sergey.V.Frolov@kaspersky.com>

Thanks,
Sergey=
