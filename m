Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653B38AC6A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112832; cv=pass; b=HQiD/KCKOxEiGmixE4FWb/BASVXseajOMQoYXp5K4J5gZ89FkbfDarUvVckVL61nxb/0ksvU5dOXARc1xRpSBesJv8grDuZ5A5AjUb3NO4jaIWFK20Z+4BOA+41SUQukW5Ibr78QSSABSiPShKq/uxNoPxECSKi1BelZQ+sN8zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112832; c=relaxed/simple;
	bh=5ZT+nU5ePSOJIdlnBHHaxRDfRgbVL3I6dkvQIAl0+3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbQlKVMDvBy2woN8dRdeALmenxW6gQdyn94VzYKhbo9yqzinLjttW1Oc9m3nTE8nEFfKxg89ajDZh8z3MviR1LOMgMary1E9LTiyKb3BJyj9Ygi73NUltwDns5mthCaBqDQtffRt+P/jicnFPyfeJ3gm0/rnMPnQzEoR7ODQbDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnganA/L; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnganA/L"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso25559235e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786112827; cv=none;
        d=google.com; s=arc-20260327;
        b=hkRloIUh216C5bhXK7ailX4CFYjfPSf7sT77R00ou7nGAJVqkMNgDoTcSpylVWjplM
         /wIqGNUX7kNhkf7FTt855hTBzCBlbFWXXsbKpoMRuVwevCrevLm1vgP08g4yJwijYgp8
         zedXrPW9eiMRPJ9diqzdR4qwtrGH5r19opfoutuJQ8PUxOJOg+zb+szYAyXJiuc0vjEy
         TLG60+uxOXjwDQDM+b+oCc7Xhq/T1sMNrEXnoG9bcrA+o1oIInpsPwfj9YdVJFlwyw5Y
         7+ARvAR2IMmp5pHZOhJW5P8F3jnr9/SqFGi1mG75xPhZJWgL19N9735QDRvBJ47xVAtx
         x64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZT+nU5ePSOJIdlnBHHaxRDfRgbVL3I6dkvQIAl0+3M=;
        fh=lXX+0rqoHC3CPSOl9foYkC/s8jwIU3Tv6096jNe3WRU=;
        b=nA1Zve3+JVHkGwzlj7N+pMXKYVotu2+9s8mt7jzpBr37wl5eymAyiGLDHrTOrQA+qj
         v2IOvZr4xmilBkAlPXWAQDAK9AiEXY6PblR+qm6w/8li+G8hHMC8QdKgf9i5bEfX5Z0A
         yExDSEiJYRuKMgyHNFObH/eDww8ZxcrvdmSTks2+J2dRm6rqvL+sTVmirBtGN7f78YVc
         xDjPIKk9HU94M7zkahw3Aa0Eye5mZhbmbZIRi8BGejNsx1hnA0YLgEdnq7ApYnX1Nap9
         Ku8BLWhGjJaAQ4jkR8FDv0FSfzybX3ZNA2JU8BwjsxxrKuYqmiBT3J/5ml0r3tu+pliZ
         iKzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786112827; x=1786717627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZT+nU5ePSOJIdlnBHHaxRDfRgbVL3I6dkvQIAl0+3M=;
        b=tnganA/L66WxOVh6g7SlDsAJ7iEloExiuZmP1b2wjK/mTn8gflFLIxPEOKZseB10Ag
         kNinkILNjrEtLYWdLrYEiD+SnSCgrvncwDMGJdKsSAAtvqHNBq7xIxwYJDI0ZWuKn05Z
         Ye1fzXApaoGVNRw1xODIFm04XVz2I1Jav1YnVOyFUOR5Rb+953gCkX3DuB88BiPmd2W3
         Np4uDRwaU+p8x8PVyUZYINWlG2pBh6WHWt7C1pg+EjDVw+TSiDai+Ctt0e3Gub467RDY
         dp6ep/69jUWZ+LB3Eo6hjK7/bSm0fzeLXL9KX5VkSsc0m4ydrPT4FybXqsgly5UXfZui
         3H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112827; x=1786717627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZT+nU5ePSOJIdlnBHHaxRDfRgbVL3I6dkvQIAl0+3M=;
        b=m5jgx8zuRsPRVIGiDEkKtlMF9HgPOUbEYolTJW0+9WEBVLxKJtaFQcBK1puUw+Lkcd
         /BunPFeqtRo2YEkI1UCBvaZI3nU/GdOZCSELGPz0zQEQYwTnWeh2xP1KDWAvR+JAVdNo
         2qxLGpF0fLxzt1mqQ2LdpyzxGSCHDj6jZrFIfwRfKETjFWaUAXnmLhGCEdAi6OQ9hSiB
         1fnKlr8mKY4ARgbN8qI20mZsXfV68rJ1Wj/59IZJtFxHspaUp/TRAMxlNYPAOCatLoYy
         gkGJl29t3PNCAZ1DuhO+6b4XPVrvcO6FapVOfwo0O044hwlCqpSvGkSDA6lbT4KkZobf
         hz8g==
X-Forwarded-Encrypted: i=1; AHgh+RpkuftKSFfBWXP+fn8HN0nki66+yWyXVlPzBcT5oO3/Mo7UKxbdRypCaG/XPlB004/9TYwb5BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLqM449oDFo5OT77+cUTgZ8mnqkRCev/VPJ5s/QEA12Vy92n9
	aRJXxszm6Q3oNXhxQwE71mbjpd9rTtYQDyMXNymSAP/dW8U57POYUrqiMYjAN7s+deyyzZWiqlu
	TxIFvqpn2wHP9uPN2FxOetZThtOaYNy+TF/mCniJt
X-Gm-Gg: AR+sD12WMi2IL1p2i9OVzQ8DWXktDfVuFhGAl+LsC0j8shhj14fpE9me5Bl1wF9ImtB
	EDhoLnfurd2vEjKqO7Rassm/K97hW+Ax0sspBWnsPH0ZEzkvhyIHBA+Mq3nEZCPM9YbuNSbvDUr
	OO/0g3BDYm1re7/VMC9YxDakXuzv8GqurqeqctmfLk5mlhmYwzrF6b6nYvgJWtttwpU906POlCR
	sV0b9snF1O29yUznDRaPcj3TNGnBP0ScjNVzBHpL3v7tgnov9rmSOCh8VdkH+kA6D4fq43l4Vc2
	esb2VeAaOuW0OV3OQLJ6sDmTE2pt8lwx8Im0S/g6jf5N53TGd0RNXuARj9zflPTMjvxVF/P5O3d
	uDY+DO/ZqF2E6DkObABVwRmej5cREZAc=
X-Received: by 2002:a05:600c:48aa:b0:498:ff3:71ed with SMTP id
 5b1f17b1804b1-4994e7e6e99mr211942655e9.17.1786112826205; Fri, 07 Aug 2026
 07:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-3-surenb@google.com>
In-Reply-To: <20260806200548.3124802-3-surenb@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 7 Aug 2026 16:26:54 +0200
X-Gm-Features: AUfX_mwSu3MvMCSzwZwIjnv1yD3ofSuLhSz__pDDowPm-PtIyEmCGX0-kA2AFSw
Message-ID: <CAH5fLghUGQFq-wsQpLDqvAdT1VviWPumCZHBg_qL9eMTh3GNFg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:05=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> it and mmap_read_trylock().
>
> Long Version:
>
> =3D=3D Background =3D=3D
>
> Historically, binder used an mmap_read_trylock() in its shrinker code.
> This ensures that reclaim is not blocked on an mmap_lock. Commit
> 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> support for the per-VMA lock, but left mmap_read_trylock() as a
> fallback.
>
> This was presumably because the per-VMA locking can fail for several
> reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> to mmap_read_trylock().
>
> =3D=3D Problem =3D=3D
>
> The fallback is not worth the complexity here. lock_vma_under_rcu() is
> essentially already a non-blocking trylock. The main reason it fails
> is also the reason mmap_read_trylock() fails: something is holding
> mmap_write_lock().
>
> The only remedy for a collision with mmap_write_lock() is to wait,
> which this code can not do. So the "fallback" after
> lock_vma_under_rcu() failure is not really a fallback: it is really
> likely to just be retrying in vain. That retry in an of itself isn't
> horrible. But it adds complexity.
>
> =3D=3D Solution =3D=3D
>
> Now that per-VMA locks are universally available, lock_vma_under_rcu()
> will not persistently fail. Rely on it alone and simplify the code.
> The removal of the fallback does not affect NOMMU case because binder
> driver depends on CONFIG_MMU.
>
> Full disclosure: I originally tried to do this with
> lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> trylock semantics. Claude caught this in a review and suggested the
> approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> I guess.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
