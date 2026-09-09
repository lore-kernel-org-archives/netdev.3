Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728639CCF7
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979251; cv=none; b=sIZ8VWyCg3syI1DLPwXMiK67Kc4mYH1AaMp3YgMt9dv/mAe2DckXmYbltjLM47yqw2N5CngfX0k5KN95KCKE6qLNw+OsUwKD5EqOenhBdX4LWU5v6Sh4UdM7pkoautuy3rl1uEz/8YF9jy49kMbmLpXY8RhcGW6XedXhpneq6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979251; c=relaxed/simple;
	bh=DRAwhPSMOzhoJJRRnzoEYIrag3gaYJMbJRaZnzbbwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4ILHpnTOCs8UpycUOrUKjXh6rsmoX0RwOv4DjyRMXEmTam+rk8YgNv5RfzpHyijvmSX4yRSiGJpSINh8CDKEKNQaWFBtRcItq7muTjzdCRS7H71D9ST80AeODk3RkJruxPvYM/Mt51bkgJcsFcQEAl6iqkzPXxx5HDSR1zxRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkfHKqRF; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkfHKqRF"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ee4399c3abso6086448a34.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788979249; x=1789584049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7UxhbuxqRDbidvsvhsBV/Jg23n9ONgmz8jzAfiURPM=;
        b=EkfHKqRFF/bGYGEuclcigpLXhauYJlwdbj/c2MrvgCeoeFKgRFOAv7jiUf3erJU6Lf
         JGTeDQRQZZr1R17CIyYQoIPORYTxL+6h7X9pNFspBIyBii6Rg9K27EyczrIxgeMUQTB5
         ccXmyROeQFu04NISs0nYQb7q0ip1/+bfLIECxmBfA3n0e9HPaDpcYGQPbntivGdP2lCW
         dEy63KZU5JCsZUCmPYfBRdssh4eV9WpA9jbjURWZAoPZ7CLeUuj2Ymzawh8YBLVGZHBS
         8vmf3SkVmrSZKLUAyc038ImsOwzLzOSSzoi7EEjbIc9Mw8Fe1SaYyqFaDKHx0cI2TpIV
         2jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979249; x=1789584049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7UxhbuxqRDbidvsvhsBV/Jg23n9ONgmz8jzAfiURPM=;
        b=DeNX7fE/IcXx+oEiSuKnqJe8UDpMgxeo0imdG37v7+SWBHthzIpbMBPTObABXVzaNP
         SjHihThMmVGE1B9hao2BH0Kdeo3uNYgTCcb5AjxN/Q8ZZQFWTD45YsAY1YcTcyh56goT
         DXmBzph0DwM92klyG2IzbBHX6YIByapQG3Xo3gVgm68TKMUAO5+ym0Wv3SD67G0Btmu5
         uWbFbGYJ4VZgLpSCTGtUKceBOxR5kUkNXba2SVc5ht0ZmKAO4tZuZlVgcDKE47n6+aPz
         LDw2MuUarGis1ZcSEpObJIFqylr5FUdPp71gbncB77YcCvC1TaCWwddbA5Atwaf/x8zb
         vdow==
X-Forwarded-Encrypted: i=1; AKwUvBxfeSWAZAijkm62TqLtzA0eZwUYsZNMw3v+47f3fRleh+6I0/lTFRdUsR0NggiZ43XZekTSjWs=@vger.kernel.org
X-Gm-Message-State: AFuF++lw62LlFiS4IzpXI7YAvmIA144swQrQlOS0ut3PFpZ6XAuNc9+u
	t5ENgk6cp9rm9u8n499VrnCr3gJ3ZS7zigHp8fFkRwQ5V0AUxnrsq2GX
X-Gm-Gg: AYBFou3/SkDS+FCsnNWdcer7a2UjsPQxhd+RmgvIBjDfLONBB+qmDKpTz5yK6seiOJI
	XUAQ6pScl3Ij1UvQAO4KpfeOGVtR29SjzU51ZDA/Cxajp4LlCZmEQYVZvbFOvC0ON+Pvk0N0TJU
	Zpcm8fSxX1IAufYT9YFCpWD+cKvXW/leX3rwNVuyU3nrfbVTtV54yzqmGqFDC+XjPTtArLUk98Q
	yELhI/if7cFxc358rOGyq2s2PCX5cEGAq/ax8vH4qvIlxzMlG04O+1hRXbttkzdXWVnUiUdTJy3
	pJLoG/fKcPyl/BcCgrsWgnI1m0HF4FBa4hd8k5NrMv7JVFqln2ffLONnMZvIRSY2oYc4vTY5gR5
	1zniK9czxBL2fFG7C/C82ZL0itOxcwo88tXY8kmLPzduX/weov6jDyPXLe/EzrRZyaPqzryl6UJ
	tfM1HEYj9rRiVn4aHj6dfSWN5iwpOEFIRhZm0SoarKOVw8UqzWyHXNmWLQNowC7XfIJN+D3SoyU
	Azlnm6y+xnRMOLxpZYC
X-Received: by 2002:a05:6830:3808:b0:800:8151:52d with SMTP id 46e09a7af769-80081510a4cmr6737373a34.28.1788979248654;
        Wed, 09 Sep 2026 11:40:48 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f72d3d3csm18319790a34.18.2026.09.09.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:40:47 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:40:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, bobbyeshleman@meta.com, sdf@fomichev.me,
	leitao@debian.org, razor@blackwall.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: devmem: set reuseaddr on
 the sender's source port
Message-ID: <aqGoLKIOZAkcajKb@devvm29614.prn0.facebook.com>
References: <20260908183420.1369630-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908183420.1369630-1-kuba@kernel.org>

On Tue, Sep 08, 2026 at 11:34:20AM -0700, Jakub Kicinski wrote:
> devmem.py fails on the HW runners with:
> 
>   CMD[remote]: dd if=/dev/zero bs=512 count=1 2>/dev/null | socat -b 512 \
>     -u - TCP6:[fd00:2::1]:50051,bind=[fd00:2::2]:50051,nodelay
>     STDERR: socat[41018] W bind(5, {AF=10 [fd00:2::2]:50051}, 28): \
>             Address already in use
> 
> ncdevmem installs a 5-tuple flow rule which matches the source port, so
> socat has to bind it explicitly. The port comes from rand_port(), which
> checks availability on the DUT - but we bind on the remote...
> That said the failure rate seems to high to be random collisions
> (~2% per sub-test). It's probably TIME_WAIT sockets on the remote,
> run_rx_hds() alone creates 12 of them.
> 
> Set reuseaddr so a TIME_WAIT socket does not fail the bind. Collisions
> with a live socket are still possible, we'll see if they are frequent
> enough to care.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: bobbyeshleman@meta.com
> CC: sdf@fomichev.me
> CC: leitao@debian.org
> CC: razor@blackwall.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/hw/devmem_lib.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> index 3554954a6691..b6e52fa9dda5 100644
> --- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> @@ -201,7 +201,7 @@ def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False,
>      else:
>          addr = cfg.baddr
>  
> -    suffix = f",bind={cfg.remote_baddr}:{port}"
> +    suffix = f",bind={cfg.remote_baddr}:{port},reuseaddr"
>  
>      buf = ""
>      if buf_size:
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
