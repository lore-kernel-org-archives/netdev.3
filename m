Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBE3D16EF
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670230; cv=pass; b=nMyGdup0odfXu5rvwQbBnhT9QXnxPuMTuMV1C9lE2q7G0Axm4sB/M57MvVAud1n+c43PMnV4oEsjJfMp3IVZarkC9nrIGThEhWUmoqlezMpbHse2d11gqkNuQdWZnK3VoSE3yOy4UUEeCRaJOPFd9PV0JodI376p0TzLfYg1QaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670230; c=relaxed/simple;
	bh=zpzK84aFNeYs5n6doOsmwCBihzFY3RH8DIcd51thSy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJiuZJaeKlrRSw0wX++GketK+px+jDAbEbuvmcTxcgxF/wYpK9FgpeQmkOHrqmX9eMwJR6v9ABnoVhGSXykyAWrPM6VodbP5UIP9MZtzaOh42XKXH187txnvHtAxjVCTgdhFmXAOHS/FT+fz2wUfOXukL8YZCI8mZVc+DfpnA8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndUEugMf; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndUEugMf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-395cf2535acso1232884a91.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789670228; cv=none;
        d=google.com; s=arc-20260327;
        b=aQa5RBXNoL+rdGBrt+lfIqgmDqOowioe59x0LQG5K9heZa76kHt78rBgMYip46VOXK
         pgY8nmoomXU9DaDxsS0NlKPP41ZX2IR6mWzygDnLcBA663tnxKswoIsVelXU2FqjJK7q
         h34+epItmKXE8E2bkMJc4u1iVR8CXMuR7i2kknb4DylnMHxcE+u1bzIEl026IXwBMa60
         TxpjzeCpF3S448R+g6Rku092AVxbP/16IYfLciHjKXF4UeADBjOEJagTWJlgm/rqXspa
         mZbV6fvq7S2Rc/Sm8fpxqSq+/ur8dQQ8d94BVXMPA4ToxOVelr7QloBk70fS3x2TgtNd
         vOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFwu5zj73SZE/R7e6e6kQGnVHSqzBlTAzyAG8pC35YQ=;
        fh=u7ydDxTnASgfVMB/TXIcJBgKa4ZrLzUcV/n6OPoS7VA=;
        b=XMDQyjGt5tt3vvtbXZfUfujsATpqZbrx3incSsAj64XpMOQopaxNOKcsULQVAF5ZBo
         gwnG0PxpAOQSmbJLL3nOmobETLfTGxMqcEyNMQsX1/GL1xWg/6bxFzN6WNbozpGqrTXR
         O0wqkqwivdlPokCtFbK6VZ2Uz4LYNNrye5U6yPoJnBVLehB5UzNHewFWeg7cJmhBrn8+
         2LmlvgrdcuWd0bZqHIqt1RMuEfK7/sc2wBWkdFsuArDe8AypDem7aFErMPwkSv3RbFbR
         Mgk/B1wdvnSJPG6Ojs4T+Wx42lsAiSbfgnLASh9nVtZAiS494czAiD8nCx4Yxk1Ij8NV
         vG9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789670228; x=1790275028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pFwu5zj73SZE/R7e6e6kQGnVHSqzBlTAzyAG8pC35YQ=;
        b=ndUEugMf11XRPSw3IsAv37qwkDToX0U6W93wEhf3J/KNi07k74C6OL01QacZR4FIZL
         VMFHwc0Rrg6gQ3sHX82p8rzAKRzK145JUkDwzEmvq0Jv76UCO/+iW7Cj2ELLtD0+7zCO
         1Ld7MjmHxdZKg5qGF8YesqDZpMe/NwvGle9HkdZnGitqNZ6zgYULKDwb3fo5OK2+NiOl
         DZHVaGekBpDnqUn6jqwj7EemKVLoBYD4R3Tkv8m0u4OJuGZgYPLNn00Vr6xqMchzC8AJ
         9SRMXiiK305IAFZxx2/Lkh3+8HBovXcJdR3zmWn+F2UHN8wn3E91oo9yQIzItB15DlWo
         O0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789670228; x=1790275028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFwu5zj73SZE/R7e6e6kQGnVHSqzBlTAzyAG8pC35YQ=;
        b=w/BLuuUUErZiQCi4quiqN17xX459gShkNuQTd1p/yqH+XB17BoCa+jF0JTfdONUMod
         DPVRhxyVp75FPc2MXijuzABdNdBg53qTzrTSPcMdc+v/9F1cu7N53JR553/irjKw7GWD
         IFzyefqvhmpR2x09P9JwURMwxD50PWywsVKih+FLHJ4+BnSQylcUau2f2nrU7u7ziGka
         leQZ8heyN20drRKd5No1xHVSYaafm6fcOo1tYZNJcf2+GrwyiD/0sDSnISSkc3gTA3iq
         1sW0TUYd+wk6bVM79Ym2qZeNAQMAEFSxC/tzDVfb4RtV4Waxu97f3xyEsEugCeYLRg+b
         SMCg==
X-Forwarded-Encrypted: i=1; AKwUvBy2Ayi8kSYgAhAXZUp8H1wOVKUdz85mFALLpzXSQfd6sLSdokBiVwgzs1/lP/FB18NIGo/RBG8=@vger.kernel.org
X-Gm-Message-State: AFuF++knEhXFJs723NiX3F2WXc1Ia0oMuSYHF3i1Yufeo8OJHyyByVjG
	WeA+uj7OGXfkRt6lcwa06G3LNYB9zkkNPY2Ouy8GyKo+/Jg65xL26R2Xr1qjbXBF6TrROk5d3Ik
	BhiQqKiU+PJijEAyTAL2Bd+DDDYMtAyAmXUX3IvIg
X-Gm-Gg: AYBFou2DZIQZI0UB5I2U3XvlQt9WCu6Z5IDMPWHfllpxqhPd+5mbSJ/VCNG/QiOpBim
	gBc329r/qREW0xFjwBnFWoIckODmPVpmbhhIzvpCu5pVJU0KW4LjYkvj1el1y57eNKTyslmXgZC
	Fg1znHT9yez1W/4ocRbRJPv102dgB5jPSO6fXxkCgQ1TJIRWaCHC6DY8FzZb7jV6J0Sst/z9GLJ
	wMIbK4ya2o93dtY6AmHuJF+59hpozgdp+WDwvkdvp/4LwH3ywMcd7GXwQKJ7LmryfDUJRUUIsju
	BopYCKjLa5bzxZ0pQj0zp56qJIx2vRIARTTM520UvcYV6u0tzA8SkN6uDQQrkVRsHCD9ax2czJN
	Zd6PBgtr4dp3tSQfOeDpq3l0DtyJq32u1c0oP3QrpAIaESa4pbrM986ONtpvRTM/qGbira7MXwv
	JTdqBgDHxVnxuMOaTKbDj/hZHc
X-Received: by 2002:a17:90b:58c4:b0:39d:e445:1d44 with SMTP id
 98e67ed59e1d1-39e361afbe1mr6629588a91.31.1789670227753; Thu, 17 Sep 2026
 11:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904033543.2635540-1-kuniyu@google.com> <20260904033543.2635540-2-kuniyu@google.com>
 <DLHLRA8GVI5B.2Q1IRQG5BVJNZ@gmail.com>
In-Reply-To: <DLHLRA8GVI5B.2Q1IRQG5BVJNZ@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 17 Sep 2026 11:36:55 -0700
X-Gm-Features: AcwNN1VVZlLFG46zE3ERwl3nksSuaKTMwQsJ2_k67BiDzS2J13utUcvuPKmPgeQ
Message-ID: <CAAVpQUALY3GdKsUkmGQJf0CYL-gA4ka4uZr-bv7MeuMdn8HS=g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] tcp: Do not allow buggy transitions
 between ehash and lhash2.
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	Michal Luczaj <mhal@rbox.co>, Hyunwoo Kim <imv4bel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 5:49=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> On Thu Sep 3, 2026 at 11:35 PM EDT, Kuniyuki Iwashima wrote:
> > The following state transitions have long been a playground for
> > syzbot, and recently AI joined in, reporting a lot more bugs.
> >
> >   * listen() + shutdown() + connect()
> >   * connect() + connect(AF_UNSPEC) + listen()
>
> Hi there. Thanks for closing these. I'm wondering if connect() ->
> listen() via timewait is intentionally left open?

Ah, good catch.  I missed inet_twsk_hashdance_schedule()
unhashes wihtout calling inet_unhash().

I'll post this.

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c

index d4c781a0667f..5772a64fcdbe 100644

--- a/net/ipv4/inet_timewait_sock.c

+++ b/net/ipv4/inet_timewait_sock.c

@@ -110,6 +110,8 @@ void inet_twsk_hashdance_schedule(struct
inet_timewait_sock *tw,

  spinlock_t *lock =3D inet_ehash_lockp(hashinfo, sk->sk_hash);

  struct inet_bind_hashbucket *bhead, *bhead2;



+ inet_csk(sk)->unhashed_state =3D sk->sk_state;

+

  /* Put TW into bind hash. Original socket stays there too.

  * Note, that any socket with inet->num !=3D 0 MUST be bound in

  * binding cache, even if it is closed.


Thanks !
