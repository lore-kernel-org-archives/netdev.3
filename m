Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B403559E5;
	Thu, 22 Jan 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106775; cv=none; b=RhSGxu7UaCfVz6lDtENaCcSqS6EN33+NHWLsVQSA8lnJGcZKBpGkAvMxQbPPvElAtU6b+OPmdb2/1igv80bVLNvBQVllQddVNXuheLf/Sd/fJHtka4ufaJVcri8k2rjiVp4DFljCrjGkMxjrPYyi4Ek1zFm4YkBP3AUhdqyyFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106775; c=relaxed/simple;
	bh=uAyY9gjyCOboVe//FtfBE8PFXZnUIGHTUkUD1deROxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiGQb18wtgFqJfSF41folEfRp18g5kKcN8aDctEYypWmy/C9a+cv/OjV6IJcm2FM18PwkFo3pHUDRPBigKWxk0VrZdmWuMEY1JGpvdxS2zhE0Z+aytWcuzSs/hgDhVUNq2xiUrCxCKlaqlBQv1F+/rojNsSALSwlNCc+JtAYrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LT2aOjws; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LT2aOjws"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=27Cg2Ss3WK7wBsdTiuUAdwt3cEVjjpMaTt34CUsHVYU=; b=LT2aOjwsHo+vA8IfzWZ91aF6zJ
	UeUS2XmfQKmqbxkl+AzWu+bmvs26VQGrG1rSGSuGAjHjH4AkmlH4wwfeFPwJyjsQDJRADE26OdGJg
	haNFaW8P7wIbWylMow/1/F/al+hAZpLLtqp0HCXaOdHA4j4ajTX/AYItgcZIlay3smn31iW1Ar7Z9
	ViwyqzYHOFXYAl7FHyulgXblbQHriGTey41ff341gsTY1GVEHV0mLhx7sXlnwrdFFuuSznEPgjJMR
	+gkcwypfC/MASiDGZqs1S/Vj1z3LHndvYO860ELgGwNXNZTz+FWQapTVZ91tZ2bptviywresgGrcd
	yXOkRmVw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizTv-00DDhH-F8; Thu, 22 Jan 2026 18:32:35 +0000
Date: Thu, 22 Jan 2026 10:32:29 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, john.ogness@linutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v3 4/5] netconsole: Use printk context for CPU
 and task information
Message-ID: <aXJtIPk5joxRQnxV@gmail.com>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
 <20260122-nbcon-v3-4-a722f2f0dfa5@debian.org>
 <aXIWUmhBnFLY6EqK@pathway.suse.cz>
 <aXIc43kUCBYZex2h@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIc43kUCBYZex2h@gmail.com>
X-Debian-User: leitao

On Thu, Jan 22, 2026 at 04:51:21AM -0800, Breno Leitao wrote:
> On Thu, Jan 22, 2026 at 01:21:38PM +0100, Petr Mladek wrote:
> > Hi Breno,
> > 
> > I have got only the patches 2,3,4. I can't find the parts 0,1,5 even
> > at lore. Something went wrong when sending them?
> 
> It seems so. I got a bunch of Delivery failed messages from different
> places, including gmail and netdev. Not sure why yet.
> 
> If they don't show up soon, i will resend.

The other emails arrived, but not the cover letter.

I will rebase and send it again.
--
pw-bot: cr
