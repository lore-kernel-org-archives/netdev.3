Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA738DC60;
	Sat,  5 Sep 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620706; cv=none; b=tW29SZ6KHtmqtzwaw0kEjLjYOAqDYLr2serDBnQnxV/YiEiYtpEclv70sjkL/7ET78lkUkrG6OVJghBLj00zIo8c/Ahy9zrm4sxnh4BNsjuWdNb7uXm+IdpAvtr3iKyYF43m/aFPMMLm0RC1YhYpokGWVyNE39cx63SdUl17GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620706; c=relaxed/simple;
	bh=nDdG8BD1DSZNuI4cUQ8tFY1Dao4xRcG+uJfGYN/a3ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd9pZPKav9vMJOf4WZOb3IouhbVSlImaiGD8lUzODSerS2TWWLncbrXCtWZBp2kOlh4zkoKdHAfTAzPb+No6+QqK640ArMSIkY8S58r7sdTk5FDSxR85A+ylHJbf+zL+IPsAM79qyKq9+bdaEOSWe7ohOuyZpp44GM9z17pQXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3p5DrX2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WulSgb/t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3p5DrX2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WulSgb/t"
Date: Sat, 5 Sep 2026 17:04:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788620692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhNEhRKiYbjkBq/95l3sYrjC3d8dHBqzl4HFHikpcSY=;
	b=y3p5DrX2M628BCFrZbQVhfXYrQrzTU4i/xb/Nw84EQ3k2JnO23MeZ1DF6b7qYSzI590x2I
	8LpcMJ0RAhHAffrXexzyH9qecQBgKnp6UFEMgjdYkJ/YIQF0a0jNVWDUd+3o9pPiwfX0at
	i5R7dcKOzyMRz4tXpvPNKa5lmFIH12vJrXRj4I0/aWPlPgAinMSL4NXZJD6daYtg1itvWC
	1BNsXEg/oQUWL3dyLsW6myrAEzwI6VUqh39h3DuDPzn4p0f2ZqFxSIgTIRaS+t5VbJff4t
	18rnK/2NS967ncvDaaYFezn14KyKTfiUAjvxxHCLAI7nQRrEiJc+h48iVG/D/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788620692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhNEhRKiYbjkBq/95l3sYrjC3d8dHBqzl4HFHikpcSY=;
	b=WulSgb/tYw1layxUHaVduRfjopdp/QWPpqVKjQpxuMMHLsJ8YSOasyLXzA+aA97h2AO8Mm
	9ksL6retV2e8FTBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petko Manolov <petkan@nucleusys.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/6] net: usb: pegasus: Move long delayed
 work on system_dfl_long_wq
Message-ID: <20260905150450.2hrac_GV@linutronix.de>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
 <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
 <20260825151812.4aJyFUgE@linutronix.de>
 <31b46916-dd89-4ae9-89b9-9d39e29e8e69@rowland.harvard.edu>
 <20260828094318.bOajNBno@linutronix.de>
 <b6cf44a1-d2b1-443d-8efe-c596ef89cc2a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b6cf44a1-d2b1-443d-8efe-c596ef89cc2a@rowland.harvard.edu>

On 2026-08-28 10:10:01 [-0400], Alan Stern wrote:
> > While this does make sense I don't see how this is related to this
> > patch. The pegasus driver uses `system_long_wq'. This is a system wide
> > workqueue_struct and is not limited to USB or this driver.
> > This workqueue is per-CPU meaning if you enqueue the work item on CPU3
> > it will be executed on CPU3. However pegasus uses a delayed work item
> > and the timer can fire on any CPU so even if it is enqueued on CPU3 it
> > could be executed on CPU1.
>=20
> It doesn't matter what CPU the work item runs on.  Here's the deadlock=20
> sequence, in brief:
>=20
> 	USB device reset cannot proceed until network interface's
> 	->pre_reset() method returns.
>=20
> 	The ->pre_reset() method cannot return until its call to
> 	flush_workqueue() returns.
>=20
> 	flush_workqueue() cannot return until the already executing
> 	work item finishes.

Not sure where you pointing at but you have an unordered workqueue (such
as system_long_wq/ system_dfl_long_wq then you can have more than one
work item executed in parallel. One item does not stall the other so you
can flush your work item (waiting for it's completion) without having all
other work item completed.
There is no need to flush the workqueue, that would force _all_ work
item to complete. Flushing a workqueue would make sense if you have your
own and you want to ensure that _all_ work items, that has been
enqueued, did complete and you don't want to check them one by one.

To illustrate your point, the  example would translate to something like
the following:

| static struct work_struct test_worker_busy;
| static struct work_struct test_worker_reg;
| =20
| static void test_worker_complete_fn(struct work_struct *work)
| {
|         int count =3D 0;
|         while (1) {
|                 ssleep(1);
|                 count++;
|                 if (count > 10)
|                         break;
|         }
|         pr_err("%s()\n leaving", __func__);
| }
| =20
| static void test_worker_busy_fn(struct work_struct *work)
| {
|         while (1) {
|                 ssleep(1);
|                 pr_err("%s()\n", __func__);
|         }
| }
| =20
| static void the_workers(void)
| {
|         INIT_WORK(&test_worker_busy, test_worker_busy_fn);
|         INIT_WORK(&test_worker_reg, test_worker_complete_fn);
| =20
|         queue_work(system_long_wq, &test_worker_busy);
|         ssleep(1);
|         queue_work(system_long_wq, &test_worker_reg);
|         pr_err("%s() starting...\n", __func__);
|         ssleep(1);
|         pr_err("%s() cancel\n", __func__);
|         flush_work(&test_worker_reg);
|         pr_err("%s() moving on\n", __func__);
| }

which leads to:

| [    4.136593] the_workers() starting...
| [    4.137007] test_worker_busy_fn()
| [    5.161198] the_workers() cancel
| [    5.164832] test_worker_busy_fn()
| [    6.184710] test_worker_busy_fn()
| [    7.208525] test_worker_busy_fn()
| [    8.232754] test_worker_busy_fn()
| [    9.256522] test_worker_busy_fn()
| [   10.280716] test_worker_busy_fn()
| [   11.304523] test_worker_busy_fn()
| [   12.328671] test_worker_busy_fn()
| [   13.352517] test_worker_busy_fn()
| [   14.376842] test_worker_busy_fn()
| [   15.400539] test_worker_busy_fn()
| [   15.402676] test_worker_complete_fn()
| [   15.403290] the_workers() moving on
| [   16.424483] test_worker_busy_fn()
| [   17.448524] test_worker_busy_fn()

which means the test_worker_reg work item completed despite the fact
that test_worker_busy remained busy.

Of course flushing the workqueue system_long_wq (via flush_workqueue())
would stall but also raise a warning=E2=80=A6

> 	The work item cannot finish until its kmalloc() call returns.
>=20
> 	kmalloc() won't return until the kernel can free up memory by=20
> 	writing some pages to the swap partition.
>=20
> 	The write to the swap partition cannot take place until the
> 	usb_storage/uas driver carries it out.
>=20
> 	usb_storage/uas cannot do anything until the USB device reset
> 	is finished.

as shown, this is not a concern.

> > Therefore the suggested change system_long_wq -> system_dfl_long_wq
> > should not make a difference here: it is a different workqueue and it is
> > unbound (instead of per-CPU) but given the usage it is unchanged but
> > more obvious. Also its usage recommendations (use this for long running
> > items) is the same.
> >=20
> > The plan is remove system_long_wq from the tree.
>=20
> The point Oliver was making is that the driver shouldn't be using a=20
> general-purpose workqueue at all.  Switching from one general-purpose=20
> workqueue to another ignores this point; it's not the right thing to do.

Still the wrong thing to do? The driver should do either flush_work() or
cancel_work_sync() (not flush_workqueue()).

> Alan Stern

Sebastian
