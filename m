Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083328;
	b=Crl7RxE8vA4N3sShWD+ur6t/v7ddIudcUQCr81RobGFK70/ZAQlu2y+9a5ORh/jvqCfh
	 0ZEU5SGQERQaMUcB17y1IAkxYL65ZqkA/hk2/wjlF3+JNVKZ8wdwjen16VtFgXjM3SVNz
	 A2PQkPro/d1Ro7XOkp6O9LhFDbv5EW1UJ3746j1R/l7dDay/9ttm3CAjezsZTtp29oOOP
	 rAECLCfv+S4x71da6If99T6fUZ7UMgjn+HIK36PekbRiTAcz1dxWE6smqf4Srb5eH8zJX
	 GLD0Z5BNF6tSgSVNR1H4jAcxZ6Xf5/m+LOilcUZ7lpH6tdxbDRNBax/Wsbn9NPewbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083328;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yhV6Qi8oP3wsBHx8AcQx+K7PgSHJp9dJD4R1lrCW+YM=;
	b=aVI8OYakcpyupDF0Zdgk5RxC9kqV8gH4VPfl0kbLUg+HwcPFWIt1XGytPdCqr5pIkLeW
	 7W7eefj6FQ+ostXWc0me8APydT5nRIEJA1T2qYkFlLabf9Z0EAM3FkmhaaWT16B+/cRn+
	 4rBaKTrFZvZFZWy5KwmMPb4SIUQ3Y7HiR8gJ3t6mGwZAAFvO52MPCqsZvPTuoaH457tDP
	 pSOM75mxcziOp/nS6j+fbZkz1Q8fnYr6L4rMET93FipIA5sXRm6q47nxpxUTfP3JnhIdL
	 KKWbQwrChxB+jSBP9cGOpdRtlQgLgXDSV8pmo6joNoxBpQF0ZVrgRmupz0EmgIA7hzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNplFQEp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCF606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNplFQEp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEF31F031E5
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793083327;
	bh=yhV6Qi8oP3wsBHx8AcQx+K7PgSHJp9dJD4R1lrCW+YM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MNplFQEptICEhgYJEua7ll4vbpkZ3U4mW5gzoB9k9tFiKtGPh1NUtHH2yKlqtqje6
	 4CnEPm810ZP/xLDxZChQFFgEJk9TNsENn9fiq1yStPJcuTzBRMbVv02wuqRBwVbnBV
	 HiQVkd8JF4JH9pigNWgf8Pw4QjW6+S1crroRxGUuHxY7LXqkK2LJY/vsSTgnG7U7BY
	 KP+qDId99WGr3qW7C+BVHAD6hVzZ9BGYu/naGz1QCmLr2P2QY47yeVMvw6JN7ENQWK
	 VZEvJl/PJE9HewuNCjAjnWdES2f0IOHTpcPoxcU3qjIxqgDIMIthmtfZAFk3eDoyKN
	 4zvTgKXDoktrg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-70059e4dab6so2670258eaf.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:42:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy4rjjEw/8aNTxAV2dFLMRhbaScjDrO6JR2qBQw77ICLn9BV8NLx0VE0pHKQXrU0X9elEE0sLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhEmyQIV5ckWib4pKbF/oO+ZJTesj/bhns90QFuBDCzvs7Np81
	vg6NbQK8yoEyg0pOwkd0WURXk9KvNoVoOcTrerR9VpLsUAX6HWF5J4ELEfnNhLEkJrvdQc4A8Ts
	3NH7rbEfXM5zc2LsSZJcO+4azaZbndFs=
X-Received: by 2002:a05:6820:616:b0:70b:a4a8:a32d with SMTP id
 006d021491bc7-70ba4a8b55amr4429661eaf.30.1793083326837; Mon, 26 Oct 2026
 23:42:06 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026091549.605810-1-p@1g4.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 07:41:55 +0100
X-Gmail-Original-Message-ID: <CAL4WiirG9+kP8vTNgSC=NfWA7eqnoDHZ6UMJ4bBEYOF7oNg4NQ@mail.gmail.com>
X-Gm-Features: AclHuK-_ZepuWsPA_tB9v5pjt92BBzYdY9sMEaBbm3_-uA4NkNald1VGOO5yyE8
Message-ID: <CAL4WiirG9+kP8vTNgSC=NfWA7eqnoDHZ6UMJ4bBEYOF7oNg4NQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX timestamps
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, 
	chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, 
	horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, 
	matthew.vick@intel.com, aduyck@mirantis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 10:16, Paul Moses <p@1g4.org> a =C3=A9crit :
>
> Preemptible queues require software padding so hardware includes the
> padding bytes in the mCRC. Padding currently runs after TX timestamp
> reservation takes an extra skb reference. If padding needs to expand
> the skb, pskb_expand_head() rejects the shared skb.
>
> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
> padding error path. skb_padto() drops one reference on failure, and
> out_drop drops another. This can free the skb while the pending TX
> timestamp still holds its pointer.
>
> Move padding before TX timestamp reservation and use __skb_put_padto()
> with free_on_error set to false so out_drop handles the skb release.
> Preserve the VLAN flags in first->tx_flags when adding timestamp flags.
>
> Fixes: 17643482e9ff ("igc: add preemptible queue support in taprio")
> Signed-off-by: Paul Moses <p@1g4.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
