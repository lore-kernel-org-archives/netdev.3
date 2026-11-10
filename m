Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313506;
	b=o9LGQU0sjyTWOp1WX9ap94gA8XOjitiaILgN37oOeccBy8KcxBBYZ5ETF87dWbiA3Mgw
	 SboYhEBBURJ/kUjugy5mtN2/NDSaMUJ+mUZMK6UF6/LS6ruTfexlz3yuMew8LTDbekF57
	 k+XadWGRGicM5A31dzxs2Mg0zDG1xW+CUX7BfrzMC9SRfULbC9HEJ95HE9v08bO3eg0Xr
	 xROTMGJNoA0XkaLa3V69haVgG+KQHlDkWoH1PQMS5+Fzb4miz7sHVi8P8iYIolESbMTI6
	 ACxMlW3jCUtVcoqwUc+EIpS2HjwTmeaB1UfoBFvP0zJgkZO+2kRXRfvTRzDyzSUpCpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313506;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
	b=MYerho9kZq4ePs8rEOgwuSK762JSr7Z7N8e53e4+r5HrlVUx5LGM59L6Op32bQ31Xf4y
	 tIVdW7/0MQgkzZlBcLAOWjOKCGydKNu2gLspwg1dCKGfR7TVWyAFGGmKW0ehOFK1Rteam
	 7KvYw+gST71cPP2/Hm9Ey4REpXy7h9bKJ048Yq9G8kCNRQ/gq6lMVdVJE81saBth7GqD8
	 XNbwxJWPYgJJLNHWbGfHNfOpQxwNJb1zvi/qilC+KVqMznMEYkraHcvK/2KU+TDZHHWBU
	 PkstoSVnRAQW+5naI4Gr6JyP1HMlR366blh9w7eeNlyDlERM2cwgG4GXGG/hIDfjqUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gaZ+IBrY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OZ5PTgUU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32F606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D32F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gaZ+IBrY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OZ5PTgUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794313504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
	b=gaZ+IBrYaGjCsDwNYEB6oSb7EW9VO14HBJyLO59SM4yoyWfheDygnM5cEuoCQInMwVxdkS
	PUMGXLOQ50srcwtPyAJ5MYfAvsN8jVgz/uo8mfFoiLj1uHey8Peb/xNmqYFuWYOJqq1bDA
	p6n3r7IliiJaF5WrWdwgDliDSCiUcGo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-QHhadjcKMyO9cvzGBmcWDA-1; Tue, 10 Nov 2026 07:25:03 -0500
X-MC-Unique: QHhadjcKMyO9cvzGBmcWDA-1
X-Mimecast-MFC-AGG-ID: QHhadjcKMyO9cvzGBmcWDA_1794313502
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a211bff50bso13118175e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794313502; x=1794918302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
        b=OZ5PTgUUrM/bCkP1D/FUAAlfZS3NzHyDd4Ak/fTk1dxj7r9esRupwQbuFptwyWTWTM
         HmFsB3wa+Z9BcACzYh2q8cYDzIuD0MRqF4BQ+XxTFnWonPBhVcwwVvdEUATt2HR9QGsS
         0gV0PYOvwiQmIb4fuEOVZcmRznMScEMw9hEW3zMtGHNkk2U3oeEjJDx4ITiB7k1jMVAs
         rJSz/Bs6qu21SG+XZQk/Giv6yLd3PmIA7iMBexQ++qgOvaIejAy+3a5KOUXoaT52bHQ3
         Ve+liNhvCYZwEGuQaqjHKN1rtzCFjC1pjxGmZcS4Nzv0/tdH3hiAc9kCsphoICbFhF3I
         mWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313502; x=1794918302;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
        b=nNPGq6+2FzOV/LXkT1pTxrjdLXJJluhM1OxPfV0KxWGzJn9onxEBZ+J1XP73utKJgv
         99fwrNEgC+foxzYtdb9gjQD2Ei3wZk3PoHm5DKOxlq/xXo6qeieEbmyThbHfmTaz165s
         bcUd48f9pGCSl/VsYs+IDrSqF+2RA4oCFBzXxdxQUA0EIiVV4j9LcqcFMLdbwiyVSgul
         faifFT37XjXGaw7WQwnsf/FnjSKkc4buFScniUfcpUxO8+AQXZqQO1v993q8k7ngllOE
         hnrs/nljEZYTpBsaPi1Id8wg9/EK3NDvT3I4usj2xDm25hU+wxlWucLRqMCV/GXTQfyY
         e6oA==
X-Forwarded-Encrypted: i=1; AL+hErHeYSf1DFkF9zxh9vts97WCZkQ5FSsNyUINhqcbVj5xmiJzOUxrtMx73p1D4PoctPLZ0bf7eiQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jBU9/+oNZdhHxLK0mB3BQtZHo4Z9lr47lpdynHz0BNkbZ5p2c
	HM8mBReF9iZv3e1FbA+hEaBsnU0DoyAzP4zRbivyqDeMpwBjEobpArGm4UQuKyxXd3YLs/3GcgW
	ByRE4Lkp9I62KS7TrIFJVyk6+nZyFqDeTDhbSYZ9ge2wLG7P9cnqOhQ4SbA==
X-Gm-Gg: AYBFou3NwTUbDOp3PP/Wl3PmWy30bEoWHq5mTsHLiqxf4dF+e6mGORc0GFnG9oiueat
	kaZVNSXRDIAz9O1/7fFfIqzbubgAOsLzycnSGbvdxBwb0xPTqORn8RGqVZA5WCXBLMZevK3ODak
	gxOrHkmLawfvHfI1pI6LgqhMRQosI6TArDPXpJ3RgzXmPPJ1JgmTkdVOvKDF1Rn/9hoSAXq7hU3
	dqPvheeVt9YP/NnOOZzEM4X5YFQtoXwVekwykwRGSCNPsx7pmJ1TMafhd4QNCfQxYlLgEYudIaK
	O0USf2zvSOgJFJa8/ujEhlbBb1sWWcpiotryagu0ltlaLkMT3wo+92i2cLHhiAlcoeVS7yN5RWu
	mJkMwdNwepVQfOCLGUBvKVSiS+qTJLPQ/sI4=
X-Received: by 2002:a05:600d:82d3:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4ba0234ff73mr46627625e9.26.1794313501896;
        Tue, 10 Nov 2026 04:25:01 -0800 (PST)
X-Received: by 2002:a05:600d:82d3:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4ba0234ff73mr46626915e9.26.1794313501466;
        Tue, 10 Nov 2026 04:25:01 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c5b9sm4681271f8f.9.2026.11.10.04.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:24:59 -0800 (PST)
Message-ID: <42c9a0b6-0828-42b6-ba9e-cd49fb9ef4bd@redhat.com>
Date: Tue, 10 Nov 2026 13:24:58 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] dpll: zl3073x: update locking comments
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-9-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-9-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Callbacks are serialized by the DPLL core domain lock instead of dpll_lock.
> All channels of a chip belong to one domain, so what the comments rely on
> still holds.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 1cdadb8e46fb2d..6e5e2bb41f55d6 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -349,9 +349,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   	if (rc)
>   		goto unlock;
>   
> -	/* All code paths accessing per-channel reference priorities are
> -	 * serialized by the subsystem dpll_lock, so it is safe to release
> -	 * our lock here before iterating over the other channels.
> +	/* All callbacks accessing per-channel reference priorities are
> +	 * serialized by the DPLL core domain lock shared by all channels of
> +	 * the chip, so it is safe to release our lock here before iterating
> +	 * over the other channels.
>   	 */
>   	mutex_unlock(&zldpll->lock);
>   
> @@ -2401,7 +2402,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   	mutex_unlock(&zldpll->lock);
>   
>   	/* Send notifications outside the lock to avoid ABBA deadlock
> -	 * with dpll_lock taken by notification functions.
> +	 * with the DPLL core domain lock taken by notification functions.
>   	 */
>   	if (dev_changed)
>   		dpll_device_change_ntf(zldpll->dpll_dev);
Reviewed-by: Petr Oros <poros@redhat.com>

