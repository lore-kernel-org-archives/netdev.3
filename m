Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262A156661;
	Mon, 10 Aug 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786333494; cv=none; b=SdyqEFNx8yiNaCshllRs1dVFGEwB/QD48MSmd4IDDWNJ6ldGSv84mcD4vjOzZupwe9F9KQYLHpPWH79JCyAmBC6mbPPsPlvwPIO+Oykf9AsuGzZfHlGMMkYEtWKfUMVBqx5XuefzbHfPrkljEhbHM49AVyNRPJdAY7pB6U8Id3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786333494; c=relaxed/simple;
	bh=tx3iLemcVxUK2fGKasiAZTeE5f9dX3ymYMGh3wU3ntE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRvbbDqkfwoObQCpnSY7abdLO9aQs3KBTc8j6LOTZ0XYCCXHvPNfxwHUgj+uf7VhA9RCQiJgNBsBihyPjoaK93/hbcR+hpps7GW3j1OY/iK3VcGcQOkKcpLicCzApaHh4EKWKk4Pui0S7lIAj1aCuzZzjwoLSGFz5NUzD403jUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NTEoqP8G; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NTEoqP8G"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A1j9r73659807;
	Sun, 9 Aug 2026 20:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=LkJtI1V+M/f826lt1z7brNsCC
	6kt9oo8+IAiLUZDBjA=; b=NTEoqP8GzNNgVw/9ODfYzxjvLd8AvsE+3rMsfGctR
	NRDPClFM2kjqARwN5hu3LHH8vg14B8WZp00e1nXA8itRRbPBroM7yTv3FFMZVWWU
	AT2yCoC1GwDXb29iEhkuecAIfcSjFqv0dYT+14nvecWLo6WogBP9Hv9Np+7D1hq1
	Y9ewpuiGGnkQzUhWsIonREEnTfJx3I8vXDftKO4oH7xaZnbj53l+lTccpyt1r0LU
	sVAp6yLqlyf/4hEUu6imY07l8zYJ8OBLdMVWjZtyHLcBIBqGUQumgTh8eaQCJfwS
	xSJwfJIZ3vYlqnEetWHKsZQaD+rO6Mkqlh39zPurlGUPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fx3yjaxtt-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 20:44:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 9 Aug 2026 20:44:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 9 Aug 2026 20:44:28 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 37BB35B693B;
	Sun,  9 Aug 2026 20:44:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:14:24 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v5 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <anlJGID_6IBlTFau@rkannoth-OptiPlex-7090>
References: <20260806095434.1144397-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806095434.1144397-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyNyBTYWx0ZWRfX/9jUccExi/9e
 ayDu4tylbbq951A7TMdyT6MnjM5rV8rkKa2TsVNkYmV75kuOS5/YREKkuo8RwcMskC6gacNaeym
 dPfYuxe4HyRWLYTCdTybddyjpVeE6YcjZTRLGB7HayT6nIy3H68u8FO1C0pHFu9CzSgbES+/D1e
 sfDr9DfMMBpB3qjIgKQtOffbcD7O0yYWr5K2kWuEebONWNRuE66LpyifVxMzK/SnzRIiBB/oQgY
 5JIq0Lmqk3kJsBAFR651JprFjrA11CvKH5w2lbwztoKubqy87s5T2x4veDVLoM2ZDtN8Eiw/lWX
 LqN6UF0g3GIrgvM/4pFyZjB9Kl8Tul7VbkoLGooK729rWfkKLfaxqKHkX0zglRkJprEnnakAJbl
 fBbwnCrOPwQNeSXIgr0wtcr115CI2+u4ek77DaRx7IwR2dELmSusZ7uFTMMWMOQPYW9B432AzIg
 IUSbND1ZALJT9JDiBig==
X-Authority-Analysis: v=2.4 cv=cOfQdFeN c=1 sm=1 tr=0 ts=6a79491f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=qZa0puetT2X_V2HpRBgA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: B9IsjwvDW8w6aWXeAZuZo4FO7hRVhmxN
X-Proofpoint-ORIG-GUID: B9IsjwvDW8w6aWXeAZuZo4FO7hRVhmxN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyNyBTYWx0ZWRfX+vpSlgGmNPGD
 JI5KvkAAy24MCaH934HWH5e9Ypnhv2GzObGZoZ/aYtkjpcquhdSgQN1PuRRLO0lCmgIn3myeBnn
 cCebVHX15HqfTXfnbUAyMNpSVL6+s5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01

On 2026-08-06 at 15:24:34, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

Will address sashiko issues in v6

pw-bot: changes-requested
