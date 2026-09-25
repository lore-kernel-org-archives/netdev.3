Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34647F3DD;
	Fri, 25 Sep 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338653; cv=none; b=Z/CwVD7M/WC0ZrErcj8N2+naKIBUmnGdwTBYTF53bfO6nlvExOYSxe4ldLGG5u3B44i4BrSp3Hq459hAFINHgDycKw5dGKxGArXjGztVXCnfgkX2TC/u7Zhtr9ER9fAez32V9XAYJ0cSLK2kDER7E/DsFz9BGyRJSdBckicXVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338653; c=relaxed/simple;
	bh=wz03nCaklvhPBzaWmdEC4b3DMc18UNTWhxF5oXSNHgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgP5dt3sZKfegWSe7cC4H7hQkjQaJvTB9+ikKBV9Kp1TxbUFGJQcYskFb99C+UIfQc2Jlc8TANlRDCvRe80nfJAlJnjblrhb3U5z0cu/qS4AD2Nwq/NaWuF6r426sApJB1QgIoeEk3Z4i3V5Y87i8v5yLcpiwMfqU/FkLxMNFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHouwk6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHouwk6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2091F00893;
	Fri, 25 Sep 2026 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338652;
	bh=y6N76suMhrb7LmS5sdFrS/SuxiPWeYIYkmmQN66yBGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHouwk6BVj/OH8UqAdKe9kCpwYTxCIPWkSGrEeA6gtMdW9LOKsV8uvmHr4PkspIcu
	 C4UchGYTyhG79ehd/KZoX9TzzXsJbQN3HCEOTqHu8ZHakR6CCEuF8R+aMjkFb3MgZx
	 YC2yuet8mo7BTnhvLXIEYOdlSyL9NHxQ2sRpEhgdEpZkfajvigPCeY8viwUvn2pu5p
	 aYRDmD3HAMP8FhXAnyygpFnrioHd1DK2WjWYt5bTLoS6eHLPujec3aVV8UycSqY+Jt
	 ybmgi28Z0VX0Hm7kH+WpGSLrHVZo29a8DQr7JkriyI0mpRfZRhJsYozdLOh61Ygb6c
	 tr0ahBJgs9rUw==
Date: Fri, 25 Sep 2026 07:17:30 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Document Marvell PHY
 "marvell,reg-init"
Message-ID: <20260925121730.GC677989-robh@kernel.org>
References: <20260922183157.291091-2-robh@kernel.org>
 <179031804081.2160803.4823115817421319418@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179031804081.2160803.4823115817421319418@kernel.org>

On Fri, Sep 25, 2026 at 06:34:00AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The newly added `marvell,reg-init` schema in
>   Documentation/devicetree/bindings/net/ethernet-phy.yaml documents the…
> - [Low] The new `marvell,reg-init` definition types the property as
>   `uint32-matrix` and gives each of the four cells only a `description`,…

Looks like all valid points.

pw-bot: cr

Rob
