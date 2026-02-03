Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C9201113
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126438; cv=none; b=jknaNju8bO++A7YBhA/8lF6ENzLiBYV38x8juPgIXD1BcjDfNhRDtuMztsuEFgs5NaJUHRhTAaaGpqbV5Pz15+RVRY7SVnoHIXDMAgGxay4GRP3vO6GiUteoU5t2pEMNR0Xgha9dB94BuqSMbDpC4RzQuHVKE90QrmvfkkX8cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126438; c=relaxed/simple;
	bh=6+kTkjRJbfXiaHW0+AGas7RjaKSk5o8znQIJ3GHIHVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZQze49XuItVLY6JNPboPJnLoBUVPALenynrdko8yopev3Jyo/rnbw4k6jla+XaS7puLZotOIYTKq0XVmfHlySxFkNaeAfgcZ0NPn22fiFKQWx3Sux14mXYNxz/RyeSxzMOZwHYAHlmFkupC+pauDLvufsV8GsSKi9e0QMKwwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45bxZaTl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/NqU2Fz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45bxZaTl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/NqU2Fz"
Date: Tue, 3 Feb 2026 14:47:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770126434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM8phpfWBsZwaIYtVkmV50nAWvOzsolS5Jj56q1+LBc=;
	b=45bxZaTlt+COGLhGQNeqo+M5KE+7Cvgex6Bgbwqjw2JY36X0a8ulnJk9ySJOfNp36MpXpo
	yr4GiyT8aqRQVRWEBJu3gn9PXdL+znoRcPQDOPbYWXM4saafpbdJBrV8aJXwcRev74ReWB
	berotZv9FRcrC3wUY4PGPBH3vUc+dPfx+5osN0ai5EOHtSfGagnN81hfBa9B1sz+jB+VgY
	A1YT5Ro3Dpi3CfCOP19E/zR0zXzAnRn2A6sxSNvyk+DDC++Woo3cLnBOZjGJCXKuYQf+ut
	lZQEA1BZvxn+rFgt5A7cR8uuOrsnYx8l09zs5H3oKdgANW315RDCKajm72QtJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770126434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM8phpfWBsZwaIYtVkmV50nAWvOzsolS5Jj56q1+LBc=;
	b=0/NqU2FzbUUVFI7nCuml3OvS/tyZ8ViH9muxsCQZqdsbgrcXGehqZbOAOIJuV8XjruL/cZ
	4UEu8X1s0Uyx3QAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <20260203134712.Q1vJp5UQ@linutronix.de>
References: <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
 <aYCPsDZeJvCrJYRH@thinkpad>
 <20260202155510.C1zpsxnk@linutronix.de>
 <aYHJ9KHdiBEGfjwA@thinkpad>
 <20260203115526._PRE3nvY@linutronix.de>
 <aYHo1uEK2e8Vg4WM@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHo1uEK2e8Vg4WM@thinkpad>

On 2026-02-03 13:23:50 [+0100], Felix Maurer wrote:
> But like you, I'm uncertain what would be the right thing to do and
> which port should control the MAC for all the others.

At the very least I need the same MAC on both ends for PTP.
Now that check the spec, 5.2.1.1 "HSR handling of multicast frames",
bottom below Figure 10, says it sends the frame over frame A and frame B
oder the ports. The "src-MAC + sequence number" uniquely identify the
same frame.
Now I am certain that the two different MACs are wrong. Let deal with
this later and then decide what to do about the testsuite.

> Thanks,
>    Felix

Sebastian
