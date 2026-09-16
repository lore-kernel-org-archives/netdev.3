Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4D4A5C2B;
	Wed, 16 Sep 2026 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560334; cv=none; b=JF1+IgEZWdBrMLbMA79z8OsXDf8yehi7az4y35cEKwu/NU9Nh2F5uXzyQb9r1sqSSz1CAYnge1fuJYIXmuNvKnE5X7p2brwFnL/mVwk+jeqSeG8SsFzzHxpNUzi/HCy0u/u5Xb+pLlzspTml48uK8ZPM2tzSsW0dZRgGCHf6QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560334; c=relaxed/simple;
	bh=pB4ajd9CekEA+EsQ37qDFqowNoyq/xTdxT/MdWW+BbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY4oRakGKwg200y+JkqFntlyZ6/GfDEGER8GVzOEYopCcmgn2nftFOkjIsFz7MlkxPZzWIY7F5+ctVS+JC18Ob3O17ETV9DVnlaKSBysMjzOsZGmpnBtq9+m7+kLn319nToh0d7Vfv3bCWIfygleJhCv4S+QgRIG528yn1zapog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU8aTf/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU8aTf/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565FA1F00898;
	Wed, 16 Sep 2026 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560326;
	bh=JXvHZLoQIlFZmPrrjjTVehOEu/jmp+1LnP9kQf0ktrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fU8aTf/TLtdpehlFnNI6SlWSg4lwiPi68YQcRGl4G07GnhpvMeOjkGc1d11JIfkLz
	 N/ck/Hm+ftgOSKPDTl9qXjCJTo2bBlYNjYqHkckdrCzap8amg7Le92OfPnSP9AprYN
	 vwyWXzOs6kcNb4WDV0Z97EbVEfaZP/WH3BE0rra/rlY17sFDl4+9ymHKhEt9JYGPcV
	 MUxowDPhMWEEQa69CVl5FKeY08eU7cq1J2wWj9ujMGq8IxEHHdVDRZdXiVqDN7PNbT
	 ct6caGPVKbVqucgaqNCoARW0siCioKqpoLyOZcSsWD6XvxOKv+NZGEduCWNRTB//ut
	 oD7ztvRzk4ZXQ==
Date: Wed, 16 Sep 2026 13:05:19 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ncsi: validate response packet length
 before accessing fields
Message-ID: <20260916120519.GB51261@horms.kernel.org>
References: <AS8P251MB000151B1FA33EDC00D8275D2C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB000151B1FA33EDC00D8275D2C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Sep 12, 2026 at 07:09:37PM +0100, Aamir Ahmed wrote:
> ncsi_validate_rsp_pkt() takes a pointer to the response header and then
> reads the checksum at the end of the padded payload, without checking
> that the skb holds either. ncsi_rcv_rsp() reads the common header the
> same way before that.
> 
> For response types with a fixed payload the header length check is not
> enough: a short frame whose header claims the expected length passes it.
> For the variable-length types (GP, OEM, PLDM, GMCMA) the payload comes
> from the header itself, so the check is tautological.
> 
> The response skb is not guaranteed to be linear, so use pskb_may_pull()
> rather than testing skb->len, and take the header pointers afterwards -
> pskb_may_pull() may move the data. The payload is padded to four bytes
> and the checksum occupies the last four, so the validator pulls
> ALIGN(payload, 4) rather than payload. ncsi_rcv_rsp() keeps a copy of
> the packet type for its error paths, as its own header pointer does not
> survive the validator.
> 
> Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
> v2:
>   - use pskb_may_pull() instead of testing skb->len, and take the header
>     pointer after the call (Simon)
>   - pull ALIGN(payload, 4), not payload: the checksum sits in the last
>     four bytes of the padded payload, so the v1 bound did not cover it
>   - guard the common-header read in ncsi_rcv_rsp() too, and keep a copy
>     of the packet type, since its header pointer does not survive the
>     validator's pull
>   - correct the Fixes: tag; v1 quoted a hash that does not resolve, and
>     the blame for this file is the commit that added it
>   - drop the GMCMA hunk; it belongs with its own handler
>   - add the Assisted-by: LLM tag (Simon, Greg)
>   - name the target tree in the subject
> v1: https://lore.kernel.org/netdev/AS8P251MB0001E6ABBE0B6809D3E21B9DC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Reviewed-by: Simon Horman <horms@kernel.org>

For future reference:

This patch-set has two patches.  But they seem to have been sent as two
separate email threads.  Which confuses some tooling, such as Sashiko.
Using tools such as b4 or git send-email (in conjunction with git
format-patch) should avoid this problem.

