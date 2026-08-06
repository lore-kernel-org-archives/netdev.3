Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C903E8660;
	Thu,  6 Aug 2026 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009489; cv=none; b=LuWFbkB7l6oeNviGXsfjGX2ANJ4GeU++gvKB7TGc+RbjZ9QCbFvlK5dyC6Z9i2Xg+UF40pRtBAeoSyLcvstGcgGZy54IMe2k+G4+ADAkDR9I7U1LjLs06oHVxQq9ZCHwxdBZXo2unZ5ULtoaqyCdywxmPo/lFUkDb8o1rqbXByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009489; c=relaxed/simple;
	bh=1g913kg3VDFCPxZHRvw9MXE+SbyprlAvk5Y9s7zuczU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoR8fsUCGDoBwIZmshjYrh0Jqowd1sPcG4GB9fi4sBokE9/R2OxjaBfsTkM9YCwubjfaJZroq8EQ2FvyMZa7VDvqMRX98Q+bktCtO5jMtlXoddNYqIJWIvu4uIvQClFesFQwngM+hLqkthIp0Paul8sWmWK2x2ucvmLAVv+g6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G9Vz1J+c; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G9Vz1J+c"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769YSwr3675997;
	Thu, 6 Aug 2026 02:44:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Y2IaUGdMe78onuq1psEYg9MZJ
	m8wxrmKybqYfCyL7RU=; b=G9Vz1J+cFiNJEWENVs/+GK4ITDXL4QBCOgBYgNG5X
	u5i9UhptBtK+Cl/jXXVTF/oXg824zYSLNWINV1K52crCM85tgxOU6fd22NqEVw3o
	liU4O9jV031AshBnv6GESkTf6IythCrqYbe3+oeAzY2zrcENKsbaGk8iE1eNl+SU
	8w4Mka91Brot+C6yldbMP6EbDddkC9R5RH10oiBmA/zIC4vB7xFtLNh2LFVCwB65
	09bcp3HL8uGw8rz+s7y/T/kSlbzRnxHqKM/+96lFtZ6cr2WRaq20z0NMLerZyGJ4
	BsiAwd2W7XH36a2vi0Gs2Y667O4XVcxpNLgmue2WKbrcQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fvqrqg0uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 02:44:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Aug 2026 02:44:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Aug 2026 02:44:24 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8457F5B6923;
	Thu,  6 Aug 2026 02:44:21 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:14:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v4 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <anRXdN4PAYOIS3fX@rkannoth-OptiPlex-7090>
References: <20260803042724.3380209-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803042724.3380209-1-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: u1lNrbwq2ZMS6GFXnl_cAwG6LH3e1vS1
X-Authority-Analysis: v=2.4 cv=KdnidwYD c=1 sm=1 tr=0 ts=6a745779 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=qZa0puetT2X_V2HpRBgA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3NSBTYWx0ZWRfX4feGCDkpdWZw
 Vs0MB7LqAxu5ZWZHUqGaxLrBc/SlKS1ZaXM8nhGcOA44+9gE+DHxVKN2K9jKtUy9srcbs+WTlQN
 LOMgS5++KaxcG7E8Rx9Rx9LAmH46Q6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3NSBTYWx0ZWRfX+xVs7gcVSLFl
 P2+LbkYhYslkwmsBLiN+lpBRR0fMmxJiQVwR3oFq1FtqcjzHaaoUwKzOdVbkLcwPISWdQgnKjpe
 QMAaiLaHJJTMeLrt2zDTKyEKiydlHoJJcuuG+U+d2QyhKru3JWxk3hR+ZDdSgJjlIzj0GmK/XI1
 Rc/X5JlEBsIHg8UyYZomAa3ab/zq6poGc3bwAuIzBVg4TV5q+aXyL6oxZvrmsNRNsRHRe4JNZE4
 d57+pqgU8w4ojv6qz8t8quHXlc1K7j72JntjyebesBhagPCVFdXR6hZ/1arvM7YyrhBR+6TlLWk
 /StZ0A3nA2pj0erqry2b2dmZHNMwVNGeMN4tHgYJ0C/l+CXVioRpNPuUdNxtFDUOa9sy6iVQJSf
 o13MRhrnRPVberaC/CxVaWwsOGRbGoOLvd+5rz6BIHcyffEcqyG64iAyPs398b+/zpRP2GSaYF9
 2ZVzxrIjlsKbLwMwlsg==
X-Proofpoint-GUID: u1lNrbwq2ZMS6GFXnl_cAwG6LH3e1vS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01

On 2026-08-03 at 09:57:24, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO handling to program per-queue MDQ CIR/PIR
> shaping after mqprio channel mode setup, widen SMQ allocation when
> per-queue rate limiting is enabled, and align MDQ parents under that
> mode. Reuse otx2_convert_rate for bps-to-Mbps, fix sparse register
> writes when only one of min/max is set, and improve AF txschq map
> mismatch diagnostics.
>
> Configuration examples:
>
> 1) Set up commands
>
> a. ifconfig eth0 xx.xx.xx.xx up
> b. tc qdisc add dev eth0 parent root handle 100 mqprio num_tc 4 \
>    map 0 1 2 3  queues 1@0 1@1 1@2 1@3  hw 1 mode channel shaper \
>    bw_rlimit \
>    min_rate 100Mbit 200Mbit 300Mbit 400Mbit \
>    max_rate 150Mbit 250Mbit 350Mbit 450Mbit
>
> c. iptables -t mangle -A POSTROUTING -p udp -j CLASSIFY --set-class 0:1
>
> This will guarantee max rate as 250Mbits for UDP traffic
>
> 2) Tear down mqprio
>
> a. ifconfig eth0 up
> b. tc qdisc del dev eth0 root
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko comments in v5

pw-bot: changes-requested
