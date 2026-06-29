Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A03750D6
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700488; cv=none; b=q25WZDxzJo11WnXZds1eZ/s6/mNX8T2x2b2ZGm6Rlab4q0kMU7hbP+za0G7xE7koLHiNLYOWiECxFQixUvKMWbXw3eNr2dUb/52lpdQQGiLF2xjxK3Oi8ZLlG6b+OHK50515ibWaNHVzPIsQt9A6oeTRWxr1z83KxE/ISKTpiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700488; c=relaxed/simple;
	bh=MqjIMNfvVj1MvB1WbtO0xB14EvFr7MbBubzfSRE+otA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXyMI7Y+vjFDhAVDdrcofePUiUAVyaLhvc9GscODZoPmrKRGSZvTxxNrj9lVNvrlb6A2bVez6roIFWPGp32MiaU4bVXexUctLgMkHqDHqowlJvNvG10CXyVssfgEEI7vSbCKvV6eJE8RXOwsiGXWJuK/izw7vEVMNGKtUwFFKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 65T2YHMF021906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jun 2026 22:34:18 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 157EB7C1B88; Sun, 28 Jun 2026 22:34:17 -0400 (EDT)
Date: Sun, 28 Jun 2026 22:34:17 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rafael Passos <rafael@rcpassos.me>, Jason@zx2c4.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [PATCH] Wireguard: Fix data-race in rx/tx counter
Message-ID: <akHY4UEa1ab2PF-j@mit.edu>
References: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
 <20260628203823.144789-1-rafael@rcpassos.me>
 <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch>

On Sun, Jun 28, 2026 at 11:02:05PM -0500, Andrew Lunn wrote:
> On Sun, Jun 28, 2026 at 05:38:23PM -0300, Rafael Passos wrote:
> > fixes data-race in {rx/tx}_bytes counter for wireguard connection.
> > these values were incremented inside a read_lock_bh block, but write
> > protections were missing. making them atomic was the simplest way out.
> > This was found by syzbot with kcsan.
> 
> Atomics are expensive in general, especially on high CPU count
> systems. 
> 
> Statistic counters tend to be very asymmetric in usage. They are
> incremented frequently, maybe per packet, but reported very
> infrequently, maybe every minute when an SNMP agent reads them.

One of the reasons why kcsan and syzbot can be quite noisy is that a
human being needs to *think* and consider whether or not this is
actually important.  (One of the reasons why I'm not all that worried
about our new AI overlords taking over the world.  :-) Consider what
is the worst that might happen if the tx/rx_bytes counter might not be
completely accurate?  Is it worth the performance penalty of using
atomics (or the memory overhead of per-CPU counters)?

	    	       		   - Ted
