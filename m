Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243484;
	b=cFVao60d4iWjzOyw+hV3Q4EPyRjuQRwzCRMdYdgh/PaFb03aUotpwo1DDEupUD+5uEZY
	 eC97cMRf/2utowdmLCyUyEbpZ4xR8/yOpTx3/29iTl70l2V4InitBpscSJsAzmaVkzvYm
	 OJmLnTCrvBY3CVUE/NljfPcJIK0sZiJjMPIUA57r9aMhlT8SlIn1YXotsodJUKEFeJ+kn
	 Gte4D0ayS4HHPeaBCdKW+i3zHpdutaTT8tQXpQGjpYZmje8MXx7icZzBz8unEkQi5peDe
	 3IyJEZGWZUc7VkZsKNW8+lJVDJd//O73NFVIyfsd7sx8RiOcUjZonxt9s6XpYLeWtiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sDis0WLx8KUE2I1kamC2CNbijidM52hUokuP0aR4tyA=;
	b=rtoOePWzds04lsMXFvuJ4O4CZFh6pIgXtJxgNXKoQ48JTcTaR52decy0MRFPHCSk6aAB
	 qmOCefjdFBrHh93QSv0UJe8bufNulmYTyPcswfrxnS2w76Kf/9qGpJN641YsxcbV7WgIP
	 gg0uwvLcEWsRjRn9rSuCZ0fVvQi+LC3FP9LDhYvz/0gv1vjohlAfFqXylqBZJWncpV50G
	 7TR22Tepge8GX//QWimB1UH+2IHUxaW3Lqzfl6ELxgAnZsByDHJtuMVX5DIL6sEIYTbK/
	 SJqIXmiW403/F6Bhg/SDUGickZX0ERpOQG+IH854cDqmlDwdojHdeZJ2TDKqOVE1HPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gTQgqc7f;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0951606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0951606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gTQgqc7f
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14fc585291cso1502134c88.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793243482; x=1793848282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sDis0WLx8KUE2I1kamC2CNbijidM52hUokuP0aR4tyA=;
        b=gTQgqc7fe00z38xS5VGL17ODfWk/PlBu1jih7V9N5ixOOIh4suNWXgN1PLiPkzxYyF
         Tj5/qsjjHD6FC5/PvMl06NBmfZ3VG73HPxA0eyYrakmgTH8JTSdNOXbqzcoVGBvP6OKF
         +Br9NIZBdNisAFJmXMlzO11v6I6/eqTCKXnm0BOPfeU6wx9VVv3ohYiteBGouPAD8p9D
         fF8VfgggBcpIqhP1nxJy6Lu04xwwpAH9jifgcptedlpc6It8WTUWiJ7LZq26bSWtxmxa
         ks3Y2p6zCXc2kGkI363E0lJBSzkEhk8eo0Xau9J6aJIC1GQGSPhi7gTdrFsXhKy2ea8p
         30OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243482; x=1793848282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sDis0WLx8KUE2I1kamC2CNbijidM52hUokuP0aR4tyA=;
        b=KK6UeGmwz/7Qqt7XVihnmWoC/G23Z5YPGQlTrQxYnbN0R3kguWUblnxx50znqmaPA+
         vVisWTBCImT2CtgM8g3rVMctD2RGtu1mnwx8ubSpNFVEQf131v87NzXqdAF0yKfVn6jJ
         VNA8elWm6mNKaCRx9nd+30aDrgDTevGlOxLsqgMc8EcIl2YR+Wb18ufImpwXGVhkI2k4
         RQq8VfgqiZ8CTomyladxhxuik03E72BJ///MnkQXWpGJTUFZNOV8I0L6wtHoMwXnyJi2
         n5DDBDjlGt8TaoGrwgzyWdDWFBUGQQ79jAu86F0MpXGOgKUzrdb/7QE4Fu/lhnvUQBqM
         btGg==
X-Gm-Message-State: AFq9FYKJlioDZfC/7coUqAuXZwuvv/0eOJe66x9JQ6kk259RHGh2tx5I
	NqV4o4XwK7EWLLFW6OATae8fHBZj1MKyrDdvV21gDjt1j0AaO410kAPT11gRC3ng1DuNd8NG59C
	UsgooqrZbLL9DFJcDSNwaf7+Nbl7w1cQHwYYCpjRVzQOmvpMEGJFHTOAXYb0mt8CuYnHI6GRl
X-Gm-Gg: AYBFou1ZuGNZCjMpSnraV6ePpwcl+t5zftRjG7Gs2B7Ycmp0GQguwD5jlAufHZc+pOR
	Ik9UQ6dkj8oPoBGu8AmS6RCYnQVmjFAVwStOlDRhWvTSWYRpl9uQSGVOYYg1iA1619ukUIlAOc7
	YTmkm0P4XtYYUaZTL7A/21IM4ElQ3eIpGpAm0QqsAwFuGgAbHCheFImIT4rioFcH8KwFwqoXx6q
	elhVhqR+OSBZ00NZhvuAL3Z/ESuIB1UJLoSKu+c9hNzxttDPfuJU5D02cBdQW2H18ZjlOUeLeg2
	6jZRlq4wEaZXyn3EmXejLRSUf9O/5NRaTxM1u/y4qysLraI8r+n0BgxBssLXUzbeyiqyYnUeSOu
	SjizSQhJggR97Hw5KAMaU6q/PVlHXHUN5IaYUcLpiS97lxQfkWTectoe0rglhvbENcHvnPqyMrT
	EVbRGffltzXVMDXkaGGf5z4Y4cWOOVkNyQ+BiJ9+YKgEgElOtHcqBZz7VSwNQXSrnl0o92PMZQa
	rpIFLwsImGHfQ83uNYr0aWEHVH/Ht1BrBMHF5Eu9WIExXWUWpBbMywm5qUu47Ky/is9F6lJ9Qbh
	u/3Z+XopEmlrPNuQVSe+lW+Whewwvvh9dhityC9DylZeT/c++tELFIUe9SW8VH9A
X-Received: by 2002:a05:7022:c89:b0:184:329d:eced with SMTP id a92af1059eb24-1a6ce4ea23dmr5028701c88.25.1793243481131;
        Wed, 28 Oct 2026 20:11:21 -0700 (PDT)
Received: from localhost.localdomain ([179.255.112.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f51bdebsm11705549c88.17.2026.10.28.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:11:20 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Yingjie Wang <x-professor@outlook.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: preserve rps_default_mask on failed writes
Date: Thu, 29 Oct 2026 11:10:36 +0800
Message-ID: <20261029031036.1133374-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7fc32d133404c078352f0b8fbcc80a67861bf2c3.1793199118.git.x-professor@outlook.com>
References: <cover.1793199118.git.x-professor@outlook.com> <7fc32d133404c078352f0b8fbcc80a67861bf2c3.1793199118.git.x-professor@outlook.com>
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

On Wed, 28 Oct 2026 14:52:09 +0000 Yingjie Wang wrote:
> @@ -105,27 +105,29 @@ static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
>  				   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct net *net = (struct net *)table->data;
> +	struct cpumask *new_mask = NULL;
>  	struct cpumask *mask;
>  	int err = 0;
> 
> +	if (write) {
> +		new_mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +		if (!new_mask)
> +			return -ENOMEM;
> +	}
> +
>  	mutex_lock(&rps_default_mask_mutex);
>  	mask = net->core.rps_default_mask;
>  	if (write) {
> -		if (!mask) {
> -			mask = kzalloc(cpumask_size(), GFP_KERNEL);
> -			net->core.rps_default_mask = mask;
> -		}
> -		err = -ENOMEM;
> -		if (!mask)
> -			goto done;
> -
> -		err = cpumask_parse(buffer, mask);
> +		err = cpumask_parse(buffer, new_mask);
>  		if (err)
>  			goto done;
> 
> -		err = rps_cpumask_housekeeping(mask);
> +		err = rps_cpumask_housekeeping(new_mask);
> +		if (err)
> +			goto done;

Please consider parsing and validating new_mask before taking
rps_default_mask_mutex. It remains private to this handler until published.
