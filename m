Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192593DBD66;
	Fri, 10 Apr 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856645; cv=none; b=gfOk3y4ZEUt3fDifAt/jAOwAHgCfcvX8HxPj/dfCBYLBkOhMgp4TdM3o05gX3sdkW4K1XzsXBL+EDs0rNjxs11na68P1G5qpZ8peaN5cOgrmA4R/5tPxnVutY42uHgRpaUwqdwKhRm5UXHHatPUvS3CDB6y1UlHbK1nzuwkCKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856645; c=relaxed/simple;
	bh=G2dtzdVuZ0FFm6ylWyUaMhhph1il2Hr0GyFl+vJtWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtNv7RzDwpFrATpFQS6ugS7eWyw3bl6K3JHiPmY5rFuYBhvdG8fvPUopgkl4oaL7yjfl2Be4nWuskc7wNzzhviMdCXFoYSKKCnktjdURZmUaE9T3BA99M/16S0vD3FQezUJJFnkKygpEnsFnRmxKIyMkhIJfT6zBO06kGZHqDoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkL9qfeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkL9qfeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0680EC19421;
	Fri, 10 Apr 2026 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775856644;
	bh=G2dtzdVuZ0FFm6ylWyUaMhhph1il2Hr0GyFl+vJtWEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dkL9qfeok2m3mrx4KQdDEonhwk1uQihgVpFPyXJZxOrqKcmq/6tLf3XYRMCbzcZ2K
	 U3NYbfad0BEPJj2k2IY7306IYfocTvv1eMnmmFHCkkre5Jb9qDfEFT7D4wH++IEvXg
	 LPbnjge77WoZ7qEPatEw1jdnA8jq2Drnr/18uEI7Hsp+RlvnyEHrTSRs1sC34MM1b0
	 lYPzuKk9FrikoF2Kqtj2UdjXDVmfvhVp44O6WLJQ/OYwIRe3DouM7QiQZY6lndenEH
	 gZlpQl2Iq7t7aSN6qP0rPh4agoolG9QT89JbOYF6knKSBFhC5Zuqzho2P983bUoA76
	 s47NMBwiRr8hg==
Date: Fri, 10 Apr 2026 14:30:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>, stable
 <stable@kernel.org>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260410143042.1d4436de@kernel.org>
In-Reply-To: <2026041026-excuse-slashing-c4ee@gregkh>
References: <2026040730-untagged-groin-bbb7@gregkh>
	<20260409190328.GS469338@kernel.org>
	<20260409203235.6b9329f0@kernel.org>
	<2026041026-excuse-slashing-c4ee@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> > On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:  
> > > I expect that checking skb->len isn't sufficient here
> > > and pskb_may_pull needs to be used to ensure that
> > > the data is also available in the linear section of the skb.  
> > 
> > Or for simplicity we could also be testing against skb_headlen()
> > since we don't expect any legit non-linear frames here? Dunno.  
> 
> I'll be glad to change this either way, your call.  Given that this is
> an obsolete protocol that seems to only be a target for drive-by fuzzers
> to attack, whatever the simplest thing to do to quiet them up I'll be
> glad to implement.
> 
> Or can we just delete this stuff entirely?  :)

Yes.

My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
Create GH repos which provide them as OOT modules.
Hopefully we can convince any existing users to switch to that.

The only thing stopping me is the concern that this is just the softest
target and the LLMs will find something else to focus on which we can't
delete. I suspect any PCIe driver can be flooded with "aren't you
trusting the HW to provide valid responses here?" bullshit.

But hey, let's try. I'll post a patch nuking all of hamradio later
today.
