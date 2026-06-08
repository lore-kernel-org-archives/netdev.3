Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857A23C39A;
	Mon,  8 Jun 2026 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885463; cv=none; b=uj/csV/EAqfIW6BGuRMOvr8h/I55aSxj/nySvGTq1rf1YgQADOMH1g4AR7IhyNZa6bSxTuy+CC1GmPincAQ6uGNDQgYwKpsBFVm3eZHsXbZQWriUI3mdpVHt89UXz/bYBdEmqL0jK1FdFPL0w6VSgw63k+yNlSUNV/EyAJwLp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885463; c=relaxed/simple;
	bh=xhhpMJnPIPdOiBLW4+kcJcApUpf96BbMFSZMlyvXnbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNJn9bY4onRY9ZpSAU3WPCAZ1friFapfsxvuIVK2EFaEKOqASiELNz/Is1Zv125tJMYRvpe2RJFeDrYd4EFqdPpuOA5XW7G2Rdjsxju38fTrPldMsSYGiYow2bx7P2e++eT8xQwx0qV9X/wN0c1ELHzYLixrFHIv8Qjtsv4yF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Au2/j2Vd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Au2/j2Vd"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580Enut936658;
	Sun, 7 Jun 2026 19:24:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=QLh8iztTar5D48JeJV8Ne/o7R
	A733eFB5WUdpacLfpw=; b=Au2/j2VdlKOXjqKNd0fiDsYRS2M7bH/vF/MQJjB4y
	oPXxZe+0lvtx2fz2KV3E2EyNK6du8Chm6tpM26nO/XweqINjE1gc1J9a+tpra7qW
	OI2WnGSMeVppJflfgaBaxqf7dk9igDA5uJEpS5BL869o1sJji02Hc9sCNke4Tje3
	5wqoSP8vGg0YweZb6dGNAzHbTzdBkuj7ApZWgkm4UaltYy+4bxqW1IfZDv4TLZjn
	iQ4cFZwLirHQzOH5NwAMiV4OCWnFaKh9/8AppVAZ0rSrUZrnizpds5eEpjRpTsEH
	PcDCOssUZ9G1EVpIIEJHgvGB/oL02BrTqjhXCAkOH5GvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2emrre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:24:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:24:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:24:12 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 758035B6932;
	Sun,  7 Jun 2026 19:24:09 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:54:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <aiYnyPrgaZ0wt0mG@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-9-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX6a/WpIlAkfYP
 gju3dRH5f37uD8RuB0LTnQ2r/9hwYVRHPuOIGZ0Fn46EbvIhxDRD+aerxn5K3mY0QzT13lnJM4r
 kMWcyyxz2AEPSgHe+9J8LsXF6Vvh74AL1m6vFeqi6ToA9oIVAxh4gaTO1SGG6lY+XIwZT2W+PEW
 txaxZCVTT4LxRhh3X7INf/0pC0hU+r3jzk7mK5/7mSm+pwYdQprlfejY9e46qLXK2+nbBCjxmqr
 5PSQb9Gp7MGI2gvpOjFpN/SBzVghUmPrhi9/KdHCvGP/ThXN0cMywdBn8KRAKVbopAn5GCP3KPw
 9AJQUX+bTHR2YwIfYz+nJ9QcOm9fzDVx91zFSUFXUSMUfM5UIYkUeiDyL+itO6j0ekOqlHutYlD
 l5h5p3qZy5XE4Syy5TtIDCLbyIUHC8n4PwoWzUZLbrch+3lp+wZRZy95TrCe1/ACZDO+EFA4xQM
 mc5Vhi0dE2dhVn8RHfQ==
X-Proofpoint-GUID: JXl4nJlmHsEzDgsXG4UwwC9rupgDsK67
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a2627cd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=Knl-tBO3iHv-3BrbUGwA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: JXl4nJlmHsEzDgsXG4UwwC9rupgDsK67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01

On 2026-06-05 at 12:02:44, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://sashiko.dev/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
>>  {
>>  	struct npc_get_pfl_info_rsp *rsp;
>>  	struct msg_req *req;
>>  	static struct {
>>  		bool is_set;
>> -		bool is_x2;
>> +		u8 kw_type;
>>  		u16 x4_slots;
>>  	} pfl_info;
>This is a pre-existing issue, but does caching the hardware profile information
>in this static structure lead to data races when multiple devices probe
>concurrently?
Hw profile information is unique. AF process profile read mbox messages from PF serially. If first
PF updates this information, is_set flag will be set to true. Next PF can directly read this value
rather than sending an mbox request to AF. There wont be any race as values are same and updated serially.
Secondly this is a pre-existing issue, so we can add some hardeing logic (some locks) in a new series
after this patch series is merged.

>+	u8 kw_type = 0;
>> +	u16 x4_slots;
>>  	u16 dft_idx;
>>
>>  	ref = 0;
>> @@ -315,6 +319,16 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>>  	if (!flow_cfg->def_ent)
>>  		return -ENOMEM;
>This isn't a bug introduced by this patch, but does otx2_mcam_entry_init()
>leak the def_ent array during repeated flow parameter updates?
>
Pre-existing issue, will address as a seperate patch after this series
is merged.
