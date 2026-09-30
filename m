Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B63264EA
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736192; cv=none; b=sNSZX6zdhOeXNqBENLKFignhFOKfEAvRm/GVGDsloiMz+Egz7cevKVAzDVOTbJoMK51zCy5kgTglw6oVilY9Vy2yTdAFWgBM6X/nExPbRkRY3/7uZs7TiGfxX0dOZalImg6bj8iuZgp9nEfID1FwdCJLCxEiCIgghlSjRxAPnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736192; c=relaxed/simple;
	bh=3GrxvB+2Da1BW6NdVv742j9kOFhkBxYY2NYsITumiK0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EsvpCckFhnaOW7FiIYJ9dkvaeCS6JLeZz2Zjvg/5MRWDfFx88JYgnXxwuKTYcnlsAtkj+DSV9C5hdVE84kYeIfLMX57kMLpJNhXXydqOFse9pw6EhQPhb9QG0926erYePd719cMnhlOGdDAHjft2aeqYYN657InQnkxo6qtNB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTvVdwqD; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTvVdwqD"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso5343474d50.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790736190; x=1791340990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CpXFwb4rKFini1iYGyGt9MYlm+r+Zxvo7U9L14tAwLw=;
        b=VTvVdwqDNQTsLSeAmWz2DKVk5b3vVbDwQigIpIWxiqc7nkanmgLC7syIvpVghEMlgv
         QCfS81/+b91YOzSEcwPjn+QCsCvcQj23baIFQVKLbdIKQnNCcDTJGkoTZb/YdlplYUnm
         T8dQ0xaQFkzU8SqRaBPvkrvlKl2wgp8ANs3w7BbIJnSoKOOd6ddTEilqUvlVSBYqpjQp
         zh3wC8IbIZyYmj3KpYqIBl7dRa/lfkcBXris8obz2aGAAvhtdnKUdJOiiicfiX1NrFsb
         uatApSmF4Y184BFbqqOgXXmgWYiQu7sTrvTlfxyMxtpoV4nt1UvofxZRqi7oFq9Pf+rj
         H5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736190; x=1791340990;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpXFwb4rKFini1iYGyGt9MYlm+r+Zxvo7U9L14tAwLw=;
        b=UQTcPkJfMNdL4Z9wGjnTV87PM/2OwPvkLkIgq8jZFQCZDjsPbcdxuew/W5yhK0G24N
         /oh8igsEEwCMH/ns3fQPUC2+U7XD9N6FHF/sBurPprUT9TY2GnExunJdl3ikp1u9zqvG
         TmnpKNSFfppd2rIyDhqh1iVxnUEqOb/f5dTHB4e5p5SjYHq5CADdXNItZcIk4acqiOXS
         QPq5vI1NUqsCfd94q3y9lypYKOAyefCUN881HSRdk0i4Gwytv3W2O0QB3ULEvPfJEvlV
         Sg3MGjvjepOUzz8qQW9Rf+2G/Q43LPckGqIayFGT9zzhbORLihITqu3EEvdN5awvnB+Q
         JOxg==
X-Forwarded-Encrypted: i=1; AKwUvByG4TzUGJw0T4pHsRF3fCmFgNzybT/lQYwxeKUgMO3Il0Mehw9Qgki9Saln4txPP7Izbpuhob8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMvkQu2fnsqpvGpuxB05NpOSDL37IoEvqcQJ/35C6Q07BF6BIB
	cTphedr5vEIuVBm9yo59etklpCyYChtc8N0Kv5W9aNZTKyHZ4UITj3g+
X-Gm-Gg: AYBFou3Xx3Vd66rCY4sWECMQaDwqF+kr2phr9jOjQ1IJPZ5auxkqez53/h4vA0TuSjd
	CSJ6Y4P/VSBQbUaqbHXq5qHtRrWxW2NAxpaSyRTbyLEzk3nQT+WzHW6G5RwayEegZQnMEw9VyO7
	sCJyXjgdHEk1BXFb/v05oQuXyE+c2knbR9FGaDCHfEc/k4vg75ICvBDPEaC1WemVMUM97TeUsgo
	c+n58rfnd0qb/W+vl1ZSg52GPXZzb3LKX9dFtJm/SmTihZlCz1rdm5plJcUbPM92BjyeS5os6vO
	M558NENHMlkZ1CUxDjJzNmPP1Z0NwaWfkAtl29nVtFLsPxQLg+/NaCqyX8xNF6Vg2p2OyWwNUYV
	RWz4w7d8xY2rVUePLm3K7eBkmT1CWefj1Watu8mSo0HvbH6xeoG4XBDF9W0CfdKy9DGM53NVxP4
	J34u5ekyTQB+0qwMHD9Z1Qy3xt21jp8zpgx2/VhpYPI0QmxQqeH/9MszjnfhRUlibmBVf7ESJHh
	d3kOt0KdLcWxNAHjBgthS7gZgw8F5HCmI749WOQdKFY0J+oSf+P
X-Received: by 2002:a05:690e:d53:b0:676:8313:bbce with SMTP id 956f58d0204a3-676834d6d01mr39130d50.122.1790736189062;
        Tue, 29 Sep 2026 19:43:09 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ac53d9ece3sm1365467b3.34.2026.09.29.19.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 19:43:08 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:43:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.2d6146d195b1a@gmail.com>
In-Reply-To: <20260929093712.131096-3-clementwei90@163.com>
References: <20260929093712.131096-1-clementwei90@163.com>
 <20260929093712.131096-3-clementwei90@163.com>
Subject: Re: [PATCH v2 2/4] net: filter: add sk_attach_filter_kern() function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> sk_attach_filter() copies the program from user space and sk_attach_bpf()
> takes it from a user file descriptor, so a program that the kernel keeps in
> memory cannot be installed again later.
> 
> sk_attach_filter_kern() builds the program from a sock_fprog_kern, so no
> user buffer is read, and attaches it like sk_attach_filter(). The caller
> must hold the socket lock. Failing the attach releases it; so does the
> socket when the filter is replaced, detached or the socket goes away.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

This should probably be squashed into the next commit, that first uses it.

> ---
>  include/linux/filter.h |  1 +
>  net/core/filter.c      | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 39decde7fc73..0de5a738fb26 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1218,6 +1218,7 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
>  void bpf_prog_destroy(struct bpf_prog *fp);
>  
>  int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk);
>  int sk_attach_bpf(u32 ufd, struct sock *sk);
>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
>  int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2..64d6505a4ef2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1567,6 +1567,28 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>  }
>  EXPORT_SYMBOL_GPL(sk_attach_filter);
>  
> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
> +{
> +	struct bpf_prog *prog;
> +	int err;
> +
> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
> +		return -EPERM;
> +
> +	err = bpf_prog_create(&prog, fprog);
> +	if (err)
> +		return err;
> +
> +	err = __sk_attach_prog(prog, sk);
> +	if (err < 0) {
> +		__bpf_prog_release(prog);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sk_attach_filter_kern);
> +
>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>  {
>  	struct bpf_prog *prog = __get_filter(fprog, sk);
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 


