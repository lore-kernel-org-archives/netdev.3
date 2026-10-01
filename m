Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4CE33F5B6
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814674; cv=none; b=TBEpXsNwGLw1gZnODI5dKTcY2TXnZcCCJpDng3CSc+Cf3UT9VVUJ74Mvg2T7B/+Bs6YQlg9iF8hvwlTXxzrYkyB4cPTit34jg5H5AT1PClGM6EfLwXCQqnWouuQ3VR0+GlUf50Tm2ChlqWrq0R1F1OwB/euYkw1hVg31jQaAudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814674; c=relaxed/simple;
	bh=dqTj0MZrFfOa+ZxXLtfnC/pe1AWktx7H3quZH0bdCRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+RvD14eW6KtcAOdYh0G00n/75kD1XRSKN/fFoZASU9M4jwFzEjMtKiOwvUdqZbk0c9zJwpFTN4b4lBgClcG4fmymua0sN3SP3JJnMPg7hQymOaSsNyPAUgDu9r9u/8LHSZOlWOUP88y6lJlvytthxH275bt2CPGPK3HUqK17yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyePcqc3; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyePcqc3"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so6507578a91.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790814664; x=1791419464; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqa8UEr3NfdZuGngCMvdc8mK3hbU/KTX0TorCz4toDA=;
        b=RyePcqc3GrSN4wSvXDsNUKdd69HZjpC4PZtpCsH1crTMyaJeYwo/s2oo8PreCjCwrQ
         aMlxx3uJVXsxKvYngovxiGZfGBDkYiOFjxPsTbT1HX1GQheQY/YBbYQVU/jUCGH2CJi/
         SkwQN3sNWzFf8fPeuPS/YC0Ld4LNrQTiTOxrvlaih+s1j2Xao3vsU7mBKuIOy8ZL71oc
         n2qI2/Ij2JdsdAKsIERrOfcU8dHY3zyxxEBbGaXDFeXodiPf7a41hEUf0iseNfiX7MNB
         10pfX8Ptsc3/eT2a6jVc7W0aXCw+wiR2kytlhNuYFeIoNHYUdaUIuFOSO5BY5qMXOwB9
         3kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790814664; x=1791419464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dqa8UEr3NfdZuGngCMvdc8mK3hbU/KTX0TorCz4toDA=;
        b=jDKS/gVM91+Kmxfd5rQ0fHPmf7K1YG9e3q73BsU5ZPyKQc6D65E8ormnZ51symaphc
         BwDjUipnu7qTUlKA/rt+CHsYfqARKKyU2IUSR4Yj9yHwSdSgiXvqXwkU3hQVYfJ/6NM6
         QqPfu/Q+Uhpl1DPfc6P0zrffpyh4R7nX4ScPVh/yFzWAyIMMX2zbZG3FzwI+5fFYwFGl
         Uselj6H6Fbx6xVv0/WNCYacJ6d2omthSqddkzJn+Ev1/6yvZZI6Fz0QkRLUTLvL4SSSx
         VZKVUDF9vXWYO6gLkSNRi2a5rEfoW0LbzJHcRom5YFOLcbM2rklJ0CTAOgZH5nq7YT58
         PRDA==
X-Forwarded-Encrypted: i=1; AKwUvBzhdbcatBwcVtKNtp4TbfdTaoHtEW8KIK3r+z8nMecoFcCE8h9Z33Z6wdrFx/NZMHTl9Yxqwo0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJavtjhZpXZI7zTHbGPEh88u5YH5rBBK/bh5RC3i21rdV426z/X
	O9dwWQDKTafTvyZyFrLBk27/hWph1uUi9qq7KDhaXG3TSvNo5HB7QR5PlqA2Y/63zPnvOG/S3K7
	NxV1eHQ==
X-Received: from pjbng11.prod.google.com ([2002:a17:90b:1a8b:b0:3a4:8aa5:b794])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2cf:b0:3a4:df8c:a4c1
 with SMTP id 98e67ed59e1d1-3a4f4ebce10mr441149a91.57.1790814663681; Wed, 30
 Sep 2026 17:31:03 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:30:13 +0000
In-Reply-To: <43ad79b6-40e9-4704-bcd5-b67255105fae@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <43ad79b6-40e9-4704-bcd5-b67255105fae@linux.dev>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001003103.987619-1-kuniyu@google.com>
Subject: Re: [PATCH net 1/2] tcp: restore RACK list membership when undoing loss
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: edumazet@google.com, netdev@vger.kernel.org, nramaswamy@openai.com, 
	edumazet@kernel.org, ncardwell@google.com, ycheng@google.com
Content-Type: text/plain; charset="UTF-8"

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Wed, 30 Sep 2026 10:13:42 +0800
> On 9/26/26 8:25 AM, nramaswamy@openai.com wrote:
> > From: Neil Ramaswamy <nramaswamy@openai.com>
> >
> > Partial undo can clear the TCPCB_LOST flag on segments already removed from
> > RACK's list, which prevents subsequent RACK loss detection and can lead to
> > long retransmission delays. Restoring them to the RACK list allows them to
> > be reconsidered for fast retransmission in the future. To do this, we first
> > sort the segments whose lost flag is being cleared, and reinsert them into
> > the RACK list (which is sorted by transmission time).
> >
> > Fixes: 043b87d7599e ("tcp: more efficient RACK loss detection")
> > Signed-off-by: Neil Ramaswamy <nramaswamy@openai.com>
> > Assisted-by: LLM sparse
> > ---
> >   net/ipv4/tcp_input.c | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 92bc60716f33..38ac07c8b38f 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -69,6 +69,7 @@
> >   #include <linux/module.h>
> >   #include <linux/sysctl.h>
> >   #include <linux/kernel.h>
> > +#include <linux/list_sort.h>
> >   #include <linux/prefetch.h>
> >   #include <linux/bitops.h>
> >   #include <net/dst.h>
> > @@ -2840,16 +2841,48 @@ static void DBGUNDO(struct sock *sk, const char *msg)
> >   #endif
> >   }
> >   
> > +static int tcp_rack_skb_cmp(void *priv, const struct list_head *a,
> > +			    const struct list_head *b)
> > +{
> > +	const struct sk_buff *skb_a = list_entry(a, struct sk_buff,
> > +					       tcp_tsorted_anchor);
> > +	const struct sk_buff *skb_b = list_entry(b, struct sk_buff,
> > +					       tcp_tsorted_anchor);
> > +
> > +	return tcp_skb_sent_after(tcp_skb_timestamp_us(skb_a),
> > +				  tcp_skb_timestamp_us(skb_b),
> > +				  TCP_SKB_CB(skb_a)->end_seq,
> > +				  TCP_SKB_CB(skb_b)->end_seq);
> > +}
> > +
> >   static void tcp_undo_cwnd_reduction(struct sock *sk, bool unmark_loss)
> >   {
> >   	struct tcp_sock *tp = tcp_sk(sk);
> >   
> >   	if (unmark_loss) {
> > +		LIST_HEAD(restored);
> >   		struct sk_buff *skb;
> >   
> >   		skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
> > +			if ((TCP_SKB_CB(skb)->sacked & TCPCB_LOST) == TCPCB_LOST)

nit: "== TCPCB_LOST" is redundant


> > +				list_move_tail(&skb->tcp_tsorted_anchor, &restored);
> 
> 
> I think the simplest way to solve the problems is just drop 
> 'list_del_init(&skb->tcp_tsorted_anchor);' in tcp_rack_detect_loss(),
> although it will reduce the efficiency of RACK loss detection ?

It will almost revert the optimisation done by 043b87d7599e.

One sort + merging sorted lists during undo seems better
than reintroducing costs in the fast(er) path.


> 
> Leave it to maintainers.
> 
> 
> >   			TCP_SKB_CB(skb)->sacked &= ~TCPCB_LOST;
> >   		}
> > +		if (!list_empty(&restored)) {
> > +			struct list_head *pos = &tp->tsorted_sent_queue;
> > +
> > +			/* Ensure lost skbs are added in transmission order */
> > +			list_sort(NULL, &restored, tcp_rack_skb_cmp);
> > +			while (!list_empty(&restored)) {
> > +				struct list_head *entry = restored.next;
> > +
> > +				while (pos->next != &tp->tsorted_sent_queue &&
> > +				       !tcp_rack_skb_cmp(NULL, pos->next, entry))
> > +					pos = pos->next;
> > +				list_move(entry, pos);
> > +				pos = entry;
> > +			}
> > +		}
> >   		tp->lost_out = 0;
> >   		tcp_clear_all_retrans_hints(tp);
> >   	}
