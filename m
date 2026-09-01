Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C1481238
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302263; cv=none; b=D79NDtvJCQDx63Xkb1OJDf57j7+OJqHGwc94ame04y2h+O3+FyrROgUOz/ei9pGdUR9yAYfab0PYX6tU3xkxIRKiIPz2ZzWg59nsCaYNrgxP6YzIDxtYJZV+x1pI5nPGlVW80EJEO3DhIn+J2HhBTIpmtJQ6lF8ZX4LuJaED2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302263; c=relaxed/simple;
	bh=8aPoo4jgIVBGo4owYg2s8XmF/Ek5U7kY21mmo1VDwBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIoRCoQJSn9QdogJUC4j/fSnmJEp3JMFHrtb9PmjKLfISHrxIZXD3ZN/AppREZSrfG7zNlW9uPG4uNHR6RBitHuUK6t/TaOIl98Mw2KuqbFa89D4mD/d0ke9qCg8uzqOKk0GOh+gHQE1dcYdF9PcVSzw1rdLWCdVW6W/wC7SbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q60YstaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q60YstaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEE41F000E9;
	Tue,  1 Sep 2026 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788302260;
	bh=NqjMnYpw4QyZ+XDiGjc7N9Pv6N77vv75qr97LOg8NS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q60YstaD/GRxtLwDLAWx7XrZXkKQHRDwc5a6f9HFPAnuYzAdofNX7nbg5xnpTmrIi
	 9AeFASHhUgy4c/Ec45PPffNnjHr9STGbKiYNymRPm6GY98QJZywQG5t+VcgCXx/YYb
	 7lWcAsF+9/g0Yrl2x/yGpNXF2Jw1espK804VQvh6QAoIW338wkAG4TWXk9vxXuwcUI
	 kJY4OcJsqL0zCDEmN/ZZx/LTk5zaiq3pvi0kmDqUqdZonshWDK9FlrzlA3opHNKck6
	 TM9eWSJqRF5oXyvXwkKEXqvMqAQ4HoEfV7AZ49NmllDVaXKsHEDcgG8wSzNILHmTKQ
	 p3gKlcUGvN+iQ==
Date: Tue, 1 Sep 2026 15:37:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: ethernet: cortina: Count dropped frames as
 NAPI work
Message-ID: <20260901153739.1283117b@kernel.org>
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org>
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
	<20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Sep 2026 19:04:56 +0200 Linus Walleij wrote:
> -	unsigned int received = 0;
> +	unsigned int work_done = 0;

Do you (Linus) think that renaming the variables all over the place in
a fix is necessary? Or just LLM did it and you didn't bother pausing to
think? 
