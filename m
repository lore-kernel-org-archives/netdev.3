Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDB397933
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349467; cv=pass; b=YoIiQrD2t8/gDGzrZsnJSTyy8DWkmXzH42gAYpOj7G7LV0Rdza76lyrONxc1ED50b4oPfYPGj3TcFDzLIumlZWqxX7d5E1+0+XjLxgRDoGhsUzZUuEhTcdES1F/n5lHZJFi4LBxL82GpbE+2WYPJIjTNLOsavYrsn2W4HiM4r4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349467; c=relaxed/simple;
	bh=Ul0/DVXPUY8V3mImYLK8uMDT9XqPjTHYQpkTHb8gJCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPOO2RoAiUnUlOKyKbaMNCd2lHh7PjvVtXUdEZW6HkoB/N+4QTU0LvSncYZNkn9YrMYejs+hVUOPdzzNM5L8oITEE3O+P+ldjC+cCD9Nc0Ms/7BZfHXbSc1xgjrN8ybOcvHjkP6Fkfg3/zZTpUV6nzlB2qrFA6a7RG7SW5AHpp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9sNAsJ6; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9sNAsJ6"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e6391b114so116943785a.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786349465; cv=none;
        d=google.com; s=arc-20260327;
        b=sr2pfW4z54ORBvmMgJK69MYPDEn1JXsYsP7SriMqNGfllnFgmYzhZ82egWAIqzG83L
         cuP8ntVTJTZeRz+kWkDzUuXLmr0nAEFSh84ttEoO1Z+772lJSmlwI6uD/hNCGlCqfs04
         af6HP1Z/xsC+zY1/c/nhaDyW+E3K3QquZE0o3ady7VdfjeK21NWiEtYmRzvWjXxbP8IM
         4KHrS8Pm9ecS4vWm6iiEdr2p641deiCQma82g3xmKyjfPHTT85rNh/gmh8TqE8QGVmKB
         OJ9j6lAv4AQFNTP5+wGAoYBqXjqAT+cBcO2SqMrhmNm7emO92aIRwoSEoh5Z8P8tFjU4
         rJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMNTg7s6iuYq9HTrdlr0s0RVepF8iEFcEW++6XrG3nU=;
        fh=QW1aoQrxZo1vTNrzgXtpqobJ4qpSlmKiIl1DJYz1vY0=;
        b=AuBvjvub84O173G6MdCsNe/aMdF4s9GgvYwih3dZdxlQOzWwO9xlms1do5rUiiU3wY
         gxMpe8m/8KRaLeyMqpQVJ9Hr/JxRmoVDYXbptvz/2meifJifqjEFJ3h0oGcD60uRgInw
         R7zuuEpE4IeHsipG/j4xTOMXYlwxkeQrsAd4TD6tMzG4tcJbYIaDFcb6oHPIzVUv5g+r
         pLiNG8LLR3My3afP968ScnYfOqQcgDmhXsfZxv1eh9TKTLh3yZ65FnfXS0mHVpTSwpbv
         2zTn72gGzzE0Y7HcezWvoKgwJwANOrSb6OaX1DkR8/TqMdrtKhfkmXZoPb0FTg93x6nr
         FxUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786349465; x=1786954265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMNTg7s6iuYq9HTrdlr0s0RVepF8iEFcEW++6XrG3nU=;
        b=q9sNAsJ6Z/MWuZfkpgwKAqgDPoO8x/Li6A2uxkigsLHNJ8RYmHkPY4Q27PEPYRSgSI
         /OXO006Qh+rzOEbqnkawK6VJxAX763BW9kJC8bkkheSnaOa/LobNC2ewNZJ+xTP6Dpjl
         F/yd3DJXafk3F1MASzrw4ZNHMlWsOQunH2+7/0ld7zkYplsXmvyjNOeMmXjYtmTj5t1l
         9tRruICkGLqjLLczUuF19KVoynFfGunI/9amko96INv1gxfNsxdiRmdCSLAt/Nt5AQ2U
         44UOpr96toB+2P1T0yRZqGkliWUMXXIAaxtFdqKtYK6xfqv3/s5+B1dXV9sdAuD8xcBS
         gaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349465; x=1786954265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMNTg7s6iuYq9HTrdlr0s0RVepF8iEFcEW++6XrG3nU=;
        b=bPvyrdWIVkZRt+WPY2dd2QgfDoiHTnWaIXcg2a43VtksMUg9ZVqfxwYBj5/mbe8loy
         za5y8sx2h+UZsp8G1MzU7mVs6QPOxqi/vZ/i2OUKP1IB+F2NZmzrLxDkiXEwlN73tSmB
         f044OVblH6xPy5sWT7rbCmSEzz3b8mndB0iiKED1bVdsk1TKVcOZ5lgau8/PZvI7McTY
         Ijy5uHD9hZHWsTPPDNHuILcIgy04BLNb0BNE9GSKBFjfotvglJlXxfk7+eqN2SHIZ8lk
         kj8Qk6hKUyzHgWxc175r7mmZdx6P5Av/vs9Wg9e7z8go6AehL0PifGE0v0+yLLLzqWlc
         uHng==
X-Forwarded-Encrypted: i=1; AHgh+Rq/7DsTvY2dKfaRtxfGcumusn7NaIHmZPKQZpDFZ0PcnSo4Nf9uRv87cKRYZLsezsidyAJ93TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8HIbpFmHTLI5R0BWwthxVkAY9D+OA6cg5OhKspJQZEnMPpoQ
	33fvOVBd1882fxaywOPjfnRYCEKqAE/48xLwDbKS7kOyPc/5Qd2FBVgBx6j+rAQKh6nx5bzHBme
	vrXGU4lbaQ/GI1eOATp62D1w00E8yNFwWTZKIT8aN
X-Gm-Gg: AR+sD11f0Zm6x0/RktlRlPxL1OnOxK/iDQPWhk6V9k/LBFMSx8uZn9onkioKtW1TGE3
	ZBxq9gqitC5fqI/lbIoIiQuF29Kj3VBa9wyyWAR+QzzjgLXlWTm1XCNYzJwXHCvKlqLjzRPjDdD
	2uqZTHXTG1vCBChCTisqVyg5fOnH8pyOQXW6t1SRYisxSwiA35aX4ggGRNdkz61xz5zEwPtx+oh
	OIJoW349Njcfu+3aP0mdShiBYEF87UCkGmyQjF5VIsXvGYRehoeDj8F+AwRgGuon+FnzaLFs/i1
	BoxROvbt69yWLASDdQlxVY/zGdyGwKd3YdpJv5LjyRVgi4rNbsgz9Iqcjtrrkc8z0SRu/1dQ0ed
	yj1r0L9PnIzN5sv0Lsm0tIlbHX+x/3ZMHuDi8N6nPtohxbG5iTYEuxJQ=
X-Received: by 2002:a05:620a:489c:b0:930:e2ea:2881 with SMTP id
 af79cd13be357-936665d520cmr2844934685a.36.1786349464133; Mon, 10 Aug 2026
 01:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807102802.1696827-1-zhangfeionline@gmail.com>
 <CANn89iKByRiWyVdPCzvb5+0WWrPcaeLSXDqP6GqUHbqRwMF9bA@mail.gmail.com> <20260810075935.2961699-1-zhangfeionline@gmail.com>
In-Reply-To: <20260810075935.2961699-1-zhangfeionline@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Aug 2026 10:10:51 +0200
X-Gm-Features: AUfX_myeVfc4yGRooJPQY1bzyiwcFrBllK68PnQyh7yYUACU0ELbnCQAAX8Quac
Message-ID: <CANn89iKHSfHhrDVVsyFcu+dDwx9GM-Zc0e+p519-ERaRJ9ojdQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: drop skbs with a short linear
 part in eth_type_trans()
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangpengfei16@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 9:59=E2=80=AFAM Pengfei Zhang <zhangfeionline@gmail=
.com> wrote:
>
> On Fri, Aug 7, 2026 at 6:52 PM Eric Dumazet <edumazet@google.com> wrote:
> > This is obviously a wrong patch. Please fix  faulty drivers instead of
> > adding more code in our fast path.
> >
> > If you use header split, you are supposed to use modern NAPI api, like
> > napi_gro_frags() which will take care of that.
>
> Thanks for the review.
>
> I put the test in eth_type_trans() because I thought the stack should not
> be brought down by a driver handing it a malformed skb.  I take your poin=
t
> about the cost on the fast path, and that napi_gro_frags() already takes
> care of this.
>
> I will drop the patch.  I do not have amd-xgbe or dwc-xlgmac hardware, so
> I will not send an untested driver change; if I can get access to a devic=
e
> that behaves this way, I will fix and verify the driver there.

This function is primarily used by Ethernet drivers.

An Ethernet frame must at least contain an Ethernet header.

A frame smaller than that should be dropped early by the NIC.

If a NIC and/or driver provides the upper stack a packet without an
Ethernet header,
the bug is on them.

Let's not add checks in our fast path for a situation that should never hap=
pen.
