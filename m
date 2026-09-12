Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6675194C96
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173170; cv=pass; b=R3LznNeQSeXjXEzH5FTNkSNXAq2sq40V0aLPNGySKzJqj467z7PNCGUKwQMp7CAV6SGbcbqicPrY9QUelglWMLsYO+vaioMs7ygkor2DoGMLpVQ0p0UtdjuJDSRJbcJtXIxTLhcNzK6R1EVU4GjxbyzeG9dIchxJ5ZzDTr2B5VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173170; c=relaxed/simple;
	bh=6CTfjGu/co8oDmaSdIORMY3ubKy3EuhhE0g/TKzNfhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyPDc1mTQp3lcsNEAupiTKVJ7l5aaQNDRvbD2bVyE4i+/Cw4DVahF8mQQSGAxUDK7GWeMnrLLshwzdbCHqJlu0oGL3dbOyDItUBTzPiH9yeWf6eFTLibLbUxuqUXdqI+VjB2eZSpkaQb25oCgFQPym9zb+9g7Yd6jafByaPwcBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxbQj8c9; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxbQj8c9"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc149372c14so1138074a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789173168; cv=none;
        d=google.com; s=arc-20260327;
        b=pkFp3kHYmt31HPrYraBGVN//Wk1/wcE1IHMTMny1WtTIVpFJ8aI034knLvj9z+sHKx
         PVKrarRhQSItmVhDSK8gxXh3RwarxmiSWIF/y5I8DQRSxQbALusoNXZcYDRAVkSqdqDB
         9E5iRjpXv/djHuKgzV2LLYVwSPBBgQjBVj49wy72lnujCnyROnAFepso8+89bOXxfhoc
         +rQA62PwWUOBoi9dIwVzosjG15AUiktjhCx5sbduymFHQqb654TsEP+F+55FjBwBB2OO
         aFNEhhp0iouee+c0+RgoNkZDuaGCr/OdHoEh0KkSEW0ipc4UD5o3W08g/ABb3MCyN4Mq
         pLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bAel0FIyGFKttyX3y+YTIp3f+S3gTxoqwsSHkZvfRIs=;
        fh=RdCSh3OL8axTQnfHextzo0hYqalk+jpSZ4AbjXWHlcg=;
        b=ibBEesDe2BVdG8AFtu8D67wOSQeWy3yj44MSp7IC0o5oIE3OKdenUdzFa7BGCcSDfr
         QLAW6CaJbv/UHkFJJ9mznUHrDvcM6Cm2HL7QmQ6owEN591Fl2MrDYRdo8ecGRq4Q2aR4
         vx000PSG9Wx/ahMKyAnvcfLJd9bka16cImmzclyw+moOrZWjyJ3Ar+TmSRVoVw80tA/j
         xO5raotAyb4JJCDKuJbnxYuNWt7oWdUpl0i/KHkpc1rJLwwUbIiHfpJcuoGW0j5KmD8e
         MWRYoEmAN+LF3tRAmLxRdgmcdMNcuTxr4+OshsEzvSiK7cS6vtXNf26NTySaUI8TdXMP
         S/gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789173168; x=1789777968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bAel0FIyGFKttyX3y+YTIp3f+S3gTxoqwsSHkZvfRIs=;
        b=RxbQj8c98a/rrBf6GJ1AntmNT3QwjDJUO42P4RVoxbHeLDxbQLob/7SLg6u6jGxhlJ
         R4vHwIPX34U546WXbexwMG/oSDoVskmQNj+TF+USw8JixMJTmOgiuQ1Lhalc52VnI4I8
         ds+9TJ04fQ+Nz/HyBmrc8v+/BMjfU0MPRVN7Qh6wQptfEnaKzo7F+v2gYlNeLIvdpyNk
         spxbJfcZL1i/C9/K6lWelyHqHejMX+GJrYMquqbqIHNYY9BjiIM/HcHdJKbDndKa/nTp
         alYDq/3sWKOqQGOrrqYKaVqWpB8rdwLz/lZLsSLaWEK0UuDox9K+N90d3qSBz1QuJMZC
         wONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789173168; x=1789777968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAel0FIyGFKttyX3y+YTIp3f+S3gTxoqwsSHkZvfRIs=;
        b=lLJ0DvbDs59bNIUUQtVhlwFKt/kHxACL52KJMor1TXQwgy+CxVkVF+q8TpiZ7AEjBG
         cFBbcIKPTTPa25zC7kNb2u/IfLEcxSb0nEMzeXPQor4YlIjECITAclFK0ab1EixyQvbq
         xLEp/mM0u9WkEzbna9y+FaidzrbkDH6ixKFyQu/QY4QuaJxyJRW8/0PMESy9ccsJTZBD
         gcYnFcW+CG8YPBAvovZjEOgyGDW5gjRoF71FBCkBG4qgqsFZ1zZDwHXB9b9hNO5ZxbYp
         3gnOBHoy6xi3fTeq8NRnLbZCxUCI4WDUX5fhf74ceK7uBYOownfjYjOySQfhoo0adSE/
         z1JA==
X-Forwarded-Encrypted: i=1; AKwUvBxdXHWbSGCfKQzJlf5TRL/uIuXZfRRej0vm2w4iwuEns7xwKhWDagD1gmnStmSxQA5qtPfSpZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ5Q0pcBWeutvaGe9O4gY4H8L0URC3RPle9QZeO0RskWyOcgQi
	kh3z7VInKRDFqATj7T0uY8DJu69/WP+6Vso5sddGUNrvWGVXN56fBGxXnUMttZ2wnHgjblaRVkV
	2RuymSXYOeK7xxTqQytmRKRrg6guzSgKVTb+Ap06B
X-Gm-Gg: AYBFou3P9DeLZvnDKZmAfmAhj2uuPj/ozev0lSrFa7zFKW30fO+qtNrS156ZIdnunN3
	XgKe5yIyJ2zOLj/7TgOacKYY+WV6bULBTHdithiE0epm9rPvLGZRDiMtQ6vpSw94lfzx/Hh/JOY
	DwPccys4jH2tC/32cEfkJtU+Uljx0MW/wZ9UWueUa2K6AqCkCoPlla2Jsf1otPE2dJuD4s971y6
	bLPURLrR1sUNT4XRq1JHt/i5l1m/Dr12baX8EQR05ithpiXq6R07EPGnhLJ2oq09yVjYlaTrSVd
	l6x32Bt7p9gNpH183cskFnMA11q8FfFrIzqVCmlyMFe4CsCUzVgjS8KWywmg1S9n3fYtozdEEn1
	BGRGB3Ver40xLP2y815QYWG4+f+uR2E67opbM8MFIL4PxryVL0R4OIoyl1Av7LDdyOu4=
X-Received: by 2002:a17:90b:1d0c:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39d9c35972cmr11489309a91.24.1789173167436; Fri, 11 Sep 2026
 17:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909233143.2401847-1-kuniyu@google.com> <20260911173056.44ec06e0@kernel.org>
In-Reply-To: <20260911173056.44ec06e0@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 11 Sep 2026 17:32:35 -0700
X-Gm-Features: AcwNN1WlOL0gah2S6mLiI-AWiJyIAdfeFdCOLsxFOggru1bOz0RWk8Pf3x5BJ1Q
Message-ID: <CAAVpQUDMevd+_TgLMwCz3sG-ztEaLkB34tTCs7kNPPe5sh-gHQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/4] neighbour: Small fixes for RTM_{GET,SET}NEIGHTBL.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  9 Sep 2026 23:31:22 +0000 Kuniyuki Iwashima wrote:
> > While working on the follow-up suggested here,
> >
> >   https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
>
> Conflict resolution with net-next:
>
> diff --cc net/core/neighbour.c
> index 27602bcbeb69,7448320f7ad5..000000000000
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@@ -2659,9 -2620,15 +2669,12 @@@ static int neightbl_dump_info(struct sk
>                                        NLM_F_MULTI) < 0)
>                         break;
>
> -               nidx =3D 0;
> -               p =3D list_next_entry(&tbl->parms, list);
> -               list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
> +               default_skip =3D 1;
> +
> +               list_for_each_entry_rcu(p, &tbl->parms_list, list) {
>  -                      if (!net_eq(neigh_parms_net(p), net))
>  -                              continue;
>  -
> +                       if (!p->dev || p->dev =3D=3D blackhole_netdev)
> +                               continue;
> +
>                         if (nidx < neigh_skip)
>                                 goto next;
>
> ?

Looks good, thank you !
