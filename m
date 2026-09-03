Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AC4EBACA;
	Thu,  3 Sep 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452755; cv=none; b=Mku/CM0jDJOrnAFoim/ziVQ4PZSeSOkSDqaKRrpQeYqBltVMJGAORdZ6SJtDKTx17zJVePjqn1oALGgcG30LNpqp8xSRw7wroh7XmRDnDj7VNlNTVxKP0DUVbsM34a6RvCXzJJ9VjbBom/b0ssk8dVtbFv427x7gSNm6dNhMaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452755; c=relaxed/simple;
	bh=Qjp9s93WKT9GSAkwinXvY7BYYxnbXCPp1HZhL2ZKUWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkv1LHWhqoodWxcv0hHGvtHdJagLxkc7i5fE6FGFOJNtgzriEXDv1YJKl8fZr+5A4rYxkS+Q7Bwu6Zfm2jWQr1ZkHTNhjQj0QMGVa5bbakUixL5ftIAV3R1ndqGxplo5FOO1ROByRMOi6R8AWy3FFWhU6fwhT/uI1z8KMmsEDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4NNVtOn7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4NNVtOn7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o9ibEAjof7rB7VihNGOccTypJjhjM+Lpyk7rTBpXcRg=; b=4NNVtOn7d+1/QEZy2LEeAspKFh
	kzezQtmefEab6W1nyiNG93NxQFbtfYM5kNL1ZmAGtJCij/xejEKD5WaCXD5B09i8QmKQc4au9+RTk
	iRhRUCdiFDt98CiQGz2mJ7qBCKDSMauCRq/4GDJTHLRgDiflWOfrjot3KLaZq2rFqjTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2AG2-002kyG-TR; Thu, 03 Sep 2026 18:25:46 +0200
Date: Thu, 3 Sep 2026 18:25:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: motorcomm: Use u64_stats_t for
 MIB stats
Message-ID: <ff900ceb-82eb-4356-97f2-4af75480a8c4@lunn.ch>
References: <20260903143514.532023-1-mmyangfl@gmail.com>
 <20260903143514.532023-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903143514.532023-4-mmyangfl@gmail.com>

On Thu, Sep 03, 2026 at 10:35:08PM +0800, David Yang wrote:
> 64-bit variables might not be atomic on 32-bit architectures, and could
> lead to load/store tearing. Use u64_stats_t to ensure consistency.

Can this patch also be broken up. It should be possible to use
u64_stats_read() without changing the locking? So one patch which only
does u64_stats_read(). You should then be able to add the syncp
code. And lastly the mutex changes. That then allows you to explain
why the mutex changes are safe in the commit message.

    Andrew
