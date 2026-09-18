Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652233E37C
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694520; cv=none; b=gkekuJaVkGt/cNTdeF2I0OkZ4UKMqooMa0iB0ZSC1cI+guaTC0hTbivS9c5jeaxRZNXx6OW5Tzbw+afuq4z6nL1uBWW9l4OZvUkr8vbMBHL/X+FRPzmN4CEkTuwYkCBbiLvqXeqnwJdQQTIqEFDwR9t8N52UKJCTGIXR5Ia9NXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694520; c=relaxed/simple;
	bh=Xi9eL4d4hMDRGCb9z6Ta5RvUROUt5QZcMZ129BHXcBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ur6LRymuXvcvYRE9BwsE5yyfx03fUcpWn4UeOhLU4I0Tr0QOl7uN6CD7LhXRxrZU0xsqhVm4GhKAJXExFMvOCiWwxs1VjZ+ZGeioIgUa/35XS5Uv+aqGl4PSRTnrgDtjZ3Qf3/lU7+TcYd7bEEQkTYlizRiMFYdd4CtNKHnMPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUXIGsjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUXIGsjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265EA1F000FF;
	Fri, 18 Sep 2026 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789694507;
	bh=Pqm43CgpdMLS1zJieh+jstydu6YsvOVemfklh6ruDdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hUXIGsjNhK4aqN/Gjsz5EJtRtdkocifgaISflB589wvR8NFha3wx/YwAOWhlreXDx
	 OSO8msHmw1FPHNkNfjJ9WeLj0fZf1FSFplmxl0PNC8ONkye8A6coxTK75n0vMv9xS5
	 2zvJS1MhgTZqz3Bo6+gkYJfKciN8+lgdMfsChBFTevJIVGUXfeHE9RC3gudHJdZYYk
	 GwR/Go5mxfgPso3Rcn22MajV1RRhNozba3QoMeiFL9QhGd6qLTQT6S9g4yIFzNWIEG
	 QG918XIarLtSNS+zC+6n4HhYABy1F7v0js+dqQEYi7B3Wv/CpnOjVArBxpi2BeJeUQ
	 0LDGmQyy9ioqw==
Date: Thu, 17 Sep 2026 18:21:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, tariqt@nvidia.com, moshe@nvidia.com,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next v2 3/9] netlink: specs: devlink: describe
 DEVLINK_ATTR_NESTED_DEVLINK
Message-ID: <20260917182146.228f838f@kernel.org>
In-Reply-To: <178958611988.22033.2838182170584631797@kernel.org>
References: <20260915161341.1053476-4-kuba@kernel.org>
	<178958611988.22033.2838182170584631797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 19:15:19 +0000 netdev-bot+sashiko@kernel.org wrote:
> > +      -
> > +        name: netns-id  
>                 ^^^^^^^^^
> 
> [Severity: Medium]
> Is the inherited type right for netns-id here?  Since this is a
> subset-of set, it picks up the main devlink set declaration:
> 
>       -
>         name: netns-id
>         type: u32

As previously mentioned, negative netns-ids is something for a separate
discussion. In practice since only negative value that can be output is
-1 == "invalid", this has limited impact even on the convenience. 
The bigger question is whether we should be outputting error ids in 
the first place. I don't want to switch to signed in case we decided
that we don't.
