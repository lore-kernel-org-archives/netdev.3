Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028744;
	b=vK4ggNY0TbedSxdaUhLs71maSBdFCwiR8TZzd5sCBeFvjg8iyzNAfP2gGr44Rka7njax
	 OeeXlIDzTIXDRAjTpBxPbno/w/PtOUhXblF/7O/biRLTrvZJwp/0AFv56PbeMfcTfd5By
	 hLcSFUhFNAFyRWbE5aZyF/jlFuIlUJo7waUN06V1nE1l/noE7xmbOA6nxpGgXI1qfC/Zf
	 JuetcKRri7SoNS0QLQ06wlI0Vwnx1W4vIUJbGST1IK8ziiPJgrrC14bMJBKtyng52UIjZ
	 63t1SMVNvlpm9Rwpoq9gTch7J3QmMNddKOUXMX/U34Y1KSrDZvdpu7SQjOXqUEI4a2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028744;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=xsbZnMuIwZGVt5Zv5ZprAj+CulDRMl9ek0Cr3wabECE=;
	b=aioJUOENummFgWbxmJkECtTRt4L8LAjzNEt3ter0Ia1VRrAiSobwIcWqt2GkmM+DtXm6
	 lk8fAwZH2Cer3nn7kYJlz+0a1qvUfU5/nrqgGWs33tBFzLv41Et1DdWFNnzXMzipgxLpE
	 771fy2wl8ZNSq8jQ87j46PpaHHHHEP81J6e6TS1KNlvdfLQ3wEiZAM0bYVcbpWQwxxMjQ
	 C+608f6qY6lHFOjkhP+/sp35JbzvB7d0qcnVIo/1fDBbe24Yqh+H81XQfSaGX3aMsOtb5
	 0mIYlBGDiqLLHdtbAvVcX8t82N8vaLin+dxVZu7f9YyWoo7snQB9a3UZa+YcgJQbWLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IoRI1Jhi;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46DC606A31A;
	Mon, 26 Oct 2026 15:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IoRI1Jhi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xsbZnMuIwZGVt5Zv5ZprAj+CulDRMl9ek0Cr3wabECE=; b=IoRI1JhiV7krpPaiUcxvPCmXe3
	MHJ2c8wAUT8DD1SCTpRiFg5MO8oddSvRs1ceA6w6L9f9kt50vm0hN1TXTC/PVh4aToQJVjJHL4uUB
	msUFJYVS823574Ow0sELheq2lw7LdPQt5li8A2fj+19yN7wOlqtv5HvLcM3zeVP6eKctNFVcCBmg4
	PMY2j6JjeyzOy5P+bsbRBBnIXinzGIEOvf+GPqz1SAM5+p3wqZONII2C0tRlr11xZOcRApuhOcYBK
	1nCVJymXCF+bTTB4Z/X4KURwy5QkwfxMCU2kyYdKmzDmJArNNaV5cbEVQvqMlZaAtRgwkLpD9kDJi
	/s+6R8yg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLMgA-000m23-2K;
	Mon, 26 Oct 2026 15:32:06 +0000
Date: Mon, 26 Oct 2026 08:32:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Chris Down <chris@chrisdown.name>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Sam Crossley <samuelcrossley@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Paolo Abeni <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <at9sdzpT1y7ygAbR@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <at9mJoA8ZQfUCFGw@chrisdown.name>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at9mJoA8ZQfUCFGw@chrisdown.name>
X-Debian-User: leitao

Hello Chris,

On Mon, Oct 26, 2026 at 10:39:34PM +0800, Chris Down wrote:
> Breno Leitao writes:
> > So the next step would be to add a basic /sys/class/console/, similar to
> > [2], and put a `replay` entry in it.
> 
> Feel free to incorporate an abridged version of my patch with my From: in
> your series if you like and we can take whichever one lands first.

Thanks Chris.

Your patch does a bit more than the series needs: it also adds the
loglevel entries to sysfs. Would you be OK if I trimmed those out for
now, kept only the basic sysfs support, and preserved your authorship?

--breno
