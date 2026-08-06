Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F23793A2
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042264; cv=pass; b=swlKSjb55eVZUO5Rm2w3UIsz6lGbtU+sHbC1nV+wNCpz0Sz7RF02H88goHo60IShHBsJYGD2VYPzVkkamOQnhKRFPLSTEWLMg3kzCLpf9HMjAuWCsoGplVmYqHx2tlYQFG4k+f9x4sGdAw2UaytBS/q34u4m529zZTuGpcWfWos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042264; c=relaxed/simple;
	bh=XUp8sq3ZQPbWuj50V96fLS23pI0dsKpY19Irb6eeJ8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhfXSbzkfvdtWL+HlWMtq/YLju1VxpLXnASFVpadXLvUpw2mMLuGTe4SERXdu//gkzruiUAlBQP+g82moGtKEhO6U0XNxHun9r1Ogh7+BoXAcKq1UpdrXEBDYmriwNQ3XK4X/KwnVwQPkb89HyBi4poCxi6s+P4Qx0OGWc7uHq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMpMpKRm; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMpMpKRm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso22505ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786042262; cv=none;
        d=google.com; s=arc-20260327;
        b=YYFpm3IApJX8DqqhHcV/bXU1Om0vKV+X2vRBQoVQamXYBGbG8d1F3E2ndCJFBiUYrC
         hoH6e2tU9nA0JNLTDVvbLTie4aJd4IxxKf2foTdO+yHuphXIvVOxxwlAmS3EAfQ8oxMO
         FmD+r0Jo1ilZCTx0A2cgX0W+f+E1tJMgCj2xfce+KlBLKbo48gO9+8XSj/7sGbKFQLQz
         8MoQr8rfVZlppsyVyDrNeSLeWjiJ5yZIM8KGBxPhEceR3rkI+FslBRW7PbtmrzW7coTU
         TXQqbT2LRBtFpyYHlTkA4rabKuJzQ/4+yBT4/PWhxehz1ZLEFeT8PdT7VjiqFJbIBX2G
         8LeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUp8sq3ZQPbWuj50V96fLS23pI0dsKpY19Irb6eeJ8Q=;
        fh=kYpfiypJp1tAzkb4/H/WvGvFGibnaNFc058zAzHk2Jw=;
        b=hnd1IdHYx4t9aw6bt1B0Rr2D7EUy2qnpEpt0w4ZnNBgJzvcwrWA0pscDhoupIO3+yd
         4/+wwzoTBzbSGyAYofHGuYmQ/CwnYtsDvcBKWex7OdwPxBdmGiBfveIX0vf8AV3DvmGY
         /XnN/e+sV3RPA5SqAAfjUDfYJD7LZdg2KIPPYV0qXBesQ57W1q+VErjk6TE4rcdKbBml
         abI67xETIEqvcNF0wJv3Ts5G6hw6GTJMTRDcLEREAKQInAbp65O1mebZgTnrluyaihMN
         bPplsf++g6NIAI7dpic2ivw5swn8Taee9+K42R28IimKPiLhFTtgnLd7KfM8w91n+PVC
         K2sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786042262; x=1786647062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUp8sq3ZQPbWuj50V96fLS23pI0dsKpY19Irb6eeJ8Q=;
        b=fMpMpKRmsCec4deyp5gu1H3xuiMVdzagCRN/KppZU5+S21IYyjToe4qxL9b7a9XXyr
         9WsnAJbm+vpf5RHZjtz8/HJpYAmRtCiToFOudQY6yu5IJ+5neXFNNcQ0vkksSBSDMtcj
         m2nQC042ec2k2NuHhrJjJcLeNjhmL7wvljzydoClP8DoJCnymSdwxu91VEFfMqMcYJeV
         D1p0OEBnfuilI0GKfK9cDaebQd5U0eiX3S5q4MLGcBaX04kjhXu3RnkWZmS9Qb0Cqs+2
         FOv5YTTmkj5FtXx9OJ7w9cmpZeMb5HlMWsWhIlGzWjH4cQ0tuIZ5N9xScvTVwWas9r+I
         S63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042262; x=1786647062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUp8sq3ZQPbWuj50V96fLS23pI0dsKpY19Irb6eeJ8Q=;
        b=eLcmTsx9ucI4QN7NoqetIe9d44Wt8yDHjNM8C81p9dzrNCDXOFQVPDJ6l6SJGIkvhu
         +h97zwLGvu6TUTow454vQJ6i2pJOa0NqWqgGSOh2r1QmmSgoNEXuK7pRxlflAcuDYzAR
         FxSK2pjJdomkQL44wIfQr3Xx91DgO+wemQabHmmCfOAyg8RQcbjYyWk0Th0+tsATY/Ww
         vwuODUhF90hJe25iCNBm9H/NF4lIyT/6/05HAq3PFLe8I6vVMxSjNED4f65BwMT8rwCY
         kEGtqzlAEmI9Iorj6pqhFsEJxrgaOyFYnEXd37DnqbONH84KZDysCZYqkCwMXfL0BYfl
         qFdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3/Qwh9bpDchMTsDnDly7rDLD74nNYcjnWFcBVvxmneuhgETRQiSpra0jZ5Qq13kYRAzZF7Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75a3q7nV7Fmz0QcCo3nIy5pm0+SPYoFBoERBHWM5DlCpRXCws
	3Sqakgk26+E0P6XizUMdF7PuMBEuSG4xQepgnw4tbWSKyrn3vujNRnDvu1Rw/PLiPwFjSl7sRT1
	439g4IHqkp6xm289Rg1QcgxUjjfVbiy3vmLL7qQfG
X-Gm-Gg: AR+sD10LbI6n3S5H267mV2g6rlkjRFao6IMcj6Ka3TUx1zYmMgjgAEY2+1DBuP5bVtH
	6TmBaCtJLcXOY1z/n+XVid0xLN/gX1wYwwaJZFTDvnSSeMuL4+gM6Ingd5AeciPB+vIUfH/MEl0
	V0vMOgsq2ydQ9XIovWQGiFqznsesj9gJ9SJ/K6DDzkeUeQbzrJB9ybktBewwVIAla8wWSGxeD4q
	Q8MIPO5Q+MDXzsz5vAsDGvVS0VKGmN31La6TdTLoc1TfmKCcboqAg7L4aqIjEJr3P2+s6oPQ67K
	HlLNUVRzoSs6LAqh+/q9PMXJJdl4nM/BDysYYSW5vl79DS8byjgykIeSXPRKYCgGiRitumRYhmw
	MZ5Bk6vKR9Q==
X-Received: by 2002:a17:902:db02:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2d120431c1dmr1078495ad.1.1786042261839; Thu, 06 Aug 2026
 11:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731111507.2355601-1-shaojijie@huawei.com>
 <CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com>
 <20260804191628.762ec7eb@kernel.org> <CAHS8izMVqidVkiVHNWZMqP4Eoi5N_M3Wv1Cnn4jjxHf3=cWNQA@mail.gmail.com>
 <20260805161114.409b1d81@kernel.org>
In-Reply-To: <20260805161114.409b1d81@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Aug 2026 11:50:46 -0700
X-Gm-Features: AUfX_mx1oa1Rb9WpmmQnmxFLkpaO4N-E-rK4PxNJrCW1a3DIYQIFMLYM5qCX9gM
Message-ID: <CAHS8izPu7uH0yn3RRsFnEQJQe7h3E8q2oGsvpEa+o0u_s_XgYQ@mail.gmail.com>
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in __page_pool_release_netmem_dma
 on xa_cmpxchg race
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, toke@redhat.com, shenjian15@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 4:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Aug 2026 20:50:46 -0700 Mina Almasry wrote:
> > > Not sure this is a good idea? scrub is trying to touch just the DMA
> > > mapping, right? It shouldn't try to update the page itself because
> > > it has no reference to the page, the page may get freed in parallel.
> > > Hopefully DMA unmap on a freed page is legal..
> >
> > Scrub actually frees the page in the loop in
> > page_pool_empty_ring(pool), so it's not true AFAIU that it 'shouldn't
> > try to update the page'.
> >
> > My mental model (roughly) is that the pp has a ref and that single
> > last ref can be dropped in the page_pool_destroy() path or the
> > page_pool_put_netmem() path, but the ref can't be dropped twice and
> > the same goes for dma unmapping.
> >
> > Now that i look closer at the code I have no idea why we didn't 'just'
> > put the dma-unmapping inside of page_pool_return_netmem(). That code
> > path is already common between scrub() and put_netmem() and does the
> > synchronization between these 2 paths.
>
> from memory so likely wrong -
> ring scrub is freeing pages from the cache
> DMA unamp is clearing _all_ mappings, including actively on used pages
> the are different sets

Yes, my bad, after taking a closer look, I was completely wrong. We
can't put the dma-unmapping in page_pool_return_netmem (because that
can run after the netdev is destroyed), and yes, there is indeed a
race with the page being freed.

FWIW, Jijie this restriction=E2=80=94that the scrub path should not touch t=
he
page, only dma-unmap it=E2=80=94is worth documenting in a comment so as not=
 to
trip the next guy.

FWIW, I also have a rough idea of how to fix this race? I'm guessing
we could grab an extra ref on the page before putting it in the
dma_mapped xarray, and then have the winner of the xa_cmpchg be
responsible for dropping that reference. That should work I think? But
it adds overhead. I maybe wouldn't want to add the overhead unless
someone is actually running into this bug in practice. My
understanding is that this is an AI code review theoretical bug.

--=20
Thanks,
Mina
