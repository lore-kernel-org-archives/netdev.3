Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53693E8C78;
	Thu, 19 Mar 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935624; cv=none; b=J0GyBQasNDtKx+/mkIym4W5p8EZ0UQvf24v1RdxRCRbZSC7DuAHXt7NDWQtq6YFqyxgyJQUYc6BSXhXS5QHUq12QvRuochg88kG6WBV/I4CwA+GKZ6KR9WF94mNe/TZKkauA3aHy5IIaay8kMlYBY6Vuyjk0PqiUOuzp1b65L88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935624; c=relaxed/simple;
	bh=PyWcQUs/CwOXw1ONa3nPZtkK0b8+U9fg5fPTG1r9oWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar1nZEQ4fmsZDLcE5NLb4McUcjkRuU/wWzrEmAS+tIQFNgibj1pU/LzUsZYtW7QNbHGVeuNqk0Dr0v7K4QyI4kJfz+t/NmbTWsV9DfHflwD/993OCKFKKCcMQYb2CuCu7GcEnru3pHq3erl3x3EM3cpEPC8xpKPI9btiDRjGdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A0riGY0q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A0riGY0q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J0Jn7FRpfsVh6xJoXGSk8kCSSD4azZ4tiRFyJZ/ByxM=; b=A0riGY0qWjb4UcHpG57UUNNvrj
	HqLLQrleN75OO8WmQDfc0TXdBAg07rAJMloz0hNd8O9VsX01brW7A1YswFAgK/uNfoLCftOVirAoe
	ORb/ma/q9Oo5eeKdgkP+ofpS7qCZr2tSXPHAG+ypqtEN5DCJLsBNDX5TacVcN9S2RDY8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Fgj-00CPJU-5r; Thu, 19 Mar 2026 16:53:33 +0100
Date: Thu, 19 Mar 2026 16:53:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Message-ID: <339655b1-59e3-42d6-a460-b8424d7fd279@lunn.ch>
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>

> This patch is on top of linux-next as the code re-uses the 2.5 Gbit EEE
> recently added in r8152.c.

Is 'linux-next' a typo? net-next should also have the EEE code, that
is the patch networking code takes.

	Andrew
