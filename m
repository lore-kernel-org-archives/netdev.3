Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C34A8FC8
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145977; cv=pass; b=kUfLe5IQrBfG28lzVMpBNxPGIzSKKyrU9qW1vHNQyCcN6sSmg//m0SJauFIWkdBm9ptkz47k8JikwQlV2si3U78wW8K51Zlp8F2YBy+Dm9G/eg/cPcoiY4rYOyzJ88StcI71p4WgT/pkpiTF0a2CzgbOMujy+Wqfd1xSXX1bhrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145977; c=relaxed/simple;
	bh=jDKALMMpK2/hAEc7VzR4UiOm5gaPklP8kWGOd5+e82Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZL4RIXcucluLHm1lRIPzYHDv2HFvKhyQygAh0zP+N2lsgmIVB00BPEnwQw/h8RVvV5VPYJxQLBP+ks37d3RvZU8Xai3J0bIwh3WHm5NfjwGsTlFQSimgWELuIfDCrUf7t0WPZe6p91AB9BYYqnaB/n4cEfPekoBRAuOeJvUMbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8YNlXfz; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8YNlXfz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52fa9c055b5so25725541cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789145958; cv=none;
        d=google.com; s=arc-20260327;
        b=lkUbFgevwrPEdLow00WebMPIHt8eXyma/BBD+CNN7/Vjv/Aj7PXLe0JgO1fSg8BR+f
         ud8WYRBRQdejKbh/DQY9J+yjnbvXdWnZTglxOyBp8BnwyHQIXNhU/mqwvpzI+/4TNiNq
         sCXn3oN3T+pFH9PdtCgfBOI3NYfFkkiUL8FkMb15ri6uf5XeGTdPD2MhR1xJHkF4Fdi7
         MzPoOB9stngvjQzicDZg+THxiKDiPthmTsXZo6Yu/gftPS7a2i8RuC+7t9JHfePk6kYl
         Ivo5FEux3MJOa45XGXW8hF+tjr76DLEFlunARIWX4Fp5rlUXWZ74Wf5wS04hZjlWWxNB
         RyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CxHqvc9vLcBnC0tbHsk2hRhAalz2OgvhCKulcIzODbg=;
        fh=saZ1yMNA352ZBooqQoroDfiGW7J5qrsgCUZcwSP07vI=;
        b=GR/PYRalAR1HZ9JtIpsB4JqS5CiLvkSk8WB6w8SksCe63GWbX+tT8yOnia64XZGV1m
         KLwNRsSoAG8uC/ebArNM3/q1iXkToRBYVZCgAnPFcM9SDmf2WcXkYATjXWW2lrC+8ulg
         G9UPzt+uHxUoQuUTImKztQaD4HxoNksnTeE43L4Uu8/CgtGW3U9xKgtn31byrK5ltQXF
         cGhQapvfcPijV2r/BDEunjrrbdv+KyuC0DTMRlp+pUVc5VVp0GP5E9rPA9P/YVrXDRH2
         /bgROXLaYU/tsY2V3RkCKKr43V1Wkxzp6/cfCI7im3Y52PNEmpOPTpZ8PeD5z7Q+3xWc
         OzbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789145958; x=1789750758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CxHqvc9vLcBnC0tbHsk2hRhAalz2OgvhCKulcIzODbg=;
        b=n8YNlXfzJrKYFQKHjqZLPl4h7zoo4azZfVIXNhqH2TuaRhqx7EG+l74Nh2q7oPxf6A
         A+DUjZkbR6FiaETtXnIOJgHbpO8FLlyonxacno7mwHsKeDGOqn8P1ip/+S7xKjtEn+mY
         uwF78sqWA6sKda6Zp1AQijm9nPvwukaPoEYUjqsZ24lH+3b4COg+W6kTVquDzZCD00j1
         GyYXJOWxaXpQdqaj3dBQ+1xt7uM1ZT3XvMHpgwUO6USAY23dbz/56mo5yuBzhQEY6xkO
         XKhR6Q8TkVNHAW6+OBYG66/5ndQXeC6Ks+eNV22H/aHA97rk3O037SLOnpOZR9kdh8/H
         nttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145958; x=1789750758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CxHqvc9vLcBnC0tbHsk2hRhAalz2OgvhCKulcIzODbg=;
        b=pkxIQZ0H4WzXfsfyJdeTfK56AowT6N8IFjzwGk5QMk2s06dhqBJzjAWR8Q97uWawQs
         89lsNY2H0UR0I6E+rCABA/Zoj7rj0fGASOwi6UMlBA7NJZk4zmgOibJoVTkNuDGKSfpv
         kLNMuBGKBk0MFvlSeeQ7Lzp9EuzP7ZOLljfLcFfvqkoPfqV94dzgaodLGL4/69eOK/M/
         dAK3ogMTycNKqNy2Q9mQoDq/wuMOhrund0EjC14YTdNGJGemftwTh/KOJqfpMSdrNj3Q
         uIiirbQmKjOoTpB+3gvjv0hAeewxEhF1yHs6gcCrjP+Dq2CfsdhRtFPF8zndIxujDH0T
         Y2gQ==
X-Forwarded-Encrypted: i=1; AKwUvByzbvjBtJQ1af1FyQgIW3X6FQh9+MCeotiCcIEy4FUe7+YX9GeXo1B7V95YfVW0t4k9fALM2so=@vger.kernel.org
X-Gm-Message-State: AFuF++lkGjsHic9/d1RqCCINazW/rIfgz6qyf6cZDSaYUjQ7jS3l87Lb
	JXP+XbPdHiFov94HK9LOAIb3e6qLyV+QOjJDDHmzGMjrMxFS+vVdVzBoVCt7XgaO99pm0JYsTOy
	zHp4b3fMe1oyfjjuDnE4XBFt/Lrpj7bg40y0SwNa1llZO+EW58dwO1FRW32OG8w==
X-Gm-Gg: AYBFou27G5xMa/ayfOVTCILjlFoVil7Jq1m9oA1nUXAr9bCdaPPwrChMGP+D5tsHXKV
	XvDtmeaIsKoLIiOe8/RoYysWKqiMVSnbp3Dtu7wcsC+z55FDuPX4D4IncO1ZQsD+QRtaSXxl0xL
	IMvdj6JdkT8FAnsdLw6x1gQDInV8c/UJwLtJu2cA3zCGDqKIwIKByStnBYge8b+Oh8lEWyrc5Jg
	uHdXPha9Njs9BEPyXTWLV/LubWPWglLw82xjvZbwsWbBDa4QNvM+Bij9V7X4wZBMzMKj0b2qc9W
	AkQEQeL825TdJOb6/lp6G4SKYWp1d1AU1Ut0+rJxSMH9dq7KTuuWKG6GoZPm9s9JQA2OBe42ce8
	GMrFxbk7KkxSgj1kyciKlAwd3YY1xwci7mMzu8x1V33AjLQF+6GcHHFX3H2V7VEhCpdFcb88/2l
	Ncs5TlCHMqEFj15apTp2//
X-Received: by 2002:a05:622a:60c:b0:52d:d12c:3ee0 with SMTP id
 d75a77b69052e-530b32e7d7emr132274731cf.11.1789145957119; Fri, 11 Sep 2026
 09:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911160804.917099-1-edumazet@google.com> <20260911094931.12e0339e@kernel.org>
In-Reply-To: <20260911094931.12e0339e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Sep 2026 09:59:05 -0700
X-Gm-Features: AcwNN1XtLMlqlRgx2V60xbs84yZj5HeCb44BM9JBAXOA2aiNiFJP_ZGEOCfSyVM
Message-ID: <CANn89iLZzb-Lh=DaAw1sJbQyfTbVFaHc0eeEz-q5ZpmeWPqvdw@mail.gmail.com>
Subject: Re: [PATCH net] netlink: do not free nlk->groups while lockless
 readers can use it
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	James Burton <jamesburton@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 9:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 11 Sep 2026 16:08:04 +0000 Eric Dumazet wrote:
> > +     /* Publish the new bitmap and its content: pairs with the address
> > +      * dependency in lockless readers, which can pick up the new poin=
ter
> > +      * while still seeing the old (smaller) nlk->ngroups.
> > +      */
>
> What do you think about the value of these comments, Eric?

I think they might prevent Sashiko and AI other agents from asking for
a full RCU conversion,
but I do not know.

Note that I had a first verstion of the patch with a missing
smp_store_release(),
so even LLM can get this wrong.
