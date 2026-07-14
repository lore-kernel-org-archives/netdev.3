Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A08481657
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044242; cv=none; b=JxP0WKm3k8eKgIWMFHxHCdDjfHvPoTv3vbuOgIky3pd68ry4kjpPYo6y7BsYFFYcheBFy/gZtfdHFCOv8xSud2n8RkEGbk0QnzXqQVnQq9wAPo8oFxWJ2Mw5FFbY38J2XXB8TyJ9qw+zc/otshv3ZydNhgjby3jXjEbBAu1BNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044242; c=relaxed/simple;
	bh=Pd1Ltd3l6EG/6nUOsfbwWdRwYflJbdo1LeRCyZqxpYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTSzER1wvIJhGk9jTRKpM59Yoa0uqv/BvNfhwC92x4+Nk1uguTDDeHClmaKQPQ6GKh3JTFvQTuUPz+SOcAxigtwr+IIA4gY1B8Qu473Wt0YRhE4z62YpKcexHf794ApxxBkOIC8foec0qUMPaT1UsfRo7VFGB/SI3DOqzQX+NRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S6v0NJ24; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S6v0NJ24"
Message-ID: <06829124-18b1-478c-9f6a-d9ec372158ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784044237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uPxwbeZ+GlcGGeZnRjg0fHtrtYAdcDgirSNi4lmFS4=;
	b=S6v0NJ24lum/7z1mrWiTNobXaDzLvOl++oh5KUXRF/aA6ycOkTvNZJbdQlQ+tGpxVCEXzF
	QjpFU3gRviIynSK/LfYh+MpCkq1wW0luAL/iTLTRLMogoGm2u65VJPxKhE+DJWbyACj5sA
	3Tef+xYdbx2iwxvgU2wtAh8ZH2xyE4w=
Date: Tue, 14 Jul 2026 16:50:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] octeontx2: Fix Klocwork issues in AF and PF drivers
To: Ratheesh Kannoth <rkannoth@marvell.com>, davem@davemloft.net,
 linux-kernel@vger.kernel.org, naveenm@marvell.com, netdev@vger.kernel.org,
 sgoutham@marvell.com
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, Suman Ghosh <sumang@marvell.com>
References: <20260714020241.1810407-1-rkannoth@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260714020241.1810407-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14.07.2026 03:02, Ratheesh Kannoth wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> Fix null dereference, uninitialized variable, and error-path resource
> leak findings reported by Klocwork across the OcteonTX2 AF and PF code.
> 
> Fixes: 818ed8933bd1 ("octeontx2-af: Re-enable MAC TX in otx2_stop processing")
> Cc: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c      | 12 +++++++++---
>   .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c   |  8 +++++---
>   drivers/net/ethernet/marvell/octeontx2/af/npc.h      |  6 +++---
>   drivers/net/ethernet/marvell/octeontx2/af/ptp.c      | 11 ++++++++++-
>   drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c  |  2 +-
>   drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c  |  2 +-
>   .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c  |  8 +++++++-
>   drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c  |  2 +-
>   drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c  |  2 +-
>   .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  |  1 +
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +++
>   drivers/net/ethernet/marvell/octeontx2/nic/qos.c     |  1 +
>   12 files changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 2e94d5105016..70c8ef5f0be0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -491,12 +491,19 @@ int cgx_lmac_addr_max_entries_get(u8 cgx_id, u8 lmac_id)
>   u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
>   {
>   	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
> -	struct lmac *lmac = lmac_pdata(lmac_id, cgx_dev);
>   	struct mac_ops *mac_ops;
> +	struct lmac *lmac;
>   	int index;
>   	u64 cfg;
>   	int id;
>   
> +	if (!cgx_dev)
> +		return 0;
> +
> +	lmac = lmac_pdata(lmac_id, cgx_dev);
> +	if (!lmac)
> +		return 0;
> +

this 2 checks are added for impossible cases. both values are checked for
existence in a signle caller of cgx_lmac_addr_get(). Please, do not add
defensive code for no reason. I didn't check other changes, but I believe they
are of the same quality coming from yet-anothener-anaylizing tool.

Please, provide stack traces if these checks are really needed.

[...]
