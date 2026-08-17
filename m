Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09934317164
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940918; cv=pass; b=ofSQOZ3uMJycV+lsNgTmOS/y5ryx19lfh+9tWRqnBpzbn9U1goPFN0nQkORIsKzo0NvOeQOXXwL5dFaCaHd9satw5RXj0Dv057e9kjftHlOfpgpMdq4thxeaS/jWPiU20J+c42Un2GSWJBFF9pO/jwYbbKQeGmqUkjihEJOctDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940918; c=relaxed/simple;
	bh=R5NlM7JX+7gX9vyxDMbzNKkRtNfi6TQHebfvN3YC7rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu8CCXfM02mMGY389AcLpm8FVTIf49EzyKKpBC4IxUfEeiO7tIbIrQmeWT1+U4dUcA4nREitSM76ApAO4kjt1SkrTPkC1NstWbAK7WKWvQqOpejIoPnHzUHvZSHKyGoGXcf/kKYd7tpZ0ntdu9kYZtJxCzSNNZPhKrE2lTnr/3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sw6k2iqU; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sw6k2iqU"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so1229483a12.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 21:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786940916; cv=none;
        d=google.com; s=arc-20260327;
        b=Yrdi4CUJmFeNDM0Mpmpnq/NffvzRPq2H5PpeR+C6AlqhH/S6OaqFN4etvp6UQ2iH3c
         dEjuyuJRSm5TGq9+ADO5enWbOqyeFLVouJvn2jquz40SQGvBeQEVLJKpSrhwuhUd5x/o
         8stL85v3mBPg5Fpr9qGVNjAtsMIJrGNi2XExVeQHsz4a8bmAOt/GkcItiHmdhvQSUI+p
         xlm2mJESga5korHxA6Vcq/VwBP1VPZ/CrNcmpJDvTmDh4vExS4G6e09ufATB+hyitdSO
         HeEflsQIZBNRiDWpmkUhqQ5KYk39Si1g9jkb1cHzq3j9QygrtHzA0l4UoWduxjOvBkaU
         RNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=np/a560KEDySTia9A46SmI+SWqeTHZFW9gThnLc5+gY=;
        fh=8ZaU62Ou3J3XnQUfCxYWoPuQiWpS6gTuzCisYLpvKx8=;
        b=m5ouq6Fzpw63fEm1nc8P27+tSt/H8bV/RznLYzuqD8ZVdFrjZNfs+jWI52pXevQnqD
         45rg3y+24Tqcb+ue7wDCQRhZzjTLyPQeUKNuS4Chnf8GLLn+XoXLLeLPnncBt+Yzql8U
         M7tB3EE089qcu5+AzpDaxDnCu+LfPKldPjW9+8H3K6s2SSHsUxYYNpluSvM4BJQGo9dF
         gBnAij/27zEZh7LOT/W/qzJMNWanXSStj3Qlf52Y1dnCVnhcKvVYFg344jB7QuslKuS9
         ZYJOPHOU9gtOFh3QiQ9ddaoT860rrRf39z6PX1n42r+6Doc+xOMgsKP7SQ2ugaRCOYVW
         IeiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786940916; x=1787545716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=np/a560KEDySTia9A46SmI+SWqeTHZFW9gThnLc5+gY=;
        b=sw6k2iqUTFaWxhYyTGtOFN0CrJ6HRGIrqjnLS2oX/F4RlWakAOwcvJNhDw9kLnHnSv
         yx8p+vRKqEMXpR9LeveSm9Z84RYNJkVvimSAb33kBDp2EeBOZpBNnmwyU8Q6lnkWB0vM
         3+uU70NMCyjTxKgvHR5lzvaxNm2G1f+O0n1hDwGGJa1oBRap1tK2qYK3uJU3HPwa+B6B
         Fiwdq/wOnoUD2bynlZFy05eiEQ0NniJaOv7xhWGJvac4FeruMian1htxhLx9lOQFVAVk
         g6bhf02cwFKywpoiOR/lLxb0E0vMvJ42fjlqB7vfnag4ZB7tokBjzUFX/WfmAk5ms4lD
         qdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786940916; x=1787545716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=np/a560KEDySTia9A46SmI+SWqeTHZFW9gThnLc5+gY=;
        b=psgq2BTYga2VamIw0jimkOhSnnk/MYXZDi9tYAaJkNi1QfAxEdVI9Dw5D1dSc1uCch
         tFzoTZ4MHs6Qoyq2KLU/wzJuCT9N2ioA7SbOTGV+7r/f/g1bb80aTxQd4OqzKL0nvEFw
         j2KwMa/2Jq3lFuQbmWyH9aWtjuv6BL4rO9NxyxKKj9yJsdQJJOY+xBBldD6IKBVOiZqQ
         h8BjANw96D5mlhLbkRIBA+h+EmQBuP5GS1r12WECRSmm+KMFv/ykglIQuwb5Zn+RPDmM
         CtjCRdqt3nsdakEtnsDOqscTxCTDh8CfwAowI2itfR7uRMKfzo/i5oe/y9tVPghWN9Lz
         zgoA==
X-Forwarded-Encrypted: i=1; AHgh+Rrtx/nk0umTkBw5Rng+ChJuDGGKCBIozHe0h081G86OqeTM4u9b9EfDUufNZbCEVzbhJQbM654=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGswy3f/pl9kHJ2MwuOFytC/M8dU9vU/Q1MJpw6DuvnmI/u+n
	N9QwaG0BExFt63LOQaeXQedtqohzXHk7RQpVrbJ1RcJszZ8WAJUwHH4UAJG6lumUJwIkb1tnt0k
	iE8hxRKVjvpC7JZsogznkhLC47CvZ8xqLorvbS0pf0mxpThIpyF67GXYYSa4=
X-Gm-Gg: AR+sD12MERI/b+f/5Ile699/wYxhB7EbginHXcBOVKfuN3DMAlDhg+O9cfT23Vr/RfT
	t2kDvGqaBVIyKj2o3g6BYDS6xgf10EW/2G1/t9UhSqSr51ZweMakM/WJkXh4OeZANyLLOWSejPv
	rP8c6nKAgVVxrgcn7W+63X0Vj664cxnEE8t79wseZ3b+dVjhYiJY9HSK0ozS/GAk7TX6Tav1kXO
	70LfFICfOgYWQ9Zi0UlLmsghJEtOjo8Qcmo3lNXGs+NHa4hOO7Mizie6NkvIifD3xBmxbg78SBl
	5ZGt60HeWq0R/GbGo7x2iZxILBKJnE5hcOaYQBKPBX3NRtODmvJm7GAVE0HyBa8bMuukLrObx4N
	R09DMj0rH9HvLqKOnolBriseDpmzdHT+HaLaFXXAAaDFb2P92NGXhefZr
X-Received: by 2002:a05:6a21:4508:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3cc71a59053mr25169043637.14.1786940915801; Sun, 16 Aug 2026
 21:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
In-Reply-To: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 16 Aug 2026 21:28:24 -0700
X-Gm-Features: AcwNN1WiVXg3WohbrXkvhb-iUuV_9c4NhqcblNLHlnNYeR7f5t42O-_x8Jr-_EA
Message-ID: <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
Subject: Re: [PATCH] net: make sure final 'struct net' free in
 net_complete_free() is always deferred
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 4:08=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since there is no serialization mechanism (e.g. the RTNL lock) between
> llist_add() in net_complete_free() and llist_del_all() in
> net_complete_free(), it is possible that net_complete_free() finds 'struc=
t
> net' as soon as net_complete_free() added it to the defer_free_list.

Did you see a real issue or is this based on AI report ?

netns_wq is single thread workqueue.


>
> Fixes: 0f6ede9fbc74 ("net: defer final 'struct net' free in netns dismant=
le")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  net/core/net_namespace.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index d9dafe24f57e..6e9a0c29a9a0 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -514,14 +514,10 @@ static struct net *net_alloc(void)
>
>  static LLIST_HEAD(defer_free_list);
>
> -static void net_complete_free(void)
> +static void net_complete_free(struct llist_node *kill_list)
>  {
> -       struct llist_node *kill_list;
>         struct net *net, *next;
>
> -       /* Get the list of namespaces to free from last round. */
> -       kill_list =3D llist_del_all(&defer_free_list);
> -
>         llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
>                 kmem_cache_free(net_cachep, net);
>
> @@ -703,12 +699,15 @@ static void cleanup_net(struct work_struct *work)
>
>         up_read(&pernet_ops_rwsem);
>
> +       /* Get the list of namespaces to free from last round. */
> +       net_kill_list =3D llist_del_all(&defer_free_list);
> +
>         /* Ensure there are no outstanding rcu callbacks using this
>          * network namespace.
>          */
>         rcu_barrier();
>
> -       net_complete_free();
> +       net_complete_free(net_kill_list);
>
>         /* Finally it is safe to free my network namespace structure */
>         list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
> --
> 2.55.0
>
