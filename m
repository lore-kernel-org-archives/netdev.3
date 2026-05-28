Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A43AEF4C;
	Thu, 28 May 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963124; cv=none; b=tcdT/Q1p5JZI412KybkPPTAwPiXALFDxgwPqXeUrLkK2Gp1vhq97zlf2v9iEcm/MkIHHynPsaAwhDtkfyss++PcYbtE0B3KoqJSp2V8YlEebckfIjEBUSoHCiOD9lla67Ee8jMUBIjdNQ3ZRy19rceJBW5IdrWodJdVNn41Ba5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963124; c=relaxed/simple;
	bh=7yTG+lx3lbuBusqJZuhP5mXRw8+u7d9OD3odjCDRP6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keql20Rhp5foOnn1YLglII8Zcvzc1gN+KlEh1H3nhB+UtPP2VrR5bf8HqtmzSGGo87sYn123kZenCc6oD1gEO26oHx+aqRT286GNPu8KRKSpI7TOU6YkJKDXlmVQXukDIoX085ne77FIL5N2FQecew3et06nyr3lPwB3cE5UmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3KKbXSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3KKbXSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F85C1F000E9;
	Thu, 28 May 2026 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963123;
	bh=fUFcaEaWayC7DDmcV0ClxnFtppOwFf9S7ot4EM1JWXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W3KKbXSStDUrT71Q6zfWAIL/GB31mhrcZJCxyGCrC2CvINdIjr6tULHoqhE5G3nn7
	 YB2LfFWT3QlLyMA0c8/KInrQcQdbxh5+bmg4h8sFLjrRvI6k7Vf32P6dq7gjRIbnpf
	 qAiZZYpZ27MFqO1BOkom5KJhg5Fv7PbmL7rvJ3KEcEIH+ZYxP9aUXw+8L1j092OJjU
	 GO4RhWPXIt339uYJ8ZychL06YvRIj9GixUGlqBAP8ObJb1fOZqV1en8m7FYOSzrruG
	 RmJ7vMKYbpFYXv4/trGeC4FEZkAaYACml+G+JtW2PuVYNc6nODaH2PHy/frKApm4kq
	 FJMUyOGpdSJpg==
Date: Thu, 28 May 2026 11:11:58 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Qing Ming <a0yami@mailbox.org>, Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovpn: avoid putting unrelated P2P peer on socket release
Message-ID: <20260528101158.GR2256768@horms.kernel.org>
References: <20260523081543.94507-1-a0yami@mailbox.org>
 <20260527085510.GF2256768@horms.kernel.org>
 <10ea92d8-f4f6-462a-a76d-729cfa1715e1@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ea92d8-f4f6-462a-a76d-729cfa1715e1@openvpn.net>

On Wed, May 27, 2026 at 02:45:03PM +0200, Antonio Quartulli wrote:
> Hi,
> 
> On 27/05/2026 10:55, Simon Horman wrote:
> > On Sat, May 23, 2026 at 04:15:43PM +0800, Qing Ming wrote:

...

> > It is probably not necessary to resubmit because of this,
> > but for future reference bug fixes for code present in the net tree
> > should be targeted at that tree like this:
> > 
> > 	Subject: [PATCH net] ...
> > 
> > You can see more about the Networking development workflow here:
> > https://docs.kernel.org/process/maintainer-netdev.html
> > 
> 
> Thanks for spotting this!
> I'll queue this patch in my tree and send it to net soon.
> 
> > 
> > FTR, there is an AI-generated review of this patchset available on
> > sashiko.dev. I do not believe it should effect the progress of this patch.
> > But, rather, be considered in the context of possible follow-up.
> > 
> 
> We are already actively working on all pre-existing issues.
> 
> Posted fixes can be seen on the openvpn-devel mailing list.
> 
> We are triaging patches there first (Sashiko is picking them up too) to
> avoid clogging netdev.

Thanks Antonio, got it.

...
