Received: from mail-qv2-f38.google.com (mail-qv2-f38.google.com [74.125.230.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D153033C6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272199; cv=none; b=Qy77p2SfYlCkS6dYn+q2I7vRiz+gMqlpTB+HXu47mg66axkPusgDc0F654RZnK7yZrTBHCgch7+a8sPvhgITzGSFsqWM9htarORWzBXIbozZTfHnjF5G+w/7c9Y+cFmbWqU4fOvXj20t66kbp0CbmL/bL/TRpg328MBzzG7yo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272199; c=relaxed/simple;
	bh=RXy7Ou1QOWH8eM/PoNMBdCMAjt0T9ASDa5ZCQDCjObU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QUQA3u0Sw4VPYppBi0ETfEwgBZdO/Wef/JLwluiZWZBqsBgSXI+hMUes7/YirdmXR8biXDAcV6dcJquSIje/g8pvYcopaxV5PBDHaIJ4A1SEQ7drgtaRdOJbTiNUZfwSONu2WRcOP/DZXkbZGgThc3kf31GzBQhTcPMhoitZrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/MvyOmn; arc=none smtp.client-ip=74.125.230.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/MvyOmn"
Received: by mail-qv2-f38.google.com with SMTP id 6a1803df08f44-9107051ba26so1138696d6.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790272197; x=1790876997; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jhMxAV05it6pd2NHiFs1D8r78fRLUTSgrzLPRna3ABY=;
        b=H/MvyOmnhBqDd3ZuLmLt2IlqlsCyMPrD1m8XtT3RzIwzGR9vaA63gnC4neJoutU5JK
         umFWsBVlnBqF3pKt0R7B+Pl+NY8R+RtUEmTpblmZoti6qihutF3ObWJHwHzVegEj2OtY
         olShFTZcn7VtriSbMBf5rnDkFNFKdPENQRroydjQFBcRttyJT3G0upAZgJc4nvqvCj4a
         RqEqo7bYWI0T3Bw9bkbiS0+Mso0ZrVfi6jVjRhq/nJqrNCrM/9joZcmIIBsI1I7y9inD
         hp3ptlDoVGpGN0k8/hfXfejNhdJOLnJYzm2fP7sY2hZFtl+zOY6PJJJJV04qm+fVpbV0
         LoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272197; x=1790876997;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhMxAV05it6pd2NHiFs1D8r78fRLUTSgrzLPRna3ABY=;
        b=ufs7HSoE6USh438UfhHJtm7cfHongCnIbMdIgtpbTpRYj3IXZjwD0IUxSVCF6XjM1x
         Z4Pc8JjuyhyMJQErCw88wgSwnsmV3mNfooQ3z4UO4iVxaMF1/F0DQxw7xQQ4vaBclNNZ
         ZTyLCgsEa/NNUttPd6+l8E+7x1QuVc1pSzEoHmzpYwfhlV5yS+kxZcX4qwl1c2sqeltD
         peCL4UEaEJ5heebE0A8BQOBGdmCpP9Ht3a66EUhkIlecfnO9BuPCiifXHFWTYk2ihG4E
         qTSFvp+qHqbzURwqRy4HYvBVCZn6L/4EsH1SI8TuP6jkKcum8Davh8FJvD/fdhNrmg0e
         Xa4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzLsiwUILgMTVJ+Q7UOo2hK6WY2oj3i/jaLdLv0vf55VB1HX3rkn+opu0SkLEPe/zoHeW3GVKU=@vger.kernel.org
X-Gm-Message-State: AFuF++kl8vw6fYEwGE8BUuiIB0ZYDXTPLWQQgCL6AH/oT7/LsYlD3sJh
	ha5TpB4nOEyfLfEHP0Pyx4y2j5HsML3j5Oq9MxvLzr/7QHQxfldzwxVW
X-Gm-Gg: AYBFou0HpRiNNKt8TynRI6yYEZSxTXGxErAu9JIz9YOjE3rat6PCsXzhna430h/8Cjn
	FuDiE8pVGJ4D/LU0fdjDDSYVskqPxp0phKutCWIHZBihM/KK+auLLGyhKWZXUK91nCGMXMmehf+
	pVdbU2N7veHHuNMqFUJGA6ovx11EL3PAoIHI0jRzm3asoOABFhq6e7CAlM27foxwurYsTlunuJA
	ih2SR/30+E8AmiohVXMmBv5Rsi5yeTPwUWvOAA1WJr8H0vve9tSn2Q/68wyIRZi46jBfDOCNyfQ
	LYPx3A5WA52mTyr9Kyuyowm5+Wpi8pCGIs5FjD7h3SN3XMq27lR62yyMnAcXaAlyERb+Xh3Jcg7
	SJW/7T/ARnItFCRQqF6JYbdYLIYRYSbbCS25fvG1h26ujRNe0Wm6jjmB6SmzcEAGyWaZT3LvR2w
	v3Hw7rHXfL2DrQ8B8XQ5n1xdc1LEnfCovsyzx94h8hJzMNxmDSyX6ADr1KJLFdhdqn7gXZ1bteI
	MPleJv1UVhnmA==
X-Received: by 2002:a05:6214:4a05:b0:912:517b:7be0 with SMTP id 6a1803df08f44-91421f1b16dmr42393266d6.43.1790272196522;
        Thu, 24 Sep 2026 10:49:56 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914271c4aa4sm10042626d6.44.2026.09.24.10.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 10:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 13:49:55 -0400
Message-Id: <DLNQJ0HDQBGV.2CDQAQ64FV1NR@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 5/8] eth: mpnic: start and stop the Tx HW
 queues
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260922-linux-mpnic-v1-5-236844f53072@gmail.com>
 <179021553598.2160803.16775147198934716952@kernel.org>
In-Reply-To: <179021553598.2160803.16775147198934716952@kernel.org>

On Wed Sep 23, 2026 at 10:05 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] mpnic_wait_all_queues_idle()
>   (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:599) returns void.
> - [Medium] mpnic_non_idle_queues() (mpnic_txrx.c:569-570) counts a block
>   as idle when every idle register reads ~0ULL.
>
> --
>
> eth: mpnic: start and stop the Tx HW queues
>
> This commit programs the Tx work and completion queue base addresses and
> sizes into the hardware, and adds helpers to enable and disable the Tx
> queues. It also adds mpnic_wait_all_queues_idle(), which polls the idle
> bitmaps of the TWQ, TQS, TDE and TCQ blocks so that teardown can wait for
> the DMA engines before the rings are freed.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index fe360a26a27be..cb4d1427434c9 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> +static u32 mpnic_non_idle_queues(struct mpnic_dev *mpd,
>> +				 const struct mpnic_idle_regs *regs,
>> +				 unsigned int nregs)
>> +{
>> +	u32 non_idle_bitmap =3D 0;
>> +	unsigned int i, j;
>> +
>> +	for (i =3D 0; i < nregs; i++) {
>> +		for (j =3D 0; j < regs[i].reg_cnt; j++) {
>> +			if (mpnic_rd64(mpd, regs[i].reg_base + 2 * j) !=3D
>> +			    ~0ULL) {
>> +				non_idle_bitmap |=3D BIT(i);
>> +				break;
>> +			}
>
> [Severity: Medium]
> Could this report a device that can't be reached as idle? The idle test
> here is ~0ULL, and mpnic_rd64() returns that same value once CSR access
> has been disabled:
>
> drivers/net/ethernet/meta/mpnic/mpnic_pci.c:mpnic_rd64() {
> 	u32 __iomem *csr =3D READ_ONCE(mpd->uc_addr0);
> 	...
> 	if (!csr)
> 		return ~0ULL;
> 	...
> 	mpnic_mmio_err(mpd, reg);
>
> 	return ~0ULL;
> }
>
> mpnic_wr64() also drops writes silently in that state:
>
> 	if (csr)
> 		writeq(val, csr + reg);
>
> After mpnic_mmio_err() clears uc_addr0, the writes in mpnic_disable()
> that clear MPNIC_TWQ_CTL_ENABLE and MPNIC_TCQ_CTL never reach the device.
> On the first poll, mpnic_wait_all_queues_idle() then sees all four blocks
> as idle and returns without a timeout. The caller can't tell a confirmed
> idle state apart from an unreadable device, so it goes on to free the
> rings.
>
> mpnic_mmio_err() logs "awaiting reset", which suggests the device may be
> recoverable rather than gone. Suppose the device can still bus-master
> after two all-ones reads in a row, for example after a transient MMIO
> failure. Could its still-enabled queues then DMA into ring memory that
> has already been freed?
>

Won't fix. Our assumption is that losing the device is not a transient
failure mode, and will require a PCI reset (not implemented yet), or re
probing the device.

>
>> +void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
>> +{
>> +	static const struct mpnic_idle_regs queues[] =3D {
>> +		{ MPNIC_TWQ_IDLE(0), MPNIC_TWQ_IDLE_CNT, "TWQ" },
>> +		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
>> +		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
>> +		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
>> +	};
>> +	u32 non_idle_bitmap;
>> +	int err;
>> +
>> +	err =3D read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
>> +				!non_idle_bitmap, 20, 500000, false, mpd,
>> +				queues, ARRAY_SIZE(queues));
>> +	if (err)
>> +		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
>> +				non_idle_bitmap, err);
>> +}
>
> [Severity: Medium]
> What happens to the rings when this poll times out? The -ETIMEDOUT in
> err is only passed to mpnic_idle_dump() for logging and then dropped.
> Because the function returns void, no caller can act on the timeout.
>
> The commit message says:
>
>   every one of the four blocks a packet passes through on its way out
>   has to report idle before the descriptors are safe to free.
>
> Later in the series, though, mpnic_stop() runs the teardown with no
> condition between the steps:
>
> 	mpnic_disable(mpn);
> 	mpnic_wait_all_queues_idle(mpn->mpd);
> 	mpnic_flush(mpn);
>
> 	mpnic_reset_netif_queues(mpn);
> 	mpnic_free_resources(mpn);
>
> After a timeout, mpnic_flush() calls mpnic_clean_twq0() with
> qt->sub0.tail. That unmaps every pending TWD and frees the in-flight
> skbs. mpnic_free_ring_resources() then calls dma_free_coherent() on the
> TWQ and TCQ descriptor rings, whose addresses mpnic_enable_twq() and
> mpnic_enable_tcq() handed to the hardware.
>
> If a block is still busy after 500 ms, can the device still read the
> freed skb data and descriptors? Can it write completions into the freed
> TCQ memory?
>
> The final version of the series (the "eth: mpnic: add basic Rx handling"
> commit) still returns void and still frees unconditionally. It also adds
> the Rx HPQ/PPQ/RCQ blocks to this wait, which would expose the Rx rings
> and page pool pages the same way.
>
> Should mpnic_wait_all_queues_idle() return the error? Teardown could then
> avoid freeing memory the device may still be using.

Won't fix. If the device is not reporting idle, I think something like
this could be possible with respect to stray DMAs, but I'm not sure what
we can do other than leaking the memory. Also, the device would be in
somewhat of an unknown state, so all bets are off anyway.
