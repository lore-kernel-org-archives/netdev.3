Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AA6A001;
	Tue,  3 Mar 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496540; cv=none; b=T/qFe94b5dE+mTaXOl9WwTvpa0WTsk78sANpxChD15Z/HcmjRKfmaVbGjoQDdINvrnI/C0KHOkgkmm4K+Msm7gmdyxZW3YgX7NKxQLf9WHhPQZ5+zGEechNSH3MHk72kJg/KIi+y5bsJyNtvhiTeIzbHRlwrg0W13FI7aXDFie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496540; c=relaxed/simple;
	bh=Z7qzH+D+x67to5sjz18CPohudnWYBfSkLMEK4/Me4F0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUQIRlEhWSiL88S29GYFCsK92PDU8RwzYanUPsBdcS8UNxnUkWQuTP3ypdDdgOQbGX1UKGF+TwfgSi4u1X2s/zdByyQN7cYFI004tIAG1iS3udWTDHnZNBljrJbRb9acq+QqnmcT313YX4/kNaklzdyyPMJUl6RdpJkUAH+MevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFrjQ/5k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFrjQ/5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484D8C19423;
	Tue,  3 Mar 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772496540;
	bh=Z7qzH+D+x67to5sjz18CPohudnWYBfSkLMEK4/Me4F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WFrjQ/5kV8TOTrHmKgXNQTQUMy/UkeRyUyE2IFWAdlTmOlpJbQiz658attUr4F6Bq
	 gDYAJ+RWG80dC2BGEBS3VSN1UPvs/orq0XSoy45j8LuzhiXPJqHVzblZAIT7o+nRQA
	 jcWXgYAW4dPfjJzh6MfHbm4DEKsLjVuRtDXJBjJPAsUmG7X4mVpMFN04zY9EDCNvKX
	 BugFfMHWV2ub1B4bU1MSIzaaEw7LK0AuYl1LtQzu+0oChW72UtdThQHpud1b5HopLW
	 T7Vx/n4KSI18dfpe8MFU/mhM5pYs0slgEdpk6mJC2e6izNI4p+gj7+/EaXEJZVH8P4
	 bd6tWDwBX7DIw==
Date: Mon, 2 Mar 2026 16:08:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
 <alexandre.torgue@foss.st.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "rmk+kernel@armlinux.org.uk"
 <rmk+kernel@armlinux.org.uk>, "maxime.chevallier@bootlin.com"
 <maxime.chevallier@bootlin.com>, "boon.khai.ng@altera.com"
 <boon.khai.ng@altera.com>, "rohan.g.thomas@altera.com"
 <rohan.g.thomas@altera.com>, "vladimir.oltean@nxp.com"
 <vladimir.oltean@nxp.com>, "hayashi.kunihiko@socionext.com"
 <hayashi.kunihiko@socionext.com>, "boon.leong.ong@intel.com"
 <boon.leong.ong@intel.com>, "kim.tatt.chuah@intel.com"
 <kim.tatt.chuah@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/5] net: stmmac: Add write_hw parameter to
 VLAN filter operations
Message-ID: <20260302160858.2fe0fa3b@kernel.org>
In-Reply-To: <TY7P301MB1984067560FD51D7E2424CA2D37EA@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
	<20260225142414.130144-5-ovidiu.panait.rb@renesas.com>
	<20260228110408.384420e1@kernel.org>
	<TY7P301MB1984067560FD51D7E2424CA2D37EA@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 21:59:00 +0000 Ovidiu Panait wrote:
> > I wonder if instead of passing attributes like this around the driver
> > shouldn't simply maintain a flag (or have other way to test) whether
> > the clock to block X is currently enabled? It feels more like a global
> > state / property than trickiness directly related to VLAN config.
> 
> I'll drop the write_hw logic and instead just check netif_running()
> directly, to avoid passing attributes around.

SG, tho - be careful with netif_running() in context of open / close 
code paths.
