Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C463B9D86;
	Mon,  7 Sep 2026 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778929; cv=none; b=bUNeKfde08I+NJrf9aEZHzL0VEx/lgSq1XvfUlYnD+Uta3NmLHxh/8yxqwZYlfuTFyR7XJsRkp9YlxwIaOz5IIj9FvzzhlZFs7IeB0yTVNveVqqKMJtaYyL/OVlDKxhoIlFWZ/hf9ZpNh7can9HMx02G+SLmjGTdxjzlQARAqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778929; c=relaxed/simple;
	bh=3C84IEMFAiiWfWQ9rsDQ9T4zHS6EtLuWEEHMX862IJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma0KuobrOjtvFHG/LGN3zYuU4ZaT09VeyoYf/og8O1LHg3dCJBYy2c67gIlv8Qbqx9j/Ex99tnHhPhKPzuAVx/vqOBdLzNgK1gIIFZAijuDXWTfjz6XEpY8NFHrexwZou/ylUAtont07LIutdB2boS3ziuZtvThEGiag8YtKzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IsCs3eAR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IsCs3eAR"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Ap5uh2654431;
	Mon, 7 Sep 2026 04:01:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=W4R0+d+WUbd6nGaO245VWULp6
	Ck4ivLU3Nq5ngnHZCY=; b=IsCs3eARAPTiMtO6amGrfatUDqa8qketK+EX/YIAK
	9Wk/NR8I8ucWVHGhDLzxJyFKpqqC1PYOUOb8AZpMSUDzTvpvIIWNLaiE9hi+YR5u
	ssHuZWOroopLL7yNAg25hwH4irtYQjZlxsSS1kNnacvnggB8hRWSN5Zn23j9uJIq
	l5om0l5YOFAP03pE6RKQZ0DSmacjiZ+UWRqiIvWQ8bAu/XBWjjn1P4TxvYSB9KDe
	z1GImr3rjaA2U4Fct5uzU9hFcPs0e3DCuxkorHNg/dERFh/kO2Qpmr6Maupnjvdg
	/6a2PTUHLv+EKPKfw7JtHXnfPlZAr7BZnArQ5Qqsv+L0g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ghupy81y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 04:01:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 04:01:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 04:01:54 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C290F3F704D;
	Mon,  7 Sep 2026 04:01:51 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:31:45 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <ap6ZmZ4SwFa4Xf4_@rkannoth-OptiPlex-7090>
References: <20260907042827.4077114-1-rkannoth@marvell.com>
 <20260907072315.GG13683@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907072315.GG13683@unreal>
X-Authority-Analysis: v=2.4 cv=AYyB2XXG c=1 sm=1 tr=0 ts=6a9e99a4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=-yquJuTKTeUr1aoEfloA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyMSBTYWx0ZWRfX2+2BGVNUvRP0
 EOhZjw4YnyvcLeCMzA/2dZPNNNhixFQk6lWvr8UgjYjsqkN09PBV0LDpUdg4aq1iib7A8w3PyTZ
 algoWZeRjZXMP7Ugfd4fq+zk8boJr2i9HVeC1bq8dtfyJZQy8/SfizxtU258+eVjA1QiaIN6LCn
 8fJw25j/H0FTaR+M9MXntr9vrzZYoaVIWhm9XaPpoF19jSvrtMZ/gmTuzYlmF/BKkvVXP7oKow0
 j7r9zQ5++8rE5BEZW18YtYZ6356zl8KF8Oqxka8QSRE3oMqBwd0qrlVJYpPv99/LfpGgL+Hie1h
 Ze9ENEjlOnUm4VwJNK91oEdf2G1UEbZaiTGlbxjS+EYNAD7crc1Fxomcn7J/SKqZip+SBlyxm9d
 YCt2573J/Yu4+yrGSy9f4I98JpJmamTeUYKMmY3K24p5AJEvck9YkhM5Fro7+E/yxzV/4WDtXf8
 kcjqDfuaO7+HqwKOa/g==
X-Proofpoint-ORIG-GUID: toM_TnWfbVdUtfGK-sK5cO3lOLc702Jy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyMSBTYWx0ZWRfXxy+F58UpH5Wn
 KQ62sJCZmShm0wqT4C8pG+SPrPwi0au1xZHHjOF2k0ewZB4sJEsPeAhpsRhy26fB6JEWN8s2Nvc
 h8VK2w03apBdg9wEi9D+3sz/7w2WqUc=
X-Proofpoint-GUID: toM_TnWfbVdUtfGK-sK5cO3lOLc702Jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01

On 2026-09-07 at 12:53:15, Leon Romanovsky (leon@kernel.org) wrote:
> On Mon, Sep 07, 2026 at 09:58:27AM +0530, Ratheesh Kannoth wrote:
> > From: Hariprasad Kelam <hkelam@marvell.com>
> >
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > @@ -1231,6 +1231,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
> >  				OTX2_MODE_SUPPORTED, cmd);
> >  	otx2_get_fec_info(rsp->fwdata.supported_fec,
> >  			  OTX2_MODE_SUPPORTED, cmd);
> > +
> > +	cmd->base.port = (u8)rsp->fwdata.port;
>
> You should declare identical fields with the same type and avoid silently
> casting variables.
>
> Thanks
You are suggesting to split rsp->fwdata.port to  u8 port + 7-byte pad ?
Currently FW is writing as 64bit.

>
> >  	return 0;
> >  }
> >
> > --
> > 2.43.0
> >
> >
