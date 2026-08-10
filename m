Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB12D7DE9
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786328630; cv=none; b=NaLptxtxJM3Hj8ec7JsZ1yj7xnomWO8yRFjyxeGbblmDL4cMyhCAUVxh1AmyjFUVfxro0h04CckAi9e33BW5BgRByZTeTh8crCKo9BPZv46PTh+5qrlyKmBnD5A2cHkhqukw1h5JLwZacesL67qdA20XhUEU66l1vdTRK4qJFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786328630; c=relaxed/simple;
	bh=brIXrSHMNh+w2+wqvBdY6ZLq52aicUd2kThuQ+xFW+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e91bFPiZCs5HUv2oo/TUa0hMgF+fLGynYG2MfF6TYu9UaEwUMqkn1kO/YhrRxpkzVNeJc59EBN3mdwFceDseVgZNpmL6q0mG1YrNe9e2NWS1K7Fv8DXnnuRFHvdwvIABQ+X0QbcRJpjaenMJfOm//G9B/+iyPK+H5JSYXfa3SN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukle3woU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukle3woU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso705586a12.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 19:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786328628; x=1786933428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8/Xu6Bl9nz3vhT2oV8jvDAfGpBWDs2/HnpOEeUYYe8=;
        b=Ukle3woUorjutusatcUOV+w/so4QfCzhHs1JAVMuDNrk/XsRMDs1glmFRHrONcXSQ/
         K1E4iT65wsrW/ErPgFxHim02hn9FN2u1JTwBxGBnjUzy4stsbgZvg3MIoUnK6bWmUcIX
         cmU8BJzWEaOA8Z7PZsKXU53M4MYCstFV4ztc1z/pmUX59KOU8AI0MQjrcxWuop2z0qkM
         4wtUcDmQePfEokOmb7cr4QSx7TxXwKKD4eQEMLBdxuagCHRD0pdysbeszR/EeiRlxC/a
         RJTy6wZ1huV6fWy7bTUAjSwB9Vv4Ke12ObvApLXUq52+EIFXZvf9PNit+CHdxmd++/p2
         MLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786328628; x=1786933428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8/Xu6Bl9nz3vhT2oV8jvDAfGpBWDs2/HnpOEeUYYe8=;
        b=OCAVZpYT526qEW6NblKX7L0cK37Q8TU+BLo9TdtZjVXZ19S6jsrCkqeEFnsquvLU6u
         BVS02EWG/Jh1a4G6o1ZO/Aewf4e+ywMGHqYV6Tf/jKmcmArTRbTtxRRHidtHlX5WuwaN
         br5CeVTgUZiz3flMsWa3eGN2eqFgn8zkn6Ed8qlSVwgHj3+wO2nlVApmi0S5W8AjLzgb
         NA6iCoxMs9ouWdwg0bjFl6EEt1F3iZfD9nalWhaRgJP8jqJR6h+fAqjnmzbmae+IKR1b
         aIa5tKPXq36yaJrGPMgA1anD5Gsg7BiMpKoIsB9TkPh3ErMCjWhHmr1raUw8pSHfPBf4
         WfbA==
X-Gm-Message-State: AOJu0YxfKofu6ybniQt4QWZjkH2ytCjpJUsSK/4BO4qmJLJvkhJRSwcn
	Cv3nN9hZxJcVjp62QrWyoITCDFHSkgC2cFqdPH8+QJ5UsLdeU5CLO13H
X-Gm-Gg: AR+sD11szH66OXJlhaEfL3ECSWCpaxgv1iJ28mJtnwueB48RamYfwKWmm0q5OwGANiJ
	gXwH0r8dCAO4OnHFwVvvw//twcRDplkrnfbrS48wOSnN3YIsmmNRALr44EFTtwzg9mx3chxIswA
	MJTCfD1cNFbZPGOCxn1j4ypmKHXdG2lPE8FxTpsjT++hiBIUN14LIdAVmSIUAsq1Lslc7opsnNN
	e76LlF0SpbbPEBt4Up9h5vCCiagcXbdCc9eknpphC9wdY3PiC6Zm+MDGkvEV0++p7OmG2dy2TE7
	4zZY/i5LyIu0Vl7EXQfPyvBzRG70K68OvLMGI8k+BAbwkIBaCQRRl1dUvWT7VvRfQJ1CTuwBdS1
	cG/hpSm/4uiNdytzX1Q9JsJSblzBto0b9DQdrwL1sOUIK025FMTgKWU3zKzN13VYwobKUkGMUJ8
	kq+lROzYBTtjOn1C4P/5rTlvDsMXZ/rV/+czspLWVKa5jqoxjGzn2t9VA=
X-Received: by 2002:a05:6a00:ad5:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84f2e021ff5mr41007248b3a.3.1786328627675;
        Sun, 09 Aug 2026 19:23:47 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58bd4bsm3074067b3a.56.2026.08.09.19.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 19:23:46 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:23:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/4] net: hsr: shrink seqnr_lock to sequence counter
 updates
Message-ID: <ank2JxDbOpX_wr5f@fedora>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-3-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809121455.1745-3-xiexinet@gmail.com>

On Sun, Aug 09, 2026 at 02:14:52PM +0200, Xin Xie wrote:
> Commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
> incremented outgoing seq nr.") and commit 430d67bdcb04 ("net: hsr: Use
> the seqnr lock for frames received via interlink port.") hold
> seqnr_lock across the whole forwarding path. Transmitting while
> holding the lock can create lock-dependency issues when HSR devices
> are stacked with other net devices, up to a real deadlock (see
> Reported-by/Closes).
> 
> Since commit aae9d6b616b5 ("hsr: Implement more robust duplicate
> discard for HSR"), duplicate discard is order-independent (sparse
> bitmaps), so only the sequence counter updates need serialization.
> Limit seqnr_lock to the counter updates in handle_std_frame(); the
> master TX path (hsr_dev_xmit()) and the interlink RX path
> (hsr_handle_frame()) drop their outer lock, and the supervision frame
> builders release it right after their counter update.
> 
> Concurrent forwarding may emit frames out of allocation order, which
> sparse-bitmap discard tolerates. The master/interlink tx statistics are
> no longer serialized; consistent per-cpu/per-queue statistics for all
> HSR paths are handled in a separate series.
> 
> Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
> Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
> Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
> Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
> Signed-off-by: Xin Xie <xiexinet@gmail.com>
> ---
>  net/hsr/hsr_device.c  | 15 ++++-----------
>  net/hsr/hsr_forward.c |  3 ++-
>  net/hsr/hsr_slave.c   | 11 +----------
>  3 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5555b71ab19b..3fd1762d8916 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb->dev = master->dev;
>  		skb_reset_mac_header(skb);
>  		skb_reset_mac_len(skb);
> -		spin_lock_bh(&hsr->seqnr_lock);
>  		hsr_forward_skb(skb, master);
> -		spin_unlock_bh(&hsr->seqnr_lock);
>  	} else {
>  		dev_core_stats_tx_dropped_inc(dev);
>  		dev_kfree_skb_any(skb);
> @@ -335,6 +333,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
>  		hsr->sequence_nr++;
>  	}
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  
>  	hsr_stag->tlv.HSR_TLV_type = type;
>  	/* HSRv0 has 6 unused bytes after the MAC */
> @@ -356,14 +355,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
>  	}
>  
> -	if (skb_put_padto(skb, ETH_ZLEN)) {
> -		spin_unlock_bh(&hsr->seqnr_lock);
> +	if (skb_put_padto(skb, ETH_ZLEN))
>  		return;
> -	}
>  
>  	hsr_forward_skb(skb, port);
> -	spin_unlock_bh(&hsr->seqnr_lock);
> -	return;
>  }
>  
>  static void send_prp_supervision_frame(struct hsr_port *master,
> @@ -390,6 +385,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  	spin_lock_bh(&hsr->seqnr_lock);
>  	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
>  	hsr->sup_sequence_nr++;
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
>  	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
>  
> @@ -397,13 +393,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
>  	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
>  
> -	if (skb_put_padto(skb, ETH_ZLEN)) {
> -		spin_unlock_bh(&hsr->seqnr_lock);
> +	if (skb_put_padto(skb, ETH_ZLEN))
>  		return;
> -	}
>  
>  	hsr_forward_skb(skb, master);
> -	spin_unlock_bh(&hsr->seqnr_lock);
>  }
>  
>  /* Announce (supervision frame) timer function
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0774981a65c1..8e4158a9b57c 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -621,9 +621,10 @@ static void handle_std_frame(struct sk_buff *skb,
>  	if (port->type == HSR_PT_MASTER ||
>  	    port->type == HSR_PT_INTERLINK) {
>  		/* Sequence nr for the master/interlink node */
> -		lockdep_assert_held(&hsr->seqnr_lock);
> +		spin_lock_bh(&hsr->seqnr_lock);
>  		frame->sequence_nr = hsr->sequence_nr;
>  		hsr->sequence_nr++;
> +		spin_unlock_bh(&hsr->seqnr_lock);
>  	}
>  }
>  
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index bb2182a169a3..8b96eafe15b3 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -73,16 +73,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  	}
>  	skb_reset_mac_len(skb);
>  
> -	/* Only the frames received over the interlink port will assign a
> -	 * sequence number and require synchronisation vs other sender.
> -	 */
> -	if (port->type == HSR_PT_INTERLINK) {
> -		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, port);
> -		spin_unlock_bh(&hsr->seqnr_lock);
> -	} else {
> -		hsr_forward_skb(skb, port);
> -	}
> +	hsr_forward_skb(skb, port);
>  
>  finish_consume:
>  	return RX_HANDLER_CONSUMED;
> -- 
> 2.43.0
> 

Thanks for the fix.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
