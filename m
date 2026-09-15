Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0A4B2038;
	Tue, 15 Sep 2026 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513067; cv=none; b=NpiOZfZZVtCZftAgOpY6DJKw3JjzbhBzlnf3w5pdvPSciJc4Fz8aOQYB4W02YSWb43+KaTQX9CUVanzLdcnSUSA1Z4c7AVTwDxLuHfgjX9s8q/uaBdTeqE9WvzelUfhU8bLj/ckpYaRf1P9Cqs9Yzf/CT3d8gM1enorzD5pXZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513067; c=relaxed/simple;
	bh=BgvX9jrbueN5Rm/tJdbmgfwE8emytchohzujjQY0AhQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZEZlgd0fOLbUMk7hRlbIgOTssLNNJRnpuEQ8lfMVjuqpz1W6XOUOOlMz2R/LCBvhGO4XoreWOsufWd+bD7hi5J/3mUJ22zWQRHba15j8kH00dR3escz9nrxSQGyc3eEF7i1aOoOxN0zXt7zj7qS5ewRm1NdIOWF4+WZaKFVc9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S24GzRbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S24GzRbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF51F0089B;
	Tue, 15 Sep 2026 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513065;
	bh=0FAZDEJWUBcgNu/tPczl9wmWS8AZOsh/q/XmmRGLteo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S24GzRbToMjIREYN7CTuFayZ3MdlQGU1gjJGSyh5EooimK+kn8RtVxQgrlJc2Jfz1
	 JF7RL7LZrfelEjr01cdVaR9HToX8quKqL35rXefUFLC6CePgsRmnUvJME/Vy1JdW1t
	 4f7NRGgzgihqYYri2jAxzfipA0Xv3pWTEmY/5O8jvXuft/3/dfAv0w6iW+zsvmYb2L
	 gxcy4dbL3p8rj7lPkIm2Ad4WtyZgykT0ojUGT/RiWQGshvvLgrfM74i+j60/7+koyp
	 1qqplDBsLNgGqFm2DdEJfZSJWV6SOSdwGm2JdvKzP965pnNVeDDvQQTuf+ZGfJP+fK
	 12HxHlC7m4bMQ==
Subject: Re: [PATCH net v10 11/14] afs: Fix creation of RxGK CM channel token
 to have right size
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:44 +0000
Message-ID: <178951306451.22033.10200734629950838825@kernel.org>
In-Reply-To: <20260914151340.3227501-12-dhowells@redhat.com>
References: <20260914151340.3227501-12-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Commit message gives a factually incorrect impact analysis for
  the bug it fixes.

--

afs: Fix creation of RxGK CM channel token to have right size

This adds the missing 4 bytes for the RXGK_Level field to the toksize
calculation in afs_create_yfs_cm_token(), so that the size of the
blob-to-be-encrypted matches the number of bytes actually written.  The size
arithmetic installed by the patch looks right; the question below is only
about the impact analysis in the commit message.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> afs: Fix creation of RxGK CM channel token to have right size
>
> Fix afs_create_yfs_cm_token() so that it calculates the token size
> correctly, remembering to add in the 4 bytes of the level.
>
> As it happens, this bug has no effect because crypto_krb5_how_much_buffer()
> rounds encsize up to a multiple of the crypto block size (16 or 32) before
> adding on the checksum size - and so there's actually 8 bytes of unused
> space allocated within the blob-to-be-encrypted and 4 bytes of that gets
> used.

[Severity: Medium]
Is this description of the old behaviour accurate?  I can't find the
rounding it refers to.  crypto_krb5_how_much_buffer() in
crypto/krb5/krb5_api.c returns the sum with no block-size rounding:

	case KRB5_ENCRYPT_MODE:
		*_offset = krb5->conf_len;
		return krb5->conf_len + data_size + krb5->cksum_len;

and krb5_aead_encrypt() in crypto/krb5/rfc3961_simplified.c never pads
either, placing the MIC immediately after the data:

	secure_offset	= 0;
	base_len	= krb5->conf_len + data_len;
	pad_len		= 0;
	secure_len	= base_len + pad_len;
	cksum_offset	= secure_len;

So rather than 8 bytes of spare padding existing inside the blob, wasn't
the effect that the last word written by afs_create_yfs_cm_token():

	*xdr++ = htonl(0);			/* token.identities[0].display.len */

landed exactly at cksum_offset, i.e. it was left outside the encrypted and
authenticated region and then overwritten by the checksum, because toksize
is also what gets handed to the encryption as data_len?

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
> index 103168c70dd4d..5eeeef761cf31 100644
> --- a/fs/afs/cm_security.c
> +++ b/fs/afs/cm_security.c
> @@ -235,7 +235,7 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
>  	 *	struct RXGK_AuthName	identities<>;
>  	 * };
>  	 */
> -	toksize = keysize + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
> +	toksize = keysize + 4 + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
>  
>  	offset = 0;
>  	encsize = crypto_krb5_how_much_buffer(token_krb5, KRB5_ENCRYPT_MODE, toksize, &offset);

Same toksize is passed as data_len further down in the same function:

	sg_init_one(&sg, encbase, encsize);
	ret = crypto_krb5_encrypt(token_krb5, aead, &sg, 1, encsize, offset, toksize, false);

There's no out-of-bounds write in either case, since cksum_len is 12, 16 or
24 for the supported enctypes, so the extra word stayed within the allocated
blob.  The reason the truncation went unnoticed looks to be that the only
consumer, rxgk_yfs_decode_ticket() in net/rxrpc/rxgk_app.c, only checks:

	if (ticket_len < 10 * sizeof(__be32))
		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
					rxgk_abort_resp_short_yfs_tkt);

and never parses the identities<> field at all.

Given the Fixes: tag and the cc: to stable, would it be worth correcting the
rationale so that backporters and anyone auditing stricter third-party token
decoders get the right picture?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
