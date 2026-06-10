Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8153403AE0;
	Wed, 10 Jun 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104159; cv=none; b=gSIPy1RtF2eJoMPhZ6xZMuzJ0W/mlJTcLaMDr3/ToNsoy6M+p85Qkh55+++MKCoDDkbCk7nDjpuvTYrFF7YxH79l11oivaaEeQtPvBI40Y7ihz7k+U/FWfX+S9Ume9yWIJaW6NRWo3XE0//Cp/Rp15MZ2eG4tzkaGX+bWAZpxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104159; c=relaxed/simple;
	bh=tA/untSj+tG9lh2v33r52Qa+XsXymVWnkc/1XyFydK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHux8lsAHdrlrkgh7UdBYtCHif13XSIGlSpzYxsJYSGqzuNyyplM30lXkdMsr6cWWuNaPoNA7q69Y+8bStJFPGIHVOJfgkMhNDe3HSA7XCOSNSP+dyC7M/Sc1Qk8n1Jnxv/+L0C/ck4LDcev9SnRw1X0t7FVpyC/KjccWn0Hog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm8/SNaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm8/SNaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3D1F00893;
	Wed, 10 Jun 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104158;
	bh=2riMH4v7nCtM5EEVBOarO8veqFiO7ntvGyqzsKAqWeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zm8/SNaXaxCusjb4qlDFNpCGen9YFklQkXWpYet1o8XCsSMib5Je9x8JF6qAIRvGz
	 ZN/+sTh8R4VQqqyMdCWPfcXotZduIjxeHKMybZFP0H9RWP2pzyHRmbzbJcaV0oka2I
	 AaW9SIABBO7qa9BkIM5L+xGN1Pb9gM02i5anMRg1V7zDpab6Ahe+bmb3ozSRbQS/kC
	 7aC5h5JgY4mwWbRtZdi3jo8ZW2bFmUl4IV734AbEGFwi0/vClNpxy38WCa/wrK7qit
	 TFd7X+qPKxGoalpMoixIW1Z2sBUzSOC3x4ecylrgS2BhKWehfRfWSTMQlabv6P+5Um
	 z8lgam4G/f7kA==
Date: Wed, 10 Jun 2026 08:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net/sched: act_csum: skip malformed IPv4 headers
Message-ID: <20260610080917.52135297@kernel.org>
In-Reply-To: <20260605152916.2125473-1-sam.moelius@trailofbits.com>
References: <20260605152916.2125473-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 15:29:15 +0000 Samuel Moelius wrote:
> act_csum trusts the IPv4 IHL field before using it to locate transport
> header fields.  Packets with an invalid short IHL can make the action
> write checksum data into the IPv4 header instead of the intended L4
> header.
> 
> The action should not repair or modify packets whose IPv4 header length
> is invalid.  Treat those packets as not eligible for checksum repair and
> leave the configured action result unchanged.

I could be wrong but I think we were trying to prevent such packets
from getting in rather than fix all the places that call ip_hdr()?
Someone please correct me if I'm wrong, or ack this, otherwise I'll
toss this patch..
-- 
pw-bot: reject
