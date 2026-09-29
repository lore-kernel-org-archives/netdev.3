Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15933A032
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641236; cv=none; b=C2c0SJoW3TSkLrEQYVhc6XoHPio/NaoU1J0TG6CUJpzWSmQ61lGWA9MFdDbUhjbaTsIMaaQdtEBqv+p61/lXziP3fc0jJmrMo838GsSEG9JbBDGFo10TXb5SMhbPJRyT6lr3aoEEhwPEH7ToDn5AJkT1vX2n1BjsotFfb48Ag7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641236; c=relaxed/simple;
	bh=njaNJUNDzcQJqP8cXWyLujjI7GkWmjvNDB2uLaRHOsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGgEplp1gFtK9mFDVM4mV3ig2z66en1zVL6Ryw78O3ujbT6WfrUe3U0k+9PI0+5NBV7cj4JWhu2AN1Wu7NOW1SkyC7HMK0fJ06VOaBZqYfKw5wblQHFaQOow575aztB+EPslCX9l0uhT/E24J2eXsJUYI0mqYpn4uSYGPqKSCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=K4eGEfXO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="K4eGEfXO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1580969a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790641234; x=1791246034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ve4zzzXKEVOYiC04gBko3TUlMyxYcTGnHNIKti8S/Sw=;
        b=K4eGEfXOJpLFkcWW+q8ONLgjpJ2xzW6i8RuUMxdPL6WT+ddoDUD8iLPhlkOWuLC8G6
         3OlbS2NyVzURFf1vQF0+VywN7I+U/dNOKqjdOqTTRb9v5ZXvWFTK/nxqiibb+lzARh8u
         uTcDd7KxcCNMmN1gu0G+KfV5FLw1lOGwviQ+EKqh74dYIR+lYElupjBWoaNLEIIAoeUV
         J1S8islCzze8LZZzLYhNj3M8Lf4CTU7Lwh7zxmopaQddJpEiKP1jmjTL1tPOwezPVUK+
         ChsBX0PcUsy1Eb5TQ7l8AdxzFJ2yDjkO9aRNNIIRu36vi56atlSHdzu8uREdOabMtcJ1
         uTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790641234; x=1791246034;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ve4zzzXKEVOYiC04gBko3TUlMyxYcTGnHNIKti8S/Sw=;
        b=C4wExXpfpYOmlZzfBv3VNFYU7il3thM4U1uFRrqxb4GaJ291JRxxjayXDTzVHYASkU
         aI1p2wos7jfI7U6QYLAm4g6HvQeCobwTkDkc/bm2wSOvAhs94ce++yV8HLRUj9q8CZ8R
         OHBZEjAKhV2Fgq63czCGixi/vZPTpLEmSgH9+X2ffhNXJ4DKLYQLJ8ms8/CEL7/YSzd0
         r3redYbFFdRvT1omCF2oz7Rkv0ggPZWLWeuUpUIAsZud2n27I0NZBQtfX9OgKgCufXYD
         c1HyA+jw/J7gmvS+kvRnghaYanxsob48Ywng32HDvDoWDs5sFTJ4gQIbWUvAWOQh0TlT
         BZUg==
X-Gm-Message-State: AFq9FYLDh8m0gc6UpG5rob0waA5dJ+R7A64q1rf30/jW0L729EtjyH/r
	aZKiF9iMUst882mGU3Uo3xoIHrXQOhHc+lz4t2Z5A39dDxwupXz0IT0sIF3ZVzLwJaCKB9j27d+
	8raZk
X-Gm-Gg: AYBFou1Wru5QZ5qHpD7LxCb+dF8Yo81zBRIBsJWFQU/CFVP1C3eBTuwAgeeY5+66n6G
	OFvTzehdAk3HhaFgG5+zsSyQMplIoTefyLnFMtyhJSHqgux6ruifiugXlY2NwoFXTIGGRBUKezD
	naVbKKp7Xy+9vIVknrcFkT67ybaKH1CjjjcfXw6+60ZJmHLtTRbc8k9rETHUJtXl3BIhxX18gio
	9mfJVIg3axC6XT3puINezHgA57dF7lCaEu9D3snJa7aSEsGLCM9uBxMlUG8iVwHPh2mfD/4SiCS
	0PiJgDzvjo0Mn+ZtvTe5p8iyq81iq1Yd/Z1TVYGE+p7e7vW/XhMuuEFxTWK0+6KxxFYNZA5sAio
	eUc/QOs9hkG7C8JpfYNzdg7CCkEpG0jRCPeVAOpHSRz4x+Aad0AQq5MbIo+PM3sYPcrsWBGLA8u
	UJ4hYXZkodXYKaRVW6VY1IlATvCSUyCfUCcE7HLZLWz75Bqd1o7x5CxI2gVkVaiRla50jXJPrs1
	wpyKGz4dp6aXA==
X-Received: by 2002:a17:90b:1e42:b0:3a4:948d:9dc3 with SMTP id 98e67ed59e1d1-3a4948da310mr1345895a91.21.1790641234231;
        Mon, 28 Sep 2026 17:20:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858555csm1915743a91.5.2026.09.28.17.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:20:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:20:31 -0700
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net v4 4/4] bnxt_en: refuse to open a device with stopped
 DMA
Message-ID: <arsETwwN4YfcfcTz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>, edumazet@google.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
References: <20260925174404.2789072-1-joe@dama.to>
 <20260925174404.2789072-5-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925174404.2789072-5-joe@dama.to>

On Fri, Sep 25, 2026 at 10:44:01AM -0700, Joe Damato wrote:
> Add BNXT_STATE_DMA_STOPPED and set it in bnxt_stop_dma() to signal that
> the device had DMA disabled. When opening the device later, check this
> bit and exit with an error.
> 
> This is a very rare case, but when it happens the device needs manual
> intervention by the user to become usable again.
> 
> Fixes: 74608fc98d28 ("bnxt_en: Ring free response from close path should use completion ring")
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++++++++---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)
 
[...]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index c673b2ce4a0d..061f57824c7a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2470,6 +2470,7 @@ struct bnxt {
>  #define BNXT_STATE_DRV_REGISTERED	7
>  #define BNXT_STATE_PCI_CHANNEL_IO_FROZEN	8
>  #define BNXT_STATE_NAPI_DISABLED	9
> +#define BNXT_STATE_DMA_STOPPED		10
>  #define BNXT_STATE_FW_ACTIVATE		11

FWIW: while applying this series to an older kernel to test it on some prod
hardware, I noted that this bit was previously taken.

If this is re-submit as a real series and not an RFC, I suppose I'll tweak
this to take a different bit to make backporting easier.
