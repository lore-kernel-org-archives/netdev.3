Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21E431E60;
	Mon, 20 Jul 2026 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559247; cv=none; b=XF6DgDJY/zidEw3DXbTjY+b3IwR/lqZwm5isrmATXZYSX/dI6ituIO4wN84FRVU3pAZ0Xiu2LbPB3viEOyIFadIV8Dt5LBUNx+K2da0UNQVXt9tZNxATgJWKDcTmc9jNBO6gUCYqdwT2nEA0TIJ/aDP7SAb36xZ5q0k5Q+XU3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559247; c=relaxed/simple;
	bh=ugBecLFod58ZpWYhmJbgIviDVk99Cr0xUnyqGxMsg3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyFQ8CA9v+q8G8U6j0Y0/VHnVnguXybvCQGKGYkW5Eeu34fXHyx+2hfPSaw9w4afXdB51b+3PdFn3PR6iT/jNEDyVv1QxOgSovRIMOnBVx/IVUwV+xxIknmUz2kcmKbuHYbPZGjQqgpamwc3UVGQH4aBWdUQ5v+PXO5nAh7282Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+2CU7HH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+2CU7HH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758D21F000E9;
	Mon, 20 Jul 2026 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559246;
	bh=vjW4vMokjFNxEZxe2yvRaYhnmmgONQolmpii7B/vEUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+2CU7HH719tjc95FOaC3jF2S3HMjtzTJx1KhsA0wedXKz27wyRkfgz91shLw6v78
	 kB6/92owLjiavIrfC3tUv7nAUGEJLdMb5MZj5qi2yJYUYOk9AZlmjsUZDf+VUQ6dku
	 RMVVz2nsPS2SWXvqtdZiTg0kh8vULF7CbulMu0ocRbSeV4N+b27h3SI9jh3nSwDj1A
	 L7WQ/06By5mM0rByIVx6Tgw72HajPQOQptqfqxRbjspsQQRG+RUVkhy2JeYSH+wYSX
	 TKva1am0p/ZKBERjmqG8eMahySy2apnhRGbIS7Ah36kjSXlnoy1cDgBICkIiCMWW59
	 TTxk+FaEbTI5w==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net v3 11/14] afs: Create a server appdata key
Date: Mon, 20 Jul 2026 15:53:56 +0100
Message-ID: <20260720145356.195862-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713081022.2186481-12-dhowells@redhat.com>
References: <20260713081022.2186481-12-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713081022.2186481-8-dhowells@redhat.com?part=11
---
--- Patch [11]: [PATCH net v3 11/14] afs: Create a server appdata key ---
commit dc88fd6982b57fe321cbc39b2f060f5b1d06bb8e
Author: David Howells <dhowells@redhat.com>

afs: Create a server appdata key

This commit creates an appdata key for each fileserver the AFS filesystem
talks to with RxGK. It attaches the key to the afs_server record to be
used for generating application data in response to CHALLENGE packets.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
> index 103168c70dd4d..36907a04efd0b 100644
> --- a/fs/afs/cm_security.c
> +++ b/fs/afs/cm_security.c
[ ... ]
> @@ -23,6 +25,236 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
> +	/* struct RXGK_Token {
> +	 *	rxgk_key		K0;
> +	 *	RXGK_Level		level;
> +	 *	rxgkTime		starttime;
> +	 *	afs_int32		lifetime;
> +	 *	afs_int32		bytelife;
> +	 *	rxgkTime		expirationtime;
> +	 *	struct RXGK_AuthName	identities<>;
> +	 * };
> +	 */
> +	toksize = keysize + 8 + 4 + 4 + 8 + xdr_len_object(authsize);

[Severity: High]
Does this toksize calculation omit the 4 bytes required for the level field? 

It looks like the sizes added up correspond to starttime (8), lifetime (4),
bytelife (4), and expirationtime (8).

If the level field is omitted, toksize will be 4 bytes too small.

[ ... ]
> +	*xdr++ = htonl(RXRPC_SECURITY_ENCRYPT);	/* token.level */
> +	*xdr++ = htonl(0);			/* token.starttime */
> +	*xdr++ = htonl(0);			/* " */
> +	*xdr++ = htonl(0);			/* token.lifetime */
> +	*xdr++ = htonl(0);			/* token.bytelife */
> +	*xdr++ = htonl(0);			/* token.expirationtime */
> +	*xdr++ = htonl(0);			/* " */
[ ... ]
> +	xdr = encbase + xdr_round_up(encsize);
> +
> +	if ((unsigned long)xdr - (unsigned long)appdata != adatasize)
> +		pr_err("Appdata size incorrect %lx != %zx\n",
> +		       (unsigned long)xdr - (unsigned long)appdata, adatasize);

[Severity: High]
Can this manual advance of the xdr pointer hide the token size mismatch?

Because xdr is advanced based on the miscalculated encsize rather than the
actual number of fields written, it appears this will bypass the adatasize
sanity check on the next line.

[ ... ]
> +	ret = crypto_krb5_encrypt(token_krb5, aead, &sg, 1, encsize, offset, toksize, false);

[Severity: High]
Since toksize is smaller than the actual plaintext being constructed, will
this corrupt the token?

When crypto_krb5_encrypt() executes, it seems it will only process the
truncated toksize bytes of plaintext. This would leave the trailing 4 bytes
of the serialized XDR unencrypted and overwritten by the appended Kerberos
checksum. 

The fileserver would then reject the appdata token when XDR parsing fails.
