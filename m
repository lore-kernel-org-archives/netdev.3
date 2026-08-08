Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C0175A6C
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169314; cv=pass; b=Ri8eenh5t9StM89w4+2fIynS2Sp9YigBNuqdLZTJOrZgvQDe0YqoAlPQPjDNCakhq1LkprTNeCmRNzP/2jhesXZ+TGTuvlE0Pv4q5eTnCASxmRvaPHvptD9mwL+TigcBb+X0C/rhm9JRooJTwl/b0oI69ZfZRTc+7Fa1QH1C+bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169314; c=relaxed/simple;
	bh=haW1/r4WDOqMlIZ8eZIzmd0QeHTYNGUyyJtPYqOed5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOryTHiVN5K/HO04WlcI+mrzEOoXGqnpFIHyQxC+kp9uqZqBQHmybujQi2RCt9+bdynHrPotp49wIDpxqsGZDHiM9oIXrZgfeUuOoOu9i1q1d/cmeMXf4b2EyFRBCEWMXjbSQItcKoU8U70Hg3ESnd8rizGgo4HpRkNWakURWmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uuy/hhLx; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uuy/hhLx"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c01c79467so77151cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 23:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786169312; cv=none;
        d=google.com; s=arc-20260327;
        b=ftxOBZKzKuWIbvLRFCsEiXutIUzJ72gvBpEgrzWuIGcOQ8ZDcJtVlRzJm9C3/4JEqj
         lBIsE70KJhS+nf7PrpKBaW8x8xhgUA9lIBmmQ/KW6THuuOhGKMxWAxxFXfKixMmWbmBc
         8i1mpVk2VY7RDDvMhkA6xCcfDh0Arr4Ov+utDMUOBnvgYCDK7rB5C8RU4lrWo8yo9hn1
         mRxPUoCJolfQzXA0PbgYPQoj2GAflCFPVegNP40ygdixAFTP/a81b+n/PXtOhvKjKREY
         h+y1rDwB3hBfGvwYFHnOLrihbRpzNxTb7TPNjBz3IWnuL0uuD97basG2C9GXJ2m0ejmL
         Ox4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OgvhkBZQm7TTcdlEFLwBVyKNBJ4AnSDMpFcWHrUMaa0=;
        fh=QnseVf4BvgZ1d6t26jHyTAjKMvwvSulW49af/GnktlA=;
        b=FNl3Ig7F4ssMF9xoi9WZPorUiHebZG2nuxmQeuTgWPGc4mel5l35dDsNAFZxb1MiEg
         rXxo4+oDd7SKWDwO6Rh/fsEYQmcmRyO+Qcq8N/pYQaqavvGwgWnC8vG3cJzHD6Y0gu5N
         tF9UY6I1e00esrUednPNeVkpStC8vgcpSpfzGlIg6r+NjSG2BZuV8XEIMkXTiVWZJJrV
         zzH2DsKEQNbl5o9QLmL8F3651veagrO7XUo6F3NAnJoUSePOyeFdcCK1D5iQmeMqRlYq
         NKbDihc3b+088XYOGI/F5WnLxLKfMm7senvEuqPVAjTNtC4rOoZbinQ0Ojmo5jlYC0WP
         Urnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786169312; x=1786774112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OgvhkBZQm7TTcdlEFLwBVyKNBJ4AnSDMpFcWHrUMaa0=;
        b=Uuy/hhLxxLUB6BnNrlM2dfBuaxkJ6Nz2bz92f+lJ82yDJllQ/pJNPqiql35TGATsrh
         QHRh5dUZgzxZtB6H0kxJ6Qz8ZT7JxWWaFQpdaTm0zYf+nXWAg5F5Bb1TZsjXGkv8bfbD
         ETDAxn8pt1kFMHXSNd+7MJ1oJUrhvjZpTPZi5xLjMGshSbt36j6aNM4BhDR6RYYWcjww
         3b+QSI4SRXyxMDfUac6qYKQywYg+yQqnckix2ZbjzkdQalTrN9910OoCLkBO67QcUZz2
         K/3TaUNj3eZiYH+sHcVXwHD61sqMXOXktUU1AFYHXXQm+nBrXmrvxXzKkCJ3mDlOLM4s
         4F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169312; x=1786774112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgvhkBZQm7TTcdlEFLwBVyKNBJ4AnSDMpFcWHrUMaa0=;
        b=c0SZ9WHj96pTCPm3qdaeYPTYk4HcLEjtw9ktP05sr56vIxqB9Wc37EiME7wib1o7Ir
         VltMZyLOsJjzYbKE8n+Si2/+TSISOGAGbxsrSX0HjY8mBX1pTGwpALE4JqvQuckXIqKL
         99tBI6sAquNdz/mmMBnwzYqFOLkZ2wDBER1EqXXQPJG3G1ynKJM95WfzZClOgKJBnG0V
         Fcr6YKxOeS4ucwVgsYbZLZ+V0+AghjQVDogipASrAwDtB6Y6nxVEWcBOP0UPwMK0o8hW
         TJmr26sKNYLct7gHAleD31IN6GvJPPJI/jSLiAX7r3s/T2VPyaguFo+1xYBl5z324MXd
         FLeg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4hvwvwa/NAQufcNvV9YmaHwv+6J9WU2b9UROPhqb/nU9ZdJ2HHWQ4TrnigNbCTF65qNKoOJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEbyYhLfcnYUV9hhnp0Fmt2LHcCj5V3ZXYWksefhJa3YrAciU
	EJZzyPW4LA7wynSlx56XYWWLOSyxHvYV/SYI50hlSkjUpyN2ZRlBZ+oEArcVZ+J+qvPmeSkFoG+
	k/mq7wuDvqMsXecLAHgGq4+Z3zj5sBWGDRdOpeAVW
X-Gm-Gg: AR+sD11mFt7Hqi/76MUiRBdrzbrKnXXgmVuk6+JohS7SteqGpeTTRxCLW/i4XWx0wK4
	Ea7vybv2/IaOwIhUEr8i+6yWCUuqIRMQK12jVQAX2h2Oa6b9TYJ6RAhL/1Bou3AMRXzo1UPeDcF
	n3gSUHboasOGkuhWv4pVgfZEXZ/+eJMKSHfO5j4VZiwMv5H5FFBb87UyxOg9kr5GGbOYPNpGUOr
	KUoc9rnGmkNa+feCV1R5/dnJ69X6ySsm8YCrYMK1O0Ji35RUoPPNTBRaTyi3GMyBl7R2BN6UoN+
	Yz79HqbnpHEdk+4Fjh++fg7JRVzPBmKABVb/cMq7BbCDrO04iMpvNQ==
X-Received: by 2002:a05:622a:1f12:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-52d2810403cmr4720131cf.5.1786169311027; Fri, 07 Aug 2026
 23:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-2-surenb@google.com>
 <anaCkrk55EQoE2aS@casper.infradead.org>
In-Reply-To: <anaCkrk55EQoE2aS@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 7 Aug 2026 23:08:18 -0700
X-Gm-Features: AUfX_mxLofsrHMU5CIeqh9b3KqMSfU1ajZdARwMWTRjWxwVoustLbA9NbMKVpCI
Message-ID: <CAJuCfpE9n5=FoDm7Dhu2oJ1gK2Ft_pzRCBSLbJBeGK903Fu5ng@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mm: Make per-VMA locks available universally
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:14=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Aug 06, 2026 at 01:05:44PM -0700, Suren Baghdasaryan wrote:
> > +++ b/kernel/bpf/stackmap.c
> > @@ -272,13 +272,8 @@ struct stack_map_vma_lock {
> >  /*
> >   * Acquire a stable read-side reference on the VMA covering @ip.
> >   *
> > - * With CONFIG_PER_VMA_LOCK=3Dy this returns a VMA with its per-VMA re=
ad
> > - * lock held and mmap_lock dropped, so the caller may sleep.
> > - *
> > - * With CONFIG_PER_VMA_LOCK=3Dn it returns a VMA with mmap_lock still
> > - * held; the caller must snapshot any fields it needs and pin vm_file
> > - * with get_file() before stack_map_unlock_vma() drops mmap_lock, as
> > - * the VMA may be split, merged, or freed after that.
> > + * This returns a VMA with its per-VMA read lock held and mmap_lock
> > + * dropped, so the caller may sleep.
>
> I don't know if BPF is compatible with !MMU or not, but the comment
> is inconsistent with the code.  How about:
>
>  * On NOMMU configurations, returns with the mmap_lock held.  If the MMU
>  * is enabled, the per-VMA lock will be held instead.  The lock
>  * should be released with stack_map_unlock_vma() which will release the
>  * appropriate lock.  Once the lock is released, the VMA may be freed.

Good point. I'll update the comment here. Thanks Matthew!

>
> >   * Returns NULL on failure, in which case no lock is held.
> >   */
> > @@ -288,7 +283,6 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock,=
 unsigned long ip)
> >       struct mm_struct *mm =3D lock->mm;
> >       struct vm_area_struct *vma;
> >
> > -     /* noop under !CONFIG_PER_VMA_LOCK */
> >       vma =3D lock_vma_under_rcu(mm, ip);
> >       if (vma) {
> >               lock->vma =3D vma;
> > @@ -308,21 +302,20 @@ stack_map_lock_vma(struct stack_map_vma_lock *loc=
k, unsigned long ip)
> >               return NULL;
> >       }
> >
> > -#ifdef CONFIG_PER_VMA_LOCK
> > +#ifdef CONFIG_MMU
> >       if (!vma_start_read_locked(vma)) {
> >               mmap_read_unlock(mm);
> >               return NULL;
> >       }
> >       mmap_read_unlock(mm);
> >  #endif
> > -
> >       lock->vma =3D vma;
> >       return vma;
> >  }
