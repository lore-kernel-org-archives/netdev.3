Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81F1A3166
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039391; cv=pass; b=ZPWC1GgCgWfTYXicT51X+9rOE0pf1SlNReKQquIVv4WKCaJbTJq+K545iQUFhPmzSJ8gPJGZjft9glb8dsUS6o3rUT2n+LOEVnJB+IXffVQuTfQfhCbGoK6OaHIV0FtGX0URv+8azaxBLe5jVeqT2/Lsbp78QU7/CkQSxUrDD4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039391; c=relaxed/simple;
	bh=ezXLVRbb+zxHqJCqPHjFaHsQnF2TTsc2hryxULy4MnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZpNdwFT1ijbot9qoIu+0bgX6dcFA4ImwgzAD+l2zS5vhI92Op6KKnar/ho0wCfzBelD0RWAatni3ADTR+G7hXU7GEVPrv/ie87x7NO7WNh/I7omSKMZn7+M9OHx1jTk4NVEnYZZLoCDRsEMVHIHNJk/pf6h7nIhrqRD5d3Ydek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3rtV5nF; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3rtV5nF"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50d1b048eso2810429a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039389; cv=none;
        d=google.com; s=arc-20260327;
        b=LIZVuw1oVqFoMfiKTmmap5TLPDGLKULTg2UbCVjtGb2PRDpJQz/qwItSbJJABZZ0rL
         Y0h93GacTTvg64AKk/wAT0moFZnvUZlCQjna8pBFkaP0HtVuOLTTkppYEOXiipA8/YZA
         AiaOiz2Cw67TNZedVNCIkVWE/H3bng7XFfkT3gkrWR4dkI+Y9aioi+GBgZWl4CoKPw1O
         2t3acY83XsHBQ6X2CL3umUtgqqMuQi89CXr7RCEKZx+OthCYdamfrIVqh9XZgNkQBUOy
         lww6j4wb5yLd7c7GMqsrXHPkdyMINWeOP8XFdOBdmgHUJyoOi+g8GhZVe0aJRxuxqAxc
         34uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUDOXujiqW1xrz8MTucaL1Wl15NF7Mgdmm64Na8Rt60=;
        fh=MFmERlkAAiIyIcM6K3Q73X88WS7R2nl3pIhsKgYW+VM=;
        b=MGDoeBqGQlFUQLSiG1xgGYL4TOX1BW+fn8vUMw41y3RiX9QVtZEwh2Ajjhip3mH3Ly
         mc3pFwr+DV768tWSMi6uATyliX0DpSUEQaxZf1w4VqArDzK8wCE6LyFE5L9LY3cTt3Va
         Swb9SELSWk+nvxqOJBjo7fLjzELXJ+AwMOE43dVr/9VGBgHNco+f4ps2ShyMnmox7ATL
         r9q6dpgMDGHVthsNkXNY+utKuLFgD91fgD0adXVSUoGp/k/ok0L52BBNrRkdXLsM3WjJ
         I6ajdsViTJG5vHexWtnTIYkOPomJz2RjrdN9mhFMPjINJ4yNY2GQbdzxo5iVNPKUHsim
         e6uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790039389; x=1790644189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUDOXujiqW1xrz8MTucaL1Wl15NF7Mgdmm64Na8Rt60=;
        b=W3rtV5nFp9cxGbfPB5ES3X5RPk3kjzjyHG9jt6ms63AFkKmIfhfhjYx48sXpYdv8k/
         CZF/KExeb7bxJJrkczg0Fy6eeMxjIvJ9xEUlw3jkgFkL276ISX9p6lDC99v33bVkB20o
         Mq2pn4ztvGgvLOdkv0pnUZGWbGqXrCFod1NtOOvosuqI0bPsHxChqQrwiFO2JnvSvi3j
         EtmHmtSCAGUXlmDtsCCTYo+v+QbU2LJDbYUr6rjUIqRzxfwH+kQyeSIO03wOi/o/vnxL
         ON7V2BJD+GvAIQrEDKhQN67v28g1HfBs7mu7rGNB/basS9IfymhtZT4aZq4bvjBP45cu
         gU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039389; x=1790644189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUDOXujiqW1xrz8MTucaL1Wl15NF7Mgdmm64Na8Rt60=;
        b=etfTrv87bQkYZ5HUAgoR0URj3aaKPyPPQd0u3A27RCYlabWiPq4VGrq6qititsPVDX
         GRXpARxzRq1Bw8oKaCiu0UXREdv1tE8dwq9e8M7JO0te1kIqqBvnP+TAs+piwJHd7zNA
         ibq1D7RKggJUgHY+fjpiRZLpqZJYyBz71odu5XU+e7wp5Y1z3kYquMWHJepMsWXCwyGr
         aLlSDA+nFNvVShoJmjPn1X2UYKv39CWG7KrPJ0Q9hHY/K7xQWF2zygfLay3AX6rgdCgT
         lQ7GTIL2JDhkT1sTSTFA0fUHIdh9UWFV7G/5htvLMBSMlv/uuaanAO3oLPLfuMlK37XW
         p+9w==
X-Forwarded-Encrypted: i=1; AKwUvBzDWR5DKxpS6baKeZjNNLw0wZvGd8If8P8XwN99YR7DY/szzZfoEHbpb3pSZNeZBcgbyBiLaas=@vger.kernel.org
X-Gm-Message-State: AFuF++lONSeR+vopeMDhcLaNcUpZpjGJIsJFKcXDl0qliSntDoIRlHd7
	6kyFl8s/SucrymRW1aC9PRWTF4uhyw+nw1NViG9wMBd8CeGSlYk2lzzdclHu5d/WGZgTykGogx2
	d/dVcX2pz73XefPwSqJKrr14KiQnqA6tMOvCzLrYB
X-Gm-Gg: AYBFou1BIF9XBHFqJe41eTkJ5JlF5vt95z+2s2wrWh96SW0XjJSHSxf+YLpS8x1OVp3
	9bv6IY4P2mmzv/6lkYpi0WnVBurQTy+op0hdGTL+kcHT1cenRL5DB48PUuDP+38n0d2TMfmyMY6
	WZLq/A5HfF/2Yy7jwhIKuQ5JQny87TYHEJ5oi7z4BxYQK1BOEnUi1EXpKvUVZRYbtRJBswZu1dk
	4v3c9gz1gLRk9Eyo+MH8DHuReGpFeh+Q6e1hjBrPoE8TwwNbA1mytH+xJWATuJ4LUQhUXKuEngM
	0auKBmfxlnwYsbGA9R2nmQ6K1zOmUOgqpMX9seLk/T+y8hRz1GCGrbH079yH4wU7882OM6leCLP
	FLQZ55yFE2r29jg4R8x/yWnx96ST8hYVk6MqK36wkgyEZBHa28iIvneAJEu0k6UE0y79t
X-Received: by 2002:a17:90b:2681:b0:39e:6c6a:657d with SMTP id
 98e67ed59e1d1-39e6c6a67c0mr12045871a91.64.1790039389045; Mon, 21 Sep 2026
 18:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com> <20260917-udp_hash4_fix_v1-v1-1-718891af0d7a@mpiricsoftware.com>
In-Reply-To: <20260917-udp_hash4_fix_v1-v1-1-718891af0d7a@mpiricsoftware.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Sep 2026 18:09:36 -0700
X-Gm-Features: AcwNN1W4zo0lF11_EKGR56RyaFTOenFLfq5u9TmQaHIyrpW_Y2TQj8_ayHXa_fw
Message-ID: <CAAVpQUAi6mP4D3ZHZcWksfcuWx25i=2-qBzg6wakvZSDLLxS1g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] udp: relocate a connected socket in the 4-tuple
 hash table on re-connect
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Philo Lu <lulie@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>, 
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>, Willem de Bruijn <willemb@google.com>, 
	Cambda Zhu <cambda@linux.alibaba.com>, Janak Bhatt <janak@mpiric.us>, 
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Shardul Bankar <shardulsb08@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:26=E2=80=AFAM Shardul Bankar
<shardul.b@mpiricsoftware.com> wrote:
>
> A connected UDP socket that connects again to a different peer is not
> re-filed in the 4-tuple hash table:
>
>     sk binds to 127.0.0.1:21001
>     sk connects to 127.0.0.2:20001      // filed under hash(sk, peer1)
>     sk connects to 127.0.0.3:20002      // still filed under hash(sk, pee=
r1)
>     packet from 127.0.0.3:20002         // hash(sk, peer2) misses, so the
>                                         // lookup falls back to scoring t=
he
>                                         // hash2 chain for this address
>                                         // and port
>
> udp_lib_hash4() returns early when the socket is already hashed, assuming
> ->rehash() relocates it. ->rehash() runs from __ip{4,6}_datagram_connect(=
)
> only while the receive address is unset, which a second connect never is:
> the first connect assigns it, whether the socket was bound to a specific
> address or to the wildcard. commit 644f9108f3a5 ("udp: Make rehash4
> independent in udp_lib_rehash()") added that early return and named
> connect(AF_UNSPEC) as the way around it. That workaround does not help a
> socket with both SOCK_BINDADDR_LOCK and SOCK_BINDPORT_LOCK set, because
> __udp_disconnect() skips ->rehash() for the first and ->unhash() for the
> second.
>
> Delivery is correct either way.
>
> Relocate the socket when the hash it is filed under differs from the one
> requested, which is what commit 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash
> for connected socket") did before the early return became unconditional. =
It
> is done here under hslot->lock, which that version did not take, to match
> udp_lib_rehash() and udp_lib_unhash(). hslot2 is unchanged, so hash4_cnt
> needs no adjustment, as in udp_lib_rehash(). A first connect is unaffecte=
d,
> and IPv6 shares the code.
>
> With 500 sockets on the port, a re-connected socket measured 522,553 pps
> without this change and 2,055,078 with it. The UDP side was noted as
> remaining work in [1].
>
> Link: https://lore.kernel.org/netdev/apnHqmYZQ4yzOP4N@v4bel/ [1]

This link looks random to me.

> Fixes: 644f9108f3a5 ("udp: Make rehash4 independent in udp_lib_rehash()")
> Assisted-by: LLM
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

The change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
