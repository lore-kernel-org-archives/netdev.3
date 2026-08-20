Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1D239085;
	Thu, 20 Aug 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787200543; cv=none; b=lBjEG40uP2cxruKbTiBidX26BeaiIhEFR0t48lRAARLp2+L+Ide6Uqqc6C+LbreDpe2qGeh6U5T+UEQRj9rFLrIvQzHVOCq6rQmEtfhrJohmhWEPFvsZame+AZWDlZgD/bOm4O2POzDtVSL8KPpRM8DtZtOsEhG72/0AJFtubAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787200543; c=relaxed/simple;
	bh=1mAC0XozXQ4a0QaSwBcOjStI8s97xXRpX+5budkuvF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8UbqLiAYumYaDe0JKXFSF8nBbiFjk+CKNhQ9lbbltQCCrpCro2YWbuhPYc/05xuu9TQ1kM4xa/TwHy2XJEDB9GG9p8yuTz7fTW58ZO9xmOCyAiNUFoKQrOfkGSnthRR1itPabQ7ku1+0Ez55HonHGVwMe/y06b2VpKvGtFeTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A85UNoKp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A85UNoKp"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JM8H6F527677;
	Wed, 19 Aug 2026 21:35:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=1mAC0XozXQ4a0QaSwBcOjStI8
	s97xXRpX+5budkuvF8=; b=A85UNoKpHoUhzzP3r2Bx9A+gPboNwm9yHD9xAi+3l
	VPyYPd+uzUazGEiL0UNKapqyaZbK9CbfYeIAF13P9xyRx+8rDHgTcfFpTalFOiuW
	hPW18V8LTUmCYOuJyuJ4C8f2t+1ixJRVxf3qFgY2psK8NztkX2jnwIdTOr524hyz
	nVC61OEbMlZI763KGrxvctoHTEtlTQBwdKvkjR4nO9OzisY5wghgymkmLUEZ47st
	DBz+VyEH60TZjlQKejH7LUnYYcVi9mVculkWOs1f6BoT3GduZNKWvD9dLNfSUuE2
	bMKwUouVnLvt7sVI/KjPyABO089QWtu7jdPa/888vrBpQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yeve6y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 21:35:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 21:35:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 21:35:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 264563F707E;
	Wed, 19 Aug 2026 21:35:16 -0700 (PDT)
Date: Thu, 20 Aug 2026 10:05:16 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <hkalra@marvell.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <saikrishnag@marvell.com>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net] octeontx2: fix PTP RX enable mbox failure on VF
Message-ID: <aoaEBGetKxYcHHpB@rkannoth-OptiPlex-7090>
References: <20260818034728.2047614-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260818034728.2047614-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzMCBTYWx0ZWRfX8ryiCqcYUlDt
 R6361SjBbjELAkFQ5TJ6kzP/PGPRXdl1EmgaiBpGhXaoofq7bCjijfn0WZJcNZgnmbm7dD98ulw
 09NCxMl2dU9/TFyvkY+uhUmC4egbV8A=
X-Proofpoint-GUID: X5g6hM2Y5gtOg5aJY-t77GqyRkvHrGU_
X-Proofpoint-ORIG-GUID: X5g6hM2Y5gtOg5aJY-t77GqyRkvHrGU_
X-Authority-Analysis: v=2.4 cv=Wq8b99fv c=1 sm=1 tr=0 ts=6a868409 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=yuX_TPEG8QTjFcDWbsMA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzMCBTYWx0ZWRfX6ESOAk4QnXNK
 Zl4OcetKMgE5OhxCBxXbqTGsscC3BNQceLXW2L4mqAkMV38FymtlX6btY/YFeigkzIwTTIA9UW+
 GY7GwzpBjvc/OzYIEIor/4U8B55WrMWTwkwZzK+eCi0iRj4rXW7l8GNPp+1vDLqHpaaEKbUqqkK
 XgbgVB1+J8mJ4BJF82croI2TCORxB3H3ZvBX6ynQt60nYu9h0aBbq9adiAa/MIwQdnVh4LzmcAo
 XWXjKUHErUqKOey24WE+quj4mgypHVGurXga+LvkmNZLQA+CfBl6NMwKa5lPfn/JGvdnnT2Iu68
 UXpckuPt0/6LASsgRcXZvgVo31v6kreo25HnWfrE+7aGdbys8T56266om63LVCphjQuCfM+09gB
 iWRORLQ3hxdALMBcQYN5bF4gk/H1w2E9El3c9h3yzCb8YWuP+iKaZkedXMyRw6wS3Qy+1j5J8pb
 AhokbS2KvR1VExfpn3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

On 2026-08-18 at 09:17:28, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Sai Krishna <saikrishnag@marvell.com>
>
> When a VF enables PTP RX timestamping, the AF must notify the parent PF
> so it can adjust its RX data offset before CGX prepends the 8-byte
> timestamp header. Use the correct upcall mailbox pattern (wait for zero,
> then msg_send_up) instead of msg_send/wait_for_rsp, which causes the
> mbox to fail on VF.
>
> Add the CGX_PTP_RX_INFO upcall message and PF/VF handlers to propagate
> the PTP enable state to VFs.
>
> Fixes: 30e7ecb6441d ("octeontx2-af: Support for PTP notification to PF")
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko and "verify_fixes - FAILED" in V2

pw-bot: changes-requested
