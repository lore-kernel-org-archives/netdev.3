Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD8491583
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102780; cv=none; b=o48v84FGNhKth36SFo6lzmlCd4P7vaM0RzNu58iQIU8Vy4wHaun6sc6+DWM53NJAF5BQQ5U0RO/6SCxH9azin2us+Dxi8a5wdSH3cMLD6mkrl4FsuEg5EMHFKUreaXUCGnSP+gYCR6cWoRfl7I33voIZC7T4Fd0mU+S2WwR1AE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102780; c=relaxed/simple;
	bh=nTVQMey50UnzvvyZ7z2R22Xdnm5sqI2qMUvaYzyCAaQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kNxvW2nZwi8phaub+7c7Z+JYEMGr+18Pq3DLqUllNXJ4R3iACeAsSPUEE4vmF2yTYjVdQujIFbF8jJ5K47eIUey0Qe6UBulZRo3Q49m6MI/kjydiYZscghIMvpp+30utku9nB/S5fOWrlyBCAC80VetOAWwo3b0OvRs4Hye2Tmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soabn2Ft; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soabn2Ft"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34907so214330b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102773; x=1790707573; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DlGmU2tr1aC3QLpKPtGAeCfgB61Lr6xQ/wV06DTCoBw=;
        b=Soabn2FtSRzatHhV3Nnsw86mNIj6fZMmyNxLBcFTpeLfWYjdla2LHV7hTZc3kHdj8A
         yJcV3YUldA89c9tO1HBkfv+8t8YnmWCPCrj2b00iyUDTnDDT1agTzUS0oxQ9SLrIs/28
         XCutNaI8MITaEBvMJFFSxNl6/+zvT0u0ebW498071ZBiXcKetzd1DZ+Imuz0uo5c5nWm
         cHU9Enz3qVYK4d86fMirUVV74lrhXmnsbAFipRVmcP6emyvCSgUMcFVdgkPsVxex7m9t
         L7KAbTw/K0NhGvb8RiE5kkCKTPgpjV2qJSOpO7VGQIukBbUbVfFwXxoJB82+3FA8dsIW
         peiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102773; x=1790707573;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlGmU2tr1aC3QLpKPtGAeCfgB61Lr6xQ/wV06DTCoBw=;
        b=19G2wzISXjse+oaabm2QKqW10w51JDRPZ+TqgGcPE7GeAXNJ8RZ0YnBKTfNZf90bhR
         qmpBqgQ2+lwpa2jRUlOutVk4QtgmKgLjmhGmCB/E59333zU1EUZItuRKN7q2mwcMNv6G
         XNSCSz7PTycwosvrFCXeF8ZqonQMUouvUA0qt/0z8vznscKplfpfO3+BxKfNEK/b3Joa
         Qi/uV88OPlumxYuB9S3HXGLw91OA3kT+1emdowB7wGOFpJiB29cyW6NkU6NkoGmYzlWq
         qiGLKb9kpceBWFgAHdUj4+gbPsvwKt6aQgejjGBdJGWO34qitKGj4yyFajyLr8yaz6Pd
         O+Bg==
X-Forwarded-Encrypted: i=1; AKwUvBy6Adc+OaCmPdf2IRzPW+kFQ1d9tNjPwBB1e76LSNqLXdizfxx1NFfLDVG3Es9KRDOU5LRKMkI=@vger.kernel.org
X-Gm-Message-State: AFuF++m7o292/8nJu3g20s6FqQhzFoFoV7+93byFezCxJ4a5s/afTat0
	EmC2wzJI6AvDIZthyP5US57NbkO5LYhee3bfvysZ8oLxg6NOFuxdBcpf
X-Gm-Gg: AYBFou1X+Q1c65FTBJeNQq56P2gGfLz1sKxKc1QmIJrC6ANwXZu1mjdk4ZVHj0duCtx
	D/VhcwW5MWy464hB2Cte8qbOkHklPUOZ320hmDEZCNGWX//c6hmA0D0nfTy8Ff0kuw2bWRfcLi5
	gaeVdOjtG2TofZ/1o1xdaU6oa3ltjdy1LjDqUq8SmpR3MRx75qUfVzP7KKwa1g2knMghSCOhVVR
	200rkyqNW0cg5fAV9vqx5nlAvE1zw0ZgS9M2z+genP9+FO93a6PvhFtftxh2HQ3tfXsPqI3FNZG
	LM/m5qMtpDktEy9bzJcvNtMd7As8lA+YKB/XKhiElgMYupXd7Pw4MojPrNJ8cVGvkCy8WCX4WhF
	ar9+3J+xGzha1agr93kQWhVlUfECVe+Rj43ADg3j2uiQso74SagkOcKJI8biYNrv7eU2X/gv1Wi
	Uk8X7qLk5FrbGzVI+zoioE6FzusfvNOwbYE+6SXOJyPXne3Y907zrVKEXLumlRSSKaCCGIp3B9t
	1C/iwmRuoYheMUGj0N+a58ujuLz3m1ukdzGpi5YKfAM7Tln8Faoree5CNWeV8g4c1V0JZNCMpBL
	lS0=
X-Received: by 2002:a05:6a00:4398:b0:857:7337:5dba with SMTP id d2e1a72fcca58-87d1a4b3d21mr497862b3a.24.1790102772886;
        Tue, 22 Sep 2026 11:46:12 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5bfc87sm205200b3a.25.2026.09.22.11.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 18:46:11 +0000
Message-Id: <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-10-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-10-emil@etsalapatis.com>

On Tue Sep 22, 2026 at 5:20 PM UTC, Emil Tsalapatis wrote:
> The TYPE_LOCAL dynptr type is used for two different
> kinds of dynptrs in the codebase: Those that are created
> locally and backed with a memory region, and those that
> are passed as arguments to a global subprog, whose type
> is not known at verification time. The two kinds require
> different handling in certain scenarios, e.g., packet
> pointer invalidation. However, there is no current way
> to distinguish them.
>
> Add a new field, type_unknown, to bpf_reg_state's  dynptr-
> specific state. The field designates whether the dynptr
> type reported is accurate, or a placeholder for "type
> unknown". Adding an extra field to bpf_reg_state avoids
> unnecessarily splitting TYPE_LOCAL into two types, since
> they would behave identically in most cases.
>
> The change is currently non-functional. The new field is
> first used in the next commit.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/states.c          |  1 +
>  kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
>  3 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index be0ccad15..f57730d1d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -71,6 +71,7 @@ struct bpf_reg_state {
>  		/* For dynptr stack slots */
>  		struct {
>  			enum bpf_dynptr_type type;
> +			bool type_unknown;

why extra bool? Can it be another value in enum?

