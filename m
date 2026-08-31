Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C04F55C3
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188409; cv=pass; b=kLP2WMAZR2+wsvlF9JypFLBDaYZFuqKUTGxw1vwqUSEv3pX47r1zZBlK81EL9qUubKSJorzUvdmLzYX7HhqqgnWVhnTl1DWOEuFsLPBxhGBo0ttsGiOuLst1tH5YPGUHu6QJD1i5lYR7ZMA0x5qUMik/9+pRvwe3LeDtCfeq5nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188409; c=relaxed/simple;
	bh=wJfBEfLv+Rwg7Tjw7PXm4/IPo+26W/5qnu3XOen5aCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1UqCJ3Q+PvfkZIPXDEP5gRaryST4dtPrjmOeJOdAGXQ0fFpemUCJMiMR0jXVrr4DTEIMOw64atKvnc5il35TWsJNHpY07qM1vDilJ9WBQGs++fnvHi5HvD+b3rmkRznQhjZ7pmyJmQCUSPTdBKALm/sTcKCa5DkHEB3WnkeFdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P79wDAX5; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P79wDAX5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfad59921so35190301cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788188406; cv=none;
        d=google.com; s=arc-20260327;
        b=dwII2lvBr+IW8fXDHsa5WzgQJ1EBPBRJS6ENKHpltwpjZ0Yjq6mWzmMCP9lK5YztZJ
         dCT9vI3a0yGen3ydAzWoPeGfpHBWXbRFmJjNmfF4opYAW8UD8rL8qL4IN5v/RAcEBkYm
         F2KjFiMToOP9T4AwGs7NinQeOIyl5DJnNZFhsX9xmQAm6nY1AP87zOIlmONsMQMZRrc9
         MK2xuBSzqIELS6JxTAgohzTo2u3Rtiy5WuvQmcpWsAKljWRZvZg/BlrHLQEMQ67BOWCA
         877R/IwKM1dWMaZfaaeF91j3TsD5ZNXF+0MvJuSiXNqp9QxKp+blcCn8Z2ghVinojm2l
         wBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ieLlYx0vyeXO3RjHlzi38YD4dkPfW6u9uvQpCQ5tCDY=;
        fh=ZVaoLUP1BokF3HHgrklcbBmbAVBcTXaszSpSd6H8cTs=;
        b=LHC7s2AsybAMij7CjUXTo9ZU4RR4qvYusd6dmZuwwnIzAs5me+tw3NVm3NdQWo/f6y
         gnLta9bTIdKTavlJR85NaqT09GBVpqc2E7kxtgmLBNGY1dYXYlvP0f8saTXofcFhQ6/J
         2BQZs11zL8WjVZlhRrwa3kKNnJwH+fv2E7McoUIrw8iVsSjaof3rgjMDMci/tqUypgXd
         O0DET3q7EC0AhGU6x+3eE0QAlLhEm6PxhdRDxe5Hij74XWcPNw8Jk67YT5t4SZTxsqIn
         886U4t59tBCjFD6TeJlcUIZgTU07TaZZm1NzgiNGm1pDDKj0Kl80u0JQXAiWNMuIiOSq
         zwRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788188406; x=1788793206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ieLlYx0vyeXO3RjHlzi38YD4dkPfW6u9uvQpCQ5tCDY=;
        b=P79wDAX53bYBYWUXDZ2VsNAg102RCtC0qfkqJcxkXHMHfl/MlUW3MaUlp5GQSRgI7O
         AQRITMc6tCwwAzaT/gAX1pXOQV01XuPESk0Y6n/o1AlI+BgC4QD5+5QcTxvaP9YqaOh5
         87F+5fiBTcMzma5MyguEOYxdIjzGpfpCyce7sAI3EpyfNYk8787vd+S5btzW2Av3sO51
         FVkNMZiS4TqKXqMa6E+/ecy8R/wCBZKvlX1iXI0crAY0YpCXbjkQSic6rq6Fx9L2q1kY
         /P9jG/Qt5uLaFMRa4w+ANb4jTd26ncW7/GQzDClxU/B2Y5vAMILdRqWNsZTokl5PA27c
         wBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188406; x=1788793206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieLlYx0vyeXO3RjHlzi38YD4dkPfW6u9uvQpCQ5tCDY=;
        b=oJk8Y38EIP1n7+KDCrzuFO9KZp66vUeptRP+sai1BcyiJ0Sr6PAiM23mZ3bvOMRO2W
         bJjnxEy0+qPF3PrWrUYNFrCmo8ThvO324TE9bBdPy3Rm6ADS4e0BTSxiGSgAwZHlRI/S
         nh+LTvKyqyeKCYeWE0gKsUZy0m2fgwtijsYSdGWCbhTWI0DvE4XNAenuQ+HZlAFsoVxg
         m0IeX6j82siHhbJROIXVqEl1iYWta0P97sG6X0nH66nO29Cvd3W614R8pOAE6b0kwXMf
         scDi2uQilTuI9cJXIKclJYuQqigBYTUIGvnP3HZ5XjDmA77IyDMQZYk21F4tni6EaP4a
         SGwg==
X-Forwarded-Encrypted: i=1; AHgh+RpxmAt4lp/w9wO3NccTU3L/dxP7kHvr+rkD28WwViEyEF+rTYSvKX45uxJ4TsOI0GzV43y+q0I=@vger.kernel.org
X-Gm-Message-State: AFuF++lzoxveVzHScEIB7X70e8wzFYwJtuEfixGUDLCKVrb92/lahHlg
	SPz4oAFnT5icRP2CK8RTGcrth2cZ3fqCDkAzXW/kcYAuxleUM4L6cr2lFM194+Wd0Ckc6DcZuI9
	wEJOs8+kZDs03QflV/Yd7uzuXSXZ0t6HPU1MwKICQ
X-Gm-Gg: AR+sD12jgJrHpTEW5JTveQJS2H+edrKtFHOtLBeNTQ03YipPACXhw2hPZHCwCmK+xmV
	oDH4D4/fJMnY+CAMfypLe//YrsEZuqenoID4AefVissrjE3emxi1ZZ5+4gzIsT/s1HaCjue9K/z
	Jo/wuTCJiBIzawNiXw7ZwUByjtoUgmBWLFHlM+146TT3Qzh5xKf8XsifwHZJqe4inQun47W7tq5
	rgVcIWsnHqm9jMhiVh41I/B0GWaBWJlMJlQvw2ML2mF3QtKg26Clpty7NQ4qKZ3Jb4diiT/40wx
	mwfg7UTJ2PyOQrWp1OF4hwEZTQU1n/sYIrfprvvzvJaRku9IOlYwC2J+1CpxUQcCcO3EyqxKG/8
	8un2o1536of7Kid4ro3Ay4KDugyW+Yj+YqdP2Bp9sdI4jRgQQ9khFEfTgqw==
X-Received: by 2002:a05:622a:2512:b0:530:4ed:c251 with SMTP id
 d75a77b69052e-53021b9e3b4mr18674631cf.12.1788188404846; Mon, 31 Aug 2026
 08:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a786da9-f9cb-4957-938d-51000793a4a8@mail.kernel.org>
In-Reply-To: <5a786da9-f9cb-4957-938d-51000793a4a8@mail.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Aug 2026 16:59:51 +0200
X-Gm-Features: AcwNN1Vj061KqWNnfn0-xipzLG7ZbvfYcBi0Wps-v1a38_YeDBMpkiOsYiD2FwY
Message-ID: <CANn89i+FVuGcPv=uBhYMrHfmMpkEnPTcLX=joWbZtBiqLSN-gg@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: Fix use-after-free in rxrpc_destroy_all_peers()
To: syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, Marco Elver <elver@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-afs@lists.infradead.org, 
	Marc Dionne <marc.dionne@auristor.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, horms@kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:41=E2=80=AFPM syzbot <syzbot@kernel.org> wrote:
>
> From: Marco Elver <elver@google.com>
>
> During network namespace teardown, rxrpc_destroy_all_peers() iterates ove=
r
> the rxnet->peer_hash table to print leaked peers. However, it does so
> without holding rxnet->peer_hash_lock. This allows a race condition with
> asynchronous peer destruction, where RCU callbacks concurrently remove
> peers from the hash table and free them. When rxrpc_destroy_all_peers()
> accesses the freed peer, it results in a KASAN slab-use-after-free.
>
> BUG: KASAN: slab-use-after-free in rxrpc_destroy_all_peers+0xcc/0x150
> net/rxrpc/peer_object.c:461
> Read of size 8 at addr ffff88811089e420 by task kworker/u8:1/13
> Call Trace:
>  <TASK>
>  rxrpc_destroy_all_peers+0xcc/0x150 net/rxrpc/peer_object.c:461
>  rxrpc_exit_net+0x7f/0xc0 net/rxrpc/net_ns.c:114
>  ops_exit_list net/core/net_namespace.c:199 [inline]
>  ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:252
>  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
>  process_one_work kernel/workqueue.c:3322 [inline]
>  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
>  worker_thread+0x92d/0xe10 kernel/workqueue.c:3486
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> To fix the slab-use-after-free, acquire rxnet->peer_hash_lock with
> spin_lock_bh() while iterating over rxnet->peer_hash in
> rxrpc_destroy_all_peers().
>
> Additionally, insert rcu_barrier() in rxrpc_exit_net() prior to destroyin=
g
> peers and local endpoints. Without rcu_barrier(), rxrpc_destroy_all_peers=
()
> races with pending RCU callbacks that drop peer and local references,
> logging spurious leak warnings. Furthermore, this missing synchronization
> causes a downstream panic hazard in rxrpc_destroy_all_locals() because
> in-flight peer releases leave rxnet->local_endpoints populated. Calling
> rcu_barrier() ensures all pending RCU callbacks that drop peer and local
> references complete prior to leak checks and local endpoint destruction.
>
> Fixes: 17226f124038 ("rxrpc: Fix leak of rxrpc_peer objects")
> Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
> Reported-by: syzbot+c876adfab6362679008c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc876adfab6362679008c
> Link: https://syzkaller.appspot.com/ai_job?id=3D7fecbeb2-cd9b-4ca2-8149-4=
8663e20b153
> Signed-off-by: Marco Elver <elver@google.com>
>
> ---
> diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
> index 9a9834145..c00cddfd3 100644
> --- a/net/rxrpc/net_ns.c
> +++ b/net/rxrpc/net_ns.c
> @@ -111,6 +111,11 @@ static __net_exit void rxrpc_exit_net(struct net *ne=
t)
>         timer_delete_sync(&rxnet->peer_keepalive_timer);
>         rxrpc_destroy_all_calls(rxnet);
>         rxrpc_destroy_all_connections(rxnet);
> +       /*
> +        * Wait for pending RCU callbacks that drop peer and local
> +        * references to avoid spurious leak warnings and panics.
> +        */
> +       rcu_barrier();

Hi Marco.

This rcu_barrier() is a pretty big hammer as you might guess.

Please ask your LLM to use pre_exit method in truct pernet_operations
rxrpc_net_ops
(split existing rxrpc_exit_net(struct net *net) in two parts)

pw-bot: cr
