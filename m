Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749158;
	b=r//rHmoZSl3BvujbNiu1dVI8I8a8Wug5Zq+wf8ChA2+SlkF0HXdwgXaq9bAtylgdS0U6
	 RZb+Cb/avO6AWRoou136tv6CILT4l9nOVIh+DrZhslqcdKa+e2FBZT6YSMn8enAkifmdr
	 jO1w7RnYSSUL1vyymHKtwD+gdPOoZgB77y6bvhod2z8eKec+c2pJeqz2IqKOL5fv/4HMR
	 OZvHSkWUUd1CAIJGhBWwo76HOhcRM0KoTv61Y+Gl84aGJkiRwnD9Tk443Wg4BrriVVK1F
	 /jeq6j5SBGz7JgfKK7YXMWtAiqQPMPFbZzcCG5KIJ/e1oZA7fkSuLCnePIsfzjRwu7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749158;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=D3V+tXOROo9RA3BPDgn1rGU3p2FTl3fivWSdHqJYvOM=;
	b=5XcRg5p2k7Wx/wv5M7AAF118KNYJbTV5Bg1W56h8zqZ3Ju/jUIgSzcRDTIvj2GszFJFR
	 cQ1BhTxZgeuxRMdrvCp6HZHufsjPNYkAS8s8RLV+jSID5qhK/ZALUki0w9xqpOC5/Qd4O
	 tdyKJ0mkhd7IhJCaZmsIk30EZjMOnF0xm7eKx2LIF6Hsn2YM9cha/WKq3iUZ63layWMm7
	 BMikTUsBXkmvfRSkFMf94SVF1We8n8/Qnd00jvhCC7F0RimRp64TsJl/WX1Xp0efmEeUr
	 sZ2toNLZBlk+tbLxkTxHC/KALZ7LrwC3Le8139R06Dc/pHH0Z0yDhB5g2l+ghr/zTvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hszpysWe;
	arc=none smtp.remote-ip=95.215.58.41
Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13753606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13753606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hszpysWe
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WLfyEPO9u7yNFzh9quOo1RAysJhG8X4qXmtIqyQ9aBk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792749155; v=1; x=1793353955;
 b=hszpysWex70ZvYgueA6bd3xCOOE6scXFCs2v79YWYE8cT9ecQHxnhNQgg+vPeZ0eLjxRUfjk
 1rBJ4n/DqGKo1pyOz8yam+gI8zfPjXsPXkleU4wc8kTEQ3Bys3PYLbSZzeVpqgr/SEW8FGfoWNi
 6xYUu0NWvPCEjCCG6gP08qFk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 57aa98510cb311f2;
	Fri, 23 Oct 2026 09:52:34 +0000
X-Mizu-Trace-ID: 57aa98510cb311f2
X-Migadu-Flow: FLOW_OUT
Message-ID: <cbf14506-d689-469e-8aed-509ad5fce16a@linux.dev>
Date: Fri, 23 Oct 2026 17:52:30 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: reject flow_limit_table_len values below 2
To: Dudu Lu <phx0fer@gmail.com>, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20261021155505.67208-1-phx0fer@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261021155505.67208-1-phx0fer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/21/26 11:55 PM, Dudu Lu wrote:
> flow_limit_table_len_sysctl() rejects non-powers-of-two but accepts 1,
> which is 2^0.  A length of 1 then gives log_buckets = ilog2(1) = 0, and
> skb_flow_limit() computes hash_32(hash, 0):
>
>    include/linux/hash.h:68
> 	return __hash_32(val) >> (32 - bits);   /* bits == 0 -> shift by 32 */
>
> A shift by 32 is undefined and, on arm64/x86, the "hash" becomes the full
> 32-bit product val * GOLDEN_RATIO_32 -- an unbounded index into a
> buckets[] flex array that is one byte long inside a 289-byte allocation:
>
>    UBSAN: shift-out-of-bounds in ./include/linux/hash.h:68:24
>    shift exponent 32 is too large for 32-bit type 'unsigned int'
>     __ubsan_handle_shift_out_of_bounds+0x11c/0x208
>     enqueue_to_backlog+0xbe4/0xc44
>     netif_rx_internal+0x130/0x4d4
>
> The subsequent read-modify-write at dev.c:5443-5446 is an out-of-bounds
> write into the allocation (also observed as use-after-free).  Require at
> least two buckets so log_buckets is never 0.
>
> Fixes: 99bbc7074190 ("rps: selective flow shedding during softnet overflow")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
>
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest (KASAN + UBSAN);
> UBSAN fired at the claimed sink.  The reproducer source is not posted here per
> Documentation/process/security-bugs.rst; it is available on request.
>
> Triggering conditions
> ---------------------
> root (flow_limit_table_len and netdev_max_backlog live only in the init-net
> net_core_table, absent from the netns table).
>
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.
>
>   net/core/sysctl_net_core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index eb35da3556f4..bb0fa69f94f5 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -283,7 +283,12 @@ static int flow_limit_table_len_sysctl(const struct ctl_table *table, int write,
>   	ptr = table->data;
>   	old = *ptr;
>   	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> -	if (!ret && write && !is_power_of_2(*ptr)) {
> +	/* A length of 1 is a power of two but gives log_buckets == 0,
> +	 * which makes skb_flow_limit() compute hash_32(hash, 0) -- a
> +	 * shift by 32 -- and index the one-byte buckets[] array with the
> +	 * full 32-bit hash.  Require at least two buckets.
> +	 */
> +	if (!ret && write && (*ptr < 2 || !is_power_of_2(*ptr))) {
>   		*ptr = old;
>   		ret = -EINVAL;
>   	}




1. Need more thought about flow_limit_table_len=1.
A single bucket still has well-defined semantics: once the backlog
is half full, every packet hitting skb_flow_limit() is dropped. The
same effect can be achieved by reducing netdev_max_backlog, so
rejecting 1 may be acceptable.

2. ptr is unsigned, so -2147483648 (0x80000000) still passes your check, 
as it is >= 2 and a power of two.

3. sd_flow_limit::history is u16, and the bucket index is saved into it:

skb_flow_limit():
      /* bucket index, 0 .. flow_limit_table_len - 1 */
      new_flow = hash_32(skb_get_hash(skb), fl->log_buckets);
      /* saved into a u16 */
      fl->history[fl->history_head] = new_flow;

So with flow_limit_table_len > 65536 the bucket index gets truncated
when stored, and 128 packets later buckets[old_flow]-- decrements the
wrong bucket. It is not an out-of-bounds access, but the accounting
becomes wrong. An upper bound of 65536 seems needed as well.

