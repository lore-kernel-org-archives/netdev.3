Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8E391826
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563279; cv=none; b=NFL710rjjosb3dSJkt1xGy3hPKUahnoTa0Z5Lmexr3+tmCTIKrJ/bOJ+QOX+iTRjR0H9AN85Vz9/42u+i3G812nReGwIEts01j/leb9T/VByskhEyeWQTtKgtEVp04qZ2OOJEYnAOTPVzilDOVi0wMV5kU4P4GGqrQCWUOxx9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563279; c=relaxed/simple;
	bh=COoepY3IHCGDvrOdJwMdZwFCBacWNUZWI+Ma3V+69Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCF+2EzjD6gAgQiowV7JlsOOHFXo/7+BCnEu2Hgj4KqEl2/sU1qZYSzgN762RPtTqdmA5Xvq5zS6gze5IdksBRqi27UKnC/pmUjJAEWsZn2oHDz71nq02KcGV5mdrp+fzLqA+3IYYVszQ1rdx9y8Xv2YCI/Gh6fDoZlRvYm5UMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=VTsC5HTE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="VTsC5HTE"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82748095963so2999457b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772563276; x=1773168076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxvBm/svbAndJJLk+ZSBdX8462dd6PpqDbcqOUbb0IQ=;
        b=VTsC5HTEcDSYUJk0tgjA/ur95nQVMnG83zCrJgsznxBvPYMkyYNvcDnudDwHWIt8v5
         vTNnMeAKSt+LPHJzPmSvMq0N5Vjt2aL1qGxlDuwtWIDdG7OZF3t+/O+aXq3rFpWJmVdn
         kFv89fihdQFM2MQAHRxAcl1BeNO2lWEM9ciqGVc/TdKnNqKDmQ07p6aQjVG00ULwMIVy
         T/ywOeA8uLH88j8OOGwQ1gnI6heSFyE+/AtY5GRDcdnedcPJ/d4D3h/xtGp9tv6IbVOa
         Y902vgXH99MqUzmnyFHkCjZRcaEJCsYKmnnLFNxuiB/2jptjGIEnjYOcAvuZpbFLOA79
         rm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563276; x=1773168076;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxvBm/svbAndJJLk+ZSBdX8462dd6PpqDbcqOUbb0IQ=;
        b=t8Sr/PKG2oYMeHjdXGqnxlimcDDGE+xWmols4GURHGfphzFfrU0c+O8azikUz4Q+f7
         h8HW5i2jKhAp96kjvXXfmlQ3SyGLd7M258qnIxxfDR3KdDrCgZKHhIAzp6lhNku1vEVW
         Ja+T0dsGPiBIyxuu+80pUKUZ8vo6Or9fSw7oo7cfhSw/ydGqz1BwxA1FleNbFAaJntxu
         SP5dLmUG2kmsS+90nl9rHmwQeJRpv4LzVy1Dhomm6A6gENR2KLGuhbuUS355TUbZyjZW
         F/eGuMtxEYFPm9Ief39PFNuk4krgC+ZJR73WVT9HDpJf0suCuE5ZlXT9cHzaFZWUkLBx
         0f0A==
X-Forwarded-Encrypted: i=1; AJvYcCU1JxozYxy21j6d3Rx+4BDxeurFNnysn551BXFufrv+3f8Vedbknd0sz4iQ9FJC364t5Pk0pdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRohO6CfRJ+Rs1n1Rc5wg8Wh4Hy5PB1n0R/qUHIzivUu65U3Iw
	2TqWWsdJ+IjzGcpsOfX+YPizqvIvQiDzMr+GxopGjfZz6VzZiVdkVE6v3VXaVgj1Ybs=
X-Gm-Gg: ATEYQzwwd07TPfKA+OhaF9CQNhAcIFr9+rk2MDibq2GmocT6X3ig9jiFy1bzi9o7xgU
	1wmk5jPrbVmu6wP2nn6Zz9S4AopdqHligTIftvf0js95hBolhdwPLB8BBJeljH2O+FY5fgunAxt
	TGyGo5ZI24ImH0cLEWHeLjHBosG2r9E/BX/p7+I2EbAS19Q8TRE/llL4eaLPjFxl3b9qtkbBaTD
	GP2ecQrqHqbbvEx69i11M6cE/pff4iy0fBX1fv/FwTApVvdv/3Ck4WUvOuhajN6dCZRzDnYKRtI
	WQ4TFjG9lk6p6Fh0apN7/Y1Nay1ZJ8v2o1nM6ySozTHI/lk1xQDA0uWgf1JGrrrsw8Gqqyxquh4
	cy9IYYOGDX/fAl/7cvK+hS1zhqoq+TgoTnYcB1m4Tu60kavy4PtF6SnygFH2c1DukaJS6nJVkFa
	C96mg=
X-Received: by 2002:a05:6a00:189f:b0:827:2d0f:1ed5 with SMTP id d2e1a72fcca58-8274da07d17mr16120083b3a.45.1772563275952;
        Tue, 03 Mar 2026 10:41:15 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e78sm19760699b3a.17.2026.03.03.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:41:15 -0800 (PST)
Date: Tue, 3 Mar 2026 10:41:14 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <aacrSocsBAV9wZsT@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
 <20260303024510.644962-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303024510.644962-2-carges@cloudflare.com>

On Mon, Mar 02, 2026 at 08:43:49PM -0600, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c982aac714d1..ab73aad40593 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	bool xdp_active = false;
>  	dma_addr_t dma_addr;
>  	struct sk_buff *skb;
> -	struct xdp_buff xdp;
> +	struct bnxt_xdp_buff bnxt_xdp;

Not sure if it matters but similar RCT issue here.

Otherwise the rest of the implementation looks OK to me, you can retain my
Reviewed-by if you are respinning to fix a cosmetic thing:

Reviewed-by: Joe Damato <joe@dama.to>
