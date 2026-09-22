Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8537F8DD
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042167; cv=none; b=d1/0bmSBuMc9fUJWe+CToYLDbtdAEE5CpifcD/d58Xfz6K2T0fmF6Dt8eJT0+ZKXzdGkNiX6EZ0gm0CeqVP6ljhk82DhA8pjgBosjRgo6r+SMSuhPlICD963pHnVtuSD837fjNdPq7BgegypjBr7VXQtr+Ef3ZeMSn64QzG14u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042167; c=relaxed/simple;
	bh=JKTMT2kqu9cumolW5UPTRN/Zkv7aFZihDsdLIKQ15mc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQ3KFiR/M9B0Bs+C6/gwT31Cv6Cd51C1L0pbGx3im8jsbCOCQ5tapGG2ivoEDYhZIQ8LizeIxlpCPEdn4oAguikm0O7QN1P9qJlO15P6KKKZ6QLscdDtbUlz2C4jpyiDn3Ityk3LZ3Q+ziEa+8dzP+bv8w1RV2JFkG1tN+ME+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlzRbFdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlzRbFdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FFD1F000FF;
	Tue, 22 Sep 2026 01:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042166;
	bh=ZQ3Qtu1+6pAWI2xVDdFPrNBbbd3DNJX4A0xhEmfKKfo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AlzRbFdZjjh9BcgBdbsGNF8053AysH26rwvt1t6N6jxnDR5tsZYtz25uJwaiJLJHv
	 0VC72AHLXoz+FCOV0N/cZO9Mgq+AXAFvMavEetrSvXGYiqNuToraLiZH4no9125U4t
	 mz7jNA3cRlL6033xyVaGmBH0iX+6PGdsoSLuOhjGNABp/emXkkNt+mDtKRaFnOaLpL
	 435hAeCFpLtFTCWmaYy/pPo/Beyqxj46UozMcZ3UwWlYgXaIQLVuv9QYCNAMUbP03n
	 L3jIz6SGZ46aq9ZVhsrNuqzRc58zZQwHAnOTf9AglK8gChKG3SrXb/7okRP5UcHCVt
	 JjH66JhTzWXGw==
Subject: Re: [PATCH net-next v17 08/15] tcp: fence collapse against rtx-queue
 tail when write queue is empty
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:04 +0000
Message-ID: <179004216475.2160803.6929555883274353432@kernel.org>
In-Reply-To: <20260917224355.2288021-9-rjethwani@purestorage.com>
References: <20260917224355.2288021-9-rjethwani@purestorage.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Changelog claim about TLS 1.3 device-offload KeyUpdate: the
  concern states that the final paragraph ("TLS 1.3 device-offload…
- [Low] Stale call-site comment: net/tls/tls_device.c:169-173
  (tls_device_commit_start_marker) states "So mark the last skb in the…

--

tcp: fence collapse against rtx-queue tail when write queue is empty

This makes tcp_write_collapse_fence() fall back to the retransmit queue
tail when the write queue is empty, so the end-of-record boundary is still
marked at the point encryption keys are installed.  The stated goal is to
stop tcp_retrans_try_collapse() and tcp_shift_skb_data() from merging a
post-key skb into a pre-key skb.

No Link: tags are present in the commit header.

Two small notes, both about wording rather than behaviour.

> tcp: fence collapse against rtx-queue tail when write queue is empty

[Severity: Low]
The changelog ends with:

    "TLS 1.3 device-offload KeyUpdate additionally relies on this behavior
     to keep old-key and new-key records in distinct skbs for
     re-encryption on RX."

At this commit there is no device-offload KeyUpdate path that can reach
the helper, since tls_set_device_offload() and tls_set_device_offload_rx()
in net/tls/tls_device.c still reject a rekey on an already-configured
socket:

net/tls/tls_device.c:tls_set_device_offload() {
	/* A rekey (setsockopt on an already-configured socket) is not
	 * supported on the device offload path yet; ...
	 */
	if (ctx->tx_conf != TLS_BASE)
		return -EOPNOTSUPP;

The KeyUpdate consumer that does call tcp_write_collapse_fence() arrives
in the later patches of the series.  Would it be worth phrasing that
paragraph as a forward reference to the upcoming KeyUpdate patches, so
the dependency ordering is clear to someone reading this commit alone?

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5e5f5f9b89a3..8c6d90e962c4 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2340,6 +2340,15 @@ static inline void tcp_write_collapse_fence(struct sock *sk)
>  {
>  	struct sk_buff *skb = tcp_write_queue_tail(sk);
>  
> +	/* When nothing is queued for transmit, the last skb of the current
> +	 * state is the rtx queue tail (its end_seq == snd_nxt == write_seq).
> +	 * Fence that instead, otherwise the boundary is left unmarked and a
> +	 * later tcp_retrans_try_collapse()/tcp_shift_skb_data() can merge it
> +	 * with the first skb of the next state across the fence (they only test
> +	 * the tail's EOR, not skb->decrypted).
> +	 */
> +	if (!skb)
> +		skb = tcp_rtx_queue_tail(sk);

[Severity: Low]
With this fallback the helper can now set eor on an already-transmitted,
unacked skb from the retransmit queue, not just on a write-queue skb.

The comment at the tls_device.c call site still describes the old
behaviour:

net/tls/tls_device.c:tls_device_commit_start_marker() {
	/* TLS offload is greatly simplified if we don't send
	 * SKBs where only part of the payload needs to be encrypted.
	 * So mark the last skb in the write queue as end of record.
	 */
	tcp_write_collapse_fence(sk);
}

That text is unchanged through the end of the series.  Since the commit
message describes the empty-write-queue case as the common state at key
install time, the fallback is the path most readers will hit.

Should that comment be updated to mention the retransmit-queue tail as
well?

>  	if (skb)
>  		TCP_SKB_CB(skb)->eor = 1;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
