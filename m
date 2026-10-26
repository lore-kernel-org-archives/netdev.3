Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976215;
	b=gJcWCG5gKhmv0TsflfOdT+tVPZQCyZiGgatfKW3FZYPzz5fw0ionLaV+nVTKCR5Z9zzq
	 wH0lxPa0964x7bY0e0Hj+CNhTRgRwBR9WjVOdDVAZKX2QA15uHL8lFEIL5xYBbBCpAse/
	 TyFOWDE9T+kWVI5oL/jAh8sGz5njU8iVX7amMVHFPO8Pq8Mq24JaIPmK3JAgHVhLcjVVm
	 mcTq73LDgL81Rwk/Af4V1ixt1uNKiwo1Pa0/Zxz+54kHwfL+qyaew4kcJHnA6d8P9cK0O
	 qNIqjPFUX0AiSNY4OcclJAGI2m0NpHZ/43nms211pANtB40MKFXm5AwJC0d5dJ07DLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976215;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RLx2Ro+oXYG6Esl8h8Oz8vJrCiQY2x6fL9DTdSUob0M=;
	b=qH1fXoIRDvAKQkqR42PBcCBnN/FuOxKNCVO5xBWDV3cOWD+13vATNN72Zir34y3PdmEm
	 veYLtilFqYuv1C0tsh5549GuvWlsrDHTutvSX/Yd96lFfE0E1viGSOmaD5XYVYFo1MR3u
	 Il7pIEYa7eTtJhwBkK52vnbeQKgmg0QM66tLRCA2lbusYCOfscuSq9mqbx2uFRpY7I8ty
	 Z3FVnoSGekus5xs2u1hCdiot4U7AWZOgSEaIrAE2tThk/GDKcdgWtyfDbmeaP6tmQxe2j
	 6iJC2uPYO26a8tzYQvGTkh872V4Z3D7A+ppkPzOnWX4exp/rICvlz6jJs+PFMrM72oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D3HVgW8u;
	arc=none smtp.remote-ip=95.215.58.34
Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E252606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E252606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D3HVgW8u
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DhZfvcVUIAIZszQSJBwAYpMOK0X26Pzmzgl/OqwUSZI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792976212; v=1; x=1793581012;
 b=D3HVgW8u+Is1mGe+u+pOX/SkrZtonVjGkXjBIqj0GBsj+Rc8JDSpV3aWyYoVKQdhzmmU1+wm
 8r0ZVJ801W+QlSPfzu9ykiPFe7+evZWPLIcrsiCL4fXZHzHQN9fAE2VZrVh0Takx0cAQMGu14fd
 VAmXyfHnCnUf+9evqXJvr2zw=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0f3592458cc6a98b;
	Mon, 26 Oct 2026 00:56:52 +0000
X-Mizu-Trace-ID: 0f3592458cc6a98b
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 08:56:44 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Message-ID: <at6lTNHwA1V9Xja9@fedora>
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
 <atsRW-aYHeB-cEgi@fedora>
 <CAF+_u5Byu9BccKQpZ9VcXAb-fMEhpKAD9A65LktLDJ77ng+KfQ@mail.gmail.com>
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
In-Reply-To: <CAF+_u5Byu9BccKQpZ9VcXAb-fMEhpKAD9A65LktLDJ77ng+KfQ@mail.gmail.com>

On Fri, Oct 23, 2026 at 03:35:57PM +0300, Timur Stukan wrote:
> On Fri, 23 Oct 2026 at 10:48, Hangbin Liu <hangbin.liu@linux.dev> wrote:
> 
> > >  static void bond_miimon_commit(struct bonding *bond)
> > >  {
> > >       struct slave *slave, *primary, *active;
> > > @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
> > >                       err = bond_update_speed_duplex(slave);
> > >                       netdev_unlock_ops(slave->dev);
> > >                       if (err && bond_needs_speed_duplex(bond)) {
> > > -                             slave->link = BOND_LINK_DOWN;
> >
> > Hmm, this issue only happens when link_state is on
> >
> >         netif_running(slave->dev) && netif_carrier_ok(slave->dev);
> >
> > while !netif_device_present. Should we set the link up when device detached?
> 
> 
> Hi Hangbin,
> 
> Thanks for the review and the suggestion.
> 
> A detached device is one way to get there, but it does not cover all
> the ways to hit this bug. In particular, it does not cover the case i
> reproduced: during inspect both link_state and netif_device_present()
> are true, but the carrier is lost after inspect and before commit, so
> reading speed/duplex fails in commit.

Hi Timur,

Thanks for the explain, but the same question to this patch. How do you
make sure the carrier is not lost during bond_miimon_inspect() and 
this slave->link_prev_state setting?

Thanks
Hangbin
