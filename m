Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736939479E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210698; cv=pass; b=eHTG5Hh2xKJH9Bu0zdiGe6HdUBT0mWSXleWHB/TEf9kEJKZOkB5nM/24MG9geZ4BgNNHmsvfF7UC4Hnj3jMQLRgchj929C8YvATVa9+USkxziKD9JVMsN0qnxSy4/S3gatxfZcXFuBu1/6Ovr4qFyhvgUFGGs3ho+zJqdVMxkHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210698; c=relaxed/simple;
	bh=QbhyJfg/WXDqs87zXKRLV7LyYRBmE5mekdLgnDf84Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odEhG+vQQF4EGHOaQJnIX/aePU4iAi4lDVaBgE5Vw8EGjHFAVF7F/1/dyJy4Qa3VOeEaPfU9nZ5KEOw2/DNGo+mLxkKPlhvlIaiTzbtvJycgsqhJHjK4u03v9kt7jQXpV8pYu7z4tafLsPofNv/hCzJBHV4k7BGTzxvQb82MKcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gh2iHqgg; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gh2iHqgg"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177d1ff061so42261cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781210696; cv=none;
        d=google.com; s=arc-20240605;
        b=N6OUt3aoQyNB9ncemyC9qK5pwcc1iqimXX6owQSaMDkMvnMwGOLxccHSgNa4m9o5ds
         WUS8ac/j/V77CddtsJUvAVnFRY3PrW7NcNgtt0oiyRUVbukflUrZqJJD6G3t/aFr/Q4/
         /o9BE30NIAXNr0zPGcn+qfJQzRImvw4rzjXRoa0wk8Ksid0ZRzwVYhm58A7vmz8kSg3o
         FMHyX10KAybIory4P6XldQAQ8G0jguNColpJY7Drw291hEZo9Ki64WLrtUI98zI7B+n3
         SWMS7kOQ+i8Hkw4jbXAlYEx0RQQWGs2mScdyytIJct++kLevqP5Tk6efCPob2PPdFUJO
         tPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R25VakW0RBUev3UiF4u6b7DOEi2czhIVwldQzjdZNDA=;
        fh=A7uaRJKcCp5mKuis2ziuPXIggU7pVFWh/KYBJKaJ8cA=;
        b=hoXSpZrSGToM0zajuSbp5NYDPqPDPak5AZGvPhGoc2I/pctwnAw2HX9HBE46QJu0/e
         dolpMj9avZkoA3mIVBgAw9oxpEThieRjh8MjXpMXtCVxhxwKXgMHdpGL/lXRO67iVu2c
         hUKuH3ym5Alx+C+1p6Axqx2AOsuLdIbxIkRySC+imqKksG6JZi/WML2Qtd/TfaWlB4hI
         ysTq8lXRaqfllVpxPER3K4wrDCJE4MgF5ndA8TPo3Qx7HNohRD+FYQaqQNHg30dCNn4x
         0O08+uJoDFMM3qWJH6w+j2R/ZaJlIrfk40YjIlKPbKIirbl14u18j6RuhXr7eJQxDHvW
         JBBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210696; x=1781815496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R25VakW0RBUev3UiF4u6b7DOEi2czhIVwldQzjdZNDA=;
        b=gh2iHqggdlqHu0HeCPgxJNv7BFiMnhY6a6jeEC8czqVQ7yuC8bc1b8I4OwYjzdbsrF
         K1OlGNPZ/fKLUjjT39+KI5X9ACChKkpvq3pCPdaaRE/qwvQjKeneexazeFm4tMPZ9P69
         wYOrf4oxjB+JGPeaZEAXlqoYj0KwYDUGoD4Eq+8SRBbYlB99jJJTH1pLj59Z/Ost+87Y
         rP//j9ek+fRSHYoGzarSg+eADU24cTqhWjUhEuP0s1BWZ+Qou0SDpkXLtqMM5pe9OWL1
         jYq5LL6LqY8nzSH6zC3AElp+sTOUOK9v9DR6w72uC00pplkjNeuzvOTtaCKXnBsE6w8r
         Iatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210696; x=1781815496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R25VakW0RBUev3UiF4u6b7DOEi2czhIVwldQzjdZNDA=;
        b=cPTVbcv7Hp8BSJl0yBJM8lG77CldNbq8y6cX8L7ZQgx/ev+OXJ29u+7s5X9c4hCXTL
         fiFXpqZtdd1AFd4MQCF85AF7q/sqdUh+fwIs/2d8+xw0w3s6k9Wa8MZYRW7T5UOpL3C+
         TTuwplMuZdV+4ra7LaXJdYtrAhXqUjzABXlFiYQMH1AHQx+HcPjokdAkwQL5IAzBLp9y
         Pppp0xDZja6vtpT/2iDKm6/MfAYmZBy/hKIlUe6X8gDjc2rJBIrErZsdKlkMr+Ef/Fc8
         DDYwsb3cIW5Q5Kf7SSbzit4ZzXAq1trr2BiEO77q3Jc/TjcTiYTDbPvqwL6CPpYhhFXy
         Adbw==
X-Forwarded-Encrypted: i=1; AFNElJ/6KeO144hurA8fWQB5MbY2qOymexQv7rPBhWxMgYcMmjiKF17J94jWRlX/m/LUFmm7p4E9e2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqNCkgOg2forTIHMb1TJvKHeGnoolbNstVde/G4wNV1gwnSyB
	x9wtHrsk8LZRCX/mrFAQqC6R/8SYLV5FnBghJAZf10fPY5UEoP2+hNJ5YuWGBcAjJ7YDjxG9zMd
	XFpui0GL8B/BjifYDBCQxJ00v9qAzswaCSIFgcrUJ
X-Gm-Gg: Acq92OFpbTPLfKLW8gnbjeumCx7sCkMSGlUWrJKX27yIETe428V2zXWerAE5eD0doIA
	hwRftkifXmaFofoqtUvgqGwwaWkLIwnYrse22/YcH4nrI5QKCtH4CDfjWmdHbhdeOpdwC7jtYIH
	gmyDNOaZsDvxlrtQi5yqFgFURrvBm86JLfjUkyAHbjrjACcr4vv1mP7sVNRIKP+/QnRxFyAzOAh
	wbYGjROjzgzxb18Lly6rD2EnpiOBjUZO1PjcbwZJ6K37QCokODpFsasMTww7LBPEvZJb1scVDap
	L+nPoSnhqQfEBvBpQFog16w9o3ZEBlKPUkarI9YqjOHtG8Q=
X-Received: by 2002:ac8:5ccc:0:b0:517:99ea:ab79 with SMTP id
 d75a77b69052e-517fc55fcb0mr654001cf.25.1781210695733; Thu, 11 Jun 2026
 13:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230419.F746395F@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230419.F746395F@davehans-spike.ostc.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jun 2026 13:44:44 -0700
X-Gm-Features: AVVi8Ce6L-9b-YJ4eJTdZgAldSAMooh3Z7_4xrsEdTCFqBgSe6VDwSOKn0GixX0
Message-ID: <CAJuCfpHhTnJRoQJ_V5qLbeccKL6wKWy1z9Ri6aVkrhxir3i8pg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tcp: Remove mmap_lock fallback path
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:04=E2=80=AFPM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Previously, the per-VMA locking could fail in the face of writers
> which necessitates a fallback to mmap_lock. The new
> lock_vma_under_rcu_wait() will wait for writers instead of failing.
>
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
>
> This really is a nice cleanup. It removes the need to pass the lock
> state back and forth to find_tcp_vma().

LGTM. As in the previous patch, you already have my Reviewed-by.

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>
>  b/net/ipv4/tcp.c |   31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff -puN net/ipv4/tcp.c~ipv4-tcp-vma-waiter net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c~ipv4-tcp-vma-waiter        2026-06-10 15:57:56.97247=
2379 -0700
> +++ b/net/ipv4/tcp.c    2026-06-10 15:57:56.976472521 -0700
> @@ -2171,27 +2171,18 @@ static void tcp_zc_finalize_rx_tstamp(st
>  }
>
>  static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> -                                          unsigned long address,
> -                                          bool *mmap_locked)
> +                                          unsigned long address)
>  {
> -       struct vm_area_struct *vma =3D lock_vma_under_rcu(mm, address);
> +       struct vm_area_struct *vma =3D vma_start_read_unlocked(mm, addres=
s);
>
> -       if (vma) {
> -               if (vma->vm_ops !=3D &tcp_vm_ops) {
> -                       vma_end_read(vma);
> -                       return NULL;
> -               }
> -               *mmap_locked =3D false;
> -               return vma;
> -       }
> +       if (!vma)
> +               return NULL;
>
> -       mmap_read_lock(mm);
> -       vma =3D vma_lookup(mm, address);
> -       if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
> -               mmap_read_unlock(mm);
> +       if (vma->vm_ops !=3D &tcp_vm_ops) {
> +               vma_end_read(vma);
>                 return NULL;
>         }
> -       *mmap_locked =3D true;
> +
>         return vma;
>  }
>
> @@ -2212,7 +2203,6 @@ static int tcp_zerocopy_receive(struct s
>         u32 seq =3D tp->copied_seq;
>         u32 total_bytes_to_map;
>         int inq =3D tcp_inq(sk);
> -       bool mmap_locked;
>         int ret;
>
>         zc->copybuf_len =3D 0;
> @@ -2237,7 +2227,7 @@ static int tcp_zerocopy_receive(struct s
>                 return 0;
>         }
>
> -       vma =3D find_tcp_vma(current->mm, address, &mmap_locked);
> +       vma =3D find_tcp_vma(current->mm, address);
>         if (!vma)
>                 return -EINVAL;
>
> @@ -2319,10 +2309,7 @@ static int tcp_zerocopy_receive(struct s
>                                                    zc, total_bytes_to_map=
);
>         }
>  out:
> -       if (mmap_locked)
> -               mmap_read_unlock(current->mm);
> -       else
> -               vma_end_read(vma);
> +       vma_end_read(vma);
>         /* Try to copy straggler data. */
>         if (!ret)
>                 copylen =3D tcp_zc_handle_leftover(zc, sk, skb, &seq, cop=
ybuf_len, tss);
> _
