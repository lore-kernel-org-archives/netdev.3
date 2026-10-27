Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103429;
	b=tBIkFE//SkH89DOHk87YhyO5F5K4EuJSuntdHeWhikTubdOU8HHhQKoxMho0hFDcs1Tx
	 JSF0aEtCFndAwFGiEBpmK5bGnrDbhLtwaqLPRUYxcV+cb5u2V4YhvwSdNFwTcLZf13x0i
	 3lLvwlyYrJ6xs1YwAaSUtwqLFInvs+1vxnLMLIuvVlYNXB65Mb34QBQwRNVxAhSaihV4W
	 ilSlvTR2gz89NfjBiXDBC8PC9a4nnX7BG8IPIj6FsoRNZimqT0JRXLjfOt+AOlhQ5rXfI
	 Ziy9q9VOfOBlNgJe7DuirBgkfjjvqnC3GMSEcnb+JZQ23gTZDuoans8wTX1gDYOX7Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103429;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CvpAXhZ/zB1/UtUz0RWVeDfIbCVfPxKrIVg3TrbtYsk=;
	b=utj+zmTnukXI/yL7bQNdI1loRQ6eqCRFRQxhOUJ6dPUbER98VNsLans7yUZlb3DM9G0j
	 xstu6SAvycR3qqQ8t64vF7gH9FEnBTcaJqGvYyQMzC3uvyq4qJ212B16xqdJU61m0CInY
	 zVR9gTdRxoTz1zOyup6WxUTwemZSYsy42rE9f/1corG72d/WcacGAnAv+i9C8qNmh3RQv
	 p25peApON+qJfCdYa3kgpHacTfz23pVNWEY7LkyGXiGP+3nDvnKGb/i/hDRbPwU0WUadk
	 zn3It7dP5QuOJ4hTkm69EjgezEcnZUlhvHnqCoI5E7NwNH+DxcUSw5PSSa1AOVvylFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClM3rRbw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE93606A31F;
	Tue, 27 Oct 2026 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClM3rRbw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4791F01829;
	Tue, 27 Oct 2026 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103429;
	bh=CvpAXhZ/zB1/UtUz0RWVeDfIbCVfPxKrIVg3TrbtYsk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ClM3rRbw7sUjK5COILTK6VMb0rOMQo1W6mGE8fGvM4PcVoB/jHoq47VmwsbdWmuPv
	 LeG6wIiU/HGyBgX/pVXX0zuvoKbQBsF9d06IlYnUe0cg5P4xVa/Jqur4ukM5sHbMVw
	 kU/BUr1kHZeMgAJSEOiaCIbSXsIeueFFInMQ2u7K47TAmW5z+hID2zzMSlDlurUAzd
	 WaGauLzBgIA+GP1xHDK6JtP6vNamVQIlj49scs8EWVAp0LkiZAb7Qvoq0ARc7RwrZB
	 Swd7G37xWLYdnFYmC2RULY2i+//cVUnTwtvo0UcqahermV42Yc4SxdzVVR46aY3Kse
	 ISPQtQxU/nvEw==
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com,
 aduyck@mirantis.com
Date: Tue, 27 Oct 2026 12:17:07 +0000
Message-ID: <179310342759.3134.9480442291648763504@kernel.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch alone, igc_xmit_frame_ring() still calls
  igc_request_tx_tstamp(), which does skb_get() (line ~1687), before…
- [Low] The commit message describes a failure that cannot happen on the
  tree this patch applies to.

--

igc: pad preemptible packets before reserving TX timestamps

This commit moves the preemptible-queue padding in igc_xmit_frame_ring()
so it runs before the TX timestamp reservation. The extra reference taken
by igc_request_tx_tstamp() is then not yet held when padding may call
pskb_expand_head(). It also switches to __skb_put_padto() with
free_on_error set to false, so out_drop is the only place that frees the
skb.

> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
> padding error path. skb_padto() drops one reference on failure, and
> out_drop drops another. This can free the skb while the pending TX
> timestamp still holds its pointer.

[Severity: Low]
Does this description match the tree this patch applies to? Here,
pskb_expand_head() in net/core/skbuff.c still has:

	BUG_ON(nhead < 0);

	BUG_ON(skb_shared(skb));

So c7d8bc3dd511 does not appear to be applied. Without it, take a short
frame on a preemptible queue that is cloned or lacks tailroom. Before
this patch it would go through:

igc_xmit_frame_ring()
  igc_request_tx_tstamp()
    tstamp->skb = skb_get(skb);    /* skb now shared */
  skb_padto()
    __skb_pad()
      pskb_expand_head()
        BUG_ON(skb_shared(skb));

That gives a BUG() rather than the -EINVAL and use-after-free described
above. The same holds for stable trees that carry 17643482e9ff but not
c7d8bc3dd511.

The code change covers both cases, since padding now runs before
skb_get(). Could the commit message say that kernels without
c7d8bc3dd511 crash in pskb_expand_head() instead?

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..f1bf4e462a511 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c

[ ... ]

> @@ -1669,10 +1686,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
>  		if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

[ ... ]

> @@ -1680,24 +1697,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>  	}
>  

[ ... ]

> -	if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
> -		if (skb_padto(skb, ETH_ZLEN))
> -			goto out_drop;
> -		skb_put(skb, ETH_ZLEN - skb->len);
> -	}
> -
>  	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
>  	if (tso < 0)
>  		goto out_drop;

[Severity: High]
With this patch applied on its own, igc_request_tx_tstamp() still runs
before igc_tso() and igc_tx_csum(). Can the same shared skb problem come
up here?

When a GSO skb with a cloned header (for example with a packet tap or tc
mirred active) is hardware timestamped:

igc_xmit_frame_ring()
  igc_request_tx_tstamp()
    tstamp->skb = skb_get(skb);
  igc_tso()
    skb_cow_head(skb, 0)
      __skb_cow()
        pskb_expand_head()
          BUG_ON(skb_shared(skb));

igc_tx_csum() can reach pskb_expand_head() the same way, through
skb_checksum_help()->skb_ensure_writable(), on a cloned skb.

The next patch in this series, "igc: prepare TSO and checksum offloads
before TX timestamps", moves igc_tso() and igc_tx_csum() ahead of the
timestamp reservation. That fixes this by the end of the series. Should
the two patches be backported together, since this one alone leaves the
TSO and checksum paths exposed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091549.605810-1-p%401g4.org
