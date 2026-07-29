Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627847DFBB
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336219; cv=pass; b=eE2Ys44h7eseTP7kQjx9yESSOHZmrcwJEHJ3e8ZtdsidLWLgFBNK43xyS+ouImjF/vdUD1vnjsOL/vCzoF4ZTS6zD+BG5phNChGnsJo9q1jF6D0jKSVHf3m/yiOr8oT257pCmEG1bu+YtEsTEDJm1DLUgNr1kQN02DeuecZnWbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336219; c=relaxed/simple;
	bh=bO30GBdigpLpXr8G01gVY3c3cMypTioYacQIgy7BQwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2f0eVJ6BYWcg8Hs36pZ8cySdDioZ3jMfyV6cWfvu9rSH6gR96Y3ewhfErWv1HzZmyIEBY7RUjWPowCjSivU6SMvnIAHKLqtmW3EEfP+rRUV0OKPqA2jotSFcqg0Sj3OVqbChYRCyRwgg05MJ5DiydBM0n25Y0MRY3u2huO54h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd+nxQIM; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd+nxQIM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485b358552so1190460b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785336217; cv=none;
        d=google.com; s=arc-20260327;
        b=jXz120pB+tC0CyBZDTRATKY+qd+6oKAxURvAytysuVLSSQ+eDd42Dm3e+BE0pgrZxu
         3oNDK/GDdeXN631eZHkndiMWsOt5piTBkvMyLeY//9LFSdWJ6UPFcdzbkFjbeGWhgD9V
         TezEKvpmHBfyawouIhPMRiSiJZu87mv9R7QpGKh2h4t9giDjroiwcYleP5AXcOAI+k29
         5B4lxGbLH7jajChl0dasmCQMIlu1g/8R3vpNX0n8XhguBY0ioxcCKbgYtIl9Z3deY80X
         UC94lGUTOxYtgxy3iC2cCH6ImoGFq5dzyU18AOc8hwLBcUQLMEHDtolDVtnJVpZ5y4QK
         EhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWVLK5NfeZSfuYOjxWPGReqguFO0C9gVVig1mZn9FwQ=;
        fh=vGtn6xsSEVAR06kBOlUMJLEO2evHUKIaH9Te+M4elBY=;
        b=Qz8R8LeNgveqL15EkrbJGhVmb/niSlEHzRVCiJvM+y7dUSckCWcnQqpfjRMeLsntb7
         zM6dpg2pALgGDDeHkgXsvYiTOOFfxCEknVtydlxNAH22T5cIC6AHSPUCdjQuqukI9w6v
         NTFLybs2TbbYzw7nirpRB3B8fT+Doru7KRxpVH6/gw8UcLu/UkYm26/KD/u0M8G1MpHl
         Eu3ikk2/QF2gAkt30CFV8rLcvYFLUxOH3bs4uqQ3ccSb7R7SpVoj4uBV2CvUhBhDCEVb
         4tpMAtpI3Y/N8uyCtpKxTRXwVLpxCkn2VrsUJ0Bd6oaQ1W5Xhf4/M0mGNu3h2uwWKkow
         BRFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785336217; x=1785941017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SWVLK5NfeZSfuYOjxWPGReqguFO0C9gVVig1mZn9FwQ=;
        b=Fd+nxQIMcfaNLq2rpnnBLp+39h4colGbDZd3IFfNiCshwi+RIAJdXfiLvwL6loK7RM
         98Oha7t8j7cD+Dl7LeQdiQGZ4kxxOp6qSDI4MmdAR8+XT/mBrN3e10edvi/wOBFyhE1c
         dusuE0V48tnTfwOvlHNhHpuTLc3FU7OIJ+9265GJETQoPeigQwQqvvrXn+p7jnvbqZhZ
         Rj0AqfTPkSX72NxdebG2eDg2SxH1IIjZci254xm38+zjhYsZI79nLOI1HHXuHEHFs/PS
         oBG/LJxlS/A1F3bNG8mnZn1fqMePx3jkUE4C+ZrpvNMT/T99FvT0YzNMy1SLiybOhL8D
         ZtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336217; x=1785941017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWVLK5NfeZSfuYOjxWPGReqguFO0C9gVVig1mZn9FwQ=;
        b=AdDbQIyhxvP8yN9fddyDT3nkToHTYIpMD8NDE/ZLQhT8MFi/LGEavs2FLv+gnh0KE8
         fbKDBt7k9ChaHEDWA7obANcgedo8HzTtnPjjc5hSV3nCpWh4YkFB3C/mMWGMYfLm7Lqx
         a5ASvoe9Fj0zvcLEkDHaiBkWfD0vLPG6QZcpUdchtMIMvwif5nouBJuvvsGSWag299vp
         ySzSvVicSZZ/a7gM9lK6NFg+z73a+2U62rsJXLxnogIZ23tI0edhhcHGq/xYCUBubSDH
         qAAMsDOZsSiIPIXRvntZ5xRr63fpCUPflfwKR+7CIgRNl2KQyAQZDnDI1Dcqayqwjist
         D8JA==
X-Forwarded-Encrypted: i=1; AHgh+Romyc6lYt7O387eORlQnRnYOFzMPxFBmmzl1tPkPWmNFkkQaRMwla6bb594Z8NB4cqx/srppKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKKg0FijRmbovlkXAA2rrvA7MrfdQBG0u0efAmbKoeVvAhD6C
	g/9hcp4w2SsKuyZgo/EEnheG+zkbvLzaETgArYr/gi/uKCyaj07lGagrEu0N459WV7OwY+nN54v
	PPQZW6Jcqfsmk2WgAD45yxNKr0wtMGz0=
X-Gm-Gg: AR+sD13T6oU2H41lCYLUCepaNNQXx4fyyRoGF1VKAvY26rfKy1tDGOgnyvIF9AlDAAo
	9KgCCOB/UOgXGAWWzo/NCHjanQvKrMn+e58GilPGPuE5db5sKV3jvydyXorjo9pGX9hfql8z4X1
	NFCEp6urHa0Vtkvin1eTkHO/b/vrk9Lv1uN6GdUu9+Noa08suKIXLInQF9q7jkp7gcLWBGah8BR
	dYbDYv9XJh2YirKCrANkMZEL0nprETN+FOTMx1lNz/PCYJ4CPQjJHqFLB6z/30RrTgDipsUvW0r
	eIXZs5wR/uf9fu6cK6y6uydKoZFxZkqLYGafedCCRs3v2E8kV1U6LdzXokmWV8OuJKrH9/IPWG9
	mMGFlFXzGsupSrV5Wkt7KSwZv2QzcPbFbm1Qs7njRXUw=
X-Received: by 2002:a05:6a00:bd09:b0:847:8ccc:d7c6 with SMTP id
 d2e1a72fcca58-84e931844b0mr7932333b3a.31.1785336217592; Wed, 29 Jul 2026
 07:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_cb8Q=9nv5Z5eR3cf=NLb=5=wSg_HKHrtCtPU_bAN=qvg@mail.gmail.com>
 <20260723061107.384106-1-l1138897701@163.com> <20260728182359.3cd3acf6@kernel.org>
In-Reply-To: <20260728182359.3cd3acf6@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 10:43:26 -0400
X-Gm-Features: AUfX_myvjigZq3pCCyct8kGwuVqsXaVLLMpSYVzV2Vvf-myxU1YKYy0bIhWF4kQ
Message-ID: <CADvbK_cAR8qZwA1pAN1Kov+v-Whg_P19VK-Fzpztxc5fiwA+Pg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] sctp: auth: discard auth_chunk when skb_clone fails
To: Jakub Kicinski <kuba@kernel.org>
Cc: luoqing <l1138897701@163.com>, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 23 Jul 2026 14:11:07 +0800 luoqing wrote:
> > From: Qing Luo <luoqing@kylinos.cn>
> >
> > When processing AUTH + COOKIE-ECHO packets, if skb_clone() fails
> > due to memory pressure, chunk->auth_chunk is NULL. The original
> > code still sets chunk->auth =3D 1 and continues, leaving the
> > COOKIE-ECHO to be processed without a valid auth_chunk for
> > deferred verification.
> >
> > Discard the AUTH chunk early via pdiscard when skb_clone() fails,
> > so that the receive loop can continue processing remaining chunks
> > in the inqueue instead of stalling the entire packet.
>
> Hi Xin Long, should we apply this or it's no longer worth it after
> 8e04823c120b ?
>
Apply it to net-next.git.

Acked-by: Xin Long <lucien.xin@gmail.com>

So sending patches with wrong in-reply-to doesn't require repost?

Thanks.
> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 62d3cc155809..a5f2835dbe0f 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -999,6 +999,10 @@ static void sctp_assoc_bh_rcv(struct work_struct *=
work)
> >                       if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO) {
> >                               chunk->auth_chunk =3D skb_clone(chunk->sk=
b,
> >                                                             GFP_ATOMIC)=
;
> > +                             if (!chunk->auth_chunk) {
> > +                                     chunk->pdiscard =3D 1;
> > +                                     continue;
> > +                             }
> >                               chunk->auth =3D 1;
> >                               continue;
> >                       }
> > diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
> > index dfb1719275db..a15b599b20b7 100644
> > --- a/net/sctp/endpointola.c
> > +++ b/net/sctp/endpointola.c
> > @@ -368,6 +368,10 @@ static void sctp_endpoint_bh_rcv(struct work_struc=
t *work)
> >                       if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO) {
> >                               chunk->auth_chunk =3D skb_clone(chunk->sk=
b,
> >                                                               GFP_ATOMI=
C);
> > +                             if (!chunk->auth_chunk) {
> > +                                     chunk->pdiscard =3D 1;
> > +                                     continue;
> > +                             }
> >                               chunk->auth =3D 1;
> >                               continue;
> >                       }
>
