Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211340;
	b=C6vB26cDgnLQmjSYP5cpAKsXB4imp6+3WxN6UvUKlkEavzjw7Zif0aOv0lT4Ao67/AbZ
	 IDGbFb5hn0TGO++UJgUIxzE0UzqkdAQDylCvjn+muX9lYVtZ1vHIdJeO4SZJ9OlEaWqRT
	 ys/JZA3jVp+aq5ayXmAp74xmN8ouZy3QrSzqkqF0TMI9DyzvWtmO3ZKVlWd2LxLpLUi2h
	 IpCdtgxX4L4BYLJVRs0pW2DM2gOebMT5ARQB8tN5kzkK6oiM8+XArRJ8AbO2nYv2RpCJ4
	 eVomemGQ9yJPwsm3qmUgoM1Ibao+ynRAUMWswhZONNmYpHzqGxYMyP030eBeK0TjDoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211340;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/mAjzZEkosZRDQ8zd4dGgpytp3p0kqh3evUh6L5DLZY=;
	b=QoVlX7bZCG4+EEEmN6PCiyZ/MkMi7j2s4DLVYLh9KGrw6eioCFuyFokGbqFjBz91y+0p
	 uII2vwdPelSnrAPeIZoh9SSM/GuLR+VOzNPs62+NeZ2TI8+reZNGN+Pbnw//ikauDWO5/
	 iyNv/4ui4Fx7Ops0+xu5rHlpYId8KCKohmwjLZge/dyZGIkMD8Hm6C1pWQMn+vfyBK9Y6
	 L8W/hUZ8b9lj4u5La7slUbJVeXMgZfr+ZxAKb4fWhyyBCe2eYtwBdNY6bj8MG6jcneX04
	 GGbpXpHNm5Xb1U5n5UsgJKN/Vssru0kPVe0ZLuFABFqJZj+NICUkP7ZzY47koyU40IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYMVFGL+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD9606A321;
	Mon,  9 Nov 2026 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYMVFGL+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA80B1F0089F;
	Mon,  9 Nov 2026 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794211339;
	bh=/mAjzZEkosZRDQ8zd4dGgpytp3p0kqh3evUh6L5DLZY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CYMVFGL+H4lICdCOFhaO4J6dyZ+Bn5x1C0gRn9ycYjDhoDKqLymYw+Qx2yfJ+/BuG
	 hyd2FGGQK3AHf/wZeYcNbBdOPTKEwSCUj0oz2we5neryvdz3wE0G8Z6T+/edTxE90T
	 U+/q0rLYEGfSjBk/Frg0DmSQWZApcBf7zJYlKiPeRweWTqMq2ipXmAeZqZcJvxYEnA
	 FefNXZpdh6SFdUdborc2Er0rth/SgHF1E2gssZkCib/WphqOUjzGpqQ9NpRfrSfUh3
	 pH9Vun5uJkdGxp29Ecx5UiMV0HsYlUJJ+rDp/m/2mBr7yyzq5ThnLIWk2C3qMMrG6Y
	 80B/2NeRjwF7w==
Subject:
 Re: [PATCH v3 1/2] lib/net_utils: allow mac_pton() to take a custom delimiter
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 andriy.shevchenko@intel.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, khtsai@google.com,
 fangxy@xiaopeng.com, rdunlap@infradead.org, dbrownell@users.sourceforge.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 09 Nov 2026 08:02:18 +0000
Message-ID: <179421133849.994134.10259570241135328106@kernel.org>
In-Reply-To: <20261105072147.3383565-2-liuc63@xiaopeng.com>
References: <20261105072147.3383565-2-liuc63@xiaopeng.com>
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
which takes a string of accepted delimiter characters. mac_pton() becomes
a static inline wrapper that passes ":", so existing callers keep their
current behaviour.

Link: https://lore.kernel.org/all/20261104025058.2650911-2-liuc63@xiaopeng.com/

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
This isn't a bug, but does this kernel-doc match what parse_mac_pton()
actually checks?

The only length check in the function is:

	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
		return false;

This rejects strings that are too short. Nothing checks that
s[MAC_ADDR_STR_LEN] is '\0', and the validation loop only reads offsets
0 through 16:

	for (i = 0; i < ETH_ALEN; i++) {
		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
			return false;
		if (i != ETH_ALEN - 1 && !strchr(delim, s[i * 3 + 2]))
			return false;
	}

So strings such as "aa:bb:cc:dd:ee:ff:00" or "aa:bb:cc:dd:ee:ffGARBAGE"
return true and fill @mac. The trailing characters are silently ignored.

mac_pton() already worked this way before this patch, so the code itself
is unchanged. What is new is the comment, which says @s must be exactly
MAC_ADDR_STR_LEN characters long and that malformed input returns false.
New callers that use other delimiters might trust that and skip their own
check for trailing data.

The only new caller in this series is get_ether_addr() in "usb: gadget:
u_ether: fix out-of-bounds read in get_ether_addr". Its old open-coded
parser also ignored trailing characters, so it sees no change. That later
patch does not touch lib/net_utils.c, so this mismatch is still there at
the end of the series.

Could the comment say something like "@s must begin with a
MAC_ADDR_STR_LEN-character MAC address; trailing characters are
ignored"? Changing the code instead would change mac_pton() behaviour for
existing callers.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105072147.3383565-1-liuc63%40xiaopeng.com
