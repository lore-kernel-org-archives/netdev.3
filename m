Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17D44160D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201509; cv=none; b=Pp23U54SFCJTw7QIrBW1UPaNaa5k69j4H5W+1GJgR0+OPclpldoRJlVjFoIngdOkcWWoVehy+FEtDtUUGg8X3qSMJ5x+rqLIh4dN62aUDE2I4CInwPdNYvQBkmIJwlfMxrLl9+qInHx71Rzt+jZ5g7Kmxlq4ruDApBdFG7uCIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201509; c=relaxed/simple;
	bh=G+sXLb5QQACGJWFw2GYB/k46SIVKIpCEAPVvzKkNo84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IjhMrnjTO4Wmx4Rmpz7dy8ge+EpsJR9/l9lB0bk/1iTT7uCPwnE4IhTSLoe+GO/j5XQo6leT8nkIxL38ibVJqmhhyQUeFTuVWTtIGf9S0t8tC/VaRAvcBC5QlCMiEIPH7BWkqXniDTmnd6YXxvMC0w120xvfpPSbyQJDcuOwYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=taa0RHq7; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="taa0RHq7"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so7835675e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790201506; x=1790806306; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GAy3js82zkC6BZGrspDqEhBjsPWiuHyN9je/HHFqVI8=;
        b=taa0RHq7gcEylNl6iCnAL35RW7qHxoCrus8sPHrquAghyLiXANtiWbQZ6LwZYLiwxP
         LQEqXLzN8r41H1c98UGdhqkxQMSrQlS+cR6MS0iS/7FQ+V37Rilg4opgBVs6lC8mqJUY
         mhGvsmJfxxgiuswQH99sxcAmzay6rKO9cJP4tGk1/EZKo+es3iOQiVVvcHV0rzYkRi5Q
         F4LJwiLGVeWQaXihqs4r1ZWNrz5Z1BeHTmM9krFQ0suHLNTWFmx7ikcFySfsi4QGG2fH
         zHcyHQeoykjQ0RGMe/Kcg28bjyY46n/j1Eq0yx1gW16atbiRFt0LuI6a4ry5ERn2o2R/
         hSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201506; x=1790806306;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAy3js82zkC6BZGrspDqEhBjsPWiuHyN9je/HHFqVI8=;
        b=y6mBDBF7OJna7tx3gK+hrv9MAK0xW/PaAfd0YdZLhzqdIgixJVLD6AdQi6bgPFjZ69
         0jWaGAeMKGkFCv0rphKhjVUwA0R8S7lD5a7pHNWe+YuoeH6jb5dqTSvWZDV3Thp3tYHV
         3o1r6vuQvrMilvCOdZAHEwStZlErokKe9ELynBsS+ugBl+97+Q9QF6sdeBdzxRtcJFC7
         iWhRPk4q07vXLGn7/uAJWjcsJsZtgqbxb+cbZeA2Xd7fUe3a40jcenlGwjjJHE0DxUit
         FSfK+BGdn0+Rrnl1R4AVFpau5oaReuZUga2egsTgBRaZ2oa1Co3R846/x2El3UH3BNuV
         8P9A==
X-Forwarded-Encrypted: i=1; AKwUvBzy6/mOjlsZDdCqIRvhEW//TYgvdnrNp3ETnT/sSaSjO+mJb7myy0e/MwGwnTxSeK9cB8tzoUE=@vger.kernel.org
X-Gm-Message-State: AFuF++kHaZCK6+w/R/POglwWwuAWYCKEGMUafXvKmYu0e0qQ6B9RSnIQ
	9tWf5CaHBPgMtiO1AcVYJsBV3eTBF5wmkYe7GOoTJhNOTy551o4IItknHcj3H+ul0c0=
X-Gm-Gg: AYBFou0odWzskg8Q2i8VGE5F31Vmpv2thf1ss61nGO59LMaFrKWk1em83FvRdV32PNl
	xi7fYyRBhCVoSTLJQXTSC0IQy4YCgDAic5iIn5CA/O/qCJBjL6AdEKQdN5BVHE2fYkFzsEkEXMY
	tQFDAfKLo3aCnlwp1q/LwSyFSqVGM2lrLjXMX/o1YweO9xerywmnF4VZ80U5OAtrrv9OJUQRZXj
	Wh8dqlumpX4I/zRRDl1n4xFsLj7ru2tHK7dq9u+ugRHJ44sekVevFNW19mqHmjWVcFhTBU7LDMy
	sWAxSedD4Qml22/EnaKR2O0ZGA5MktwrcKziuJ8dyhxhxOl02DKWJJ28KwU6st+5ILfBvlvcNjA
	nqT+BF8b2fn2n5SmTVp+uGtx2NSmRg/vjviG2+Wku6YKw7wyKczcQ1tFc90qJN5YT3lfmf/xHnM
	0DoZuBmTNSHtlR8Mb6H/FcG1gv+uTnkHtKGiKKgpV3VEDyJy8xmCM6NMGYuKzEjj7XXQ==
X-Received: by 2002:a05:600c:a013:b0:49d:2555:1a6d with SMTP id 5b1f17b1804b1-49fe66f1ac3mr7346185e9.16.1790201505557;
        Wed, 23 Sep 2026 15:11:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:b92a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm26956515e9.12.2026.09.23.15.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:11:37 +0000
Message-Id: <DLN1GUANHOWT.312QCZOCNSGKQ@etsalapatis.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 2/8] selftest: bpf: Use
 BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-3-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-3-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> Once bpf_sock_ops_cb_flags_set() supports a new flag,
> tcpbpf_user.c fails due to the hard-coded max value, 0x80.
>
> Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c | 3 ++-
>  tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools=
/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> index 7e8fe1bad03f..e4849d2a2956 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> @@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result=
)
>  	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
>  	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
>  	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
> -	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
> +	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
> +		  "bad_cb_test_rv");
>  	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
>  	ASSERT_EQ(result->num_listen, 1, "num_listen");
> =20
> diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools=
/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> index 6935f32eeb8f..e30cb1fab079 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> @@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
>  		break;
>  	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
>  		/* Test failure to set largest cb flag (assumes not defined) */
> -		global.bad_cb_test_rv =3D bpf_sock_ops_cb_flags_set(skops, 0x80);
> +		global.bad_cb_test_rv =3D bpf_sock_ops_cb_flags_set(skops,
> +								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);
>  		/* Set callback */
>  		global.good_cb_test_rv =3D bpf_sock_ops_cb_flags_set(skops,
>  						 BPF_SOCK_OPS_STATE_CB_FLAG);

