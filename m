Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35E3CF67F;
	Wed, 23 Sep 2026 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205866; cv=none; b=AFH39FtIO121mILw4THTBosJizDqK/6H+sBu4PwLMo/9PbSuoQmFebQkuqh+lfnNgbEU+yb2IIYYbMEGIO6HVKmeOS5fq5o9yMpfkO7JV0XrbgqK+Houk2OmnIVvmGkb+pzdgf61YSh4NzaFIjkAyIMKV9jykj/nw+BcayowJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205866; c=relaxed/simple;
	bh=HRrBlmsVBvBb+TMnAum+7J15MBrbDAhKeBAjCN8c5XQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDdA/q6fjj8PBaX9JyTwRKFZBpkeLxtwh/jS3XEaiet9HbRQj6R9SPhz8BD/u5s/rrCbu8pR/B2JojSVMZ4PLHFABQ8+LN66U8Gow3I1f78pcl6Yw+gMc46mpFcBp4qz68YFbwqRqEaNBtOAraacxhIqMpQP1shiMYCVpfYET38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT+SkoUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT+SkoUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E251F000FF;
	Wed, 23 Sep 2026 23:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205864;
	bh=NL2zL4T1TwfBi0kwYRvAZ/jCym1NP3SWepDCm8q+Snw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DT+SkoUodPmMNL6fmxvDwBPmaTItsVZZpqoHCSzEKN6hqY5r2eQEeYPFBfgPHP1nv
	 LLKB2Xbp6dWrLqiIkWzxMHqhvupca1lgtLvgH5er4kega/R1xQ8G3bW9TRDjNx8Lg+
	 unWfypn2/BTKAHEkwIIAQIz8EckRuXp/LsCMF5hzST887LzzIYPNF2jqGLPXg6VDoG
	 8kAnlJzzY0Qbfw4NSrSUiLYCMYsKQzS2Wm6yJSVmq2fYP2kxqGqWpHRaqt6H8YszR/
	 CwUAn5kHjDzvEu1KEqF7vK28eaEnSjow5buk2lVaPgi1aLAKW4FOSn5AocVhhOQiuF
	 t8ACyGvupT6ig==
Subject: Re: [PATCH] kcm: fix socket memory accounting leak on TX completion,
 error, and close
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 23:24:23 +0000
Message-ID: <179020586343.2160803.15675750153868355675@kernel.org>
In-Reply-To: <20260919212853.3240951-1-benquike@gmail.com>
References: <20260919212853.3240951-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message's stated bug does not exist, and roughly half
  of the patch is dead code.

--

kcm: fix socket memory accounting leak on TX completion, error, and close

The patch replaces the direct sk->sk_wmem_queued arithmetic in
kcm_write_msgs() with sk_wmem_queued_add(), and adds sk_wmem_queued_add()
plus sk_mem_uncharge() calls wherever TX skbs are freed in the
kcm_sendmsg() out_error path and in kcm_release().  It also adds NULL
checks on head before freeing it in kcm_sendmsg().

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 71af69d442f2..accf0d427e11 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -693,7 +693,8 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
>  		}
>  
>  		/* Successfully sent the whole packet, account for it. */
> -		sk->sk_wmem_queued -= txm->sent;
> +		sk_wmem_queued_add(sk, -txm->sent);
> +		sk_mem_uncharge(sk, txm->sent);
>  		total_sent += txm->sent;
>  		skb_dequeue(&sk->sk_write_queue);
>  		kfree_skb(head);

[Severity: High]
Are the sk_mem_uncharge() calls added by this patch reachable at all on a
KCM socket?  kcm_proto declares no .memory_allocated:

net/kcm/kcmsock.c:
static struct proto kcm_proto = {
	.name	= "KCM",
	.owner	= THIS_MODULE,
	.obj_size = sizeof(struct kcm_sock),
};

and the accounting helpers are gated on that field:

include/net/sock.h:
static inline bool sk_has_account(struct sock *sk)
{
	return !!sk->sk_prot->memory_allocated;
}

static inline void sk_mem_uncharge(struct sock *sk, int size)
{
	if (!sk_has_account(sk))
		return;
	sk_forward_alloc_add(sk, size);
	sk_mem_reclaim(sk);
}

If sk_has_account() is always false for KCM, then the new
sk_mem_uncharge() in kcm_write_msgs(), the two in the kcm_sendmsg()
out_error path and the two in kcm_release() are all no-ops, and only the
sk_wmem_queued_add() half of the patch has any effect.  Would it make
sense to drop the sk_mem_uncharge() calls (or wire up real proto
accounting for KCM as a separate change)?

The same reasoning applies to the premise in the changelog:

  "every TX fragment is charged to both `sk->sk_wmem_queued` and
   `sk->sk_forward_alloc` (`sk_mem_charge()`)"

The sk_mem_charge() inside skb_copy_to_page_nocache() and the explicit one
in the MSG_SPLICE_PAGES branch of kcm_sendmsg() are gated by the same
sk_has_account() test, so is sk->sk_forward_alloc ever charged here?

And for claim 1:

  "When `kcm_write_msgs()` finishes transmitting `head`, it subtracts
   `txm->sent` from `sk->sk_wmem_queued` but never calls
   `sk_mem_uncharge(sk, txm->sent)`."

The line this hunk removes already did sk->sk_wmem_queued -= txm->sent, so
is anything leaked on the TX completion path, or is this hunk just a
cosmetic conversion to the WRITE_ONCE() wrapper?

> @@ -960,10 +961,17 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  		 */
>  		if (copied)
>  			goto partial_message;
> -		if (head != kcm->seq_skb)
> +		if (head && head != kcm->seq_skb) {
> +			sk_wmem_queued_add(sk, -head->len);
> +			sk_mem_uncharge(sk, head->len);
>  			kfree_skb(head);
> +		}
>  	} else {
> -		kfree_skb(head);
> +		if (head) {
> +			sk_wmem_queued_add(sk, -head->len);
> +			sk_mem_uncharge(sk, head->len);
> +			kfree_skb(head);
> +		}
>  		kcm->seq_skb = NULL;
>  	}
>  

These two hunks in kcm_sendmsg() look like the one place where a real
imbalance existed: head carries data already added to sk->sk_wmem_queued,
and the pre-patch code dropped it with a bare kfree_skb().

Since the patch carries a Fixes: tag and is a stable candidate, could the
changelog describe that symptom instead?  A leaked sk_wmem_queued count
permanently shrinks the send space reported to sk_stream_memory_free(),
sk_stream_wait_memory() and SIOCOUTQ, so a socket that repeatedly hits
out_error can end up blocking or returning -EAGAIN forever.  As written,
the described symptom is not reproducible.

> @@ -1695,13 +1704,21 @@ static int kcm_release(struct socket *sock)
>  
>  	lock_sock(sk);
>  	sock_orphan(sk);
> -	kfree_skb(kcm->seq_skb);
> +	if (kcm->seq_skb) {
> +		sk_wmem_queued_add(sk, -kcm->seq_skb->len);
> +		sk_mem_uncharge(sk, kcm->seq_skb->len);
> +		kfree_skb(kcm->seq_skb);
> +	}
>  
>  	/* Purge queue under lock to avoid race condition with tx_work trying
>  	 * to act when queue is nonempty. If tx_work runs after this point
>  	 * it will just return.
>  	 */
> -	__skb_queue_purge(&sk->sk_write_queue);
> +	while ((skb = __skb_dequeue(&sk->sk_write_queue)) != NULL) {
> +		sk_wmem_queued_add(sk, -skb->len);
> +		sk_mem_uncharge(sk, skb->len);
> +		kfree_skb(skb);
> +	}
>  
>  	release_sock(sk);
>  

Can the warning named in claim 2 of the changelog actually fire here?

  "triggering a `WARN_ON` in `inet_sock_destruct()` and `__sk_destruct()`
   when the KCM socket is closed"

The WARN_ON_ONCE(sk->sk_wmem_queued) / WARN_ON_ONCE(sk->sk_forward_alloc)
pair lives only in inet_sock_destruct() in net/ipv4/af_inet.c, and
kcm_create()/kcm_clone() install the destructor via sock_init_data(), which
leaves the empty sock_def_destruct() in net/core/sock.c as sk->sk_destruct
for PF_KCM.  __sk_destruct() itself has no wmem or forward_alloc warning.

Given that the socket is being torn down at this point, are the
adjustments in kcm_release() observable by anything?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212853.3240951-1-benquike%40gmail.com
