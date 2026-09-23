Received: from mail-dl2-f32.google.com (mail-dl2-f32.google.com [74.125.229.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE547ACD0
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200470; cv=pass; b=gzYOOQEwIfiF7MNE0/Qt36qmaIbGQfGmvONEe4tuh5mC6iMZrmk06yCqYOxRK80vJO5RuK5z0Bif5LnjtBKFtKm9FlFylHfX94+Ku6ctrWQRvjucF6guMTHRdGy/xBYQqbdybGDgXKcXZlpuFcBKRJvXzEYQ33Ec6Qw35xxgyzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200470; c=relaxed/simple;
	bh=MFbEVlnRfRiFMctatpBv0XeXvNst+nu8bC1BDPtol4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANWOMxrvdwxaX9gxtYCRX2MlsEv7oHRCeyQAhEXvIfg4npDWOb+7UxSZM7W4h5vinpAVZg7SBz+7ez2KD7ycErwjDnAeNdzUVyGcQvIMwWfI+Six7fqO93XindtAJVZtRKpWgPOKPYvVo2/BVcbfQgFhGWxjTZEHaWmDTdTd/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYxrNcXZ; arc=pass smtp.client-ip=74.125.229.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYxrNcXZ"
Received: by mail-dl2-f32.google.com with SMTP id a92af1059eb24-1437b77c274so884553c88.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200468; cv=none;
        d=google.com; s=arc-20260327;
        b=KzQ3TiORFGOzS090SCkwOsJfnyewk5CHLeJo7oX50IER2XkNgpizavaPha5l0vI/H1
         KKo4T4roYSCY9kzMqLf1APffvYeEi2j/jNQKg52UA/qiNcXy06PZFkavpDHo5dNbn10A
         TuAnA99UGmcd/u1XhBwUs9KpUVt9pWOtz6AW/WhbN7BDSP+dbfHRNcnMq5yN7KV+/kp2
         6u6riz/HO4eQCLDre9FEOAcytVFEb/OzMiuLVVQK5GEqF/wFoUXlcUscuqHFtfNEhM8+
         BE+l5kXveqjfhA/BZjM6PXXaBAMsa1H/3e3y6JRAPQsYjYP4KFcKm9HdQT3TaPnchvAO
         Q27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFbEVlnRfRiFMctatpBv0XeXvNst+nu8bC1BDPtol4c=;
        fh=VcjIXkBVjegLQytFoeTjBY/kKR96r8NYTTIzj64TFE4=;
        b=BPY0r1lEhM3SUyScZduVrrp8OQRQqGLL1gAGzh/igPYDz9Wpvn7Tw+mDrphN4/LQ90
         T5RSf/J0XyjiJMasH6MXSfFFPvi7K4uu4QKHB5Se3F5EQhywXbsqE/VwA1iAcHwBJkys
         h2cBP5K1RnZGkisP9FptWNiI7+tJ55VUKe+WdDEQxgRj/kB7KWIT4UWuWNMlt/xhzO/6
         rRp7mGeVtYxhjqUr7KnOMwmM3JIRzwdi0RUFpjxKqgeQp+FSBbmP1QJ7GphHgMUiwDIo
         d344a6Npnu8PgbcQ5iK8g4Xl3OkTUIj69AzNQWArjKV4pzeNyy8PYdWv3wLS+xwp+mwX
         hWxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200468; x=1790805268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFbEVlnRfRiFMctatpBv0XeXvNst+nu8bC1BDPtol4c=;
        b=XYxrNcXZNxLsbaGb0IGVAN3hpBx7yqWwm8/ocx2lHVOqEa2eJyeviJa8BsdV8NF8Cd
         rVn+UIHqaozrQF2scOjn7bpsHRxjut/ZXx8Qvd5H7YwNdLf5IjsxPYcqDGVRVZNOF6Zd
         FjVCkncLaAm0S71XqFnJKYGUerVeLNUaBy+f08sot1L56lv21v+rtYswBsgNdeo0l2fP
         YNyvOc8pGzkkYRb8ALq0DGoUv8lR/l8ycra6ozDVJ/PXfX61ico6V3oS9MnUurZWeyuu
         S3FpNeyJrWceiijGo79TTN1jc3JTVjJCRHV1uOdcOqTDxqDTxquAE1jKV+uUMHoZbKY1
         bsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200468; x=1790805268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFbEVlnRfRiFMctatpBv0XeXvNst+nu8bC1BDPtol4c=;
        b=S+NA+RcgIXOn7z8zE0NkccrRKDX+DKiuYxC7ev277zQnotBW1kKkXZ8M3hoyEM+O71
         s0bDePTRo8/HWNHiNo6buH8xJV3nx6DfcXcXuHsry/CUKjC+vACUbYx2wvc5K1BxQlLz
         HvzyNJwDf564gFND3HpH5ToFwk9qxQkkZUEHwJ4y9e+YJpNFEhv2eW5+jGJvkJWz77kj
         9YEiCcH3fynflKOS4hDTfOYwGUD8j6kQWD2QP8L038vyUVk/8OnRl4WSn9w4uHH7YJwj
         N3tBhkm3oEs+ZqG+PdBsK2w0sDmvm1MATrTDtgVAK83Z9/9PfIOkEP4LhgeJoZCdJ4J/
         WCKg==
X-Forwarded-Encrypted: i=1; AKwUvBwbM66E/9WtoozqD40+S0OZFlakGV0an8+cC6rqi9q7SB2K0cAfiOxUrjNDvdp2LW0mymanfmo=@vger.kernel.org
X-Gm-Message-State: AFuF++k5zhXMqKkYO5/MC6Xa8Y6oFMJAJrmbLlUYRU8JCmnzGd+dDeTj
	96cXGh7WLdllL4cGde7lE3XzxdhJth1CebhvH/zln31FuQfdKivycEMQZVuSTsISmwgfrADlbLo
	P2sspQBBXFatsWLnKOS+83pAUtEUMi96ftjABxpWZ
X-Gm-Gg: AYBFou0iB+xKaVqT0e4DRZ5HQVfZlR9+fJROnZBeT2nIvWmbxCeb/hY87zs6JUMNIER
	3a6RsicxyuiIwM7oHedE7dfsWlVuK0ivAD4ZTxpKPxV7Ena7ipDdrHmaF9AfykqOnVPwGg0dssx
	Dwzxh11H7uPoXjv67BWVMIuKuMHUR1oPrfvb++Ot+4fFSdB11Ze++VDweKFhlDrTVM+4r0rfOLr
	l1Z4B6t1+AD10Jljkhuh6cZ9MIOGlXc6/ABnSl2tBlBRmLJUg6adz71hXTYCLlkEv1GpBzb4E4h
	D+OhXGaAU2m3soprC0Vw475FxHX1tkttg1WxTKi9YR0MPrNsGYzq0NiFpscyOdrl52m4LMt6fIX
	M/DHqdlL9a4999Pf19pQp+9Nppstzd0YMMoDb5qyq4yinLa1wlEhyLBpvinhzBWXcca+RA7XYdO
	aciWbOn9mtp4hVzdJ6/yj1KaKg9iWPeHft
X-Received: by 2002:a05:7022:3f8c:b0:143:2979:c87e with SMTP id
 a92af1059eb24-14503fefaf0mr363153c88.33.1790200466861; Wed, 23 Sep 2026
 14:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-3-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:54:15 -0700
X-Gm-Features: AclHuK9MP6Qel9dv03Aubfz1Hm03F3B2xEZ_18o2AXhFQUoGgDpz1onRx6KsmEA
Message-ID: <CAAVpQUDEUwjjABSG7W6EV8CQXe9y01RAkMo2zdcMOOMFN3UUug@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] net: add sk_set_nospace() and sk_clear_nospace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> SOCK_NOSPACE lives in sk->sk_socket->flags and is manipulated from
> about thirty places in the tree, all of them open coding the
> sk->sk_socket dereference, some with a NULL check, some without,
> and some reaching the struct socket by yet another path.
>
> Add sk_set_nospace() and sk_clear_nospace() helpers and convert all
> the setters and clearers to them, so that "git grep _bit(SOCK_NOSPACE"
> only reports the two helpers and the remaining test_bit() sites.
>
> Callers that had no NULL check are all called from user context with a
> socket attached, so folding the check into the helpers only makes them
> more robust.
>
> No functional change intended.
>
> This is a preparation patch: a following one gives TCP a cheaper
> private copy of this bit, and needs a single choke point to keep it
> in sync.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
