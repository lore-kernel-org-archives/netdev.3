Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107F1F03DE;
	Mon, 27 Jul 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144799; cv=none; b=FgOUPjZxvu1UC/jHT46/+rRe7wGvHIq+ZJeBTSnC+Y7TDPdCX32zriB3jW4B7NM9UohdiOuerPEBXzH5+gYTJFdSdJNArlG7j0o7sjMPVlq9IvabRa7hvFKG28zkFXeKPpodXCxeXiTCvhjzQUGZAVoLitqvDyPrESH9vCgLIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144799; c=relaxed/simple;
	bh=Rm2OQdxtQcMMVWf4wd1kSKoD95zFWKCB+zHjmmhMU+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8oe3H/DksykGl/0qA0Ftnp2Kq202m427K4kqluz29cZzlsJk8Fh52cwGsL7pg84Ij1vpRp0qjdQuHOtI/E+PnLwtcAotfM9oNDXZvNS8IYxFAZdDozbA+fvtovRqnGl0gLgGeSnTVY7CYKJLa5Lc0d5Tp1eZsQGJddmEcBlYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ukz5Ox90; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ukz5Ox90"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7UH4k2643359;
	Mon, 27 Jul 2026 02:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Rm2OQdxtQcMMVWf4wd1kSKoD9
	5zFWKCB+zHjmmhMU+0=; b=Ukz5Ox90FO8R9ixqguo/TyM8bHpUO3G9nB3HP396F
	lpZOsFAVez5PFDBHRmjgibXQSBqmRyb17T+Jv600WTy8Fkp3+BliX5qC2ildLy15
	2lgkWWc7GC2fZFS3j8z9NrU8RWcBm7oCU7EShvcqufsS8E2fkq6dDzGHEKwg0imL
	9mpFDdzh/as80moOPhDOIlY6Em9KvIaqfLveZTJVNDap8/yvXCDUBneNnRZZWy6F
	qk4yGyME9T7bCy1djWYLkldeQhZdfL9+2j++gN6EgcxHU/uWv3feDuTzqZktvlP4
	/4TsW9CtqnroIBV19eQCpYzUuCl0TRbzgGtovilcsa7mA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fndw8t2xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 02:33:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Jul 2026 02:33:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Jul 2026 02:33:07 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 003823F703F;
	Mon, 27 Jul 2026 02:33:04 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:03:03 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net] octeontx2-pf: add mqprio bandwidth offload for NIX
 TX schedulers
Message-ID: <amclzwg3qXGbaZVa@rkannoth-OptiPlex-7090>
References: <20260724075010.2665758-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724075010.2665758-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MyBTYWx0ZWRfX46JaG0KAi37X
 6CYDr/OWPC0VoDEpPc2U4XQXgVLeOAdd4LxZYRipguy5Svazt+zhDQPOGS3zJlVBKtPDtiYUin/
 xU+kbeULQOf9wg+cb+uhtZeJWm5jKaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MyBTYWx0ZWRfX0QJYQn8Zkh/G
 SgkbKRX2upG0oEQQ04d1hoXezkXvjPcazA8O8w5HD1Y3BQuW0LCjUlFnuHD6S5CPZ71re3yJr0f
 coxqUTBfINrSdv6HH28MTSfvpWzLC6J5t6OcO1MGcDopw/u/TZVVoll8eUh7ZsidiaosAc0Z3Fw
 L5m0HQI89Pao1FG7q0FSkzSce24FtNVm/fNMbyubnZISPXHMyYkHAU8w5+UMThuiS6kr8f/EYaz
 cXHrgVgUBQ5BfrKNCvkMOMsUw2gJTWId+7DpYU2b+VPtVb8QdBNriDZ1KnqFTHJKEIoNOeQE/bu
 hWZysdd+03wvQ5Qc6pLHjKJ52rBDV+5I959W79bnFUY1e7zrgJRtXXUIrRDqdgyv6OHMlgx6myP
 9/IAMJdqcqVRFD+vH152K0RbJPwfby1f9jcxjVquDsNf8mb+wakyGBhQO0P6B7bnmB0SxQ284Pn
 Ttgzlg9r/X5iuCsGj2A==
X-Proofpoint-ORIG-GUID: VV7H4h6VxsylDTI9A2vYJ-oCvpiR8vB-
X-Authority-Analysis: v=2.4 cv=DeknbPtW c=1 sm=1 tr=0 ts=6a6725d4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=pUhW0NasXGczhlxQT_kA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: VV7H4h6VxsylDTI9A2vYJ-oCvpiR8vB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01

On 2026-07-24 at 13:20:10, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO handling to program per-queue MDQ CIR/PIR
> shaping after mqprio channel mode setup, widen SMQ allocation when
> per-queue rate limiting is enabled, and align MDQ parents under that
> mode. Reuse otx2_convert_rate for bps-to-Mbps, fix sparse register
> writes when only one of min/max is set, and improve AF txschq map
> mismatch diagnostics.
>

The patch was pushed to net instead of net-next. Will post v2 to net-next.

pw-bot: changes-requested
