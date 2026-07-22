Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06E47A0A9;
	Wed, 22 Jul 2026 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706980; cv=none; b=fwAbF5/FfV7EtDF2C5XLDkHEJamvnhYxM79BFz3ysH3W91H0CGdrwm9tY45UGRmg1sDyPuGo6yt4RKq7A03kWkrL6NeBkyQgjrNCjilVaYuJceo0hYW71PoDjmAqJwHpbPDk7pINx1B1/ca29QFEBUK/Hx+vb9w1+sNMi4GPUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706980; c=relaxed/simple;
	bh=nukePEXqRfDAirUZoE0va78p8gJc5818cc+LNWzBdFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/5nDQeIWak1BV8QBTaC9rPKw3QWlO2shOrA1/hqFebCi3uP4ENiBHCVSS+ikcybOEYk3BFOB9C4EGQuMMQOt9glXGHDdVnZZ1iZ54dtYht2eqrqKmKP6bIkPgz+sWpcCjdzJpQRJ3Ed3+viDll8iH/qu0LpW2FN1o2lbwB4O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Hm2yTEa+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Hm2yTEa+"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M6BNRW2154352;
	Wed, 22 Jul 2026 00:56:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=O5DuKBO9EFqg8PY77nZVdAx1A
	FeCxwU7Cj1Qm2fay98=; b=Hm2yTEa+0ac6ZRc9ICeBB62Cw7EvmSx4zIja6Mctk
	pfSuNE5vfJ4028gNnRsZJQx317KzlPi2mOCyN+c3yDRV+EncF+O3JkyXMTDH9Vae
	/x8njc4UT6iRooyIuNkMxhi88po5/lf9QaRFdXNCu7HE3t8q1t/CALaQO9nb3NFB
	Fo0x7/u+IYyCUb7TOcG8PkT5hpItORzL4URJ4wuNSZAMCCpcxa9GAWdGC2H3B9pn
	2Arl2hr7To+YqCWfKwLgAElLA8Vf6rv6aslbzsWIrwR6j+vuVt4ppXlW2/MBfp9r
	53IfrMbL4zDQvQqI5OyEklbEZ2FfJld8KNkNMzJ/5eiOg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fjjf88ys3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 00:56:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 22 Jul 2026 00:56:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 22 Jul 2026 00:56:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id E62C73F704B;
	Wed, 22 Jul 2026 00:56:06 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:26:05 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key
 overlap
Message-ID: <amB3lUrldQhP64xa@rkannoth-OptiPlex-7090>
References: <20260721070303.986740-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721070303.986740-1-rkannoth@marvell.com>
X-Proofpoint-GUID: KPVWFY4b_iMO02Ypel1jnK439GMYim-n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MyBTYWx0ZWRfX55zl53Odeox5
 2MPc+tqrqaU1GWC3lUmO4TQRgXEcr/C4fv6QRTHOVeZ75oZKdiOgTjI7Kt+ZpJf7w8X7C6fi/Z7
 8Cyb9fIT+XzVxbJKs5c/5htwnjyraOM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MyBTYWx0ZWRfX4Tx5IabRTv7q
 75nXfiEorTuDvp8gcPoxCIImtG54uYe/Od+BObL0abUHVh19lE+lfNnkEzBi0oIqx7iRYFjEik0
 i+1J57OmwhF27vgEqBqv10CptAFwTMF9SMbCsUc4/oBQ3f5iCJf0eMesvExnbX+xp6P+cFbjxfz
 JPBkTKjX8NwCnKqBMU9DEn2lUUzYKh3vR1HoeKCQbD+m/tCX8iuq//Lu4ziYDRQOS2Y3WG7+dK/
 FULK5w0Xma5mt5cT3DLOvhSuPUtsAYSJAK5Fzkw586ukBtirjiS4JPrLuySmS7C32ASLJn8xo5a
 ZyQxOFl8jlYccQSUWJIpkp0VjgjT06QWEuaGIUI135quX9S7nyR6FmVR9kYVRvUqyvVhj6iyzDS
 HvOmDdi0iyXc52J05Xgyrim0GoRIbX8hoByUGwWCvA1f+wLFX3SMcaQoQWzKlFALf54BDWmHPF+
 HdtTPM796I62YxtDyzw==
X-Authority-Analysis: v=2.4 cv=Rov16imK c=1 sm=1 tr=0 ts=6a60779a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=r3grigIuxABfADZXa-wA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: KPVWFY4b_iMO02Ypel1jnK439GMYim-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01

On 2026-07-21 at 12:33:03, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
>
> When scanning the MKEX profile to determine supported NPC features, warn
> if the SPI extraction field overlaps with other key fields. AH and ESP
> may legitimately use the same key offset for SPI, so continue to
> advertise NPC_IPSEC_SPI via npc_is_field_present() instead of treating
> the overlap as a hard failure.
>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260721070303.986740-1-rkannoth%40marvell.com wrote

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>[ ... ]
>> -	/* Allow extracting SPI field from AH and ESP headers at same offset */
>> +	/* Warn on unrelated MKEX fields colliding with SPI key bits.  AH/ESP
>> +	 * sharing the same SPI key offset is valid; use npc_is_field_present(),
>> +	 * not npc_check_field(), to advertise the feature.
>> +	 */
>> +	if (npc_check_overlap(rvu, blkaddr, NPC_IPSEC_SPI, 0, intf))
>> +		dev_warn(rvu->dev, "Overlap detected the field NPC_IPSEC_SPI\n");
>
>Will this warning spuriously trigger for valid AH and ESP configurations?
>
>The NPC_IPSEC_SPI field extracts data from two different layers, NPC_LID_LD for
>AH and NPC_LID_LE for ESP. However, rx_key_fields[NPC_IPSEC_SPI].layer_mdata
>only stores the metadata of the last scanned layer.
>
>When npc_check_overlap() processes the AH layer, npc_is_same() evaluates to
>false because the LIDs differ. Then npc_check_overlap_fields() compares
>their kw_masks, which intersect because the SPI kw_mask accumulated both AH
>and ESP extraction bits.
>
>This appears to cause npc_check_overlap() to return true for its own layer
>component, warning unconditionally on valid profiles and contradicting the
>goal of ignoring legitimate AH/ESP overlap.

npc_check_overlap() is to check whether there is an overlap for the extracted key in meta data.
We can ignore sashiko comment.

>
>>  	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
>>  	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
>>  		*features |= BIT_ULL(NPC_IPSEC_SPI);
>
>Does bypassing the overlap check here allow corrupted key extraction?
>
>If npc_check_overlap() detects a true collision with a completely unrelated
>MKEX field, such as VLAN or DMAC, this logic merely prints the warning above
>but still continues to set the NPC_IPSEC_SPI feature bit.
>
>This seems to advertise support for the feature even when the hardware MKEX
>profile has genuinely overlapping extraction keys that could misclassify
>packets and incorrectly steer IPsec traffic.

Evenif overlap detected, system functions for most of the traffic, so print warning and continue.
We can ignore sashiko comment.
