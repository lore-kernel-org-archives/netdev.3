Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184749;
	b=QQaSelDs5FRjQFRAsU4/4Opra8q9ivyTsqJM4sEqIJco4gYQ/M830AqGq9BKRcrGDvkI
	 e2ZsnpkGifou6lQkJGti+nvjdbRYdkvP0Va+mei/Galisj+w8EfNy1zxMDRedZsJwGpQp
	 OZ/k3C4wWCmbId48aGM7mDZDv+u/7yFDyClJtkcGgry13QSgo5yracqqrZvgyv2x1LkKn
	 VxDaJq6z3LyAfgozkPQmUw4mx4UoqIehOgvleuZ8Dc5tLW7F3KBlAFAo2iOcPy3EL7K7I
	 J6coj1bY0ag7DTGjNXqqUbDXxC96p+Y1R7V57pY6gtgui0TtvqzGiWvpmSjlPs2B5/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184749;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=JiuXj6JeXqS9pt7Kj+GD9nzy3JKhZ7SFK0Y9XqeTlQ0=;
	b=n74WOsd6kDkHdUQLA609gRQStQfE99YjJFZX2wibOxTAQ9OMHyMcqSmSpNZhMeWxDTLa
	 5Uy+i2qYbs0seIIxNQZy2gyaLNc3QSlN6JNbhjz1okbmx7rePzdbjvrWb1wOfsD81wDvR
	 US4hAfiNzq0d2JNq7WNdSrqgwJqX53w/jsM33KUoFge4dMZjU9IZirdtAHeGTL8dTqxwo
	 QeRD+UVMlQB0//+ChWn6l02Np3MXJMqy2REKJ9bzXGoCaO7Gd8LHuelYD7QY9wadRMjn0
	 VzaYHL8LDJhQPubwrOGq+t610a6vGCKpYpgAoYrkP1garGEr4K0VnxVC0nBtV50nwOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19A606A31A;
	Wed, 28 Oct 2026 10:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C19A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 13B2942DCA;
	Wed, 28 Oct 2026 11:52:19 +0100 (CET)
Date: Wed, 28 Oct 2026 11:52:17 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev-bot+sinfo@kernel.org, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <auHTyggWddxZgYW8@luna.proxmox.com>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
 <179275358416.3327.10205293492560698598@kernel.org>
 <attBBLegF7iEikaQ@luna.proxmox.com>
 <20261025131216.GB184152@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025131216.GB184152@shredder>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793184738514

On 25.10.2026 15:12, Ido Schimmel wrote:
> On Fri, Oct 23, 2026 at 01:15:01PM +0200, Gabriel Goller wrote:
> > On 23.10.2026 11:06, netdev-bot+sinfo@kernel.org wrote:
> > > Hi!
> > > 
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > > 
> > >  - How the issue was discovered, e.g. hit in production, hit during
> > >    development, syzbot report, manual code inspection, LLM or static
> > >    analysis tool scan.
> > 
> > Hit during development of ifupdown2.
> > 
> > >  - Whether the issue was actually triggered, or is only theoretical
> > >    (e.g. found by code inspection). If it was triggered please include
> > >    the symptoms, like the stack trace or error messages.
> > 
> > Can actually be triggered.
> > Check with `ip montor netconf` running and execute e.g.
> > `sysctl -w net.ipv6.conf.<dev>.force_forwarding=1`. The state of the
> > force_forwarding property is not returned
> 
> Are you using a modified iproute2? I don't see "force_forwarding" there.

Oops yeah, my bad. The patches haven't hit the mailing list yet...

