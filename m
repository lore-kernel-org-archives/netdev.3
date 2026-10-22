Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666131;
	b=0Xc4IvXpMwyYf1jSsACv8kndCWSwFst7TlIE8Hh7P5p88r5x1jYTEHeQoOxTJ+chlcl9
	 kWkuNMZ4U6eDvhyR0pAUFjCRYwtWaNGPvqri7NiVhX/fJMgUEGbLSi9+5VvqIm9kysv/c
	 ZczeIpWdD8ICs+vYMDDwBQiBeKwYrYNfZC4pZUM56LinauIRCDCQE+pAxDL8ClFc0++j9
	 gL4suzz69DqrJSsMA8CGSGx+TWielP/fbhdmSAXF52dNS62ylDOu1k8WKHiLe7D8ZxKec
	 K/3gws2mu9PA72pjtdKwtmkaM5KcP22UZCgM5GhwM064vsD0NA/m7L+95tRhmvXmDyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666131;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6h+090XV4AUbcVggLD95jkyA3B0dznfa0uKt5/mUhAw=;
	b=TlZUqQKRnbgx6xsW8j85vU3IKGOxg87RzH/qGAMxCE6R5I+SaTkTu5KZKbh0BT8vw/QX
	 Y6tUi7PQ5oiyGiWU2t4oogY7LV7nQi8pxKLfbj90a2Q+er6fXjVjorOVPa8Rivztd9UHa
	 WzU+QX+ItITgEjCN1TCsxNj15gz93jRZlf2gX/g/hzm0DXGvZCLckF0XxV+BA5QnGMOzC
	 ObO2GGFtLXDQa0lWERk165O+pJHjzjzpeMe4QWj7IPURhAJnuiaDYsK7kTcU9h0TT+w55
	 2eln7gxjTFxaWi4iec/A/hLeNoyJPBwWs3HrGnUbpgdMxlSXBzKSsjWSplOQTL72ZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfVJMHsB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BB606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfVJMHsB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5C91F000C8
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792666131;
	bh=6h+090XV4AUbcVggLD95jkyA3B0dznfa0uKt5/mUhAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jfVJMHsByPaXl8YwBxBP1xzbR1WQ8D3eebUQUPlGJiBcQdsfMjObN0K/Rmob4SxyG
	 ckj1Rx2khXhSTwHfZcvbMXCI/W+ORSKDF8E1Bx2TtbIXrOAhLh5LImiQ+nl/BLdY05
	 pJuMQg9V1ogBhP+8i0Mks1jd8Z3esYO/UwvDvO6azKfgyjpanm+czZT9nuXs270br2
	 bTxMKhn4diJbp1LyqPZ/Z3MunW0rHW5vfFzESb6sUbl/2P7mEdpRVvihAeqg4enY3q
	 9lsde9vhtSqe22RY8SbMAK05RGDFJOZSjXwlVDstusKvhV13rrKwjfL3putNKfcodr
	 /vGTjtwC9HWcA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4932b13c4ccso873718fac.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:48:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxWX98S0dOoL9/t6Am9RiY2mU2/zHmSiTDnpaI1PXjuf6f629u+Yff23r5OwEmoweeXrId9s/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0t2FDT8FrI+aD6t7eosX9+2SaNvgfJd1QSxI1c7rtSrqNOOl0
	ozcIzVjKKYF+BJjraukh0NHJoMgUstAnZGVP9JmU84Ro6DR3ILTCPCrUNGSVtMHUdz64yz3+4a/
	1tidlDri7n2f6VsGxeNEPNq31aoK0m3M=
X-Received: by 2002:a05:6870:214e:b0:494:a6ba:53de with SMTP id
 586e51a60fabf-4a7dc311d74mr3316797fac.60.1792666130335; Thu, 22 Oct 2026
 03:48:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022102641.1429128-1-hackerowskiy@gmail.com>
In-Reply-To: <20261022102641.1429128-1-hackerowskiy@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 12:48:39 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiq3Bg75Gtnid8cGuhmCVZ7yhd+kEF78mXtdq5ce-CJxag@mail.gmail.com>
X-Gm-Features: AclHuK9Aw1IQ0g_DyyCsu-kE4upblkb_k_cLT1MAGcNgv1aEWAaEyD1MSeJF7PI
Message-ID: <CAL4Wiiq3Bg75Gtnid8cGuhmCVZ7yhd+kEF78mXtdq5ce-CJxag@mail.gmail.com>
Subject: Re: [PATCH] xfrm: disable state hash resize work on netns exit
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 12:27, Eduard Zateev <hackerowskiy@gmail.com> a=
 =C3=A9crit :
>
> xfrm_state_fini() flushes state_hash_work before it inspects and frees th=
e
> per-net state hash tables. A concurrent state insertion can queue another
> resize while that flush is in progress. The resize worker may then replac=
e
> and free a table while teardown is still walking it.

Which concurrent state insertion ? At this point the netns refcount
is zero, there are no user sockets left, and pernet device exits
have already run. If such an insertion really existed, disabling the
work would not help: the state would land in tables we are about to
free.

More importantly, the syzbot report does not match this theory:

- The object is 64 bytes, allocated at xfrm_state_init()
  (net/xfrm/xfrm_state.c:3358), so this is the initial 8-bucket
  state_byseq table, read at bucket 0 (line 3402).

- It was freed from an RCU callback (rcu_do_batch -> rcu_free_sheaf),
  that is via kfree_rcu().

xfrm never frees these tables with kfree_rcu(). xfrm_hash_resize()
swaps the pointers, calls synchronize_rcu() and then kfree() from the
worker, so its free stack would show xfrm_hash_resize(), and
xfrm_state_fini() would read the new tables, not the old ones.

What the report shows instead is a stray kfree_rcu() on a stale
pointer to a kmalloc-64 object, issued after the slot had been
recycled for this table. The culprit is somewhere else, and the
report cannot tell us where: the kfree_rcu() sheaf fast path does not
call kasan_record_aux_stack(), so we lose the caller.

This patch therefore does not fix the bug, and the Closes: tag would
close it based on an untested theory.

Thanks.

pw-bot: rejected
