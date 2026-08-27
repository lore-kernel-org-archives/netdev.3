Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32072DE70D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834517; cv=none; b=h9E/I7urBJBKWNRkqyOKwfZpaTu25Y7rEXePaDev+rs8CkIgvIo14vg71+4vGq8LSma17LZhYC1Ms7ytseFEKCiBzhdTfkUliJIens20Wvl8Yk6etesV8WfLS62twYF2DxANN/Nhx7+7uGFAs+u3BtYyWHYDCpUTUKOO1SlGwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834517; c=relaxed/simple;
	bh=zkZbpzJ/hTqBLL/12FtKBo9jG1YH5wjhTJdGirG3RIc=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=p9vwRVEEE9361VWEOddmRZdsIOa+SLSSR9jfoei8k0ZOps3tMd48rl1lnPO5YRBZhWOkL7alkMXebztqL9OYR8Z8unIkRF9ZXKh9dS6svhDnSCUBISn9nz9kpWSsuftJGM+jfT2oIMZUgQr0MZ1YO/K4m2Benp1nmD2ZFceSQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=NnoEx2bw; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=aE22PJEq; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="NnoEx2bw";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="aE22PJEq"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834515; x=1788439315; bh=Fe5mwI+uyadpwilkS/
	Ud1QcG+ym0QNHsLruGoVJ0/pE=; b=NnoEx2bwj+Xm1PubbVqWUkvcx20yyDjcqjINW3l5W50Lw
	U5I4iMUpWbdJ3nGpi+70CisClRE6zT6kQ3+snK5XIzZ5Vm15t1JpU4cimt3vcrBjplDXxsXNeGD
	Rk8ZJDUyPsSQCUozRuwz3cu475zMhFXxT1h/cqSdopw/WLMoU3VC1vumVpYNnH1F5AfETJMlBnA
	Sn8GPLid9OVmLMlYIJRJKZRwspke2YWlfCvZNP0U3XvYxzHNlhy5VtOp152lVreXeiC8mLwIlsU
	m1qsxADicwz19xjRuXlHD/0k8KFfw++tb/9KsDcuF3yl6EkbwNseRqfBs338AxVYMG37W27Q==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834515; x=1788439315; bh=Fe5mwI+uyadpwilkS/
	Ud1QcG+ym0QNHsLruGoVJ0/pE=; b=aE22PJEq3eFNkLqOsQOqozHaY8rf3sbmWq6Aia4OD6MB4
	vbmCpFSn0NFobTbvZWyg/jzFWTOmUFv+mO628aGSdagqAdWcTkTqzmmgx5wqlyF3SBBslnh5f/E
	QNAlyE345Bzl+eiToNmyU1dDDYoRCPkpD0yz9z4u+Wz72hioAZZevIw5qdRU8AcElLMkzDOalQn
	FHOWWE2ui1SeXQwMgO4MhqIcmRZJjSTcqrGfpZ7EQFdTty4kMvTOnWy7E1tNr1sozX7xT2Pd8BO
	Li0JayBQjwPZL/n0Q7MuF/rfb7gKmUOUj8ZwMZkRGITEyWT4pb0dYnMilPspAEuBn/RPjqGg==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+28eef7d8af9428e6@bugs.sh>
Message-ID: <jH6u350kaBRuqklDjd3k3BW4nWzp0tYRjq3p@bugs.sh>
Date: Thu, 27 Aug 2026 12:41:49 +0000
Subject: [BUG] net/dsa: out-of-bounds in crc32_le()
To: netdev@vger.kernel.org, "Florian Fainelli" <florian.fainelli@broadcom.com>, "Jonas
 Gorski" <jonas.gorski@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 =?utf-8?b?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    net/dsa
    crash   out-of-bounds in crc32_le()
    commit  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfiguratio=
n throttling")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+28eef7d8af9428e6@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/28eef7d8af9428e6/patch.diff
        report.md   https://bugs.sh/b/28eef7d8af9428e6/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfi=
guration throttling")
    VM setup       https://bugs.sh/b/28eef7d8af9428e6/run.sh
    config         https://bugs.sh/b/28eef7d8af9428e6/config.gz
    poc            https://bugs.sh/b/28eef7d8af9428e6/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in crc32_le (lib/crc/crc32-main.c:38 lib/crc=
/x86/crc32.h:22 lib/crc/crc32-main.c:74)
Read of size 1 at addr ffff8880131a4fc0 by task exploit/148
CPU: 0 UID: 0 PID: 148 Comm: exploit Tainted: G S 7.2.0+ #63 PREEMPTLAZY
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
crc32_le (lib/crc/crc32-main.c:38 lib/crc/x86/crc32.h:22 lib/crc/crc32-main=
.c:74)
brcm_leg_fcs_tag_xmit (net/dsa/tag_brcm.c:343)
dsa_user_xmit (net/dsa/user.c:942)
dev_hard_start_xmit (./include/linux/netdevice.h:5429 ./include/linux/netde=
vice.h:5438 net/core/dev.c:3937 net/core/dev.c:3953)
__dev_queue_xmit (net/core/dev.c:4926)
packet_sendmsg (net/packet/af_packet.c:3110 net/packet/af_packet.c:3142)
__sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discrimi=
nator 1) net/socket.c:2281 (discriminator 1))
__x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 148:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_slab_alloc (mm/kasan/common.c:340 mm/kasan/common.c:366)
kmem_cache_alloc_node_noprof (include/linux/kasan.h:253 mm/slub.c:4584 mm/s=
lub.c:4917 mm/slub.c:4989)
kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
__alloc_skb (net/core/skbuff.c:715)
alloc_skb_with_frags (./include/linux/skbuff.h:1384 net/core/skbuff.c:6786)
sock_alloc_send_pskb (net/core/sock.c:3012)
packet_sendmsg (net/packet/af_packet.c:2959 net/packet/af_packet.c:3053 net=
/packet/af_packet.c:3142)
__sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discrimi=
nator 1) net/socket.c:2281 (discriminator 1))
__x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff8880131a4d00
which belongs to the cache skbuff_small_head of size 704
The buggy address is located 0 bytes to the right of
allocated 704-byte region [ffff8880131a4d00, ffff8880131a4fc0)


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


