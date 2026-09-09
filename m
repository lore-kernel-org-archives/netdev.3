Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC13002B9;
	Wed,  9 Sep 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922842; cv=none; b=WdbGG+irsB4tx/W93wumM0WsxEc0C1yb4O/zTWb5uAOJG9IRNJ0WvnHp2nZAtbUVfiKDt8e4uhPbeCBwi+qWbnsJbGyzIxoraWz3U2LtviRLWfnspjGzHII/74Z4f+wigvmAHj1wDNHutkW5CZESC6GbvF41q2Ivb0jiQdIYtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922842; c=relaxed/simple;
	bh=mrwQ2By5KA5YhupV20hH2vaWpSk2nCO94j7xM1x+LNk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl4AaYYoTGxkkc5nGKKy1h4J3hCaeTBIB9C5+cgXeC8MVPT/PNTtZZSllryYe20vNtH2drKVhEV+yBZ6XDmrahYUhy9ERGcw1qgtWy8oPYqE79+/XN6rtj7x/Z8Nz0cRGlUmxxE/PNmrOTMSvSvMPFHqtonsOqO74XXxDr/T+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IdUKOaFx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IdUKOaFx"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688MhggF2378353;
	Tue, 8 Sep 2026 19:59:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=U/qNu6FwisjxU9TKceSqPCJAD
	tUcZ+bZC8JUoQmjpRo=; b=IdUKOaFxSYAoiigblV+hLmCngdUeEXskiw2X6s5l5
	qx4fOrPG+Gk+GFNufKJ9+CS77x77sAlgHDzSpInxjjgnt+Fz4PtVbB68lcPiSVO7
	HcCtkgUbmIyUMM8Cd4W5woN28ZaS1nhSl9TVSsYfSZwwRwPeo5/VJJ/IRYi6T9zQ
	7dDI7XxyXa2VJPS7FPPMg2i8ObVSc+q0MrLrRmfPRz4mPIFzTFl9hJcnNjQNtmS+
	Ts054htHRlzcLEIussTPSpD/USYYtIzmoK5vGErVr4TImlq2o/rah2YMb3mw1N2G
	5HPaILJUKsgs3xZadPfbOGbjVCmrVIO7dyNkjeUudRETQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gjh5nubg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 19:59:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Sep 2026 19:59:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 8 Sep 2026 19:59:31 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 476063F7071;
	Tue,  8 Sep 2026 19:59:29 -0700 (PDT)
Date: Wed, 9 Sep 2026 08:29:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Heyang Tan <thy15333007817@163.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>
Subject: Re: [PATCH v3] octeontx2-af: use seq_file for rsrc_alloc debugfs
Message-ID: <aqDLi-xfsssfP59e@rkannoth-OptiPlex-7090>
References: <20260909015437.1042-1-thy15333007817@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909015437.1042-1-thy15333007817@163.com>
X-Authority-Analysis: v=2.4 cv=duPrzVg4 c=1 sm=1 tr=0 ts=6aa0cb94 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=DeVBWs9PZeKcyMnSSBgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAzMSBTYWx0ZWRfX3Dncgj56f8Q/
 6fksoEQP+zAvChTo2aXfFR/msoKAVNvbP/1hqFAaUldsEwwdkd30+29dzgqDdV5wDdOsJq4+Lpc
 wIitVMLfy/IVjV9cZ+lRgnYZsdWRkOI=
X-Proofpoint-GUID: REKTTLdOUsJeouSPEyTkbx4CSOaYULCq
X-Proofpoint-ORIG-GUID: REKTTLdOUsJeouSPEyTkbx4CSOaYULCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAzMSBTYWx0ZWRfXy0qkh+AwOKnt
 GpO5GZt05gpr+AECmtwN51FGQcmHMnOryhknA2q8QViJlVMA6HAKnw76z43b1UR6ro0g6cyjDmK
 oG/YsS4w9Gy/8MzEPFo5UQ550L33t6Hu22ExiuNVWI1LGavqwHoUgxnSKTM+zR382Cv9r4Jl4/m
 qhGnwVMJlsuliCZm1Zl7VlzLmwaqN/fCSl/gSLVtohmQrX0Ax0cWulVNJwqsTPKFFhocXh9W2qm
 wnGnugTv3jEgVeDYUlTFcC/Uk2UJ5TN8RKMxuPiAFs49A5OppYWGLm1PXmJUrymSFKMyRuKclNF
 8Cy1JgQbXcvqKNUN/MNPd8od3deWu2hl84avZ17k0UDI7FNjwxBSiL56D0/cXaEOrfERljLcIVg
 DJeg9EP59d100l+QvKiCDFM6GBoWvQ8DkvVeHHni+4udCfF8WROwe23e7TChcH30GbBHLpVTlFs
 6jcUbOaqtLHlwBiTTJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01

On 2026-09-09 at 07:24:37, Heyang Tan (thy15333007817@163.com) wrote:
> The rsrc_alloc debugfs reader writes rows directly to userspace without
> respecting the caller's read count. It also uses the current row length as
> the userspace stride, which can corrupt output when rows have different
> widths.
>
> Use seq_file to handle userspace buffer sizes, offsets, and partial reads.
>
> The LF list formatter is used both to determine the widest column and skip
> PF/VF rows with no resources, and to emit the final table. Let it measure
> the formatted length when no seq_file is supplied, and write directly to
> the seq_file during rendering. This preserves the pre-scan behavior while
> removing the temporary string buffers.
>
> Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
> Assisted-by: LLM Codex
> Signed-off-by: Heyang Tan <thy15333007817@163.com>
>
> Changes in v3:
> - Format LF lists directly in the seq_file buffer and remove temporary buffers.
> - Measure, rather than emit, LF lists during width calculation and row scans.
> - Explain the two formatter modes in a code comment.
> - Preserve column alignment with seq_setwidth() and seq_pad().
> - Reorder local declarations in reverse Christmas tree order.
>
> Link: https://lore.kernel.org/netdev/20260906141129.1730-1-thy15333007817@163.com/
> ---
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 114 +++++++++++-------
>  1 file changed, 69 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index fcbf4ba0e10a..1f177851e76d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -646,10 +646,29 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
>
>  RVU_DEBUG_FOPS(lmtst_map_table, lmtst_map_table_display, NULL);
>
> -static void get_lf_str_list(const struct rvu_block *block, int pcifunc,
> -			    char *lfs)
> +static int get_num_digits(int number)
>  {
> -	int lf = 0, seq = 0, len = 0, prev_lf = block->lf.max;
> +	int width = 1;
> +
> +	while (number >= 10) {
> +		number /= 10;
> +		width++;
> +	}
> +
> +	return width;
> +}

Sorry for the confusion here! My previous comment was strictly a "nice-to-have"
suggestion and wasn't intended to trigger a larger scope expansion. Given that
this is a targeted bug fix, keeping the diff minimal and low-risk is the
priority. Your v2 patch addressed the core issue cleanly without unnecessary
churn. Could you please revert/repost the v2 version as v4 ? We can always handle any
extra cleanup in a separate follow-up to net-next if needed. Thanks for your help.
