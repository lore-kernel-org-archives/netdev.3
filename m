Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C861DA57;
	Thu,  8 Oct 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791428451; cv=none; b=ooeSONoIbu9QbYqWXo/u2kTNaJ99yix+CpxDqUdKXE7GklLbVjhTf1GgHqU82uou1RVWxCr30TRweGrO5+LgLws+6sQQxGVGWG0ZgWJ9G1VZ9dKWZ2Qyb6CnFQkQolg3c6LQtKVgg9dpopIAlpwOGwwZoLkARuiQjAuByRKLCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791428451; c=relaxed/simple;
	bh=MLHG6/E9+FPE7FKFRrYce0KiCbeJqQiYOIBWFMlp6dA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxh/6uByT8nGVVaUsUy1i3WJVt4oPVvIHMzMD84WGzvdK3QidHADxzj92cqAqHN5GZzVGIJxO1f2Wq0NtFMkLKae+MqUNLMZpqEsehPM4Oc2o5MtZfvRKjUk0I1sx1912y6m5k7CBnHq5I8zzWT7NRCXONxLLyxC3CO72mO4bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=basoi69h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="basoi69h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2D61F000FF;
	Thu,  8 Oct 2026 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791428450;
	bh=50+POZDEVfVpcAPhaP8rz8Dn7fXCA2QJ9qoksTKwMjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=basoi69hO6t+oVGsi/ibwJoMDmzEmR6Jjzi4gE4UfAd9exBXrup0+CAieaZTvCd2y
	 IcYHStU3NXo0J5iAhsmqRsT0l88nYyuoclZ/QskbtV1jwf6K30qaqwN/yu5v9Wlrqi
	 XrmCv1MSer97MObJZU+KHSA4399PfDtGoRAv6TuzWkefQPm+mjuWPZC/F8HB55/ik1
	 6iwSIrEw2BvkjecEnxbv8cLD8MuSReBJvc2o/uMkRP+949bGL2NDJb7LFwHz/TfuI7
	 L4V+Cos+RJS3SvSQghjwkbPCYPj0ecaO2EpmyVJsJozvvKvV8ke5GjC5+gbiQv+zYT
	 30EDjFmtSgx0Q==
Date: Wed, 7 Oct 2026 20:00:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
 oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in
 preemptible context
Message-ID: <20261007200049.079aeb75@kernel.org>
In-Reply-To: <20261004215937.302247-1-omermetekaya0@gmail.com>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  5 Oct 2026 00:59:25 +0300 =C3=96mer Mete Kaya wrote:
> tx_complete() calls this_cpu_ptr() before disabling preemption, which
> triggers a BUG when running with CONFIG_DEBUG_PREEMPT:
>=20
>   BUG: using smp_processor_id() in preemptible code in tx_complete
>=20
> Fix by using get_cpu_ptr()/put_cpu_ptr() which disable preemption and
> return the per-CPU pointer atomically. The usbnet_skb_return() hunk
> is a hardening change: that path runs in softirq context so no warning
> fires there, but the same fix is applied for consistency.

This looks odd, how did we miss this for 8 years.

Greg is probably busy, but would be good to get a confirmation
from either him or some other USB expert that the callbacks
can indeed be called in process context.

FWIW stack trace from syzbot

 <TASK>
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
