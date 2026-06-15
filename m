Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00440F8C5;
	Mon, 15 Jun 2026 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542444; cv=none; b=fcAdwTdfKC68EPphqiJPjyQQAMA0mH7TF3nRT9fqnAdsEiaEyi1y99ctc50JCe5ngVsTcC1ueIC8n8XDxDhUA7kRF972Y0QN1LMVnzZalSlzrsitS7QQf21KPfFRqw+LB2mnTvu9lzTW0AU8JMLrbAi7hS6H4OF/kGp+Tijsbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542444; c=relaxed/simple;
	bh=uaptR4eB/ksjA8/Crygio18xgxXnoIhbgU+ERQEvnRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9xADFLjzU/o7OPP7SGHEuB40OMFTS6cI11oeUWBxE0MnzwCmc0RmjVFMWc633UpbqZNi13mpLn8xT3d6/DzzpTHY+Ft4hPv9+7jRWYfIJjT/QJCn6DJ032Fq1HD7MIP/yMHBdmTqsyfSV5/ycgsZaH4ta/21ddfmf71hm4luOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXE4LLhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXE4LLhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B1E1F000E9;
	Mon, 15 Jun 2026 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542443;
	bh=c7VLpTjiJlPakzgidAeJWFZIvAEOGJqmv9AoRpZJbBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kXE4LLhyWtex2w1o3Y41tplzjao1nvvTI72/KjlE6bHni7vXnToVnpVilqYDDx8F4
	 L+CY8m29jNCP+2TAEmeAcbJZQyjts64yCdPMC5oHJI0xqJgRxgViiDvmEv0lyRNSML
	 eJjEAGI0qEkjRFO3Ic8FammvCBS2lM+6EjpnqlnMJO9sO9A7KhnV3QbYmQqh1bJGVg
	 iubgo3QFBIFUWHP32XZZYDMgqP4lc6dlLJ3tKbUMfIDLr3GM6ytmqMg8857MzNWQ59
	 khaT+5Rt086Klxfy76Hs/mGc6S0WBXcULigcTPOgU9Y7DtiCCyelmKQ5lvHCZUsR6q
	 2JoyeCW/NvVfw==
Date: Mon, 15 Jun 2026 09:54:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
Cc: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <20260615095401.4be9706c@kernel.org>
In-Reply-To: <4dvydmir7hw4zhfrxonjuu4l7as6hma5yg4iuv3vgoqed7zai6@knkmyvh4sa54>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
	<20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
	<20260612153656.4c5b8c62@kernel.org>
	<4dvydmir7hw4zhfrxonjuu4l7as6hma5yg4iuv3vgoqed7zai6@knkmyvh4sa54>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:29:34 +0200 Cedric Jehasse wrote:
> > > +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> > > +				  struct tc_cbs_qopt_offload *cbs)  
> > 
> > please stick an extack into struct tc_cbs_qopt_offload and use it to
> > report the reason for rejection back to the user
> 
> Do you mean modifying cbs_enable_offload to report a driver specified reason isof
> reportig the generic "Specified device failed to setup cbs hardware offload"?
> What should be done for other drivers who handle TC_SETUP_QDISC_CBS, but don't
> fill in extack? Should cbs_enable_offload fill in extack with "Specified device
> failed to setup cbs hardware offload"?

There's a "weak" version of the extack-setting macro which you can use
to avoid overriding the driver-specified message. With that you should
be able to set the generic error for existing switches while allowing
your driver to provide more specific reason.

BTW please note that net-next is now closed for the duration of the
merge window.
