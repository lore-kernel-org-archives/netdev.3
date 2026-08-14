Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44037347532;
	Fri, 14 Aug 2026 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697671; cv=none; b=Yr7jrMB5KeAgTZUtMR5Z0cyToNwYheU+E3m6RzMf38Zub4Lj9H01M8gdwgAtW2SFhHbayfl0LnfpRLRXG4WsYZn79yYQ2LLrXj15VRvErG7JmxVEfd01xbxsk99UAjLQfqDhi1SmHYMIy8hNUzdYUhyp4y6/YlZvCPb/Z6w+7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697671; c=relaxed/simple;
	bh=f2Hay731TBpLSejaGbrqZ60b/Rfn74ILpvsWkdPbCZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlEXOb4JwAOjBT2woWuAq4YqbBNajiWkFA7SupOHD91Co5/7Ln2TSDsbFHAM7/j751lY19hDA8MGhQ1WkaU7hcyCgFXPDPYrYpdV/67Cfngh61ic56giWDqWakpYWEPg2MvH/UmUIt3qolB24FWVKi+PxpW4pGIYJEkOHtqfhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JLEiQrh7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JLEiQrh7"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7fvbq2932840;
	Fri, 14 Aug 2026 01:54:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rO1q8eq4A8PGUAq5NiL5o2aM5
	c/CI+fZuBn3gEPConE=; b=JLEiQrh7Xq8j6sJDrTjWGJ+VfF8y5r3Han7cpVDd6
	bPG8HyDNAnnAo6yDqAkMVW6SNVx/z6KAMj+4Nbj8fASZ9m/XOoSGYRrTXOYOszod
	4yGWnkHoEmD8DyFIr+ykbIua+4CBhv2Yx/F7qPNxvIRdNihUxocZ02hqGkvcvXwL
	JQbY0XZUBm0QOufLOrzXYKV4tHUYCifxui0dI92exXG93OVYN6+Xks8UBkJhfwnE
	1u1ZH0eygRoz8pjQqFMR4QCYCiUXae9V6sNMtPK5n2Ccp9OdjEe4iSk/6WmyKMu0
	FhvMS3HH6tJOlCN2Fxiggy80TGkbJ9NncO3q1pgjdzdfw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g0v4xej7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 01:54:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 14 Aug 2026 01:54:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 14 Aug 2026 01:54:05 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A37AB3F7083;
	Fri, 14 Aug 2026 01:54:02 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:24:01 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v8 net-next 0/9] Switch support
Message-ID: <an7XqecYwqm8DQCm@rkannoth-OptiPlex-7090>
References: <20260811085406.3227312-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811085406.3227312-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NyBTYWx0ZWRfXzgzmOsi28gag
 m9lUWOCRoj1l+y7KxkKYfHMpvQdge6VFiV8+4v7pupm5X8TdHzUXmnuL6dNt8WY+HV1UKOCHGyJ
 BEMATyWFYmYd65nqbLLn/+a+/9GcNp/kjLAOn8/HtnhsRG1wStv4N7+JNMu6K9IDv/zA9qh0TR3
 j4O/JMJ6Fr3KZB7N21HNFe0kqUC3HqE5lbFDLPYo1lcU6+HQzbZNNR7CcS7rocjEAPum57jquRK
 K+S4pWlSW3QGkd0XH2bKSQ2pNDji2kxtSW3bzl9agpAt9nU0w5fLq2sVbx0RpA2CG3jIBT4oqe4
 Mv8o7O/ORGXGl6FgYA8JL+PYt+rI0xs+FHcFTNc4WEXyLv/uOnwkUpnkq34klGcaSpJF6GK514h
 tMJuSpbNr8AaOe25dHuaQy4w/bsqqz8BoEthB8YYHKViyZLiqTKXmeMJtmpgOk895/w0aeK/JBc
 M0BlMTx6cVtbSKgcX9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NyBTYWx0ZWRfX9Ca6oXevNr2/
 /k2uQ26ljSEqSZdAF14IcRJOEvXtwrk8fQl5GeSaABSI/Xrs1DsOiCVHqYzXcxXnF2pOsyyRA7H
 rQQPXt5l923KR/OvweuiEq0SmmAyjPg=
X-Proofpoint-ORIG-GUID: eOa2VwUXUirXVMcdLs2zJTR_KKrqG3P-
X-Authority-Analysis: v=2.4 cv=B/yJFutM c=1 sm=1 tr=0 ts=6a7ed7ae cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=BHaesAMrB6GiR3SZK3sA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: eOa2VwUXUirXVMcdLs2zJTR_KKrqG3P-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01

On 2026-08-11 at 14:23:57, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.
>
> This patch series implements communication from the host OS to the switch
> hardware and vice versa.
>
>                  control plane (FDB / FIB / flow over mailbox)
>     +---------------------------------------------------------------------+
>     |                               HOST OS                               |
>     |                                                                     |
>     | +------------+  +---------------------+  +---------------+          |
>     | | bridge /   |  | PF + notifiers      |  | TC / flower   |          |
>     | | routing    |  | (FDB, FIB, flow)    |  | offload       |          |
>     | +------+-----+  +-----------+---------+  +-------+-------+          |
>     |        ^                     |                      |               |
>     |        | slow path           |                      |               |
>     |        | (unmatched pkts)    v                      v               |
>     | +------+------+       +------+------+        +------+------+        |
>     | | rep-eth0    |       | PF / VF     | <----> | RVU AF      |        |
>     | +------+------+       +-------------+        +------+------+        |
>     |        |                                                |           |
>     | +------+------+                                         |           |
>     | | rep-eth1    |                                         |           |
>     | +-------------+                                         |           |
>     |        | slow path (miss / control to host stack)       |           |
>     +---------------------------------------------------------------------+
>     |      |                                         |                    |
>     |      |              mailbox / PCIe             |                    |
>     |      v                                         v                    |
>     +---------------------------------------------------------------------+
>     |                           SWITCH HARDWARE                           |
>     |                                                                     |
>     |      +---------------------------------------------------+          |
>     |      | L2 tables   | L3 tables   | flow TCAM (HW)        |          |
>     |      +-------+-------------+---------------+-------------+          |
>     |              |       fast path (HW)           |                     |
>     |              v                                v                     |
>     |           lport0  <========================>  lport1                |
>     |             HW forwarding between ports                             |
>     |                                                                     |
>     | slow path (miss): packets raised to host via representors           |
>     +---------------------------------------------------------------------+
>
> When representors are created, corresponding logical ports are created in
> switchdev. Matching traffic is accelerated in switch hardware using
> installed L2, L3, and flow rules. Packets that do not match offloaded
> state, or that require software handling, take the slow path through
> representors and the host networking stack. Control updates from the host
> (FDB, FIB, TC flower) are sent to the AF over mailbox and programmed into
> switch hardware tables.

Will address sashiko issues in v9

pw-bot: changes-requested

>
