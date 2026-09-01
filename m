Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD443BDA9
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278293; cv=none; b=nO49QbU7FovbAfRHs8XeNwLMpzx2BuleiLLz+Jb+xlZC71vkroSECZoX97K7qaZZFfBbynB8ACtr1py000ijtnIY3ozI94aZ6PlorGEgcQ0NpKVeBUzb+zBQpfWhn4wpGOQj8rixKyqGxYKuOERQU6bQrbUHWLbtRVI1+oSddL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278293; c=relaxed/simple;
	bh=M5BeQDw5eb2myqWI4EYOJmv87nba4ut4fX4kqBHrbmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbBm0bIjhg1nXrrF7ZeYyJrGAshFcS9Uv5337f5v9oCPUs0mbJdivvLlOZLNfS9d7CbiPVUSULNfHzFlRi3mRdT2LA2BlEd5sCccZe5n57MmbsbQSlujkJI6ehI9Eiq+NKIOEqN/KoCh0fOr/J3ToDHBxgSbFv3uDTaI6E1n9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=f+iPIqSf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="f+iPIqSf"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39647184c73so1255777a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788278291; x=1788883091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tFh8cJbHJN/yLYBydB6gpSd9kUWn9zqLfjwYsTOT5+M=;
        b=f+iPIqSf0N036Hbf4/jzY8alpTENsK3exEQcmb9AwfUCNEFDmB13seP0G5ZZTYur6l
         UdrQLQDXjvj+MNnxq6TWMPIKiGy63/LEqy6enQ8KpUihYI5m+ZZNVPxAjbg1/rH7DOoi
         qTpBiKEkwUsYGZwM2IKlcBGYsH5hzh98PznwHudwZZGB64TL+Biyj2GnkrvKy8mlLzfX
         9Bq4P25Krjte5PBcPgVwBkzsLRD4PFykuMrw9E+HWZcW3bR1zvIWM68oR9rdPo577VH/
         G5zGQCOGugw5coKxd48eKUY60L4Zmqpglx/zgDmjvLrnGPNmJ2Oos89znfEshEWuiPlG
         b3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278291; x=1788883091;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFh8cJbHJN/yLYBydB6gpSd9kUWn9zqLfjwYsTOT5+M=;
        b=NzZpRQRcxm42qJWalADFOIduKNlehnExn6aKgDDSQID8EDf27//vhoGQmKTyHwPOqh
         gK1qaaamuvGt8uiJeFE3isNeR08LhqmhF/WEFyUTJfmkbQNA66b3Tnp0KN+z6nGdRv6Y
         R2VB3JiVfyl8SwW6qKyZAwxnSKRR0O2KtzGpKqnP7xz62dt1NJZwccjQoBvcFG/OeAfO
         sdCGHLLvcpN/3KpQM7klnodvwnEGLcdCQNNe9UPaHwIR8/nk3M3oZ3wrbLLSfYHUfCG1
         O34CXpA/spa3Ah+x9u7mag2xPrZuC+vT6Im75ZCnNUx5t+CPslH0oYPMz0nuMQqRwS5W
         E0sg==
X-Gm-Message-State: AFuF++nBxiC8yPWnw7Uq0BsHyWCFdMYi8ybFQ0GkEjG6ML8nQ5P2bRco
	W1A9L2fMG0k/+lJxUTLggvXJx67wEfH2jdSg7cKxQ066vn8i/QqVmbviuYdw2yIhfxJW7ie3Jdl
	GG55S
X-Gm-Gg: AYBFou2+lND56FP3d1hA6qBdaETPURS9CsCmPDKflPPq+geM537IFMtYXfC+KVb+Jvs
	C9E92qz3+oUuZEmrWFJqYeHkVRr1Gh6E4NjQiQGE0t1BwmrKIjMhydyM0yafj3VaQLR3nkbqze+
	dg2F4vqy5sKMSvRDbpSQoHzoQjdu4Rnft5YhbYswgsIuA22ZeXRn3sDtFqzKDHUkDRrG5vhq7zf
	RQup7L9zGm7kg+/UAaIt+kdVa0bTxLi0jfyzvquz37WGaXCjQ6Vzp/oMPwP09o4RHWSXsV6QYGK
	/eU4HNwJXolJ78CmbixWban2p8lS0J7HOzqmqGx82H+5hpUap/c9Leo1yyaV9++yEPVnzF2TpJt
	t6lEmwvkdDxmBepGIg5TJB4c1iDY3U4kbNfNlQ86Gf55ZmrFHH7dsJsTDR3Z0FzTaFitMFcVOZf
	SqqdDtjB3KQoOkV2Ry7uocf4uG0nkClFzRgQ4J4bJzyn9n8inBzKktK7bBviApDSbMKJ98IS+Pc
	AyZMctDepYz/wY1FoPQgkEQvdh9SHg=
X-Received: by 2002:a17:90b:4a42:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-3990f727a7amr4773479a91.3.1788278290630;
        Tue, 01 Sep 2026 08:58:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d22eacbfsm8431325a91.0.2026.09.01.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:58:10 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:58:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] u32: fix IPv6 port match pretty printing
Message-ID: <20260901085801.61250518@phoenix.local>
In-Reply-To: <20260831104057.2176-1-prabhakar.pujeri@dell.com>
References: <20260831104057.2176-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 10:40:57 +0000
Prabhakar Pujeri <prabhakar.pujeri@dell.com> wrote:

> parse_ip6() stores source and destination ports in the 32-bit key at
> offset 40.  print_ipv6() checks offset 20 instead, so it does not print
> the decoded port fields.  The source and destination labels in that case
> are also reversed relative to the layout produced by pack_key16().
> 
> Handle offset 40 and use the source label for the high half and the
> destination label for the low half.  This matches the parser and the
> equivalent IPv4 printer in both text and JSON output.
> 
> Fixes: d13cee6d598d ("Add IPV6 match pretty print")
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---
>  tc/f_u32.c | 10 +++++-----

Used the new review-prompts for iproute and it saw incorrect placement
of print_nl() so I fixed that during merge

