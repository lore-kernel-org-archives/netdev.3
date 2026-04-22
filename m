Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9024A23;
	Wed, 22 Apr 2026 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818223; cv=none; b=iqXaLxHaSopjYWfUfPFRZlgl4LdRfpU1Jaj2jFwO53Lemf0qR7vtCuAAtGcC2FDbvibrxPYX/nIwyWHF+YIsxeAyKBOo6wUX7gWn+WvJpcV8+EX9JEo+xkWaCeLhgHSgAnDOCO+m0xUmWPFpKZcPIt/OLNbgwb6yh0D7jF47jdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818223; c=relaxed/simple;
	bh=bO3NOqwjsP7MiNelqR1hAg21aYupK9Fe2FX9plbCZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaDztsrVnPWUiO2tf8ZQ6l17g565yx5ALsZCayEUqbNjEZVWuTJWEjlFwxBVQMdskalPFx492XMqpd0PwD84l6XRV/9bbt6cuVaEVzJAjd3fRkAN9sJn/kf/+kojXABUyUrrjDJsoG1ug642/I7PtnA6LM2ORo5vQxIEp1tTqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=h0NJU/xW; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="h0NJU/xW"
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63M0aplb086551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Apr 2026 09:36:53 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=YBx+MIOtWAPaDsDfwt6FFgYvmTmWT34dA7qBErfIMtQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776818213; v=1;
        b=h0NJU/xWnne6XeoII10r0TgHw9cSH0tlMzn967avU1ed4OTjNCHfBTJ/75/axyo9
         H309BFOIPxzoEPPL1e+J1whlBMRNPpBC4XTvxl5Ri3HkRDpU4PptdD4kRWpG3eYc
         QsrbqlOCAu9yW2bcdolh3kZ4lcwYX3V9wVDlkWVu3nII10lst8iVjmeKMHTRQzHz
         5bNUthFdkaEUN/tVwXiDR3HuASXFBS6j5B8BSJ2y0KvkFnKfbJa2p0m4VtREPfXV
         wVrNWV28gCS0OGXbt4id05EK//OjRPHi8Qrzvjo0/+IZqGvbelMJBn4EIOIQbcYk
         riazpdpwepkAoq4N4+fxQQ==
Date: Wed, 22 Apr 2026 09:36:51 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] BUG: sleeping function called
 from invalid context in vhost_get_avail_idx
Message-ID: <aegXjsir7lWLc0pI@x1>
References: <69e6a414.050a0220.24bfd3.002d.GAE@google.com>
 <aeerTzpq8B-WTKeC@x1>
 <20260421165358-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421165358-mutt-send-email-mst@kernel.org>

On 04/21 16:54, Michael S. Tsirkin wrote:
> > 
> > #syz test
> > 
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 80965181920c..c6536cad9c4f 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
> >         busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
> >                                      tvq->busyloop_timeout;
> > 
> > -       preempt_disable();
> > +       migrate_disable();
> >         endtime = busy_clock() + busyloop_timeout;
> > 
> >         while (vhost_can_busy_poll(endtime)) {
> > @@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
> >                 cpu_relax();
> >         }
> > 
> > -       preempt_enable();
> > +       migrate_enable();
> > 
> >         if (poll_rx || sock_has_rx_data(sock))
> >                 vhost_net_busy_poll_try_queue(net, vq);
> 
> 
> 
> Makes sense but this stipped up the bot. Try again?

Hi Michael,

Thanks for taking a look.
I've retried the testing, and it looks good.
https://lore.kernel.org/all/69e8119f.a00a0220.17a17.001e.GAE@google.com/

Will send an official patch.
