Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5236683B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612605; cv=pass; b=tt9HtoNBWtVtbz0uSG8qlXDKRcety5e8LJlPUveRj0BbZpzGZUBsg7TABnhnmMaSeB96Gijrdmc6iDj9Xnm5n3/UeYV9iXMZIcvmCBXlmUAGpxZbqMIZk+szEjRnl85s2fPC8ujlnydwUwhYeQYcfqkE160K+M7DxaunwwbkoQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612605; c=relaxed/simple;
	bh=KFoouBEoh+uW86XcJd+UZdk3TebKZrvQ+qmS9LC6dTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FldyNE6LOyaMXLRT1Uh2BhrUVvkKEzbxbdnl4g2zXe7OHELXm5onHdHcFzH6fqPOU4iGzP84VkECmgDZnhg2kkuBhDBKGB5W0VpYlKs43gDhhaY9qKO9+B4uXu27fTlYpi0Oc2ra/PmRfMqnpWkC2V0FYKAjGLbOQ0Hw3LjBMOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=O/GbSBHu; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="O/GbSBHu"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4d9197so218605e0c.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789612592; cv=none;
        d=google.com; s=arc-20260327;
        b=QAdBm/cbjmFUdZodr/mqn6Xo2L6+FOnfkKhphu8j3acAMOY1DzndqKP7WWC7RQwvOd
         i0j27PCqGpCqkn1gko3TYOiXp5H7p0spMvOQtdQ2CqOKFs1LVuX1li09bAhxzJSE8pSy
         i8LYFXf9Ou6jO0FgxMN2k1CheOn48SdQAlKBLQFLh2EhfxC6o3rFDwsGXsb89Pr73rkq
         tX6beslssS3DuhtdhqhLikAu/wKp/pLC36HFhEAKaUWPrnN2d2OSmUZDCIljSo2drEF0
         URXoVnvsxRP4tB82M3EWd6cuFryBkISuLbMJuzpc54YtuNXiGpy1dTVF+I1RgYpliQwT
         iF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tQ6AEV+sre/jT0COFkT5OPJwURRK0cuFSk9SrCDKSfg=;
        fh=TalG078Q1jqUdgsq67+XFGDDLl6rFC4ulKDlvnOPdZc=;
        b=W7grmuOgASFGBpWw3/MN/G8OCNorls3fy6cPpY/4ZIBWNK59qKM0ZTa6rkyUrX5EIh
         o6bFdnzhcskDnGX25rCc72LLA/re2JdO/lQWIvDlB7pTAoUesfQfZJtg2j6HBIKW5pM9
         ASdlCdWIHglLPReGiKpwI5Sj90E39UKsasGu12d1cTHoxU1z3bQIRVHM8GDbA9tDGVkK
         2Y7qx1z+KOtFZ6tr4rrr+amswulrd/hc6GAF1kopbNEO0rPsfg7Vi/X2iK1A8ezz0x6q
         Gke6/ec6Hggf1YrP6eEw1/QW/rlMRt3SC9NeBJ2nqef3hkwVV3mrDHuAQqzp4WXTS+cT
         BFMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1789612592; x=1790217392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tQ6AEV+sre/jT0COFkT5OPJwURRK0cuFSk9SrCDKSfg=;
        b=O/GbSBHuYvRoT0rEzzr6xK6x4y2vUtKeFbQ0clb0swF3u11QodQYaRw7Q3uZ75N/J4
         D16/mWeRCI/sWa9ZtiHxuu864qzudheMRyH1OkRGorM8amnTEQU0hd2zf3e458Kej/sl
         MsvsvQT0Gz9ZM9Ceq7wyrZqdddI6JnDH0lqe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789612592; x=1790217392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQ6AEV+sre/jT0COFkT5OPJwURRK0cuFSk9SrCDKSfg=;
        b=Vysa3cDvJA4AYuxVUOyKZgutbw0z1mkqhhLSGfg9XNVIRfAdUGSulObKzEYqugpoPS
         99WLWhDPdbK1Cc4Fmt2fkExBzwxNbPxdzb35hKABfbrj/aRGqK1mgPJYnr8lRbCxZzxF
         UvRwrZWjB3MQq6nMG6iJbDumoHmOQ7Ccnmn35EryqBsi15iry+stkJ6JFwxqVt8kJ3In
         +tNLkEHw4awBEzDhASEyDz7vTRG+W3VYcGdWGSTbWEqxA3xb8GZ7iJS7tn411VfMh96o
         cjSqMrHHrvKRUjhq9/vcRUgp1HuHUA40LOPlC/7dG73/1Jsjqm/GPF8kwMESaPsJ1M8O
         trpw==
X-Gm-Message-State: AFuF++miBm81k4qZdID/24n6yy6mXhP0aRTOQDTo8l08wU3AepU2kWX3
	cc44Fl8xTuz6lndtq9rVdbig5R85vmpHqqLGCGUvlV5Ca7O02KL4HwHUi33v8lGOTKHuP/lwTVc
	No8flTHRrEMg0ze6S4SgPhzM+1786ja8in8LQpNq3XtIjHrCmMsO7esTVAw==
X-Gm-Gg: AYBFou3CZrgvTzuM4YRNxaMear/xj3wLYcwulHYUaC1hFtRsSZnBWK9vcY3RWjFm/su
	TA8thJOD5HAUKOZdVEnDaJjB+W5dTgnRUDxOzvnEhUnAZvrZLBoBGodsl2zsJiQQQYJjr2h3cvW
	Y+O99GTzaiN3Q7u52elgjL3BTTBVwK/j3HZqxKMHvoJAcdPY8guw/zSabvn59LDAoNLc7OgiS26
	rtovXDN23PKU2fnxUSYNre09s3CwplhKc6WrzMgX+OeKf8vr1UN8EgJzIRfISchej4fPWoXI38n
	MxGQwbRCrqKpLxbCEeLdO/oTWJRdv+AVDoldCHFj0psjxWh1nIJ8REqwFQ==
X-Received: by 2002:a05:6122:2221:b0:5c8:36a6:ddd0 with SMTP id
 71dfb90a1353d-5c9a62c415fmr572925e0c.6.1789612591679; Wed, 16 Sep 2026
 19:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
In-Reply-To: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 16 Sep 2026 23:36:21 -0300
X-Gm-Features: AcwNN1UOMBnnX6yxvdEoPMD6HzLNvtDDNUO0W_2RcWqzvqH3H9lFb8WsCFj9rFw
Message-ID: <CAPhRvkxuibHUSuRcoz-X-i1mEvGb5huU+sd9D-8m6j-BaczLbw@mail.gmail.com>
Subject: Re: [BUG] rxrpc: Client connection leak and BUG() call during kernel
 IO thread exit
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Jeffrey Altman <jaltman@auristor.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

I have just triggered this again on the latest kernel on Fedora Server
44. I used the same reproducer provided here a few months ago.

[  316.661038] rxrpc: AF_RXRPC: Leaked client conn 0000000053e6ed6e {1}
[  316.661063] ------------[ cut here ]------------
[  316.661064] kernel BUG at net/rxrpc/conn_client.c:64!
[  316.661080] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  316.661087] CPU: 4 UID: 0 PID: 1351420 Comm: krxrpcio/7001 Not
tainted 7.2.5-200.fc44.x86_64 #1 PREEMPT(lazy)
[  316.661097] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 03/24/2025
[  316.661106] RIP: 0010:rxrpc_purge_client_connections+0x55/0xa0 [rxrpc]
[  316.661147] Code: 48 83 bf 28 01 00 00 00 74 22 31 c0 48 8d 74 24
0c 48 89 cf 89 44 24 0c 48 89 0c 24 e8 24 d7 fa c1 48 85 c0 0f 85 0f
ed 01 00 <0f> 0b 31 f6 48 89 cf 48 89 0c 24 e8 7b a3 fc c1 48 8b 0c 24
85 c0
[  316.661160] RSP: 0018:ffffc90007fdfdf8 EFLAGS: 00010246
[  316.661167] RAX: 0000000000000000 RBX: ffff8880121cd000 RCX: 00000000000=
00000
[  316.661174] RDX: 0000000000000000 RSI: ffffc90007fdfda8 RDI: ffff8880121=
cd120
[  316.661180] RBP: ffff888022054000 R08: ffffc90007fdfdd8 R09: ffff8880121=
cd128
[  316.661186] R10: ffffc90007fdfda8 R11: 0000000000000000 R12: ffff8880111=
92dc0
[  316.661192] R13: ffff8880121cd000 R14: ffffc90007fdfe80 R15: ffffc90007f=
dfe80
[  316.661198] FS:  0000000000000000(0000) GS:ffff8880f546a000(0000)
knlGS:0000000000000000
[  316.661205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.661210] CR2: 00007f2fccc551a0 CR3: 0000000003c2c004 CR4: 00000000007=
706f0
[  316.661236] PKRU: 55555554
[  316.661241] Call Trace:
[  316.661247]  <TASK>
[  316.661251]  rxrpc_destroy_local+0xd5/0xf0 [rxrpc]
[  316.661296]  rxrpc_io_thread+0x600/0x6e0 [rxrpc]
[  316.661323]  ? __pfx_rxrpc_io_thread+0x10/0x10 [rxrpc]
[  316.661349]  kthread+0xe4/0x120
[  316.661356]  ? __pfx_kthread+0x10/0x10
[  316.661362]  ret_from_fork+0x1a1/0x270
[  316.661367]  ? __pfx_kthread+0x10/0x10
[  316.661372]  ret_from_fork_asm+0x1a/0x30
[  316.661379]  </TASK>
[  316.661383] Modules linked in: rxrpc ip6_udp_tunnel libdes
udp_tunnel krb5 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject sunrpc nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables qrtr rfkill binfmt_misc intel_rapl_msr intel_rapl_common
intel_uncore_frequency_common intel_pmc_core pmt_telemetry
pmt_discovery pmt_class intel_pmc_ssram_telemetry
intel_pmc_pwrm_telemetry intel_vsec rapl vmw_balloon vmxnet3 i2c_piix4
i2c_smbus joydev dm_multipath zram lz4hc_compress
vmw_vsock_vmci_transport vsock vmw_vmci xfs nvme nvme_core vmwgfx
nvme_keyring nvme_auth drm_ttm_helper ttm ata_generic pata_acpi
serio_raw fuse scsi_dh_alua scsi_dh_rdac i2c_dev scsi_dh_emc
[  316.661476] ---[ end trace 0000000000000000 ]---
[  316.661493] RIP: 0010:rxrpc_purge_client_connections+0x55/0xa0 [rxrpc]
[  316.661534] Code: 48 83 bf 28 01 00 00 00 74 22 31 c0 48 8d 74 24
0c 48 89 cf 89 44 24 0c 48 89 0c 24 e8 24 d7 fa c1 48 85 c0 0f 85 0f
ed 01 00 <0f> 0b 31 f6 48 89 cf 48 89 0c 24 e8 7b a3 fc c1 48 8b 0c 24
85 c0
[  316.661548] RSP: 0018:ffffc90007fdfdf8 EFLAGS: 00010246
[  316.661556] RAX: 0000000000000000 RBX: ffff8880121cd000 RCX: 00000000000=
00000
[  316.661565] RDX: 0000000000000000 RSI: ffffc90007fdfda8 RDI: ffff8880121=
cd120
[  316.661573] RBP: ffff888022054000 R08: ffffc90007fdfdd8 R09: ffff8880121=
cd128
[  316.661579] R10: ffffc90007fdfda8 R11: 0000000000000000 R12: ffff8880111=
92dc0
[  316.661829] R13: ffff8880121cd000 R14: ffffc90007fdfe80 R15: ffffc90007f=
dfe80
[  316.662027] FS:  0000000000000000(0000) GS:ffff8880f546a000(0000)
knlGS:0000000000000000
[  316.662208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.662387] CR2: 00007f2fccc551a0 CR3: 0000000003c2c004 CR4: 00000000007=
706f0
[  316.662618] PKRU: 55555554

On Wed, Apr 1, 2026 at 1:19=E2=80=AFAM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> Hello,
>
> I have identified a reliable way to trigger a BUG() in the RxRPC
> protocol at rxrpc_destroy_client_conn_ids(). This occurs because the
> kernel IO thread can exit while there are still active connection
> objects registered in the local IDR (local->conn_ids).
>
> I did a quick analysis and the result is the following. When the IO
> thread exits, it calls rxrpc_destroy_local(), which in turn calls
> rxrpc_clean_up_local_conns(). However, that function only iterates
> over the local->idle_client_conns list. If a connection was recently
> created by rxrpc_connect_client_calls() (via
> rxrpc_alloc_client_connection()) but has not yet been deactivated or
> moved to the idle list, it is completely missed during this cleanup
> phase.
>
> Because the connection remains in the IDR, the subsequent call to
> rxrpc_destroy_client_conn_ids() finds the entry, logs an "AF_RXRPC:
> Leaked client conn" error, and hits a BUG().
>
> I can reliably reproduce this using a client and server where the
> server calls close() immediately after sendmsg().
>
> My suggestion for a fix is to update rxrpc_clean_up_local_conns() to
> check the local IDR instead of just the idle list, ensuring all
> allocated connections are reaped during teardown. I don't have the
> time to properly test a patch or verify if the teardown for a
> brand-new conn differs significantly from an idle one, so I wanted to
> report my quick analysis to the maintainers. I tested on Fedora 43 on
> kernel 6.18.
>
> 420 void rxrpc_destroy_local(struct rxrpc_local *local)
> 421 {
> ...
> 433         rxrpc_clean_up_local_conns(local);
> ...
> 451         rxrpc_purge_client_connections(local);
> ...
> 453 }
>
> 813 void rxrpc_clean_up_local_conns(struct rxrpc_local *local)
> 814 {
> 815         struct rxrpc_connection *conn;
> ...
> 823         while ((conn =3D list_first_entry_or_null(&local->idle_client=
_conns,
> 824                                                 struct
> rxrpc_connection, cache_link))) {
> 825                 list_del_init(&conn->cache_link);
> 826                 atomic_dec(&conn->active);
> 827                 trace_rxrpc_client(conn, -1, rxrpc_client_discard);
> 828                 rxrpc_unbundle_conn(conn);
> 829                 rxrpc_put_connection(conn, rxrpc_conn_put_local_dead)=
;
> 830         }
> ...
> 833 }
>
> 54 static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
> 55 {
> 56         struct rxrpc_connection *conn;
> 57         int id;
> 58
> 59         if (!idr_is_empty(&local->conn_ids)) {
> 60                 idr_for_each_entry(&local->conn_ids, conn, id) {
> 61                         pr_err("AF_RXRPC: Leaked client conn %p {%d}\n=
",
> 62                                conn, refcount_read(&conn->ref));
> 63                 }
> 64                 BUG();
> 65         }
> 66
> 67         idr_destroy(&local->conn_ids);
> 68 }
>
> [88656.300130] rxrpc: AF_RXRPC: Leaked client conn 00000000cf1d5a14 {1}
> [88656.300702] ------------[ cut here ]------------
> [88656.301099] kernel BUG at net/rxrpc/conn_client.c:64!
> [88656.301442] Oops: invalid opcode: 0000 [#17] SMP NOPTI
> [88656.301765] CPU: 0 UID: 0 PID: 3989526 Comm: krxrpcio/7001 Tainted:
> G      D W           6.18.13-200.fc43.x86_64 #1 PREEMPT(lazy)
> [88656.302039] Tainted: [D]=3DDIE, [W]=3DWARN
> [88656.302323] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [88656.302599] RIP: 0010:rxrpc_purge_client_connections+0x58/0xa0 [rxrpc]
>
> Regards,
>
> --
> Anderson Nascimento
> Allele Security Intelligence
> https://www.allelesecurity.com



--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com
