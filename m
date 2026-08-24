Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88955373BF2
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565854; cv=none; b=MbtdICT8YA+ICN9CMLGbBvZObcTTFF4vgoM4JTFZinjcSWUiMAr/Mh8hGNcf6QGCpjHYDbSW0uRV05oU7ErE5XTX77kfNByFNk6We1ow0ErfNnf3wxqlk6baQsnnzYit/9s7cx06iGh3Giatj2pqjna45aOiY86NAr2hUKS4NzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565854; c=relaxed/simple;
	bh=HPvbVjJRAUx2zxnx/2JXbCymsHLLVjGfbuId3zasyvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz/kiL6GsoQ4yckUwQ3WX4quG8hzcvn2t5AiCLzorJXMStuDEcig/XHmL/vJUZ+ANLPPCuP6nSwzREKngkyvBwDRse6WZ9d1R93MPi+H9Opv1eCf6U+YeNYj0JzQEDKmlbCwPnGg/JQlc8unzQ4dIn8gT3fTbo1HmmJqEDrlLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=cLKedQEF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="cLKedQEF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d049069377so27273745ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787565849; x=1788170649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbN3euIVQaKZlKlCehEGCne8jRWCUQcC3Nf98ImKjAk=;
        b=cLKedQEFUprgt3TDw8sP6+l5Y1GH6IDMa/x4Smy0a2Ca7aU2NrPUJoQzzFVVktnAf/
         rW+Gtwt4iqjkJUDitQtjXJ8LusKAFn9oUGmbXjqZs5yoQooASTevMOpSJZqaim5XrxqW
         YklVGXKOKLk4SOsW5Kntzs0ADoW9yBykqmOrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787565849; x=1788170649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbN3euIVQaKZlKlCehEGCne8jRWCUQcC3Nf98ImKjAk=;
        b=EozIuzKKTRAxn7uREjO3H7ibhI+x67YftzLmbJz9x6abu1NIiDupojtITyb9gR5dob
         aY0vUsiQuxCoSJE4FonCfs7Ic/A9BgZhUGIkumPsWrcyLow1qe6n5AHITkTVD9PtBA20
         1Pgo5+y4ocwKH46eGX1giL/q33mR2sAcqxcskujwFlfTwWlz/0JUld/La4f65tSZq90X
         Bqi8mjJxGtfHHfOevS9KCyil2J/XJYEddiVJXmqNhMRZT39qqgaSuWP338PyYpkvfHGV
         LXeykmfhK0fjEJlW185znA0MzgmrF7krNHr23YStcWRVlavDo1yR07VKyAEmfjpvxNaG
         n6Zw==
X-Forwarded-Encrypted: i=1; AHgh+RrEQcyuVGoQCi7nFO4MHfgs3JaI/YKmg0z+DYmxowPrkpXXXWW49iVEFrpRc0nKKi1demo2MD8=@vger.kernel.org
X-Gm-Message-State: AFuF++k7ICd6ZWSHbs1qguaT9JJuT2R/Vvi3tt5+9ERRR6N5Qz0/TLtv
	Xn8LcBJm5WryU7S8j5/fvHD7h8x6uZzxoKM4rBtiMqgCZp0X/U4cGs/PKIYOMponAQU=
X-Gm-Gg: AR+sD12gZjt1uukyWmqv87gsILwk8eFeczTTPcbYCpLI0oyQBVz+XNy1h62u3f2ScET
	NXFHdDuYNq02xoK0PWKSrYtx+hpklfVBRU/JeOX5BRNFIRx771vNhlwmGVA0FQfs/rpAYNTc+RD
	AkE2ezR2Wu9eRLC6Os8egMmdwBNp2nP9HmmyVCvCGwCRtXqjCedVW3LsQa624Yl9sHNbqvFwat0
	LJMOPvg69Q6esxEnSkOG5rODb25c7gCIP1YAOf9wAGVozM/5B8YWtPcLLdTT9xc1yMLQk5o9hLh
	E7JpNAd4tUNw76Zbj5ZagKSqS4v/0QjP3PqzQlmiAyA4Dm4q7nQAXGJo3rLctNLK4SRXH0zBPd8
	FHM0m9a+FWM5IWVsQqWtW2lz1naEksFl2T4McIOELWjX8eMYyR8/cSmcaaTyLydY5lzCJvGQwgU
	b2yOgIP+9bhmDQezGN+L7PyUaHNOwlKeNDj3seGMPWCHXesdGleFdetwOKImgeXXjOIixKeGHqs
	Qza2h+DcvS080ezEILY5dSRPBOSmjLuA/wp1pZz3xQk
X-Received: by 2002:a17:902:ebc2:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d64adea473mr478553465ad.5.1787565848918;
        Mon, 24 Aug 2026 03:04:08 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d67689639bsm15324615ad.54.2026.08.24.03.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:04:08 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: edumazet@google.com,
	jiayuan.chen@linux.dev,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: Re: [BUG] KASAN: slab-use-after-free Write in sk_skb_reason_drop
Date: Mon, 24 Aug 2026 19:04:01 +0900
Message-ID: <20260824100401.272056-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
References: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We have found that the bug still exists in v7.2.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fed9dfdfc..1af529b04 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -289,8 +289,11 @@ static void tun_napi_disable(struct tun_file *tfile)
> 
>  static void tun_napi_del(struct tun_file *tfile)
>  {
> -       if (tfile->napi_enabled)
> +       if (tfile->napi_enabled) {
> +               mutex_lock(&tfile->napi_mutex);
>                 netif_napi_del(&tfile->napi);
> +               mutex_unlock(&tfile->napi_mutex);
> +       }
>  }
> 
>  static bool tun_napi_frags_enabled(const struct tun_file *tfile)

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fed9dfdfc..147c80c90 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -289,8 +289,12 @@ static void tun_napi_disable(struct tun_file *tfile)
> 
>  static void tun_napi_del(struct tun_file *tfile)
>  {
> -       if (tfile->napi_enabled)
> -               netif_napi_del(&tfile->napi);
> +       if (!tfile->napi_enabled)
> +               return;
> +
> +       mutex_lock(&tfile->napi_mutex);
> +       netif_napi_del(&tfile->napi);
> +       mutex_unlock(&tfile->napi_mutex);
>  }
> 
>  static bool tun_napi_frags_enabled(const struct tun_file *tfile)
> @@ -1783,6 +1787,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> 
>                 if (frags) {
>                         mutex_lock(&tfile->napi_mutex);
> +                       if (unlikely(tfile->detached ||
> +                                    rcu_access_pointer(tfile->tun) != tun)) {
> +                               err = -EBUSY;
> +                               mutex_unlock(&tfile->napi_mutex);
> +                               goto out;
> +                       }
>                         skb = tun_napi_alloc_frags(tfile, copylen, from);
>                         /* tun_napi_alloc_frags() enforces a layout for the skb.
>                          * If zerocopy is enabled, then this layout will be
> @@ -1981,6 +1991,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                 mutex_unlock(&tfile->napi_mutex);
>         }
> 
> +out:
>         return err ?: total_len;
>  }

We have tested the both proposed patches, from Eric and Jiayuan,
and our reproducer did not trigger any issue.

It seems that Eric's patch is sufficient to address the reported use-after-free.
However, we are not sure whether the additional state check proposed by
Jiayuan is also necessary.

Thanks!

Best Regards,
Eulgyu Kim
