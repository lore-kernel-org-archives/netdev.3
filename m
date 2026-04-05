Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4B1AB6F1;
	Sun,  5 Apr 2026 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432962; cv=none; b=Ydf6AFodc2rs7wfFQmAq0iEKn1EsmFzJUZtlGipqQre+sRCpQq9dAv49i2Z9FsVFFg9bcX2sqOQ22jrVAJ3OmTVVByhFhN13MO9vVdLmmir8AvdbEcOBVcZR8Jh51+uZpdlZUKOHK3Jqy2L/L6Jrd8NND/ZkU8LoWs7pwi8+sZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432962; c=relaxed/simple;
	bh=ByVakQaqWOdVbTt8cRRx+RrqV7H0NZvlLdiCELhpm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg1OGTsAYqoBb56OjUg6uloFZqpn3w0oEM9vhezY/r5nrsQWOQRjBs+Xzh+q4EWSfjxdaNRlIcX7ISeZePs8US4NolaDjrJUkCZkAJ5wDJOqphjvkmhRDQZruyc/lKqzJ+eqKxsyQGZqKPxk6wj5k1GAZ5534si5uuxwdt2yJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x+AlIvYk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x+AlIvYk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j6+gdbDZZdlGyn80LUvHgvPnYmuishTMRVpglZve2KM=; b=x+AlIvYk1zjc1NzfvxMUMcblyJ
	p5ythXWUplKBGwLsHSKorJK8fIen5rtkoQBt9Ns9LZdeePG2UbvQJyOAL1ThnJhpx7LGz+y4Teqca
	V+9PWGgC/kp1xwTk/SR8EnLihhioCzQgdJKCrmvV5GpV73caHrRJc1M+xQ8+PpMt+FNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9XDM-00Evl5-Or; Mon, 06 Apr 2026 01:49:12 +0200
Date: Mon, 6 Apr 2026 01:49:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, lszubowi@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tg3: Add PowerEdge R740xd to AER quirk list
Message-ID: <bbd6d9df-9698-41d3-808b-c751bc1c4576@lunn.ch>
References: <20260404225023.1254-1-rayfraytech@gmail.com>
 <975ec123-e3df-41d5-bb15-f3af8af2c340@lunn.ch>
 <CAJioSGcBb3eRtgQXHWx+Bhw4M422dyAo-0yXO-XwU7h4hmwmEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJioSGcBb3eRtgQXHWx+Bhw4M422dyAo-0yXO-XwU7h4hmwmEQ@mail.gmail.com>

On Sun, Apr 05, 2026 at 12:56:11PM +0200, Oskar Ray-Frayssinet wrote:
> On Sun, Apr 05, 2026 at 01:03:00AM +0200, Andrew Lunn wrote:
> > When you look at tg3_restart_aer_quirk_table[] they are all Dell.
> > Are there any Dell systems which actually work? Would it make sense
> > to mark all Dell systems as broken and enable the quirk?
> 
> That's a good point. I don't know if there are Dell systems where
> the quirk would cause harm. Do you know if it's safe to apply the
> quirk to all Dell systems, or should we be cautious and keep the
> per-model approach?

You might want to ask on the PCI list.

As far as i see, with 30 seconds for searching and reading
documentation, AER, Advanced Error Reporting is an optional feature of
PCIe. Since it is optional, it seems like disabling it during shutdown
should not have any negative effects. Except for systems where it
actually works, and there are real errors during shutdown and
resume. It will be harder to debug such errors since you don't get the
advanced error report.

      Andrew
