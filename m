Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70E4FB9D4
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541705; cv=none; b=pSCnkgrPzbo7WgOyBpJ5wT2/8v8STOJoNl0NyyJy5HWCbrAlY60N1Y/vokiftgzfzxEMllaDCfFvRjevW8hi/dQFqxelmlA+33cAbX3Ex02GZ7v49lqDM9pOfeXB4vxwyLQQe23Swh4Y4d5QwpPXRxF2h1yvN7j6tuAldcZO8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541705; c=relaxed/simple;
	bh=u+8hEW8o95gatEdW7w0sDtYr+KU9S8UxpvGfwq8aJE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OV8i6zhgfxvUp7i1WXHxeyHh2B+TK90huaPm0hjWsVvDlguQrP/cthrgErRqwOVJZit0I8zpGyy8dvT6Zd8Dzz2B7Y+ISp2u23DIgf79fEYpOToxD82mfhNYvzWf10zbGj37DVyn4i0LF6S3UDKKBZZF6cVbZguG+WpyNz4WUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMKw53tE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBGDoE7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMKw53tE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBGDoE7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788541702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+8hEW8o95gatEdW7w0sDtYr+KU9S8UxpvGfwq8aJE4=;
	b=QMKw53tEDkv02GuePt3fxmEbvwNfowkqqvxXXfw+4CYE6yXVmeNq2mkBSK0H+agoYva8E3
	W2T8VVf2P3rNKl7N0MwFb7+7hANsT2MId6mXdAWk15ALfA4pHXOYTfAyJZNIbEds7exQPq
	i5TYRubYyDma8rP7swGZu1unL8GH6+0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-7-DIVDicNHikJLV7e6JGhg-1; Fri, 04 Sep 2026 13:08:21 -0400
X-MC-Unique: 7-DIVDicNHikJLV7e6JGhg-1
X-Mimecast-MFC-AGG-ID: 7-DIVDicNHikJLV7e6JGhg_1788541701
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66f8a19cf9cso1413082d50.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788541701; x=1789146501; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u+8hEW8o95gatEdW7w0sDtYr+KU9S8UxpvGfwq8aJE4=;
        b=BBGDoE7vfBY1kMftyQZr+Q/3C+I0c5LsDgA8ccJww0k7AHk4N8PJINKidBQtNGHsIv
         76MiiBbFwsqQIls9D5ZJJ3nehWi4JWWc8BtGhBRMh9nv7uunUwierdtSsgTdpWsq15W5
         OKw5HbooSssbuQ9AuZnDvd5zgm80dWifFCgNoABblf0QtH6H0I67cVlw8AmTiadjSVGn
         xXuSzwwgrd2TC+5etvS+II7kdNnw5FsoGErGFau209jn+NZTnr0gV0RS0Y3MnxKz63oP
         hzqjBOrj3kxqcctBmG95QqDzWg2DoVbSY3Aze0cKpn/r3D9kbGNA7LeHk1Yocr4+AIy6
         XFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541701; x=1789146501;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u+8hEW8o95gatEdW7w0sDtYr+KU9S8UxpvGfwq8aJE4=;
        b=Dar+a577VCmgwTfp6mqv118Es2bcMaQK6D63odCH3tS8cOzjqQWEEDo/acsywxFhIF
         RF1pJ1Ae+vlYhl/bxxt730XkBYgqLyV3T58Y9oAn7oJBIflhknbIRLySH2y1SDnvAN89
         suLviAquBFi6aU2Os91PdypTEP1x0TvxbbmKA70MZDrxBgHiQxHP2wvg5fifI4YJ0Kz+
         kBPdbkNtrgENekgSaW/IVFaab4MZ+7bfE4YliKC1aNnL633C8dRLJcEBlhsjVXoGHtMa
         VHrlYRnpyvSpMtocqJyjfqC37Tkj/nQPmOwKYdvQ0ar4EEQsWrmmPw3XWbCmM0HT0afc
         8+Hw==
X-Gm-Message-State: AFuF++k8oAF/K2hsD6g4neX4hds9etwTagnCKrd/vN8Cf3lCxOQG65ax
	TtOgiBSb1/88U/fPF1T7UGetZFeaZH9TyRJXVarWLp/6zEritSThyOTrmuP1XxxDjxNIoZuG3eO
	oN9Ykk1Cx6S6Q8LInYwWOSUPfrWRNO8ZXXUMdybUfXG0aAat6VDDfBJrcag==
X-Gm-Gg: AYBFou2Z5FS6iO3pMgj6BowlopCBRLOZmc1q4IX0FTUMamPyk8hd6TFFsqW6Dz+BzyX
	6pec4GlsUonZcFAuqhw9DyDgHwBhN5KebqGc68rbwl5LzWbnujjWDvKgsLGRK7TLYpVdRCzJIIR
	FCmlBv9U5glReWRjRuZb5iM7AqwDYsgQSR4dtyjq887VH1biNsKQWf5pGSKxSZbMZJczQOEh2JL
	FAB6G2bjAG6dJAu7rB9zSi/ziuqvx9OH11YrMdKJjbEE6Vz4PRb+KoOMzcRC5l7PiPyRPSrTH3o
	oHxqxz4M/MmXSzQ/M+vUOO63RK1ixeLm4nTYSnJBWMnjB4FuQIj1/bnT0fD8Uu9P4dRVv59NVVJ
	VrBsZ3gYWz592ZUjL8UwI+L0DPth0
X-Received: by 2002:a05:690e:d0f:b0:66f:89d0:fb24 with SMTP id 956f58d0204a3-66fb5a2adedmr2847611d50.30.1788541700464;
        Fri, 04 Sep 2026 10:08:20 -0700 (PDT)
X-Received: by 2002:a05:690e:d0f:b0:66f:89d0:fb24 with SMTP id 956f58d0204a3-66fb5a2adedmr2847575d50.30.1788541699939;
        Fri, 04 Sep 2026 10:08:19 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406b3965sm24616506d6.46.2026.09.04.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:08:19 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  cpp.code.lv@gmail.com
Subject: Re: [PATCH net] openvswitch: fix wrong flag value in
 get_ipv6_ext_hdrs()
In-Reply-To: <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
	(Eelco Chaudron's message of "Thu, 3 Sep 2026 10:18:59 +0200")
References: <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
Date: Fri, 04 Sep 2026 13:08:18 -0400
Message-ID: <f7t5x0lj665.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eelco Chaudron <echaudro@redhat.com> writes:

> The ESP and AH cases in get_ipv6_ext_hdrs() used IPPROTO_FRAGMENT
> instead of OFPIEH12_FRAG when checking for out-of-order extension
> headers, causing the fragment header to not be recognised as a valid
> predecessor.
>
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

