Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4E40862C;
	Thu, 13 Aug 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617682; cv=none; b=HvvOF6UbyOSAUPyI3pOgxy560VyXfO2gCfFDhZz2C/OoujaE+8F5CnNN2D7NjnEaZKFkSPBFVgIa4TZCL6+mZK3lrbtSqRgXX5bnLyJ5YatDyth1cQlltTL+r2CR9GehEpnDg61MGFp32wqGDhOwirTb/PP8cfvcW4/oYgaISV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617682; c=relaxed/simple;
	bh=40Hv8THBLGy9rCrzhYAdJjHwnEvnVqZko8YTkJjhKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9tB07xfubkOP9CKY6Vd1X67NVxQMwq0eisWmJZkRcLIqxIUyCpQyNUvhPen7XY3wl/5xws/loWRaifHbSLJkpgXrq2zdMWmDf4CxpKqsXOJbkDw9++EGweRV+dy8LbrnyC+tGYy+GUWOY27mPLkjw/vCM3ZQG0iWg/OezVLh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=g75u+Yyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgJ0qx0H; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="g75u+Yyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgJ0qx0H"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE6927A00FE;
	Thu, 13 Aug 2026 06:41:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 13 Aug 2026 06:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786617678;
	 x=1786704078; bh=N+TbeFEDz7QDJaax9vmGb90pQEB+ILX8FqA7sEhjdog=; b=
	g75u+Yyl6+AtYqOyto1M2doXLU9tyjrKg/fQEdyk2eXNsCNamznXfIuoSCAFVU7l
	MWhX2nuWJO2DbxgFYAHSsiLhDW54ucBm8kBod8P+8uCmhL0iTDvhI5nphoPI6odf
	nJeJcAKZvxF4Trxo58dhqu6irHnHTzZRfDpfgiaFyxnzcTx5oPsv9KicDneIqfbA
	Q4ry1XwiaAjJmw+YtsIJxbQkDK9qx0YOgaUxuX5OSXSw9QcrI4ka9czLmIn1rSOZ
	RSTCLlHcZTg8qMPICm8X19ErNIDj6fO0+Rtxo27xcKhn2m5CbmLLYnMTxxACk0FC
	wBH07omZdnDr1zV+TRCB8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786617678; x=
	1786704078; bh=N+TbeFEDz7QDJaax9vmGb90pQEB+ILX8FqA7sEhjdog=; b=T
	gJ0qx0HgMgXtKxCH3NOxBjw/WSjqlj08thdff1yR/TiXc8v5SoK/u9csSEHQqFTN
	WEIhKycbJTa6wQsaAHMBnarfPsG9h9LhL1xlN0/08AF80BWfhwVHIKx6DsG+M6cF
	T4Pz5u9iTit4x1s9FBv/FZ9x03ASYdnbk3LvO2KCnrpv47YLAt2+RVI5hpbpghRt
	w1aS2I/JR+CLxRSwgDT9jpY3SzIj7jELtAEjQdmYFSRhOqjItnI2aZVTEUAOo0K1
	fJpPvbNwOamSxNgBH44RTfC+DuM/5vCp8EiubXWRD8unT6vDa1LezaZ5k6ZKju+V
	A8hmUD4I99S8EPlHUgSXw==
X-ME-Sender: <xms:TZ99apyPQoMRNJATwLqKEJ6Nxp_Yjc82J8VDsc9wAfHo2u2CVqn8eA>
    <xme:TZ99avzsmsHIcRHhkh4eaMBzI15K-X0g7R6uLrABeIqB35l-uyG6YLAGcX3VAs-Uj
    Ex5gKKs-72QYCciGBNcJMU4iwWst6wF9Gsjug7mlxAA-AwDTrRe-50>
X-ME-Received: <xmr:TZ99ahVaGzkIhyKD0uiPfJeVMu_O1RJRDuLO2eXUDVKGIAiLgCoIeYZnnmOeYirxyxeqjL_GuJw8qd-oXJWjfogDPEvWToA>
X-ME-Proxy-Cause: dmFkZTGsHrBP9vRnPwQ+Uv/DigyeHPgHhztGSjPtRV7GXJrXZw/OmOVXsxMdRvAavoeMIl
    6SFyaFtLzVFEDfoqFbWnz+5odpBmlN70IBWgxBTIKjJXG5hXyeGB6Zi5nFUOzSZqunrq7i
    //Wb7Dcfx1xidAAth6Hy2jDXr1RqofbYepQ649FnqvDfdFNPOtM4JfoRBlMNr1uOUPW7uo
    43DRGZ58fkb4100Qm+ur+SIiI9hrXS/xdcpXo3m2yO6Kq43XQH40pupLrFQ7WDkr9bRrMA
    o+TlsAhalcKNur2CDtfsq04sG/DRWH0PRkdh4w5nJxbVn0nNDy82J/NCSVy2YzjgPTq8DN
    6bIOPgiJmmK0GJq56FVhsAd5JRU1laa+rU9fg8VIv1ZHt9hamSGUd7Wdu9q9lpBB/EdPb+
    EbLXCZ+gHKfvd4mF3ecxVCWOfPZqs3FdLNzZBEb/InsLCeoEU0toaYm1S9reXQ3uDnqvdw
    j0342OTINZNYeqpu96XiFv95OcBWG3n9QsCM8gyEcXtFqgyIe8coEs75V2weW/cwXnKgvd
    91pDHJk6DmC44OGt9ZCqd0dlhANG/qkMWzZWHTkPTgR0j9LkaEEA/Sn0Yue2ZTmMcIFIeS
    4jMBQu2oqwjmT16YQ01TArddZ/AnWnUQO7hS+1II6Go1a9S06m8NdrgKBK4g
X-ME-Proxy: <xmx:TZ99auSEmjJJj7ZNfI2LheUylG2uk3rOZxL3e-6k_bCyEPO9gSAXuA>
    <xmx:TZ99ahRQTRO9uHVnHgoqn-Ce0KpckrYEpcLvQCWePkr8XdlzaJW0qA>
    <xmx:TZ99aucDE3bnUpo7YFtDoBIWldQ_RtN5LazlL2ioUuwSkZyu0f6fsw>
    <xmx:TZ99aveABQ51zOaK1dykATsMyT2Gj-Ot_WR4k8X4heSieW2SEyP0iw>
    <xmx:Tp99alUjMJ2-epFYOZ23TpMG3HJvkhNLP2wPhoibsx4XEEU8J450N8q1>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 06:41:16 -0400 (EDT)
Date: Thu, 13 Aug 2026 12:41:14 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	kuba@kernel.org, vadim.fedorenko@linux.dev, paul@pbarker.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 0/2] net: ravb: fix PTP clock lifetime
Message-ID: <20260813104114.GG2757863@ragnatech.se>
References: <20260811103733.62599-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811103733.62599-1-xuanqiang.luo@linux.dev>

Hi Xuanqiang,

Thanks for your work.

On 2026-08-11 18:37:31 +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> This series fixes RAVB PTP clock lifetime handling. It reports a cached PHC
> index without accessing the clock pointer and drains PTP interrupts before
> unregistering the clock.
> 
> Patch 1 caches the PHC index and handles registration failures.
> 
> Patch 2 detaches the clock with xchg() and drains the PTP IRQs before
> unregistering it.

These patches are rather big change adding READ_ONCE() and WRITE_ONCE() 
to avoid a LLM warning? Or have you hit a real issue? How have you 
tested this work?

If you have a test-case could you share it? I have a pending series [1] 
that cleans up the whole RAVB driver ptp management which have grown 
rather organically. It have a small fix for the missing check of 
registering the clock. Would it be possible for you to test your work 
with that series too?

1.  https://lore.kernel.org/all/20260811160200.2049987-1-niklas.soderlund%2Brenesas@ragnatech.se/

> 
> ---
> Changes:
> v4:
>   - Rebase onto Linux 7.2-rc7.
>   Patch 1:
>   - Cache the PHC index separately instead of locking clock access.
>     (Vadim Fedorenko)
>   - Reword the subject and update the commit message for the cached PHC
>     index approach.
>   - Add Vadim Fedorenko's Reviewed-by tag.
>   Patch 2:
>   - Replace priv->lock serialization with PTP interrupt disabling and IRQ
>     draining before unregistering the clock. (Vadim Fedorenko)
>   - Use READ_ONCE() and WRITE_ONCE() for lockless clock pointer access and
>     xchg() to detach the clock atomically.
>   - Track the error and management IRQs and synchronize all IRQs that can
>     invoke the PTP handler.
>   - Update the commit message to describe the interrupt handler race and
>     the new teardown sequence.
> 
> v3: https://lore.kernel.org/all/20260806095126.57803-1-xuanqiang.luo@linux.dev/
>   Patch 1:
>   - Omit Niklas Söderlund's Reviewed-by tag because the implementation he
>     reviewed has changed.
>   - Describe the NULL pointer dereference before the first open as the most
>     likely failure mode in the commit message. (Jakub Kicinski, Sashiko)
>   - Normalize PTP clock registration failures to NULL.
>     (Jakub Kicinski, Sashiko)
>   - Keep hardware timestamping capabilities independent of PHC
>     availability. (Jakub Kicinski, Sashiko)
>   Patch 2 (new):
>   - Serialize PTP clock publication and access with priv->lock, and detach
>     the clock before unregistering it. (Jakub Kicinski, Sashiko)
> 
> v2: https://lore.kernel.org/all/20260802090750.116215-1-xuanqiang.luo@linux.dev/
>   - Only advertise hardware timestamping support when a PHC is available
>     (Niklas Söderlund).
> 
> v1: https://lore.kernel.org/all/20260731063254.71260-1-xuanqiang.luo@linux.dev/
> 
> Xuanqiang Luo (2):
>   net: ravb: avoid dereferencing an invalid PTP clock
>   net: ravb: serialize PTP clock teardown
> 
>  drivers/net/ethernet/renesas/ravb.h      |  3 ++
>  drivers/net/ethernet/renesas/ravb_main.c |  9 +++--
>  drivers/net/ethernet/renesas/ravb_ptp.c  | 44 ++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 9 deletions(-)
> 
> 
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> -- 
> 2.43.0

-- 
Kind Regards,
Niklas Söderlund
