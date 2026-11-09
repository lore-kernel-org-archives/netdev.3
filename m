Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217580;
	b=AxVmVtil+VSKj1GExLz/dtTvYY90lfc635uvRPqRt/6YcRgXxU7panhLkHjeNjANyADm
	 WRJWmsTbm2+302dSVkkiDq7fznetgi8/aM1n/eSGn0/qTHxjcskXZWhHqjTuLyF5RONLh
	 L/arTSG5D0L8D05QCWVZfotni6U41wl8FXDxq13xP6OGXOvva9MZO3kbMtVCad3GvARUz
	 tUOAY/C+qTXG/fo97JyZKG1LuEZoJEjdt7lBNyORbx9DAYqfYS0tBX9Qz6isoZsTdU/RK
	 7X9lZxFDZMu3LaOY1USkCEqTlvxorj6+Wh+pWrvCRiExrYu90acSuxgjzMcWKQbmcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217580;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=j/JNSqiuxSrB70B02fRtLw3bSYxRwlLDMiCkZqEuAV0=;
	b=CJT2g4mqqA8OQZ6jYLh1mjvd4Kmx9rB1SeD5xNtRDmK9Ta+GuRRc8jYoz64HiuEgurAQ
	 XU5OU/Fh2INCxJcGLXNxTdswBYJ7QKS4TPmX4Y49fB2F2/uOkJLhHlgEA8WOy8B1s1V7+
	 yGVFNWPeQTeD+MQwBg89snQyVlxT5MHQMuR5KtECQnl9ZBxpUZLO0PSaoWTPBdAv9d6m2
	 S52m+3Lj2gOwSfu8f+hc/PWORAHnDJNXfhsog8np853B/cR73Q2DNDaV3zvVutvajAcJ0
	 Uq90VRVxK2ompnDAMHl6ppVtiDsPNTykxzOSGu2PdohQO3j9ivZdNATTHz3wIFK/A3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTDGMlJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97494606A323;
	Mon,  9 Nov 2026 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTDGMlJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E831F008A1;
	Mon,  9 Nov 2026 09:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794217580;
	bh=j/JNSqiuxSrB70B02fRtLw3bSYxRwlLDMiCkZqEuAV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PTDGMlJiFfoBNSmEUkvji9RMFkPeN4z4fd7qZkPHZUv6bnJeH3EVqTDCdYQTfAR0s
	 62mc7epQR3o0y6ka5+NLoWSfu3U+bwdhCVuadEPBrQfU/OZ29SKpTmZwZKnsls2Xb7
	 MKB3kDEyBncpmpYU/DMCpSg5Gj8dstE8ZIsbLaWRqfTJE5qd3f0jXJYVSLjPnBXfVV
	 snc/Ntd9R2XVSSzVFOw0TNgOQ0zYi/qDVpUbP1t+XiPhNSBAHNsz0zwoXeWAVaF8cU
	 DH0iIjZ7PS4C+R9aYp68PO+r99+rbRL/Gr3xkQzOGS8OajM6J81LcBfgabjfa1cP3f
	 MrCUSQtd9QDVA==
Subject: Re: [PATCH net-next v2 1/2] net: dsa: motorcomm: Report error when
 FDB fails to add
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 09:46:19 +0000
Message-ID: <179421757926.994134.10474840324955611823@kernel.org>
In-Reply-To: <20261108094512.1285796-2-mmyangfl@gmail.com>
References: <20261108094512.1285796-2-mmyangfl@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Bit 14 of YT921X_FDB_RESULT is defined in chip.h:284 as
  YT921X_FDB_RESULT_NOTFOUND.
- [Low] This patch fixes a real silent-failure bug but has no Fixes: tag.

--

net: dsa: motorcomm: Report error when FDB fails to add

This patch makes yt921x_fdb_add() check the result word after the hardware
OP_ADD operation. It now returns -ENOSPC when the result reports a failure,
instead of always returning success. The commit message describes this as
preparation for the upcoming static entry counters.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..a7a9a74393045 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	if (res)
>  		return res;
>  
> -	return yt921x_fdb_wait(priv, &val);
> +	res = yt921x_fdb_wait(priv, &val);
> +	if (res)
> +		return res;
> +	if (val & YT921X_FDB_RESULT_NOTFOUND)
> +		return -ENOSPC;

[Severity: Medium]
Is YT921X_FDB_RESULT_NOTFOUND the right bit to treat as a capacity failure
after an OP_ADD?

Everywhere else in the driver this bit means a lookup miss. For example,
yt921x_fdb_has() checks it after a hash-mode GET_ONE:

drivers/net/dsa/motorcomm/chip.c:yt921x_fdb_has() {
    ...
	res = yt921x_fdb_wait(priv, &val);
	if (res)
		return res;
	if (val & YT921X_FDB_RESULT_NOTFOUND) {
		*indexp = YT921X_FDB_NUM;
		return 0;
	}
    ...
}

The only caller of yt921x_fdb_add() is yt921x_fdb_join(), and it calls it
only after yt921x_fdb_has() has reported the key absent. In that case a
"not found" flag would naturally be set.

Suppose the hardware sets this bit on ADD to say the key was not present
before the insert. Wouldn't every new static FDB/MDB entry then fail with
-ENOSPC? That would include the host addresses DSA installs on the CPU
port:

yt921x_dsa_port_fdb_add() / yt921x_dsa_port_mdb_add()
  -> yt921x_fdb_join()
    -> yt921x_fdb_has()   /* key absent */
    -> yt921x_fdb_add()   /* OP_ADD, NOTFOUND set -> -ENOSPC */

If the bit instead means a generic lookup or insert failure (for example,
no free slot in the hash bucket), could a comment or an alias macro be
added so the ADD-time meaning is written down?

YT921X_FDB_RESULT_OVERWRITED is also defined, but nothing reads it.

> +
> +	return 0;
>  }
>  
>  static int

[Severity: Low]
Should this patch carry a Fixes: tag?

Before this patch, yt921x_fdb_add() returned 0 even when the hardware
rejected a hash-mode OP_ADD. DSA and the bridge then counted the static FDB
or MDB entry as offloaded, although the switch had never programmed it.

The ignored result seems to come from the original driver commit:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

The commit message says:

  In practice the 4096-entry table is hardly ever filled

The ADD is hash keyed and not index based (no YT921X_FDB_OP_MODE_INDEX).
Could the hardware reject it once a single hash bucket is full, well before
all 4096 entries are used?

If the patch is not meant for stable, could the commit message say why?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108094512.1285796-1-mmyangfl%40gmail.com
