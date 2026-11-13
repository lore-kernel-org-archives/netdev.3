Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592834;
	b=Z2NfqQ0D6q9ryP4z6zMdkztqKVtDA7FQF1dpJ/1jbuK1ZY3xGCwuGqCWOpuwC7qD/M50
	 4ksshtG6AzdyPOAxhKaVYaDnFIdPC9Ii6dlhGKIaJN1ERSdgDggNItMox9SOzdk9KJqG+
	 rmDkXiNxL8k8O4Pq8iCh0vzAWMByaJIFwyXhG8ASc2Y7tuNSmQ+urnqgw7jnGoXMBswVN
	 5tFjPFEt4dNtucPjgYZtszW0lcbnmD+zNxN4p/sGUmBLsXOBOG1J+mHumGCVmvtfkhekO
	 Gh7NW3N7Xs2fszbnliBPn0VJZ6Q0mA3esQmwkA7F3nhPaBrCbfdfgOsMbt1iKYOdBpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592834;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Tw0lREbHvrQFePK47mNtizeFz33aFjFULtXTtRVDf8E=;
	b=NKlPXegZ4E85AdIImdoaJrfo2haTNCn7LqBPZuG42jFzPqceWBR4+PvqX5f05vgN6c7v
	 RIFedawISy5Sqvr8Q4EcTqlg/s9LW7m4q/hJwhmJ0c66MUGT7c0sQVJSxs+dqs3xEEBCK
	 nNI0OHYQPqDOKojTgZ88IMQnT/vPGQ13Nc0zhtJ3EOTV7dppa+yl3h9xHLwnqalL+88rI
	 YGY5+HTtJJirO0cyOHsPg2TM1L2Dx0Gud8NtimXprrInzqeoGOE8p8LHzkoJYPxqwJz1x
	 6DXS2FzX7jfNQA75UCXS36zorMPwUtqq6KVfMvkqf8vNRCfymQ6+6OIJu7hBibRzmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZFf9qxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53282606B440;
	Fri, 13 Nov 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZFf9qxK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FD21F00935;
	Fri, 13 Nov 2026 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592834;
	bh=Tw0lREbHvrQFePK47mNtizeFz33aFjFULtXTtRVDf8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZFf9qxKTXcw96rvkG+t9eR71AToG06GLwSh4mGQZmF2a5CetWYzr/DfvvmtHpEv8
	 L0tNQLds0AVt0hk12a4EVSoFeVgnqvxHr8ovSmEVDzw3eAW/STAGGAZ0KW2F3geMM+
	 iJqunplwuIrCkvkPlNMzgH5ifiBUUFKlmf7T5CJGqDJ3qF/OOOKC5gRaZ7ZC4LIh+J
	 wbLVuNqs5JB8YBfI9igczSGzP/5aL91Q4N8oapp2WUbp2T53w4sgYEaTJrYpa/d9Or
	 wjWYzs+QqvvOPC3+j4Er4Fws0Rxfk9OWDH00eRsFXXFdT2b7uKXPbFfP53J77zuoIW
	 IDh3KRuBpRrfg==
Date: Fri, 13 Nov 2026 18:00:29 +0000
From: Simon Horman <horms@kernel.org>
To: shaos <shawnq1@163.com>
Cc: jhs@mojatatu.com, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_dualpi2: avoid double memory
 accounting on peek
Message-ID: <20261113180029.GB18859@horms.kernel.org>
References: <20261022144758.65248-1-shawnq1@163.com>
 <20261109163655.301509-1-shawnq1@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109163655.301509-1-shawnq1@163.com>

On Mon, Nov 09, 2026 at 04:36:55PM +0000, shaos wrote:
> qdisc_dequeue_internal() removes skbs from gso_skb without invoking
> the qdisc dequeue callback. Their truesize was already subtracted
> when they were first dequeued for peek or requeued after a transmit
> failure. dualpi2_change() currently subtracts it again while trimming
> the queue, wrapping the u32 memory_used counter.
> 
> Skip the second decrement when the skb comes from gso_skb. Packets
> dequeued directly from the C-queue still need the accounting here;
> the L-queue path is unchanged.
> 
> The issue was identified by LLM-assisted source analysis and
> reproduced with a purpose-built rtnetlink/AF_PACKET test in QEMU.
> The test uses CAP_NET_ADMIN in a user-created network namespace and
> CAP_NET_RAW for its AF_PACKET sender. It does not modify the kernel
> or use error injection.
> 
> On Linux 7.4-rc2, the unpatched reproducer wrapped memory_used to
> 4294964992 and subsequent packets remained rejected after restoring
> the memory limit. With this patch, the counter remains valid and a
> packet is accepted after restoring the limit.
> 
> The modified sch_dualpi2.o builds with W=1 under allmodconfig and
> allyesconfig. Full-tree W=1 builds stop on unrelated warnings in
> lib/tests/stackinit_kunit.c, arch/x86/kernel/callthunks.c, and
> net/8021q/vlan.c. The QEMU regression passes; tc-testing was not run.
> 
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2610.2/16461.html
> Signed-off-by: shaos <shawnq1@163.com>
> ---
>  net/sched/sch_dualpi2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 4947def7c49ef..ccf6359eeebc3 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -909,14 +909,20 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
>  	while (qdisc_qlen(sch) > sch->limit ||
>  	       q->memory_used > q->memory_limit) {
>  		struct sk_buff *skb = NULL;
> +		bool already_dequeued;
>  
>  		if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
> +			already_dequeued = skb_peek(&sch->gso_skb);
> +
>  			skb = qdisc_dequeue_internal(sch, true);
>  			if (unlikely(!skb)) {
>  				WARN_ON_ONCE(1);
>  				break;
>  			}
> -			WRITE_ONCE(q->memory_used, q->memory_used - skb->truesize);
> +			/* A peeked or requeued skb was already accounted. */
> +			if (!already_dequeued)
> +				WRITE_ONCE(q->memory_used,
> +					   q->memory_used - skb->truesize);

It strikes me that this change is incomplete.

I think the loads and stores of q->memory_used and q->memory_limit
should be consistently annotated, stashing the value of reads
in local variables to avoid re-reads as appropriate.

Perhaps the resulting change is too wide to be a strict fix for the bug
at hand. But that does at least seem necessary within this function.

>  			rtnl_qdisc_drop(skb, sch);
>  		} else if (qdisc_qlen(q->l_queue)) {
>  			skb = qdisc_dequeue_internal(q->l_queue, true);
> 

-- 
pw-bot: changes-requested
