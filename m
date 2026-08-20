Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB80400E18
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255647; cv=pass; b=ddUFSvIbh6dP33PctRUlrlgGDFoS/IQ7P30nUtnW6BEiXeloNz0Loq61/hAlaZfE/rPpR5BGTd4HRJrolWLhslDE7Q/kFJI6NGCy3Pn/expm0b1Li/k5a69iEj9fjeE8cPUY0Ztm7QBJfNExwC3hX/gHrVEHh1pc9ZJaLnfo9no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255647; c=relaxed/simple;
	bh=A4o5BAAOrrZIkOj858bf5KwBTmSTE/KeiHyue8gRZYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOAGg7pqM2+/Fr7jcmh9ySyJxvWurV+agKZebGa2NqHkcCOFNDXb6/uxOSU/edOKfb8pZyHq16iDdCOtZQCBQ/ef2zlkrxYApDpQmLqFB9VjyIKoPIekAUFPqyuhwrtr4mww88YauS6KUdUOvifsxxKkc7MUs+SeLa/t2gmLY20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=I1Dwui1T; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="I1Dwui1T"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so233849a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787255645; cv=none;
        d=google.com; s=arc-20260327;
        b=GSzwDVhpYDrb3x6Oov4ePangkPVR/7lq42w/P2ZfjogC4ZHG8rGGOVjzZUkp3XRAOE
         a4NOAs+eF7ktmPAtqXt/xz1gUsQc9nn146qN1p9WtiZbHkHFIa4lJCQc9QiEFGp04T4l
         78YbUi+Af3mPr1JUvYmwIXDungFgOvYqiIcJTYeDn4FwtwtWkCYXGeB+glz5ChOdwePL
         iFZcTJXvwa+aLDyJRALx320ONYkV8g9XOv2lmxk4hFjc4RwzwD73pI+Q1BeEekWyFWt3
         iBa5clmC7DD93dLcOuFLcF/oiC5W8NHr9PN47aF57SYe2VnfLcO5/vVHKPLGz7ZO1qCu
         TOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YF2Udwm0JsieL86irU/S4OXN+OyCZZY90u2F/ywl1LQ=;
        fh=McJ40Ro4tuKQ++v+v3sAw317dKY02wcsZx4DL7oRYpk=;
        b=JACZ1Rd8pgeFNP8laMwsOOL5auc/93Cy8/oTnLtl/bU+R79PvSrhjZ2CoZD9s3NKyS
         lDc8f/+rMHtIaovbIpsY9u8fYET8X4+FqGA0HB8T+Aj2bipAIzj4/EQePT8uy8pGEW7c
         UT7AZja1uF3CBpczFkfNAmhXiNV4mkvNRQWCpxt61IQdv3XQNi0NSjojeMJWFP0GWyKd
         e2lu3vOO20nZ1cRbAEtW0Incp1OHXWe+XSiC1t8td9K5KTszM3hUE0MNikNgH4wb6LYt
         5D/9Qu8dFBC6n4kqpusWT270MsspndUnaAZwLLE0bcWa7tALPE0x4TI8QV+BaxGASvez
         7P0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1787255645; x=1787860445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YF2Udwm0JsieL86irU/S4OXN+OyCZZY90u2F/ywl1LQ=;
        b=I1Dwui1Tkuxm0wu+M+GDqa1v8JK0Qj1y+ea0mybwHUsh++IuqkhxNNh0uxewbWH7ST
         CP+t2g7ja+Al8nrl08mJt2dLF9dQG5LZTigDHkr4O8agaIkjGy06fnojAccp4nrNyDoh
         ZYfgn3tsXHotZis5w/pJX4koIQ/glg4+GOFRFHzPaIvCbkjPnfUdTRFN2NyesggMBVuS
         YxTEpBhWwaQs9DMSaOMZl9V86Xj69Qvwu1fHsZd1mxWGOPGHstTfycEiOQ0vOsXbWAY2
         /V/0kwkO8c+ZoixkEfpfIV/wCB+5HUMyEkYH8EkOr7l5lX2TGUtH5T5e6MqLHaYQ6D3o
         M/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787255645; x=1787860445;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YF2Udwm0JsieL86irU/S4OXN+OyCZZY90u2F/ywl1LQ=;
        b=QDhZqMadlxacCDaa4DKuB7jq+MQRMiMBQLJoyhvvdvKxAF5fK3+vpgEeYrm7fo+3Xa
         bJdzfA+905UyJfYZbhCfGwtCx6cYlpuKzuELxlre+5B+6Lq79rMsN3K/pv61oTSGYBgn
         pd/sidu8Y240UOKNTUYyRqvHUq8Na4afXJq+tF+acit8B1U629YPTNAtkg3JPmBF6t7z
         spYCxMzoi8VLBN9SozHq9HLnEbqENqn/qz/eSXTv5MWxkazmN+D6AKPdZ2BK6DB6DKYj
         Pq2FyguucmHarbkWz8LALRhDKXU0zUrwSH6RX/1SKIhOQ/+nRjok5gkmRhM7k4jZPAUW
         cY3g==
X-Forwarded-Encrypted: i=1; AHgh+RpkunZ0KfaxiMEplFsJlSN6Po+tTnXuC5Gd7PTxR5jCrHW78J/ix0sSx/GWPgg/PPKf6tP59cI=@vger.kernel.org
X-Gm-Message-State: AFuF++mUh86wpBVM1qtcoRBzQ+Mqxl964V5lupw0MlW+7kuCdQrPcfDZ
	/YSUui1jUWgGE2rUJqqJC2gWjDOVZWzcAi4/Zz2OERbemoG5/1NfTM4mTO9+WRBB1nWRtdWQpW0
	DNtn1GbW0vjJcpOmOKu6HDnS//wobytBN0LfPPkpq
X-Gm-Gg: AR+sD13UFupYczhIXpeFX+qTYwsCLvtCOYIO8RK1SE4E17BlTmBEOdr4xwl3/cCyg17
	fuHCFpbGpiyi5bdxLJ5tqLH43EGx49bfbp+ddxfuSLEu/nvNkKogVytvoxBnXaj0aawTXpeFBu9
	9DJtTu3+OzCh9dBKSkDmf/Mv7z1xcBnGRw11E+g+s2JXWlaHU6jwfMPMa7IqYoquADs93okKdYA
	AaBt8qtRslh1H1Y+M2jtfgxAITU7XB3LJP1rFRQTd/PYYitpMwDRidVTkkPY3k/iDyoMmOPtSpM
	oFTNYf6wuuMBg73W5pFcacdAsOI7rQ+Zz1ihhvDF369JhjEx5MMo1J46r/8U88NGOYIOKGjiuKQ
	=
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-395c33d786amr1904374a91.2.1787255644847; Thu, 20 Aug 2026
 12:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820081111.1586932-1-xmei5@asu.edu> <CANn89iK39fwq3hLAdEKPk7_G-dN-rxrhWnpoiGh3dkQBttTucQ@mail.gmail.com>
In-Reply-To: <CANn89iK39fwq3hLAdEKPk7_G-dN-rxrhWnpoiGh3dkQBttTucQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 20 Aug 2026 12:53:53 -0700
X-Gm-Features: AcwNN1X3d6dyGZFVmgFHjFDfaAmYlPGeTGlUwpHJSxEfu2CwmnS_CpaeB1riUIQ
Message-ID: <CAPpSM+STEzqzW2RfyM2A+n55E5OPiGoUHJ9DQzoAN6ymrLFoEQ@mail.gmail.com>
Subject: Re: [PATCH net] net: qualcomm: rmnet: set skb->dev for deaggregated
 MAP commands
To: Eric Dumazet <edumazet@google.com>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+4638111fe2a12980@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 2:49=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Aug 20, 2026 at 10:11=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > rmnet_map_deaggregate() allocates each sub-frame with alloc_skb() and
> > leaves skb->dev NULL. __rmnet_map_ingress_handler() assigns
> > skb->dev =3D ep->egress_dev only on the data path, but a MAP command fr=
ame
> > is dispatched to rmnet_map_command() before that, so rmnet_map_send_ack=
()
> > runs netif_tx_lock(skb->dev) on a NULL device. An unprivileged user
> > reaches this by unsharing a user+net namespace, creating an rmnet link
> > over a tap device with INGRESS_DEAGGREGATION and INGRESS_MAP_COMMANDS,
> > and writing an aggregated frame carrying a flow-control command to the
> > tap fd.
> >
> > Assign port->dev before dispatch: the command was received on the real
> > device tracked by port->dev and the ACK must egress on that same device=
.
> > The non-deaggregated path already has skb->dev =3D=3D real_dev.
> >
> >   BUG: KASAN: null-ptr-deref in _raw_spin_lock (kernel/locking/spinlock=
.c:158)
> >   Write of size 4 at addr 00000000000004b4 by task exploit/144
> >   Call Trace:
> >    _raw_spin_lock (kernel/locking/spinlock.c:158)
> >    netif_tx_lock (net/sched/sch_generic.c:497)
> >    rmnet_map_command (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_com=
mand.c:67)
> >    rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers=
.c:125)
> >    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6103)
> >    ...
> >    __netif_receive_skb_one_core (net/core/dev.c:6214)
> >    netif_receive_skb (net/core/dev.c:6474)
> >    tun_get_user (drivers/net/tun.c:1966)
> >    tun_chr_write_iter (drivers/net/tun.c:2012)
> >    vfs_write (fs/read_write.c:687)
> >    ksys_write (fs/read_write.c:739)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 378e25357ac7 ("net: qualcomm: rmnet: Remove unnecessary device a=
ssignment")
> > Reported-by: co+4638111fe2a12980@bugs.sh
> > Closes: https://lore.kernel.org/netdev/ijg79FFMfIvKJbivdJEKvTO90Q9dTvyB=
kJck@bugs.sh/T/#u
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/=
drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> > index add0f5ade2e6..3944925566fc 100644
> > --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> > +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> > @@ -79,6 +79,8 @@ void rmnet_map_command(struct sk_buff *skb, struct rm=
net_port *port)
> >         unsigned char command_name;
> >         unsigned char rc =3D 0;
> >
> > +       skb->dev =3D port->dev;
> > +
>
> This works, but the suggested patch is cleaner IMO
>
Thanks for your review!
> https://bugs.sh/b/4638111fe2a12980/patch.diff
Agreed, that is the better fix (fix the problem at producer end). v2
has been sent:
https://lore.kernel.org/netdev/20260820195240.1631458-1-xmei5@asu.edu/T/#u

-Xiang
