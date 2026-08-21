Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789CA353A62
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293291; cv=none; b=mAcM47isQtPE0yRWeAAOuHqWU5eCwyJIsfAx7RkLfrmEQMH/sTE3Dy45fbje67WBblTxtu/crre2mm6uEomMWd8/tA+fb3oIopoPapAMocX+7a1yMQQvMNEGthiPr5SATn0lDI/MJN2IGkvDADIER/p/rLJWvfkGAQ8oUTSaFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293291; c=relaxed/simple;
	bh=U0QE2IDuNHPuNfEw0+p6zidkFr+oU8fdFdaadHjxcRU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nICagItRX2FLPRDBVi3HBuWmAScaPgX1Ne6E7IwWSsQl161S8GNzbHMlN3MV7spOo3ABG31KC6uwG5OLfE7iJVtrnEP3GZtnMiiOEuQ65a85n1KYhIzhg7BhIbGX+u21NjTtDEkb572L0gAuDGD/rabu5x9hE3p+pZWFt+q3hWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz9t1787293226tf9ce771b
X-QQ-Originating-IP: ctJMPy7LiFAxILBXFJyUnaI55XsaVWrKhPUm+q0TxFM=
Received: from smtpclient.apple ( [61.175.160.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 14:20:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6812197540765051863
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v2] net: libwx: protect ring accesses with RCU
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260820182943.GD265046@horms.kernel.org>
Date: Fri, 21 Aug 2026 14:20:13 +0800
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
Message-Id: <A9F3596F-27BC-46C4-8C74-B8589BF4F330@net-swift.com>
References: <20260818100841.37483-1-mengyuanlou@net-swift.com>
 <20260820182943.GD265046@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OQvGGvC8Jm/iXgh1Ln1hgJfMhDHTQJapIoL5RRLQ/w52W3uunLUZrxY5
	bodHZcTCLK/eYnIW6CW9q1w8LKyaVU3DecWxzAhKZ34a7dNX1dO43xw2CVKX/N/1DRl0onZ
	BD01c5zYnQDGrwJvlUVWyortxylIKCJNIAzhYxzrZzifQXi4f1QhbNEx46Kn2TqE5awI5Pp
	8FZPy/9GnzL7H7PiZvoJK17hjLgZxQzKcDHk3tAqBZpOdwd/NacZt0VLG55PaV4FmC1MwY5
	TE/my4DN9+FNJxAgkeFS1Cq4v+pXynLYVpaxV6LYbSX4mPmBstXCHawhoGtxbF7CAbxMvpC
	mhHBZh/CvtBuq0berHslb10E3NCneHxKpMc8Y2vYPpwsBQzB7RFFA7NabTdJJopjmjzF3Sk
	VefZsDXPGA0gstZLOKJutjXoqumm6RltykAjHNuXQ7Wsr+GcCoDPask3OSEfZ8zOYmI8HWl
	HdDnx6oZ9uvVlERC8luj/esnKnpgSQUlz559vryt9z/XTt7jJ98NQwdjKi1RnWDWu1/qm0D
	1LXdOeaf6XkteU8rBMoysjbp6h92boE+VO88sGRw5gnCYidOrDfvkbMhnQgzioxgetL5g8/
	7JqsyUW5MjXEi6GE2GAuXrTVaD9hXOxt/gnuaSAt5+ekIjvbAlh6W2Q9LVrtRst2zaTd6fJ
	IWTtUu9v3hTT7Sq69J9EZgrsxZUyYmwNnCl0jzF0S/DzrJe4/VmFH6B/RkIJifXl0xN+r/+
	QFfZ3e/1BBBwqWLxgAlc/2/iisw7YHF3V69i6/SBPkGdcLteongSXnIG/gwYY+lLa0bFkiW
	lDzEt9pqJYlerUl6H6LpFrqU+2k0VuflRoWh/5vfvJ1d1sHD0kDu74V1Z56nvnsuSnIzxDx
	7knI0+kKKesdJlNLbNktKWjDssO4UxqtE2QYYqV2nBAScEx0Iq/1TKL6HhIJTgKD/qjqCGi
	IJv/V1u37D5mRSfpiBtsuGrpGVm6xwNeIjL8jXGWLm22hNML5CQAwKdRgc5kOKYR9sW/2Em
	7T6uNbKkTmEuZczN8eEx6EqRzAkfoBTcLqJEK9WHE+8qvfsMMxRzyBrQsLmThScuqKMZq2o
	QTKcOKlUXknfrYE0ju/JkI=
X-QQ-XMRINFO: MSVp+SPm3vtSAK0vc9/6p91805vGRESrUw==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B48=E6=9C=8821=E6=97=A5 02:29=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Aug 18, 2026 at 06:08:41PM +0800, Mengyuan Lou wrote:
>> During queue teardown or channel reconfiguration (e.g. via ethtool =
-L),
>> ring pointers in wx->rx_ring[] and wx->tx_ring[] can be cleared to =
NULL
>> and freed asynchronously via kfree_rcu().
>>=20
>> Concurrency between interface reconfiguration and background tasks
>> (such as service tasks or dev_get_stats) can result in NULL pointer
>> dereferences or Use-After-Free (UAF) issues when accessing per-queue
>> structures. Specifically:
>> 1. wx_update_stats() accesses per-queue Rx, RSC, and Tx rings without
>>   RCU read-side protection, and lacked NULL checks in the RSC
>>   accumulation loop.
>> 2. wx_update_xoff_rx_lfc() walks wx->tx_ring[] and modifies =
ring->state
>>   without RCU protection or NULL checks, risking a kernel panic when
>>   flow control pause frames are received during queue teardown.
>> 3. Queue assignment in wx_alloc_q_vector() used plain stores without
>>    release barrier semantics needed for lockless RCU readers.
>>=20
>> Fix these by:
>> 1. Enclosing queue statistics gathering and wx_update_xoff_rx_lfc() =
inside
>>   an rcu_read_lock() / rcu_read_unlock() section in =
wx_update_stats().
>> 2. Adding READ_ONCE() and NULL checks when traversing wx->rx_ring[] =
and
>>    wx->tx_ring[] in wx_update_stats() and wx_update_xoff_rx_lfc().
>> 3. Using rcu_assign_pointer() when publishing or clearing ring =
pointers in
>>    wx_alloc_q_vector() and wx_free_q_vector().
>>=20
>> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> Changelogs:
>> v2:
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
> Although this patch does apply to net now (at least in my local =
testing),
> the CI failed to do so the time it ran.
>=20
> So I think this needs to be reposted.

Yeah=EF=BC=8C some conflicts about=20
net: wangxun: add Tx timeout process
=
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=3D=
22d95e93c05b0e4af35b94cef004254306a63a2b
Has merged into net, so I can repost it.




