Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944B37DAA9
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278744; cv=pass; b=Va/2zOBPx6rB74o5gmqdNGKHhDHIJ17h23OZxpbFo/DaaPXjV0CdMeIoC4TIzOTcsSrIl4elqy9jDsNc8JGNS10pQbO9rg5yKnyJQUjw25kdRv9DBwr93oCXMt2/LBq6UzLkM3O5jKHKDaDVG75ebI7BtaSkXQ/qKbUE+LbisA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278744; c=relaxed/simple;
	bh=kzBIwScZkxmJaAbRIZn89+TPiZbPYudZb4JFa930OGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM6QsdKUoflmFRm4QB45kdSIdyVTwnGhSgrnntF6MtcQ7i4ssutQ94zABdYzk4J1xTp9SWfTrzieDPGAm4wc3u/e0d9IzHnzfygGMFL415RcbhQ6QJE+AR8YsHFGOvPMoYHjqTsQ+BheTmm4spQjyTanP8hdeGlBaEUHgQ+C3vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKNqQ7lj; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKNqQ7lj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845e363246aso2490303b3a.1
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 12:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783278742; cv=none;
        d=google.com; s=arc-20260327;
        b=LZG6gqBTooFSKjb4McKF99jH8U3s826961nAxrYLvmavGI8z8Vw/aW9oraW3tEwLDj
         gMfBtkYiy+RwlgwbP7jLFYyevCfjZ8oprwJ5xTBthYVXiFofrq8REcupECKzaP//R3AJ
         PG+ha3hE7nyS3XTx6gMhsCJxeik7RvDHqbUVd15MHKrwtW5QP4zdXiLTIyCwQrcjIOkM
         Y+t8U62s1TM89MjJ8frLRc1A0uqp1lpjBKkugAcpb+L7/88Sb1MdGjCt0uZbxAmHll3k
         w7N1rgjk5lLNZDcqI1hWn8Z6n+44goBxxbPLknSbUMw1ThpRtHpHKqq/gdiezlhJzQfe
         IXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        fh=/SPI++w1w2FS7HK8XcBq2m9xyMSFz0RgAclVYrC9rOM=;
        b=I7FzfyOwnOgs+6ciYhLGozRgVmHqKO0x3j8A16tlm/pdBO/ka0dz68wYgJWHvjXKpp
         zKv8ju8ne38V32setBDIxW3i9fIvldgGWpqKEgfAKHQycDvNGyzn+yx1otQ416gT6wlg
         /cEhK9zZm6QxpZHTCAJGDBQImTkCfTReBrOUwuUEhwsGq2cMNPLbV0kbkq8wcg4yKhkA
         1FgOl4uty1XW3j96VA9fV4lHjQO1RqeFSseNcHUgcKm6EOTvvcuBeOggx+kHCrYk3Vld
         0hfA7ARYLThr6fj0oxNLnwmDfRDm7clbKMNlGZyLa9XHWx8HebmY3t8zt7ux5xnmJEFQ
         S9CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278742; x=1783883542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        b=lKNqQ7ljm0Q2s+uh5ZBmKjNi6BfodIrdl24723FeBhzQvFumO+GY0kVFGYH8mMU1ra
         Y4rR0pmxeLK7qjOinA+wYWkM9Z9u5d+1eEfve5Vnvc3qLc5doWdrqLCeUJxhO/9uwHbB
         puNO3wiY6Nf+IXn+0jYXlRoCaqL/zeNI8dv9mPelgESkhGkuH58N0mXDjRSIb8p2jaOB
         XMusjDqZnGCHeMbkWdLjm8lVVQKFYW0lFTvvrOYoDrxIkXkEHd+kYpT+WoEuFEm8+9NZ
         2xcjdGDNHa+RpUjrm2WYGdvahUBdCI8k6gNSBahham6UsAE7uHtEbS0ot4k9clpeK6X5
         KQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278742; x=1783883542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        b=Me5gvy2WcdFcbC8AxCo0GsMGkqB8PAB1UkBAKPTWuLfecTqR3kwYMnXYwHJA7mNRQ5
         HaJK+TKtZmqzuwr/37OmTpHPnYHWoEmHUan69b4Hn725KACS0HtOtV48eOctKUtpRf9H
         Xn+iD+ANB1M1K1cbdPtfs3s6Seymv5V2VP4VwJsyu0jkJiumD4Jj7qN+vVS4nJzz3urZ
         3Z0z0QyRIrG+F/e0bFf2OvmnsChvBZlXXLzWUTHV1c9DYTDKCcWjB47Ct08bo9ED6uwg
         dJTJnuJNFzQ7s9q//dEUYclFLxUgCqjy1qOydCzBsGsCjS1DSCnZVw1eESVhB2RyYLUC
         ixaw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4v6+XQ8P6u4pDSD7Xp5qUwL6LWQ8nV1KmMlQWptaiKG6eAeWP145hqNX84U1fiKVQrdIpxbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++rkhQ8cGI/9ukuKBPxG4hy4a+TAwc01ZWfmtxnR2I2phx33d
	EE0Rqi5YA3UWFzuDy56KU4WKDPiM9ThPEcPQVXW+72bZ24ZkFX0zITXnvapjCzh2TAZRxOmqgbx
	vRX2asrVGX/b6DKcYoZZ2R9D6FO96xaU=
X-Gm-Gg: AfdE7ckqsMF+lLIMl2RdewINTArk5jm8AORuGRtk2Dn9lpwuMR6DnsbnF0DUNDzZ4FV
	R3K2uL7oxBRDX75fH1uLL/s07qOKkK49wu4zPq9HyLwWTa+MbdfmKoPmdZBB+aGVRH/ORCh4VPF
	XVLlEyVlkPVEfa4E6O0BIzynJSHGD2Fe2G35Q32ULaVXqLi58+lGORqZjBm3gQO3GGzoyhMBLjA
	PuCjBV060+CRwWSI1IcibO3fisTq/xHps89N8pVwz7UhciavUj6SL2qV61zf0KUrWySESfdMw1g
	CGgyNJABNcLrMYsj2gOgfiJTfw+rTQ0IV+JgUNYTrjMQfLp0kR++eZQTf5QowyFDo1bvR6rTSg=
	=
X-Received: by 2002:a05:6a00:4b4b:b0:847:77e7:6f6b with SMTP id
 d2e1a72fcca58-847f6f96baemr6642867b3a.59.1783278741837; Sun, 05 Jul 2026
 12:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704033545.2438373-2-bestswngs@gmail.com>
In-Reply-To: <20260704033545.2438373-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 5 Jul 2026 15:12:10 -0400
X-Gm-Features: AVVi8CfHA-j0EDc3OlrYh1r7n_r_L9jvhfkZenL3RS3ltcoq4Bgp2Uu1c7Bg_Sw
Message-ID: <CADvbK_eJ+qePAuDF0u=rmQ2brixwmxhJRrUHi=jnbWoh169OfQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate STALE_COOKIE cause length before
 reading staleness
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 11:35=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> When an ERROR chunk with a STALE_COOKIE cause is received in the
> COOKIE_ECHOED state, sctp_sf_do_5_2_6_stale() reads the 4-byte Measure
> of Staleness that follows the cause header:
>
>         err   =3D (struct sctp_errhdr *)(chunk->skb->data);
>         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
>
> err is the first cause in the chunk, not the STALE_COOKIE cause that
> caused the dispatch, and nothing guarantees the staleness field is
> present. sctp_walk_errors() only requires a cause to be as long as the
> 4-byte header, so for a STALE_COOKIE cause of length 4 the read runs
> past the cause, and for a minimal ERROR chunk past skb->tail. The value
> is echoed to the peer in the Cookie Preservative of the reply INIT,
> leaking uninitialized memory.
>
> sctp_sf_cookie_echoed_err() already walks to the STALE_COOKIE cause, so
> check its length there and pass it to sctp_sf_do_5_2_6_stale(), which
> reads that cause instead of the first one. A STALE_COOKIE cause too
> short to hold the staleness field is discarded.
>
> The read is reachable by any peer that can drive an association into
> COOKIE_ECHOED, including an unprivileged process using a raw SCTP socket
> in a user and network namespace.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Cc: stable@vger.kernel.org
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>
