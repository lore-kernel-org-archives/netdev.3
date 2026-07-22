Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301C476CCF;
	Wed, 22 Jul 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706263; cv=none; b=pE2Ri/0WhC6mp0Uq4BHAPPKFD67pl5+W0EyybMvFRbB2xI9SW/WO3e3J+94YqXL/GFmKGE+XXm7unWsLxg1MjZKD20/f0Hfp3jjfzC0FckgNVjeM4qikrbRHV9dlv9Zd3/tLK+eGzQNTvhM1ZiwqMss5o4r78k/ICtkKub7Cpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706263; c=relaxed/simple;
	bh=OLvoN1Mn9QPbfCU6SRXtZN4vEWROQTCeANS8Ow158U0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EejhUawuTjWUSnGW68yVD7r8yPhRO74dkrmfpP7MPh/0JgDpuNbiW4oKaMxAe9QX83bOKXY7mKpNBf4rYn7qgXLD1m3VF4VshUlI795kx1C3fAHgNJfH7s05Wab5egrALKMxQNHxURzT8N3aZIE1EnhfztT8lQrZrEfib782+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZyZAVMtZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZyZAVMtZ"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M6BNJQ2154351;
	Wed, 22 Jul 2026 00:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=OJOgKYtpo/xP72wgYeiPgMfeH
	k9+0E4iQT+GsvLJPp4=; b=ZyZAVMtZBKoHKtXpp7cqKGMcXlW3UFo+3HWrbea+8
	PlOSNUQ73+NOmh7ayHRC/rgQRHDfFL2Eo4m1S6tpHSZ5azPlRou/waPBgKWPHi/P
	FmfWSV5yE97lKC9UOtsAwOyhx2IREYQoTO6dwIvx10ORzodKl7d4K3QkLx1bui5U
	a7FcQmGBZkJDTFxrU26g2RHxhtfC8ncq0J2kyB8hH0VvgXYbuNE4eh9bIrcnugo3
	1UzBoGgzHmqL3fnW9ndOsmrENmt9vaS+WKmqFLeu5cL90oB0Zv7MZ6w5OLRGxVnc
	e9xyv7Oe5S9/7mjr5j+yBzEWIepTfXRyKBFNbBQr0+v/Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fjjf88y5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 00:44:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 22 Jul 2026 00:44:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 22 Jul 2026 00:44:04 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9D8293F704B;
	Wed, 22 Jul 2026 00:44:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:14:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [PATCH v4 net] octeontx2-af: Block VFs from clobbering special
 CGX PKIND state
Message-ID: <amB0wMgK_DS0gIQM@rkannoth-OptiPlex-7090>
References: <20260721062907.784484-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721062907.784484-1-rkannoth@marvell.com>
X-Proofpoint-GUID: _oONuvFIS2VR9l6H10APTwIpnotpkA7v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MSBTYWx0ZWRfX2gU7jYRgX/zC
 OZJi9gdSv1qKr/OKgDWWyLjmC8ic4GhHCH6CGo1Fl3ukSBnLToui+yn8I/bljEzABTKKyr+xM2x
 vyOzH+wxWQWSRS4hXbndK1qd4/4Unrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MSBTYWx0ZWRfX2cxScrSXgGzP
 Wo2VeJPPWOT5Z00qsk3JoIq7FxBAkW3R2RnuKGztTqiss8gpj6hS9gcTWlE2qH2G6hUVDOX3jhn
 FvHaMU7rVPldEv8rveddCqAXYxJh537cB7bmEMxQx1O3B18pMpvfE6XODzCFF1ialfha4Yic956
 xQ23zK0mEJ0omoBxjnIP5YRfaeI+tPYFS/UG3gMW7wgZFqXUAeUXkYl0ZbKIkRAFw34hLsGguAr
 AeUas1lyuFaShRiMMJpugqCpmvyDVY550qP2uXBWOZS2gZWkYjgIUDs3k9ipLIvv5vKhCrJDfMd
 gb3v4G9xP9NTP7Ny3SvJjCHl6i5UE5L0iUaQ1lbM8zLjyXp1kKvJg4QJW5+zjDFIqJjZHSMtfpX
 eTQMHWzHywk32wsjgHM+g+AleKhsqshuG0/hJy4r16qWg31cK//Jb9FaqfgXGGJndh+lxkf6sYY
 og7xdglyt73/0gKQTBQ==
X-Authority-Analysis: v=2.4 cv=Rov16imK c=1 sm=1 tr=0 ts=6a6074c5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=dpa9XWMHoREF9cE-FFkA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: _oONuvFIS2VR9l6H10APTwIpnotpkA7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01

On 2026-07-21 at 11:59:06, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
>
> PF and VF NIX LFs that share a CGX LMAC reuse the same hardware PKIND
> programming. When HiGig2 or EDSA parsing is enabled, a VF NIX LF alloc must
> not reset the LMAC RX PKIND or default TX parse config over the PF setup.
>
> Add cgx_get_pkind() and rvu_cgx_is_pkind_config_permitted() so VFs skip
> cgx_set_pkind(), rvu_npc_set_pkind(), and NIX_AF_LFX_TX_PARSE_CFG updates
> when the LMAC is using NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND.
>
> Fixes: 94d942c5fb97 ("octeontx2-af: Config pkind for CGX mapped PFs")
> Cc: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260721062907.784484-1-rkannoth%40marvell.com wrote

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> index 6a0ce2665031d..d1de9c9894bdc 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>[ ... ]
>> @@ -1685,8 +1687,19 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
>>
>>  	/* Configure pkind for TX parse config */
>> -	cfg = NPC_TX_DEF_PKIND;
>> -	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
>> +
>> +	pf = rvu_get_pf(rvu->pdev, pcifunc);
>> +
>> +	if (is_pf_cgxmapped(rvu, pf)) {
>> +		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
>> +		cgxd = rvu_cgx_pdata(cgx_id, rvu);
>> +		mutex_lock(&cgxd->lock);
>> +		if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
>> +			cfg = NPC_TX_DEF_PKIND;
>> +			rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
>> +		}
>> +		mutex_unlock(&cgxd->lock);
>> +	}
>
>Does this code leave the TX parse configuration uninitialized for non-CGX
>mapped interfaces?
>
>Because rvu_lf_reset() zeroes all LF hardware registers earlier in
>rvu_mbox_handler_nix_lf_alloc(), it appears that if is_pf_cgxmapped()
>evaluates to false, NIX_AF_LFX_TX_PARSE_CFG will remain 0.
>
>Will non-CGX interfaces like SDP, loopback, or representor interfaces need
>an else branch to ensure they are programmed with NPC_TX_DEF_PKIND?
>
>>
>>  	if (is_rep_dev(rvu, pcifunc)) {
>>  		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;

ACK.

pw-bot: changes-requested
