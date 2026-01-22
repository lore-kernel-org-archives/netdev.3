Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E83B8D5E;
	Thu, 22 Jan 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086300; cv=none; b=m97NnNORR6isKuZkky6LMfdSu0YzjWpIWH2lQB24rBRkzR8eBb4rk6vmCMRcX4Bi/Fmi8SMwtbwFG0NlNf8tog0JdJmglRLLCEUgQXnhOEVlY4bTbSH41BT7uac/Wyo3SJgyBqzZaI6O0WXC3kwSzUI+/Icj25fL+L2nsJ+dF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086300; c=relaxed/simple;
	bh=9IaT7yw7Auxhv5/NFAx9I3J5Tf8VyKOwe3C6pisHl7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka9oLmg2bZZfNaHsvU++UwfEei3YMmrkha1SrPuPhJqMO6jPiPffdHRFSu3tKRV4DWExRv1EajIUMXmjW9GRGUl8mNOzC4IwWTdmKiYs10o2HGEJ25x3V4kHMA5p+bbCaDj/QmjYC1hM+4Q8LETaLdLJNyrrn0SGUpPHq9THiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pn/AMgF+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pn/AMgF+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6ryD9xTHOVZL3Ctrwu5BJ4DG4YQJ3Rs0CaxSMd8HeEE=; b=pn/AMgF+nUEMnYXnZBN5T4CMrp
	f4vnquFk0sIThRxcZgmCMeCzN53ew/FkgMBLw4zfT1TZvF7dbUv89GQugpoPq7EqMlfohYWitiGVE
	cm0HMlT3KsebfOgAoTTohIbmVqYtYGyXg4Qyi1WCCPFetHnePvtmRpm2DVm70s7Kqg9R0B6vcXOj6
	GAnTgJ714YhLAoHyaVzN4H6jSI7zwxj1OR7tY9VlMC87gocI7EsmDn6NQTRIRvzYMP6ICgEtKNljy
	yS79BqzytQCCib5BPq7pMB25hEpb8gWCnsdRYj3Y5Z8i3Cm9OPzPT/N6nxHgak6fUJN4WiainUlmz
	ebU7xDpQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1viu9h-00D1t8-CQ; Thu, 22 Jan 2026 12:51:21 +0000
Date: Thu, 22 Jan 2026 04:51:15 -0800
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
Message-ID: <aXIc43kUCBYZex2h@gmail.com>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
 <20260122-nbcon-v3-4-a722f2f0dfa5@debian.org>
 <aXIWUmhBnFLY6EqK@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIWUmhBnFLY6EqK@pathway.suse.cz>
X-Debian-User: leitao

On Thu, Jan 22, 2026 at 01:21:38PM +0100, Petr Mladek wrote:
> Hi Breno,
> 
> I have got only the patches 2,3,4. I can't find the parts 0,1,5 even
> at lore. Something went wrong when sending them?

It seems so. I got a bunch of Delivery failed messages from different
places, including gmail and netdev. Not sure why yet.

If they don't show up soon, i will resend.

--breno
