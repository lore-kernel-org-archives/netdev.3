Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F371922F5
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502026; cv=none; b=YzUKtJ3Lwx6xmoTWVuwi/2BEg/ipUZYZEFUVgNuxF7Vb4/ENpAklMkoIotGIb4dAPKphs/pkOEALZSpUlgGZkEQz04xb1k0/Z7cxOnnM8fFYC3SBcAPuoornBNxkDWLNnYEO80hOL2JKP0HXQLjumcQ92OAvnooOFcZasJt+Lfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502026; c=relaxed/simple;
	bh=6RrdZ/C27wlmKR6ujf+o8N5Nipb5GGqNtYGg4nRoFCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yi3AzZ4OxTGDoVdjoZmFcL+I0EmL8YwMoP7E2ynSOYZlVbN+R4/wRtKb77bdT9E/tfRI6NAjl7qWcjBLvoqd8fDSp860TFoxAHoEoREq9jbERXLoBif7kOjVWB+QI0QloL5XnvRtdIBPub8xQexNpkJXvefgY2XgAzi7DR0xeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwYQbQ/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwYQbQ/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39831F00A3A;
	Wed, 12 Aug 2026 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786502025;
	bh=RuiuQhGNfA6JOkYYADd15/3Lkr0POhkg64ivicMk/6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JwYQbQ/hR7vKzIgtFoaBijgk/5zvd5A2d/knDDfzGLDIP3jbbHluL9POmsDjj7XYf
	 zmTuBe/A/8T+745ZQZgeAoxsk55uo1PT1cYUdhIdH+/pgRSaCIQhKuIpNhz0AnR9sl
	 JzBi7xMtI8XRECNeE/pLXaHCDHhiucfoZDymcNsd6ckj+3SiKef446KQnhZSXmOTLX
	 SwIpAapT5r+2K05wV9hXbpfAG8FKKW3uND8sYpci8Q+DH1Nx6DHASknYW/TmCtAJud
	 i/bJeMHrV5i8D/MJI+qFMpHqSvTosAMyuYv+s8dv2EmwHt/yQnr/LmFg8O7781ZtKf
	 LHyMQVXh24eyw==
Date: Tue, 11 Aug 2026 19:33:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, svens@linux.ibm.com, brueckner@linux.ibm.com
Subject: Re: [PATCH net] tls: fix RX desync on overlapping skbs
Message-ID: <20260811193344.4b394e45@kernel.org>
In-Reply-To: <20260807173532.2256680-1-maxbr@linux.ibm.com>
References: <20260807173532.2256680-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 19:31:05 +0200 Maximilian Immanuel Brandtner wrote:
> On a reordering path (e.g. IPsec crypto offload + GRO) the TCP receive

It'd be better to move this "IPsec crypto offload + GRO" to the end,
it's not super relevant to the problem. Mention that you observe this
in real life and that "IPsec crypto offload + GRO" is the likely
culprit. Mentioning the NIC may also be useful to other users.

> queue can hold adjacent skbs whose sequence ranges overlap. The tls
> fast-path reads the record header with skb_copy_bits() by byte offset,
> which assumes skb ranges don't overlap.
> When a record boundary lands within the last few bytes of an skb, the
> 5-byte header straddles into the overlapping next skb; the duplicate bytes
> are read as the header, yielding a bogus length (-EMSGSIZE) or version
> (-EINVAL) and aborting the connection.
> 
> tls_strp_check_queue_ok() already detects such overlaps and diverts to the
> seq-addressed copy path, but it only ran after the header was parsed,

The rest of this paragraph below looks like slop, don't describe what
the patch does. We can hopefully see that from the diff.

> and
> it validated stm.offset + stm.full_len -- and full_len is still 0 for a new
> record, so it could not cover the header bytes. Parameterize it by length
> and also validate the header region (stm.offset + TLS_HEADER_SIZE) before
> parsing.
> 
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> ---
> Tested on Linux kernel 7.2 rc6
> ---
>  net/tls/tls_strp.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index 61b10c697ecc..64d5dea90540 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -430,9 +430,9 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
>  	return 0;
>  }
>  
> -static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
> +static bool tls_strp_check_queue_ok(struct tls_strparser *strp,
> +				    unsigned int len)
>  {
> -	unsigned int len = strp->stm.offset + strp->stm.full_len;

keep the stm.offset addition here, it's doesn't belong in the caller

>  	struct sk_buff *first, *skb;
>  	u32 seq;
>  
> @@ -525,6 +525,12 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
>  
>  	tls_strp_load_anchor_with_queue(strp, inq);
>  	if (!strp->stm.full_len) {
> +		if (inq < TLS_HEADER_SIZE)
> +			return tls_strp_read_copy(strp, true);
> +

no empty line between the two checks

> +		if (!tls_strp_check_queue_ok(strp, strp->stm.offset + TLS_HEADER_SIZE))
> +			return tls_strp_read_copy(strp, false);
