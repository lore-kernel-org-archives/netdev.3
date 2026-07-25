Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15B2E5B2D
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965193; cv=none; b=GrOHVPH8YnuCpD5wa2HkW0HInAOxzAWK313K3q1ly+c6Fe8IkzboBk6rfKJmBICBQIwi0TOYBnDrHgRsbj0Q4PLk1IHh7TEKMu8hhwwMyx+5Qm7bV63TI9ofGYvJe/cwjYBjj5y6/FIj8+b06JjVM4aARs+wFmsMXaUhXVdqD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965193; c=relaxed/simple;
	bh=k/KUxMM9Py7HCnvVEMRVoQcgtuSIjjJo87FOXQLaZjk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TQFrBdYJ+Wy5Fa1eIWiGtyaULBdldJazu0zd2WQTN4VKqTrsJ7s82eNrLFVOCnV56tNU2QJDNDRZYOcIlEJjPw/TgrQsgxc5I9SoaqRZM59AlnyAABvH8Bodh95Tv35AkHvEoZWeAoTVNEQJ87nkIjfXB02IcvKOwN0OCPOQTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUKXGokL; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUKXGokL"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66892c81725so1058911d50.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784965191; x=1785569991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k/KUxMM9Py7HCnvVEMRVoQcgtuSIjjJo87FOXQLaZjk=;
        b=rUKXGokLrTNmWa0a04KYKnIokAVenKPIEJXGfNLbbeIj0nmoWtl8OSGPHqlh0+hNWY
         JczXSOLEmUHNP4JA5l/HnpL6hFaTsFxYqlkBLYqJSLrrmdh+pqRHawiuA8yOuJlHdMmi
         FlCBXskcf9wyv8LtKegbl6m8AXRd9FeVEvmyRj8t5gBcqgpq2Or7NGdEf9kGhyJquZqX
         cnGQaTKa7Ub2q4+AsJpY2P25o3JK4DuF3IAgl6Xt/9JBwKzyCmBn7wQYJ5YWBWZrIBFn
         QuNbiiTDo74p7Iz8V+m8+ptRZig7BwK0o8wrWy80veZGPGAd7ANZufW88t/KJEffaodf
         T7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784965191; x=1785569991;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/KUxMM9Py7HCnvVEMRVoQcgtuSIjjJo87FOXQLaZjk=;
        b=UEWIVW+IsAnTmLEpK2UHXMt9YIcUEr0QFDI50FyRLDn5BJ6OqgayjauYH1R5uIWsg6
         A1Gzjf5/XMIwr7pe+sAqMGzAJYQyZDshRmppY2HadwcgRQEnTdqbq5T8JO4NuXpB7ewy
         V4QjpkeyhGA7GzS7QkAs5q7hDj9eIRPrLLNCVqCSkgACGVMberwre0cA/OGbOlrbhgwb
         yDhjPtq0LOyjOncYEeL4HAteDp30Ubd3p84tcy2t7FpjPMsuaR5faHRJJGFfo45b/adx
         Go1zkbroQOJcUTe9OmmBbWqILfVfPSue9XROWP2tktEyCePG2CitDJfw4o9BZZDXUWn1
         u0Ew==
X-Forwarded-Encrypted: i=1; AHgh+RrcdDMhNjo6WirQcofA6iiEEVwGrRHia3x5ySjyjK4Rj5OyHmTjpzIuhJy5ARPzNHZzaMk5h/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwzLMtF9VZJxav3PSnhwQe3jMvLC4mypz22e+m8d5jGfgGiUn
	X+DyzRyeZPQlS4OmXJtpL+WFFYebxtYkTV7TKkt15UMPAKJ7H3bSFo0/rO99mtxR
X-Gm-Gg: AR+sD10GR9a64x26DvMN/s5LWXa7ECuHOaokpvjGZsyTRtqZ0umfvJM7E4TPkSAWG03
	241aP+/p/604D710nHgTudn/pz2Cs0NUxJc//dZK6UY1ZM5G4BvHzojgay0+JaEZ4JicZCkY7s2
	heokT+5Bpu564fz266xHjA4hBNU31PsJVJGlL87H6uqU3b4j4aWUiWx3WlWkhg5+G0VQQ0J0DYM
	7rzqmkug3gD9HXLSPUzsVxudl1OhZ/0QNOl9u9NgBNDlZJBuNgqFSC494dLHlrmW3XwW8qy0qPp
	JV4Mth4TcQri5CBGSXtBHXqcx4nt+74cC2P/aLY83RguRmKznNzAztlvmQup6Y4YCE2Bj4z2D9f
	SpzfFU/xCm/lX8vlFwFeW/BQuf5AGa+i+W3NSZKhyGLrFBY5A/Xcg2pFGmkK1Evi8o/JScZRlnX
	L6IomHDxq//w/sSfYkYw22HwYLvieR+03Zs5M9nLT5CAMqThThZFnv8r8=
X-Received: by 2002:a05:690e:43c5:b0:668:96a9:e57 with SMTP id 956f58d0204a3-668c7afe620mr245052d50.56.1784965191387;
        Sat, 25 Jul 2026 00:39:51 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c7041256sm527879d50.19.2026.07.25.00.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:39:50 -0700 (PDT)
Date: Sat, 25 Jul 2026 03:39:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18684a639029c@gmail.com>
In-Reply-To: <CAH78Gvuoqf89L8dm-FwRBzCGm9LaB7H_vt3MsOY5QPd0o_zhrw@mail.gmail.com>
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
 <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com>
 <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
 <CAH78Gvuoqf89L8dm-FwRBzCGm9LaB7H_vt3MsOY5QPd0o_zhrw@mail.gmail.com>
Subject: Re: [PATCH net] packet: use a consistent hard_header_len in send
 paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qihang wrote:
> Agreed. Caching hard_header_len fixes the RAW paths' inconsistent skb
> arithmetic, but not the SOCK_DGRAM race between headroom allocation and=

> header_ops->create().
> =

> I also missed packet_sendmsg_spkt(), which needs the same RAW-path fix.=

> =

> Would you prefer a v2 covering the three RAW paths, with the DGRAM
> callback headroom issue handled separately, or both issues in one
> series?

Since the DGRAM path is non-trivial, better to fix that in a separate
patch. Can be same series, but no need to delay the RAW patch for
that. Thanks.
 =

> On Wed, Jul 22, 2026 at 10:26=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Daniel Zahka wrote:
> > >
> > >
> > > On 7/21/26 4:49 AM, Qihang wrote:
> > > > packet_snd() and tpacket_snd() read dev->hard_header_len multiple=
 times
> > > > while building an skb. Device reconfiguration can change this val=
ue
> > > > concurrently, for example through bonding device type changes.
> > > >
> > > > For SOCK_RAW, packet_snd() stores the first value in reserve, lat=
er
> > > > allocates headroom using LL_RESERVED_SPACE(dev), and then subtrac=
ts
> > > > reserve from the skb headroom. If hard_header_len decreases betwe=
en the
> > > > reads, the skb can be allocated with less headroom than reserve, =
moving
> > > > skb->data before skb->head. The subsequent skb_copy_datagram_from=
_iter()
> > > > can then attempt an out-of-bounds copy. Hardened usercopy catches=
 this as
> > > > a kernel memory overwrite attempt.
> > > >
> > >
> > > Wouldn't there be a similar issue in the SOCK_DGRAM path with
> > > dev_hard_header() calling skb_push() after packet_alloc_skb()?
> >
> > Good point. this does not use hard_header_len directly, but e.g.,
> > eth_header() assumes ETH_HLEN is available to push.
> >
> > Simply caching hard_header_len won't resolve this. dev->hard_header_l=
en
> > and dev->header_ops (incl .create) are not updated atomically.
> >
> > I missed this earlier, but besides packet_snd and tpacket_snd, the fi=
x
> > is also needed by packet_sendmsg_spkt.
> >


