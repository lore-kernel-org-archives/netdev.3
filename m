Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679443CAA49
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066995; cv=none; b=m32BSdu7qYDabp+j3H6Imw8wzXyMbvY6lVVKAC+oF/yOjzM4aqSxHps1LP+bLbMK+PcO5sZbi6wiUoeT1qQDDkbvcXQXw/Heh5vBx6DwgtR8RCZaMMCOA8EgHsJwq5SSd9bWyEg3/MQQ6O4YFIJmznOySWYvFRuazqqjd2nIK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066995; c=relaxed/simple;
	bh=TgNasWwDbcJXHGmUtH86NitPAbH898schrr4zZKneGg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qc1bZE2GfAEVVHHvQpmGWoT/lMz7QPG0sx4aQylLQtK5LiQhgli+kYVGfeHbnPpdHCs9waXxB4ASZ37lc1QE+1gTHsjPYZ112gJa4oHYej56w5CRD7mUpGz0wb7csQIQ2TVXL0N+PYqwmi6fuMKsuHuzSRUlvBWNKjCzWE3VG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz6t1790066909t34c89566
X-QQ-Originating-IP: K6y/XmCc7WK3M+jd+w8VnqpMCSi8XkweJb3Djgkk/ec=
Received: from smtpclient.apple ( [115.205.193.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Sep 2026 16:48:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16857174221905166129
EX-QQ-RecipientCnt: 11
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v6] net: Wangxun: protect ring accesses with RCU
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260921170509.3f471b54@kernel.org>
Date: Tue, 22 Sep 2026 16:48:16 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com,
 jacob.e.keller@intel.com,
 richardcochran@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE54C737-C413-4A44-A27B-55040D41B1FD@net-swift.com>
References: <20260915065731.6007-1-mengyuanlou@net-swift.com>
 <20260921170509.3f471b54@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OYY1qefrNk1aUY2rVUEQCV1w2dPuQyVIuI/4BwPwBfpF93dPYjjDk0F1
	7C1+H7bij2OTczBGGY13QDFNC7YQ90Bl7KNzkHdZ0y0E/CghrnZz1wmtbyrmdPh7e/4y1He
	i0XaD/00B2cj4J80UyzLAx8v5CfSXJAkSutgNwx1IHezkq9xYGGLKU58ZYW7anh5Qc7YeFp
	qCOblXSX2cNjm/JkFfhDkZB/l3rzPxgkzVu6KnNAnHoshbo2EZnYnftgy6DfMGHyW0LC3CE
	2IG0siPGHizjgD/YtXMrAcShEpAq+2ZFDvBRbKnR1m3MKlgGV+7uZ9Thv2oXPzZKeYmKA9N
	x69YekWD7tdhBZobqdaHUMAkbIlo3MzQgoEcSfuwvMYgdSfesY4hrU42Hsx/iuz6oLl/bfP
	fGKWGW2SwZe2zQBeRHpbHJFhptYBkmdW5ngfz/srbMuxiL0PQr16sQD6M/ESutXbspvN7Re
	rppjFJfxFDOxRgxHxWt2A6mPjxoRzUTfEFR0Bwaz9UG+NpOsOAuOI7Ul1nngXGYmBnVk4Wr
	3pQBRHY6rPFLOdcS/rDJvz6f5sjZ2ABftrzCMfuYPJaSc5fJcF5xX7jpNE1NGFb8+oIgsAr
	C6IqBWKvdH01YNe7sCs8NPL4FCKsVFkS8Z4fXHJdCIgs7yEW3cfsgoK4nl1MBFv236DWiSZ
	KhLuMTv2GD744AZdMusm5uasLkrf6gyRwV4CS6u6R58Z4l7L1oUQ+HszI/LN3QqxatpIJmP
	8H1kl+7IB7/p5INApDu9/SZAfZyW6DOil6e4ZTFUkLvZFaRzCE8qpIRlcZJvOWqtuJoUx7W
	R3LttcHsHIkV5mKdTAAt0EG1BnWXRn2yLdRh3IYX4a5JbCiqj3bPGHF850XUhUp6SAwYcWo
	uF075W4lPtRAen4IiqFeUka0yCLe/1C1qWSyhHvPTznkrcrH1upkDf3sKmLRB6vfJtUqZ0t
	LwMvTB3gFSjP42ZTw6Pt/a+5x9kO4An/AgCA7mSR5CSxfCgnVqca45vjfEKfcGNfYmxaPAr
	HZrDVUKPnsTgo+T5o1YJShRpUOAhLyUjZDAvB+UDLMTL6dY+qjSo6ygz++9UCu23Jwreqjf
	RqQMmDzM/3eEh4UrAKlyaNECTva6w5SRQ==
X-QQ-XMRINFO: NI4Ajvh11aEjENrZhaU8/McKWNRU4Of8nA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8822=E6=97=A5 08:05=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 15 Sep 2026 14:57:31 +0800 Mengyuan Lou wrote:
>> - wx->tx_ring[i]->count =3D new_tx_count;
>> + rcu_dereference_protected(wx->tx_ring[i],
>> +  lockdep_is_held(&wx->reset_lock))->count =3D
>> + new_tx_count;
>=20
> Do you really think this is acceptable code formatting?
>=20
> Plus I quite clearly asked you to add a helper:
> https://lore.kernel.org/all/20260915184127.25de623e@kernel.org/

>=20
>> @@ -1797,7 +1801,8 @@ static void wx_set_rx_buffer_len(struct wx *wx)
>> * the Base and Length of the Rx Descriptor Ring
>> */
>> for (i =3D 0; i < wx->num_rx_queues; i++) {
>> - rx_ring =3D wx->rx_ring[i];
>> + rx_ring =3D rcu_dereference_protected(wx->rx_ring[i],
>> +    lockdep_rtnl_is_held());
>=20
> And also to use:
>=20
> /**
> * rtnl_dereference - fetch RCU pointer when updates are prevented by =
RTNL
> * @p: The pointer to read, prior to dereferencing
> *
> * Return: the value of the specified RCU-protected pointer, but omit
> * the READ_ONCE(), because caller holds RTNL.
> */
> #define rtnl_dereference(p) \
> rcu_dereference_protected(p, lockdep_rtnl_is_held())
>=20
> Please, this is not rocket science. Pay more attention to what you're =
doing,
> this sort of change should not require 10 revisions.

Hi,
Sorry about that. I=E2=80=99ll fix both issues in the next revision and =
make sure to
address the previous review comments more carefully.
Thanks.

Another question:

wx_init_interrupt_scheme() =E2=86=92=20
wx_lib.c:2392 wx_cache_ring_rss() =E2=86=92=20
wx_lib.c: rcu_dereference_protected(..., lockdep_rtnl_is_held())

When wx_init_interrupt_scheme is in xxx_probe, unlike other =
txgbe_setup_tc
and ngbe_resume, at this point the netdev has not yet been registered.

+rtnl_lock();
err =3D wx_init_interrupt_scheme(wx);
+rtnl_unlock();
if (err)
goto err_cancel_service;

At this point, rntl_lock is merely used to address RCU_LOCKDEP_WARN.
Is this approach appropriate?


> --=20
> pw-bot: cr
>=20

