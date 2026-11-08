Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794108758;
	b=HLt3POnVF6swl4YY6lWQjAKI6xfa29pRFy3JB3UAa7+YAlvWra1fxHjsIa/JMvT/JUMW
	 SCUhNV9hJvwSIHGk6hUXUbWXkaAFqAbhU8uNF1AdSsY4OojuE/Qa93QOTVj8YtlrNS6CH
	 +dal7XU53G7u8JPrtp4QuT+B6N0gJ3oxtANqBMu7KtAhqVuMxbCAeCwWrdCg3VoZ+Z5Oc
	 MFIgzVd3hJKA/qnVFgMzQzs0Xqma0z2p7N5YTytKDYbzAkZ1E19Cnp0M9VHMqBgkkBrYc
	 bDzSdVq5MpCV2EI37P9Fzz8wlBavrTn5wu1K74v1ODTNZnoy+D54qcjsEhoZmueGFyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794108758;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1KkunFVOR9hKpVunSG6R4MQyB90H0pMgHHtcvlxeDzU=;
	b=2G6utFwh1RJYah+TPlRR+NJL5I7wdUT28sWTfiKcsJl6KDCxNXKjl/t+Z+XfJwrbWHiE
	 eWj9S+gdNeWgt5aMr0RfS1RH+ytaYDKuJucocb52xUGgiZ7H13LwcplrL3jyJdfhVOIjo
	 XjY0i1mai5TEri9cTUzLjaJHV/p2OmIyHd0B722L4j9qwxLnpvoDViqls3/JuhPW7ytSm
	 M9SiYBvtLUo8qITsIcypyhj3ayLahXTOtzMqdTix/PfP4lgO+7QJTpL9zPSa6V2HrK69a
	 EUmSp8wsuPavdyFgWgFWsW7Vt7vSMUyhmBSjPvT3hroR7enSH6axHstMvlLbbUobEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5YzOJuM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48D606A31C;
	Sun,  8 Nov 2026 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5YzOJuM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7791F0089F;
	Sun,  8 Nov 2026 03:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794108758;
	bh=1KkunFVOR9hKpVunSG6R4MQyB90H0pMgHHtcvlxeDzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B5YzOJuMa07gUCuZW7PeLZxy6As0ZWPv4JoeGCp58HmvMvpliq8tU/M/6DrPbmCIa
	 5xGE2Kcj+KqL+apcZbC4UDovB5qfgSHe8PXrcZfwYzpUEBYgJa/ylHhrf+JYY6tffN
	 l3kEGi/OP472mI8F9x1ARmKbzCEGWNlnIWec+hUfvJ8unrZmwbIWaqnVUFY8Wl+lUC
	 VFLHvhG6k+Kb9EWYsA15XgPj7fkUiRjz11XFfjkB8GfY5Fh98k8ozktjf57rPbs1RF
	 UPJYQZJMaEO1ZV/K/YbPF1wZNWZMt3sIXQhmYOznybh/33vuYZ60TRcVR8HEqJqIF9
	 N6BvOaKjzWObQ==
Subject:
 Re: [PATCH v2 1/2] lib/net_utils: allow mac_pton() to take a custom delimiter
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 andriy.shevchenko@intel.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, khtsai@google.com,
 fangxy@xiaopeng.com, rdunlap@infradead.org, dbrownell@users.sourceforge.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 08 Nov 2026 03:32:36 +0000
Message-ID: <179410875676.994134.16092814735554237701@kernel.org>
In-Reply-To: <20261104025058.2650911-2-liuc63@xiaopeng.com>
References: <20261104025058.2650911-2-liuc63@xiaopeng.com>
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

- [Low] The new kernel-doc for parse_mac_pton() in lib/net_utils.c says
  "@s must be MAC_ADDR_STR_LEN characters long", which reads as an…

--

lib/net_utils: allow mac_pton() to take a custom delimiter

This commit moves the body of mac_pton() into a new exported function,
parse_mac_pton(), which takes a string of accepted delimiter characters.
mac_pton() becomes a static inline wrapper that passes ":", so existing
callers behave as before.

Link: https://lore.kernel.org/all/20261023110113.2969708-1-liuc63@xiaopeng.com/

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
Does this kernel-doc match what parse_mac_pton() actually checks? The text
"@s must be MAC_ADDR_STR_LEN characters long" reads as an exact length, but
the code only checks for a minimum length:

lib/net_utils.c:parse_mac_pton() {
    ...
	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
		return false;
    ...
}

strnlen() is capped at MAC_ADDR_STR_LEN (17), and the validation loop only
reads s[0] to s[16]. Nothing after the 17th character is looked at. So
inputs like "aa:bb:cc:dd:ee:ff:00", "aa:bb:cc:dd:ee:ffXYZ" or
"aa:bb:cc:dd:ee:ff\n" return true and fill @mac.

The Return: line says false means "@s is malformed". A caller could read
that as saying true means the whole string was a well-formed MAC address.

The old mac_pton() parsed only the prefix in the same way, and existing
callers depend on it. Sysfs and configfs input usually ends in a newline,
and some callers parse a MAC address embedded in a longer string. So the
code looks right and the comment is what is off.

Since this is a newly exported general-purpose API, could the comment say
something like "@s must contain at least MAC_ADDR_STR_LEN characters; only
the first MAC_ADDR_STR_LEN are parsed and any trailing characters are
ignored"? Enforcing an exact length would break existing mac_pton() users.

> +bool parse_mac_pton(const char *s, u8 *mac, const char *delim)
>  {
>  	int i;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104025058.2650911-1-liuc63%40xiaopeng.com
