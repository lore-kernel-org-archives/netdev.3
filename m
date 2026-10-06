Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CD3B2D0A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326709; cv=none; b=uoRqGh1s4RU9EpeRlVwVR1XHYfz9SI4qC4fXETFvrkwK2GE5eeKpz8ndeTPibYBjfoEf7qITl7ONKVFD7r5iMuXbeYp76L94gk9MBy4oqZmPfzmf2X/tl4Qp8VPypzPjJxvWx6UCraw9EgdM/NBuCa7wnR5iGc4Up3iB63T/S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326709; c=relaxed/simple;
	bh=Po4CubYmpzshj/b95OwHjNpNV2VhSvEGKh2Cuy8eVTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpRperXos9kPlLqNUYYm5S7U8XwzbJUYKX+hDRm4L4RMFN4prHm1ID7/Vmmsop/L4s6FCU91IRs/rWOMyELAALdmqPaeLBa2zrfG/asWGW9zkLPpKAJBUfYx3AmwQ53ltgNoZ/8fQueeBjNr2njT42IyQLsKCpirhwdyNDdv7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJGYDNsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJGYDNsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859BC1F0089B;
	Tue,  6 Oct 2026 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326648;
	bh=EkrhbIbqd60I6p2DSLDTwk/2TO37DH7Mz6i1AOqruL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jJGYDNsYhdvzERg1NK2JsBDOoxDblcqaY6OWRUuYNlH8z3pr5dMOtSa5zIQs/dMUy
	 sVlZ1eiY9YZTyDMbrX4qz0wN5ohpJwrBWt+slHuQ+4SXN4BMcdwsCsJbkMeTSGbDCG
	 2Ep3/atnu74/plyr8OeK5+t+maaltTMO4OwHel3GN65h+9cXmkFJB/63m8POFuArhH
	 4uGoGnqQmzidpNUwPUWB5rtaha+1bN3BiQIMQUCHOTIW8c588ZfBV9USweX0aVRkwx
	 2tkAZZMbucoVXXQORS7pYnnfxpy3LGf/O0eljzkWsbkJ5ih8TIWF7Eh/yLn/ed8kdh
	 7pBDrutDzQEFQ==
Date: Tue, 6 Oct 2026 15:44:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in
 SW_RESET, restore it to SW_RESET
Message-ID: <20261006154407.64ecac6b@kernel.org>
In-Reply-To: <a1dc7c80-acef-479b-ad03-dc83164d77c2@broadcom.com>
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
	<179080972360.31693.266631430009737406@kernel.org>
	<20261001184130.2b7ab18a@kernel.org>
	<897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
	<20261005182721.776af8b8@kernel.org>
	<a1dc7c80-acef-479b-ad03-dc83164d77c2@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 15:29:01 -0700 Justin Chen wrote:
> On 10/5/26 6:27 PM, Jakub Kicinski wrote:
> > On Fri, 2 Oct 2026 09:16:15 -0700 Justin Chen wrote:  
> >> The issue was hit in production and I verified the sequence keeps the TX
> >> disabled in my standalone test. I tested on an internal development
> >> board with bcm77122, but should be reproducible on any genet HW that
> >> supports power management.  
> > 
> > I obviously meant that you should respond to all the fix info requests.
> > Not just this one in particular.  
> 
> Sorry Jakub, I am not understanding what you are asking for. I believe I 
> answered the questions above? Or am I missing something else?

I mean other threads, immediate example:

https://lore.kernel.org/all/20260929203400.1588868-1-justin.chen@broadcom.com/
