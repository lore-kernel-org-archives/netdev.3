Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792694805;
	b=O26em1N6i9PRQoMI1qTnpNMfNTxCLkk/xPuJW9mL676fyPgyKm+MtJJ+v7eoqe/2GYWQ
	 myHm1uSAR5fy62H7L8ICTDpbKcjWfR7OozUnE8ne+zid7HHcwhPJ8WSK0Dym3ADcgvsEF
	 wGL/XT+pSHI6aST466dQ2UFPW81+ySppyXW0shnkCyoXW/XjYOhStN5ONfQztqGb0V5Xm
	 DquzkF6tGygM/2DEtyz56X+aH3lNC6Y9whrF85iVU0eefCxqjtIPU6DXn/JSBWrzIQuRQ
	 TTev2VqSyzL3WFcF+DkJ1WlmkK8LhgcCZEWnD5VLElIjPKjyxt9+mJpXdYivaq/RtJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VJ3fHdUL5SmQAXabxpkgaJOcxdg9wUPTydhIVNe9+f4=;
	b=QEnFNfMcoSd5fIXyVKYiW6W5IfiKGeDzetK51OKk1Ym4eCtC4aogxwP0fy3zsYlKtStD
	 sCWxqdvZmSCZJYvRldL5apPLvOOT0eciloxSHd/Ro5E9IGv2aX9bpIuw2IwEkxIaeKLW7
	 pWPf4KYH3kPUUQN2b26VDtBlgHiN8a9Y5JIwOwEPXtxyhhP+tOJFEeXNUTrSBEBKmB3TA
	 MjAma7EsbAXYVQNNYG3HzbIFBckUalyHPPZgE71whKQMoWhnbEfjZRj/5qAw0SPQ+B48U
	 aO/ZKLSacaY52EJss7hGtAMEfyIgGk4eqI1RKfgM2LMfeU1Pb0w48tD2Ki+y/ee8zyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eCUYLTzw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC6606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CC6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eCUYLTzw
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06c60065fso154700b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792694805; cv=none;
        d=google.com; s=arc-20260327;
        b=SzID4RYjPPXL8U9+jPh32aeZhBRVS1FYDT54+nfXE6tDsOhFQf+rUnQbiLS9IwDIjy
         qdlM2ymA2scHMdXagHj+ywjL3bHcfsSqQvVqRfjnaOokMzw+/9iqKIevjYq+r7ql3AbF
         jf2UaqPomsdWCA8HGqyP/aJfvnhCN/RfmNBvHZL0I/l4JwlAxsr1KhU4TaVW9yIfuqHZ
         Z+Q8i4Bv72Sd9ofx7+p/+l63ZkPNKfzBfla/I/m9SP0FHWcsHAVr5UGpv6HkO2CxzEJY
         9+aeXnLKU1VuKpe7jolqcJHX9VKGHytHrIMEP8FtRQQt0vNEEz1zoT2TnVfFQhjnuJfI
         yPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VJ3fHdUL5SmQAXabxpkgaJOcxdg9wUPTydhIVNe9+f4=;
        fh=EAEdreS9u4Q/+427YsCA/E+CbT8IoT5z4TC01r2vpg8=;
        b=JDrzACzXBPvGRAWeIYZufIorW/COhuZFicekYXiOLyLZ96VT6iqrVhTIzMmP5JYwmZ
         lKE9uq0uKpLOp/qJQ6EczAOpwUYaAs7eH5k5hxxCAleR61MgbL8H2qU5u1xpEjBDgsps
         tUSI+ciE6WOEtf3FBcH5Q5MyfTaS8HoNGIOnKwHi1b3aNoevT9nmugo8xUtW6VMWkE4v
         g+OLBjAznjk8Tc7mYBPVq/Z+Yn35pJbIbCUnnEvmLZMAzC6OEbufUQbUu/6IjPB/AKBx
         Co8xoRqVfMwSyJSxvfdHPtiI0vRdywGJVbCDxyZoADYMXfgFgqdeSndXgVCg5JoL9UoS
         MATA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792694805; x=1793299605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VJ3fHdUL5SmQAXabxpkgaJOcxdg9wUPTydhIVNe9+f4=;
        b=eCUYLTzwJZfnxmvJY9lif6asT9vcmB2mq2KLsm86LPWGVoZxPtjKpSerjQHYcsIj4D
         egiAzCIIJObZgpd+Fnb/+IzuoC43KA53Onhu2BPNR8wXUQSNWmxQxU8J4demSlU4Jyvy
         Rk+qcJh6IfWE5OLhY8ZZvXS1tXDSz3IvgXCBf2wwB6+/ZXUVp+P26GASmU5c+X4/jnig
         SPJbKfm4LqSDhKuzVRvqs5qsR9LPgJrgYOa0sODJKY3QyAw33Jy4gDcNtFKRSk6Xz9gV
         Srk07x5b+lqGu/n0bH9Fywbd7BiKbTwKfU6aWAlya8HEHokfXZngpHgeZ61W3KK9yLmm
         Z6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694805; x=1793299605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJ3fHdUL5SmQAXabxpkgaJOcxdg9wUPTydhIVNe9+f4=;
        b=U7rkWZP+x9kyVbf18XvGbLQ7yva/JaOa1/hz2pDXtmBtFbiDywnkpLP2z5SfKot1Ub
         Adi0XvcjIBHEU10kmUgQFlYsOeFbwlAlJ6yYv5bcz5N65rFYe1Igz2koH6n9W88gGJ0r
         g55UzFe6DOtlzpi0INqCL4K3XYkZPPMyAoTqDsoRJVGFhHJrfr1ax3cVvvn3ysTGCpzD
         tQ+rltcbkKjDaTf7JxiVqj72OfmvzB9iOy8+1A4ZJZv0FzDbL2Sv45kBp7mk78j/6opa
         wohSi+viJMTB5q7aUkwsNO9zC/OQaoVaX7HMJrUmP/Vqrdjj0GbLVXtzuQdLtXFz+jFP
         sIeg==
X-Forwarded-Encrypted: i=1; AKwUvBzVFOTkLHfNXG/lTv/VNDCidl2XiqyWsjfd0CVS4/HqoldPzaCfdit+SIKgrwvoFj392edV2+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjxycd2yUib0qwvgPZw++bY1LcbX+M1QoFFY575xQ9321OODrH
	iUThXQLvvyi1bohdhYX9k9OBwfZhMzOuOXr5x+xMEKjDQl8ECTiH0DEcYMrPamWRalOSBc0JnLG
	EoUzkVTieCvbV6FDpmkfnQtjPUVONZo0=
X-Gm-Gg: AYBFou1QetO8BDW/biVPSU/LWW3LrjhFHCtKDMSfT/33hw5WHFkOq5ASOjwlQQvD33w
	8r62/eiF6GCXdWarUDEHO9+y/zyQUqnVN6zi92NFIf8kzPZh7pWnF4rZPQRJW4hoe2VNzsIt1gn
	dI56ijaRzfxNEvFqb95qACmErhYHWHxUvVhdqvyzXPmkNWcwfKd+xuNOE9YipwB3Ae4xKoCZsPU
	rXJDgfUKF1Ck+JdSgDy93eXIwI2AgMKGtGoD2wY1ZFtHB+zmbV7jWF9dKut4TRAMg59hr01IZwy
	DDjtpUOevD6xLqMjjbAw4abe47RuJMrqILwySf9Bu8Ag7FUvYsbPoLo4t4rVyCcGQhiFHONxQBd
	0zHLk6WkJQ5G9P/GLLat2+9LAJ/7U26lXD479IWFZoD0Y9XKtlBbeoEm3l5ing5Zif/SxBmRuMC
	5VrPlRlHqbc0gMqsJNkIx2nrPg1YUapUQziME=
X-Received: by 2002:a05:6a00:428f:b0:8a0:70ff:aaf0 with SMTP id
 d2e1a72fcca58-8a2c7656184mr31128b3a.49.1792694804726; Thu, 22 Oct 2026
 11:46:44 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019073747.178626-1-hdthky0@gmail.com>
In-Reply-To: <20261019073747.178626-1-hdthky0@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 22 Oct 2026 14:46:33 -0400
X-Gm-Features: AclHuK-PDx0jP5an3A6M6WQQwIMwVAosfNCvGR5QppU0ezO-BznZ8wHlN5NdZ1U
Message-ID: <CADvbK_ft9t1ipGawiOGsKU+qf0PFhctvewV6v+P0XmSMZOyA3Q@mail.gmail.com>
Subject: Re: [PATCH v5] sctp: reject forged cookie peer_addr with unknown
 address family
To: Xingyuan Mo <hdthky0@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 3:38=E2=80=AFAM Xingyuan Mo <hdthky0@gmail.com> wro=
te:
>
> When cookie authentication is disabled, COOKIE-ECHO peer_addr is
> attacker-controlled. An invalid sa_family made sctp_get_af_specific()
> return NULL and crash in sctp_transport_init() on
> af_specific->sockaddr_len. Validate it with af->addr_valid() in
> sctp_unpack_cookie(), which also rejects a mismatched family, e.g.
> an AF_INET6 peer_addr on an IPv4 socket that would later crash in
> sctp_v6_get_dst() on inet6_sk(sk)->opt. Validate a copy of peer_addr,
> since addr_valid() rewrites a v4-mapped v6 address in place and the
> cookie still lives in the received skb, which is not guaranteed to
> be unshared. Store the validated copy in the new association and
> pass it to sctp_process_init() instead of the raw cookie, so a
> v4-mapped v6 address is normalised to AF_INET before the association
> and its primary transport are built from it.
>
> For that, sctp_v6_addr_valid() has to return 0 for a non-v4-mapped
> address when it is called with a socket that is not PF_INET6, so that
> IPv6 addresses are never used on IPv4 sockets. The check is done after
> the v4-mapped handling, so v4-mapped addresses passed to an IPv4
> socket through the socket API keep being accepted. As addr_valid()
> now also checks sk_family and ipv6_only_sock, simplify the address
> handling in sctp_process_param() with it, as it additionally filters
> out non-unicast addresses. As a side effect, a v4-mapped address in
> an IPv6 address parameter is now normalised to AF_INET before the
> transport is created, matching what the socket API paths already do.
>
> Also add the missing !af check in sctp_process_init(), as
> sctp_get_af_specific(AF_INET6) returns NULL on CONFIG_IPV6=3Dn builds.
>
>   BUG: KASAN: null-ptr-deref in sctp_transport_new+0xa7/0x350
>   Read of size 4 at addr 00000000000000b4 by task poc/682
>   Call Trace:
>    <IRQ>
>    sctp_transport_new+0xa7/0x350
>    sctp_assoc_add_peer+0x153/0x850
>    sctp_process_init+0xf9/0x1180
>    sctp_sf_do_5_1D_ce+0x464/0xbc0
>    sctp_do_sm+0x114/0x2990
>    sctp_endpoint_bh_rcv+0x280/0x430
>    sctp_inq_push+0xdd/0x100
>    sctp_rcv+0x17f5/0x1ae0
>    sctp4_rcv+0x2b/0x40
>    ip_protocol_deliver_rcu+0x25b/0x270
>    ip_local_deliver+0xd1/0xe0
>    </IRQ>
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: opencode:deepseek-v4
> Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>
