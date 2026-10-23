Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792766257;
	b=p6h4g/D0+QPi+h5UiEgbQjRBBWr2qB6jXsRQMF3sSVpG4HYPcxpLFTLqRYqLCbGS8DJB
	 xs6DQE0CPlm6QU0XMioROyG8dm+3PMkC9BTaqxwQxW3mV5dHd7r5AgpVvDc3nHvc9W6YK
	 Oo2FrevekU3Cb74u691HEb38LRdkWjClMBHEYjza6YYk6wgnQpEW66SgwvudQCtzH+ptm
	 v68y1dujKtkKKmIXfBb3giq+u9Y0LLKm2xSlmrSbraSJ5MtmRVktZreDVGjVjMiVETqMg
	 YaMYP7HwXvZPKLniNHvHdND639QpwLWhgPH0z2NfHipFe1poIc/muCqN7cg3L9f4aOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TbyyQ/cVBjURwEkpwzvfBfCIIo+L2tVbdO6SgJnUJTQ=;
	b=ytcqHLiuGuCCoLkQKa84W0WKlqTX87XUoXexfI/k85RKWkIJaM7z5hcw0XpZnJP+gu5a
	 HQqwDJ0f/FHoSnA7CPNkLzKf48d+UaK5PlkcwEYcOQiSZMt6DPS+JwIDdxVAawGdeoPFo
	 ZOqL4efmSDyfHHvEWhfwCo3aYVF6tZhFvMxrQoldBEkLpmShUN1CgW9FLwKs8xI7b68Uv
	 XMzmUncqeYJCzd6KvLN2dQNTGj3uD1eiCq8EKP+wdycVoRxvgniNU3Jy/kBwLFt2ijuWa
	 6gatBl7MrLAMomHj1PP5RwOs/AJSd3JNoNqLjjqZvopgw9hIY9qw4n+gEx20UOzh9xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p3ursIpx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAB606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AAB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p3ursIpx
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso9341a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792766256; cv=none;
        d=google.com; s=arc-20260327;
        b=H5dryrsoaeKc/I8Poxh6Zt6g1pt+6TaYDNAfw9PU3MpymsxD489l0UAJm9MdeLOmgv
         xFsRSQrYojZneL4Dind8aCCjHPsbs2K0W3/SPpYQWpX2AXaeVRmcpHEMZ5r5x/EzrCX7
         yw0N0lPwS2EiaGg1jzw3RsCrEFkYNWLLU8wQYywRj3v9b0B82X2HEWyTRJzTOug7qbVQ
         OQGWvdmsHbBexokxyOUooXJ/SkUiaCZ9fojhflmLvXyMITh8RRYJOM5+h0JzsyU5kgGj
         Km9GTa5BFEY2oFQVWpUyRKXh0xgXqQ3iyGAyX+PaV85cfzdja8DmF8sUwZQIPCXx/ZJ3
         0HWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TbyyQ/cVBjURwEkpwzvfBfCIIo+L2tVbdO6SgJnUJTQ=;
        fh=hHYs2bWYE1ARUjDBcMtpRDZEgd1bgLzTnx6FGPuKLPc=;
        b=T6u4uVpt217pBA6g1Ugsrp4rz1jcha1EF1VRbONOBLFcUkFggUW2BpDMOjA8dVgzgm
         rJTrsXUXsl5mw+4nfPQSsdWhd1tsgatZJv/qPgKbljcWZMaYeIUgFjb3270WenRMZUDY
         kB360LpkK3mfBcFIXB3Lu8olQjIbm6HmY/Y+MlEtE17962n2vVWvA+54L0WU3KqJwqeC
         seS6X7Jqfy1/IkXFD74gmgYG5OQfexlfRj+fL2w02Z6nkFQQA8PMFKqs8GAcUQfOXi/l
         y52m1GQAga5jG8PGnQOEUtSKhGuEz1vaicQqdCL6PEF4+s+OTBdPa63hWGYhvDnQrP7t
         htNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792766256; x=1793371056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TbyyQ/cVBjURwEkpwzvfBfCIIo+L2tVbdO6SgJnUJTQ=;
        b=p3ursIpxyJZDB2tNwn3h9XYnKrcDfE4F0YhY8A7fDALnovncAHM8aWG6K309klyU/m
         qyw3HIRWB3ZyhvozTRXS+rHioJW2Oi1ynfmRgT/ckbl7EULGnH9YTq7hazeqLvMMbumz
         wb6HkNhgET1IRfZDgGxplaD/ghTj3PVXJuEH/U+LB2jQimeRKIo8ItITMowY/GoaCtLV
         reVFc+gAmWXSmEnJkH2oZAVE8cxZFSEokJ67ms9hJizfiCtne0hg0Dw9wWqGVy+ydXnN
         PuRpMilDTK9s/0BrfJzKC+ihqbNs0u0MpzqaOfJZkxF+/kqp2909UjhMR45LiMt/n4xo
         6WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766256; x=1793371056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbyyQ/cVBjURwEkpwzvfBfCIIo+L2tVbdO6SgJnUJTQ=;
        b=FZR0yO0flDbodHVaRIAL4dNyzEtjd84QVbKpr4zBBnJ3hZ6pDVR7K77sdN4ltqH+ew
         JQ2jSb/Bk/wBS1gKWGDqLtXZsbCqLiEmeCGl+JRjLxtGlIJzILBBR9fqjMDLWO99iNsM
         L1Shb3BtfHeiRZN2k0w22P9AdJUX5oGdDLrOSO6+tWxe3mPPzVGccGCk6lmEwZeDBsk0
         hnquhzmLvS6+QRYnaNrh8sM+LCDEbaVVhV9u0R7r6XI6Cu0k2Gr2EtuSzc0W8VuH14KT
         J5xoHsFLSXNWsbhMpKPKDwbQwnhDA3rHoob+uKSeG9GM6RWRfimH2FSTxBZw5kTcX0eh
         3ZHA==
X-Forwarded-Encrypted: i=1; AKwUvBzs17q7KN7mb3cmCQYUQ4pFCuUo+xqfsEZsG1aB7XALyCCyCYdZoNtvy9QZBeEu6TF2TBPFOz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf4SRn7P0EDZSktKUVk/l+VkDhMH672yy9ZVzyVuzetXPUb7h+
	i7/G1YwfokOg28SdbRlL4NIB7vfv+nLcPQWC6Dv21LLA3cLXPCTH3YJMJRGaSFyeaJzUriTRgYn
	6ShdiMj4BDuyP6HbHIXorklzDlnv+ny9eCBxq09mG
X-Gm-Gg: AYBFou0L81WyrrYCntabrwnXukJFZE9pIubZCkk36QDimOj06c3kcAjAoJa2OjfSRMh
	chJcntbxVy0BjMCi9Gh/b8ErEBmwlMAPmKzVSi9NDIMS1dejpthS8LRZykAdBOvDzGT95MbGJ9A
	zKbpP5qS+DSurzPj31NuHyEqGDJJ6X7cb00ct2N4UxvLQeZJGONkEp/v31D/zSao4Zads/P3A3q
	hsAYJJVdI/BpZbto6Vc43vy/jWrvyivssDUmD2lPOTJ2FqSq0ut7liN1Z8VZcW0d56+VcYaoeoJ
	79z0gzllysnMLyGeX20AoS4jGgzU5R92b8xWAqZvFsq47VUEobeSe5WVoa7J9v/yUCmKCrFBXSf
	YIZX8c+L9daxcl1s/vNoWjbjAKHSK3CyK311hvIse2/P4AckXVJ0N2vNWVSL7HH1dBCI=
X-Received: by 2002:aa7:d74a:0:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6b43503ae79mr48860a12.11.1792766255144; Fri, 23 Oct 2026
 07:37:35 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-3-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-3-41dbef50b9f7@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 07:37:23 -0700
X-Gm-Features: AclHuK955ZVILJAXSd5ooCPOgIzdBikAhRIkvruYzZknz6V5xNQiHJHo5To2igs
Message-ID: <CAHS8izOEYnqfNz_57u-JNiEC4OCB8MT5Gvuhi52rXkN6aQ18OQ@mail.gmail.com>
Subject: Re: [PATCH net-next 03/15] net: skbuff: fail checksum validation when
 the skb can't be checksummed
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> __skb_checksum_complete() verifies a received packet with
> skb_checksum(), which returns 0 when the range runs into unreadable
> frags or past the end of the skb.  0 is a valid sum, so it's treated as
> one: it adds skb->csum, the pseudo-header sum, and folds the result.
> With a sum of 0 that's csum_fold(skb->csum), which is 0 whenever the
> pseudo-header sum folds to 0xffff, so a packet whose payload was never
> checksummed is accepted, marked csum_valid, and left with a wrong
> CHECKSUM_COMPLETE value in skb->csum.
>
> __skb_checksum_complete_head() passes skb->csum in as the seed, so a
> failure there folds 0 and the packet fails validation, but only because
> skb_checksum() happened to drop the seed.
>
> Use skb_checksum_full() in both, and report a packet that can't be
> checksummed as having a bad checksum, so callers drop it the way they
> drop any other bad checksum.  Clear csum_valid, and leave skb->csum and
> ip_summed alone, since there's no full packet checksum to store.
>
> Found by the Sashiko AI review of the series that made skb_checksum()
> return 0 for a range past the end of the skb.
>
> Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_=
checksum() and friends")
> Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732=
895b@toxicpanda.com/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/core/skbuff.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 061c61422a38..40d2dd20d47d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3860,9 +3860,17 @@ EXPORT_SYMBOL(skb_crc32c);
>
>  __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
>  {
> +       __wsum csum =3D skb->csum;
>         __sum16 sum;
>
> -       sum =3D csum_fold(skb_checksum(skb, 0, len, skb->csum));
> +       /* If the data can't be checksummed it can't be valid either. */
> +       if (skb_checksum_full(skb, 0, len, &csum)) {
> +               if (!skb_shared(skb))
> +                       skb->csum_valid =3D 0;
> +               return (__force __sum16)1;
> +       }
> +
> +       sum =3D csum_fold(csum);
>         /* See comments in __skb_checksum_complete(). */
>         if (likely(!sum)) {
>                 if (unlikely(skb->ip_summed =3D=3D CHECKSUM_COMPLETE) &&
> @@ -3886,10 +3894,17 @@ EXPORT_SYMBOL(__skb_checksum_complete_head);
>   */
>  __sum16 __skb_checksum_complete(struct sk_buff *skb)
>  {
> -       __wsum csum;
> +       __wsum csum =3D 0;
>         __sum16 sum;
>
> -       csum =3D skb_checksum(skb, 0, skb->len, 0);
> +       /* If the data can't be checksummed it can't be valid either.  Le=
ave
> +        * skb->csum alone, it's not a full packet checksum.
> +        */
> +       if (skb_checksum_full(skb, 0, skb->len, &csum)) {
> +               if (!skb_shared(skb))
> +                       skb->csum_valid =3D 0;
> +               return (__force __sum16)1;
> +       }

I think maybe we need to be careful here which are all the skb flags
that we need to touch to indicate that the checksum failed.

My LLM is recommending:

        if (!skb_shared(skb)) {
            skb->ip_summed =3D CHECKSUM_NONE;
            skb->csum_complete_sw =3D 0;
            skb->csum_valid =3D 0;
        }

Seems ip_summed =3D *_NONE was caught elsewhere, but also maybe
csum_complete_sw=3D0 makes sense.

--=20
Thanks,
Mina
