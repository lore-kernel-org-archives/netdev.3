Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F442E718B;
	Mon,  8 Jun 2026 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885514; cv=none; b=jGkzOB+F7PTMl29Y+hRoprwCTTp4/d42eePu4BlyVDIPvfuEQvSf9LvfwoXa+H8nNeow8vxBpNTgW/6iuyli0iJlP11G14C6dFU1p5lDmKKNLeCmadnNozz58DqjEvvfHU1lf81rioXk1uUxDtDhOC0eJ483/dpMF2DxxJ47I6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885514; c=relaxed/simple;
	bh=FKQeT4oNH81XVa5QulJJv21HnmVSaXCk1WcuOl2a9Lc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH8EX6fH5PwU+gw/EpEN6voNwAdjCHl/uzTLz+FNMN4bxZAd8gBm19JSoMn5m7lFatLTC7sFIwhXR1knZG8w3se0Nkf5EHLV3B2E3oyaGIkpA85xDTxSySORd+Xuszhio7/WWB09TsnORq87PQU/uzgIW1pHxzsCPh9fzDBCZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NcvXytwz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NcvXytwz"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EdwJ839081;
	Sun, 7 Jun 2026 19:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=62A4JrVvPTpdsjB64PANGdD0X
	Cf/DCGHcqWWD1ClH9M=; b=NcvXytwzGhpl8ULuqtU09FYaPGT1m/YJWEulZkBO7
	tPE6n8DhbXFe9wJe3y3a2IVmoYBL7sfPQmdcgQtzZ3necuTUsYrIls6ghkuVHj6f
	bIsasIO9JQwhtEcpHIMUf1RfQ5Xx+xIfpryhG6BwXrI3WeAFiC6sMWzOygDIHjIB
	AZoaUV9A1U/g28H1yn2z/47OPTi9pgC9HPxIiwceV2EExR8Xv2R3LrrNNhDxWLR7
	BfdqH3bqLOCydoajKbrtfIUpmPsjmYMmbLo8bOcP++gehw09GYD5rEAQmZY/1puw
	/Tqh2eIjz3OT9Azqt584Lv63IxPB+onYH4VsCN6QvJ/JA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4en4a5ja30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:25:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:25:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:25:04 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 13BA05B6932;
	Sun,  7 Jun 2026 19:25:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:55:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <aiYn_OM50Rqzga4j@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-10-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=HpBG3UTS c=1 sm=1 tr=0 ts=6a262800 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=-8eROJNlrdycMLJOjUIA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Ck7bCwbNW11ouoXlJj79VJGBJIK7J_9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX3BAKsBHfg7Gw
 gWmwI4SHV0s4JaFHk4862qjtTzKuU2IonrS976FP2T1b+DCDnLbRWbPC1lLtPFz3cgb18FaZ0LF
 GOmhkVm6CkDk4v4yi0+ehqPpCPqzdN7tG/oHwCCZVNm2Cf2ahm9UmzFvDFgZ8ven/IR7PlJz2QB
 hZUsBx1bbvgXZJzHmfsEXwIHdQM2Eo41HoBpx8op38/G7wYwzKoH8REWSYIivRS/QlChTmapOQU
 PkySKkBBnprTIRtS3JfsTZiMaHa2IA9OcF7FMmNuntuqowV5aYOclCQQhzbT+dlEoUiE2KT7FOM
 FbjoYWDabI3lmfDEMdaoSzU0QSWeREymufGbIZzj4gGMF/ES2E7Smf7fXfiORH0FUUA6UDEJ39t
 LJ6/l2bvlC9JfgfVr4DwFQTZhFUXzIq8P5kFvOsm08L3ChqS+D8tB5L4vClhfGtN1n5nwvrgKrK
 Y3VLj1bipty5z7GhSkw==
X-Proofpoint-GUID: Ck7bCwbNW11ouoXlJj79VJGBJIK7J_9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01

On 2026-06-05 at 12:02:45, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.
>
> Allocate MCAM debugfs dstats via devm_kzalloc instead of a static matrix,
> and use the allocated backing store consistently when computing deltas
> (including the counter rollover compare).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>>   */
>> -static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
>> +static u64 (*dstats)[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS];
>> +
>>  static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
>>  {
>What happens if npc_priv is NULL when this function is called?
npc_priv is allocated during probe() much before debugfs entries are created.

>>  	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
>>  			    npc_priv, &npc_vidx2idx_map_fops);
>>
>> +	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
>> +	if (!dstats)
>> +		return -ENOMEM;
>> +
>Does allocating dstats per-device using devm_kzalloc overwrite the global
>dstats pointer in multi-device systems?
Only one AF device per system, first patch in the series enforce the same.

>>  	int bank_off, sb_id;
>>
>>  	/* mcam_idx should be less than (2 * bank depth) */
>> -	if (mcam_idx >= npc_priv.bank_depth * 2) {
>> +	if (mcam_idx >= npc_priv->bank_depth * 2) {
>Is it possible for unprivileged Virtual Functions to trigger a denial of
>service here?
>Mailbox handlers invoke npc_mcam_idx_2_key_type(). If a VF sends a mailbox
>message early during host probe, or after an NPC initialization failure,
>npc_priv might be NULL. Would this crash the host kernel without a
>NULL pointer check?
Not possibe; as VF/PF can be probed only after AF is initialized properly.

>> -	rsp->kw_type = npc_priv.kw;
>> -	rsp->x4_slots = npc_priv.bank_depth;
>> +	rsp->kw_type = npc_priv->kw;
>> +	rsp->x4_slots = npc_priv->bank_depth;
>>  	return 0;
>>  }
>Could this also crash if npc_priv is NULL?
>Since mailbox handlers process messages from Virtual Functions, checking
>npc_priv for NULL before dereferencing seems necessary to prevent a crash.
Not possibe; as VF/PF can be probed only after AF is initialized properly.

> -	npc_priv.num_subbanks = num_subbanks;
>> -	npc_priv.bank_depth = bank_depth;
>> -	npc_priv.subbank_depth = subbank_depth;
>> +	npc_priv = kcalloc(1, sizeof(*npc_priv), GFP_KERNEL);
>Will probing a second RVU device overwrite the npc_priv pointer allocated
>by the first device?
>Since npc_priv remains a global static pointer, it appears this should be
>stored in a per-device structure like struct rvu rather than a global
>variable to support multi-device setups safely.
Only one AF device per system, first patch in the series enforce the same.

>
>> +	kfree(npc_priv);
>> +	npc_priv = NULL;
>>  }
>If any single RVU device unbinds or fails probing, will this free the
>global npc_priv and set it to NULL?
>If so, this seems like it would corrupt the shared state and cause
>use-after-free or NULL pointer crashes for other active RVU devices on
>the system.
Ubinding and failuer handling in AF driver is not complete; as is not in
the scope of this patch. Will work on a proper error handlling (hardening
patch series) once this series is merged.
