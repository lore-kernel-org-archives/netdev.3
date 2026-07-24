Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0983347514;
	Fri, 24 Jul 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885738; cv=none; b=kOZmm+twXT7bc3mpjQYVox2rkwrBaB5g2/W6pUhUNg+mTlAUH8awZLyeNf4EOlFSrQYKu4PuJwkRyMZpTFs8WJFHjFQ8cmZzJLgz6l53bQtwnk2vkYyS1Fi9PTnS2P2dNGHylR4i0C6mDPiBjFgN0duG5hrnAx0+PcloUKOqcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885738; c=relaxed/simple;
	bh=Ep818I0KWL25+VYHP/+29O7T4BxioGN4GlzQBJcaPbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8rSAS2mJXHVmmV262sODoiZIFGV3RiMMEobiQY8x2KQE9PkUiWWK33pS7id9Vq9knMcLpyVHqayymYHgEpaj4nMHs/aZhkPBwfWlYTmROpkIzYSy00T7pHcOmDiJAt74S7B6wqFjpfzJVUqxvPJRvQD/gZxZCyImiqFZl1krqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z81uxgQf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z81uxgQf"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4mIpr907239;
	Fri, 24 Jul 2026 02:35:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Ep818I0KWL25+VYHP/+29O7T4
	BxioGN4GlzQBJcaPbs=; b=Z81uxgQfTxz/0MvK2EEBRpzMpLQgSFvjGm8OhxtwM
	3eL9fgu6rJPFmMqJxj/fURcjDj520i8X9P9jEgascq4hMmPLwHLvXRjWyRARnCmT
	bOG03AJuA3ZfXEv0wa/QzuXRzzqVOCOOlt3CboIZ3J1ApIlJ5QaoyDVJqxkSL9eI
	Cav3Z/Gyvi9UzEMfX1wkUkBeZAtdVJ1Jy/K1bwp2ybfXeQJ7q8IUQDZe62IvnkHe
	Mw3MuzzZ9U3NwV8JIu4o6GL3w1Isr9RRAWl07AH77okXA5PCv7woDCIW088fO3F5
	ganHFX7quFwW04KAqIli621PKlS6/9lWauy8DjZ4zvWGg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fka6kckvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:35:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Jul 2026 02:35:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Jul 2026 02:35:15 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 57AF63F7076;
	Fri, 24 Jul 2026 02:35:12 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:05:11 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v4 net-next 0/9] Switch support
Message-ID: <amMxz_5CqCJfk9xH@rkannoth-OptiPlex-7090>
References: <20260721081824.1430607-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721081824.1430607-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4NyBTYWx0ZWRfXwYUWzaQC1wPH
 LBkL7EqriES8G6I4lJHhC0+IMTB6wffw5XF9NGJHGUr15tTk7OuXQI4v3MDu9hcER1W0Qvad0S4
 /f5TAI6EBUywfJRYyY4HMiXZwXro9U8=
X-Proofpoint-GUID: PCjx04BE8WsWXXQRo9-4tNADwfu8QpOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4NyBTYWx0ZWRfX9+jC4LWX/vef
 LimYDRWW5yNyE0iR/cbLIVvTSyTiCk+xcXlrm4StlePT8DbRE4kDmgoy3ptR0EQbiMN/P7Ddox2
 oKvF3/ou2iMZJLG4CZE7xAd03gSwT3xOyf2oQWf/LtQEvYXScvw/2Q4z4bVg8gdmn+lSrhDr8mt
 o4cK8zdHkKOJiKVQk6VgdWI4xNHC1GKYMfzMaKY9J4SigVHFRc+VSTjeEzI8CMLUE5XourK6+gu
 vK7cpsu1CuTxKfqAkSvG6hS1q+p5BtPAN09gGm65wBOwOz4oiisWyEuCJIZN9JTonAwU5rCFJ4L
 7O19ThM6/MqzUbzHSTdiOFGwWTMaACJIPJZyqe5tDLzOVY8cBQWw5JsA66TJo6uD08wqRgEjafV
 IWeG9GdHr2I8GdnkfjkOVbE2w6k6x0Yn6nGiOYlrnR5rYJBBDekTgp+0Y3sj+gWUBx5x5GRoh5M
 EInXkEhhoSPHvbsCK+g==
X-Proofpoint-ORIG-GUID: PCjx04BE8WsWXXQRo9-4tNADwfu8QpOc
X-Authority-Analysis: v=2.4 cv=Ccs4Irrl c=1 sm=1 tr=0 ts=6a6331d4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=ioiO9UdyrTe4zMvWdpoA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01

On 2026-07-21 at 13:48:15, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.
>

https://sashiko.dev/#/patchset/20260721081824.1430607-1-rkannoth%40marvell.com reports
critical bugs. will address them in v5.

pw-bot: changes-requested
