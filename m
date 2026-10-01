Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695037647E;
	Thu,  1 Oct 2026 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863691; cv=none; b=Q/H/kh21Xd/wBORINWE9KeElOqE6JfPGk2J+bf2wNRCZIsVuqz9zE0VdQwo9lsExCGWpOlUQ1qthkcIKHCODLboOMgroVFHAy3bKKVFB8vZI6FWFoiT0n8F6ddwZRwcZoOmz244Etf7uUeGuGKMpjNYQNVibOE5e3HfqoE4/yGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863691; c=relaxed/simple;
	bh=YEvxetxiBD5KlpUHoVwMhRCr5/UkCyZdgIlew8p94/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFOqk3JmC0/xigv3oiwFAeoR6XpiTizcBigNoCzG0CkQV88H3WLehgVA7m+w+onk9QGgoje3uLRBZAqcGRrtIwKrNo6g8JFraneT34aTeHvR4FqjAekaMBjqNVJKCyuC42LcL5XpC35roHJlUYY2dvmy7RQmgVB/3JqMedJRTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dMe+P8wD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dMe+P8wD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=w6
	r0Ih/Jax+oLq723IEwu/TgDW7NY7VgQM2fxXf25cQ=; b=dMe+P8wDEw5Sa0HrlP
	Eku0eiw9ZVKU3LQwxhxhCC05L0Muca777Y7UiOAj96EMS1gBlUylhoP/NMTpbQFw
	ECru/BbtXxt4rswnZzbmLEdm8T7u5ZC4dg71XzxkT4HV9Eevvx1Vgh/CgQEA4osJ
	yZAGIceudWMfezVuAwTHDH8sM=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHfbzIaL5q5hvbBw--.36121S2;
	Thu, 01 Oct 2026 22:06:17 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: netdev-bot+sinfo@kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH net v4] net: stmmac: fix error path cleanup in DMA descriptor ring allocation
Date: Thu,  1 Oct 2026 22:06:00 +0800
Message-Id: <20261001140600.1013202-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179082713968.31693.13138874201716710221@kernel.org>
References: <179082713968.31693.13138874201716710221@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHfbzIaL5q5hvbBw--.36121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWxXw47Kr17AF47Zw18Zrb_yoWxXr4Upr
	1Uta15ur4rXrn8JF4xtw1Yqa4DAF1UAayDJrsrKw17JFZrWr1UJr48Ar1jkrs5WFWUJF17
	A3WDWr1jqr1kZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEvtC5UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC9Bmaxmq+aNks9AAA3M

At 2026-10-01 11:58:59, netdev-bot+sinfo@kernel.org wrote:
>Hi!
>
>This is an automated message. This series looks like a fix, but its
>commit messages seem to be missing some information:
>
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

This issue was discovered during a stress testing scenario in the development process.

>
> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by code inspection). If it was triggered please include
>   the symptoms, like the stack trace or error messages.
>

The specific scenario triggering this issue involves performing `ifconfig down/up` operations
on a network device during an OOM (Out of Memory) condition. The call stack at the time of the
failure may like this:
[540776.647689] Call trace:
[540776.647691]  dump_backtrace+0x98/0xf8
[540776.647701]  show_stack+0x20/0x38
[540776.647704]  dump_stack_lvl+0xbc/0xd0
[540776.647719]  dump_stack+0x18/0x28
[540776.647723]  warn_alloc+0x138/0x1d0
[540776.647731]  __alloc_pages_noprof+0x4e8/0xfd0
[540776.647735]  ___kmalloc_large_node+0xb8/0x1a8
[540776.647740]  __kmalloc_large_node_noprof+0x34/0x118
[540776.647743]  __kmalloc_noprof+0x2d4/0x378
[540776.647747]  __alloc_dma_tx_desc_resources+0x4c/0x118
[540776.647753]  alloc_dma_desc_resources+0xd8/0x150
[540776.647756]  stmmac_setup_dma_desc+0x118/0x270
[540776.647759]  stmmac_open+0x30/0xe8
[540776.647762]  __dev_open+0x108/0x1f8
[540776.647767]  __dev_change_flags+0x1d4/0x268
[540776.647770]  dev_change_flags+0x2c/0x80
[540776.647773]  devinet_ioctl+0x2dc/0x618
[540776.647778]  inet_ioctl+0x1d4/0x1f0
[540776.647781]  sock_do_ioctl+0x68/0x130
[540776.647786]  sock_ioctl+0x288/0x398
[540776.647788]  __arm64_sys_ioctl+0xb0/0x100
[540776.647795]  invoke_syscall+0x84/0x108
[540776.647801]  el0_svc_common.constprop.0+0xc8/0xf0
[540776.647805]  do_el0_svc+0x24/0x38
[540776.647808]  el0_svc+0x38/0x120
[540776.647813]  el0t_64_sync_handler+0x120/0x130
[540776.647816]  el0t_64_sync+0x190/0x198

[540776.648028] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[540776.648031] Mem abort info:
[540776.648033]   ESR = 0x0000000096000006
[540776.648035]   EC = 0x25: DABT (current EL), IL = 32 bits
[540776.648038]   SET = 0, FnV = 0
[540776.648039]   EA = 0, S1PTW = 0
[540776.648041]   FSC = 0x06: level 2 translation fault
[540776.648043] Data abort info:
[540776.648045]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[540776.648047]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[540776.648049]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[540776.648051] user pgtable: 4k pages, 39-bit VAs, pgdp=00000013c6eed000
[540776.648053] [0000000000000000] pgd=08000013b0800003, p4d=08000013b0800003, pud=08000013b0800003, pmd=0000000000000000
[540776.648063] Internal error: Oops: 0000000096000006 [#1] PREEMPT_RT SMP

[540776.648145] pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
[540776.648147] pc : dma_free_tx_skbufs+0x108/0x1b8
[540776.648151] lr : __free_dma_tx_desc_resources+0x2c/0xb8
[540776.648154] sp : ffffffc0bc5f3610
[540776.648156] x29: ffffffc0bc5f3610 x28: ffffff83e4a2c600 x27: ffffff87de595a00
[540776.648162] x26: ffffff87de8a8000 x25: 0000000000001003 x24: ffffff83dcc26000
[540776.648168] x23: 0000000000000000 x22: ffffff87de8a8a00 x21: 0000000000000000
[540776.648174] x20: 0000000000000000 x19: ffffff83dcc26100 x18: ffffffc0bc5f2f20
[540776.648179] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe62e994454
[540776.648185] x14: ffffffe62e994440 x13: 0a64656e6f73696f x12: 7077682073656761
[540776.648190] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffffe62d20dc4c
[540776.648196] x8 : ffffffc0bc5f34c8 x7 : 0000000000000000 x6 : 0000000000000001
[540776.648201] x5 : ffffffe62e41c000 x4 : ffffffe62e41c600 x3 : 0000000000000000
[540776.648207] x2 : 0000000000000000 x1 : ffffff83dcc26000 x0 : 0000000000001000
[540776.648213] Call trace:
[540776.648215]  dma_free_tx_skbufs+0x108/0x1b8
[540776.648217]  __free_dma_tx_desc_resources+0x2c/0xb8
[540776.648219]  alloc_dma_desc_resources+0x104/0x150
[540776.648222]  stmmac_setup_dma_desc+0x118/0x270
[540776.648225]  stmmac_open+0x30/0xe8
[540776.648228]  __dev_open+0x108/0x1f8
[540776.648231]  __dev_change_flags+0x1d4/0x268
[540776.648234]  dev_change_flags+0x2c/0x80
[540776.648236]  devinet_ioctl+0x2dc/0x618
[540776.648240]  inet_ioctl+0x1d4/0x1f0
[540776.648243]  sock_do_ioctl+0x68/0x130
[540776.648246]  sock_ioctl+0x288/0x398
[540776.648248]  __arm64_sys_ioctl+0xb0/0x100
[540776.648252]  invoke_syscall+0x84/0x108
[540776.648256]  el0_svc_common.constprop.0+0xc8/0xf0
[540776.648260]  do_el0_svc+0x24/0x38
[540776.648263]  el0_svc+0x38/0x120
[540776.648267]  el0t_64_sync_handler+0x120/0x130
[540776.648270]  el0t_64_sync+0x190/0x198
[540776.648274] Code: 54000389 f9449262 93797eb4 937d7eb7 (f8746843) 
[540776.648277] ---[ end trace 0000000000000000 ]---
[540776.681767] Kernel panic - not syncing: Oops: Fatal exception

Alternatively, a simpler method to reproduce the issue is by injecting a fault
through stubbing `alloc_dma_tx_desc_resources`.

> - What hardware the change was tested on. For driver fixes please
>   mention the device (and if relevant firmware version) used for
>   testing, or say that the change was not tested on real hardware.
>

This modification was tested and verified on an in-house developed SoC
platform (featuring Synopsys XGMAC).

>Please do not repost the series just to address the above. Instead,
>reply to this email with the missing information, so that reviewers
>can take it into account. If the series needs another revision for
>other reasons, please include the information in the commit messages
>then.
>
>The evaluation is done by an LLM so it may be wrong, if you think
>that is the case please reply and explain.

