Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39741A933
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554202; cv=none; b=TVcwiUi+UJpNgCQ4NH9pPRtHJt0yjgkQ6UAN4JcGwK0JlJX6FPyjvcfPO21ha19duVY5QdL2Y3In3xuJXNZGgOkqKrxdTrcmAjPc5hJW/KNIdWzYS4PT6gF/coVeWko6MQ/tlpAHUaE+R8mBXah2ZA1bZHec9/lwaPWsfi8ZKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554202; c=relaxed/simple;
	bh=TJ2l82WkNTY3w07BL1Ch/cJ1FaLOGyUNNojmtkOqn0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMAMsl8MD0KF4jcEu09zRVBKJE3VvNcp99dgMKkx2WNYGbFgYdlqfBLWUWRs7ZN3mRPjIv3d2YrqidwcoQQo0gmAoTaVoaRrlKJ76uMYyiR05iI6xxgkOEckNueouR+Pwrxd8eon09/d7MOqErHgA439CA7mfFu0JmBRDRHkn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MqVvswga; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MqVvswga"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bq5ius1EjmwJyMWo0MoJnmHtNICufx14c1DB4U1d7yk=; b=MqVvswganddWcScN6hya6lZhVZ
	XfCQKANwQk8asjeSAE75kjrog52/kyfEXHWKOFTrOMinb/X15pe2cJuBI7+dZjLNgU1uJW7Y0DrvK
	3ScNi1rRbaONc6G2HYmpY1VNI3QUVu+Rcg5Dhg8nrDySNn6lS5KwahROZlasVwKc0cEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlo4A-00DGWe-1n; Mon, 20 Jul 2026 15:29:54 +0200
Date: Mon, 20 Jul 2026 15:29:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Ren Wei <enjou1224z@gmail.com>, xuyuqiabc@gmail.com,
	netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
	echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	pshelar@ovn.org, yihung.wei@gmail.com, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
Message-ID: <c9a39c7f-cdad-4e8d-b516-b727806525a0@lunn.ch>
References: <cover.1784355642.git.xuyuqiabc@gmail.com>
 <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
 <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch>
 <0c037f98-f219-4851-9a06-e83b25ca0f7e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c037f98-f219-4851-9a06-e83b25ca0f7e@gmail.com>

On Sun, Jul 19, 2026 at 11:54:31PM -0700, Yuan Tan wrote:
> 
> On 7/19/26 19:52, Andrew Lunn wrote:
> > On Mon, Jul 20, 2026 at 10:14:16AM +0800, Ren Wei wrote:
> >> From: Yuqi Xu <xuyuqiabc@gmail.com>
> >>
> >> Packet processing uses CT limit state under RCU, while netns teardown
> >> frees that state under ovs_mutex. The CT limit pointer was neither removed
> >> from readers nor protected by a grace period, allowing packet processing to
> >> dereference the freed state.
> >>
> >> Replace the pointer before freeing the CT limit state. Wait for in-flight
> >> RCU readers before freeing its contents. Serialize CT limit netlink
> >> operations with teardown for the full lifetime of their state accesses.
> >>
> >> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Vega <vega@nebusec.ai>
> > Is Vega a person?
> 
> Hi Andrew,
> 
> Thank you very much for your review!
> For context, we had previously understood that using the tool name in
> the Reported-by tag was acceptable, based on examples such as
> Reported-by: AutonomousCodeSecurity@microsoft.com and Reported-by:
> Anthropic.
> 
> https://lore.kernel.org/all/20260630171016.11c02dec@kernel.org/

https://docs.kernel.org/process/submitting-patches.html

  The Reported-by tag gives credit to people who find bugs and report
  them and it hopefully inspires them to help us again in the
  future. The tag is intended for bugs; please do not use it to credit
  feature requests. The tag should be followed by a Closes: tag
  pointing to the report, unless the report is not available on the
  web.

If you believe this is out of date, please submit a patch with new
text to this document.

I find it valuable being a person. It indicate somebody is bothered by
the problem you are fixing. We see a lot theoretical bug fixes, which
in practice nobody ever hit. I would prefer to spend my time reviewing
real issues, not theoretical issues, and the Reported-by: is a quick
indicator of this.

> >> Assisted-by: Codex:GPT-5.4
> >> Co-developed-by: Nan Li <tonanli66@gmail.com>
> >> Signed-off-by: Nan Li <tonanli66@gmail.com>
> >> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> >> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> > Please take a look at
> > https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> > and the sections that follow. What is listed here does not follow the
> > rules.

After reading this document, did you spot the second issues?

      Andrew
