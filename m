Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60375367F36
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584796; cv=none; b=gPCUIJtKlczDjmiuHF0dTsNJ3S2fMU9Bw5M5Ly2N2eOeffOuQGwgcxQkeOo04bdvSAnU2a96GNLNcVJOIq7GiimWKzGQdxSBnGneBeo7XYr0RE1kTjPM0iMyGysXfVgPETbD9RRpVJoeK6qS7KhV6gcHRNINSHocYs+91nc8uIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584796; c=relaxed/simple;
	bh=xnN7/cB6R60McvMyMAsz6tChEhEHHBXzEew/vvxLTBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFSAgRc0E8hAkAHDWQjmvvke7YDsORF/r9HkQ8slIJhYBMPgVmQUJJB3A8rhy8ZbQVsPcstELedPQ/ZmT7nmNAfuK+fqBJNE0g3COYxMOj5OVTDx270ip23GsmfUaY8l7GCMwHQCChfj4ZGETUPAo7/C8G63wjXlBBYNu2sLP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HngcMw22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HngcMw22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED7D1F000E9;
	Mon, 24 Aug 2026 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584795;
	bh=66hczHWglZoaCKzVlQ8YbYptRZp3iaDdQzrhf97qXUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HngcMw220igR0F+qbvYCvlamE8+1KCLmGoiSU/YTa+3k5+e9+FgTuq8ntos7g5elB
	 0AjgfGZjwwf8ZTTDB7rV7Hu/e4jbAbFlYzywgJMhxF0BT6lAFJcYmrHY/+kZqbftBv
	 cUVCcz6ZPnOGs2kvzGmtRgMw3PeIYh4sNWtl9NrsZPD6VZhVBrVyDOdf5lK+PjsbUa
	 imarEEWiJjVpij5XshyDcUCIdt+/il3TjNYa3GAv7UdmLZmjhzaCNpwsH6pK/2n+tl
	 FH2ipyDHHmptAXvmozoWv9OsN8kDPWJR6oaMZNB/5KcN1XGfAUE5S163GzLX9v6oGv
	 BD8tIULvYsa4Q==
Date: Mon, 24 Aug 2026 08:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>, Boris Pismenny
 <borisp@nvidia.com>, "kuniyu@google.com" <kuniyu@google.com>
Subject: Re: [RFC net-next 1/6] psp: steer Rx queues with the virtualization
 cookie
Message-ID: <20260824081954.2cb8eac8@kernel.org>
In-Reply-To: <4aa7871fcfc4a662d32a7ca7929b07a42a89ff6d.camel@nvidia.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	<20260822225524.2328465-2-kuba@kernel.org>
	<DKWFJ9D12OPD.2ZLQHDM0276G4@gmail.com>
	<20260824080122.17be0e16@kernel.org>
	<4aa7871fcfc4a662d32a7ca7929b07a42a89ff6d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 15:09:31 +0000 Cosmin Ratiu wrote:
> On Mon, 2026-08-24 at 08:01 -0700, Jakub Kicinski wrote:
> > On Sun, 23 Aug 2026 11:31:03 -0400 Daniel Zahka wrote:  
> > > On Sat Aug 22, 2026 at 6:55 PM EDT, Jakub Kicinski wrote:  
> > > Should vc-steer-ena be a connection level setting? Maybe it could
> > > go
> > > into rx-assoc. The way it's implemented here, the state is already
> > > per
> > > assoc.  
> > 
> > That's what I started with but then given the security implications
> > of the current simple design I could not think of a reason do
> > configure
> > this connection by connection. Besides the SW stack responsible for
> > security is likely somewhat orthogonal to steering configuration. 
> > Should have put this in the cover letter as well.  
> 
> I looked at implementing the current design in mlx5 and a per-assoc
> setting wouldn't be enough, because flipping this on requires device-
> level steering changes (basically adding num_queues steering rules).
> For device-level settings, we conveniently have the .set_config()
> callback. There's no per-assoc callbacks, but theoretically, we could
> detect the first use of VC-based steering and do things. Doesn't feel
> that clean though compared to device-level.

To be clear - the per-assoc would be in addition to the device level
setting. We'd have to enable the feature and then instead of
snapshoting the device config in psp_assoc_create() we'd have explicit
Netlink flags. We can do this later, the two flags I added here can be
thought of as "enable for all assocs", we can add "enable per-assoc"
device config later. Tho for Tx not echoing a request would be pure
spite...

I implemented the per-assoc things first but then I thought about
deploying this and really there's no reason to plumb this policy thru
Fizz/Thrift handshaking which creates assocs.
