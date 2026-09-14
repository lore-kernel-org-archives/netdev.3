Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D92D8DC4;
	Mon, 14 Sep 2026 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355124; cv=none; b=nfkkqTVpIOS2Zrz5PD4r52ziqMibghDzCE2qSKsQRmkFJc0ERxuyLfDTtJlPGsLgFxtyQhcxu8eHVlRG1/EYM1Hpn3geDBD121NO+BkooUNhYAfCGsIhFgd+AWOk/0hslvsLkTpnDxv0ltAAZNVi75f4WNeTQ4FipePJmXW7QmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355124; c=relaxed/simple;
	bh=TYZ6Qrn+yCC44PN+vNUht3tOMu0avO4/eAXCZGS6uqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvnOkp3HLd7XLGOrHBDuXTtd+O5vH0g/lj18xBT2EduzRu+/r1A8MVVpHCkOeiT7Jd14/JnkAH3nMPGQ+RWkpzH/+RdUaKVgtX1/teJ0hN/TxgczZ986FZW4ZbhljQvt63SpbYuAQIXsT1d+ceZkwlrvBmHlfhEhki/hU8ge0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hbn6XJQm; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hbn6XJQm"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E335t83686445;
	Sun, 13 Sep 2026 20:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XkuO7G4VfPHhKUr33CjXc3Avn
	860LNSramqQW62iq10=; b=hbn6XJQm5Pz9iD4IhFGiycE2SCTGiOHoS+93NDYvZ
	bMhEQtiNa1hCrkQJks5VnMEzNsTbUU2nHuOYMWp68sAD9o3NzKEfIP4agtPcYA7Y
	b4/TpxCMsLOU0XvfMVlfRlx5KuBtc4cPmSFZMcYrYMj2X9Uwe+MCO+BrqNOOrbTn
	QwXUG91jYT8cmQvNDJ1PcPljzDquktVpjO2TRAflw0diLwOz8eQkwrj9aBazVuqK
	RKo/YzMEfiAC+o0Ks5jWsIYhMqEAYnFn+Qhw1hJxMsigwyduuwEUD9VaQhLr0ASv
	9mrms3qGgeGay1E/MdWQn1d8AvF+H7a3W5qZrnl+cKNYQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gp7vyg2p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 20:05:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Sep 2026 20:05:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 13 Sep 2026 20:05:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 038C53F706F;
	Sun, 13 Sep 2026 20:04:56 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:34:50 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-af: skip absent MCS blocks in PTP
 configuration
Message-ID: <aqdkUkM13I_0VSrK@rkannoth-OptiPlex-7090>
References: <20260913125212.110005-1-bolin.liu@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260913125212.110005-1-bolin.liu@seu.edu.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA0MCBTYWx0ZWRfXznLJD7J3z37E
 /gs9MN4tcNkQiHiBgPZH/2X9txzv+Gi9X1T+OaI7okgwIttqJooIAPkmpNiQqVdy2mnIPq0jQ3/
 Vj5+XNvBL2NJRdJjqm1P/GNFYpsVg5Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA0MCBTYWx0ZWRfX4yoTsh+WKqdj
 +Ond3anwsNih9/ZVHWPG+ZkXL+mOOwKPbVWk/n8MIPg+opzkpnLndhxSLfANtXf2/vt8RvwdRAo
 QgFNP1PcGpF+TJxoYL8MUdEJxMYfX97CKo2WrtWMZC9fVRsgggkNfuhSxT1+ynfhgrV7WSB66rj
 Zpo0NEuamg0OaCSRyXzpdxL9ZW04bGngKuSHxuA/41Thqcn8xEuRPAHx8zSFNiv2oaROHTIicUW
 TD4AQ8uMxKqwYqbQOXG4cZYbNcAY16zZUJL7fOI6M2UAEnk0vpFdVgS2Rt9yvGSws+W4s9JkH9j
 nKh7V2v+vcrvhcz9PnzqGMWrPNi7bhh/fNT1C6Ik2uPYIREHfWVqnOBnYnEe9tqlta16KpwWZz+
 g+lpYl00U83PIUlylVbzEuWCqNC1bwDfsGXZBVT0kDYJ6/RftbrS7kQ94ztJOTwEcIPYsVJiIQm
 iC4WcpsR5FkiyA1WtUA==
X-Authority-Analysis: v=2.4 cv=a/ulZkSF c=1 sm=1 tr=0 ts=6aa7645e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=mGoJRa1uc5saEmWCy-4A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=4Pbm1F1Cy1QVNLGpYn_S:22
X-Proofpoint-GUID: R3ePHcqIHKO-AUZ8fRj9DxYEVg3Cq8Bb
X-Proofpoint-ORIG-GUID: R3ePHcqIHKO-AUZ8fRj9DxYEVg3Cq8Bb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01

On 2026-09-13 at 18:22:12, Slavin Liu (bolin.liu@seu.edu.cn) wrote:
> A successfully probed RPM does not imply a matching MCS block.
> Check the independent MCS lookup before accessing PEX registers.
>
> Detected by static analysis and reviewed with AI-assisted source auditing.
>
> Fixes: 65cdc2b637a5 ("octeontx2-af: mcs: Config parser to skip 8B header")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> index fce22e314cac..5e24d43d5fc7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> @@ -50,6 +50,8 @@ void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena)
>  	/* CNF10K-B */
>  	if (rvu->mcs_blk_cnt > 1) {
>  		mcs = mcs_get_pdata(rpm_id);
> +		if (!mcs)
> +			return;
>  		cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION);
>  		if (ena)
>  			cfg |= BIT_ULL(lmac_id);

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
