Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835A360EF2
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417297; cv=pass; b=KEV4nEthKD6HppondODAmEshNJ+SDZQzTUf+IDZ59cA4uWBQRSZPJmmLOXHtWHV+rcpSZuDzU3dmwsQqbGK04rV4540Nh6HjWwXK2i8sPY94JOFZtLW9Cnjba/trr1AxhgMATXg8SYeyzzXi1MYSIdnKFo8mhk//Ad9azhDRrN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417297; c=relaxed/simple;
	bh=MDyoROjaxtyy3kt1wLEk22lLIUHmORSnmJ1iUH6bkUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0tVvu+67JX8Io7zZz4GWfqz3YGRmtwWAiCr+fBBALODnP4eP8LfgfdTfjOr/fa3fVLak7ma3psg6aMH1K3R74yKhucDqm1TkIy17badAOZJEIocxJYz3GjRr/NkPF8rtNy1YqwuRbUvTEpCzH94vUa98wR2Pyx23NBs7LYIzgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzCBiyAv; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzCBiyAv"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-530de0bab75so28683561cf.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789417295; cv=none;
        d=google.com; s=arc-20260327;
        b=qokUuG/xT/UzRCnTNT3/8K4noh/D35QGKXOM0Z3SgMWC3HBDYPUFvtfb+HwxRYOxFa
         kmQRm1z8DfhZlkfZ1n9tLHAN8FmqjhkzP6FgdQ8myEG1bpBiFmN0n0DE2+11esrMVNjN
         FuKmXp20tL414ch2y3qfCrES/vJHhxP34tRRXjkCjAkMyyykwp0Y54XVJZzfWpwnFdaH
         QxYLjonIFgl1cecsI62I0iBvMJwyIC5F/pwEUx+ACw5/gDnwIeNKThkLE7EGWR8Fb6ro
         5XsKHoVJTvL1Z5SqSPKu5VOjbQK/e/fzUA0dZMcmskKhjaZGpiibJF/0VSfmCWG2gLoh
         zRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB4z5ld/pqswcEJ5booeeR+UrUp3UtJZoZTxdNkowH4=;
        fh=2NEJTM7n8fjtidopeTXiTh56V12WkRGOAQ54WM1Bp+Q=;
        b=PsTGLwkp6IKiMC5JJ/cCv/U4tVgQX41iQDxD9gbFgLp8KqJclXn8wRGNRheqOVp5Nj
         zF8xG1ncLWC0+DYYily5KMzBvk3dPDQA9hZVkGqrvsMMD7Xc506oeejQ2ifKViawuib+
         K7UKvKGqWI9iu8M9CYZgjWch/muAlPbIGqlybanZ8b7u8pVn8HwLp8x4oMuzw6O3v8+s
         ldJzbQLM2+3wLjdI/4fLHgKC3Bygw8a6BmNH6sb6pPCOhokObBZmtrWRR1qixItXYQ7S
         NucU3Mt4cnsxNcMAXASNRm1XWFhaz1Bv0UMVqMwVwszMfUCBpAPaxIEd9W+99/k2Yh+/
         C5uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789417295; x=1790022095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vB4z5ld/pqswcEJ5booeeR+UrUp3UtJZoZTxdNkowH4=;
        b=kzCBiyAvIknmqnPn20uUsa1lhbPWZ/rVFTCB48A2bA/PGjVd06fXdC6TCRJS3rIJPB
         PgJOOdKal7Nx4eLDDLbbUk6qWKs9s3rnpWqoIakReWbtLuj2fknLhvKLdr9tZYpz0ek9
         DQPzfoxV1Eo64mLfJGh/iFkG02Baw32TpNMeZO2Dexpb9yvHTGaS/qoo9t7K1nfTd991
         fZ6XU762ZBaCcPKqh+49ahudFTH26cukAZ/qSxMhreBcLJXVInVTOR99GBwnhxnTAEDA
         XFrlf4xmDpuxiPQQ/gPeLAYcqewaarHbCkoaV49VGLYpUqZXhXWmqaIvbgdub+myheDV
         riHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417295; x=1790022095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vB4z5ld/pqswcEJ5booeeR+UrUp3UtJZoZTxdNkowH4=;
        b=LoVeZ5dX/CJn9YDyBfq3uy5aEH0zp97wT4J+mVvUecFs+VBv+I5Jkj5dleC+0Yo8yv
         hostQV3zPpKmlMBpSUBokj+0oCfJOs687NuMQVjToh6zoYZnhTyhlzOIhO/lzHdfXGl8
         u1toDkzqMn5itRyRwZsvM+cpkxIUduNrQnQ7ost1VJkyNnAkqeWr0Xo1lvNJEwkPqaeV
         t48yqSMiMMLc3Z/RM990N9DMhLUFDyohtaRyi0EX8uBOYoy6Q/iQPZYbji4qwG3BhWDe
         SZesV7N15VE6cG0ZJphdcLIO7zE3TGpR0r0o6oiLuJYXOq6CoA1xLV0o3Nl4m6Tmrwkp
         aM/A==
X-Forwarded-Encrypted: i=1; AKwUvBwiJc9wxXwcJw5pcSX4dBh7N7Y6Zqx+qLWOzGk2sj7AVZtVUZByqNz7SX0dM2PmMvTNqniZQKE=@vger.kernel.org
X-Gm-Message-State: AFuF++klav6eQMK8E9wfnZzrdSWj6sHHdjLtfOuVCEWI4KlNstZ2cdl0
	bupqcEpg+mrO8cVRX7daD3Di7+7vUOrdJlu4KnGVuRO63lcQd9vnufDLx5QrO4FDQyF380+PPHU
	w30Rn7bnrBSYCNh3c4yczah1qJfasdo2FBbdO00m7
X-Gm-Gg: AYBFou1k7QFiiwvtvSjIMwS6gPyNKlDuaVzymK+4Xo7d2YebeH9yqjyulsXajvwnv3Z
	5G7SlonJ4kL1beHM+n5AbJA2ZtFURD/Sz6z9jxs3sOpW1bwHVQOU1gagcRgXMzeq1jY14KVos2i
	kniHcpXjOpOGkj/Wl00oSRTMzGtePdJRIlSTzsBCMCe0NsYzB7f5HXume/0pSE1JwYNNyhRHEmE
	7RSSTqs7ZXDPqo8/WlP71EnY+0E4e69PEda/L8/7/5uuMMGumqVplqJL//wZc8GFNHwHlUvNOaF
	DwHoOPu7mmsLwpxOd+kkfSRHaMm8XNevypctq5iQ1mEsP8HXHd1dw/eILt2kqxi+rbDYKvSDbzP
	MxfPS5sjMXh5vQM86kuFJJUw6gfM8uc6S6VTRtitrAHAUdtaVISB9llEmqpgZMelcXQ317H2Ul/
	ZVn6/+Jqbz7gcgSNRr4nEMRA==
X-Received: by 2002:ac8:5e4a:0:b0:52f:ade5:cf07 with SMTP id
 d75a77b69052e-5310d026154mr60992771cf.34.1789417294469; Mon, 14 Sep 2026
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911073758.2714564-1-xiaolinkui@126.com> <CAAVpQUAUAgAVutpQgMu4LjG1KOpm9Du0Kw1kbp2vHtHqQ5USZw@mail.gmail.com>
 <CANn89iJTMxWERqz1tdxuQ2jW6Rr7xN_ceh_yejtrBTPwN_YEeg@mail.gmail.com>
In-Reply-To: <CANn89iJTMxWERqz1tdxuQ2jW6Rr7xN_ceh_yejtrBTPwN_YEeg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 13:21:22 -0700
X-Gm-Features: AcwNN1VHGOuXR92ZZx6YdPTmJhhi5lWBngDT8spr92jnLRYRfzCHvAqmKTmPEXE
Message-ID: <CANn89iJfphTDBFKdNkgmBHDybc8wV2EGSJoiHvzR0ht4V2bMAA@mail.gmail.com>
Subject: Re: [PATCH] ipv4: fib: annotate data-race around nh->nh_saddr
To: Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>
Cc: Linkui Xiao <xiaolinkui@126.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:57=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 14, 2026 at 12:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > On Fri, Sep 11, 2026 at 12:38=E2=80=AFAM Linkui Xiao <xiaolinkui@126.co=
m> wrote:
> > >
> > > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> > >
> > > fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> > > source address with no lock held, while fib_info_update_nhc_saddr()
> > > stores a new value from another CPU as soon as the preferred source
> > > address of the egress device changes.
> > >
> > > Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_g=
enid
> > > and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE=
()
> > > in fib_result_prefsrc() after syzbot reported
> > >
> > >         BUG: KCSAN: data-race in fib_select_path / fib_select_path
> > >
> > > but it only covered that reader. fib_select_multipath(), reached from
> > > fib_select_path(), is a second lockless reader of nh->nh_saddr and wa=
s
> > > left bare.
> >
> > 32607a332cfe added the reader after 195374d89368.
> >
>
> Indeed, please put in V2:
>
> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches
> source address")

Adding Willem

It seems that this code also lacks a check against genid?

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 50e96f86ca59ab164f764f5d2185d158c14a4a6a..5a8bbcb65daaada1c3ae96339ca=
bc2e801653dac
100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2185,6 +2185,7 @@ void fib_select_multipath(struct fib_result
*res, int hash,
        bool use_neigh;
        int score =3D -1;
        __be32 saddr;
+       int genid;

        if (unlikely(res->fi->nh)) {
                nexthop_path_fib_result(res, hash);
@@ -2193,6 +2194,7 @@ void fib_select_multipath(struct fib_result
*res, int hash,

        use_neigh =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
        saddr =3D fl4 ? fl4->saddr : 0;
+       genid =3D saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;

        change_nexthops(fi) {
                int nh_upper_bound, nh_score =3D 0;
@@ -2205,7 +2207,9 @@ void fib_select_multipath(struct fib_result
*res, int hash,
                    (use_neigh && !fib_good_nh(nexthop_nh)))
                        continue;

-               if (saddr && nexthop_nh->nh_saddr =3D=3D saddr)
+               if (saddr &&
+                   READ_ONCE(nexthop_nh->nh_saddr_genid) =3D=3D genid &&
+                   READ_ONCE(nexthop_nh->nh_saddr) =3D=3D saddr)
                        nh_score +=3D 2;
                if (hash <=3D nh_upper_bound)
                        nh_score++;
