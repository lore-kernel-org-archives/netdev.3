Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E63CF209
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350361; cv=none; b=Tvm7qkbNYCxagFHFKe1yoZaieBFFTJxaGNliN+X1pOai53hyZLuh84AcR4g21qOqv3H7ZP8xqG1lctBasReTM2kYFKu0BNtoSGnUkTIuvv5N72ynBp2bMUc+NQXezEslWhrWkz3ZMrN6+5dp0C9ClURn9r7mdkHC0KHFYJOfmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350361; c=relaxed/simple;
	bh=OCVM79OQ0gYHLdaqQv8qta6+bNhKB2aLceUH39dnv34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffLIvuaJq5ytEfQQFsf7KubI+xZtp4jYPfYrJqZqI+8/lJWuJ9RykmF96S3fyAZptqIVsOsUu1IDwwCk+XaHT5LtK0I988pr6W3heARLQHpO56zhXZjagDnCO/eF4qeFJM/tk6oJ3Nm2EYeN8MIAHSUA+iR8ZuoZ0a9RWpuUA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=MJnAVkv3; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="MJnAVkv3"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-821a7bee9b2so1463551a34.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 22:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791350359; x=1791955159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pvmYYDXmzG7/tPrvhQnEVOtEDgOCZa7hCTXN0in/KSA=;
        b=MJnAVkv3rGDGDc49dVr0im6dT1j1btosb3E53khR4ShjFRzmUNBRLp1U6L3mfh5sZ8
         5zGXB9sxLwJu6Bxx8tyi6o1pwqdnbx4DbukvOYImXH3VQttpqYpGaPFjUQWPsNtvzQ9u
         fzAJs6WvnsK4mSfl6IAP9byQLe0ptyYSs19Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791350359; x=1791955159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvmYYDXmzG7/tPrvhQnEVOtEDgOCZa7hCTXN0in/KSA=;
        b=QsnnWfNlyhprNRXjCQVuVfc/EjXBESdkCd/MCe0UFu+dUdlsIzV+8l1M4jVn79WV3W
         9D4X74slh9E2IUHlPbi6jTcHxas2qtb99KjASqB4t85EWDJuKKbkeU6nXS2E5yHifMHx
         tUggcGB6LxgTz8hyP/92l8SNx2tmWMcMDjULC9OElOPEChi7/Q5MQJVB6YtGcSP02rpm
         D005M79LC3zlyxwjjkhIRdvbQud8w0K+kRVGZw5I4Ot/bhPMlBN/ob9gkMDDrDTxTGtS
         du9oQUsqPcsQKafcyLyMdSvQ0kc+0S2hl/29T1dlUySMjHqIRpyJWClCwLCLqyILdS1D
         5GVg==
X-Gm-Message-State: AFuF++n9aUb84WUw518Of9oOmPdhcwXZNkAB72PEsJ5M8SQN6iIogHcj
	7VV2xd18N6O/rlQW3PB5gLmCJLcJwhv/i6x1FuXVndz1dyvqBhrnfKkNdEGOlC8Sx9Y=
X-Gm-Gg: AYBFou3s0t7oK2MWK+YyW58aorwNVjpLSFvqigUJKBTdIyegmG9A+lx+AkEG0bv0gm9
	hlAYXcQyHtpBXwPyweE/UWeqNo/Dbhtc3Svx8Po3I6im0CU7oi7zNsxHMS3dMrPYmgLiYgmawzE
	9r2nIj7FNsq+DnLWar/ZOvNuyMPaWy0Oorz63hUdtDHLv2zvwbjZUhkGbhNopsX5raUYiXz7iGr
	ZTV6reNLKcugUCbnTRpc5re9Nz3kRUK6YV/3OWXfQovo/G6nWaC87kAoKGKVylfnpdlKiCKMLfF
	lmRsm516RKeb8nZSbWZmFrrNorUC3ooLktHtVvt9D6VwriAothjYXS/IsMHG+IkRv7bplS/KUUJ
	9/DOZCWYlyGIqi3MZPnVnvzE7aAuqB3VET802+0Quqc7Hx9Kr+p33Epm7SNgH3Asr+EH3sNMpu7
	jzK01XL3ePxf+haA4xspayRUMKpkZwnDN8vMvORCzDDfom4ZqZBh8+sbJScEnvbF3WOyMSOt32m
	vyBigriwdrzyOoFDR/p0JciJl0DR59scppuzAyxIBpmw31u95PopA==
X-Received: by 2002:a05:6820:16a6:b0:6b5:ec3f:497b with SMTP id 006d021491bc7-6e7a65d5476mr1120525eaf.22.1791350359028;
        Tue, 06 Oct 2026 22:19:19 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e7947969bfsm1375269eaf.13.2026.10.06.22.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:19:18 -0700 (PDT)
Date: Tue, 6 Oct 2026 22:19:15 -0700
From: Kyle Zeng <kylebot@openai.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, outbounddisclosures@openai.com
Subject: Re: [PATCH net] netlink: reset skb headers before unicast and
 multicast filtering
Message-ID: <asXWUz2NAm8bWF6D@com-75606>
References: <20261006224232.50724-1-kylebot@openai.com>
 <179132731939.2231598.7844526000530570814@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179132731939.2231598.7844526000530570814@kernel.org>

On Tue, Oct 06, 2026 at 10:55:19PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I have a PoC for this issue and the symptom is that it can lead to
information leak.

Best,
Kyle
