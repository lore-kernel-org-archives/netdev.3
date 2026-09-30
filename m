Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8C1ADFE4
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734429; cv=none; b=BZzN2vqdkqojlDPjStWb4l9M7DiH36HHG5UZVaepmusdjB4f5LthhGQ48EvMnIycZqCfpIh0euxfTfZ4xn6C4Twmv7QPDaQKWKL3ZSLwk0svgCRCne2BmXMy9C4VG9s0IEuA25pH/tRV2XztzgpjNnimdZoui6hid/+8zjxxIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734429; c=relaxed/simple;
	bh=oIfRFE3jbOPd4Dmo6PW97we5QbcGDySS0o5ZFCT3lO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=edtyNp40DA0Lbh5KAZGz/YWmzjZu8avPrJJnCRoK4nsBzOn4JY0UFFgfYiUgtzHqRGw/Xfuv+BflpERr3F49578sgx3lxobH6n2JUYKJi8WloMU+/SFe/kTdE7guvOCqLpOZ3iSmxefs6t3FSoBKOLWmCg0eXNk+OevTlpbvslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdiWIj5w; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdiWIj5w"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oIfRFE3jbOPd4Dmo6PW97we5QbcGDySS0o5ZFCT3lO8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790734425; v=1; x=1791339225;
 b=hdiWIj5wUOdUHYmKfmS8y72z8p8dgbXYLDfHjd3rDIihOSNRI+MZJOcPByqe8HzJ/DJaTfko
 CfkMfD6aJh7nFDtZ7aXUEfkqeNRrvikriAiRrnwBZOw4NQYNiBLoizo+keYTpPJX/ZZB+stn0Pl
 uJC/+UfTj6YoNvy8j4FHeCTc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2d6e84da83bb2d60;
	Wed, 30 Sep 2026 02:13:45 +0000
X-Mizu-Trace-ID: 2d6e84da83bb2d60
X-Migadu-Flow: FLOW_OUT
Message-ID: <43ad79b6-40e9-4704-bcd5-b67255105fae@linux.dev>
Date: Wed, 30 Sep 2026 10:13:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] tcp: restore RACK list membership when undoing
 loss
To: nramaswamy@openai.com, netdev@vger.kernel.org
References: <20260926002520.42955-4-nramaswamy@openai.com>
 <20260926002520.42955-5-nramaswamy@openai.com>
Cc: Eric Dumazet <edumazet@google.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260926002520.42955-5-nramaswamy@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/26/26 8:25 AM, nramaswamy@openai.com wrote:
> From: Neil Ramaswamy <nramaswamy@openai.com>
>
> Partial undo can clear the TCPCB_LOST flag on segments already removed from
> RACK's list, which prevents subsequent RACK loss detection and can lead to
> long retransmission delays. Restoring them to the RACK list allows them to
> be reconsidered for fast retransmission in the future. To do this, we first
> sort the segments whose lost flag is being cleared, and reinsert them into
> the RACK list (which is sorted by transmission time).
>
> Fixes: 043b87d7599e ("tcp: more efficient RACK loss detection")
> Signed-off-by: Neil Ramaswamy <nramaswamy@openai.com>
> Assisted-by: LLM sparse
> ---
>   net/ipv4/tcp_input.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 92bc60716f33..38ac07c8b38f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -69,6 +69,7 @@
>   #include <linux/module.h>
>   #include <linux/sysctl.h>
>   #include <linux/kernel.h>
> +#include <linux/list_sort.h>
>   #include <linux/prefetch.h>
>   #include <linux/bitops.h>
>   #include <net/dst.h>
> @@ -2840,16 +2841,48 @@ static void DBGUNDO(struct sock *sk, const char *msg)
>   #endif
>   }
>   
> +static int tcp_rack_skb_cmp(void *priv, const struct list_head *a,
> +			    const struct list_head *b)
> +{
> +	const struct sk_buff *skb_a = list_entry(a, struct sk_buff,
> +					       tcp_tsorted_anchor);
> +	const struct sk_buff *skb_b = list_entry(b, struct sk_buff,
> +					       tcp_tsorted_anchor);
> +
> +	return tcp_skb_sent_after(tcp_skb_timestamp_us(skb_a),
> +				  tcp_skb_timestamp_us(skb_b),
> +				  TCP_SKB_CB(skb_a)->end_seq,
> +				  TCP_SKB_CB(skb_b)->end_seq);
> +}
> +
>   static void tcp_undo_cwnd_reduction(struct sock *sk, bool unmark_loss)
>   {
>   	struct tcp_sock *tp = tcp_sk(sk);
>   
>   	if (unmark_loss) {
> +		LIST_HEAD(restored);
>   		struct sk_buff *skb;
>   
>   		skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
> +			if ((TCP_SKB_CB(skb)->sacked & TCPCB_LOST) == TCPCB_LOST)
> +				list_move_tail(&skb->tcp_tsorted_anchor, &restored);


I think the simplest way to solve the problems is just drop 
'list_del_init(&skb->tcp_tsorted_anchor);' in tcp_rack_detect_loss(),
although it will reduce the efficiency of RACK loss detection ?

Leave it to maintainers.


>   			TCP_SKB_CB(skb)->sacked &= ~TCPCB_LOST;
>   		}
> +		if (!list_empty(&restored)) {
> +			struct list_head *pos = &tp->tsorted_sent_queue;
> +
> +			/* Ensure lost skbs are added in transmission order */
> +			list_sort(NULL, &restored, tcp_rack_skb_cmp);
> +			while (!list_empty(&restored)) {
> +				struct list_head *entry = restored.next;
> +
> +				while (pos->next != &tp->tsorted_sent_queue &&
> +				       !tcp_rack_skb_cmp(NULL, pos->next, entry))
> +					pos = pos->next;
> +				list_move(entry, pos);
> +				pos = entry;
> +			}
> +		}
>   		tp->lost_out = 0;
>   		tcp_clear_all_retrans_hints(tp);
>   	}
