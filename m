Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB8345ECC;
	Tue,  1 Sep 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255994; cv=none; b=glYV4rMAgNiu562b683PwlHhGeP0+UPARy8SmbDtZXXyM8UUZCDZVQMzw4/bhGa1/0ZssWwY7OBuoRhsVvO/WrxzaL2ZIMzhIoo0RX2RT7KXQt1WHDdKqFqfyL7m7TPnfhJMI9NmTonQY739Y4/0YVPIlgBoOfb8kuRlWcyYr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255994; c=relaxed/simple;
	bh=+F9qcpRQ2xx8OGt9xdtHAgLH1Gh10ZPI0nZVwh3KzEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhgqO/mSbiqtrXlB8TjQ4XQxfkiNI4tXQlSggrsoqT4/tYFPZVO+VFVBzZSZM9farB5ImSnKD9Yc2WRbO8bXJPzwooW+NfWECcZJso1jd3/GZlLYNpf9mHzT1MUVw6j72AByYFUTXS7XVin1rtvR2WRWtYtg+Y+ks/AHu4QaKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epU7N6dQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epU7N6dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9499D1F00A3D;
	Tue,  1 Sep 2026 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255991;
	bh=wZKKgkQ31MHVRumwADkBEX70RvL+WEBmXOVQxzkxRno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=epU7N6dQia5Jqw9SLTjUTTJCbS7xO4YgCBo11x5J9KSSGukCXFZ+U0p4nKBDf52PL
	 /E3uz0CpmPgPOis91by81oKl4m9OFu3XwCO4OHQKSiYlYtC1WC1oOHp6kOh9uTx/MI
	 UyoTA551QN3LQBqiSBsTUgoPXoA1+Ub3apQmPiZeEZ8EaX4vng26XFf65EYHjETZxV
	 EJUzlaFBvkgUKdeCNx238SisbwZI2DX59UqYXs01JfxBP0HTnuM9saF3lpnASHTTfi
	 OpzzRaqh4f7G0TtQwusir+p9SBgCcMckPHgdj57O7+gTb+Jomt11Ar7x9TVmnqmKzO
	 lHWjEkC4WVX6Q==
Date: Tue, 1 Sep 2026 11:46:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Lew <christopher.lew@oss.qualcomm.com>, Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH v2] net: qrtr: Send HELLO message on endpoint register
Message-ID: <cywl4rb677vgm3is4pqvb7tgj6r67jnroxpjzruntiyis33j3n@ni5o4tjkg22e>
References: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
 <6smj6xbr4gumprpplrrw46lhe6wj63wbmcfe3nadcyp6om5cbb@tk6xtwtfz55r>
 <fc1c54e2-719a-4fda-a1f6-df1754046235@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc1c54e2-719a-4fda-a1f6-df1754046235@oss.qualcomm.com>

On Thu, Aug 20, 2026 at 12:05:54PM +0530, Pranav Mahesh Phansalkar wrote:
> 
> On 8/18/2026 3:24 PM, Manivannan Sadhasivam wrote:
> > On Fri, Aug 07, 2026 at 07:23:04PM +0530, Pranav Mahesh Phansalkar wrote:
> > > From: Chris Lew <christopher.lew@oss.qualcomm.com>
> > > 
> > > HELLO is currently handled entirely by the name server (NS): it is
> > > sent once as a broadcast when the NS initializes, and again as a
> > > reply whenever the NS receives an inbound HELLO from a remote.
> > > 
> > > In a slave model, neither endpoint initiates a HELLO on its own;
> > What is a 'slave model'? Explain please.
> 
> Some chipsets attached over MHI operate as slaves: they wait for the
> host to send HELLO first and never initiate. Since the host cannot tell
> which remotes behave this way, if the host also only replies, both
> sides wait on each other indefinitely and no HELLO is ever exchanged.
> 
> > 
> > > each side only replies to one it receives. Since both sides are waiting
> > > on the other to speak first, no HELLO is ever sent, stalling further
> > > communication.
> > > 
> > What about the 'say_hello()' called during qrtr_ns_init()?
> 
> That call fires once during qrtr module init, before any transport (mhi/smd/tun)
> can register an endpoint, so qrtr_all_nodes is empty and it reaches no remote peer.
> We have reviewed it and agree it can be removed as dead code in this series.
> 
> > 
> > > To fix this:
> > > - Transfer HELLO handshake ownership to the core layer.
> > > - Schedule a work item on endpoint registration to send a HELLO once
> > >    the name server is bound, retrying on failure.
> > > - Enforce HELLO-first ordering by dropping non-HELLO packets until
> > >    the HELLO is confirmed sent, using bool hello_sent guarded by
> > >    ep_lock to make the gate check atomic with xmit().
> > > - Skip nodes with nid == QRTR_EP_NID_AUTO in bcast_enqueue().
> > > - Remove say_hello() from the name server's ctrl_cmd_hello() handler;
> > >    the core layer is now the sole sender of the outbound HELLO.
> > > 
> >  From the internal QMUX documentation, I can see that a node acting as a slave
> > should only send HELLO packet only as a response to a HELLO packet, which
> > contradicts with that this patch is doing.
> > 
> > Since the driver cannot differentiate between master/slave mode, it currently
> > broadcasts HELLO during initialization and sends HELLO as a response to the
> > HELLO packet received.
> 
> Agreed — that is exactly why we are moving to sending HELLO at every
> endpoint registration instead of relying on the one-time NS-init
> broadcast or reply-on-receipt, neither of which reliably reaches a
> slave-mode remote like the MHI WLAN case.
> 

Ok. Then I hope you'll send next version removing the say_hello() instance
mentioned above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
