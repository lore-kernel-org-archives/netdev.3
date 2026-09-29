Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411721B192;
	Tue, 29 Sep 2026 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650356; cv=none; b=pna6atzw59mAgeoQrjVDpN4qGJ59zCQj2fhQG4n0zmpvWDtO9XqHNE2vb7vrbQL86YR3uEKff6oCJxq0t4kx7sNSIj942ES2qYcdplNYbx56RlYMJnF3SrXVM2QeawK12Mzuwx3nIanvIcZZmmGj+oZnivR3I0kPzNCL3ZP0iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650356; c=relaxed/simple;
	bh=ch7VmLk7QqYZUv4lmc8jiEhZj+S/jc2XhT/mUeMsN04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMA9LWkUezkKmZF+rRVOtNNKJgsrj7Bywyf6cRcte3x5pGSoQbfzcN6qlkYQ10R3bkZuS/H2wIcivIkf5OTA/mkDxt1YkH/q27NovEbyT9AxnsBZ4HzsQQteE0nOp/xrJSvVDIXRkVjQmFDowTSG/oYrVuK/AiokjWyjzXfyZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=anavgqJo; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="anavgqJo"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T1YT7o2904052;
	Mon, 28 Sep 2026 19:52:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	3lwBcQxJ6NrmDuJGUmonvrgjZFMfRrNzzkZ5tPCLmo=; b=anavgqJoOXYTQp00x
	T4SeUNO0LgDDerZjelq5srPym7t/b12VINB4lR3mfFYDNtqvsPZxnh/fLOGLvlSR
	yvEe5Gndn10RqYt2j79MWb2y8m4S1Zkva4u/NVtGES9A+5N1AjrH3/Kg79Vy1q5h
	PvjASak4mFi3F9VkHPZ5soo8yG8AfvqQpDua3RLjyr7gAt4u/PVikAdM8gT7Bf0b
	B+tlWqjX8DCpoEBKblvL0rRmUPGsL9WnT4V5vIGb6APndE1J1zMHYOwLCH0SrwtV
	OEKJHNhl5XiN7Szh/8/tfb727Mx5km8E+UJ+MES+HQTXuc1ktPZjPR2SLK+jqEyP
	bsrvw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gyub5txv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 19:52:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Sep 2026 19:52:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 28 Sep 2026 19:52:18 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 676A63F706F;
	Mon, 28 Sep 2026 19:52:15 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:22:09 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-af: fix partial NIX Tx scheduler queue
 allocation
Message-ID: <arsn2WKWIqzAahZg@rkannoth-OptiPlex-7090>
References: <20260924082128.1944674-1-rkannoth@marvell.com>
 <179058435280.3145.10954316639683713234@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179058435280.3145.10954316639683713234@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMSBTYWx0ZWRfXzM7B0PtVffQa
 Yh7jW1rw+RILjkQupRUh1ttE2BpM0L6EQY1Q7i1EYjXZu6sa+gDlHqo6R2JSUH/EolNDbdezy31
 LztJ2UCfhoWsLbs9vRhQcBOXceLo7gw3PQUDd1j7f1hkm+lUfHtfQAF/deSmwBWlBdNdwXvLB0F
 Yv5JuLWTG4j/PtUNR87agPx05Caphzna0bFZvLENDENKTF0Mn7+Ug0bxzq1dz9K3+nGcA2hJj9N
 St80dFbHnfJ4Sot3ZmRnau8UHmoyWyQft2dSOs9+AnheWiwJ2M8RJK5OkQm/4zESDbXgJhSu685
 QVevkOrlG4MwteEl8it1mJhlyjIhML7Ikyn+cfGEEOqor33U6FtyPExwnIeGxX/kiI8jsBoygdx
 Yuz0BYEqx/1qHKruhRMQAgu4AKfMSh7w4Chh7HcRVYDf150a6bt7Ag9ThFYffy9IXyS0ii3iSAX
 pEcpT9XbWOg619ubhfg==
X-Proofpoint-ORIG-GUID: IFEcM-ud-je2H5HW0O7piRlSkdFd_kDL
X-Authority-Analysis: v=2.4 cv=e/ST2qp/ c=1 sm=1 tr=0 ts=6abb27ea cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=PuHq0AtQRq8k6O7Yp28A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ZXulRonScM0A:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: IFEcM-ud-je2H5HW0O7piRlSkdFd_kDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMSBTYWx0ZWRfXy/ouKf0Dbm5D
 OEdt/sRXIGIWXoqqwhC2T6b3g4S4Z5yuI0ux5++5RV6PGjDyF11sFgRDI47Vs2XEqz7XJsNUHZ2
 hRhCZPn33kKqlffnDrnmFRqeWjGTxY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01

On 2026-09-28 at 14:02:32, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 · High: 2 · Medium: 1 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] The patch says it fixes nix_txsch_alloc() 'return[ing] success
>   after allocating fewer Tx scheduler queues than requested'.

ACK

pw-bot: changes-requested
