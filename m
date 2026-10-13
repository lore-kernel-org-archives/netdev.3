Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59247A878
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888217; cv=pass; b=DuYUu7IzqnpEZqBeCsAoBn+7qvKv5Y2S6+MHFa0khxIv6Cr+KnFv+J/0UAeqcTGD/p3BrgNu7y2YFTkYPeSvHsZ94GiA201TRG0Yta7bA59IZwvsrv8uIT/jPzXhPBnevr9Dsh9mlbfEZHitKwnIwwnR02nwXWjrtZTIJJJCsW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888217; c=relaxed/simple;
	bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWlwyGdxNaBWFBha9kh2vXATftFzqatusOO/p9Z7vOgludIax9eBBzlOTjGyfM7mVl6H42YEDINDUMPjA0IbGKrdNjP3rgvt6U9gmOOFDrkrlMJ7fi22EFNj3nuMOu8+Sm3pJc+A8fTGym6dLX1mVVYd3VaVRbxRk4ojfQhQnj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9JKuDu0; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9JKuDu0"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e38b61974so47315466b.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888213; cv=none;
        d=google.com; s=arc-20260327;
        b=C/+KXUgF+Bq4+7sgpkQWjWsyWyfOrfmdCzEzKqqsq3xc446ApV3PnUb2I/CKcmaW6u
         fnK9RroYUF99s16J/oUF1PoNI1BpXCE2VNeg1A+6vTIS1Ss4rI21yrzHZJbfBkqm8M8H
         ua2tC1yRiBeqSOAtyBMl5YcOFfPYl9V6vWzg2NLTaqMX4og0QdmJZCQR5vlcvn3TgQ5W
         TT74fWqa1cxo1ZSBtGwb3ekKV6ral+uWADjVbgFphM5u94K2krRIaFxe6nr+meDMSDuO
         X5KaJa3fdlZiBQdHcfcSmhq8uTT7wP70JZA7HoCV8YF3wRavoIHXGpndT/7PROtVt1ZD
         ZFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
        fh=5V2F8FAZDUfsp3jjD3miYwXhZR++5fhT6TNIj8iunxY=;
        b=N89/al5aS4Rbf1dndRG+Nd+DuT6pBEbmG8vj3AYuKqjtvnZPIEDmzfn2Ulnlc59pYg
         5rYbLtUCWghL5WtjK6ciDS935iMe6sDZQtqHPxG6n13rCrvV50XgilnGXH/nOO563cq1
         fJWfhHrgM3OJwu128gUQ07gx7NBO4KAfaNy6oH6iPXwOTj5FzxZZI1vGkVQuCjsdJXc1
         CvL5ba6uwMRltkY63XxCfSdZHJw3akBiXiBSX+7ewTFGAQuJchppckrr09INo12LKl3R
         A3oF6UHVobDULKzHCh4o7aZhtvCuPyYHhPvWuZg/1p5OKgWR3eHjPtQhjw4bpaxWBJXn
         GgjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888213; x=1792493013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
        b=a9JKuDu0SiivLt+mLksbpd/cL0Ix5TymRLUpuuGfUMEF53taMb/ZGXnzUGm3EPCzLh
         3ZcgW1dw21t+Yur5pA/4H1mOqZNN9Q+rO7gM1DHbah6Upn7tfQeMfFnGVAjbcml4yDDx
         4m2lcvDwoc1VSxlu9/Us/xe/9Dt9ayL6T73pjFOLpnhkDj54DRiODTl0Eu4CPJi01jmj
         GpKp/VM9PNc/7l7cNhPau8fK2oaM7/D6DlEF4wfcSyaymbklitcuzhtw1/poKktPEMgZ
         AswDf97ldxvngcq5kcwMHe500hhGvnP9Q0pVS1NbKQETfE6Ox+dnXinZth16C1WtCJoX
         MelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888213; x=1792493013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
        b=XNMFpzpDe4f7AQKbrAeljrr9K3j8zhap7S/TQJt6a73JuutKnD8fs3yhSAllaK761e
         Kb51z+VP4GHBYexJ54J/rU2tSVRQK9Oi2+bZbOs9FkdG5jMBt3wPsDF4t/DFm3KSMqJE
         2pyslyWFPV7ulT6yLGxt1SswBkONss3RM6x90cvzXKTe24yAXUkU/nueZUxXMIdTxqWy
         A3tn9P2nU+LGYs6HMrNZXFE0JWCg3u0q/FNHM/9QrK1xlsc9EW5C+NZjYEx0hJLpp49t
         oJufURSr67o+5imvMEbJErnmOykS7NrU98RUeCafsa5EWLETWOKHggvahMqFThPRhOVw
         e2YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPaf8CTLo9am2gafEPXgit37SRpLCg3WNRyO7eU8zzpf0QU6n/ylLPDdiLVCM2k7R0WsonHhc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBYfbk1+hXhocWVDmD2s+e1ilqR9G13WXCm/r3y9dp8nPcO42C
	cDIW8W75ps7oktV51Yv6wcaJ/l3xBnzbWDvQXFZlE/gvtTQsPrJbSFsu/zusUiA0ZUwcBgDgq1l
	EibY4/tzvG3uh4XxtRqeGbbYF+oHodkc=
X-Gm-Gg: AYBFou170OWNc69zy0ladNRvJI7u9p578Qd7tbNWoEOPDy2/EbIiYMMTUB765b0YOHE
	c3g8oxEhKAHlzWjXhz6RVnecRDNG6geafUUJc/Ty5WUGDDIgYtHVUgg3SoVCn0PJv7aIUh2eNOi
	rYxgivdvz5i4+GhzKhK2dUa2zzya5fSYoHJx01Weqy1tuw7TntLM6qwCEvIbr9KIqDABBPIGUb7
	l7/5L2lW317IqYthZcBvkzG3QrZ/abzDyhIqZmnZX03YzXEJMISljY6VQ3kCSB+8hMij6ZKuQLO
	rWYkRC/yl0ZgrRNGuB51fB5TlMLXRCoXz/WqpmdCHmiQ7RTf23m4W2XmHwKqZVP5zuEG1VcS5JP
	N8Sc67mKn
X-Received: by 2002:a17:907:3cc4:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c31a96e7a46mr1286808066b.0.1791888213256; Tue, 13 Oct 2026
 03:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
 <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com> <CAAo+4rUG_Y_d28bLbQdcmHY5-vtBrhV+D6rzbd3Mb6B3iTSuHQ@mail.gmail.com>
In-Reply-To: <CAAo+4rUG_Y_d28bLbQdcmHY5-vtBrhV+D6rzbd3Mb6B3iTSuHQ@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 13 Oct 2026 18:43:21 +0800
X-Gm-Features: AclHuK9kgucNW_X-CmFkUz3aZTCU9FnPnXOeZBb7AYpPKDF7GSiLOX-F6v5amrQ
Message-ID: <CAAo+4rV1zx_U6Er8eDE0JW2f6jBXY6gmhnncXKvycn98ZjXG9Q@mail.gmail.com>
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Qi Zhang <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:55=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> On Tue, Aug 25, 2026 at 6:45=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > Side note: returning the RCU protected ptr outside the RCU read lock
> > safe, as the caller never deference it, but quite confusing.
> >
> > It would be nice to follow-up on net-next replacing the return type her=
e
> > with a bool.
> >
> > /P
> >
>
> No problem, the follow-up patch is just sent.
>
> Best Regards,
> Chengfeng

Hi Paolo and Eric,

A gentle ping on this fix, which is still marked Deferred.

The requested bool follow-up has been applied to net-next as
2a5043c8b7d0 (https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git/commit/?id=3D2a5043c8b7d09f2fc76c19270fd687b774c5a68b),
but the RCU lifetime fix remains outstanding.

I rechecked this original patch against net/main at 8bf659bd54e1: it
still applies cleanly.

Best regards,
Chengfeng
