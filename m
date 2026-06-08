Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59F2D73A6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963109; cv=none; b=IT7fOR0qoESVnLCLa/L2a75ooAd5A7JO86/sN+kTnaniH6hxKWYWGwATPfNvwtuOhI/Ie9xZALannluuxi5QSr4vl+hn6QWKS6DFfbn6YgLWAtm1qVl65qo/GsGhZFHe5TpgT+8fiLdIxq0mPBdA2Vr1z3xXghK/WIxij5B6up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963109; c=relaxed/simple;
	bh=VK7Vqow+LqCery+/hsHgtw8qYAMwYsSWaSrW7ccFX/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ6eeQLN0XefBpW/SrZSjun/fCFze7v/qbfWg/2tt1DOkuusW9nj9RGn1UsgxqEypLWT5IGesEvPgo4BjaIjLL/G1IkN6rSLcitn55+A/2WHJG5T4Zl/8hH1SSeAK1RFMKeFspWTU4rs7MisGuapeNs9HVBPRyjeqzoqApXzGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABy1IeMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABy1IeMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053341F00893;
	Mon,  8 Jun 2026 23:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780963107;
	bh=SpuO1pUoTIrSq1m5OY7yRHg7Tt7TntzPrjMkqWCxi7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ABy1IeMIu38/22RtGd/Zcr1xfUCr2WSirekSf1B9bUzvCJk1OqV3vufmuJICClxSS
	 Og/X1/9rsCFMRxEZl40MlVZ00TbLdynqPCWF4xDEeGvOzU0FZ4ygmchEg54dVGOm4W
	 dVA7SteMYjjx1urtwTgQ4bCrZrKFsb2gD0gyuxwsvTOowU7JIc9pLYMJqcCWcV9YkS
	 frzrqph3LJqf+HgsTavZpK/e9oVZzR3SqBhWsKrNte5Soov184WfblVnATZegNx4/r
	 v4CKr1fc7NGxuWhiockONbi3UD/lEPNmWgEFSNC1DNW9XHbr/9JJ7L78ZqeITlUO33
	 rxxLdA4ceUThA==
Date: Mon, 8 Jun 2026 16:58:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <michael.chan@broadcom.com>, <hkallweit1@gmail.com>,
 <maxime.chevallier@bootlin.com>, <joshwash@google.com>,
 <tariqt@nvidia.com>, <alexanderduyck@fb.com>, <willemb@google.com>,
 <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
 <jakub@cloudflare.com>, <nb@tipi-net.de>
Subject: Re: [PATCH net-next v2 05/12] net: ethtool: optionally skip
 rtnl_lock on Netlink path for SET ops
Message-ID: <20260608165826.2525b726@kernel.org>
In-Reply-To: <ce45017d-8caf-4b4c-b04a-44806bcf5e72@intel.com>
References: <20260605002912.3456868-1-kuba@kernel.org>
	<20260605002912.3456868-6-kuba@kernel.org>
	<ce45017d-8caf-4b4c-b04a-44806bcf5e72@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 15:15:48 -0700 Jacob Keller wrote:
> > @@ -935,7 +935,13 @@ struct kernel_ethtool_ts_info {
> >   * these bits separate, per GET and SET. GET is much easier to "unlock".
> >   */
> >  #define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
> > -#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SPFLAGS		BIT(1)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM	BIT(2)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SCHANNELS		BIT(3)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SCOALESCE		BIT(4)
> > +#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(5)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
> > +#define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)  
> 
> Whats the reasoning for changing order here? Is this sorted somehow?

I went back and forth on this a little but at the end I wanted the GET
and SET bits to be next to each other (PAUSE ones specifically, that's
the only case where phylink forces us to add a GET bit).

> Would it make more sense to use an enum to define the bits instead so
> that patches don't have to do a -/+ of the same NAME?

We'd need to add enum for bit ids and then defines for BIT(id)?
Dunno, personally I don't really like that. And we never switch
on the values here so enum buys us little. Maybe BTF, that's about it?
