Received: from mail-oo2-f21.google.com (mail-oo2-f21.google.com [74.125.231.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809D409277
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487492; cv=pass; b=HcLm9ck6lBXiJIXNicfXEmAMhV3Rhu7eyIMVTSl+zOzAW3GHQPyO2F4qpnxUmzZYBGJ7Z3sAuVXU4B2SMkTUcK/e3jtWR+Fuc0CcfKnnHyD6MDiP8NMo9mevgYnFH7ZQZEnarmS2PvZh8fYofEUpYHut9Zt9apZP+pihkVg4TL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487492; c=relaxed/simple;
	bh=ZE3WRf6jwHm44maoVxf+MmYa5OvKeyvnM3vE38UytZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIM/ZWa7GzalGb3eYySEYYBTiDwF+sSUn9AFWLsfV79SMZdI6rBniY5n65xHkHZTmmHTbV9i6Qq0xcKA7HAZKpjkvaLj0qRstOb9OnKJba3skuEvS43iI7QmXiaf2m4bjXr/OulaG2fhzKE0Ie15vp0z5SSFdVl5K4aVv3TF8yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gukKkM8d; arc=pass smtp.client-ip=74.125.231.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gukKkM8d"
Received: by mail-oo2-f21.google.com with SMTP id 46e09a7af769-7f4f0d1779dso536010a34.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789487489; cv=none;
        d=google.com; s=arc-20260327;
        b=CtskgFPQrZdckSfCBjUv6YpLbfwsJjkgBCy5dPg5y0ctyuC+GkdEVRa40Rn6WN9BGg
         A2orMjVS1kB4f9AmUrlfQS2mvMq0NVfJBUKZjYbCAwe5zOqfmylck7ngHZEarUenXRFC
         bsq8fj6QqZNon1lJjcPfDxoZWRSfQOTDF3NsVfKB30wzIWkO57lDij5ce2sxYK8jIJgg
         qQObuGAJ2jtlUkea5cYyLTYOQDCWZ6GXAsIPu0bcHoiqst6JUeKQNncb1VilIuFsX9VM
         04edWJ8aM2a06QinSV5zOgJdGxejCeRV9i05zurWj1Hy+wZgBWRP4efBe03RaQNmj/lT
         rJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qLaU8Sheaee7OVZT67w7SriDUMjtz6t3Qx6H6/8vnfk=;
        fh=n7+0h+h3xN11mPronGyBEOARy1+ks5LHTsD3ekY7TZA=;
        b=l6T38n+GgFsfe1Ve4neXmyvB/hk4EFr5x22dnvb0yHDHuCaLWJNFwsykLTU/IfGx7+
         9rkSC2FLnZ8WYK3W+g2rw3Z4o7KC4E5LwAtGx8dOuwl8bbAOJ03AcU/Yl2L+KiL5ayz/
         PeJpssxUNXIJDY7WnBhqdMNxqAuGeqssalHoNX3AhpZEAb+MygsdPceqO87y5OCQ8oe2
         JzmSw18WKAQOmOOPrneu/FAJYwOZ5VjqgsVNlulu9ILR55pt8JExJVG9GLKUaXyBe1i0
         fn6RMXle48Wp9UNSx4wL5qt7kGJdFb1h27Fb+Gqbnn4I163OysIpSIgu1cHta8u8+e/Z
         KI5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789487489; x=1790092289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qLaU8Sheaee7OVZT67w7SriDUMjtz6t3Qx6H6/8vnfk=;
        b=gukKkM8dVT4AU2K/S8a4Z5A1bLCxSmtuqOEAgZQ3pT9iobLe2mE4M+UVgfbY3jeooU
         0GwrpRLAs6h926sYYQgpdbSFAm6jn8VsovNqvoyOozxGwYjnJ6E3USmXtLGOqp9GflhN
         9SniHcESMVFD7ZkWz4KaNBypefe+tsZ/jwkJtAvkFD+ZTN8Vlknczzb0rdDY5rryMXOo
         trGXafboZlVTqMVrYZbpqohHrsvc6gh/0i0SoFQVAM+A0zjZ5+OjuvxsufT6QsBdZ55I
         pBpdUarEWkkkUgF9LZfgzVTaACTxXDC4gmUkXepOnNkTEUhQqcHRWCnk+Ac9iui044K3
         dksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487489; x=1790092289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLaU8Sheaee7OVZT67w7SriDUMjtz6t3Qx6H6/8vnfk=;
        b=skUMxkRVYsxPv4yrpBuEThpOlAef/3SYIVxW29Yqe3Ss7z9LoKApA8rS9QiVotjbmC
         wsVFFSXKhKajO5Q16bsU1zbmvSruZ9hx2PMROvVtV+MCLA7D4h7SJOEDNnSuO5LAPvo8
         ReJGCiN9ehjnF2h/hNcZb1kZYPu8AtQNEUyyAwWmkR9fqm7F0dBmGwdBn7jsufBG4WPG
         xyJCVaBA5ldEqDjVIoodnMLpkK52Ip0LSTrFotPNCax039PN8CmKFQmyY6w6nDPKytGL
         3vtw2EG0RwkGLPAOwZfBY/GcPqdxqhoa+VISJKCYicv80bMjgoaJAdg/ZW9olws/Uo3I
         WiDg==
X-Gm-Message-State: AFuF++nKgAwlnwca2m6FrN7u97doPWLtJILzQOzSicnAPTilR5l6ko5V
	KjYXA4laINRUNmRCE5aEokGDM2+M6Q38j3ECT9GxDS5rhttme8u0emy2C/Dq2jL+q0l7bGvOy87
	u7W2CrbBwSb+jeUB0lCHpNAStdCgUYa78Nf0g8wUT
X-Gm-Gg: AYBFou27opUDaYxuCtFNwQC6LQNsRAGpWDzVoT+eMTCzUjjMsV+Ob+adXyhHB+p0BdV
	gt1eJ/KKNdvbS/XgaDu9J5Ku4w1B8Z0Igtxeir2/JTHgIJqhbFQei2Ct6stpJd1qDlWo/e7nVYk
	5spu8388T9Eu7M6V0FWtWmbVZTbtjUCiL7WyIxWJcWVah4uaDBtM3Q6QE2Q85jyvA4jW5VZ+731
	gPtMkoCx5mlzBUiFfeKsZfUBJaUr4rTV+gX+DcR3KtAWousGV632rGtPMwKpxVsc5ki6wGK/OVI
	h3RvzB41yCF3Oz08w/mja35lBJnd301/lC1JmhURxXtDXWy09O1h5QD6f4mu1vtCY1G9furQdGw
	VOxahkxGHmrtkWtAWRafYZeOMIRG7v7mSqBKX/ww4qzd64AXOw2zP473/5T95HHYsQXs+
X-Received: by 2002:a05:6820:f036:b0:6c1:d6a4:9268 with SMTP id
 006d021491bc7-6c737b1ca30mr1441282eaf.5.1789487488174; Tue, 15 Sep 2026
 08:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL8qZ1bxzBXReej7M-20HkBwON9L6NZKZP96bs7s-e=j-_Gg8w@mail.gmail.com>
In-Reply-To: <CAL8qZ1bxzBXReej7M-20HkBwON9L6NZKZP96bs7s-e=j-_Gg8w@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Sep 2026 08:51:15 -0700
X-Gm-Features: AcwNN1VZxjUbgSRdsZo-3wXq8QiVHvk8HaQExXuqbOILOADwb7TrgLSgG0x2RqI
Message-ID: <CAAVpQUBWtdDe4dS5Sd6mETpxVdmvSrnQkBdfK=NKgoWzTJUomw@mail.gmail.com>
Subject: Re: Subject: TCP receive memory accounting before accept() with
 cgroup v2
To: Cyclinder Kuo <kuocyclinder@gmail.com>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, edumazet@google.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:08=E2=80=AFAM Cyclinder Kuo <kuocyclinder@gmail.c=
om> wrote:
>
> Hi,
>
> "Resending in plain text; the previous message was rejected by netdev
> because it contained an HTML part."
>
> While looking into whether Kubernetes can allow net.core.somaxconn
> by default on cgroup v2 nodes [1], I tested how receive memory is
> accounted for connections waiting in the accept queue.
>
> I understand that d752a4986532 ("net: memcg: late association of sock
> to memcg") deliberately moved memcg association to accept() time.
> The discussion also explicitly covered data queued before accept()
> and charging that memory when the socket is accepted [2].
>
> My question is about memory containment before that happens:
> if an application delays accept() indefinitely, how should the
> receive memory of those pending connections be constrained by the
> service's memcg?

AFAIU, this cannot be constrained by memcg, and you need to
configure some knobs (somaxconn, tcp_rmem, rmem_max)  to
define a sane threshold per connection.

https://lore.kernel.org/netdev/20250707213900.1543248-2-edumazet@google.com=
/


>
> Test setup
> ----------
>
> - Ubuntu 24.04, kernel 6.8.0-53-generic
> - Kubernetes v1.35.0, cgroup v2
> - Server container and Pod cgroups: memory.max =3D 512 MiB
> - Private network namespace, somaxconn =3D 65535
> - Server calls listen(65535), initially without calling accept()
> - Client runs on a different node
>
> The server container was privileged to set somaxconn in its own
> network namespace. The host's somaxconn remained unchanged.
>
> The client established 256 TCP connections, then sent 64 KiB on
> each connection, for a total of 16 MiB. The server subsequently
> accepted all 256 connections without reading any data.
>
> Results
> -------
>
> Phase                                     Pending accepts   Total TCP
>   Container           memcg
>                                                accepts
> Recv-Q       memory.current  sock
> Baseline                                 0
> 0                 8.49 MiB             0
> Connected, no payload          256                        0
>      8.49 MiB             0
> Payload, before accept          256                        16 MiB
>   8.49 MiB             0
> After accept, no reads            0                            16 MiB
>       33.82 MiB          25 MiB
>
> I used ss in the server's network namespace to observe the pending
> accept count and the established sockets' receive queues. I also
> read memory.current and memory.stat in both the container and its
> parent Pod cgroup. Both reported sock=3D0 before accept(), and
> 25 MiB after accept().
>
> The data was already queued on the server, but its receive memory
> was only charged to the server's memcg when accept() was called.
>
> I did not exceed memory.max or test memory exhaustion, so this
> does not demonstrate a node OOM or an absence of other network
> memory limits.
>
> Current implementation
> ----------------------
>
> I also inspected upstream v7.2, although I have not repeated the
> runtime test on that kernel.
>
> sk_clone() still sets newsk->sk_memcg to NULL, with the comment
> "sk->sk_memcg will be populated at accept() time" [3].
> __inet_accept() then calls mem_cgroup_sk_alloc() and
> __sk_charge() [4].
>
> I also found the discussion explaining why simply inheriting the
> listener's sk_memcg is insufficient, particularly when a listener
> is created in the root cgroup and passed to a process in another
> cgroup [5].
>
> Questions
> ---------
>
> Is the pre-accept accounting gap an intentional limitation of
> memcg socket accounting?

I think so.


>
> Has temporarily charging pending connections to the listener's
> memcg, then reconciling ownership at accept(), been considered?

Not sure, maybe Shakeel knows, but I think it would severely degrade
scalability, and the change may surprise current deployments via OOM.


> I realize this would need to handle different listener/accepter
> cgroups and the root-cgroup listener case.
>
> If that is not a suitable approach, is there another mechanism
> that should bound this memory on a per-service or per-memcg basis?
>
> For the Kubernetes change, we are holding off on treating
> somaxconn as safe based solely on cgroup v2 until we understand
> this better. Pointers to previous discussions would be appreciated.
>
> [1] https://github.com/kubernetes/kubernetes/issues/134194
> [2] https://lore.kernel.org/all/20200222010456.40635-1-shakeelb@google.co=
m/T/
> [3] https://github.com/torvalds/linux/blob/v7.2/net/core/sock.c#L2542-L25=
47
> [4] https://github.com/torvalds/linux/blob/v7.2/net/ipv4/af_inet.c#L761-L=
766
> [5] https://lore.kernel.org/all/CAAVpQUDUULCrcTP4AQ31B5bfo-+dtw3H8CQGq9_S=
Q7d28xXSvA@mail.gmail.com/
>
> Thanks,
> Qifeng Guo
