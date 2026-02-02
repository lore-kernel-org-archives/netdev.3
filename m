Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C736166F;
	Mon,  2 Feb 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033010; cv=none; b=KmlwOzULV5kcFos78rysFw64J080JWuoRyLDYz7uzErL3MGYLYub6di05txmrmU7HybGK1ImtnQIlXeDjVSFEDSWASjGnBWVzTYqUdl2NL/CKWlQT7/4QzGqvh0vdRd1mfyIbc2QACkuDi/VUcg5My2K6QXtd7XKhMbHx3hng3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033010; c=relaxed/simple;
	bh=kXvnfinhZiYCbgGMJg8Xh9KSm64a3yapRQylokUJwLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5aFAXRixUen0Duw+TNo8MOZgbhfLZim4u4yJSagTTmQWwYrcqgPrGQShxMNRMia+u3Un1ryL8VR5ZI4gekAU9n6lkC/aoiIOI4t0XCIc7V/ffWRGmlU2TSLkG/TxCH6dkDG0Wyv5EeRsL3XpKpoEjobMzA/CxQ4MDT0W6Ksw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pz2uI5Zy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pz2uI5Zy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c8x3hVVlSe3yBAUyt8ShoEyWnsoTcwMhB08qqtBA3iU=; b=pz2uI5Zy88V4Pm2qtdkC4BBKNY
	tPc3oNUXR38HCgi/h7aKvCvX55zbIksp/tOna03g0GFE9cFq53Za6G8iRXMmEUgj5z3rdkgniPzJl
	RLAhyYuyEEkH1LUXKJNWH5tqyI530LIwkjCk7HjmNRFOuRq1WJ6LyNchvrUppfV/iP9gpt2gq1MGo
	LnQ3ScfyR98HcTGq7zmgcjiszwgThNiTgpPbjauaw6gRbJU5/dgstP5ITF/u5UdKbn40gchZOklNO
	aLQMeMT5EEDIf8BDbbdSauVL3m36MmqGG/P70q0WnNgpdnBmD7b/efhxBO6L3oUuCA4tmSXibP1ah
	hmvJPzNA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmsR1-0041ND-JT; Mon, 02 Feb 2026 11:49:40 +0000
Date: Mon, 2 Feb 2026 03:49:32 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, john.ogness@linutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <aYCFnYCga1dgWniG@gmail.com>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
 <20260130173243.4e3fff89@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130173243.4e3fff89@kernel.org>
X-Debian-User: leitao

Hello Jakub,

On Fri, Jan 30, 2026 at 05:32:43PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Jan 2026 06:17:37 -0800 Breno Leitao wrote:
> > +config CONSOLE_HAS_EXECUTION_CTX
> > +	bool
> > +	help
> > +	  Selected by console drivers that support execution context
> > +	  (task name/CPU) in their output. This enables PRINTK_EXECUTION_CTX
> > +	  to provide the necessary infrastructure.
> > +
> > +config PRINTK_EXECUTION_CTX
> > +	bool "Include execution context (task/CPU) in printk messages"
> > +	depends on PRINTK && CONSOLE_HAS_EXECUTION_CTX
> > +	default CONSOLE_HAS_EXECUTION_CTX
>
> AFAIU the double-symbol thing serves no practical purpose?
>
> If none of the console drivers uses the metadata what would be the
> point of capturing it?
>
> Conversely if some console driver wants this data there's no option
> for the user to disable it.
>
> AFAICT this patch should only add one invisible symbol for capturing
> the context and have netcons enable it.

The two-symbol design establishes a clear separation between what console
drivers require and how the printk core implements it.

This approach was discussed here:
https://lore.kernel.org/all/87eco09hgb.fsf@jogness.linutronix.de/

> I don't see a reason at this
> stage to prompt users with netcons disabled whether they want
> PRINTK_EXECUTION_CTX

Users won't see a prompt when netconsole is disabled. Since
CONSOLE_HAS_EXECUTION_CTX is only selected when NETCONSOLE_DYNAMIC is
enabled, PRINTK_EXECUTION_CTX will be automatically deselected without
prompting. Additionally, CONSOLE_HAS_EXECUTION_CTX is a hidden symbol that
cannot be manually forced.

That said, I'm open to making PRINTK_EXECUTION_CTX invisible as well,
given it is behaving like one already.
