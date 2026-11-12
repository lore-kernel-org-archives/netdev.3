Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448910;
	b=V/ErikzHey4Qnk6Ip3CdxXJ0iMHqmmdHfwrK8i09bebldX1d5pgVySI+hFtN+TnVUlp6
	 /i4H5zxG8/aY3j8Czq2e005uT5x1J6xiugPMNJcKbWKxFdtLHmrr3q90XUHSjPiCqlBU+
	 q9Fhx0Seg2QIosJZr6W0WVz8uPlwgmTeAqfrNXzqdaKIj/Y0JSI73nQNQg/3OELSxj6n7
	 VJ77vgu2dQy4lDlng9U2Qu9gJRZhVn5/jGBy5tUYfpSM2nrp3dqJ/CwvTiu6RIi4+7KHp
	 6o0s1kI/bMYYq7qT4qJDEfexJG5jW+cpSOMJH63R99Rox+l4N4elqCdYhWWNGy49LDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448910;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=yejiSJr1RmeFBO17pz04tWa9xnnbp6CMGeCnpHqOQ/g=;
	b=QxB+2i5r0NHpUoyqhL6+WoYgdoXiqhJrCux594pZqolZkechg6x9W5g7tDZGS5xegJtW
	 1dm3uj31fWfeqVUUYpqob648XSRArpaDFjNvS+d5fbs4t7u8UOZ5tKfsk9WrciuF5FXkz
	 XHfFwczxJa2bu5nAAAqA0cEc5XiLV+a5bhCEDSv8DmDmtyyxmmqT2/S69EmDibKpjGi1O
	 duU06qBiuNTRMX5NGrnKFSRXJWyQtElNIX6kM+Eg03EUWY5paWKVBB/IBrSL6E0hfqOz6
	 Mg0sV+SRERrHvznEsla1EvRZILljNcYwbmp/FU6KTjnABNkNNIY/eH9kt7O/EEqxvhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=g1kfmGSx;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB3606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=g1kfmGSx
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABNPmKW1486999;
	Wed, 11 Nov 2026 18:01:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yejiSJr1RmeFBO17pz04tWa9x
	nnbp6CMGeCnpHqOQ/g=; b=g1kfmGSxWuBn/rdlG3h7Z66mxnc4mWCtPjcsls17S
	ey0AQ/mMrjIY509vd2Wbeqmqjo66wR9EocUb6mOsCBuX1kHzZ251BHLlcpuvxhJ6
	Q7142SdlknC9f0lFfUOBj47NVAjJs+MVJ0u0EGkS5BrCFLKKF9dD9y4OSPCPXvgq
	tdAoLisxHCZjXBu3oBy8Zj6h7LWz2843gDCOUqzs3wE6zMu0ofpxHJi3Q2jmvcBD
	KVEqS/YDOVeNCMMH77mkhcRSXOxDRF7n83POsKqm9f+R3N2InwbdU/Omb1vJrAU/
	AAQ8K3KeKTGNEO4Z7E61RBfWQ9fpGyzqfSiZoyio8E4SA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hw15urt92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 18:01:45 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Nov 2026 18:01:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 11 Nov 2026 18:01:42 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 913F35B694A;
	Wed, 11 Nov 2026 18:01:42 -0800 (PST)
Date: Thu, 12 Nov 2026 07:31:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] octeontx2-af: reject an out of range MCAM
 counter on CN20K
Message-ID: <avUeBeQSLwNvjwRY@rkannoth-OptiPlex-7090>
References: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
 <179438966513.1752948.9405325090310502892@mails.ucas.ac.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179438966513.1752948.9405325090310502892@mails.ucas.ac.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNyBTYWx0ZWRfX/UErxG7W94mZ
 9sK7JhjsDkQMgKIEadub+6XnGOTNt6H3uvFjt8nSKoVU4zekvHvyEbC52TMBNlvA2iTSKw5NiiP
 mX1k5a1Em4Yi+OjeNxZxVQxIgfwPBhs=
X-Authority-Analysis: v=2.4 cv=Mev5KJ/f c=1 sm=1 tr=0 ts=6af51e09 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=spZFx2Df69eDOfArnIAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Xq186PKnteZjqrD3xG_6N0L1QGqK6ltw
X-Proofpoint-ORIG-GUID: Xq186PKnteZjqrD3xG_6N0L1QGqK6ltw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNyBTYWx0ZWRfX3+z2k3tKN+qU
 UuyBY7/nYAzeG7Zru3Kb5Kvkea4yoPPbRLLkNswUOf0EtDfNSOJBEjGY8ast7bvDJTi6DLmpOev
 sp4ZTEDL3FZECMYLnAzf+Tz52pmt+YuaW8cFv18knUyEqDhGarhrNUD+pSYBX6Ar2rUEebdCXoM
 FYweh3q77pLjvKfbNNZmi2XD9Q+4pI4Mc6SS4fR6qo/uAklvEDT4nHFo/un8VluFG1HxGonvu4c
 7m/C8cMcIv3daRI3czN2Pc8AZQYXD16IpMyJQgphemq9Uhy9CCoCxTdoJYjc6Pmp2FBu/84i/RI
 V1kwYpjrcC7H9fMBLEsEmFhOjYAshKPdubEp9BxmK18Q+Eb4KFozVRJmcobdmdsit1zrt3RlmK+
 vaZ1gBTlGp9Bt66O5FfCf85fJpnpZiNVQRXqw497kGQssWHKBmVcCHCRGreAOCrl4INj+xfBgu+
 jhm6lgy4SFS7ygCnzNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01

On 2026-11-11 at 15:04:25, Yicheng Zhong (zhongyicheng241@mails.ucas.ac.cn) wrote:
> The CN20K branch of rvu_mbox_handler_npc_mcam_counter_stats() derives the
> bank and the register offset from the counter argument without checking it
> against the table, unlike the path the other silicons take.  With a counter
> past mcam->total_entries the bank number selects a bank that does not exist,
> so the register offset leaves the NPC block and the caller reads a register
> of a neighbouring block.
>
> Bound the counter to the table before deriving bank and index, which keeps
> the access inside the block; an ownership check would need the caller to be
> compared against the MCAM entry owner and is not added here.
>
> Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
> Signed-off-by: Yicheng Zhong <zhongyicheng2025@iscas.ac.cn>
> Signed-off-by: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 42a601976db..be8e3518e7b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -4015,6 +4015,13 @@ int rvu_mbox_handler_npc_mcam_counter_stats(struct rvu *rvu,
>  	 * has its own counter. No need to verify the counter index.
>  	 */
>  	if (is_cn20k(rvu->pdev)) {
> +		/* cntr is an MCAM entry index on CN20K.  An index past the
> +		 * table would derive a bank that does not exist and take the
> +		 * register offset out of the NPC block.
> +		 */
> +		if (req->cntr >= mcam->total_entries)
> +			return NPC_MCAM_INVALID_REQ;
> +
>  		index = req->cntr & (mcam->banksize - 1);
>  		bank = npc_get_bank(mcam, req->cntr);
>  		regval = rvu_read64(rvu, blkaddr,

npc_mcam_verify_counter() does the job. May be we should move that call up
to validate for all SoCs (!cn20k and cn20k) ?
