Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB51F94F
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726129; cv=none; b=FwQP2x1BGF8GWAf7l3NJ+syfVjW43j/PQPRMH+n3kttN5BuuJKp18Bnj7khsCC70kZKz50UGbs36tJzWO867pKQVv6Kz8E4Ikc+dLJ5GERRvPZ08GUj+sVVDQ00Vb6lNGTPcnmtb7eSmhPqEIyrrR/IQmuMslphC527QEwrY/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726129; c=relaxed/simple;
	bh=/byUoJ/WMc6UHqgCYQepUc84g2a8J34F7f8DVdRPKCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuPNsHZDwc7/AiWJqDq3xbw6iBwU2X+LNAvYejs0HlInxbVGCYxdM03YsjNQolECzUpXVJ83fCi1usyEhdzzu8cjn9GLioghaqvAmqoTOs2i0vwVKyS8pbxycs2WXKdKV1DWndOEmWqGajB3pNYcEQuoT1BWjBA9JYBASUKTIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=TKj5EqlQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="TKj5EqlQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e27035206so5969b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784726123; x=1785330923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iD1PTipWdU3DcXEKR2UtQxdCuq75xUopzE+YD6AEWUQ=;
        b=TKj5EqlQauPSMcV3lkbsLaqOqCU0dreLTWV0TdHRTt+02xdTm7Rtrl4JsV6BdmnwTS
         8S9r8H49DY+9bzJvw1nBTXznXnw1k7RqNpvQTg451qs3/viOtJ3eLezErYcel9Fbr0lE
         I4m1+uCRVMTavGlDzdlSxVYWmSCJ8xRFG91CePilPhQDK8p3qvq0RwQfjM7e2Ims0nQH
         sbUbGeNP6MG5bDCNhKu34N74mpDvWs1pKQjNpQwz6Z/1VkZn4LoXs1xD4kfNXcHdZPih
         SRWW3Pnz12LgJLy6S9/TdvISE9N8xAGFN6VuxFVf9jgK2fE5mcGxZxY64WRDlKujNE7q
         b3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726124; x=1785330924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iD1PTipWdU3DcXEKR2UtQxdCuq75xUopzE+YD6AEWUQ=;
        b=cXl5Ufk1+KwKUx2co8YZyIVjxFsSWYG2gkwuNqEDwFPzi+nl6KsT8BFwwLREWWSMpE
         QXO3aeOoqMDHSgdVGj1Z72Yn7+c9OSnaOT9+kRYp2yxP96d6kOVnPEvMRqxlXfZAcZes
         2+281AoRKVOoiUWBwqExsupYZXMGG6zOJLjDGW7bmfrXPZ/8U8KPW0l285c0HjJuB36a
         k93g2Ctji7H9kAZ3aSywXnfRapUeoWzTRxKh/P/TlgoOzZuNCtGLghcGJZzJ94ZKEhXc
         qN8erZl0HHzY+HAQItD1g3WKTlQg7mktartChKYqs64lErb7FyNL/rhxi9WhC+k0+TwI
         mJig==
X-Forwarded-Encrypted: i=1; AHgh+RpxDkYQPlIgpfxevBzx6fFLwqgDkqabOdCCmaU4K8AH3SK80sO1Hq+YIsy0F+aGbo3kF71BIpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5jUmUqUU2zft+5rPFMJZu+cu197cRkUSfnXPVbM1Lp5n5h5X
	2NebxjXXJQY0PyncwJNOD+cfabP+um8v7riG70RjDxeWrrbdG6s50tzOuu0B0VSPT2s=
X-Gm-Gg: AR+sD10eLdZDieFoIUwOsPvboTE38e7TSOA9pBjT0D+IG+74WHLvJwJE2MdE+5qf1I5
	Er0VEYZNopJclIgdSGfSkrth++pqGIFLH9OnSPN88LnaXQd7aizqQ18llqaFSCC+cfN4CwFMBdX
	Ss70n6A2qwz+OTDoTOW6lXhhDioejJFpKmWQhbl7fjgL5DPKKzA+0SKryyv9Nqp3Mapq5Mkxs4T
	5BiZTKAYKDNMCW0NHw+guxIvAYusKbDCQHBTxsmg7hk0m0cBUwsy8q3kVplUvswHPYw9eGI2PCt
	4rEd443bwAQu4+LHjZU0R6WDK1uR7XPspPjHsJ1sAVd2b3irGc+CWFipvDxo8HoHGxlWxYP/m3g
	ExetNq/K/7fOTnka7IB/9G+mUANkTZhTZZfUNVPt4zgfGFAXjQtFHKaryCLM=
X-Received: by 2002:a05:6a00:3a21:b0:847:8d2d:712f with SMTP id d2e1a72fcca58-84c29239a02mr23869158b3a.10.1784726123466;
        Wed, 22 Jul 2026 06:15:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm1368442b3a.9.2026.07.22.06.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:15:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:15:19 -0700
From: Joe Damato <joe@dama.to>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH] selftests/net: use MAP_FAILED instead of (void *)-1 in
 tcp_mmap
Message-ID: <amDCZ5t8wDtqNAIe@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	longlong yan <yanlonglong@kylinos.cn>, pabeni@redhat.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org, horms@kernel.org
References: <20260722015129.916-1-yanlonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722015129.916-1-yanlonglong@kylinos.cn>

On Wed, Jul 22, 2026 at 09:51:29AM +0800, longlong yan wrote:
> mmap() is documented to return MAP_FAILED on error, but tcp_mmap.c
> compares the return value against (void *)-1 and (unsigned char *)-1.
> 
> Replace these with the standard MAP_FAILED macro for better readability
> and type safety.
> 
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>  tools/testing/selftests/net/tcp_mmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Looks right to me. Not sure if it needs to be set with "net-next" in the
subject line to make which tree this targets more explicit?

Either way:

Reviewed-by: Joe Damato <joe@dama.to>
