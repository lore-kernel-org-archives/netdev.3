Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792615347;
	b=N5FAdjT0iKtFSdH25UUTcxtQCEmfpMZvjGSNhOMKAbxi3Nr7lyONtbt22Y/M1IU/0AS+
	 bKsummCVHERk6/3yoD9oUyXKBxklbBqatmhhOMluyqCEj9Nrg9BJbBKWB7hxLRX681Fz6
	 wVZ6LSeWF9ySHXjlgLk4nBYbbdvEfXjt0o3aFAGazBq4vZlEreeYZVBw55cmMXZHbjPfc
	 aqcHijk9KhNv7AKMyx3blyhhc7roj5qIZTWcPIh6MXmGqrLCV+HPNbJ0pFIaXpoyOEh7c
	 0DNadbDygS/quzblELBnrvkbd+CXXiSNObW+QgEzYmQ6DMy3mRcKoh5LmShzdOJARRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8xOtYw2UQzjfVaNRpu7KDUVa/s7vr4AwHD7vVplnNCY=;
	b=eFgWSICUHG18pqHGByhlZLBBK9u/h40eUcwVcGEmbPwHwGdIKXP7bmOQ/Mf9NTGReHbb
	 VUz85/eK4T9w57ZbJxvxiqHTNalwQPahctNfyaPYS5F2BC1GCSk4KbFtkk2UWRNOgHfo9
	 OK8OTTiz+/TkETYCVrULSm0tKMmeDy6yyD69rsnxyZt0czSsUleI1ymmbK7ew9HqXjqcf
	 f8RwnN7K7+oivtX1dK6GrGt/yHIIQCD8pMGZEgpE3o7UH7jrk2SWGgcQohZnItxA+ifR1
	 sQ2yCE8cODZi35cAgaSwYN8QIEu0ZAC0nkCuOqsTnlnDozLn7taWthglffVNq8m8rgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VO3YUyFd;
	arc=fail smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C0606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 089C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VO3YUyFd
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-677dbe051d4so1001155d50.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615346; cv=none;
        d=google.com; s=arc-20260327;
        b=eohk3dKqbmtTkBpphy09+lGs4vO4no1gq2Nxh8THUumy6nrpCmjarm0AxJ0sFIZQwQ
         iOoDbu727jG2URgKq4nOhqWohWQua7PmYBrncC0yEFmlEsWAZYQ01SD0h/fyhpg744MX
         WBn4Cu48NDT3IgL3oyZ2yeF4JDKBpI1tWd+NzTtJIUuIYlr9Oc1raNwEaFVhg0GuOz2G
         Yzgv81PWKkUQTRF22drLbyozQwTQK7FkGF4G7yINoctt4FRvxDmAGgVQ+1xZlpBoKE71
         bbE5OWtSBu6jCr7XjE/f+G5/b83zK6D2mDylxOJQn+W1AsfALPUulr2vjpdV/JGYGFxi
         zDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8xOtYw2UQzjfVaNRpu7KDUVa/s7vr4AwHD7vVplnNCY=;
        fh=T+7+xqnufO9O5D660sQuoVntICEdrwW4osVq4aTunOM=;
        b=LxGfELEiofXlXG2Ow8z/8P51+/vFnx7KEZaodZBPwNKgQkYCj8J9RdzQo0YieYYcAX
         p++exfCG4T/ID9nNHBiCM2Vllp5G1dU9WPfZgINceTrha6I4Tt92no5D32fOzTn1DyEa
         8U03svHkfwPzWz4BJQiZBPTxDshi3VSub8bcs8fHTVL71u6Lh7jQ7lms2INH/fMad1VO
         y/bgwSSV1JIHxJPsBOFi70w3P88W1S3uB7USn4dBeiDuF8GjweTpJRoID8K3h5fLwxAi
         6LxQtEg9yW8Lxtey+6iwUI2dOh/SXv83ZLt1xXavhhCOEzXssBHLMp/pfprPbEhQnct4
         vc9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792615346; x=1793220146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xOtYw2UQzjfVaNRpu7KDUVa/s7vr4AwHD7vVplnNCY=;
        b=VO3YUyFd3pmmCIftZq+xF2ZkQZoIHU9JIzi2JIJ+1ESR/1LcjJdDVnlViAkkfXi36z
         KI+f3J0R4BZKChF+LZNb+KRrbY81eb4kL8JRiYuIdZ6QbY4V6+IWGHtIHClBHazi44OL
         XyRuKI9pxH4Pp/IuDAbTbYY1MLG2AjDZpVcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615346; x=1793220146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xOtYw2UQzjfVaNRpu7KDUVa/s7vr4AwHD7vVplnNCY=;
        b=qFUD9qlQ/cJUn44JoVLziOUeJhQHr23ENuGyeWQOnsf6+v0bpID6ClwWYjPwa92Kfv
         JKk9FoAgGH9b2atVLyhLWK0JmqvIuZDgR0K15oCcQTaxZUtAAA/HWZTfqceSCERpxQZt
         vuorjKzAqZL1U/CE41K4s7kdJwwXqdT1LiGRjC4FjCa45nDyc71jesbKMUULn79dhsdH
         qFNbNUyPI+jt+raxipYGRZky5ZEr3YR2oglkS9jKDzFKw6STnNr7qQhVdbx/lMUe8DmB
         +/UiI5rpc+NPtDvEPq6hTFgu/rQ0EqKm5ySliWksEJGMnlsK1eGMRqmBNIe4UlbO6PCs
         pR2w==
X-Forwarded-Encrypted: i=1; AKwUvBy+RM1w1tkhVepeNCE3NmOV+cn/1up9rqh6RnJxuNd2FIi7RPl5XHKXOIqCthk8dd9XoLCeIrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeIkZk+c12smlePiAEfL1gT5okLsjYul2+h+E2CNTdAaqsooF/
	TUiI2u5ARAzExTw0HbNEXo/XUT5iANBhoF164ojnZ1rcbKSWGPKNaPI+9TBRkmOtjLHFQSE371n
	pA/MneZfmh1zYo2DXJJvQRlm75ZFtgA2ZMdIA7ek4
X-Gm-Gg: AYBFou3VGOIZYSEQM9/Kw9waYdkYaeWjAFIeJbygG2gVwarKMR7LFke37gB+nKJRkc0
	JANhJ6f1eig8ut4/xlaKR4DXnu7j6EkmgRpWX0HlVfRy4ArATrfX9OBjm+uxmq3zopLhB/0Rp+Q
	hC4P+Z/wnWC0/lI1XJhpUNNjXYjn5SoJ+LPgijCSBDEeVQQYIySFl1hwNCSNbJpQSmjHFbJvVSm
	taaJEYzmxE8DRA6hVu2cdv7PB3H3NDYTgphp4ArW46MQo/Bjj3UIAP4w5wVBs2mRgfEoh8uRKR9
	KsV0jKce90YsDX4OMgdl/KEexNv3X7iFSo3VpASpj8nYlGKa2Ks/9+evckWkXLtUuMwCg3ukd53
	9fMyYEofAhbjmdSjjlICiEgz46XmZHj7kdcA+aI0WhMwuczjC6WI=
X-Received: by 2002:a05:690e:1512:b0:679:b810:6e02 with SMTP id
 956f58d0204a3-67a0e45c3f7mr1012582d50.26.1792615345995; Wed, 21 Oct 2026
 13:42:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-TIAE.v2.r0.20261015163454-1@mojatatu.com>
 <179244597608.3135.14866688728455017187@kernel.org> <3ab59725-e34c-4243-bc72-d93f837bcad1@redhat.com>
In-Reply-To: <3ab59725-e34c-4243-bc72-d93f837bcad1@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 21 Oct 2026 17:42:13 -0300
X-Gm-Features: AclHuK8LdBftHZw4Zb8WFN_X048TWKstFrjtX5FLtVeFmM9dmX8keSM3eYtswtE
Message-ID: <CA+NMeC_kwd5yihR3SSqb+Z8wX+NuobntbvpKtAyOwjZ1Xa4mVg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net/sched: drr, ets, sfq: skip empty
 rounds in the deficit-refill dequeue loop
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	horms@kernel.org, sashiko-bot@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 10/19/26 23:39, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 2 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] drr_dequeue() and ets_qdisc_dequeue() allow only one bulk
> >    refill per dequeue: `scanned =3D true` is set at sch_drr.c:414 /=E2=
=80=A6
>
> This looks legit.
>
> Also is would be great if you could somehow deduplicate the code a bit,
> (but I have no good idea on how to achieve that)

Fair enough, I'll respin this set once net-next reopens.

cheers,
Victor
