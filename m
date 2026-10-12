Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107943D0BE1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834981; cv=pass; b=hBO9haS1XZ2ve1dp6b/m1yE0BGi7ZT04yn85gVPPh5iAjkzlnT8SJ58Sp7uw+IRMi2PuSCI2Iihuhg4otNCWTkiAao0GekblwLA++ItIBQvXCe4ltkUq29rQ9KJmv2HSFqZTkFMLWZLUxZfT9yd6JOCG/4Zpm8aY4U2oo80YMGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834981; c=relaxed/simple;
	bh=nhEv4JUB9vCpQw4diAcOu7NdETPA5c2kiRkcyJ3lhf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIukaNPPB4xzY1aSwbuPXF8YdW7lnSvP7wASkEhpM2XMz6iAzHBj0mA9LyZzDc4zqSGlVsV3bjbblLl0LkNlqGSO5AJUSPT/71kV+JaMFVblcoliC/GiYo9Bl3LbGjaNieDqyjTSEaMbybzrRdcfRoiSfX0egoFzgLcALVTbde4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVgilZGO; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVgilZGO"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1438d9363fbso571727c88.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834979; cv=none;
        d=google.com; s=arc-20260327;
        b=CdLHP4j5u8JM3IQf1Eb71W+CHaDuPGCsaZrFsfp2puaDxDWTrTatpOhoPDUJQVpLOC
         8R1WthbDkRY9tIMOSeg4oXk5s8sy+1yaUz9iLIlzxrQ8foxsYkFXu4CrjJGjQhMh7IYS
         gFI5c0FmJ7Gpqic1xPqzv7FhzIhqowV3HszvygHngJuqNbKreYmXhYXPt5yVimzNNrbW
         i4JE5Yjc6bW1JDokGFrk2QuSC2XIptiLCC9cjhfEm5jGzOVcxZIt1f+JMCwx8K2PoHWj
         jb+uC+GKeVYM6SX/s54C0Ozy/nS1/0awp3OUcONYhgvrQB25NgwXIE/B/kDpOj6dnfQC
         1hRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JxV16LcQ0Po5kaTO3n+WFwSYzxfnwNS+UY3ZW/oeJgg=;
        fh=a0aao9DKP+CoIs3kKH07ScZRoRA+6V4FxwA35OQ8nwU=;
        b=WB5FWDIbsw3LbQTmhH/U/TLvfczuVxVCAdFrITd7fpMkNW88rYiJScY1NBJH23Ontb
         9+/jKqJ95CfGuhdB/GWaWVmwxDa9ShDi5cdtbBpIzvisL0BeT5m/VfuXNXYck2AxAQZj
         pZFWvhgrMXJ3VSM4lRJjC9AI9VoIUC16RYkO+P/8N4EQPL4VUhk6d3TPWXTDD6F8fiXK
         n/PcVt6rXek1hku5houRSSRD7jOwWMWIngwo6LHtwq/ZIudw81RddP3rNYB4/I+FtTQ/
         UqS8BKFKLRfkyJVMCCpIy/F34qx6RsGFPxt3owKt3YbXuh5rL70QaUOycuwKq9kDhL1e
         uMRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834979; x=1792439779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxV16LcQ0Po5kaTO3n+WFwSYzxfnwNS+UY3ZW/oeJgg=;
        b=ZVgilZGOrL+klLm968H5QyPZOFM0raB8sRTS+pHSQoiZy16QpKEp+EUGdBTnV5Gqy7
         qSQp28cZTDJdb+unCbeICR9lhsAlW0grG6tCOVtPEAMHy87fAfzgij/jJNvkP6D8xY0r
         2NIhOzf1Uc/wL3VLspZI3sCElJypveu2HnuT099C7V2OpJ/MMo5fpU3e8ggCLFwrW+V6
         +/qqz7Ryn8mTfGecQ2rLlljbuoQSxK3y2pFFhMwOh6Y8gmaceEIf7IPMcDLNjlrre+8N
         vqrmdfTFFiQivlBgdTFSzh7aWlWKnENpw1/Qg61v1KCv38EcYM7KD5LwMP6gO+QctE3p
         nn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834979; x=1792439779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxV16LcQ0Po5kaTO3n+WFwSYzxfnwNS+UY3ZW/oeJgg=;
        b=m2mI409IMXHoY8fb9OsfgJfP077A9IgN7NeUBZzcBtVRxnRpQPWria6xC9GEKLOgXt
         jZ1d3VqlVlUE/L+4jKXtbq/sBIDfEzr1eS9wk7WJzBJlJBHhS1c+Rs7vdB1h6TPhYQye
         mx31UwnI6qZF8NmDUex9XAd/mKYxJWXQhatDSu+xA/eEUBUP2TGVRatvuh0yurr0fjQO
         ZVWAOgKqvgDxeQxJgB9kq7Jmx0zZwo17TtMMnyaMmQmIKB+zr7UgSYOYRQloWAdKG5v0
         zABfNnS7Rf35mMBL6bTKUp2hQkRXOHwPbpAZY73gWH2Jg3XnibsBfEJcmK/A6YpcEX3+
         MxZA==
X-Forwarded-Encrypted: i=1; AKwUvBwnc3io6B7CNS0UDnnUGXXKxj6VKQMfXKB0sdGHkTxPMUn9+5klAXYvP7ubPyTPk1RVM208ZDQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/qKB7M5lIdzidCBz0W/YRZThDLoIcj6iFaSCXhf443NUor08N
	rYxWwFytyMxw36ZyeJ57XTAHUx5uZwisQB6m2mR88t8mwhYUEF8HgWN/HOVtWMur5sqKsVDE+Jh
	t1A+1PSW1EuT2qyr/6ptxOk3DFZn/43UrK3Oqe6fv
X-Gm-Gg: AYBFou0yyvdnzTUA0SXyKG9T2/56a4lojwqyypKWuHi3cfjHlaLt58Sf2NUVDLUDlsO
	jpg8TKjKovUSKID9iWUP9xBtTGp0v//k96gSAoGHjtEfBRbtQympmBuE2zUboUkhFee0JKzfBrD
	npenO8ayJdZOF/jAYccnn+O+txFLoFa1smOpJ+HtQ4r2w5qOCTR59EWIcSGk4gYzqhbrIIngXFE
	7UNh6EuMyylSeMi4MAZbtwqk5wpLbZsEy+KNbdhXy5TqoeWdJnB32C+SyQAn6GNikNmJ18YVksz
	2BjIOViPoZJaOknBbDBGsuYx0KlZrKXi2QS9b5nhGiu1wSqFtXTMpGowGmcpsaEO+3xzrxLAZYa
	Br1FNKAWgL2IUlfIE6RM/5mNLKIm52W8yNaK77icI0fMSlJtEH/6DkVi9bNUaKc7LiwVok5sIW1
	fGoEEKZOSYIgwNk/nD19Xlrw==
X-Received: by 2002:a05:701b:4242:20b0:14b:355e:2888 with SMTP id
 a92af1059eb24-16a160f503emr14876338c88.27.1791834978217; Mon, 12 Oct 2026
 12:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ip-core-objects-candidate-0001-v2-efc0e8a00d4f22c36ab8@gmail.com>
In-Reply-To: <pm-ip-core-objects-candidate-0001-v2-efc0e8a00d4f22c36ab8@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 12:56:06 -0700
X-Gm-Features: AclHuK_rgUU3gmYD-NO5eHHKADH8wtZEDHsy1aVPpDpAy99kmxwZDrbvIM-M048
Message-ID: <CAAVpQUAHHZS+NyXwtc8z2TGVUDJvC23JCrY9ghvwzqOw6ZYzxQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: Keep the SCTP provider alive through socket allocation
To: Cen Zhang <zzzccc427@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, fmancera@suse.de, willemb@google.com, 
	kees@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com, 
	Chengfeng Ye <nicoyip.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 9:42=E2=80=AFPM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> The sctpv6_prot slab must remain alive through socket allocation.
> inet6_create() selects that proto under RCU, but drops RCU before
> sk_alloc(). sk_prot_alloc() obtains the owner reference only after
> allocating from the slab.
>
> SCTP publishes its IPv6 stream and seqpacket entries while its module
> is still COMING. A concurrent user socket can select an entry before
> register_pernet_subsys(&sctp_ctrlsock_ops), sctp_v4_add_protocol() or
> sctp_v6_add_protocol() fails. The subsequent initialization unwind
> removes both entries and destroys the cache without waiting for owner
> references.
>
> After the constructor captures the cache pointer, initialization can
> fail and destroy the cache before the allocator consumes that pointer:
>
>   User socket creation              SCTP module initialization
>   --------------------              --------------------------
>                                     publish IPv6 protosw entries
>   select sctpv6_prot under RCU
>   drop RCU
>   capture prot->slab
>                                     fail a later setup step
>                                     sctp_v6_protosw_exit()
>                                       unlink both entries
>                                       synchronize_net()
>                                       proto_unregister()
>                                         destroy slab cache
>   kmem_cache_alloc(saved slab)
>
> The allocator can then read retired cache metadata and fault. The grace
> period drains lookup readers, but the constructor has already left RCU.
> An early owner reference alone cannot prevent initialization failure
> from destroying the cache, since try_module_get() accepts COMING.
>
> The initialization-failure path follows from source inspection. The
> Oops below came from an unload experiment using a modified kernel with
> allocator bootstrap changes, scheduling instrumentation and SCTP's
> internal control socket omitted. With that socket present, its owner
> reference blocks ordinary unload. The experiment selected and captured
> the same cache that teardown destroyed; the seqpacket constructor then
> faulted before the allocator returned.
>
> Reject user SCTP sockets while the owner is COMING and take a temporary
> owner reference under the lookup's RCU protection before dropping RCU.
> User allocation then requires completed initialization, and the
> reference prevents normal module exit until sk_alloc() takes the
> socket's own reference or fails. Release the temporary reference in
> either case. Keep kernel control socket creation allowed during init,
> where SCTP's per-net registration orders construction and cleanup.
>
> KASAN report as below:
>
>     Oops: general protection fault, probably for non-canonical address
>     0xffff11036c3d1430: 0000 [#1] SMP KASAN NOPTI
>     KASAN: maybe wild-memory-access in range
>     [0xfff8a81b61e8a180-0xfff8a81b61e8a187]
>     CPU: 2 UID: 0 PID: 532 Comm: sctp-race-fixtu Not tainted
>     7.2.0-rc5-pmb-ipcore-functional-v2+ #1 PREEMPT(lazy)
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
>     1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     RIP: 0010:kmem_cache_alloc_noprof+0xd6/0x600
>     Code: 85 c0 0f 8e 93 04 00 00 44 8b 74 24 18 0f 1f 44 00 00 41 bf ff =
ff
>     ff ff 65 ff 05 b5 e6 0d 09 65 4c 8b 2d a5 e6 0d 09 4c 03 2b <41> 0f b=
6
>     45 30 84 c0 0f 85 11 04 00 00 41 c6 45 30 01 45 31 c9 41
>     RSP: 0018:ffff8881135dfcc0 EFLAGS: 00010287
>     RAX: 0000000000000001 RBX: ffff88810891ec80 RCX: dffffc0000000000
>     RDX: 0000000000000cc0 RSI: 0000000000000890 RDI: ffff88810891ec80
>     RBP: 0000000000000c00 R08: 0000000000000001 R09: 00000000000000bd
>     R10: 0000000000000028 R11: ffff888113e5ba00 R12: 0000000000000cc0
>     R13: ffff11036c3d1400 R14: 0000000000000000 R15: 00000000ffffffff
>     FS:  00007ff3c2206780(0000) GS:ffff88826b86a000(0000)
>     knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000055b973e7b10c CR3: 00000001158b5005 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? sk_prot_alloc+0x6f/0x2c0
>      sk_prot_alloc+0x6f/0x2c0
>      sk_alloc+0x37/0xb40
>      inet6_create+0x31b/0x1230
>      ? inet6_create+0x5a/0x1230
>      __sock_create+0x2c4/0x730
>      __sys_socket+0x141/0x210
>      ? __pfx___sys_socket+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? handle_mm_fault+0x12e/0x580
>      __x64_sys_socket+0x77/0xc0
>      do_syscall_64+0x115/0x6a0
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7ff3c231b437
>     Code: 8b 54 24 08 64 48 2b 14 25 28 00 00 00 75 05 48 83 c4 18 c3 e8 =
ba
>     a7 00 00 66 2e 0f 1f 84 00 00 00 00 00 b8 29 00 00 00 0f 05 <48> 3d 0=
1
>     f0 ff ff 73 01 c3 48 8b 0d a9 29 0d 00 f7 d8 64 89 01 48
>     RSP: 002b:00007ffed24e4ab8 EFLAGS: 00000246 ORIG_RAX: 000000000000002=
9
>     RAX: ffffffffffffffda RBX: 00007ffed24e4bd8 RCX: 00007ff3c231b437
>     RDX: 0000000000000084 RSI: 0000000000000005 RDI: 000000000000000a
>     RBP: 0000000000000002 R08: 0000000000000000 R09: 00007ff3c2413aa0
>     R10: 00007ffed24e4800 R11: 0000000000000246 R12: 0000000000000000
>     R13: 00007ffed24e4bf0 R14: 00007ff3c2444000 R15: 000055b973e7cd48
>      </TASK>
>     Modules linked in: [last unloaded: sctp]
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:kmem_cache_alloc_noprof+0xd6/0x600
>     Code: 85 c0 0f 8e 93 04 00 00 44 8b 74 24 18 0f 1f 44 00 00 41 bf ff =
ff
>     ff ff 65 ff 05 b5 e6 0d 09 65 4c 8b 2d a5 e6 0d 09 4c 03 2b <41> 0f b=
6
>     45 30 84 c0 0f 85 11 04 00 00 41 c6 45 30 01 45 31 c9 41
>     RSP: 0018:ffff8881135dfcc0 EFLAGS: 00010287
>     RAX: 0000000000000001 RBX: ffff88810891ec80 RCX: dffffc0000000000
>     RDX: 0000000000000cc0 RSI: 0000000000000890 RDI: ffff88810891ec80
>     RBP: 0000000000000c00 R08: 0000000000000001 R09: 00000000000000bd
>     R10: 0000000000000028 R11: ffff888113e5ba00 R12: 0000000000000cc0
>     R13: ffff11036c3d1400 R14: 0000000000000000 R15: 00000000ffffffff
>     FS:  00007ff3c2206780(0000) GS:ffff88826b86a000(0000)
>     knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000055b973e7b10c CR3: 00000001158b5005 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Kernel panic - not syncing: Fatal exception
>     Kernel Offset: disabled
>     ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM
>
> ---
>
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index a9b8b4b42a1af72f09fb9544b0e13aade00a1e3d..fb7f84baeeb66f5d3926169df=
790cc439f98224f 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -110,6 +110,7 @@ static int inet6_create(struct net *net, struct socke=
t *sock, int protocol,
>         struct sock *sk;
>         struct inet_protosw *answer;
>         struct proto *answer_prot;
> +       struct module *owner =3D NULL;
>         unsigned char answer_flags;
>         int try_loading_module =3D 0;
>         int err;
> @@ -169,6 +170,17 @@ static int inet6_create(struct net *net, struct sock=
et *sock, int protocol,
>
>         sock->ops =3D answer->ops;
>         answer_prot =3D answer->prot;
> +       if (answer->protocol =3D=3D IPPROTO_SCTP) {

Chengfeng Ye is working on the same issue, and this is not limited to sctp.
(see v3 for sctp)
https://lore.kernel.org/netdev/20261002173844.3537111-1-nicoyip.dev@gmail.c=
om/


> +               owner =3D answer_prot->owner;
> +               err =3D -EPROTONOSUPPORT;
> +               /* SCTP init can unwind despite an owner reference.
> +                * Allow the kernel control socket during initialization.
> +                */
> +               if (!kern && owner && module_is_coming(owner))
> +                       goto out_rcu_unlock;
> +               if (!try_module_get(owner))
> +                       goto out_rcu_unlock;
> +       }
>         answer_flags =3D answer->flags;
>         rcu_read_unlock();
>
> @@ -176,6 +188,7 @@ static int inet6_create(struct net *net, struct socke=
t *sock, int protocol,
>
>         err =3D -ENOBUFS;
>         sk =3D sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
> +       module_put(owner);
>         if (!sk)
>                 goto out;
>
