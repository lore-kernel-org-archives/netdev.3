Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA53FFAC5
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493564; cv=none; b=SLeFIfdxPUXC9GNTPLylqYWOXxPVSTysug80PkLsox4dYRdFIEGEXyqZlAt4he+phrYyFGWYw9ChCi9ZOTvEWOd03a/NVyiUHrQaIjncozhZRrtOvWN+ZDYCwW32o/HS3uFwoqSE9RCXE5awNAO/ivaWadpbrKOIonu9VFkt4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493564; c=relaxed/simple;
	bh=GQKFAfjK37kURb8eXgj/bP3eu1MfUrZ2X80i3UfUWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2y1jZT6v8sta7bvJeMfIjhkk+jNtV9jgPNLgXIKqs88ApRCVEPJuSRe79hQTusrGBcpU4nvHTKVAoR8g38kygzgOL0VuevjfqMIQrWr7DCp2n+477jv/sPw0CeHOCI2EZykM3qa6uSIa47C596tsQI3MwXSwPtvxdM3vZD6hRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfGGy3dD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfGGy3dD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so13851595e9.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782493559; x=1783098359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
        b=PfGGy3dDJntvUAhwdN74MoQyZ7Kb76WVRvfiYiz1r1uk3V/wjmc0ccylG8JVhL0+aO
         9WSY+r+SENhfxJL8CUeOB1pmR59D9qbmsIm0QL0geqEQ3IJNFp5Fq7qrY/5fyGWdsqG0
         nIyYMLaVYge3kigQjmdxvMGDVbUqMNI+4R/I6uQ1sMOrczr5lwCRWg+mi2S0BVuQYDKL
         dDgqcqfyH8rsZo98a4Dkff0WHyw9Af1jwt2qhjUEWTtw3ws3bdrW5rBD3IoBPhrQQzZE
         8/ce3DSxR7gM6HlnWvwnjDorWuEU3FMzRK5nbfmPEGSUPopV0SrDeRoc0yqUq7qQ+8gO
         PhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493559; x=1783098359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
        b=oLgDjAzuZZ87EwztE2gwSX8Qfb9GFqHtwLgv4RoP3ZFGNVq/1cz6SacXQXGXiZ2aF3
         woL/UjXxlm+s82WkoABGoPOIaOylGsGOndHejBrGkzoRx0xWr96gAnr/NsbKTM5Nv4Ga
         6/x469jfHI3dpnNwYTfbTeitdCzWkkVd372HHh7v7uEkzsUQywiIn4vVI+TonB2w5EWb
         qarGaokNVzU9/XaOK2qgEboSOiMLg1Nqwjed04PpSgHUdxcEobtKzoMm8lJcFDpFEsH7
         8dsQttNKu/J3wG2s5PpavQQOa2fHEPa9EukFjb8v5sTV9ZkHl9xpZjq8a34qkXJ4OVY9
         A93Q==
X-Forwarded-Encrypted: i=1; AFNElJ9xusQ/Hn9DcUTsWQEvbCbsJwraOWVnKRX6mhxd7o1nDgmXOO3Ff/L+nGs5V6s0B4tBvH1bNqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlaxpdk/eN/Kc8Cey1l5YGOVbfQ/PfIQyjn9dmHRQUxz7CDbky
	QOJnBl1L/Xf8MHnnPlUSTTW9fMIaDWXUfZDoBGJrU1SD1eCM6aP1Ocuu
X-Gm-Gg: AfdE7ckflVSxfcnG8oJTrL4Ljmu/M8AYzVJDA2byvGHThY0OkwtTzeBnC1YyAJ5c0hy
	8emqocuFsHJI5fdgKbaC+3jaV9fzXrgXRVdb2MbdLCgZrHauETAzUTugYanWMBhzlixewKgPmYm
	UdwLKqo7CnhJUVccSD4FYy7cqbLCHlPaDJKOUJ5xOs9iuX5zeUW5A6lmy36kkJgTGg7ZMhhmIYl
	XUbgsgM9LW1ztFT9R3B5+/HFp30+30jJ5nNr7NHhCpM9RjrxeMV3BmsVMUC8m6auIIls+CF8ZF1
	ZOHEAQFuweD9XTDbfWWWkyqQMFz7BstKBi2/asNyfuKD6+Ftgl+ehA5hCv1qAD1Ph8H7kJesap3
	oY7P8H8F3ko3wIdN5qhNMJpU4IFmBYBDl9GLonTHBqIMkn6gn7xN3EpR+As3bnD8yP879wTiIUp
	sL5qfs1mX3zvcF+UAH5eNvE48GxHJv2QPc2yHnR6BSjlWLYLb/ks3xR6IQsSVN//+7de8RtaL5s
	naBvRyQ
X-Received: by 2002:a05:600d:864a:20b0:492:5bf9:d149 with SMTP id 5b1f17b1804b1-4925bf9d18amr186215685e9.5.1782493559068;
        Fri, 26 Jun 2026 10:05:59 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fe25429d5sm1694876f8f.7.2026.06.26.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 10:05:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
Date: Fri, 26 Jun 2026 18:05:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sumit,

On 6/26/26 14:34, Sumit Garg wrote:

>  config QCOM_SCM
> +	tristate "Qualcomm PAS SCM interface driver"
> +	select QCOM_PAS
>  	select QCOM_TZMEM
> -	tristate
I think QCOM_SCM is missing a 'select IRQ_DOMAIN'. Right now I get a
build error without it:

drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
  drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
of function ‘irq_create_fwspec_mapping’; did you mean
‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
   2512 |         return irq_create_fwspec_mapping(&fwspec);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
        |                irq_create_of_mapping

- Julian Braha
