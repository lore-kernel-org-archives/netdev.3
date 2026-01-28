Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE261E8320;
	Wed, 28 Jan 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565147; cv=none; b=J9n9+jn6guSjmrqCe+Db7A9IQWuZpEkm7pRc4ytM4kYIFfCJ/NjsEduLNbltdgajKnBs6/WuJGl0CZpDVKvnKNZADxi1FeEeF3tO/Y8/iJX/UMRS3DsdbktHHCmm/9KG7mPkQqysRcW5J9lStzNw/XrHmW6TUbVMsfosyF9hAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565147; c=relaxed/simple;
	bh=RkFn9bdWVW3yZq+uVxyn0/nH1KXRZMzYjMlLRwwjcmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXS8OOTSTMaS/w9a7GaWN25MVEqL9AvCKdbXclXFAY/WsUbYdK3/Oh9ssocNmmL+0JmIsEgMdNN0YHQm5sLrJSYiQadc2GFPL2T4xnzr0oQUw3QVs27lL6sb9GUBEO774KiBw/2c2riOg6Y2KiVJGBhmgr3Vg97rzAS4/l+Z/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9xkcCL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9xkcCL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AEC116C6;
	Wed, 28 Jan 2026 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769565147;
	bh=RkFn9bdWVW3yZq+uVxyn0/nH1KXRZMzYjMlLRwwjcmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9xkcCL70aRrC6AZdsEwqEpSB0TMpL6WaovsunIbTsqC0dv/kUNDkarg7Uzh8xn7v
	 CPGmtTl9g6fFi2VOmD43podtjph24XjHXan6iLiSY5T5YxJvMtpxn1zGRb1vLHssNx
	 HirHszWQbW1624KM3lsyegHIR4iZXoL3tOXusEfHTZcTee5GvyJbu2ceC99EwTargE
	 xplLpw8ZcjAkzLnWYe/kv+JPDqTjsSM7tiXjwlOQkrZXqTFCJoVaCvMzERk0HQ7w0I
	 KI8t+by8a63toHyF5gbRJGLtOWwZb3PmMMKVDiOXoD6LtmgnUFpilgXZ4pcWFB1RZn
	 UNGg5WdixSjdw==
Date: Tue, 27 Jan 2026 17:52:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thangaraj
 Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com, Petko Manolov
 <petkan@nucleusys.com>, Oliver Neukum <oneukum@suse.com>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Krzysztof =?UTF-8?B?SGHFgmFz?=
 =?UTF-8?B?YQ==?= <khalasa@piap.pl>, Deepanshu Kartikey
 <kartikey406@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Foster Snowhill <forst@pen.gy>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Eric Biggers
 <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: switch to two-argument strscpy
Message-ID: <20260127175225.3982f93e@kernel.org>
In-Reply-To: <20260126035052.31216-1-enelsonmoore@gmail.com>
References: <20260126035052.31216-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Jan 2026 19:50:15 -0800 Ethan Nelson-Moore wrote:
> All instances of strscpy in the USB network drivers use the size of the
> destination. If given only two arguments, strscpy will automatically
> use the size of the destination. Make the code more concise by
> switching to the two-argument form of strscpy.
> 
> Also add a blank line after a variable declaration in catc.c to adhere
> to kernel code style, since the surrounding code is being touched.

Let's not waste our time replacing all 3-arg strscpy()s with 2-arg right
after we wasted our time replacing strxcpy() with strscpy(). Who cares.
-- 
pw-bot: reject
