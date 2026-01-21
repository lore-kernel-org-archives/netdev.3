Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDB31A062
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015338; cv=none; b=VbEBC1MDePxTvlgnumJbQDGx0Z4XVZ6nHb69MDWIPutQIdEgl/PP6188AcgXVJ3iMa7p71nhnojvh4T3TMad6f59LuhARJzbfrOxOjzhbo3JAa066nU7f25yrOTJxPFq6H1nRE5qWHsL24zZWxlEghMrXwW7oTb2JiR+em5pyUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015338; c=relaxed/simple;
	bh=taF/xhpC9Yd/tH0X9On23yPZftj4Fewoh8MwRyiQz9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAVDVw4QGT5dFIcQl8LgRFg1Nc8uuLLB5sH2s0SBz+jLhBhUOmgIxV4hhac91jBriphTyidovXIsXMv3DCJxthgy10gxlMSud+4idD7GrJmDuMTW1bh1pt2H5VPCfoU1KuMBNqEKo3O4qW7VVjopub+20nvGWlCVNqJQpT2OTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awk2mLyQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awk2mLyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8A5C4CEF1;
	Wed, 21 Jan 2026 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769015337;
	bh=taF/xhpC9Yd/tH0X9On23yPZftj4Fewoh8MwRyiQz9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awk2mLyQN3A2m0V4ASYdRqlk3UEJnMsiN5fCua3CYBB/yW51Bdb9FcpjcoiXGox+h
	 /NgMtK27+w33l9tGFCZ2R4feQovaTFnC8iGb0IOfGaWUoSzmiI6gAeNfKGJoqyr661
	 8jmZe1YQ4h5OMBW+VYenkHWVPYKluGsRAdJTWFo8XGV7H6zWaSFrYTShM1tCQTGANO
	 uBL9hKJIoEv18YEKrUO9AKued42ces6jkBxEVuytQy5Rh7Tg1j4FKtpYMsCdoRPaMF
	 f+O2wCyaTDzLGAghYckXOUC4IIvozsuy2OMJaDEmbdrMv43LplhbyrANWtj1+2iPLO
	 I0ZRF+z7OYOTw==
Date: Wed, 21 Jan 2026 17:08:52 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	William Liu <will@willsroot.io>, Savy <savy@syst3mfailure.io>,
	netdev@vger.kernel.org
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <aXEIJEiRJb3hfP5n@horms.kernel.org>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
 <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>

On Sun, Jan 18, 2026 at 10:07:37AM -0500, Jamal Hadi Salim wrote:
> On Sun, Jan 18, 2026 at 1:16 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > This patchset fixes the infinite loops due to duplication in netem, the
> > real root cause of this problem is enqueuing to the root qdisc, which is
> > now changed to enqueuing to the same qdisc. This is more reasonable,
> > more intuitive from users' perspective, less error-prone and more elegant
> > from kernel developers' perspective.
> >
> > Please see more details in patch 4/9 which contains two pages of detailed
> > explanation including why it is safe and better.
> >
> > This reverts the offending commits from William which clearly broke
> > mq+netem use cases, as reported by two users.
> >
> > All the TC test cases pass with this patchset.
> >
> 
> These patches should not be considered for any review because they are
> not following the rules that are set for the community. The rules,
> which are well documented, state that you must cc all stakeholders.
> When someone does this _on purpose_ such as Cong, some accountability
> needs to be imposed. I would say totally ignoring these patches is one
> option. Otherwise anyone can just throw a tantrum and decide those
> rules dont apply to them. Either that or we modify the rules to state
> it is ok to do this..

I'd prefer if we applied Hanlon's razor here and attribute this to
carelessness rather than mailce.

Please let's find a way to move this forward.
