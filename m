Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FB366553;
	Fri,  4 Sep 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512503; cv=none; b=KDxXrfNTBW1/bWcwY04r9nkMBZKL3eHuS8WPYXDx3AiFMwsndayd1hRvMh+VBYsdSwxeinaWi5rLZcUojdiDvXaHJGldPQk7v5ssTmrYVaiFAelZvr3YqG6Fkwf3lwzj5g8TTKsfqxRfXXbJst9DmE+bET5pbD0hGGEMmP8ZcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512503; c=relaxed/simple;
	bh=X8vh/qkK2Eb2U5rlVQwB1IA9TxuF1aMgLF4c/JjJ5DM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz/KtInh9OzJTLoNKufp6GKElfMHAOiT3eX1nrKUAESy6vHpazzF7/nofJeLFn7QWz5N/PhMtOf2AyDEOC0aIdMNQoIn73hQ9sAtXJyyBXjbvrOvEg6OwQZwMLZzsUsuySsPaJBpIFcIGuitFpRXPi9XbSjOLh2pffT94QcSn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J+TEXlE5; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J+TEXlE5"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464V3w2883056;
	Fri, 4 Sep 2026 02:01:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	xEK+BRF0lHf3Vf7Lz+ZF+OlyKnHizaV+Pta9vXtsm8=; b=J+TEXlE5/jSiaB/aW
	0apCzG7ULqsMkdndnyFhL/fOs3k3hpOiScAAT+T7OkBAvghat8eaydwg9u34CpmW
	xYT0vtQvl8zIWSbQbSeC16j1QyjWgapMve073IlKmj6xpnML3z6xPezYDh1H+PdM
	H7jqRLDtfGExisfK7lqXkGQy7tZD95IxRQdFvCSGbzeL25FEzIZUD3ehOtDjcg1p
	pMk0xgOEG8QFK4an2uw6MxEo2VeQ482GrhteiUX4JJ4X7aA5xDFD9zKW1TLAw1T6
	nt7oe2/OGETgbD3z+njEYbAx4If5s86owPau0wZFoDNDHzuCexGHm7tnVzGmktnW
	0scKA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gfkq9s46x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 02:01:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Sep 2026 02:01:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 4 Sep 2026 02:01:33 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BE31F3F7066;
	Fri,  4 Sep 2026 02:01:29 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:31:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <hkelam@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <apqI44Y5ooLOPeij@rkannoth-OptiPlex-7090>
References: <20260901045857.2779326-1-rkannoth@marvell.com>
 <178850876430.4131868.17635457333077226877@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178850876430.4131868.17635457333077226877@kernel.org>
X-Authority-Analysis: v=2.4 cv=Q9riJY2a c=1 sm=1 tr=0 ts=6a9a88ed cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=KKxfz3ew_ke5nQN5NokA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: P6VXWv2u_BQzIMtyZ12uqwyj7g1XHfvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX3vSbuTrE4AnS
 y4tw3x2um+YQXg1i8YbOXZfobcGFQH2Vbb545TwqtPsTiojV/z4IfIbDvFEJ42jLIob+NWl0Z8E
 N/kiyeLKDkuoqLY0+8eurVOVkIWCbCO0bP/Sbo9jCZvbxeyRMrVXsviyTKU4768q1opFeqI5dP2
 JS074/0VrtLCxqZy/V5MO9uaAu8jYjeliGdz/a06tOQM980ranolT6d6iIaT9ppU7hvlQNPJ2vr
 ztZUlnD5cmisHfi6xflev04S+VGFqWPVqlP68WgiAPg0xtqWUKRJMCqCKafHyH/p4ymeuT1Pfyh
 Grr/1t3QC36SdQqPqFrY752/6vPn+YNlKHmVq4WstonFFNWj5M/RNa4WY7wDxW8RIXqr8PmucxP
 fz4DOifI5YYq1yNgRWu3EARwlUjw+IJPXtUjioeGY3EnpfJi5bx4YfFeDZxJ8PmToF7L2JFatgc
 a8HnmbqFkZhh4NXzkkw==
X-Proofpoint-GUID: P6VXWv2u_BQzIMtyZ12uqwyj7g1XHfvw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX10uzSiyastI5
 fGD9hni8mKT4s6ANIERmZC0o9UlLs0r764UaroZpCsAGSSvoXCQ5kwwPJKpYmpDn2uElIfLd9+j
 X+W2CEOWlGw4VWSV1Jf3XLxQ27mJsJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01

On 2026-09-04 at 13:29:24, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> - [Medium] otx2_get_link_ksettings()
>   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1235)…
>
> --
>
> octeontx2-pf: report port connector type in ethtool link ksettings

> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901045857.2779326-1-rkannoth%40marvell.com

i think, below sole issue can be ignored.

+---+----------+--------+----------------------+---------------------------------------------------+
| # | Severity | Status | Location             | Issue                                             |
+===+==========+========+======================+===================================================+
| 1 | Medium   | New    | otx2_get_link_ksettin| Raw rsp->fwdata.port (u64 firmware field) is      |
|   |          |        | s()                  | assigned directly to cmd->base.port (__u8 ethtool |
|   |          |        | drivers/net/ethernet/| PORT_* field) with no translation, bounds check, o|
|   |          |        | arvell/octeontx2/nic/| validity gate.                                    |
|   |          |        | tx2_ethtool.c:1235   |                                                   |
+---+----------+--------+----------------------+---------------------------------------------------+
