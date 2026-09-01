Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5D30ACEE
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276172; cv=none; b=bzXFEd8iTFlb9U1vRMkhliBjsS7ub/D45sZ0OigA6Kd8j/xmumK1xyloltKGQhLyqRRZiLCDA9/d7TLttMW4+PaGE+6baYfnqCOFoRlHKw4/mAciPFNqZz1oX9gGgw57lDxC8VBMwfJn8Rbp2TIknTmDLmHSo/YpKkl8+YWHlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276172; c=relaxed/simple;
	bh=dDQVSqCQZcwuWhg39szbqs+mWD4WMJTOIj/V9dQ8TUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ByPqU2VObxk04wWSZ5Ko5MOm8le0Tg28bwZwanNuVMxhgKWMUCEhtpS9PGPEwx2IwgU26SGIdRPTeF0ahpAvOIDdzpS+C8ESqe/UL9qu1jTDFOHdhvnvh2clQTu3PlwOESHJQud34Yv9DYsCnwE+390OW3BzgT/rCrCMhg72BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org; spf=pass smtp.mailfrom=pmachata.org; dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b=dfMr49V7; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="dfMr49V7"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hZ8kD6qRDzKm6C;
	Tue, 01 Sep 2026 17:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1788276165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FStWnfB8a+8DHifszIonnbpl2gF5B9Ky4NS2cEqJN/s=;
	b=dfMr49V7EWrSvNYZYa1EKsRzpJ1Ld0rr2SetndZ73r36KNCV76OlXqFJuFqJ8QbWXx4cXW
	VqGLUCVaKbZ+OFUpR/fhok3CQQXuiMEwrDnrs+TuR9f4YFE9OFinIw8Z6uxghQxq4Bbr7c
	OLGDKtgaQz3vzHgFp1LrJU7MWU5tzDac9yVspY5JsE32NxGqIGaWVvTSbpqCo2A43nzh6k
	/27h1rmcp/arKlp2YfwyaVzzlNIicb9JPDwL6JmGCV4eCCCZRSWhIVelqKlqRSoj6xBOvG
	J431JSr6K0w07askxRKgvDDmYiRWFWHwMHp16W+9wiRzdodX9SZDhbjaeHVacQ==
From: Petr Machata <me@pmachata.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org,  Stephen Hemminger <stephen@networkplumber.org>,
  Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH 2/2] ip: ipstats: Do not hide HW statistics when
 hw_stats_info is missing
In-Reply-To: <20260830181949.1096-3-green@qrator.net> (Alexander Zubkov's
	message of "Sun, 30 Aug 2026 20:19:49 +0200")
References: <20260830181949.1096-1-green@qrator.net>
	<20260830181949.1096-3-green@qrator.net>
Date: Tue, 01 Sep 2026 17:22:42 +0200
Message-ID: <87a4q10zel.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Zubkov <green@qrator.net> writes:

> ipstats_show_hw_stats() returns as soon as the
> IFLA_OFFLOAD_XSTATS_HW_S_INFO attribute is absent, silently dropping the
> counters that the message does carry. __ipstats_show_hw_stats() already
> copes with a NULL info attribute, so let it, and skip the record only
> when neither attribute is present.
>
> There is no known way to reach this through "ip stats": the l3_stats
> descriptor always requests HW_S_INFO next to the counters, and since the
> previous patch the two are reassembled even when the kernel splits them
> across messages. This is a hardening measure so that a message carrying
> just the counters is displayed rather than silently discarded.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alexander Zubkov <green@qrator.net>
> ---
>  ip/ipstats.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/ip/ipstats.c b/ip/ipstats.c
> index c531885f..54b8267d 100644
> --- a/ip/ipstats.c
> +++ b/ip/ipstats.c
> @@ -472,13 +472,16 @@ static int ipstats_show_hw_stats(struct ipstats_stat_show_attrs *attrs,
>  	int err = 0;
>  
>  	at_hwsi = ipstats_stat_show_get_attr(attrs, group, hw_s_info, &err);
> -	if (at_hwsi == NULL)
> +	if (at_hwsi == NULL && err != 0)
>  		return err;

I am pretty sure this is deliberate. The logic is, if we do not even get
hw_s_info, then surely we will not get hw_stats either, because the
kernel is supposed to provide information about the statistics together
with the statistics themselves.

Now this did not take into account that messages might be split. But
with your patch, this is will not be an issue anymore either.

On second though, it is not the task of iproute2 to policy the kernel,
and when life gives you hw_stats but no hw_s_info, you make hw_stats'ade
or whatever. So I actually think the patch is OK.

So,
Reviewed-by: Petr Machata <me@pmachata.org>

>  
>  	at_stats = ipstats_stat_show_get_attr(attrs, group, hw_stats, &err);
>  	if (at_stats == NULL && err != 0)
>  		return err;
>  
> +	if (at_hwsi == NULL && at_stats == NULL)
> +		return 0;
> +
>  	return __ipstats_show_hw_stats(at_hwsi, at_stats, idx);
>  }
