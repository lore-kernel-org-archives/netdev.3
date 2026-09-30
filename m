Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18A3BFAE7
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750563; cv=none; b=BogreHOgFZtgaQcRL0q8vYYOQZF6NLOuPvJcGhUpeFNUNIN6nPIJ487xK22Y1ICYDE9fYd+WMhGHv/Abvn4TA2u13yJoSxTcIZBh4yaFAB0vjRlaGUyqshdtyXrqMvRdqUrZm3JWx6Wg3ag6I+R0/dg/32E48gy28iSd62wL6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750563; c=relaxed/simple;
	bh=Kua3MDBCCmugX9E5NL8TG9YNQd5rZZc5cs5L0wDUUcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcaGAuGqel+OP1Zlo4Ah+CG6yQzOfUFI8Cg6oHRu4jdlBQa54o+yGqPf+LZrgT7LwAgqz26W9X6vGXxTimq2TQPkG9fpmdDg7TCjBb7xRotJIaXlF6snnpQtD5kY+ERilWQ0OObn4UWI4T8Nw1wlXWbhbd7J1X9W7SGJL1VjspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhlOc2VF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhlOc2VF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1A21F0089D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750561;
	bh=8FxJSxcnVyLZJHk5R06ZdTX5+6zCr4fAwZKJewCZpq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WhlOc2VF7YFcBHzJ0f5VEKu1j9OBwPQwb5Vm71sk0C7KpOb5mp9WotStMJVuBuAps
	 S8MLZCcXzAZLXmjQGVo9CJp0KV3Wq4+8mpQvY2HDLMgI4imIGCLkm+eRQ/pTOOrAkv
	 sYrjV3jJ6stmqkNBblP0VL981pv63fTrnhYSVlPURTVbvn1kbs5lqWO5XW4y6KADSp
	 XSmhDLmRAWQuR7s5EV8t57ExBPIxCUWCdR69lDUasczRi5zA4rwWNg3DzdZ3u9tDh+
	 Boiam/A1mdxe4z7tGlHGscdiRVgGyXeH6Nc/4/IGfdh5rissiFn09LzcfB4wK3S4d9
	 rChxg4ovs5ptw==
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-82067e86a89so63740a34.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:42:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw767kvkOMzNmh/hfPoDDulhCcnWo0t06KCmJgo5mTULWTbN1QcII6QIB8hyqBLofusqZNorTs=@vger.kernel.org
X-Gm-Message-State: AFuF++n9IY3R8zPDC+oed9U0/T7a+bjCxn9z8lJhjBLN+YSesF/vdfLG
	Zwd6gvR2VbDAt+dmQ8jzmfXssVzIKOfkM9KR+8pNFQbia9bOc9hCHGjV/9q7nFQtq2hQbTEkGli
	tV8M6mIMtuRSRf4zF98qjAS1UPCHEbTI=
X-Received: by 2002:a05:6830:44a9:b0:81c:e3de:d194 with SMTP id
 46e09a7af769-8204c016635mr569241a34.10.1790750560763; Tue, 29 Sep 2026
 23:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929214351.856940-1-edumazet@kernel.org> <88c771ae-4231-4795-b707-ff958ea27096@linux.dev>
In-Reply-To: <88c771ae-4231-4795-b707-ff958ea27096@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 30 Sep 2026 08:42:27 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip276c1G4njLi7AqoQiS5i3NkTBpte7zoNVPz1dp5L1UQ@mail.gmail.com>
X-Gm-Features: AclHuK_EtD446UJ2u8v5D3IVlZ2fQffnC3skAEWTLa2R5k9xOqwtcTlcb6F1sUU
Message-ID: <CAL4Wiip276c1G4njLi7AqoQiS5i3NkTBpte7zoNVPz1dp5L1UQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: free inet_opt after an RCU grace period
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, 
	netdev@vger.kernel.org, Xinyang Ge <xinyang@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 9/30/26 5:43 AM, Eric Dumazet wrote:
> > tcp_v4_syn_recv_sock() transfers ownership of ireq->ireq_opt to the
> > child socket (newinet->inet_opt) without copying it.
> >
> > Another cpu can concurrently retransmit a SYNACK for the same request
> > socket (either from a retransmitted SYN, or from the SYNACK timer).
> > tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
> > under rcu_read_lock() only, and ip_build_and_send_pkt() and
> > ip_options_build() then read opt->optlen twice.
> >
> > Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> > into ehash table"), request sockets are processed without holding
> > the listener lock, so nothing prevents the child socket from being
> > freed while the SYNACK is still being built. TCP child sockets do
> > not have SOCK_RCU_FREE, and inet_sock_destruct() frees inet_opt
> > with a plain kfree(), leading to a use-after-free in
> > ip_options_build().
> >
> > Readers of inet_opt already use RCU, and other paths replacing
> > inet_opt (do_ip_setsockopt(), cipso_v4_sock_setattr()...) already use
> > kfree_rcu(). Use kfree_rcu() in inet_sock_destruct() as well.
> >
> > IPv6 is not affected, tcp_v6_syn_recv_sock() duplicates the options.
> >
> > Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash ta=
ble")
> > Reported-by: Xinyang Ge <xinyang@anthropic.com>
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
>
>
> For the SYNACK timer case, inet_csk_complete_hashdance() calls
> timer_delete_sync() before the child can be freed, so I don't see how
> that one can race. The retransmitted SYN path is the real one I think.
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Agreed, if a V2 is needed, I can amend the changelog.

    Another cpu can concurrently process a retransmitted SYN for the same
    request socket, and send a SYNACK from tcp_check_req().
    tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
    under rcu_read_lock() only, and ip_build_and_send_pkt() and
    ip_options_build() then read opt->optlen twice.

    Note that the SYNACK timer is not an issue, because
    inet_csk_reqsk_queue_drop() calls timer_delete_sync() before the
    child can be freed.
