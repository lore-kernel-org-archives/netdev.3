Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6419992C;
	Fri, 23 Jan 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191459; cv=none; b=CmZAYUGPkNLF02dUdH6mMz9gwdzB8yMCQpNTooch9BU97vF50eGzoz1o2u0m2I86OZqvSxUVesenDlOmKrcx3JyR4LL0RdoyySu5rB3nede3NGK643XnB5YGDLnROHTfb45hJkLLgsL8s93d3p3Hm6fLjpoV2rDF3gxAzIla1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191459; c=relaxed/simple;
	bh=DwUaUSIkk8Rk3K76xtfMFmWSJFuLEL3bEOAlwXfFTvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXg8OTJRaH1nXfRtzLVKQyf1l+ju/M7rTGUalhigHmkk8Zt9XL6RKTN++imJz0tnAJHjkJBoTwSCf98l1sXfxmrjs+XlJv/ORuqSUcm7Z2+5Wd5dhPerYZcuGjoWZRkAOXrjgqG/HkBk8/VsyEcml1DpHe5lVeoikp5m9suqPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfysU7OV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfysU7OV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC561C4CEF1;
	Fri, 23 Jan 2026 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191458;
	bh=DwUaUSIkk8Rk3K76xtfMFmWSJFuLEL3bEOAlwXfFTvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfysU7OVtpu7IiMpjoPtw17RAUrmRcCOvnRVGqvXuBCT+rmbqiSuKMV8GbGVeyoMw
	 FFz1WP6DHANklyged8BFGWvSuqlai24fd28saB4CyP47d4kWhjdDiv/pYyQjwi/jJ1
	 hBIvmhnUwwyxUHIsLjSVmmMgD0xdev+N0EXsVV7xpZw09upScww/utR/dNdUcg8uhr
	 DrPEx70BZMfYRQq8xPLMYxovFsDV8SVrl3Q+pr//qezhpJsHAfS0MY0AGnEwqPVfQ5
	 ILwIEhltWeME9hvtec6SffWW2wdP0UBK+sUfeFBFM5FWfqqx+c3MExlPFJrBGSHzy2
	 Ppp5XvJYvsOPg==
Date: Fri, 23 Jan 2026 18:04:12 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	pmladek@suse.com, john.ogness@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: convert to NBCON console
 infrastructure
Message-ID: <aXO4HBMEGwekTtlQ@horms.kernel.org>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
 <20260120-nbcon-v2-3-b61f960587a8@debian.org>
 <aXKSDoi8Yue_Ghxj@horms.kernel.org>
 <aXNRR7dQHZ7bN2mS@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNRR7dQHZ7bN2mS@gmail.com>

On Fri, Jan 23, 2026 at 02:48:47AM -0800, Breno Leitao wrote:
> Hello Simon!
> 
> On Thu, Jan 22, 2026 at 09:09:34PM +0000, Simon Horman wrote:
> > On Tue, Jan 20, 2026 at 08:23:49AM -0800, Breno Leitao wrote:
> > > Convert netconsole from the legacy console API to the NBCON framework.
> > > NBCON provides threaded printing which unblocks printk()s and flushes in
> > > a thread, decoupling network TX from printk() when netconsole is
> > > in use.
> > > 
> > > Since netconsole relies on the network stack which cannot safely operate
> > > from all atomic contexts, mark both consoles with
> > > CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
> > > 
> > > CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> > > scenarios (panic) where regular messages are sent in threaded mode.
> > > 
> > > Implementation changes:
> > > - Unify write_ext_msg() and write_msg() into netconsole_write()
> > > - Add device_lock/device_unlock callbacks to manage target_list_lock
> > > - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
> > >   operations.
> > >   - If nbcon_enter_unsafe() fails, just return given netconsole lost
> > >     the ownership of the console.
> > > - Set write_thread and write_atomic callbacks (both use same function)
> > > 
> > > Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/net/netconsole.c | 97 ++++++++++++++++++++++++++++++------------------
> > >  1 file changed, 60 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > 
> > ...
> > 
> > > +static void netconsole_device_lock(struct console *con __always_unused,
> > > +				   unsigned long *flags)
> > > +{
> > > +	spin_lock_irqsave(&target_list_lock, *flags);
> > > +}
> > > +
> > > +static void netconsole_device_unlock(struct console *con __always_unused,
> > > +				     unsigned long flags)
> > > +{
> > >  	spin_unlock_irqrestore(&target_list_lock, flags);
> > >  }
> > >  
> > 
> > Hi Breno,
> > 
> > I'm wondering if we could consider the following annotations,
> > as "suggested" by Sparse[1].
> 
> This is great. I hadn't realized that Al Viro's sparse tree includes this
> additional check, which is really useful.
> 
> Are you using Al Viro's branch rather than the sparse mainline?
> 
> (I'm asking to see if I should also follow master and do the same, in
> true padawan fashion)

Well, I think it would be best if mainline was fixed.
(Although I am yet to do anything towards making that happen.)

But to answer your question, yes, I am using Al's tree.
Since a few days ago when I tracked down that it allows
Sparse to once work significantly more robustly on the
current Kernel tree.
