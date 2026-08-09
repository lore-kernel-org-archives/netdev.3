Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41C2E401;
	Sun,  9 Aug 2026 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786316397; cv=none; b=k4r+HQRjs1v38CcTw3xLIPUL871M33Q5p9S0tLv4wGlpUhcuXlB3/DvnpzI0P1a4lfabeocQQHfgj1zL9VF0kO6myWuKqS4BXb1mqgFvsA9nLBztGhMO8Hs3nZnlUq3fPgLDLyI+INg8hdP3Q8o5c/+QXcr1G0wFAK+jNm3Z8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786316397; c=relaxed/simple;
	bh=MeG1JHCxdTPYhdA8gPrNnSG128VlzDImgDHYuaWWVzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTGOKHCC9IoIgD0k0qbtp4QR3DHFds72KKW/Lptdp/+dh6ih/Glqk8CLFB4By7dI7v8b0EZ20MFc0qIrXYCnsJXy5PJT+jVD4kQh15hWlFyYM68JwMfNGzLhmG2xA3v3EZv9gWb+L7JUMN3X4OVkNBtDfX/pE73VHatOznXl+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeypgvGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeypgvGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E47C1F000E9;
	Sun,  9 Aug 2026 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786316395;
	bh=uCfs6JnngAsCGxEZurlWbRhpnJV4fGj9ne3IG+7xnkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EeypgvGaQp3oTRLtItcMXqwCbePkxd10FJR7CtYiHWGK/I1/EhTr3Eml2jA4XA2+a
	 RL9gzA3psIjU7NCtsxyA40tVOfhPoWOHmFTOzhhyoNNZhvFlno7k/h509sd9APtFKa
	 LZD1BmZkK8/Er6Y3MfT8KLVDx7smFLPEADz5LzdffFiuAnTj1YOpdKMQcUd7LYsxVL
	 s/tPnn02gsljvC7Bq4xmaoPAxJxxPIhngIrJxIwjEjdk6/3LMzCTgOKYKjuS5+ORwG
	 gnm+7unM0athgwP/duJfT9Eox/MMYScr3QAIpY1GJPT0Sln0LK7nMdR+K/4CZk82lM
	 qk7trScXkxOZg==
Received: by pali.im (Postfix)
	id 68D297C6; Mon, 10 Aug 2026 00:59:54 +0200 (CEST)
Date: Mon, 10 Aug 2026 00:59:54 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Guillaume Nault <gnault@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Michal Ostrowski <mostrows@gmail.com>
Subject: Re: [RFC net-next] pppoe: remove session socket receive support
Message-ID: <20260809225954.i36fajv6twbnjfdp@pali>
References: <20260806091626.231225-1-qingfang.deng@linux.dev>
 <20260809145836.5pqf2rgf574fjlds@pali>
 <76232f9c-2a5a-454a-905e-e046b6c78cef@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76232f9c-2a5a-454a-905e-e046b6c78cef@linux.dev>
User-Agent: NeoMutt/20180716

On Monday 10 August 2026 00:17:14 Qingfang Deng wrote:
> Hi Pali,
> 
> On 8/9/2026 10:58 PM, Pali Rohár wrote:
> > Hello, I would like to point out that "no know open source
> > userspace implementation" does not have to mean that there cannot be
> > some closed source or not publicly available. But I agree that
> > probability is too low.
> > 
> > Anyway, could you describe what is this functionality (which is being
> > removed) doing? Or how to use it? From the code and description I have
> > not figure out how it is suppose to be used or for what kind of scenario
> > or use case can be it hypothetically used.
> > 
> > Would be nice to know what exactly is being removing and what userspace
> > applications cannot do after applying this change.
> 
> pppoe_recvmsg()/sendmsg() can be used to receive/send PPPoE session packets
> without the generic layer. I just found out that the RP-PPPoE package,
> maintained by Dianne Skoll, actually provides a standalone PPPoE client that
> does not depend on pppd and instead uses these syscalls. So long as the
> package is still being maintained, these syscalls should not be removed.

Yes, that is right. I completely forgot that there are real userspace
implementations of PPPoE which are in use. RP-PPPoE is one of them.
RP-PPPoE provides plugin for pppd, but that plugin does not use kernel
PPPoE module.

> The state transition still needs to be fixed, though. It's done by the
> PPPIOCGCHAN ioctl. Note that despite the "Getter" semantic, it actually
> alters a socket's internal state by setting the PPPOX_BOUND bit, to indicate
> that the socket is now "bound" to the generic PPP layer. The code is carried
> over from the very first version of the PPPoX driver and the intention of
> this behavior was not known. A fix may move the transition to a non-getter
> ioctl and drain the socket receive queue once a socket is bound.
> 
> Best regards,
> Qingfang

I see. Maybe you could ask developers of the first version of driver if
they remember something. But probably nobody would remember old things.

Clearing the queue after the transition happens sounds like a good idea.
If I understand correctly, it does not make sense to get packets into
userspace once the socket is bound to PPP layer.

I have feeling that kernel PPP layer and its API do fully fit into the
API for network devices and netlink layer for userspace.
