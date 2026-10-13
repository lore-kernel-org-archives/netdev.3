Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68251A72C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909011; cv=pass; b=eaqkDzB6EdPMLHT1YJJ6VqP/PyzSqkT4Ywwq+Hignw3vc2KQO6JTyEQX6f8/SO0SC9AF7799hIik29zBopf6Saw3vVediTNkTHM52W3W4j9fKZIrP+yFxSbC81UUPXhHxEfHqSF7e2e0MhWrDBxO5Ghkgxw2z1wFCUkLtO098i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909011; c=relaxed/simple;
	bh=rr+spJ7n0JW+ovZs/CR2CxF9rmEX93rSF/dATklRBz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em3iGQU7T4cYWZtOSdG92qDvSGM+i0Ejoh+8R7QQNZkuCXOLXUkSzN/NwCctELeOCQslLq4f+6JN+09YEabyIK6RPTWcTdmtGHd8m2FDpUE4gtNlkFLU8fNQspqyjss7weIvAdARNXRAE4Cb3KM9/3WYC+Kdmym0pUWvSj46je8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FyYzOoKo; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FyYzOoKo"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so27146a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791909007; cv=none;
        d=google.com; s=arc-20260327;
        b=eDzRyA0CUEGxDwh3RXjpWqxGtJ25ZhGA4q6+QG4z8XTTqhQxA4TM8Jb1H/PZiT284l
         JTjXR2bQFxFmZZoHeW9ppBKnyD6Gp9tU9+8C6BaOSpJDL7IcOTn+OSZwUYtbbt8HlbAf
         v7InOqTPpOURFFwzcY8MRy6R6CveI3I1zJr1Zv2HA1FgBnu3zNjmOUd8UPRVHixhKHNd
         Bflwv0syJtTtoZd4/Q+fb2wv9d4pLtZi46Jc2Aw8RVuhdN4o7BM9Ze3cdcZIZgGD4lSl
         8vWiuqjBB8zEorIgppURk2wyfynG56hysqsIkETmEXvo0xw5shf/rsp23Odk73f9H1Hf
         Oubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USnWgApP+/1SoteVw2gO1Ar5rEYFG+9nVhj1Ww1rLx0=;
        fh=XiPpS1GZTCrF3XqiwXmLAlBmr/mTtCGKbqHzhld4qGg=;
        b=g01MYoZ865HUpwXoio8qllkJECAIn39W45fLXKMCRyQXJpBYuyekUrn+8Yiff/5qiZ
         7BMjjB51tWxz37boptxZqNkGFbRosdc6cWG21pvoJlP/iVCQcFh3yA0BfKG2WYFagh2+
         EIhdspyKxrL7Mg9z4L42kcZXxsW+L1siLvooXpXOwvJt/eBPTuY76Q9KBos19xYkEEWr
         6M78MuEA4Vfhs1o3P0IgEM3lBa1E4W5c2KvkWUGyUb0Mocgj+vNCYIeQZ2RnbhCieK4G
         9TdUaycN/vHTrMvC0rYLU9tjfVSYYdp8o5Bsm0SUzZSVFhYhh8BrxwpE3nqCzZZCd+8f
         ri1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791909007; x=1792513807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USnWgApP+/1SoteVw2gO1Ar5rEYFG+9nVhj1Ww1rLx0=;
        b=FyYzOoKoP+kSYyrfqeJux3/PlQAJikAsqyNzCaYIJF25L5o6DwSIHZnLvdVmvY5qj+
         bCWqP2kv9rlJRMbhMPPY4BCG44rtCH+9TB6SjfM/Y3sm0cXsFIxlnubTqnz7F1tkvdaU
         7xf018W3STozTSJkdhyoq1+TVeidmTRRekSLZoFE7ci68bXgfUhNA8SOaN++mIKZxUYS
         QFKHKWMkadeJbUccTRK9bB0oo5prWdGCg2xznaRmvy2OTIYXVkzlKrO1qkg0Z/y5blGi
         cyHDN5p39gaaZHRvts3rnWGekIBMVjx+6G8tDTy4KgnovdRdtk8+LezMYfqlaWmi1Xjo
         CyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909007; x=1792513807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USnWgApP+/1SoteVw2gO1Ar5rEYFG+9nVhj1Ww1rLx0=;
        b=amMUAYcAYJfNUEyBeDLRQOGwAuaHti1GFu+OGLPjJsvorj/Wp2OufRYd9bNTZzLEFO
         06QrbLNYwAdSG2otKaJL/HsBOMaerSL0kYDBbQfOSpEh4y2V7UR+gH4VDSh3ygKYZf7l
         7hW8Kk0bWyIrfWkzjSd1nKwvH6YAF+eLLdLvf2kr7ejN8jKMBxjJiHF3piaydzXx7rC6
         Yo7PZwvB+l+9fInMYVUSDHYCifId938LZZzs8xagfyFrbRWREmRMQZgqLimaxNXIZGwn
         wptaLAXAf8l628O0TQLhowzpSgkAsId0cGcs0hwW87yFbXowZjwNjFO7YvdHss68CLHD
         6USw==
X-Gm-Message-State: AFq9FYK8H+feCl/lw4nGGQZiB7r3gO7thImmtx/9ddqL7+ewKnd65KXU
	2TNU/X3iGWrbCdDV8Q11UwdrnBd10G6ofv3erts1zlZY8o5PdQVDekQbih7RZ8ypy17m1B5YnCf
	CFlIuZLQkv6sbQx/TBPD3fPsTwvvgTxUxpsGhZQho
X-Gm-Gg: AYBFou0PnGRlTOCup7hOmmy4BXZPxwGJg8GNUy5iKZCLM3vi7OjXgl1j2jTCLdgONDv
	4wr1+TnCtpEhGAgORw50W4miibsEdqwpSBoIgAIRx5APlShDhfhxxUV8muaDrdL2BcIWEs/1U8L
	E9vJ9t+9R0uTOOJpZ6Mks1W45t8AecqAa42cLoAW3n7Wrk03wCzsMw7S0+WVvWGRHQ02mImQmJL
	wEAfX71mnO7rr7zTy9sxkeQAAfYGP8x+0sdmaEd1PLzrZXAypgnsqm4tTj8G0SmuGBGSGpySNNB
	tJeTHXlN8kl5QubaRNSuEwakaIdOgvhCpIHYAe6wb0nYy6SROAfd9i3lKQdlgh/0ZElVLuovL/0
	g4fjAGDnlCw==
X-Received: by 2002:a05:6402:a593:10b0:6b1:d313:16f8 with SMTP id
 4fb4d7f45d1cf-6b1d3131c5emr113934a12.0.1791909007037; Tue, 13 Oct 2026
 09:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012082148.1698596-4-almasrymina@google.com> <179188049412.434549.8105329401807782174@kernel.org>
In-Reply-To: <179188049412.434549.8105329401807782174@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Oct 2026 09:29:55 -0700
X-Gm-Features: AclHuK8kCFpm3iyYaxSIjhAo3U-PNi7X2jSQzQnctTkUNfPkNJqv2oqIvvlgRMo
Message-ID: <CAHS8izOKULOVuav4R-2rcw=38G2oifcSj2EnbVoyEPcW=kLD4A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net: skbuff: replace skb_page_unref() and
 __skb_frag_unref() with skb_netmem_unref()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, u.kleine-koenig@baylibre.com, 
	shaojijie@huawei.com, mgr@kernel.org, j.raczynski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 1:34=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch fixes a real page refcount bug on mlx4's RX error
>   path but has no Fixes: tag, and the fix is folded into a tree-wide API=
=E2=80=A6
> - [Low] At this commit, the new kernel-doc for skb_netmem_unref() in
>   include/linux/skbuff_ref.h says it is the "Counterpart to=E2=80=A6
>
> --
>
> net: skbuff: replace skb_page_unref() and __skb_frag_unref() with skb_net=
mem_unref()
>
> This patch replaces skb_page_unref() and __skb_frag_unref() with a single
> helper, skb_netmem_unref(netmem, recycle). The SKB-owned fragment unrefs
> in mlx4, sky2, tls_strp and skb_shift() now use skb_frag_unref(), so they
> follow skb->pp_recycle. tls_device's destroy_record() now calls
> put_netmem() directly.
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/e=
thernet/mellanox/mlx4/en_rx.c
> > index 96f97fa0f5489..fe18606c2ab55 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -497,7 +497,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_=
priv *priv,
> >  fail:
> >       while (nr > 0) {
> >               nr--;
> > -             __skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
> > +             skb_frag_unref(skb, nr);
> >       }
> >       return 0;
> >  }
>
> [Severity: Medium]
> This looks like a real fix for mlx4. Should it have a Fixes: tag and go
> in separately from the API rework?
>

I think there were a lot of latent bugs in the refcounting, and if
possible I'd like to fix them and make the refcounting more consistent
rather than split them up. A lot of the fixes depend on reworked or
introduced new consistent and symetric helpers.

>
> [Severity: Low]
> This isn't a bug, but are these kernel-doc references accurate at this
> point in the series?
>

Very low prio nit. The comment becomes consistent later.


--=20
Thanks,
Mina
