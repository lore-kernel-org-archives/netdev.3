Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315288;
	b=Q/cNuOcqBaV+9k8PD1eblK37GR8q9DsgLuBRsIuWwhbRa0P+ZDm+MSJDIuWjqWW9RCgw
	 0NjrpdwPtB63p3+VQtY+yZY8bn7itHttbuadaNjD3DL6OMwTwiOkrKXH8uFKBMe9uVt98
	 W2j/1REcYq3dsFJTefia8fMEG8wsTCl4ZCCHq4J8mc7qubbz8ZHCpmKYJSJhSHWDH4KmU
	 HoDnrRFzdnvILgKxpqxWRKOn+WoBSdiiqWF/bt7cJxzE+XB5mzHb9fPzt7mNHCspgvSpY
	 JecYWNkQ2VxiCK+9wQxaaS3912ceZ+c3yov0+CDRKXq1A3hyseDyWS3ozOoIGRdbsOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315288;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1+2k5LckoMlRz1UsGVfXPTvJfkXcF184agG+LHhQ6uI=;
	b=elMIeUoLsCm+wGFifJcBh3aYOEFYtyz1hXZJObi7gzgUAE6/YCr/4h8OP8cKgdk2xoWl
	 e/xmu5QzMGi21cVdUENa/D5Zr1zS7VyXQAmzkOl9fY+me57/8KIvnJpEPji7c9CkKAOqY
	 VbqIaz9cuZB5qzfQi15br59/7doKi2XYnV/JzA98OGxeNxq7Q76xaxuK7jJSQ4yVeiHsi
	 YZG/lKkeo+enzJoBJhnvpb9rRo4dI7h9ZvP24PxlHYkjHn1Aw9/wYyWS1H913Wpfg28+e
	 KKdzQq5EaUg9WJNokDLn8AWiEuyyodY7vDl5DAUzljlcnlGw7CFGytkkv2NKs5v2DuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/zSVM8/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3464606A336;
	Tue, 10 Nov 2026 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/zSVM8/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5D1F008A2;
	Tue, 10 Nov 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315287;
	bh=1+2k5LckoMlRz1UsGVfXPTvJfkXcF184agG+LHhQ6uI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f/zSVM8/aG5/mr1KV04vTH9V5U8+FsOb/Jzgzli3GSTfjY2Ch1qqMEg0reZipXUvj
	 I5DWAFQMn/iYdo+zlXIveCaSxSkK2TKCLj9RGnH06zCE6QByvF9mKIdKdkvKRSuZEx
	 sxMfN2kUl9ndSIn3jl3m0taYiDibWw5YHu1bwzgPoFRFXXdR+e+JyOg9JT4qUr76HR
	 DkZGYcGE+n9yPol4hB7iM676ji6+LgDFd/s+KiArvaYW3DNh1fdXjhAbPP1kt8x/Nr
	 DrLnwR+JO48GaFQ9lEcK0WnqGVwrkFJLEnMge8Jq+WnlX28iespYtHCM2yigBF28Z0
	 99sHnlDcJMeyA==
Subject:
 Re: [PATCH v4 1/2] lib/net_utils: allow mac_pton() to take a custom delimiter
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 andriy.shevchenko@intel.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, khtsai@google.com,
 fangxy@xiaopeng.com, rdunlap@infradead.org, dbrownell@users.sourceforge.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Tue, 10 Nov 2026 12:54:46 +0000
Message-ID: <179431528628.994134.9205744622940373491@kernel.org>
In-Reply-To: <20261106030605.576584-2-liuc63@xiaopeng.com>
References: <20261106030605.576584-2-liuc63@xiaopeng.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc this patch adds for parse_mac_pton() in
  lib/net_utils.c does not match what the function does.

--

lib/net_utils: allow mac_pton() to take a custom delimiter

This commit moves the body of mac_pton() into a new parse_mac_pton(),
which takes a string of accepted separator characters. mac_pton()
becomes a static inline wrapper that passes ":", so existing callers
behave as before.

Link: https://lore.kernel.org/all/20261105072147.3383565-2-liuc63@xiaopeng.com/

> diff --git a/lib/net_utils.c b/lib/net_utils.c
> index 215cda672fee1..011857cc978b4 100644
> --- a/lib/net_utils.c
> +++ b/lib/net_utils.c
> @@ -5,7 +5,18 @@
>  #include <linux/export.h>
>  #include <linux/hex.h>
>  
> -bool mac_pton(const char *s, u8 *mac)
> +/**
> + * parse_mac_pton - convert a MAC address string using a custom delimiter
> + * @s: string to be parsed
> + * @mac: buffer to store the result, left untouched if @s is malformed
> + * @delim: characters accepted as a separator between the byte pairs
> + *
> + * @s must be MAC_ADDR_STR_LEN characters long and use a character from
> + * @delim at every separator position, e.g. "aa.bb:cc.dd:ee.ff" with ".:".
> + *
> + * Return: true on success, false if @s is malformed.
> + */

[Severity: Low]
This isn't a bug, but does this kernel-doc describe what parse_mac_pton()
actually does?

The only length check in the function is:

	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
		return false;

strnlen() is capped at MAC_ADDR_STR_LEN, so this check only rejects
strings that are too short. The parsing loops read only s[0] through
s[16], and nothing checks that s[MAC_ADDR_STR_LEN] is '\0'.

So input such as "aa:bb:cc:dd:ee:ffJUNK", or the 7-octet
"aa:bb:cc:dd:ee:ff:00", returns true and fills @mac with the first six
octets. That doesn't fit "@s must be MAC_ADDR_STR_LEN characters long"
or "false if @s is malformed".

The runtime behaviour is the same as the old mac_pton(). The current
callers (the mac_pton() wrapper, and get_ether_addr() in u_ether.c later
in this series) don't depend on long strings being rejected. However, a
new caller that trusts this doc could skip its own end-of-string check.

Could the doc say instead that @s must have at least MAC_ADDR_STR_LEN
characters and that anything after them is ignored? The other option is
to reject strings where s[MAC_ADDR_STR_LEN] != '\0', but that would
change behaviour for existing mac_pton() callers.

> +bool parse_mac_pton(const char *s, u8 *mac, const char *delim)
>  {
>  	int i;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106030605.576584-1-liuc63%40xiaopeng.com
