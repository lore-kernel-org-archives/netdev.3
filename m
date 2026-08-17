Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3A3D667D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976435; cv=pass; b=IyL6rNUPA/ZxtWLzkIgKW4ph3btDEOvffWxrgG1B0ZPlDOsIPiJf9W7nz5gC9fLxZs1l+NayaCSqyYniaIOzeCVm0/D0o/Q+YioDoDqlOLM87MAuxu8+K/X/7V4rhGm6yG2TJy04qo0Bj64BTa2TORNgv8Ox08lGF3unqSsZkDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976435; c=relaxed/simple;
	bh=h8GKJLoVE5vGOSImCg9pe0Cbu4mhw3DToAOh9rgiNRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5GxHPJuFBJLrHKpVBjsi6owgDQ/QpzR0keAOKIOwhrRGyWeITGKmHuXxmtQt8NzvOoJhCbpHc5CeotP5GX++Dn9JsJmE3BuGKP2/y4AU5RuJxw2QkpgTzx+Zt/c0rIWtIQDkMyfDshkrXFn6NI4lGxNJG5x65HXD5xZYppRFwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrlxwvmS; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrlxwvmS"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d58d7aad6so16653301cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976433; cv=none;
        d=google.com; s=arc-20260327;
        b=WSxJXFo9scQSNA02s6Y6vLgy/6Csyd4D5zyfhU2y6uVNiwBRWenDKwmyQPxnEitLUu
         JeqEVIajkmm+oVsjl4U/ioPA1fh7yJrNzWjPYMbbKicTRYOAVY30DEWz0YiYc/xFodL1
         2wgXSw9Zk5ROLDn3BKjS+RVPzgW2LimjlXzu0Q1vwb7zag7XAe/u1euAM49wxG/8rG9X
         vxhXhOHUrGoLxE5u64moOOAx/6q9ztoKmq1MZCk2LyYxXD+h7P/t+TnVRPaDM+/8Pxs+
         PjkaShYr/Ti/nbndojXCT00WC9hUHO5dYkYb3+Z5Ah7+8rYYBTY0CmqgW7tbcMFUMgqI
         udOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8GKJLoVE5vGOSImCg9pe0Cbu4mhw3DToAOh9rgiNRM=;
        fh=2TEsigOYn8ikEX/Kc2YXx4btVIOwUIquIwU4mPNNMNM=;
        b=GydWfCnf/gl5NK30p6EvWl1wybFDyvYtPEdjCaSJ0aICxlpiG2HkyX2tnbSi3WkFmr
         lX9d12Xydsg3AtjGqaM3bsQ+LTT/m+JJ3/qefDGPL4CDrGxdU7elbKpbl63/R+2mxP9y
         HXQqCUeL+Cd5+ciZO1ohqK/qhncMpj6ef+yjkQ9bWYebdhECVTgVkUOpc3Gq7IsoYujA
         GOk082BtRt12tM61VszQFMIwWFdB+AR5tXXdtWYXb8odqEcUPUHLbAIbKOhDdv/KzL3c
         IrFimnFRZoj8fho7dokwrO3LAnSuESwtuGOmxgeUg/6hMS+vF6I8G0+0A16bjvHn1rpw
         Ym+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786976433; x=1787581233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8GKJLoVE5vGOSImCg9pe0Cbu4mhw3DToAOh9rgiNRM=;
        b=NrlxwvmSY0dxudYRdXEHq2l8ukg9tN31PGiHmA7mmNlvxUcpgPQk1E2s7yXOe0bOGC
         sdzlhHTglN//lAC4p8IKnYG0ppWMZup6jVmviqpxFkYh6MuRuKhU+tcYGg7FvLNJjn+5
         ekePFpi8xeVnjQq8296pV6GCJIbi0QWdDoEQw0j4zztDqOw8JQNyUf2qUaGe+7oYBTJY
         sHXkFQdzS7R/nxMKtSVJxI5ewzbH7IdU6JeiSka7Hnw8NKW7f0fxjJpJ5JJ7VAAlBrgF
         fUiaT9aGoQByXOAJfFBdH2xGq3xtZ+/Tyaam/M6LFo+hlZXf5OKO5UrgycgZ+d1sfcYZ
         +g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976433; x=1787581233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8GKJLoVE5vGOSImCg9pe0Cbu4mhw3DToAOh9rgiNRM=;
        b=NiqhbEiV1EKFTsOx1TmW23aNpmWIt09zZXttT/iouXJxi2SSWeYyGsH2+ar3VvdMPY
         EZscOC5EV/kFBo1zQ9imn/kocdMvfJMoIxlck8h4xPF24eNk+w+DeO9//JI1Y1wO4q8k
         UMZNONeEolZX084f0pXJPaxeVVhOadb/FmVutsoQHc1YvZNcS4wZBsu9xNh13jwwW3Od
         XHjJuwhbMycWInwArCtdnMerLm+gM9n6Wk/rOOqYAMQzgC0oDtDEhT2rqUkmGtsxyzZV
         QOM7hqvrZauoGg4hCGGkr5jlxvSVPRVAi7s77wF3RHsUGqpSpRvnESfaVcW3HphXCpsX
         gSUg==
X-Forwarded-Encrypted: i=1; AHgh+RqL3sfL2P151oLGInpTT6zGh3hjMB98GzAm17gJQJnEJ44kjwu0o/+KllzC2nX0dOWVuNva/gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqcpmzc0In8ej5Ar3wjUxMZ1P4YolnB8QSvgxq+NzE415znpED
	7H2aSAKctc+UTfmC8QslQSNI8rLq0ZLfRNG38r2vV+vIJHtul5m19sonfbF8QMZbqJqMcB+lrgJ
	sYWexPRa4BHN0YSPxTVovp2pdEdcIhU+IBpMm2WyzQshzu2FVMHger9sZ
X-Gm-Gg: AR+sD109UmXHh/nNaWCoGVXnTxWk/EL6uVoCvwVDlhUccn1O+7v8x3WTXuMnAKhWDIQ
	chFP4Cf87KnsxQahpK8LRZGkb9deFD4KYQ890Yv64Qys/j+KAnYgl168OwWK/5Xkm1RGiOWhayv
	hgHO42tBlFDiOMy1xmNOnkV3dJb/0RDNfALNzvRjWvM2y9cBJ3lgmlx9puDQtcWePzRstEIzg8B
	75Yh4EH6bmGtmDSNU6jha/sEMX2VSOk7i29lQ5D7mjDui8R4nD1ddoO9TP8o0irZm91fDTfZEWB
	7284LRuOWZTHXPBOGAYNkNIGLledenOJDmRSrFSC5C5o+wVy+7JQFbOypD+9O1a7S5v7F6VvO/3
	U/6USUw5ohU/H21PsaUxv/XRHA5jjTcOr2Aozu29JDiwnLBpCjL2DgARHrx98hqOhir4JJb4fSZ
	chdX0pyDCJK+esukeoa3Pkg0txzByr4mF0Hul6oA==
X-Received: by 2002:a05:622a:181d:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52dbd76c23fmr10161891cf.40.1786976431885; Mon, 17 Aug 2026
 07:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786610865.git.edragain@163.com> <2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
 <20260817082803.GA242453@shredder> <CANn89iKamqEOMfNmbF9nLGT=+6rPmj3KexW+spPpp4DzJ7G8TA@mail.gmail.com>
 <20260817101433.GA323029@shredder>
In-Reply-To: <20260817101433.GA323029@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 16:20:19 +0200
X-Gm-Features: AcwNN1Wy4noh7G__OznFTeR4ziYceg4XjaZaZdNuHuAPuZn6FfjajuwbiI9iuIE
Message-ID: <CANn89iKQ7HPkrts=SC_FDtZWVT1nP_tgEkVd+JM=2ws5aYCWRw@mail.gmail.com>
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <weir@nebusec.ai>, ncardwell@google.com, netdev@vger.kernel.org, 
	dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vega@nebusec.ai, edragain@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 12:14=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Mon, Aug 17, 2026 at 10:35:32AM +0200, Eric Dumazet wrote:
> > Sounds good, although we probably need READ_ONCE()/WRITE_ONCE() annotat=
ions.
>
> Thanks for the feedback, Eric.
>
> Is this something you want to post separately from the diff I suggested?
>
> They don't conflict and my diff merely adds a floor to the return value
> of dst_metric_advmss(), which TCP already calls.
>
> If you are OK with posting yours separately, then the author can prepare
> v2 based on the diff I pasted.

Another concern is that MIN_MSS should probably be family dependent.

Oh well.
