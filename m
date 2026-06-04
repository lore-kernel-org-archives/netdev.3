Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DC2BE035;
	Thu,  4 Jun 2026 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543026; cv=none; b=D2kLdCUDl6j3+9aeJ0PQEGp2DKdT+FZKzxSYl4bTPFFAR0QRexHr0uTXv0+CBKNyXiV8jkBkpo1RbVoN9aY/17rOm13QC++uL6tFKm6Zj5xKLSVoLuG2Xvj2Srq8ebnA8QVlT6eAqdqWbamBiWaCbc1fBPwuO4hOgSV0h2NSDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543026; c=relaxed/simple;
	bh=5iqKnkdI/qNFDn6owp8XGyCBJ9688eFsWIEN84Sndic=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmOeTTLJIhQYjRN6E9AeVc8CDjQTcX5xcdoZIkHsEhh17aBqEXdKJl5PjCcvYsNIEtW7t/c+RUIWn43ednNXSRQXSK4ASeTBbqUtiSrF/g6Soi3URubzNEUfGVR7D7+mctCqswyNSHnG6EwKzK02rfgRZmhL+weklOIPedQ7lCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J8vEXLOx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J8vEXLOx"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653JYTP1023943;
	Wed, 3 Jun 2026 20:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wxUX0tRfJYvGPB6UXCUXCVprq
	h1hrkJgdOtzY/GSsGE=; b=J8vEXLOxr9Rt0ldF91IdGsZBHnmSU+yeqD1ctXU6W
	+nFI5HevMCFWJEFjCMuLAUouoTwMqN9ZXMfZnkWolcAFoSKeUhS9/UJjfsb2v6ey
	zkNLUUa0qLd1aX1XrTkOBKlj7MoeMhhGJG474XIEjWgtH+H1YAg2bcDFIhw2hEW5
	Zepuh0No0CxN6SxAxMT5Z3lvaz/Hx8YTqwoLQYRZNCtD1fG9jpF1mafYyrChwNXJ
	aKbG+J8HzYTgPe5LPgfHgKGO6wTspH/TN9P0v44v9lknNM3B830J0hVZTLbOEMEm
	/urb8XWur7S095FZ9UeqmZfzLLcQoxhwehh/hP/hkUwRQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8v9cvd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 20:16:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 20:16:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 20:16:52 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A13A63F704E;
	Wed,  3 Jun 2026 20:16:49 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:46:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 7/8] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <aiDuIHx6TbalXCfX@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-8-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: GD63m1JFfFnPsIxtEq0L59fO8E1U4pYA
X-Authority-Analysis: v=2.4 cv=JNQLdcKb c=1 sm=1 tr=0 ts=6a20ee25 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=48gxjua0xmgbg7Xn39kA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyOCBTYWx0ZWRfX0nQiSwSNg7NM
 VipfH5Co6HImarjq/4WIArVNQP6CI+kAgjFUG/34JDl1Y0OLls0koElho3pOgK/hz2z8GWkXjUn
 PFxNt+weUzlgqgk1CifRJkIBDw789HddDlsc9ztJcDHP3j/DUqDjW7tqv/hNSVpHDoQHAkoZlaO
 JvgGrwZwVjF5MxNAHEjsICgDoRr+LhqOtmriJhSfXOX2dtEfkbXdKVBPU89YITxkNKwi9JrXfcO
 pDmBvu5rxVgVxGBd4i61/lYPR0j4m2k+CT8oJFg9BKw2geKE7XsgqONUjHwBHrFxjBkVhRlvMio
 lXKNfJDKrgs/Jv5qIP/fhSZw5j0l2uDqRk2qprbZxELLesZRAT9qk/1i4acr7jlekghfPoNx54A
 ca4RZcEboUiXMOhySTXfmTnnx+BE6uPLRxCbWI8Iz0DP6Ax2h5OaXuvoyq+KDWLcHHZDa5WFawL
 AhJGoEIwc6HOmYMI7zQ==
X-Proofpoint-GUID: GD63m1JFfFnPsIxtEq0L59fO8E1U4pYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_01,2026-05-28_03,2025-10-01_01

On 2026-06-02 at 11:33:58, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).
>
> In the AF flow-install path, flows that need more than 256 key bits
> query the NPC profile; if the platform is fixed to X2 entries, fail
> with -EOPNOTSUPP instead of requesting X4. Otherwise select X4 for the
> MCAM alloc.
>
> On the PF, cache and pass the profile kw_type from npc_get_pfl_info
> through otx2_mcam_pfl_info_get(), and use it when allocating MCAM
> entries for RSS/defaults and when installing ethtool flows on CN20K,
> including masking the reference index for X4 slot layout.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says:

>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> @@ -4533,11 +4539,18 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
>>  	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
>>  	 */
>>  	req.contig = false;
>> -	req.kw_type = NPC_MCAM_KEY_X2;
>>  	req.count = cnt;
>>  	req.hdr.pcifunc = pcifunc;
>>  	req.ref_prio = NPC_MCAM_LOWER_PRIO;
>> -	req.ref_entry = eidx + 1;
>> +
>> +	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
>> +		req.kw_type = NPC_MCAM_KEY_X4;
>> +		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
>> +	} else {
>> +		req.kw_type = NPC_MCAM_KEY_X2;
>> +		req.ref_entry = eidx;
>> +	}
>> +
>The first allocation block in npc_cn20k_dft_rules_alloc() previously used
>req.ref_entry = eidx, so adding only the X4 path to it is purely additive.
>This second (LOWER_PRIO fallback) block is different: it used to use
>req.ref_entry = eidx + 1, and the new X2 branch silently drops the +1 and
>uses eidx instead.
>Was the previous eidx + 1 (that is, 2 * npc_priv.bank_depth) in the
>fallback path intentional?
This is intentional to fix a bug  as eidx + 1 may cross the boundary of the resource.

>> -	if (kw_bits > 256)
>> +	if (kw_bits > 256) {
>> +		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
>> +		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
>> +			dev_err(rvu->dev,
>> +				"Only X2 entries are supported in X2 profile\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		*kw_type = NPC_MCAM_KEY_X4;
>> +	}
>A couple of concerns here.
>The struct msg_req req; is left uninitialized on the stack and then passed
>to rvu_mbox_handler_npc_get_pfl_info(). The handler does not currently
>read req, but it is a registered mbox dispatch entry whose contract has
>its hdr filled in by the mbox layer, so should req be zero-initialized at
>the declaration to match that contract, similar to the on-the-same-line
>struct npc_get_pfl_info_rsp rsp = { 0 } above it?
>The int return of rvu_mbox_handler_npc_get_pfl_info() is also discarded,
>and rsp.kw_type is then tested unconditionally. Since rsp starts at zero
>and NPC_MCAM_KEY_X1 is 0, a hypothetical handler failure would skip the
>X2-profile guard and select NPC_MCAM_KEY_X4. The handler's only failure
>return today is the !is_cn20k() check, which the function has already
>short-circuited above, so there is no live failure path; would it still
>make sense to capture the return and bail out, matching the rc-checking
>pattern used for rvu_mbox_handler_npc_get_num_kws() just a few lines
>earlier?
rvu_mbox_handler_npc_get_pfl_info() behaves purely as a local accessor function in this execution path.
It retrieves a statically cached profile configuration without processing any mailboxes.
However, to maintain strict consistency with the mailbox contract and prevent
any future static analysis tools from flagging uninitialized stack usage, we will add a error handler
as per of hardening series once this patch series is merged.
