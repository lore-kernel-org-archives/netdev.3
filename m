Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8161E8836
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551443; cv=none; b=JjjdMVU888v5b5BscbWb9FwA0Q6uOAzg1rUJ699DjvIFHrVanfP10GgdkzeSm035pX27XZib6fTPddLVNPt2gxMXvjKNDoK+3KNzdlIRMXt7PJjLEsi6I9xyQPPnLaEJXxt1Hx8JZAASXQBIoFOxSMR/jrzwfoE7QbM/SVnJtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551443; c=relaxed/simple;
	bh=Ca0daxe03hS3kCtTWbDidIBF0LW+GXfCXnvz0OSyKIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nInIiQQclf26vEs1JGTwyHAN6ZX6E0mSREAtsoeoZpbQBIZ31GswRMSi/RR5RkNTYF2VZ/A2Zn0vIosaSlMJMThpDgKbjcXAiO2eF9iJ66u6A7C0L2tGRY1HK6wrha6ITfIpBFHAPTfE5ydDL5FYiMNOQ9S6cHv6vH6CBOqiAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhchHhv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhchHhv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD05C4CEEB;
	Thu, 11 Sep 2025 00:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551442;
	bh=Ca0daxe03hS3kCtTWbDidIBF0LW+GXfCXnvz0OSyKIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hhchHhv+Vx39BOyIuQhwF195w/RE3apFCtu8kkmN5tbSFVQIckoPHOcNTTMUZlqrc
	 b9ZJe1em9JS54EP2wRfiaiIdfvt0yA7SoEGbo2aGg1DZ8zaiOxcUNUpmqejpOhmHcq
	 +YnFjwLEmO2D1rGB1z+B0MQ4P2n00UwwVI5HwgBALxX2kAuF+UegLGjTgwXfCiZ2RA
	 tRSfdOf/W/V0iY/Y46rP8e2THTCp8Ec3kWBngF9rr0uoYiGn4tTqBxIzkuvRiMTh40
	 HtgDIrrODU4hq8uZRJW2+kLFHsQwd671R595Kgrnp6DfX3wqWxUgIQtMRGXacEwsHX
	 gKuxX13uM+fiA==
Date: Wed, 10 Sep 2025 17:44:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Alexandra Winter
 <wintera@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Shannon Nelson <sln@onemain.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] net: ethtool: fix wrong type used in struct
 kernel_ethtool_ts_info
Message-ID: <20250910174401.74326220@kernel.org>
In-Reply-To: <aMFzP6GFj1jVO6Qs@shell.armlinux.org.uk>
References: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
	<20250909163302.7e03d232@kernel.org>
	<aMFzP6GFj1jVO6Qs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 13:46:55 +0100 Russell King (Oracle) wrote:
> Even without Fixes: I think you'll find that the stable autosel bot
> will still pick this change up... it uses "AI".

yeah.. probably..
