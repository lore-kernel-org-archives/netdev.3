Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D51A6814
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786144147; cv=none; b=PtOJwT5HloQkZplAYeCyBoUbCOKrj8qG+ljS6SbOgC69rzW7o7VazXFzohz2KgYYflZFVpKA43plXT9VrzvPLRtYr4J6kCW4KTuwU96GQBBG3IS3R9XE0do3HS/BL7XCIrrL54nm6iHTNlDztxTOEuMibs/jqdcRPzR5OS+QIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786144147; c=relaxed/simple;
	bh=ijH4nW5kN2gJo8qK5rkArW3FaYPftUUSZ6fzo7WCAn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXdvWuyvAimtz5UbRDn0O7pDGtVGAJkLHkt4XtKeaofgMFV5dKzGgmhVrGoYt0OZ1+lhIAxC6ySPkNFyha0G92KtLvjoYJYYxPPi2wXqmOU1fx6JjraVKYcqlJnxRS2Zs33+Y82MsyKc+E9fBjBlvor+X7Rg8OLZm1YdRlqmCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjnJpbBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjnJpbBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5098B1F000E9;
	Fri,  7 Aug 2026 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786144145;
	bh=a1VCoVGitUDKbUIrUKYflD+xbqueMVkN7giTuNUkzBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjnJpbBhXIUxCc4ccVrr9YkzMjrrmnkYgtdimIuMcbkeF6kwyg6G5b5UBWhfgmq3A
	 EL1M5pvzed9WlZBrOS37sEcdLZcxnn5BqOU9Cn08MLVotA90SUufkZSoZUn8ABThDi
	 1mozyPAMUVDKopmFLZddaU9kl87xAPujDPdSXK1ztbKSkTGrXtNU4dj0YncUIKeniv
	 6Z3t900yUU6wCQ8ct0URM2U07KaOQ9dUOSK4YIpl698jtDktvbYE9EfH0xqGG63rao
	 aVtwvc+dSqMHNmym5d0Qn0FQxvN6mPDrJuSRDNBnHL7J6moN1iDDvl+g/eODsYG5e8
	 ntuX6ttZ0rkew==
Date: Fri, 7 Aug 2026 16:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, kbusch@kernel.org,
 hch@lst.de, hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on
 NIC queue count
Message-ID: <20260807160904.2eb1b3d1@kernel.org>
In-Reply-To: <4d8c8d92-d39b-4721-a405-f03f01fbb95b@linux.ibm.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
	<20260731073918.614014-3-nilay@linux.ibm.com>
	<amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
	<4d8c8d92-d39b-4721-a405-f03f01fbb95b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Aug 2026 19:08:05 +0530 Nilay Shroff wrote:
> > Looks like the userspace can already pass the preferred number of queues,
> > so in this case, why not do all this netdev resolution and queue
> > estimation in the userspace? Presumably most or the users you care
> > about always go through nvme-cli, right?  
> 
> Yes, userspace can already specify the preferred number of I/O queues, and nvme-cli
> provides an option to do so when creating an NVMe/TCP connection. However, choosing
> an appropriate value requires userspace to know both the number of online CPUs and
> the number of active TX/RX queues on the NIC used for the connection. Determining
> the latter also requires identifying the correct netdevice. That may involve a route
> lookup to determine the egress interface, particularly when the NVMe/TCP host and
> target are not on the same subnet.
> 
> So while this could be implemented in nvme-cli, it would require userspace to duplicate
> the logic needed to determine the actual netdevice and its current queue configuration.
> The intent of this change is to make the default queue selection automatic and avoid
> requiring users to determine and specify this topology manually.

In another message you said you add ntuple filters. So you _are_ doing
what you describe here as a problem. User space will know something we
don't know sooner or later, so you should just add the uAPI instead of
guessing in the kernel. BTW the queue count is likely to change after
all of user space boots, so if you run before whatever configures
queues for the machine in userspace you'll be using wrong counts.

> An explicitly specified "nr_io_queues" would still take precedence, so userspace can
> override the default when desired.
> 
> Just for the note, this change also follows the general approach used by nvme-pci, where
> the default number of I/O queues is constrained by both the number of possible CPUs and the
> queue resources available from the controller.

Not sure that maps well to networking. For TCP at least there will be 
a protocol stack that runs between the device queues and your queues. 
I guess that will depend on the network and the details of the
benchmark. But again, better to let the user tune to their workload
and machine.

Consider patch 1 nacked.
