Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529363B5F5D;
	Sun, 30 Aug 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100114; cv=none; b=qxkUtMUxWmmVjSGesDaah9pd0pT1B6x3fPUSG8JQrif1hUh68Y7pfxSsh/zZKyUxW5FVRyCl4tM37q6kZ+X6/lguMdFG40NrQkjbupKuqX+6Dw+oJIFQASbQ/VPrg/OGYV73909TH01DkswG5kEm2GEv8Q6Bun4nSEX+wMKA+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100114; c=relaxed/simple;
	bh=aSS1vwnZQkDnFZPChTBpfJfgS4KBdkySoPvVkNpgFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxL4xfq/TSS7MJZXHN9+xliT7TW2AOn6/tvfEVPvb1k8L+Fi/Og4ZBKnTv6qg7HwIhj0w2YKp6Kz1D9ToI5um18GycOBZzI9oHiVe8Q01xddJgDM577OAf21B/9Fcg7kkmsWkWSM5Eh/JvzjP//p8aEyPVp8q7wVii2MY3JXNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bxdgRAJB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bxdgRAJB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y/TBokqSnSpDNiq/lWHPw6WpT3VNl1VVy97vWYqSOIs=; b=bxdgRAJBNn6LXsI9xHjpzxAUke
	uuWRaiuuOrJUoD0kT8RijcQk7dKZDTWh4lo8GoR23gd0mUYRUWMYytgucj+RuxmXwU1+P29lmbu1h
	72hFa/+0J/Fw/FPR8iAKXZaPPuV+A54oXKYx9v6FVJ+2MpTt+oRJpud4umHPmZHkL8yI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x0gW2-0022fp-9Q; Sun, 30 Aug 2026 16:28:10 +0200
Date: Sun, 30 Aug 2026 16:28:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Elad Nachman <enachman@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: prestera: avoid overreading a short firmware tail
Message-ID: <ccfa4dd8-7b5c-4417-86a7-14638dfd2aa4@lunn.ch>
References: <20260830142404.37663-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830142404.37663-1-pengpeng@iscas.ac.cn>

On Sun, Aug 30, 2026 at 10:24:03PM +0800, Pengpeng Hou wrote:
> prestera_ldr_send() writes the firmware in 32-bit words even when the final
> chunk is not four-byte aligned. The last iteration then reads a full u32
> from a one-to-three-byte tail.
> 
> Reserve the aligned ring space, use unaligned-safe full-word loads, and
> zero-pad a partial final word without reading beyond the firmware image.

"What?" a patch does i can see by reading the code. So the commit
message should explain "Why?" you want to make this change.

    Andrew

---
pw-bot: cr
