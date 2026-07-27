Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CC411F9A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157318; cv=pass; b=XwioE2tt+7QCwAyB5Bjeat6egJXMSuiL2UKYQKTzTgJJ0gkbNrdQ7EyPtzvWwRrxM0Ja6KCzK0BBX07Tx+RxxSiaVwGACrY3eUHugUK6Yhz2N6JGDH/Wv8ILiKTb6EKxWfWWHzmMu7+duiZTTTTpYWy1w1l+x8ZAtvVCiKxBERw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157318; c=relaxed/simple;
	bh=PLFZoqvgdzDcNNG1pDtgeYUBZaBLdlJw8WFRBEazlAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnWMs44T7+nd8ogWYbj7hOEGDgJcALI5U8BrDpYl4eltRQicMaGG7wO8XFllKluyKS9eSCJ9y+4097JpkZIxvBWKIdjxaJ9Elk2yZFe4oY+vReGV7bGwTBtt6PhkV708g6E65Tn18VcpGUbaSZUR3A1tHwsZhu+25SCR0p7E8Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GMV+muYD; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GMV+muYD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2730543b3a.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 06:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157316; cv=none;
        d=google.com; s=arc-20260327;
        b=KQMndpsOvRzEIHZCOBJH4HTBariSzOOk/GN5P0v0dKLvV4dX/k1vXZE9I/raJ/pOvI
         WW6nDN4W90HW8/LNUaV813WWkx74QaCriTxC3jrqjoPDDvvlF+cKI/FBm1U8C1/Ya42k
         ZiBylsa19WF4RATvjdQiL12mSodnidv6Ph48o5W2qGZa3BG5JGEViLcws6hj0Nf3Lx5V
         3wIV7fTW2Vl1vwlrSvOOb6E+PMTdtAdPeykbstmD2xNN6Ji1wLu9wI+itfLxELziPJvu
         fTdKCIVoSukJADeQmfrAWT3SG6ttE+55816pTFqUFUbJXOh39H6jp3COi6V5shPf5++C
         6/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smH9T+3r/D6zvCFLRvYovQFwi0Ua6Y/TcKGepfjNgBk=;
        fh=TQNZBSxBrXgrzCxDRj5GH/QdAZ6l7LqpUg920DtHW1M=;
        b=OjpfJuG2Rxc9kM+NvkTihDU4eeK4PVl2g4fnKPIZ6hlMgEuq01bIP87KuWacNOuswh
         ++F9Nc/hE2QrTM5PrWVQDzYBHJ0vl/KYS5gs7Hv85mopIIJy0HEQGj1PJMpKoxcJkUZ/
         nNEnb0jfYRzOkXgTajUuGn6PIMnTA7hteTZqIDBvi1Nx15SYnuLBwtRoMCW+a+sYzNwA
         4FODn0dBbfcTsN8Vr1eWrtC47rW0m27OeLgmbTn2EmBfeHnVy1VwTwBSeOkBnG1g/aCh
         TFYrVHQ3ZQzXW8ZYY1msPfpc/j9mS5ObextMHIqnqqIsJSnkvIqbXwGf1dtKWI2qjUiG
         pCSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785157316; x=1785762116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=smH9T+3r/D6zvCFLRvYovQFwi0Ua6Y/TcKGepfjNgBk=;
        b=GMV+muYDBMbNI0Gwzbc33nYg1NtPCL+gI/gHCOTLHOlCaJxbhhDgCM2UXs7Tq/Qphk
         LL2204NmQqPAbG3LDRWsGvRh5T2Zh14yaXkCziYsivGB6VK2NtKH+7Gef/ih5O6BpKJC
         /TGP+gGBSmfdc5Nwww/IgRAQIueuTtmRrYcww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157316; x=1785762116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smH9T+3r/D6zvCFLRvYovQFwi0Ua6Y/TcKGepfjNgBk=;
        b=OyPYdzWNFqUkrZgIkMwRes4DrGBYc+xwVYWq3lN+0U3SENqtxkwk14o14t87ZVKa0P
         EVjUso5KBEyPtB1H1y8sEilD/9ffDDRvsXtBO9ItB9ssHDfawA5hRjK8hO3bM3LmBPNZ
         OYgSpTcVzHgxpbKUi27ZA6pXVq4yCvuF3g4ZCAEwNh6VSLMaxTMG+60y83zfU5ueE1zA
         nmDE6IQ9NlEBVEGOF7pgnSGEt87KGlNo/piOKWGLdVO3znePCVOxiJiRYOwyoMxnavP5
         KSBCMjQCHpVCtHVShBueYwRiDZnofbG/HFWf221kVvP+adSohX3AREparRPTCB8pyGme
         yYZg==
X-Gm-Message-State: AOJu0Yz0aYlyZZkQT3FbgnESIZr1ShwYOe/Np1IX186Z8ThoLSeHFvC8
	KPBBE7EaCHBXf3VPPvfaOFaCOcwY6VbXMIElqMqWp8bbf+6HxYolrrmxRYlMerid1aA1b99Udo8
	3SK1yU5KsyMKWlivewdQJD0inX+GvAo2OQPsSb2920uJeAIbwtQE=
X-Gm-Gg: AR+sD10mnPz0w8I5ELGuKYAYb0JKUMVBLz2UebWN9L9mfLZJV2rlTMLVEbCfB4btobB
	gFqCTAn3dgKrVe/wz+99UEU0KSl1lgoQRunUJ7R6+CIAQVcW4dmvwNdtHk7GHMk8yifCTdMwOHM
	DA0c+g4ZDAegTT0XNr5+mSQnAwqbNHUA90QuD5wv34o3DH92fovyLkHH+EGvuvi+4j3BOvAaCIQ
	IUMwVs0J+Lw9OFx+8Mc17PPgxDZB1XzyxRIWbHVvNR/C0ewto+CZbEuy4Q=
X-Received: by 2002:a05:6a00:2887:b0:842:706e:ad43 with SMTP id
 d2e1a72fcca58-84e5947c024mr6724427b3a.33.1785157315837; Mon, 27 Jul 2026
 06:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724192441.892133-1-jhs@mojatatu.com>
In-Reply-To: <20260724192441.892133-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 27 Jul 2026 09:01:44 -0400
X-Gm-Features: AUfX_mxfzq2dbrHNj67t1xp5fvmHu_cTfE0Iz5ZZrBXT0pv_1Bb8hyYa3CWw-eI
Message-ID: <CAM0EoM=ufG6DcZC=zbKRc8BH0Reni2kXGL=sxc=Xqr6FtD1tQw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: cls_route: fix fastmap
 use-after-free and preserve netns teardown ordering
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, 
	santosh.kalluri129@gmail.com, victor@mojatatu.com, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The route4 classifier maintains a 16-slot fastmap cache that stores raw
> struct route4_filter pointers indexed by (id, iif). The reader
> (route4_classify) populates this cache via route4_set_fastmap() for every
> classified packet that hits a filter. The writer (route4_delete,
> route4_change) clears the cache via route4_reset_fastmap() before
> RCU-deferred kfree of the filter.
>
> This creates a UAF race:
>  1. Reader walks the RCU-protected bucket chain, finds filter f
>  2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
>  3. Reader calls route4_set_fastmap() and writes f into the cache
>     *after* the writer's reset, caching a pointer about to be freed
>  4. After the RCU grace period, kfree(f) executes
>  5. Next classified packet on the same (id, iif) tuple hits the stale
>     fastmap entry and reads f->res from freed memory
>
> Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
> concurrent add/delete stress test (provided by both zdi and Santosh).
> Both triggered KASAN slab-use-after-free reports in the route4 fastmap
> paths.
>
> Fix:
> Move the fastmap flush to the writer side under RTNL, ordered after
> synchronize_rcu(). This ensures stale fastmap entries written by
> in-flight readers are visible (readers have finished) and no new readers
> can find the unlinked filter, so the subsequent route4_reset_fastmap(head=
)
> flushes them safely while head is valid under RTNL.
>
> In route4_destroy() the synchronous __route4_delete_filter() fallback is
> retained for the case where tcf_exts_get_net() returns false (netns is
> being torn down in cleanup_net()). The trailing synchronize_rcu() before
> kfree_rcu(head) drains any in-flight readers first, so the synchronous
> free is safe. Removing the fallback and unconditionally deferring via
> route4_queue_work() would race with tc_action_net_exit(): cleanup_net()
> does not flush the tc_filter_wq workqueue, so the deferred work could run
> after the action idrinfo has been freed, causing a use-after-free on
> idrinfo->lock in __tcf_action_put().
>

Well... AI reads commits and comments and correlates to code ;->
Both Sashiko's (legitimately) dont like this commit log's accuracy.

> Note: This fix will slow down deletes and filter add/replace, since
> synchronize_rcu() is called under RTNL in route4_delete() and
> route4_change(). An alternative fix would have been to introduce refcnt
> to the head struct but that is a much bigger patch. We justify this as
> a reasonable fix.
>

[..]
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..c7d0164c1e9f 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -307,6 +307,19 @@ static void route4_destroy(struct tcf_proto *tp, boo=
l rtnl_held,
>                         kfree_rcu(b, rcu);
>                 }
>         }
> +
> +       /* All filters are unlinked; no new reader can find them on the
> +        * chain.  Wait for in-flight readers that may still hold a filte=
r
> +        * pointer and have published it into the fastmap after we unlink=
ed.
> +        * Then flush the stale entries while head is still valid under
> +        * RTNL, matching the route4_delete() pattern.  This also protect=
s
> +        * the synchronous __route4_delete_filter() path above: when the
> +        * netns is dying, tcf_exts_get_net() returns false and the filte=
r
> +        * is freed directly, but only after all readers have drained.
> +        */

And the above related comment.

sashiko-claude is over-reaching with some manufactured UAF and
performance comment (Which i address in the commit log).

Let me know if i should send v3 making the commit and comment more
accurate as well as re-emphasize the performance issue.
(with hope next review sashiko wont bring it up).
We can ignore the UAF claim made.

cheers,
jamal
