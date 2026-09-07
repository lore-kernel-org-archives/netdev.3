Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9362C026C;
	Mon,  7 Sep 2026 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788750478; cv=none; b=GjPEBTceJnmteLSjpqmKPqU3NN/0dDtAtGyyFaNXmdcjVvP18eoihOMXX4w8QKm6klimrojWyt3y65tmKx35H2+eC/Hkru2rlkLP+b8uuQWkrkOZhEjTakzoGaomwQDGiDm3mAyAev/Yyb8sa6gQLwFIF33+Ah4MgxQlmnsw/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788750478; c=relaxed/simple;
	bh=xSoR1PnBI+GZlREYdGlIXVdmoW7t70tRY+CtVi6dn6Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXgEK8eDaO35etCbG42izzb+yC1r6/LZvl6FEsLForOEtN4JffefYVoyM3j7adfrZ1F6s+EWXWympCj/kBzlkWzxub0gEtqOlk92VXctYmitvTuf/ICMGpyn3tSbo1KcYzF02m0EveilbVHtijk1vgHRWC1kGpkZjs9d2NOp2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kino3Chv; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kino3Chv"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870lIuH1604862;
	Sun, 6 Sep 2026 20:07:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CF7djGgUtui32qgYONKt+QOaR
	Q8kFdzH/u1/UPHWw+c=; b=kino3Chv2hEMo25+ivpw4wd+mxa2nlP72G/aIqE6A
	3mIzI3nQ7LdBirpiRmafIFbzVn/xAeepvz9BtlDQ0CbalZsyqwJOZav87pXJkBI0
	HdZ1e81/UN1SpIVsLPaSsSYno5R965QD4a91xIGrKClfkBEkHsxCPecKyfsfWKH3
	+1NB8dXBOnx3GdnxJcFtmrHCnLdtaWeNQR7kOJxsEM7uhZoVzgQmpwYC1QT31naK
	T1mb3rjI6frt0gusSyIVDFfB1vDFkuMnyIksP5QLh74V3j+sIhKgdItAvr/RmiAv
	+jlxrqWe1fdEXGxY44iMBzzjT0Q8oTtEfEw8Xo0HPzGoA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gggem38nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 20:07:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 20:07:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 20:07:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 87A1C3F70A2;
	Sun,  6 Sep 2026 20:07:41 -0700 (PDT)
Date: Mon, 7 Sep 2026 08:37:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Heyang Tan <thy15333007817@163.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>
Subject: Re: [PATCH] octeontx2-af: use seq_file for rsrc_alloc debugfs
Message-ID: <ap4qd9c-givSLVwW@rkannoth-OptiPlex-7090>
References: <20260906141129.1730-1-thy15333007817@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260906141129.1730-1-thy15333007817@163.com>
X-Proofpoint-ORIG-GUID: Xu2awYSzIvB7cl2QzubHHrvoM4C6RUre
X-Proofpoint-GUID: Xu2awYSzIvB7cl2QzubHHrvoM4C6RUre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzMCBTYWx0ZWRfX+jYdX+Rarir+
 I+P2to8SbjfZ5mfr4RPhBnaultKHSaFD3VKUbl5XYBPR794yCmBJxz4vygeWYr7OfXNf2s82ZSZ
 9VB5DIdfzS1vuZSBAq4m/9u/CGJyewA2fOAjAM4yt18qdTLUK7GP+CG2GLcX4+XXlTDetEprGIg
 MY+XuqMI1OYgqFIeOZ+gG4N/tsl5tuzPNXbiJ2C0DLUrY3B8/PANiFHu1XszEMHk+K1czxtktIL
 2FJAujoua0px3nAuFkRe54u8beE4llB3kmUq6coTYeB/h/BOcZIidsbfu0pe/QH9QvivLbO4F5C
 3cblzQSm8KSvx1Eds4bKrJ+acxA1CYJM9gnbuRgf5AWp/kOsgVqcj0XiIArBISwmd5XINJW2947
 0rxf9yynTxNMjeQ+L3xTbWoNlRyvEopiOZQxBdrjqo1Hm3tyFcuugzhoJptMP0Ht2jD/5WZBPli
 j50oyhk+OTO6Hy67XYA==
X-Authority-Analysis: v=2.4 cv=DIe/JSNb c=1 sm=1 tr=0 ts=6a9e2a81 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=Byx-y9mGAAAA:8
 a=DeVBWs9PZeKcyMnSSBgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzMCBTYWx0ZWRfX2VIkqfRaw+dT
 j72Hte5sG1Iiahfg3kotpaqu69RAAX/eTuBtQ+fw1M/BAGg2De57cvu3enVvgzDCMuM5AOEyEub
 o3iykxlOHy4CnlY43AVJntwfzH6XDPU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01

On 2026-09-06 at 19:41:29, Heyang Tan (thy15333007817@163.com) wrote:
> The rsrc_status debugfs reader writes rows directly to userspace without
> respecting the caller's read count. It also uses the current row length as
> the userspace stride, which can corrupt output when rows have different
> widths.
>
> Build each row in the existing kernel buffer and use seq_file to handle
> userspace buffer sizes, offsets, and partial reads.
>
> Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
> Signed-off-by: Heyang Tan <thy15333007817@163.com>
> ---
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 71 ++++++-------------
>  1 file changed, 22 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 22ee99676879..a222998482fa 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -714,52 +714,39 @@ static int get_max_column_width(struct rvu *rvu)
>  }
>
>  /* Dumps current provisioning status of all RVU block LFs */
> -static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
> -					  char __user *buffer,
> -					  size_t count, loff_t *ppos)
> +static int rvu_dbg_rsrc_attach_status(struct seq_file *filp, void *unused)
>  {
> -	int index, off = 0, flag = 0, len = 0, i = 0;
> -	struct rvu *rvu = filp->private_data;
> -	int bytes_not_copied = 0;
> +	int index, off, flag, pf, vf, pcifunc;
> +	struct rvu *rvu = filp->private;
>  	struct rvu_block block;
> -	int pf, vf, pcifunc;
>  	int buf_size = 2048;
>  	int lf_str_size;
>  	char *lfs;
>  	char *buf;
>
> -	/* don't allow partial reads */
> -	if (*ppos != 0)
> -		return 0;
> -
>  	buf = kzalloc(buf_size, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>
> -	/* Get the maximum width of a column */
>  	lf_str_size = get_max_column_width(rvu);
> +	if (lf_str_size < 0) {
> +		kfree(buf);
> +		return lf_str_size;
> +	}
>
>  	lfs = kzalloc(lf_str_size, GFP_KERNEL);
>  	if (!lfs) {
>  		kfree(buf);
>  		return -ENOMEM;
>  	}
> -	off +=	scnprintf(&buf[off], buf_size - 1 - off, "%-*s", lf_str_size,
> -			  "pcifunc");
Can we get rid of scnprintf() ? each column can go straight to the seq buffer.
