Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC012ECE86;
	Wed, 23 Sep 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127924; cv=none; b=ftMQGxflTaGqgYsaXMoYB0N7EO3y19nODhpPR5RttN5fw2oX+/prYtdq9Syntzs0Qz2QCMfgPoG7WoZ7oK3L6Ko6wt1crIfdPLXk1GLDzRxyTdkrUxHRXPlqcdBmuGDYt2j9Eb6a+av4jW178kBBnk6UHp+fHtmRJxEuykeseBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127924; c=relaxed/simple;
	bh=IwDq0g5ManHxjwebsFxgpEMAT6fNPD784YfCX9/Z2J8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFC46mlbjS6+v7u2p7HDC8UpvO+B3ddVnP01JRGwfYpalEk/+vhhYkVVuahGPd91Zeapxn7XnIcx1/1y4AUuEFFCDWu7t5gLMF4Q3XbltAievix4TPTAElCk+9+JjOaWwDjXN3BhaIvzO1n3cRsz0Pz2OiJTqjc27IMHsXiOuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XFz3qBT5; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XFz3qBT5"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIJiq2023469;
	Tue, 22 Sep 2026 18:45:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
	sPILo7FSp/ciUFdP/tzh7Ib5YfjDu3ZdPmADG++pg0=; b=XFz3qBT5IZ+HBpTeI
	/Yw8W2LCXs+bWakdZqqQg1REoAulDQfa63mJ/fnjrGBuJKGkyhLPOAXLDk7JQfyD
	X96WxmsoBU001kU6EFMnhUT6F/C+tCsqL3veHvrpjqnNrhp4LaR7tvHYF20S8Ynd
	MrkRbugbpKp5/VJFvkTLmgSowhW7PCBaN6Ks3VkrNPRvLSsgCYouxEspm4QKdOrM
	xiWijE6KlYBPY7ybfH6+9mOQOmzu4A1rLak0GORmffY2E8NIMcqA7gqnvOzDlVaW
	lWecwH6khyp32iiokN0U4yn3r1PwVMKcBR7SmIxrTveY3wHZDLCDni1BcmMS52ve
	ut56Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4guw11b646-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 18:45:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 18:45:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 18:45:12 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D28DF3F7072;
	Tue, 22 Sep 2026 18:45:09 -0700 (PDT)
Date: Wed, 23 Sep 2026 07:15:03 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-af: Representor devlink id and port
 mapping
Message-ID: <arMvH_s-bER6fpGo@rkannoth-OptiPlex-7090>
References: <20260918050021.1359606-1-rkannoth@marvell.com>
 <179005417560.2160803.15313824484958555300@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179005417560.2160803.15313824484958555300@kernel.org>
X-Proofpoint-ORIG-GUID: 3kiOgXEDlYjK5uTF6Cjtl3sBA4N8XpS_
X-Proofpoint-GUID: 3kiOgXEDlYjK5uTF6Cjtl3sBA4N8XpS_
X-Authority-Analysis: v=2.4 cv=LJDz05W9 c=1 sm=1 tr=0 ts=6ab32f29 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=Wv8oVBfEIB1BBuCnVyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNiBTYWx0ZWRfX9fkinNy1NQog
 947Kdfz61KO27p4xNTCgSUZCieA98NJ0aXCstuYFmpVuRV/GXmLGGfvSVbiUi7TdqDyfb1ywcnj
 KdBqVdu56z7WkrtDzVKGKBR9tD9LrRQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNiBTYWx0ZWRfX3SncwORAFoR6
 C0LQvV1UAaqMAqB1HsnzV7QlEQslo4MPHWUA6k9pqo+leWt8aWGoIsBvCB6ZKFDM+53wNmNLdxK
 w7GByNz/CXXcTIOLrgOFWM7hoyyyJa0/fdl/j1zXBBj33V9omSPqq81nfHWfMqk24DQEZKHO0Df
 /IHKgdMaC9PLYBtX4f3afJoLKLlKihTn+Y65cU/f7nj4jCDqwrtoCoxpzt+Ohh9gOI9Mcpkhxh+
 vnTFiOxlJ4annj9GAvX8uEH1IH4c0IiO7LXyzLrumz/kZ8retDhLHb3U8yE3w1Eqk5f6OiDYBdB
 w9xcBIamwU9950Tq0T4TavuFTRx4/R/jGiR/DfYxvJQ7uG7xMVkd8PtwSJIIBEtqkY1uovCYTpD
 bIvUsieAzVmgu3kRDTs0eNetPWB1nRuKJow2uxbLziEgBTkZVhyw/prw7WdIXCGItJoBS2OF3z5
 l6M0iIdOhJItX+WJ/ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01

On 2026-09-22 at 10:46:15, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issue(s) to consider.
>
> Critical: 0 · High: 2 (1) · Medium: 5 (1) · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] The new cached fast path in rvu_mbox_handler_get_rep_cnt()
>   (af/rvu_rep.c:489-495) returns success before the relocated…
> - [High] The patch turns MBOX_MSG_GET_REP_CNT from 'last caller wins'
>   into 'first caller wins, permanently'.
> - [Medium] Commit message omits a functional rewrite of
>   rvu_mbox_handler_get_rep_cnt().
> - [Medium] Everything the patch adds is dead code with no in-tree
>   consumer, yet it permanently changes a shared AF<->PF mailbox wire…
> - [Medium] struct esw_cfg_req (MBOX_MSG_ESW_CFG, id 0x00e) is extended by
>   switch_id[MAX_PHYS_ITEM_ID_LEN] + switch_id_len (sizeof grows from 32…
> - [Medium] The new comment block above struct esw_cfg_req
>   (af/mbox.h:1787-1804), duplicated at af/rvu_rep.c:458 and…
> - [Medium] The patch introduces a lockless publish/subscribe protocol for
>   rvu->rep2pfvf_map / rvu->rep_cnt but omits the release/acquire pairing…
> - [Low] rvu_sw_port_id() (af/rvu_rep.c:208-226) duplicates, verbatim, the
>   linear rep2pfvf_map[] search implemented immediately above it in…

Will address in v2.

pw-bot: changes-requested
