Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103431;
	b=NKiyM6fQK5OXAdI6Q7OD598w9wItnb6zz/WcPOrJMEnnbjT7arKAnXBqDeLkpx3eqpvP
	 KfLmqE7lBdFug1G50C9hTeXgXiJGKgpjIYb7NGgS6PnqtxwB7G4WQzjlaeT+tl/akN6rA
	 /B+1J6a0tR2PqaVpnpg3yRv9uUl8ga98EW9rjvNFt8SPCWxAnlb3Rje7TAHS0phcCbLrd
	 eerQHbzNwzQEsNogN6j8P8JrAjJQVmV5pSHD+Hrz8vlG1j1+LjqFtOKAN77IE/D3TlmGv
	 Ti101saFB+F3a31Aslm26eYQUmxFLRVYl9Sw5W+w9X3yG7kgJQ53SMPw8lNKe0ve5tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103431;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YhcjD1YBMzA5Xs7JoqVBnf/2Enan5NxfdYZ+s0ul08c=;
	b=ytNbM4iqOuBQgpfm5qf6kKnAGwk3dmK6B+piw0+VZhZ1fKdwlZjqIwjDEmNFQVu+Vrs5
	 FjK/0dU8dLNS4JMhsZuN71h3rjOD88pzlYSh3ajBtwjNeBouwr8kqa65aTBA7otkh4ODm
	 Gh3Wo/UPqsmMOgwBSy0TY4JYxokb2e+0QiMrS+7ZVRX+xklHRdwWO81HMhvBFnt6D1u3r
	 3uw88dTgX/DcW4VS4juSR6MaHwlAVBaS5AqlupkTJ7PM2uGstjlhf07C+UTFBMicDCswq
	 TLzeVWDlGIkYJ78GBV/f/yRbvs/msL0x43yYD0oNRKyZwaHIHSP9/pV+iFFRcofkKTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/x5zjto";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A66606A330;
	Tue, 27 Oct 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/x5zjto
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4581F01825;
	Tue, 27 Oct 2026 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103430;
	bh=YhcjD1YBMzA5Xs7JoqVBnf/2Enan5NxfdYZ+s0ul08c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c/x5zjtoSUWG3kSbfh2U+NnRQ109lCtJVwu5+uOcfnNbifpj61anmMJ8cnZRp0/eh
	 7Uo0BhRmcPNF8Pef1y50r3+x4i4HMz99vhb5uyo+hIOl3Kv3xKARsl+XbbvMgf4zQ1
	 b4+PkKXNNQ8YLkJhuoZfK/MomyirEV027P/LxDA/Xm5FYDlZe6GXeu4hksqXWEcaOJ
	 0A+VLqY2n0W7PX7seGzH78MN+cuvqrLzE2iExxPS6FCaeEkFQjBbpEgeQYMcNI2kKr
	 vj/YRwmAHAQ62WAPiGhiBu6f7fhGE1mk5ziMYm0QTvb75F4FCIPZudCvuJB8gHHFTx
	 35eXFNx2CIZrA==
Subject: Re: [PATCH net 2/3] igc: prepare TSO and checksum offloads before TX
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
Date: Tue, 27 Oct 2026 12:17:09 +0000
Message-ID: <179310342944.3134.10071026023246764321@kernel.org>
In-Reply-To: <20261026091549.605810-2-p@1g4.org>
References: <20261026091549.605810-2-p@1g4.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message misstates what the patch fixes.
- [Medium] igc_tx_csum() (drivers/net/ethernet/intel/igc/igc_main.c:1200)
  still ignores the return value of skb_checksum_help().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but ixgbe has the
  same skb_get()-before-skb_cow_head() ordering and the series leaves it…

--

igc: prepare TSO and checksum offloads before TX timestamps

In igc_xmit_frame_ring(), this patch moves the igc_tso() and igc_tx_csum()
calls ahead of the TX hardware timestamp reservation. As a result, the
extra skb reference that igc_request_tx_tstamp() takes no longer exists
while the headers are being prepared.

> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, causing TSO
> preparation to fail and the packet to be dropped.

[Severity: Medium]
Is this description accurate for the tree this patch applies to?
c7d8bc3dd511 does not appear to be an ancestor of this commit, and
pskb_expand_head() in net/core/skbuff.c still has:

	BUG_ON(skb_shared(skb));

Before this patch, igc_request_tx_tstamp() does tstamp->skb = skb_get(skb),
which leaves skb->users at 2. If the header is cloned (for example an
AF_PACKET tap clone from dev_queue_xmit_nit(), or a bridge or mirred
clone), these paths are taken:

  igc_tso()->skb_cow_head()->__skb_cow()->pskb_expand_head()
  igc_tx_csum()->skb_checksum_help()->skb_ensure_writable()->pskb_expand_head()

Both would hit that BUG_ON() instead of returning -EINVAL.

The stable trees that the Fixes: tags (2c344ae24501, f38b782dccab) point
at would behave the same way. Could the commit message say that in those
kernels the symptom is a BUG(), not a dropped packet or a missing checksum?

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f1bf4e462a511..cd4c9815fca7c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1678,6 +1678,12 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  			goto out_drop;
>  	}
>  
> +	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
> +	if (tso < 0)
> +		goto out_drop;
> +	else if (!tso)
> +		igc_tx_csum(tx_ring, first, launch_time, first_flag);

[Severity: Medium]
The commit message says "igc_tx_csum() ignores the error, allowing
transmission to continue without completing the checksum". After this
patch, igc_tx_csum() still throws away the return value:

drivers/net/ethernet/intel/igc/igc_main.c:igc_tx_csum() {
    ...
	default:
		skb_checksum_help(skb);
		goto csum_failed;
    ...
}

The reorder removes the shared skb trigger, but skb_checksum_help() can
still fail in other ways:

- -ENOMEM from __skb_linearize() for shared frags
- -ENOMEM from skb_ensure_writable()->pskb_expand_head(GFP_ATOMIC) when
  the header is cloned
- -EINVAL or -EFAULT for bad offsets or unreadable frags

In each case ip_summed is left as CHECKSUM_PARTIAL with no checksum
written, and igc_xmit_frame_ring() continues to igc_tx_map(). Does the
frame then go out with only the pseudo-header seed in the L4 checksum
field?

The default branch can be reached because igc_probe() advertises
NETIF_F_HW_CSUM. That lets CHECKSUM_PARTIAL skbs with any csum_offset
arrive, for example packets forwarded from tun/tap vnet_hdr guests.

Could igc_tx_csum() return an error and goto out_drop on failure, the
same way the igc_tso() < 0 case is handled?

> +
>  	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
>  		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		unsigned long flags;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
ixgbe seems to have the same ordering, and this series does not touch it.
Later in the series, igb is fixed by "igb: prepare TSO and checksum
offloads before TX timestamps". ixgbe_xmit_frame_ring() still takes the
timestamp reference before any header preparation:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_xmit_frame_ring() {
    ...
			adapter->ptp_tx_skb = skb_get(skb);
    ...
			if (skb_cow_head(skb, 0))
				goto out_drop;
    ...
	tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
    ...
	else if (!tso)
		ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
    ...
}

ixgbe_tso() also calls skb_cow_head(skb, 0) itself. Once HWTSTAMP_TX_ON is
enabled and a socket asks for SOF_TIMESTAMPING_TX_HARDWARE on a GSO skb
with a cloned header, this path runs while skb->users is 2:

  ixgbe_tso()->skb_cow_head()->__skb_cow()->pskb_expand_head()

Wouldn't that hit BUG_ON(skb_shared(skb)) in pskb_expand_head()? The DCB
software VLAN skb_cow_head() call and ixgbe_tx_csum() also run after the
reference is taken.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091549.605810-1-p%401g4.org
