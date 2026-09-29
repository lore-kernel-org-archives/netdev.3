Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AE380FEB;
	Tue, 29 Sep 2026 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649561; cv=none; b=lqSyfQwwpvFZ/FGoPfuMsoTIVEBtwkCrKwG8QZ7RBOVDNr3kBTUhr8xd1iG40EdpGKMfprGIJsfhpybbcLzV2Duj6JFsGIuKvOSQbL7FFebIH9LlKidT1pzZu0aAIgqDl4jXTBMqjb6OzBYis3uwlv//nfGwIwVXeopTChrwne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649561; c=relaxed/simple;
	bh=damWrBBGmIcQTno6NBJ6oL9EeTirZwkZeLruaUPclpY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpdUmVTdxFGTDZO1DmbRbbJpjMMqrY/S1wovvYEHHEs2Yo4mrP9PmlJqvDNLRUCxOhbOTokEZabMUhZsbs+JWRFUU2Msv+i5wtOD/k1+KMFjjHvE/aU/0F/IdnZPkXhBB5prIif9GKhW74J8RKDHteyZUBiGQgdHX7/6JOSSQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rf5i8GZB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rf5i8GZB"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T1XhDH2597632;
	Mon, 28 Sep 2026 19:39:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	9WHRi7MsCm+8+WIcyN8SwgQ4M7hJSFcSn0/8Ih01cI=; b=Rf5i8GZB2zlYkLOjB
	FAOqUHl2EsIjekEt2y4G41MHEK6K5DXpldLS+9gbMWcgWzSbUgdBY4ltmVNiHCHm
	YlfyiWxK89A5mmAVZUm76Bxt0jIoZVJumFvJxAUBOfQAqCYzwteCXX8Be0jVxNyV
	aKp6l4xF4nZfz1BMpYO3p7RmMqjRAbCYqLxPKHcnULqlkxQgcX3lGb4hUDlalfwj
	vRbqdrSTPjF+A7skz4tY4v71+0ObuMhFhgwygJHOEP3SaqzQbFoDZGxzaxPagVJM
	ArNJA1ZmfM580tqjqkunAIIQ4gnroJSPGLXa3LuZgzTRtZdx9vPDRycXoVXaDxEI
	HtlwA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gymvs3vjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 19:39:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Sep 2026 19:39:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 28 Sep 2026 19:39:10 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 403C75B6928;
	Mon, 28 Sep 2026 19:39:07 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:09:01 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v3 net-next] octeontx2-af: pass devlink switch id and
 cache representor map
Message-ID: <arskxWnvfGGv-xMZ@rkannoth-OptiPlex-7090>
References: <20260924082614.1947742-1-rkannoth@marvell.com>
 <179058473451.3145.9297107718800202799@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179058473451.3145.9297107718800202799@kernel.org>
X-Proofpoint-GUID: nlqKUQtVCYCMxqD_uIcXD_63taOzCiKi
X-Proofpoint-ORIG-GUID: nlqKUQtVCYCMxqD_uIcXD_63taOzCiKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMCBTYWx0ZWRfX/Bgbuh6qlu2K
 dl3UzXT9CJZa/dbl3LrW/VGs7InWTOTxXClxc8Gr2q2Xv/I5QUMIQNOlXWmLTLckJzeBAYo3tmZ
 V85+PPjV1V+f+FKKEeum8/Je73g9fZYZmERahw2PDnOG6r1CI834qqclwhije0SCgHOmJRnPBRZ
 pWho26CSpkl60MWrXrvyTyQizguzwDfmkcx+AVs9Xpjg1wfDxQP3GhRwrOif8h0+WP3LCH0qqNZ
 u6tfuUO2znhZlxxeMJbnZEEwTt0tRbv43JBC+JkqvNN5KF+Ts2kPAfQTIc01DmvJdUqLOjFz6uq
 GDc+zc12r28YoOswXfHloPhfnDw2cS9xXR7rOprc9BiD4AmQvYRmZRVkhYHQc7RBGJsxDBTCCjm
 HeU2q0bwBGSXItlgQnaodADLxpRxj4FTSyQ3WI9c/nzZ+EG1+hLlL37xii9vw9VNXILJdlkLso0
 8dNrwtjvMkzZvHoPGfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMCBTYWx0ZWRfXwv07NmpPp+Qv
 /mjdRDf+rOTQ+FoZHAoE+7k7M4YTZGik1lxtEw5ULIgSrMuKCEFJTH0jxC7k/cA9c8naCCnAL/M
 Rm7XQ7tusGlEOcRRLWPlLp/MkTuWPsU=
X-Authority-Analysis: v=2.4 cv=JuxkP84C c=1 sm=1 tr=0 ts=6abb24cf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=01oDmyOgafZaCAmfZGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01

On 2026-09-28 at 14:08:54, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 (4) · Medium: 6 (3) · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] Turning off the eswitch now makes the AF forget the
>   representor PF before that PF has freed its hardware resources.
> - [Medium] struct esw_cfg_req grows from 32 bytes to 72 bytes:
>   switch_id[MAX_PHYS_ITEM_ID_LEN] and switch_id_len are appended after…
> - [Medium] The new call to rvu_rep_cache_reset() in __rvu_flr_handler()
>   sets rep_mode = 0 when the representor PF goes through FLR.
> - [Medium] The patch puts rep_pcifunc, rep_mode,
>   rswitch.switch_id/switch_id_len, rep_cnt and rep2pfvf_map under…
> - [Medium] Before this patch, rep_pcifunc was only ever set.
> - [Medium] rvu_mbox_handler_esw_cfg() reads req->switch_id_len from the
>   shared mailbox several times: once for the bounds check, once as the…
> - [Low] The switch-id plumbing the commit message describes has no
>   consumer.

ACK.

pw-bot: changes-requested
