Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB253033E1;
	Tue, 29 Sep 2026 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650391; cv=none; b=phHTPs4jKpqOC6xp3Zy9xuzkbgvu7T8rxkas1LU1MoXU0GkVLqQDFMKGin8eW89ucphMmsWTgP8i5x8t5jQww1thnDhzTnCBpKoqrkF700PO0gRTArZ3Gxt87PRv7ZW4eNDN4eUWRkTHd0DNO1ddAp+ROtntEaZXj6j6nEEKAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650391; c=relaxed/simple;
	bh=m6FBb/3daGyfPUCOwjMWo3UJ3uj1mpF7RazDsMqsqKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+ab4u0Rn8f6VfnG29MgA7n6LB8Gc74/XyMNl9Gw9TwLsmQ+BY4FRoeSWkAIr/I+TlCCZCg3tfpcUn8W565PDwD6sN/Jp2/1jn8AUM31NWHTilWxKbzfOLAvAA7/f4u+EG4o02kupe1njKqPqyKssal/e4HtCp0plfaFA4zPDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EHFHkpEw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EHFHkpEw"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T1XnKM4176283;
	Mon, 28 Sep 2026 19:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	Y79B0ixUmKqRF5wtB9l7Q1drhYP9JZ+Gmxw+vu2LXI=; b=EHFHkpEwkAwHsftj4
	wuWj4aj3DtzaGLWqdqTN2w0brEy68zhParlK9QrIqLnUAkpXCRP/SCCDZdifQn40
	+9uoIJrFBcpPLjoU0WBuAhamsXBiKE4G1XpyGPK7F00jhaA8V4tdwSQxKWq72H93
	ZA/NEWhC+jvZTMAdu7EiVUn+yIUKoNxoaZVmkyahalShdPbl33PCmBwqL8+4PrJo
	t3WpbJkSu4zY5Q1gE30h5QrunTr0RpAhpfPS5ZomU5zUebPA9emNUOk0NQFLPDP3
	313ZdbudsqSDIxCCaWYtdiMQAiqPHp2EMB27sKFHCBkBoNxZ2Tq67JHwrT+7B68r
	U3Htg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gyuet2h9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 19:53:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Sep 2026 19:53:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 28 Sep 2026 19:53:01 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B79203F706F;
	Mon, 28 Sep 2026 19:52:58 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:22:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: Add couple of mailbox support.
Message-ID: <arsoBMzzOiinjdGZ@rkannoth-OptiPlex-7090>
References: <20260924024446.1851115-1-rkannoth@marvell.com>
 <179056446689.3145.6845627797649400561@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179056446689.3145.6845627797649400561@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMSBTYWx0ZWRfX37O29vOlFAu6
 Frj42ZNHRR4RT8Ae5aoUtGZ+NN4soBSoynmqBTHe9X0dpgoacpMhvqPFP+RYGtCIpAVEJcsHCoz
 WAdcQYXMnUPz7kas632J1+SfaNVQ0/vNWZL8ZyGb9Gjp1/eIQofBWcJaVSd5Etq4V4vNBrZt2GD
 NDZFlLuxS2cjcpc86BNdkAObInyuZisHHsdlzTEgP12Npd7bUyQ1QmHtZRqINjAxE1i7vNa/bDT
 lLEJnKKdrR0lBmJxwUlObNzGUSTXEgeqhsvg4pk9BvDH8krrerjuSb9t6LpTmzX/DGlP/IgTIPh
 KzxI6Mk43rmLa1a3GkgueBuaiZKKl9toEEyoaHfMgbZK+RVFho1j0/wjor5nXt6QT0k2shUMk6a
 RtCZGsjvvO2KFPngnl3rJ/RTC02U9uLdJGeIJckrN8zd/dka2M4mJsQGWuvcnKjkIvtAbdjYe22
 8kEPby+9yshMlgNSHWA==
X-Proofpoint-GUID: KexnXrV0hHYW-89yOYmOngSIbwUwpCOY
X-Authority-Analysis: v=2.4 cv=OcQNnRTY c=1 sm=1 tr=0 ts=6abb280e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=6Z1x9eJ7lIRtT8jGVt8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMSBTYWx0ZWRfX68enthSWWy1j
 g0hXw6XSPHf3+FZc1EwK67QKaY/HogHy1G8+gvU2WR6g1G+1RxKSRpQpBvzxA0kjcfcD6XmgIdk
 dvQ9bULtBBskEpwx7E5DtaM2NewYY0M=
X-Proofpoint-ORIG-GUID: KexnXrV0hHYW-89yOYmOngSIbwUwpCOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01

On 2026-09-28 at 08:31:06, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issue(s) to consider.
>
> Critical: 0 (1) · High: 1 (4) · Medium: 5 (1) · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] rvu_mbox_handler_nix_lf_alloc() now declares the locals `struct
>   qmem *rq_ctx, *sq_ctx, *cq_ctx;` without initializing them, and…
> - [Medium] The patch rewrites nix_get_tx_link() (rvu_nix.c) and changes
>   what it returns for existing users, not only for the new…
> - [Medium] IFACE_GET_INFO treats `pfvf->tx_chan_cnt != 0` as meaning the
>   interface has a live NIX LF, but the patch clears the channel fields…
> - [Medium] In nix_interface_init(), `lbkid = 0; if (rvu->hw->lbk_links >
>   1) lbkid = ...; if (loop) lbkid = !lbkid;` sets lbkid=1 even when…
> - [Medium] The new rvu_mbox_handler_npc_mcam_mul_stats() decodes the
>   counter selector as `cntr = regval & 0x1FF` before reading…
> - [Medium] rvu_mbox_handler_nix_lf_free() now calls
>   nix_interface_clear_chan(), which sets rx_chan_base to 0.
> - [Low] For the representor, nix_get_tx_link() now returns hw->cgx_links,
>   and IFACE_GET_INFO reports that value.
> - [Low] nix_interface_init() writes pfvf->lbkid without holding
>   rsrc_lock, before nix_interface_set_chan().

ACK.

pw-bot: changes-requested
