Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572286;
	b=OoFoFFLSg4OdQ5v+wNZ6O+wu/6OgvnT5JKnmImMfV4f0QFoQPQ7+Eqwxu6DPnLrhgPaA
	 npnKIDa9IH75aUe1VS3/OZ5T/3DfT49h5auHOC+yfXB+34oMLzM+//cA5qf+gq4c6t71Q
	 d8RZGDWbSDoCH8p2jI4XUw1F6mFznmixAotaeMJjiaUJP4s0y8Fz5254G4FJo2u0IADNm
	 rDRq2pMWiVXR5T4oygXEslns/1zDuJ8si1YDeWaYHt/jY8xZJc48TyR/Z68ypYRBA388T
	 PdwrkSmxAFibdlBVIv4H6rbmHPMxMVcfZjSoP97QHRpL/ZwGIU1oZE43zngI4L8bXHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572286;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=Ryt79vtuqgO6oO1oeL3ZfN3BiPEbp12hL9M4yl8jSjo=;
	b=QxOPfiL5SDOBhJsAArrDrMCcJrXb6OLhb+C0fxk/BfruOnlS+pVnQI+W/3734tl3Cyx/
	 MiPzwDKjwGJb4WDs9ez7lM/x8yWBv5Q2Jah0NxJd98LfGJ4jWP5rjX7qgItu7DQbr3IXA
	 zUnmXoq74SZO6/op7UkqPITpM4cXs9BUGam1rltWh+J4mxvXCGrjgRKUwelD1kqzAM15K
	 YXUU2qJ0IaqWhnahOlIx2B8n9oFelBuwoD98Mv+mU5qeKB0fd5/lIIQZXvTtyGHO4dE6l
	 8WrhvWV8nRA804ERAFr6lKhOCEoaViEkQYK6iOWcO6TM9UaW7MNzyfOT27uD5D3akBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=fyFDjeCM;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADB606A31C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8ADB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=fyFDjeCM
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 50609207E3;
	Wed, 21 Oct 2026 10:44:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kVjeeb5hzzRi; Wed, 21 Oct 2026 10:44:36 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5811B207A4;
	Wed, 21 Oct 2026 10:44:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5811B207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1792572276;
	bh=Ryt79vtuqgO6oO1oeL3ZfN3BiPEbp12hL9M4yl8jSjo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fyFDjeCMgoqE+WxSbghr8jX/ZnuNig8IL2sPlBucAhxzBTcgnmI4779btlxNoBO4l
	 Lyl5YOlCczOXQut69sfLM23zQnWyvEY2rNSgbaYvi63rNyctSS9ME/jNYb+LDbVsax
	 A1+SDMKrtpbVb6I+POtI4Bve70akz8qByxzw93hgnCDeNkkDANsXkrjb6tGN/r7wLK
	 dVe3OXj4VFU93D8458FddXra8FFJcAWRgLDY01pNuloS9oUAvcVtF1Jck1cDe6TnAf
	 pleMQ3J4RqK9+Y1oi+puw7+UNiv0e8Ku2tJP9E3YUn+R5HPjM+LOlNZo1GnyBU8ZdJ
	 1v3Dd+VZ92Qqw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 10:44:35 +0200
Received: (nullmailer pid 2570425 invoked by uid 1000);
	Wed, 21 Oct 2026 08:44:35 -0000
Date: Wed, 21 Oct 2026 10:44:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jun Yang <juny24602@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <chopps@labn.net>, <netdev@vger.kernel.org>, Jun Yang
	<junvyyang@tencent.com>, <stable@kernel.org>, TencentOS Corvus AI
	<corvus@tencent.com>
Subject: Re: [PATCH net] xfrm: iptfs: do not seek the sequential skb reader
 backwards
Message-ID: <ath7c-r2GuDm5Xo4@secunet.com>
References: <20261015021747.30346-1-juny24602@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015021747.30346-1-juny24602@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
commit d3c6d0500e742002c13ba4e7b9eff45bdb2c394b
Author: Jun Yang <junvyyang@tencent.com>
xfrm: iptfs: do not seek the sequential skb reader backwards

iptfs_reassem_cont() can underflow its offset arithmetic when reading
a saved runt if the sequential reader stepped, leading to an out-of-bounds
memcpy. This patch aborts and restarts the sequence read to avoid backwards
seeks. It also fixes a sibling parser to use offset 0 when restarting.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..751cceab738a1 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
[ ... ]
> @@ -1046,7 +1052,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  			struct sk_buff *save = skbseq->root_skb;
>  
>  			skb_abort_seq_read(skbseq);
> -			skb_prepare_seq_read(save, data, tail, skbseq);
> +			skb_prepare_seq_read(save, 0, tail, skbseq);
>  		}
>  
>  		if (first_skb) {

Does this code introduce a data race that corrupts reassembly?

When __input_process_payload() saves a runt, it calls iptfs_input_save_runt()
without acquiring xtfs->drop_lock or any other SA-level lock:

net/xfrm/xfrm_iptfs.c:__input_process_payload() {
    ...
    /* save the bytes we have, advance data and exit */
    iptfs_input_save_runt(xtfs, seq, hbytes, remaining);
    ...
}

This locklessly modifies xtfs->ra_runt, xtfs->ra_runtlen, and
xtfs->ra_wantseq.

Concurrently, another CPU processing packets for the same IP-TFS SA might
execute iptfs_input_ordered() and read xtfs->ra_runtlen locklessly, then
acquire drop_lock for iptfs_reassem_cont():

net/xfrm/xfrm_iptfs.c:iptfs_input_ordered() {
    ...
    /* check before locking i.e., maybe */
    if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
        spin_lock(&xtfs->drop_lock);

        /* check again after lock */
        if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
            data = iptfs_reassem_cont(xtfs, seq, &skbseq, skb, data,
                                      blkoff, &sublist);
        }
        spin_unlock(&xtfs->drop_lock);
    }
    ...
}

Because iptfs_input_save_runt() does not hold drop_lock, the lockless read
and locked memcpy of xtfs->ra_runt race directly with the lockless writes.
Can this cause memory corruption, torn reads, and packet corruption?

Can this code cause a lock context violation on PREEMPT_RT kernels?

In iptfs_input_ordered(), a sleepable spinlock is acquired while a
kmap_atomic mapping might still be held:

net/xfrm/xfrm_iptfs.c:iptfs_input_ordered() {
    ...
    if (skb_copy_seq_read(&skbseq, 0, ipth, sizeof(*ipth))) {
    ...
    if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
        spin_lock(&xtfs->drop_lock);
    ...
}

If the packet is non-linear and the header resides in a paged fragment,
skb_copy_seq_read() maps the fragment using kmap_atomic() and leaves
skbseq.frag_data actively mapped.

Acquiring spin_lock(&xtfs->drop_lock) without first aborting the sequence
read violates lock context rules, as spinlock_t maps to a sleepable rt_mutex
on PREEMPT_RT.

Could this lead to a 'sleeping in atomic context' bug?
