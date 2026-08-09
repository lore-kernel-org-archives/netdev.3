Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030183A1B5
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236732; cv=pass; b=YoanpZ1zFa7MYxDmZt9U2HYiB51gMA3L5zDG78YUTcU7ar5CMMBjmCdPluMhMtMcXPmSqGH33GlVTrh8tD8bcMryFtLukHvMxQrgJFx42crUcoGqxYLtmQRYMmpdw+68IG3QRpJcRE8jjMjjofUE8icn/bl69CG3oG6LPhW5Ghc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236732; c=relaxed/simple;
	bh=v4liCDh36/+ZyZXBwFufBk0+NwnQDPX73vt+RUacM7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePXBLLd8TE7NFesCdSpd312QZxb8zBh+PcPC5xQK54t5JgywAjobyktsZqj3sjdkVbFE6VIN0KPRtWGdzQW3imbXjDIbFZhdz+b9pFplA5brhKUn5lhGCns6jKKrDOe3lWZgZ1rlD1KSnWy3sILnR9EHxp4EKzbkTPc3Lt35cY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoienVJQ; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoienVJQ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01c79467so136051cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 17:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786236730; cv=none;
        d=google.com; s=arc-20260327;
        b=h59POFIcF5uWb9NsJCIwa61WvKPwoZ/mAUZfPuq7WdK8geOhUJNcUjrt+GUAJZxoAJ
         N59fikl/aZlz8zOpl+6JGmFy3tjY/lc1QeS4VSo5jJGanLmBNY7J8pRdpe1MyV1lIb7g
         tMFTEynJDFoJjiJU2OMY0oQxT5+hZyfqkPuwSbutHorruUGr+32R2/QWCqfh+Y5IejPh
         mMu2UnEARwMbX/3FRP2qmQ1wnBuomuhruDM/HF9lqG+TnFn7OqCE/WcU0KdAA/xdCBB3
         8rSTxPJulFUzTJxl1BAYfRVa3FtpWfdaxPpB478L/Nk28Ktq+ruzSYoibieyaW8bfLH2
         NLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v4liCDh36/+ZyZXBwFufBk0+NwnQDPX73vt+RUacM7I=;
        fh=ueDGRK9tK+zzhInwt7ttsoLJElltjoiOZ3w8TVxdRFY=;
        b=jXchEqdmkKvEIvr+EyHNFJzQmsfHOF698+SHzvBcA4m/ctkrFH8PN5WDCSJoPTSJEz
         wpN27M5wBLC0Jfsqfmu5znmF9zwx8VN2ieIYPF+B6LEQ15v8tLzSHeX5/IazFHPC1Tk+
         FSXunLRFD779GvcX0xo7cEx1ekx1jLZ5NCOnRD5zTzT44IMjMmCqGg9eK8zFnJ7JSf51
         ap9zsxiByfKtgWKdS40Fg7ffK9AigoreEpVjAQJy3ur8Snxer3wk8yN/2slpZmDXVr5+
         KoIwapFxmHCsaO/OD9gndodXPd6FMXI3QV0IekUjae4H5a4CAxO4yL7B8s/dDCWbBZka
         dFAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786236730; x=1786841530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4liCDh36/+ZyZXBwFufBk0+NwnQDPX73vt+RUacM7I=;
        b=IoienVJQMlefOb1bpDXDLa/WMbztK3dHcRq1YHAmMCsGAUlQoewW1SuS5WOi40Cbft
         FxL4lea5Q9TmnyyrY0KJT/3+a+Wr0lHbQQKkvvFDT9CNAG0XgDrrAcR9JZuEBlZZbs2Y
         Qj7wWgRTD8fuOdKTox7J7mcJ9ok9EnVK+hx8RPPPJoAaHx7n5Pq/n+/FlAaJOldh+y8b
         n90Qw8iHtm5N3i2E4rihJxehlS/vS9e+B/PEwqyAcNKqg/zLSiSrgOyT6K8tFEVxcdgY
         SdPmuWe7hFKunkGKU49yYOBYYpxovd8HDpflVn2FUMsq1ISkfkH1F9fKSmBIn2SDv2ug
         64Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786236730; x=1786841530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4liCDh36/+ZyZXBwFufBk0+NwnQDPX73vt+RUacM7I=;
        b=oiVon1NIPo0+mJIY3REw+XZ3rA1P3eqVjjxO4u6602tyoJbolaM9/cSnl6MQaLQ4f6
         AEE/htgeE9pMVU/hNUj5ieguSOgGhqC47YnPbRmHoezoTtbcwxdibvPmr7p9O4izFhkY
         sdk/CbpVDQvMNaKPJAYroS5cmulxBERzWMeHv+9qm7jCmVK00aeOMnKK2Isx+ynW0p1X
         PoX7QU7H9+B9AAl7zSb6gnNRzznWUjjUz0590LZcdrqsQkPnLOrUaL0/k/z8QhSDf1xE
         cXFpEXeZNxSUx5H4iYfityGRduhlToW1zvUQ49A/WHqTm09PrnHENUK6cU3JmLSyc17R
         QqIA==
X-Forwarded-Encrypted: i=1; AHgh+RpMwLMQeXOzHe1Go1wKl7lr4I2Fqos50DbZo33MnpKUsmO3UIoNJOh/QIeGPif322wMEUE7Z1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpfMOnzjyfW6dlN/KtVmNfC+l2RdNeYlHJ7FQWUQGJAhRAhpH
	TU/ByUkYNHM5C0XIKuhjzo+U8gKZfvApgoCYuJqj0g5oUhvTFsBwNM05wRIWS37SruqYM4Iogas
	6T2Bilx3K/uq7J+XSqQY+4/Lwm+9O6bplwNrqWrKr
X-Gm-Gg: AR+sD12+5o+Afa1Dck9DbEva4SfJVY5YYx3N92CtjSHtxJvyeXWZylN6AP7cKHFPN3D
	BEKpLc4+/cTU+h8Uh+H8+YKzYnSyRN/FfVanGdFzW0CZYUW8Rkn8mwmlo9h6+zveelja6VYvyD4
	sAlwbijavomRSwe0rfp73skOEgjBCw837ESxUXWUg1E6GWsesdNVOUjJubcYaHyFU4Cn2vWNA+X
	bjweBtV2NE3YgXuiiEsSFeNgOTEk5AyR0QrS/i+qppruFh72Exznkzh9AT2dgWD53+FegLo/3ss
	LSVA1PQCbeK3VcnZFeBryQhE4JawsaGBz/Io0koV8dkspl50kqOkR24=
X-Received: by 2002:a05:622a:1f12:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-52d2810403cmr12830401cf.5.1786236729475; Sat, 08 Aug 2026
 17:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-6-surenb@google.com>
 <anbaJuYXEoldvtPn@casper.infradead.org>
In-Reply-To: <anbaJuYXEoldvtPn@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 17:51:58 -0700
X-Gm-Features: AUfX_mz0H2dhrc0_RWDLxxG1OQBtlVHwDKim8LfHEsvh69mmXopyqhXcVVjfQFo
Message-ID: <CAJuCfpHh1E34LVTd=4y8m+2ugGABc3MSU2Z5N4pFY4ttH0a5Rw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] tcp: Remove mmap_lock fallback path
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 12:26=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Aug 06, 2026 at 01:05:48PM -0700, Suren Baghdasaryan wrote:
> > Previously, the per-VMA locking could fail in the face of writers
> > which necessitates a fallback to mmap_lock. The new
> > lock_vma_under_rcu_wait() will wait for writers instead of failing.
>
> It's not called that any more ...

Ack. Will fix. It's obvious that I took over someone else's patch, isn't it=
? :)

>
