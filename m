Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C232F7AD2
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825838; cv=none; b=hFluM7GySlLmWC0MVuG+hhBRzj2soBuXyar/tyusQotwvVxHOVm6gKf3JXF7wnVVcrOSGtmCosdbmPWYKE6EYPB4ts3JiWnp2c6gkTCPfqJvye7kzDLxY5EarsxP3gunc6C+wWYI4ujhu73rew8FrdLfSA9hCwpZXMetk/uLVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825838; c=relaxed/simple;
	bh=kqkVnzp1PtcwnXw/XvpqNWMT9yU+MgdWV317x2EvHbA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eJ/jRUWpGRceDyBYnrg/vwOzxSn5Vrv5eCrQvvirNbFnsVYiHvYtR9FRA8exjxw4FPyK0AcmUO9GAfs39vY5wVaX5Saf5LoNOyCFiNs5gQSIObiRsnl6Ym5McPB4JWuVkbzwtQj4cIQwdDE0dEj6S1LlStxrzRWuVV9tnIK7UmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz21t1787825772tce932078
X-QQ-Originating-IP: DuolrXRpRYk9X8sV3nNtFKmUcLkWPHwLDMaUQ3QXO/c=
Received: from smtpclient.apple ( [122.233.170.62])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 18:16:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8418775501427314855
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v3] net: libwx: protect ring accesses with RCU
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260826153412.GE22033@horms.kernel.org>
Date: Thu, 27 Aug 2026 18:15:54 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <86BE7746-4418-4B69-A6D6-091EC9418E70@net-swift.com>
References: <20260824103606.303-1-mengyuanlou@net-swift.com>
 <20260826153412.GE22033@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M7UMH0JKJBc4Lk3IFWjYv0uVyrFZzDu9v8WqwSXIaaS6hBybjIXP/OQS
	aWbT0RpuZNq8WM747mgQO4NduOHzTJP0ib4M9ji133gnE9hIgNsGowSeOrX5UKl5OT3h6Fb
	g9MCU8iJWPIE1fhhHpqRkM3PhBzUJE/5o3hLjbBiuRO/lgLFA0DMGaIM13hRjCa0Og9LM30
	2kyllXnrGIxp3ARkq3x/ajfZ2EbtAftJXL6C3HobzFg2YggV1wiq3JUxux/MkQ1oFw3rGYY
	POcLUYVyHahp/SdtArITZ5RQkjkC78C3PjP1QFCiZFtByWEnups4YgqEGyVQ6MX7nRW25zL
	rPaBkyzavG5QMDW5tYnkfKtZRtdHUQczM+6Esgbell+WFigCSO/oj9U3MN9rPeDQrkU1awg
	0ak6ajIEvzImIbfoemYwG9SgP89OjehlV9eYl4HhpKvFFJAv7YIbDn1ETtz3hHZABzJUEBf
	noAMRs4G10CBHyjc9YQTSN+QoJxeTYIlXvsnWJjI8CLdLJ7glYqHeO2G3b42aXg9Aj8e31A
	hOyUBq0zDUSk55Y1Rk2a7F3q7IDCzkDLU/T/PFHeufZQcvQeBz1EvDYv3NLJkz6nryhg9MO
	sgTDwoDAQYzYuNDa1na60aFRHQXLPYicyYJSPwq/P4EFqJDUTdUgGcA/TnUcKZe14jji/GH
	ypHW88ZSmzchjeA5L2NgysNjruwRyGvAKYOy6DA4kjeo5ymDKIoqfTgkl32kvpX/7KmZb2o
	lMwnhqrw3XX+fvO0DYpqflvARry4y2dW2sd+sZ0Hmxu/NM521ohXsuuih1EPD1wgz/81Rk6
	ZEHBLhgUzUfB6GD1wYHEWyjNIn7XygwcJEZWenrEvanBhA65KdpZ8KEuxIf6dOgMNxzlKVt
	ka792SKJE4BeW6X8okzebECiLRkk+ksIoGpMKLYgv8knB5RZmIm9FznE8iRWN8NCaoTuDgp
	w++o1Xe4pFyR+rjw4ZJYARM38zIyUXtC/yLPiSdcAoUTbRUUKtZfLP9wfDZRiGnYMusXBsu
	leaBpSiVl9DeujFES1TEGcEO3LTjiQdIYacmcxDnZtJMU+x6zl+9BgKhgBtJK4lmTLi2cBa
	8k5o9eEymcQk3jI8msYoRkQofYcIiLU00zKXoRAFrsEi9YBcUrVT37J/tml6t80tYjnoqMZ
	+Vsa
X-QQ-XMRINFO: NS+P29fieYNwGszJ5bcOABDF4IceLkWABw==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B48=E6=9C=8826=E6=97=A5 23:34=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Aug 24, 2026 at 06:36:06PM +0800, Mengyuan Lou wrote:
>> During queue teardown or channel reconfiguration (e.g. via ethtool =
-L),
>> ring pointers in wx->rx_ring[] and wx->tx_ring[] can be cleared to =
NULL
>> and freed asynchronously via kfree_rcu().
>>=20
>> Concurrency between interface reconfiguration and background tasks =
(such
>> as service tasks or dev_get_stats) can result in NULL pointer =
dereferences
>> or Use-After-Free (UAF) issues when accessing per-queue structures.
>> Specifically:
>> 1. wx_update_stats() accesses per-queue Rx, RSC, and Tx rings without =
RCU
>>    read-side protection, and lacked NULL checks in the RSC =
accumulation
>>   loop.
>> 2. wx_update_xoff_rx_lfc() walks wx->tx_ring[] and modifies =
ring->state
>>   without RCU protection or NULL checks, risking a kernel panic when =
flow
>>   control pause frames are received during queue teardown.
>> 3. Queue status checks in wx_err.c and PTP watchdog in wx_ptp.c =
dereference
>>   ring pointers without RCU read-side critical sections or NULL =
checks.
>> 4. Queue assignment in wx_alloc_q_vector() used plain stores without
>>   release barrier semantics needed for lockless RCU readers.
>>=20
>> Fix these by:
>> 1. Enclosing queue statistics gathering in wx_update_stats(),
>>   xoff processing in wx_update_xoff_rx_lfc(), error handling in =
wx_err.c,
>>   and PTP status checks in wx_ptp.c inside
>>   rcu_read_lock() / rcu_read_unlock() sections.
>> 2. Replacing unprotected accesses with rcu_dereference() and adding =
NULL
>>   checks when traversing wx->rx_ring[] and wx->tx_ring[].
>> 3. Using rcu_assign_pointer() when publishing or clearing ring =
pointers in
>>   wx_alloc_q_vector() and wx_free_q_vector().
>>=20
>> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> Changelogs:
>> v3:
>> - Replaced READ_ONCE() with rcu_dereference() when reading __rcu =
annotated
>>  rx_ring and tx_ring pointers to fix Sparse static checker warnings =
and
>>  enable Lockdep runtime validation.
>=20
> Hi Mengyuan,
>=20
> As you may be aware the change above has introduced a large number of =
new
> Sparse warnings (~50). However, I believe that the approach taken here =
is
> correct and those warnings do not reflect bugs added by this patch.
>=20
> So I would like to suggest that they should not impede progress of =
this
> patch. And that, rather, as a follow-up an audit is conducted of them.
> Any latent bugs can result in patches for net. And non-bugs can be
> addressed as follow-up for net-next.


Thanks for review.

Originally, I planned to use WRITE_ONCE and READ_ONCE.
And sashiko suggest that rcu_assign_pointer() and rcu_dereference().

=
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260813095141.88227-1=
-mengyuanlou%40net-swift.com
----
The ring is initialized with plain stores just above this publish (dev,
netdev, q_vector, count, queue_index, plus syncp and the stats union =
from
kzalloc_flex()), and the consumers read the pointer locklessly:
wx_update_stats() after this patch and wx_get_stats64(). On a weakly =
ordered
CPU, can a reader see the published pointer before those initialization
stores, and accumulate stale slab contents into wx->non_eop_descs and
friends?Given that the free side is kfree_rcu(q_vector, rcu), would
rcu_assign_pointer() here (and rcu_dereference() plus __rcu annotation =
on
wx->tx_ring[]/wx->rx_ring[] on the read side) express the intended =
protocol
more directly than the READ_ONCE()/WRITE_ONCE() pair?
=E2=80=94

It is actually always be used in arm/riscv/sw CPU.=20


=
https://sashiko.dev/#/patchset/20260824103606.303-1-mengyuanlou%40net-swif=
t.com

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h =
b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 2eba5ab599252..ec75ca1169796 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1359,8 +1359,8 @@ struct wx {
> u32 tx_ring_count;
> u32 rx_ring_count;
>=20
> - struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
> - struct wx_ring *rx_ring[64];
> + struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
> + struct wx_ring __rcu *rx_ring[64];

Does adding the __rcu annotation here cause Sparse warnings in other =
parts
of the driver that still access these pointers directly?


For example,
in =
drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:wx_get_ethtool_stats(): =20=

=E2=80=94- Rtnl_lock protect it.

ring =3D wx->tx_ring[j];In =
drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_xmit_frame():
tx_ring =3D wx->tx_ring[r_idx];
=E2=80=94- Fast Path / Datapath

in drivers/net/ethernet/wangxun/libwx/wx_hw.c:wx_vlan_strip_control():
struct wx_ring *ring =3D wx->rx_ring[I];
=E2=80=94- wx_configure path

Since these accesses don't use rcu_dereference_protected() or
rtnl_dereference(), could they generate "incorrect type in assignment"
warnings from Sparse, even though they may be safely serialized by other
locks?

To slove these warnings cost a lot.
Should I use rcu_assign_pointer() and rcu_dereference()?
Or fallback to WRITE_ONCE and READ_ONCE.


>=20
>> - Wrapped wx_update_xoff_rx_lfc() with its own rcu_read_lock() and
>>  rcu_read_unlock() section to ensure self-contained protection =
regardless
>>  of caller context.
>> - Extended RCU read-side critical sections and NULL pointer checks to =
other
>>  background tasks accessing ring arrays, including =
wx_ring_tx_pending(),
>>  wx_detect_tx_hang() in wx_err.c, and wx_ptp_rx_hang() in wx_ptp.c.
>> - Updated commit message to accurately reflect the use of =
rcu_dereference()
>>  and the expanded scope of protected functions.
>> v2: =
https://lore.kernel.org/netdev/20260818100841.37483-1-mengyuanlou@net-swif=
t.com/
>> - Moved rcu_read_unlock() after wx_update_xoff_rx_lfc() in =
wx_update_stats()
>>   to ensure flow control processing remains fully protected within =
the RCU
>>   read-side critical section.
>> - Replaced WRITE_ONCE() with rcu_assign_pointer() when assigning and =
clearing
>>   ring pointers in wx_alloc_q_vector() and wx_free_q_vector(), =
providing
>>   proper release memory barrier semantics for lockless RCU readers.
>> - Added __rcu annotations to tx_ring and rx_ring in struct wx =
(wx_type.h) to
>>   align with Linux kernel RCU coding standards and fix Sparse =
warnings.
>> v1: =
https://lore.kernel.org/netdev/20260813095141.88227-1-mengyuanlou@net-swif=
t.com/
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
>=20

