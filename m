Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7589946C;
	Tue,  3 Feb 2026 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078203; cv=none; b=rhO5BWcCJF3xJrmlE9uPNx0rDAyyJvfiy0QnnWWHcARsOo4JO0DpZUjAvHCrrF9RMVl5Li8tvzofuD1NSZmk7wtvEsgoJ18u4NOhCR9PRShH4jpHcX9WRt+qW4ndC6+aJkIZBK4Si8bda9fAaxODTVx0ccznfXPMNn/SYuOndFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078203; c=relaxed/simple;
	bh=RXKaVnP6y+nIgtSd6hAI4tHqTDyOyb7D7OxyiKx7sas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqztSu0eztgYpULCBdFeuLDJL0frKPVIeyN3fnujNRynq703NXylhJSttWwI7EazNgOX6o8X/IvpTA5VfFhFjbbJjxCkr9nSGoEflh4633IYiQaw204wEuNgXqPMZVONNZt4kZEquACKCLeFcFtONMIwjNfJaCMKwbeQPU5Vv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQu0vI/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQu0vI/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31FDC116C6;
	Tue,  3 Feb 2026 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770078202;
	bh=RXKaVnP6y+nIgtSd6hAI4tHqTDyOyb7D7OxyiKx7sas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQu0vI/X9M43ymbIvwa+oynpt9Sa5RDjVht6CKpcBSB3L6cv14WGbT6nkPtqi/fwM
	 pI7V5P9iR+Lud3G1w6GG4oOQ2yfWaI8EfLz4eWEAOPh9ZRUu5wAXEOTJ1IYLcmXhTC
	 b/5vZ1rYYXdF2bwMI80I1y1Sq/rSw82QpxA5KuVqpEuF69X+b1LBngdX3VqbGjNzOm
	 SgiLwJoLsBtKV4/jbJQEq40qfJsQFxlTKUQAxnbApG8K9KLcw0boEmaL4B7UiqdtwI
	 0z9rEwQwEkEgGDFgOap1k8ZktBVitGZnEU3w4y2C0XlbOocCSjFmwz8el8nLCK7f5i
	 HBOhGYJrRL2nA==
Date: Mon, 2 Feb 2026 16:23:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, pmladek@suse.com, john.ogness@linutronix.de, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <20260202162321.55fccbc2@kernel.org>
In-Reply-To: <aYCFnYCga1dgWniG@gmail.com>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
	<20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
	<20260130173243.4e3fff89@kernel.org>
	<aYCFnYCga1dgWniG@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 03:49:32 -0800 Breno Leitao wrote:
> > I don't see a reason at this
> > stage to prompt users with netcons disabled whether they want
> > PRINTK_EXECUTION_CTX  
> 
> Users won't see a prompt when netconsole is disabled. Since
> CONSOLE_HAS_EXECUTION_CTX is only selected when NETCONSOLE_DYNAMIC is
> enabled, PRINTK_EXECUTION_CTX will be automatically deselected without
> prompting. Additionally, CONSOLE_HAS_EXECUTION_CTX is a hidden symbol that
> cannot be manually forced.
> 
> That said, I'm open to making PRINTK_EXECUTION_CTX invisible as well,
> given it is behaving like one already.

I see, it doesn't prompt because netconsole 'selects' both.
Why y'all think this is clean I'm not sure, but yes, if you want
two symbols please make them both invisible. netconsole should
not have to select a printk symbol.
