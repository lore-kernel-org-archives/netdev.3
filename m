Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0C42DA36
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250145; cv=none; b=OGfFh1AoAZARb2bv27w3fKSQC2ax3wCZTEW11YDwx9xsed7GL9uFerPmfB4oH5i+ZNJEvyB3Y7x+uS9aSDP9RnBsgOYW403zu/PiZETyBYUKzXX/POoSx5TqkKTk9RdYRpJE/hHa/rB2WTVG5mr5JcNCLe+QicigQyvXSVT3C6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250145; c=relaxed/simple;
	bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVN6uPsTFtohei7rlVEJGWHITPT4UoCufpc407AWKDEBCZo79O4j/TOpNBmhp8nTd/KDR12lXMJcIVWQAuYyv+Ss//oNzosUp+Vhz2c+FSItqeEs/HB9zf9V0k4LZpy3FNv0Yi9XA0cF25JDFqGMlUFDZgL3dE0DOFxSVHRTLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUM9okvy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=liK1g+cX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUM9okvy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="liK1g+cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788250141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
	b=SUM9okvyfvIFBfaj8YsA52kxF7RFmgMZs7aU8O0YLZ4tPXB6r7F8AkzYkTaiX8iJIBmc8G
	1OzY/FlzgRsBpsZlP1XKYfLYDscuZiO9+FTJngAi5rcYiGTaBY5AsA23eNgQBtQPkKmg3h
	DHfdmV4XxZ3I+rc1PgqRZSmAyTPu2yU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-EUqYaT8QMJ-BMCwxh3wb7Q-1; Tue, 01 Sept 2026 04:09:00 -0400
X-MC-Unique: EUqYaT8QMJ-BMCwxh3wb7Q-1
X-Mimecast-MFC-AGG-ID: EUqYaT8QMJ-BMCwxh3wb7Q_1788250139
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so29628515e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788250139; x=1788854939; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
        b=liK1g+cXQU2rRMtRVsFoKzWusjqIH5jzumgud8vTZiX75eByvMFsfC0dO0XMp9TaSj
         hqjLU7UnoSEV9ouFdhiNaPezcbttIHyIuTmscB+hjx4gl36rgmyUM1rbi52P49b+xMtr
         WSjdscauTmJQAyB/cw6CgRU20TQo3ui9VIqKK3a9Ad1FvAMmc75fSamNKWc3h0D9TI3a
         U2zRCtOznzog+CV7vEy0aNZYPpWruKFT2KpS99xM/0e7uK2qI4uMRcvatO6U3X4oD39y
         kah4oWh0EOg3W6RcjhQ3spSj50lOc0TQd1vj3Yik/ohd1YxSVVglGX2DPW0/yPLv2JY9
         l0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250139; x=1788854939;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
        b=iij575f02y6MHsDgYahwJEOmHMHywJp1Tk8Ph3CgLoZn3OxifsDbmScud+Snj53l9r
         MgbmepwbTInMXSGYwXDEh6NlKTs3lIa1gAb9ZFap8JXu1pZah8ExQynx2cPKi7X/W5dJ
         /UROF72XNr9yqH7vZe2mxozPJtNAY5ofv7T6NJnuONoB4iQSFLdmn7YRZLZLnHZdh2tz
         eZsJ2dsv7RBnpnxfMSbVlcLSDf5PDUpdlsujmwkh64JLnwAiCc7iNISG494k8q1EhCyX
         KtRFOGYdMctBDMee6OG/zPNTecjhsFFsb1v92OMhwEuXrz5oxLcAcg10qzCbONo+1T3I
         /dnQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7sCNL88t5I5wy1L1v2GQZ92VY/DBTuZAG/EaNwww5BodfArTiZDujuBSfnl3y3KEf+cHOLuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++luHxsngFDDGEG6dlF+DBz0FW8ypGLOU9E4JR4i+4qbMSEMyN12
	Il3BW+V0Up6P9snUfs3sBNvYjNLRCHzeGGDF8HI5moTzUL/pEF0LCm4w2uMcmwOFWzA5KMJ895T
	m0LNpeVWCDIuDUX4xyvJHZtXkQaAMfeL98uE9OMeJ0Fup+6okp9j9/NlxGQ==
X-Gm-Gg: AR+sD13BhvmqkKrqJCi53Vh3lWo1C+XELrX5TyFLeijJiOkCve53sE+Gny0Cf5m0r93
	kLJZPA7sRYiYC/qdN093+CTQGCChYoIh+RLDjQZK2I9s8CaMMpCA4Lk3Kg7wbUHgtbqWRT/2JdG
	KlxSPP4emC/9ssfTO2y6hRfjwbgzJFDsAgPiZI3Zw28PD27VwBhRZTN4n51Ow/a8l78kyZQfRbs
	g8VxCKHiuK4XYp8T6/4pL06CPpUpsNy/UaSXp7RjekMgKk1HiSAtO22OrAzx3DgKlk6KPA2dVe7
	3OyJ4cxqWKPPaNqIE2KQLIrgPYsI3YFulUdsH9BKl+x+J+/PlrzqoPMLVdjjMLBwaM8GVRIB1ky
	YttrRhi/gcxbblkClY+OGvY5d
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cdc405494mr118156185e9.1.1788250139477;
        Tue, 01 Sep 2026 01:08:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cdc405494mr118155135e9.1.1788250139078;
        Tue, 01 Sep 2026 01:08:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8b9a2efsm154174195e9.3.2026.09.01.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:08:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 94FDA97C4A4; Tue, 01 Sep 2026 10:03:23 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence
 in bpf_program__flags()
In-Reply-To: <b256533a30204621a9d7963031e0033d87a88f0858ce6c6286a2fc054dd6ca11@mail.kernel.org>
References: <20260831132648.65843-2-toke@redhat.com>
 <b256533a30204621a9d7963031e0033d87a88f0858ce6c6286a2fc054dd6ca11@mail.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Sep 2026 10:03:23 +0200
Message-ID: <87v78pv1o4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> bpf: selftests: Check for flag presence in bpf_program__flags()
>
> This isn't a bug, but would it be worth using the same 'selftests/bpf:'
> prefix here as in the later patch of this series, so the whole series
> reads consistently?
>
> The sibling patch in this series that also touches
> tools/testing/selftests/bpf uses 'selftests/bpf:' as its prefix, and
> mixing 'bpf: selftests:' and 'selftests/bpf:' for the same directory
> within one series makes it harder to scan in git log --oneline.

Meh. Won't respin for this, but I can fix this if I end up respinning
for other reasons.

-Toke

