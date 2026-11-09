Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237447;
	b=wV8PxAMXniuyOP1qIXrHtopblq0lYthnLiVwPPLyc2zOVw934U90n9rJ8g6Nnhfr+tmd
	 n/D/fhTfhIFWwFCMhDeXoRxC2CyrC1ngSF+OEbWWHm7HmMKG0azF/Uf3CF6bHsY9AU2iB
	 jae/VUiE4CC+SR4e7DsO5o4GKK8dHVii4CRDcTE0c6cCQZ+QMuDDcfhuf9lmCBO/t6PPf
	 Ey0OcXO2trqpLMZNh3KaUrfanqy8+SZDUexpOuFDtJiyhP1t3CiMl8zHvtgTg0BnC6w/b
	 dlOBgtjxSdH/joXzstAJkrtut3oglB1E+rD2ZUaa7hfBZ8wI3LhfyPUBhra+gn4j1vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xdh9DR4pvP3bPWHM/PE++xfHsGb4NZkwyA7cH/UYfZM=;
	b=YJU9TMv9/kDgWjJhW/ouU0mfcmy7C5ScFIJoQeyI/RPszhtIJUx5bxa8HfnQPNTgI968
	 i90aAThfBjkCI8JwLhOGy4Eznxj4OYn8bdu2tUMavgCIWQKmqjG75Jys24PdcWu93EaH+
	 gxO4qRt9mjiZlN8BX8nayN+zlkSDat3ipoFeVu/ZBGPhi0X/iD2VSyikjkWDLFsw17im5
	 7JGrgagv7p7Yv2kJY2L2dTY0V5/2P61K5IAeYChy033jwqlZYdixhsV/zJTJ7z2HJtAxI
	 XjUiqZgJ9Fes4kdtYB6M2CdD5t2ITNGldVBxehcksoKeeH6WMwcx3h4cpDWUbxfhzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nnkIAT9j;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6F606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 15:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC6F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nnkIAT9j
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1aefd1bf74aso837705c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1794237445; x=1794842245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xdh9DR4pvP3bPWHM/PE++xfHsGb4NZkwyA7cH/UYfZM=;
        b=nnkIAT9j6W5kjL2AukY6s9LACsUL/7/5/3oeWkfyGSy9CDbNWy7IJd/+qGnPI/Rvrs
         h8vprcezd8yI62kK0DZeROYl07EOnZQ7yPXw0f+CA9vbvyNqAqKFVhAgS59o2nVboAkK
         u/5VSHDv0mrWUEOv5AH8tFKnEmbw295JSMmHYA5dPR4YZJ7VDcfaMOOoZDQuvePTlnXo
         ra3a83LDvmY3qZT2nsnq7zgEm2qGS8ucdse3VXhSCb2kK//HknKd8m8gUmXB/VqYWGIF
         qk4xqOfqBOrhKKShpRCDXqVJJ1aTtYCR3FBuSuceszHHeKLBdgIKr8c0rb/PjzxS/YOc
         nrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237445; x=1794842245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xdh9DR4pvP3bPWHM/PE++xfHsGb4NZkwyA7cH/UYfZM=;
        b=1pjro736RWNz0FSYZ+X5DfHyVv/VVaTtrPvlfKkVZ31yMzwV47onl9tl9Rq+NcUhqt
         zAWDsErwHpxRAMfhi87frTPvl7YcW+BO2sQECftc30lnpz0M4zS6HeBphyWgPcrOS6TU
         B6w8KgXHKbkvzsDbieDbhP9xqqZ3mbS0tfDCau9N7fENdERz9aG37U4cwlXWVBykF6oz
         eZibt6GxtekTtFpNT+DNX3kX9hPSz4TsCI5N6td/TpEF0gMjA9iqFksReGyeTpGyCJoB
         7CH2XXIprCQH/Rbp3sc/EDtJviDtOcCt8PYXRaOxqk+h4qOiIPKZg+jaufR9tHjbLRmk
         UShQ==
X-Gm-Message-State: APuU4Z/n5Vu2/4rlXLXCQvXeO5u/dnXF1IugHNp+U5pBbGcn9X8MVSnD
	DdMYWO50dF9o8T8iBkEysJMPRVEfLx2+qgaujkaWup4BGQX8iO924AUyu32HFUTNP4iFeInT7Ud
	qJyoDwkNxNXO+rRNGu46o2YgOYoSaeIKrI+7KhYAT1BrGvuz2qULDTG4hHAVSU18Lr2T0xrWL
X-Gm-Gg: AYBFou1a8+6MfGFD2gFpqo+IC7MhrblGNogqx5oq7a1b/iPGnbzJPwq/STeay8MVw5q
	jqABUYdNz5OIVssgclFG822B8EUftaDS/o+mNFwzBDHjkdVvHgx8Tef2hI9bADK8YC45mdegGoQ
	vdjSNpgSjg+DtCD+hsNAoZyviiUP+vWlIiVSGWVX2vEtjBaoVIGcdDFTCCjIgU4DyTWeFB/5ECF
	Lvz6Ux3swqmiXQk629WOSh+6jtkXrtcniJK/7QoV6nb3m4zNpyOeJ6llPkqMXK2pCnsKNwK6Su7
	2RPP1bAyuY8OGXWQNT/+72JQTNyesSdBGduNyYmhsWjB++qjQufqm5fHpc8F+3RfBp4dIxvipWK
	UxhsbV1b/dEzhVYM1z4h57UPOp7WwFNYPsZP6ZynWQdHhJ0IwyrxQAhcp5U19WngzTxxjQf+cd0
	R7mtOrx3rBzHcaWNJMJ3ZECj+GZ94gwAx+RXuoUXNV8l4dBQ8EgKNW//8KWR5v1qDqSXcnUygKf
	9tZjLciQQULoMKtX/ypGDI14ntS4sSIaUEvCYvPThoCDPG5q29Yi1S+Wl847cm2BaQ/6IHSRS6G
	pjEfbh4Sh7rmPhL3p3fB09OoGMU8QNgKi11QLUVczg==
X-Received: by 2002:a05:701b:458e:20b0:1b2:42db:8a5d with SMTP id a92af1059eb24-1b39fe2fcd9mr6125970c88.3.1794237444186;
        Mon, 09 Nov 2026 07:17:24 -0800 (PST)
Received: from localhost.localdomain ([174.136.204.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm15203046c88.2.2026.11.09.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:17:23 -0800 (PST)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Yingjie Wang <x-professor@outlook.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuniyu@google.com" <kuniyu@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: preserve rps_default_mask on failed writes
Date: Mon,  9 Nov 2026 23:17:00 +0800
Message-ID: <20261109151700.3979272-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a235de028cc4160692127c6bf44ac567185b5449.1794143938.git.x-professor@outlook.com>
References: <a235de028cc4160692127c6bf44ac567185b5449.1794143938.git.x-professor@outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 08 Nov 2026 13:19:12 +0000 Yingjie Wang wrote:
Two nits, if you happen to respin:

> @@ -105,34 +105,36 @@ static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
>  				   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct net *net = (struct net *)table->data;
> +	struct cpumask *new_mask = NULL;
>  	struct cpumask *mask;
>  	int err = 0;
>  
> -	mutex_lock(&rps_default_mask_mutex);
> -	mask = net->core.rps_default_mask;
>  	if (write) {
> -		if (!mask) {
> -			mask = kzalloc(cpumask_size(), GFP_KERNEL);
> -			net->core.rps_default_mask = mask;
> -		}
> -		err = -ENOMEM;
> -		if (!mask)
> -			goto done;
> +		new_mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +		if (!new_mask)
> +			return -ENOMEM;
>  
> -		err = cpumask_parse(buffer, mask);
> +		err = cpumask_parse(buffer, new_mask);
>  		if (err)
> -			goto done;
> +			goto out;
>  
> -		err = rps_cpumask_housekeeping(mask);
> +		err = rps_cpumask_housekeeping(new_mask);
>  		if (err)
> -			goto done;
> +			goto out;
> +	}
> +
> +	mutex_lock(&rps_default_mask_mutex);
> +	mask = net->core.rps_default_mask;

nit: use net->core.rps_default_mask directly in the read path and drop
the variable; there are no other users.

> @@ -105,34 +105,36 @@ static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
>  				   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct net *net = (struct net *)table->data;
> +	struct cpumask *new_mask = NULL;
>  	struct cpumask *mask;
>  	int err = 0;
>  
> -	mutex_lock(&rps_default_mask_mutex);
> -	mask = net->core.rps_default_mask;
>  	if (write) {
> -		if (!mask) {
> -			mask = kzalloc(cpumask_size(), GFP_KERNEL);
> -			net->core.rps_default_mask = mask;
> -		}
> -		err = -ENOMEM;
> -		if (!mask)
> -			goto done;
> +		new_mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +		if (!new_mask)
> +			return -ENOMEM;
>  
> -		err = cpumask_parse(buffer, mask);
> +		err = cpumask_parse(buffer, new_mask);
>  		if (err)
> -			goto done;
> +			goto out;
>  
> -		err = rps_cpumask_housekeeping(mask);
> +		err = rps_cpumask_housekeeping(new_mask);
>  		if (err)
> -			goto done;
> +			goto out;
> +	}
> +
> +	mutex_lock(&rps_default_mask_mutex);
> +	mask = net->core.rps_default_mask;
> +	if (write) {
> +		swap(net->core.rps_default_mask, new_mask);
>  	} else {
>  		err = dump_cpumask(buffer, lenp, ppos,
>  				   mask ?: cpu_none_mask);
>  	}
>  
> -done:
>  	mutex_unlock(&rps_default_mask_mutex);

nit: move this up to the closing brace and add a blank line before out:, so
the unlock is visibly paired with the lock.

Thanks
