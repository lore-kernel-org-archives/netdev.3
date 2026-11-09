Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246352;
	b=TInYC9gX1Ok3heyY96Zmxqy363NYZyN9WkonBTrgWu6+11D1kdhQ294QLnzXYhGURDOS
	 9ieB41J3BKGjHvIECLDxa0z6+vU0bAydp/11H1D9vlCd4XcmmYcImUtfWcXoIoj3KDsFW
	 FmWs0fVCLGgZ3kt/r0J6ZKaGP92bVFyRyq+t8iscjGWnGWKJ/MOaL6zOE8nvTKxU3Sew6
	 bjFMy3i68MCoZf5IWqOXY7wLo2a8vB26DFbgI+xvP9fd5P6sYi4XP2VpFsek130dH7Gwu
	 paoHgIVutClT9CxlmBA0olTVETrc9kN6XDgC8c5K51f2Bk76YQudn7HgbpdSzFwbf+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Si1qr0FYlgYaa7aEt7lVrrFDFWoP/sB4RXZcugVCzwc=;
	b=HET3K95bAZwYJcVz+ueKcTpr+JWX0f0MGEj4L3E3/xBawICPxYOCkwYLot37mk5ONqV7
	 z6fK0Qb0a9xK2uqjBicnchXaw/Cx1r9EoFugbLsWhMU55N3rcKLX4qeQQV0nESBEfXY4n
	 ityh9I3qPUN/WlSmh+onofDoHXD8y+5GfNtLSt9qSF14jPzMqjDzIQEA7HBpPxCW334YV
	 /O955q4ESyjscaUgssKLglHTfciXU1ZF6YMmmJXr1QsEtMamKuzep55w5WZ3hkQMacoFT
	 Frpflu7fmXICHPIqNQnyhV1YNhDkMYVrNVrzJ+4Ra58v1ZnkseGEO8v4fuNgQnwx01A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=s1hdktMa;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525D606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9525D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=s1hdktMa
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a05b210703so538348b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794246351; x=1794851151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Si1qr0FYlgYaa7aEt7lVrrFDFWoP/sB4RXZcugVCzwc=;
        b=s1hdktMa4eev/Xy37ge0y053vKHhohuEhfKbyyLGZ8LhehfDfc7Aa6wgvj8JlFdDIV
         dyBTAaZ01JBpEwl/xyUBNHrukY2FPWOHOlKH2EUZ9LtH82OwqyZBQYFoihKUeBfR4Dod
         LgF+/qrvAT9UuLDXWl1Y6p+h9axQtm5UsHRDWJ3QtCZUcnZs3NGSsvinvVwsc08xotdG
         GoOWfQYQ1mNv4EHZtnaAhjn2alXJPY7zFG7Sd5i8zPKp/YAFfs3u8dZcv6D14loi5J5h
         GhCWK2MsqUyjSRDeOvO8jO1/zjXEU3grOLYeeni9spd1jqtDBAku5qpX95f8Lr+hWhG5
         Di/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246351; x=1794851151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Si1qr0FYlgYaa7aEt7lVrrFDFWoP/sB4RXZcugVCzwc=;
        b=sHe9A9UFXk9hE2hsuX+2FbvqcAcWIIK2Y3EYYg+C09tpRe7oKKHmiKOyB0g7/kG0WE
         YrPFQue6yhBeJYge/aaGlqUdGug9i/CenWcujfbpTqnjgr/PbirjZioG17x8s2u0RMFJ
         V9rTYzSeY6K1K4ra13P/dbKJbw82NXoAwnBIhCb0pcULwkDyU99cmzoDXkYOGcKfQ4mM
         eJDgvpQjLN2tTgAPoVSPKhOIY3Zyq/uGRw97kfysGREl0a5RotOTA6TuyH/W0y7oPmp/
         ng1DGHb2dCCpyf59ndHhauslGV8OsD2c8PzUmkfmlip7yxnSGU1npHy4klqHSDBY7p/K
         kK3w==
X-Gm-Message-State: APuU4Z8nkqpBJORL02lofu39rFYpnwFswkavL0a8APpPDsWge7p/7oXq
	CN0Ht9S2jIpfIY9Dbn6FL13BuxwCBWvveWu3XfNSEKheJVpSCS2diwnS0Cikg9sKWBU=
X-Gm-Gg: AYBFou2vkiSXSPw5rZdjaBSvTf9+AlfH8rXViWVXDZrNkqqtD+QCDc47tD40OlyoKw1
	9ZAcA9lHjF9Y/vHIKeEByVbfdIZhx+g29k0/dYevtfoECLXkwU7FnNU+oAIDUKjrtGSkiDIN+f1
	Xasiz5wj/M4RUqq3k4LY8iUQ7GCA3YzsilxZhQxXl4ndLPts5sSYSKRZHH43k4KhN6l/ATfLtHw
	jck7xjuLizI9eX0LCLQQi4g5xW6Hbx4v7x/ot32cwyd8BlG/R3xTXHTfEzLCBEqweQiZci7vEiy
	Nn0J2Gvgn+nz2hCLsApMDvTp0nkTOuhFITI2LYLXg5F9Qr692N7nHPzE0QI3jOM7zZzwpz0hN2C
	Cgu2rOXzL2Mcz9IysowMQYxNSmNNOIT15raVNjIAfPO7GUXrk7YW6qhi5TsuFbw9PP5IDEc/YeB
	JW034ZVdl/kG/BI72PtKwZJMPIkxeRUS6/2ohSxZi+HCfl50kvhCURx/DVg3edl2/VUsuLkq4gB
	SQkER9FGnJpVKiqAyCtMMzKOuUJRGhQILRwPB2XRTzO+7BK6nxSTz+P7qfx6IB3WfmRaZXQJYq+
	sVR6QZ8WwNg4j86GsUCIJJurUYq1f8aZrJxui8CcEA==
X-Received: by 2002:a05:6a00:1817:b0:87a:3144:8c4c with SMTP id d2e1a72fcca58-8ba87e0c270mr330184b3a.59.1794246350855;
        Mon, 09 Nov 2026 09:45:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64a1e1cc9sm1671290b3a.50.2026.11.09.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:45:50 -0800 (PST)
Date: Mon, 9 Nov 2026 09:45:49 -0800
From: Joe Damato <joe@dama.to>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, prashant@broadcom.com, edumazet@google.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 1/4] bnxt_en: return the RING_FREE status to
 callers
Message-ID: <avIGzUc6WaGgYBKG@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, prashant@broadcom.com, edumazet@google.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
References: <20261106191423.4194081-2-joe@dama.to>
 <179408152976.994134.11735257663578231009@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179408152976.994134.11735257663578231009@kernel.org>

On Sat, Nov 07, 2026 at 07:58:49PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch makes bnxt_hwrm_rx_ring_free(),
>   bnxt_hwrm_rx_agg_ring_free() and bnxt_hwrm_tx_ring_free() return the…
> - [Medium] The commit message says "All three ring free helpers that send
>   the command discard the value", but four helpers send HWRM_RING_FREE,…
> 
> --
> 
> bnxt_en: return the RING_FREE status to callers
> 
> This commit changes bnxt_hwrm_tx_ring_free(), bnxt_hwrm_rx_ring_free()
> and bnxt_hwrm_rx_agg_ring_free() so they return the status from
> hwrm_ring_free_send_msg() instead of discarding it. No caller acts on
> the returned value yet.
> 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 33c4cacc8ffe3..ea8529c789947 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -7679,50 +7679,55 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
> 
> [ ... ]
> 
> > -static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
> > -				   struct bnxt_rx_ring_info *rxr,
> > -				   bool close_path)
> > +static int bnxt_hwrm_rx_ring_free(struct bnxt *bp,
> > +				  struct bnxt_rx_ring_info *rxr,
> > +				  bool close_path)
> >  {
> >  	struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
> >  	u32 grp_idx = rxr->bnapi->index;
> >  	u32 cmpl_ring_id;
> > +	int rc;
> >  
> >  	if (ring->fw_ring_id == INVALID_HW_RING_ID)
> > -		return;
> > +		return 0;
> >  
> >  	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
> > -	hwrm_ring_free_send_msg(bp, ring,
> > -				RING_FREE_REQ_RING_TYPE_RX,
> > -				close_path ? cmpl_ring_id :
> > -				INVALID_HW_RING_ID);
> > +	rc = hwrm_ring_free_send_msg(bp, ring,
> > +				     RING_FREE_REQ_RING_TYPE_RX,
> > +				     close_path ? cmpl_ring_id :
> > +				     INVALID_HW_RING_ID);
> >  	ring->fw_ring_id = INVALID_HW_RING_ID;
> >  	bp->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
> > +	return rc;
> >  }
> 
> [Severity: High]
> The per-queue callers of these helpers still ignore the returned status,
> and none of the later patches in the series seems to change them. Can
> the queue restart path still release rings that the firmware did not
> free?

The per-queue callers should be fixed in a followup to net-next, IMHO, because
this series addresses a real failure seen in the field on production hosts.

The per-queue callers probably would fail in the same way, but that's not a
failure I've observed so I think that would be a separate followup.

So, I disagree with Sashiko, but if the maintainers feel differently on this
bit, let me know.

> > -static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
> > -				       struct bnxt_rx_ring_info *rxr,
> > -				       bool close_path)
> > +static int bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
> > +				      struct bnxt_rx_ring_info *rxr,
> > +				      bool close_path)
> 
> [ ... ]
> 
> > @@ -7730,14 +7735,15 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
> >  		type = RING_FREE_REQ_RING_TYPE_RX;
> >  
> >  	if (ring->fw_ring_id == INVALID_HW_RING_ID)
> > -		return;
> > +		return 0;
> >  
> >  	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
> > -	hwrm_ring_free_send_msg(bp, ring, type,
> > -				close_path ? cmpl_ring_id :
> > -				INVALID_HW_RING_ID);
> > +	rc = hwrm_ring_free_send_msg(bp, ring, type,
> > +				     close_path ? cmpl_ring_id :
> > +				     INVALID_HW_RING_ID);
> >  	ring->fw_ring_id = INVALID_HW_RING_ID;
> >  	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
> > +	return rc;
> >  }
> >  
> >  static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
> 
> [Severity: Medium]
> The commit message says:
> 
>     All three ring free helpers that send the command discard the value.
> 
> Is that count right? bnxt_hwrm_cp_ring_free() also sends HWRM_RING_FREE,
> and it still returns void:
> 
> 	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
> 				INVALID_HW_RING_ID);
> 	ring->fw_ring_id = INVALID_HW_RING_ID;
> 
> The inline NQ/L2_CMPL free in bnxt_hwrm_ring_free() also drops its
> status:
> 
> 		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
> 			hwrm_ring_free_send_msg(bp, ring, type,
> 						INVALID_HW_RING_ID);
> 
> By the end of the series, bnxt_hwrm_ring_free() counts stuck rings only
> for TX, RX and AGG failures. If a CP or NQ RING_FREE fails, would
> bnxt_stop_dma() be skipped, with __bnxt_close_nic() going on to free
> that ring's memory in bnxt_free_mem()?

This also seems possible, but this is not what I observed in the field. On
three hosts, the NQ rings failed alongside the RX/TX ring free failures and so
if this series were applied DMA would be stopped.

I suppose it is possible that only the NQ or completion rings fail and this
series do not handle that case.

As with the above feedback from Sashiko: if I understand the requirements for
net correctly (and I'm probably wrong), this series addresses actual bugs seen
on prod workloads.

I'd be happy to send a followup to net-next addressing both points above after
this series is merged.

If the maintainers prefer that these other failure cases (which I did not
observe in real life) are handled in this series, please let me know.
