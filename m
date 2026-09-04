Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF343AD50F;
	Fri,  4 Sep 2026 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491752; cv=none; b=heF0Zgv3ropx4AKap0+OuNfO9Vdl1hxzuJpgOp+ubauXGTAPo1TY79TzmZqSF2+3s4OJ9K76+ygq8Gx8ZDqUopPZb2q/Xj89PDKgynNuPaSOxGVuJFGFJXBNZvuij7pOXMbOdBTRvNvCJ6N+DwaWPcYuzBxobi+lFXb+p030gE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491752; c=relaxed/simple;
	bh=Ph1COaWD1/TZeiCWV11M4UTFGz+5wUP9COH4JlUYcC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/+3OTYnDO7qMNx2Dx/a3GyYf2zSzJd1A/IUdq/MVisAzQHIUaaT9IVGcLOU5O4z3i+bVZRglLQnpadPS0yS/nf7NHQ8ofcUqxxek1pIhbycX4kdz4h2IY5REXX/o2ItfjoL6jFSXrKjGr+QEZwO1q1orG2bmi26TouWY6E83js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KCsNXQ7C; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KCsNXQ7C"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842ow1E1559504;
	Thu, 3 Sep 2026 20:15:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	h1COaWD1/TZeiCWV11M4UTFGz+5wUP9COH4JlUYcC0=; b=KCsNXQ7CDJt180GH3
	nAZgdxJU7jR9oNyvaKZ+clbu9iKbjH8KINrtW2jH7D8JLVG7T470UHZYThKO67EU
	zEgkQf4xw4KKmIICyUb3n+p50QNuPG56BhY+creD7EQQRe+AOGuz21NPD6Eixyxk
	yR6OSdVtncJzVWLqMhXcSvxoYAWY1QOP15C2lgkPwnRtlWA7Htx4pO1PDRkkVny+
	ShHJei3LpxLpNIL12kMMfkmUFLsaR+sA3Vf5CmlX5mHCemXGlgUdvVqtoocsYMw9
	D5TsrSLxT2zaOud6mTKCjH6Pnx4iqomNe8PBapnP4sO3VupL8el/FbC1yi0bTTf9
	XI80Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gfn1qr509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 20:15:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 20:15:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 20:15:29 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 89B073F70A4;
	Thu,  3 Sep 2026 20:15:26 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:45:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [v9,net-next,7/8] octeontx2: switch: plumb bridge FDB updates
 through AF and switchdev
Message-ID: <apo3yFqlEqsl3blX@rkannoth-OptiPlex-7090>
References: <20260831131944.2649362-8-rkannoth@marvell.com>
 <178846349021.3394541.5852418349978761361@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178846349021.3394541.5852418349978761361@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAyOCBTYWx0ZWRfX1EiSvDZDFq4F
 TW6eRid+UqLeKLZGqY3aw2zA2Iw4a/bgn1gQB8N900lnarW/VwVehjD+h1LD7gDbQ2uhwOzvXmF
 rYFqtlQvNJeT1ZIP5j8PXARJcPgq2yF0m6pqQJT5kkDQla7czoUTrQ71AC7NDEReJjpB4SNb9UQ
 6GeyY6xj9YfQZcYz1sdIq2CbCIixGolXxlyccktMFxx7k6yKNhRUY3/Cq8i4L7/YeXUFNpLZ0ST
 pujLbjRE9VCMzwxSlxF+T0y9hzonjpA5DZ2KLl/oD+TeBeyeHCfSqX6yq0sFSZvwokL2TOdTNmO
 rNZtc8S/n19Rmi4drfiwJFc5jwXARgoyzHF+boou07NKEdFaUtH5P/6RRYpZvd9E4Irbhxq4RbG
 9r2SineRsF3iuuc6bwBDwc46sbmc9CImdJJRtqGez36IWxrBuM9JQVDeFNkwi4QMJbJe+Wdj/t3
 6biwmMFD9F3cZ2Zhzgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAyOCBTYWx0ZWRfX8Wx5P1cORkUN
 /vWS0CZ8Yb3HRmAK+zydTTkMHkDKG8to/CmKQTlP5TsRW2jA9hIOTC/Bxp5Qutru58aW6E+oJkV
 n3fUJgj1Dbj8oAzwAGctTg7O7FypO+k=
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a9a37d2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=LY0MTtD5d5xocWonJYcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=SqOTP2NwCHEA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: 67u5rWJOEY-cpeu8XrNuDdWdgJ-fWdzA
X-Proofpoint-ORIG-GUID: 67u5rWJOEY-cpeu8XrNuDdWdgJ-fWdzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01

On 2026-09-04 at 00:54:50, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 19 potential
> issue(s) to consider:
>
> Critical: 3 · High: 6 · Medium: 9 · Low: 1
>

will address in v10

pw-bot: changes-requested
