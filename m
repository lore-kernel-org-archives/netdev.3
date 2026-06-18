Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FE25B0A1
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772377; cv=none; b=gjgXcddLNh62mzQXPMm8MHcvx8J97rAkEWYTV4P38agF4iDauujQlgm3Bz2ffEQ7J4OdHJ6VsaRq4g6NRMAGNM41jbxmRa7ImEACd6QScLqYOQrjUKqjml9C7RIwpeNk6YnfmiIT1/4oGR7g5rXgJNXO39DH/giQVE0LYEZfg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772377; c=relaxed/simple;
	bh=ZkO6pGqCkfZqy3u/oU51uk/j3lT62505mW0fThy9hk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNajTvYoiTd598n8DY2AEE2Hm00tioF0UgOX+O2Eq/QTSHxhvqtuwkBKaP4eMVnCXBkS8mY5bTGrDOc7Xwu2ti+pePgMwvTTpNeEeezAt2Kjl82D6CVs/WhSP2QGsFOOXsmh0n6Fjay6y0zHoI+WYwEJW/gEnpeY6Ikd7b2CkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPQhdo49; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPQhdo49"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so5703125e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781772374; x=1782377174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PGCTCQszIeeChHhQclIvtZO9APdlhqX7ENI5kXXs3o=;
        b=kPQhdo49O+yBje7dRhYtDtHt4mCyMKrFOBAd15Qovc/SviFiJm4TKN+LmQiRyh4JqN
         hyuCSZBO2MEUlMYVnLqBOOYzjuph6m50697h0zjDRx+qgFZB+HEp1jRfKsB+Gz9poVs9
         pzioYQiWuLcIVIHrLu6PqaUu8P3/Vk5ZYlGQOEbPqDFxQdGqV0p/vxClW3OZmZYsDQpW
         HQ49OyS9Eku0Z92Fot9TDvBC6KAy9skjsFuZx8y+eVHpF7krlHoNuc1kLNUyjVde21cc
         qXt5wzsKWTaabaEvJUjIR46xsAMvtyFJPHAjzvdq67c/s1EeqzXiucNBaTqFsrjAxU48
         9niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772374; x=1782377174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PGCTCQszIeeChHhQclIvtZO9APdlhqX7ENI5kXXs3o=;
        b=b31SbfylWJBmODKyav5bm/9dZPNk2X8WSYhM8jegBbCYKf4MpaZWrVmSjQ5csIh3sm
         AfGH4Y7tZLnTd7BEFw0JvhvoyrRr4wA4wgPvZIxKExr0sDv+RD9BDmJ+SfUXxXbkHc4c
         sP6Zgmra77Ki3q9KLzG/KFVwhdz0gUgaANQgFQE5yIsNOq9Ipz8GgL/+Mvfd/SFBnnHi
         6O71OTdnjiByleWdqRHj4IFSE6mMqLlcwSGRC0tNcBMzCGZt7apeCBEJaWzWw9sFzwzq
         pohKtaSMHRu5n51oIO5tJfFk5tF8ipoNvZ/SM8Fq93z9FYfi677X4HwACrg9RLFv9r+R
         Pd7A==
X-Forwarded-Encrypted: i=1; AFNElJ++7feKN753rFCbo+jQXFjxgjYf3oW4dYCXTTr+NrFxPIo4WF5H9na3H/ioM//3MK4zqp8EZeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbMfsJmKiJzeV6R/T3Y+uivgAUYXfRg9EKQGQcoJCR9JwvjR1
	Qhnb/eAaONoid2WEjuXFvzobNYUTyRuP6ahX/MVU0dh5I9LxAePzGC6F
X-Gm-Gg: Acq92OECNUmys3QQ+XV1pl68yLTrNbr0wed1Yov+8uZ2bEay+KE8MEB8EKnXZQMeOgn
	KghFR6mlypFs1BNT2OYJ+0tKraXPPa3KOzOVWHaz3Zx0IJ6BZZegJxo+71vaLIN/s/vUgOVJCDQ
	hEk6vAaekj3n+cl6Zty17LFT7QqIW3Hg3iLPODapO+6HGHhx1gm2juR/PuAWi0JMJEeXiNsiSt4
	oy0rLPXTvasdTKNtYeW8gXrgF7ZZfcgdGxBQ7EOXFgGAApsrxeuJ6WFbiZY4dyBFXkZUaoR7oTt
	Aln6+jnCgZZvbfCzto+HpMBnsBLTQzmFsRiRhJrjiiHoMDt8jgX54ARafRdmlQ6G0pu3I2jhO8d
	+dXGHxkHdsYgTi6Ms1cL232iXnQagNMsnK0QpyRmp4luIyEi3ardAS22LfcN4wjlu25Tg+C4j7O
	sS6WmDaUrPDBg/ufVnGJfxYLuE7KKpqNr0lRpByPBASW/ZELqVYxVv34X8pGjY0RvnBmYNRtZtY
	l8yR+ovvaEJ5jIYds34+Yh6RC1hOBYwdgamm017LbFnbfJE+gp4zyGR7LqgthNYZ13LCm6G8ZVJ
	VPbaZBLr3ISzOKS99UkVXUgvIMV8j9mBa/lK1ksMGDk=
X-Received: by 2002:a05:600c:8189:b0:492:32a0:7f92 with SMTP id 5b1f17b1804b1-492333aabe8mr126392015e9.12.1781772374045;
        Thu, 18 Jun 2026 01:46:14 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006e99796483dfbc0d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6e99:7964:83df:bc0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm255435305e9.12.2026.06.18.01.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:46:13 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:46:11 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix partial copy of non-linear test_run
 output
Message-ID: <ajOwU4ak1qWlAaYu@mail.gmail.com>
References: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
 <20260617093557.63880-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617093557.63880-2-sun.jian.kdev@gmail.com>

On Wed, Jun 17, 2026 at 05:35:56PM +0800, Sun Jian wrote:
> For non-linear test_run output, bpf_test_finish() derives the linear
> data copy length from copy_size - frag_size. This only matches the
> linear data length when copy_size is the full packet size.
> 
> When userspace provides a short data_out buffer, copy_size is clamped to
> that buffer size. If copy_size is smaller than frag_size, the computed
> length becomes negative and bpf_test_finish() returns -ENOSPC before
> copying the packet prefix or updating data_size_out.
> 
> Compute the linear data length from the packet layout instead, and clamp
> the linear copy length to copy_size. This preserves the expected
> partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
> in data_out, and report the full packet length through data_size_out.
> 
> Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2bc04feadfab..f15c613aaa4e 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -453,12 +453,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
>  	}
>  
>  	if (data_out) {
> -		int len = sinfo ? copy_size - frag_size : copy_size;
> -
> -		if (len < 0) {
> -			err = -ENOSPC;
> -			goto out;
> -		}
> +		u32 head_len = size - frag_size;
> +		u32 len = min(copy_size, head_len);
>  
>  		if (copy_to_user(data_out, data, len))
>  			goto out;

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

