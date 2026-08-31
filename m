Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E61EEA3C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178898; cv=none; b=gpFHiSSspvd7gJliIcX1WAdcqkU0shu37hUdFxkK28vp+TayxmnnNJGclMLVTFHuNUF/qsS2vxPyKNB5l8+w5Sfdrh6qEdQzPyOYCKOkieC0RWJe8Jl89ejuJrgHNwMnrmzBVUBQEQKk8WqR/UjamYgCBnMju2BUKo+Slj7frLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178898; c=relaxed/simple;
	bh=pxmTHdNDxAKvcBdr0Q6BmU6L38qT0hqsMdwKCNqk3G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lt60ep60qSlMTEtC15JW9bhs3ug/VnCJA0l0vz+LRO59Eet/mUVgVqc3Kk+vz9/qYh/TwRQJtgcM8v0bw/8s0kq8UT0sia7cytb717vMHuJ0Bbb86nqEx2MQ7BSgA4bv4ISGAGN5dntFU6dsTQgUXTY2YB/1T69+UkTkKnsch54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRArplFE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dcjbItc/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRArplFE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dcjbItc/"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788178895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYe6x1OHER0WnkxSsk9czItmbLICuxMc5XkA5AmyP3c=;
	b=eRArplFEE+kE43qiQVn/siiJZ+YI9erjj+4AlWm2PeNTcc3jL+2fcndjFn6ZoTUhmf3VJR
	87YmBm6gHjQHn4EzJXNj280KycoiVIoFj6DHPjcn73zWc9zZ52fNlNWZU4Naka6rKvDkJB
	/BhL7B4kfiFQRbKsCQq2NmJAKiT2ai5Rb4LFEktkaUhA5lhrXlrs2KMJNqDrLc8pdAQZMX
	d7Fml7fj/Ol8aWpN6GIZ+y93AuT0xMcBRld9WWrxEDGqXGQ8ArXrC8oiNkl3yNShUHWkiA
	B7OaS4F0F/KQG9dxYkIgK5yGcuTM+rkwyjItnIP/3LSw+53G913LNY88ytuM9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788178895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYe6x1OHER0WnkxSsk9czItmbLICuxMc5XkA5AmyP3c=;
	b=dcjbItc/clzxwSH771gPKrb2oTjfE9/ZPvfv2uzukWlGbShvgRC+JV0IoVCqRSUwjY70ZP
	HwoZTvLB/Hz697BQ==
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
In-Reply-To: <5693c628-dffb-46c4-8f7c-5a5a6c101660@bootlin.com>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
 <20260817103337.74c30adc@kernel.org> <87mrujzzjv.fsf@jax.kurt.home>
 <20260818075335.48936b08@kernel.org> <87h5kq1s1f.fsf@jax.kurt.home>
 <20260820144528.7107ba90@kernel.org> <87y0e0x7ic.fsf@jax.kurt.home>
 <5693c628-dffb-46c4-8f7c-5a5a6c101660@bootlin.com>
Date: Mon, 31 Aug 2026 14:21:32 +0200
Message-ID: <87se3utr8z.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Fri Aug 21 2026, Maxime Chevallier wrote:
> Thanks for tackling this, let me know if you need testing. In the past we=
eks
> I've been looking deep in my drawers as well as on various online shops, =
and
> I'm starting to have a farily comprehensive set of stmmac-enabled devices
> (although I couldn't get my hands on XGMAC, AgileX5 devkits appear to be =
way
> outside my budget).
>
> Let me know if you need help in testing for this, and we can ask the Alte=
ra folks
> for some help in XGMAC testing.

Ok, I don't have a xgmac device either. Only stm32mp{1,2}, imx8mp and Intel
Elkhart Lake.

So, I've been looking into this TBS thingy and have a patch set for it. How=
ever,
there's one other issue which might be worth fixing first: When opening an
AF_XDP/ZC socket the kernel crashes rarely. Stacktrace see below. Seems lik=
e the
kernel is sending packets while the XSK socket is being configured.

Looking at stmmac_xdp_enable_pool(), there's napi_disable() and
stmmac_disable_tx_queue(). However, don't we miss something like
netif_tx_stop_queue() or synchronize_net()?

Also stmmac_enable_tx_queue() is of type void, but does memory allocations =
which
can fail. Shouldn't that function report the errors to the callers? ;-)

Thanks,
Kurt

Stacktrace on stm32mp2:

[ 1205.743707] stm32-dwmac 482c0000.ethernet end0: Register MEM_TYPE_PAGE_P=
OOL RxQ-0
[ 1205.746103] stm32-dwmac 482c0000.ethernet end0: Register MEM_TYPE_PAGE_P=
OOL RxQ-1
[ 1205.971709] Unable to handle kernel paging request at virtual address ff=
ff800083a2d010
[ 1205.971736] Mem abort info:
[ 1205.971741]   ESR =3D 0x0000000096000047
[ 1205.971747]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 1205.971756]   SET =3D 0, FnV =3D 0
[ 1205.971762]   EA =3D 0, S1PTW =3D 0
[ 1205.971767]   FSC =3D 0x07: level 3 translation fault
[ 1205.971774] Data abort info:
[ 1205.971778]   ISV =3D 0, ISS =3D 0x00000047, ISS2 =3D 0x00000000
[ 1205.971785]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[ 1205.971793]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 1205.971801] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000008c5170=
00
[ 1205.971809] [ffff800083a2d010] pgd=3D100000008cb71003, p4d=3D100000008cb=
71003, pud=3D100000008cb72003, pmd=3D10000001066eb403, pte=3D00000000000000=
00
[ 1205.971847] Internal error: Oops: 0000000096000047 [#1]  SMP
[ 1205.971847] stm32-dwmac 482c0000.ethernet end0: Register MEM_TYPE_XSK_BU=
FF_POOL RxQ-1
[ 1205.971856] Modules linked in:
[ 1205.971869] CPU: 1 UID: 0 PID: 112 Comm: kworker/1:2 Not tainted 7.2.0-r=
c4-00002-g36d3d0252886 #3 PREEMPT_RT=20
[ 1205.971882] Hardware name: STMicroelectronics STM32MP257F-DK Discovery B=
oard (DT)
[ 1205.971888] Workqueue: mld mld_ifc_work
[ 1205.971916] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 1205.971926] pc : dwmac4_set_addr+0x8/0x20
[ 1205.971944] lr : stmmac_xmit+0x364/0x1950
[ 1205.971959] sp : ffff80008330b7f0
[ 1205.971963] x29: ffff80008330b800 x28: 0000000000000001 x27: ffff0000824=
20b80
[ 1205.971977] x26: ffff0000842ed500 x25: 0000000000000001 x24: ffff0000824=
20000
[ 1205.971991] x23: 0000000000000000 x22: 0000000000000020 x21: ffff000083a=
fd002
[ 1205.972004] x20: 000000000000005a x19: 0000000000000001 x18: 00000000000=
00000
[ 1205.972017] x17: 008f000100000205 x16: 003a160000000000 x15: 00000000000=
00000
[ 1205.972030] x14: 02ff0017899bdb57 x13: 001789ff01000000 x12: 00000000000=
002ff
[ 1205.972043] x11: 0000000401000000 x10: 1816008f00010000 x9 : ffff800080e=
52c6c
[ 1205.972057] x8 : 80fe010024000000 x7 : 0060dd86ccd4e37a x6 : 00000000000=
00000
[ 1205.972070] x5 : ffff00007ae3405a x4 : 00000000ffffffff x3 : ffff0000873=
a0020
[ 1205.972083] x2 : ffff800080e5e3a8 x1 : 00000000fae34000 x0 : ffff800083a=
2d010
[ 1205.972098] Call trace:
[ 1205.972107]  dwmac4_set_addr+0x8/0x20 (P)
[ 1205.972123]  dev_hard_start_xmit+0xa8/0x300
[ 1205.972143]  sch_direct_xmit+0x9c/0x1f0
[ 1205.972157]  __dev_queue_xmit+0xb08/0x10e0
[ 1205.972168]  ip6_finish_output2+0x3b0/0x900
[ 1205.972189]  ip6_finish_output+0x1bc/0x370
[ 1205.972203]  ip6_output+0x88/0x1f8
[ 1205.972217]  NF_HOOK.constprop.0+0x54/0xf0
[ 1205.972234]  mld_sendpack+0x1c4/0x3a8
[ 1205.972247]  mld_ifc_work+0x1e0/0x420
[ 1205.972261]  process_one_work+0x164/0x4b0
[ 1205.972280]  worker_thread+0x194/0x318
[ 1205.972293]  kthread+0x138/0x150
[ 1205.972308]  ret_from_fork+0x10/0x20
[ 1205.972333] Code: 8156bd00 ffff8000 aa1e03e9 d503201f (f9000001)=20
[ 1205.972349] ---[ end trace 0000000000000000 ]---
[ 1205.972363] Kernel panic - not syncing: Oops: Fatal exception in interru=
pt
[ 1205.972371] SMP: stopping secondary CPUs
[ 1205.972393] Kernel Offset: disabled
[ 1205.972397] CPU features: 0x00000000,00000008,00040000,0400421b
[ 1205.972404] Memory Limit: none
[ 1206.253642] ---[ end Kernel panic - not syncing: Oops: Fatal exception i=
n interrupt ]---
E/TC:0   Panic 'Watchdog' at /usr/src/debug/optee-os-stm32mp/4.0.0-stm32mp-=
r1-rc9/core/drivers/stm32_iwdg.c:228 <stm32_iwdg_it_handler>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmqVccwTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgqp4EACVY/D7ERi+v1aw1Xod0RAUPrDTjzjw
5oCeWoGKUpe3V9tf46nAxG18B91zQKXVEbWveTf3QPUGqcPXvZ/HxjxdzXxKXLLf
W6OrkYSXdfWw82fFjIfhyVo6gtOZwfq+PXSxWx4Md6uNzBcomoUb5G5Xy/j7p3d9
UftKw2FTI7zAo5ETWB7Zj/vNQ8RttZe3zaZf5fxEkSSeBTi/eMFPMyApGLD7ze3I
4wtEyTP6lGCIbM1jub9Rm1guvJBqdv/ELdo0tOj/puMovWEM/bd2UXHGIv7Fz1p0
5Cnch6x+e5qK5FEYkBdsMaT+pR+u6HrAwdZT8WsxAkI3/9+hrKbgNtuc05E4pbmB
SA+zdrBm5yN1n3kK7yDB9lWZiSOiWouo2zDH/Mlubjq4mBGpfDK/UH4H/8tz8v5c
nsBRKCIp7ZfwsAzfafCyAQxrOOa/ocQE/dAQIXWe+e27YXdCL/dOObE1DPeJLEvl
Gm1xwtZUo2qKiWGULFY19MkEORc1lo+UQtHhAP30RSsP1n15mMHotlQeeGn/sV+o
ILSNLXBh6u6SU4oWg4jAdOsA8xYomjoy6hOO1zrOm1q25/6HVQCiPZb0/NEOfmyw
ZD5UxEQFEz35EdnesHJhpRY+n5N1FXwj9cZt90XkV2xLqpcz4ZiZRDM06RnqqYJJ
VMzItdCR51uA0w==
=8XmC
-----END PGP SIGNATURE-----
--=-=-=--
