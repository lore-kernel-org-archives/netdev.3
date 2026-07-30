Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3C3B7B76
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451717; cv=none; b=Xs5FUiaPcgJqnlf8YpjiLKcP4U1Oq0vXq5FyighhQzzKHeTLdo0+ahz6tAbo0z8UBtglOV4T1fn+3oIgmQ6JLbUX6FdvIOBjLAYOxiJ+mPyPheDKqzAn5sOpVVW/LVA3MpC/KTCkqDAfhdh/qRCcZ3Vb8fsfWvjnW75eU5NL3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451717; c=relaxed/simple;
	bh=DFohw7Zh8YqFL8Kbyp3qBvizvm4Ti0kROPEeUL0S1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0o2d6tCOUjUWor+fUbVRVYnEewF3qbnbaetMe7+XNlOAlqctJKMYE09H48Nf7v57SRUimZoCJBTRN6RJIG75vtsjNyb4lXsFcfhAGDr0UrAxK2vJdy7GreZ2giCo/7wjjGQFWzPIAZKWjDOgDpys8svMjEFSHXkYDpo0rF+DiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm4Dz1Vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm4Dz1Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E41F000E9;
	Thu, 30 Jul 2026 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785451715;
	bh=U/sWpKygvafKmTyoHjspn7efgUGsFg1/J/5JyTKmdt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vm4Dz1VjEXwp5u7W4Wa+1fAoiCEb7Ik+m6uerjejqDTGhOtkzIpE4ohnGjmxDZLVt
	 asxSKnoMJeqKD7NCmDOZg8yWpP1O2LDMR7WPij89Ui18b+8SHb+GFZ17ZrLD8uU7kB
	 mmUMT8qFIsa0TcyH0rBkEB3wlQhjMoYwf3tTJHOHipTZ3pUGXFBma8NcbaDNvzb1sT
	 FB1T/xLZtX2t6yov/PgI7XEpQHwsxsDMbsr3QigYICExQO+R/InkyI8+ueB3xsA3oS
	 RFmkQ2nWo86XDF4sYr2cy+0prpoe8sWacTyo1Kzg2y23jSXEJA2vogntTAApn+YFJX
	 38Reb13YHWsdA==
Date: Thu, 30 Jul 2026 15:48:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: realtek: rtl8366rb: Fix up port
 isolation
Message-ID: <20260730154834.07038c8d@kernel.org>
In-Reply-To: <20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org>
References: <20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 15:46:21 +0200 Linus Walleij wrote:
> Sashiko reports that we incorrectly disable isolation in the setup
> loop while what we want to do is to enable it.
> 
> Enable it by setting all isolation bits in the isolation mask
> for all ports in the switch.
> 
> Fix up the comments so it is clear what is going on, including a
> missing word in the helper function.

Sorry to report that both Sashikos remain skeptical.

https://sashiko.dev/#/patchset/20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org

The mask is the allowed mask so the write of 0 was correct,
but we want EN + mask(0) ? The problem being that
rtl8366rb_port_set_isolation() does:

 if (mask)
	reg |= EN

so with mask of 0 we can't enable.

Maybe pass 

	rtl8366rb_port_set_isolation(priv, dp->index, BIT(dp->index));

?

Of course neither I nor the LLMs actually know this HW :S
But comments on other calls to rtl8366rb_port_set_isolation()
suggest that indeed the mask is for allowed ports.
