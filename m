Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F02E612E;
	Tue,  8 Sep 2026 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834429; cv=none; b=FVGZEJU3rqzDn2R6jVxX7L7lISar4BXl2wXdl1Vq/7Cp5lU3NL853xnztsj2cJHt80LR38MUcQiGvmozUuV/UKf3l6daL9QMsbl55udENBpJVTlF/0cKMj5gvTbjXv9nNPgjwB0ywbw3jUpwWezWDT25ScwsgAGLnS+m98RKlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834429; c=relaxed/simple;
	bh=y7pxaDAbVeUX4k0GvzSHwHgBGoiQwUur0QEkggFn9CM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG8IWhCEucNBmNmktbWmRK1P+v36W9DTvc5FxZB+dhTmQBYTyYNExbLuJjvLNaAN+wtoCoJu28VJM4N7WR61rI2JVqgUrKo+/6m+PG7nvOko1LaUXqakuk4SB0kNhOVZlZbi1XYl2L3KMUVaPrJPJCDdRlUmFzBp1mGWncBFPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ofepju9t; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ofepju9t"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Nomot4052722;
	Mon, 7 Sep 2026 19:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=17+zbN9gbM4u77l3PSd7TEWqI
	SJh+zHUxKje14cPnc0=; b=Ofepju9tXoNy3Pthfd2Xxg9R1B/zjziwFi95gZ4ue
	OCweOK31kYongou+mftmKIOvQLpOkMgjHhtdCCXaGRgKNycLSRW6NXf/QR2XQUKt
	gfQXQWdZxKSgszhH+OEGeQxoYmQ4ESZAW23nT+i9SmW3GdfJbwtID0SFiAW8yjj1
	qyVuaG+OkPrmMOlGUyEX3eURMBfuTOa6I7VghzeYyDe8V1JtkE/Ydedud3+7uUI6
	ZZcF9/UWamMN3hROPkN6qC7DTfnfnPFPjLgei6bVonY8ReDdlzRG1K3Ie9sKx4gN
	4N/R4txNKN/GIkUmi/jaS4vCEOFjyAXKDQmbAF6+mnd7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ghupya3gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 19:27:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 19:26:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 19:26:59 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8AC9B3F70BE;
	Mon,  7 Sep 2026 19:26:57 -0700 (PDT)
Date: Tue, 8 Sep 2026 07:56:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Heyang Tan <thy15333007817@163.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>
Subject: Re: [PATCH v2] octeontx2-af: use seq_file for rsrc_alloc debugfs
Message-ID: <ap9yawyk9Wt1Q5Da@rkannoth-OptiPlex-7090>
References: <20260908015435.1213-1-thy15333007817@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908015435.1213-1-thy15333007817@163.com>
X-Authority-Analysis: v=2.4 cv=AYyB2XXG c=1 sm=1 tr=0 ts=6a9f7274 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=Byx-y9mGAAAA:8
 a=eSKagXBqjSjDablskkcA:9 a=CjuIK1q_8ugA:10 a=1CYo9-gkzx054UpEq_5a:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDAyNCBTYWx0ZWRfX6y4lPlEgB7Gf
 NYIcGRDyqnL0RM37Tbu342ROxW4dlKxrsUhxDDIik4MP7DEkDMVPnY0nZLwER/ytPyJ4EK1ozqn
 1I98KfJ9QCUV8EINc85Ll3hkg93iRYG9wKuXok2TJnOKbY6gwoRQsEe+R77i4e9N2zv+qMynyIm
 WQRtwnDRokHmXtGQ79NJRm1HKUuN/NK4XO8f66GoJrH8PQ6nMF8wtqx1yUjnaLhEWpnkMRlHGvV
 XEr4MSremkOfgVGZ9QfGaXrZFrAVY9Wv/I+UTCM83rITsUvHZKk12pHE9obhPatugSHWIOms85C
 6KgHocPV2RnjT9QAS7hJex88q13vAAmlUDCT65OzttWYE6TwA6kW+iHfkY3SgVxCB6QOilydtVy
 wit1jpD6ro0E0AX0YBvUGH6vxU5db7upGZUHaxw8kuXqdd4czXNkNbUeowNFqx2Gr137y5BrMaV
 vI9wjIR+MXi76TIHULg==
X-Proofpoint-ORIG-GUID: BEYnj2FKvi-ZmujHGCRmwoYVaa1Ded9r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDAyNCBTYWx0ZWRfX2fzYQX71ol8Z
 GfBmmG5PqXn7koQ1xZXLbZvRcmYT5PEaFZ8d/mK9qRXSbGMG48sFcdPwMGttCFr6AGIFLBvEQJl
 8EQrvJFLMXEUGjbbWwyh10e1TcMIT0w=
X-Proofpoint-GUID: BEYnj2FKvi-ZmujHGCRmwoYVaa1Ded9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01

On 2026-09-08 at 07:24:35, Heyang Tan (thy15333007817@163.com) wrote:
> The rsrc_alloc debugfs reader writes rows directly to userspace without
> respecting the caller's read count. It also uses the current row length as
> the userspace stride, which can corrupt output when rows have different
> widths.
>
> Use seq_file to handle userspace buffer sizes, offsets, and partial reads,
> and write output columns directly to the seq_file buffer.
>
> Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
> Signed-off-by: Heyang Tan <thy15333007817@163.com>
> ---
> Changes in v2:
> - Write columns directly to the seq_file buffer as suggested by Ratheesh.
Thank you!

> +static int rvu_dbg_rsrc_attach_status(struct seq_file *filp, void *unused)
>  {
> -	int index, off = 0, flag = 0, len = 0, i = 0;
> -	struct rvu *rvu = filp->private_data;
> -	int bytes_not_copied = 0;
> +	int index, pf, vf, pcifunc;
> +	struct rvu *rvu = filp->private;
Reverse xmas tree?
>  	struct rvu_block block;
> -	int pf, vf, pcifunc;
> -	int buf_size = 2048;
>  	int lf_str_size;
>  	char *lfs;
> -	char *buf;
> -
> -	/* don't allow partial reads */
> -	if (*ppos != 0)
> -		return 0;
> -
> -	buf = kzalloc(buf_size, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
>
> -	/* Get the maximum width of a column */
>  	lf_str_size = get_max_column_width(rvu);
> +	if (lf_str_size < 0)
> +		return lf_str_size;
>
>  	lfs = kzalloc(lf_str_size, GFP_KERNEL);
Do we need this ? can we pass seqfile as well to get_lf_str_list() ?
may be rename the function to suit its functionality ?

> -	if (!lfs) {
> -		kfree(buf);
> +	if (!lfs)
>  		return -ENOMEM;
> -	}
> -	off +=	scnprintf(&buf[off], buf_size - 1 - off, "%-*s", lf_str_size,
> -			  "pcifunc");
