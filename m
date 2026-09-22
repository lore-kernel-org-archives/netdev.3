Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B94FC8C5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077265; cv=pass; b=awPR5iQKHpA38Z2KMJ8k3N5ugGZeKkKFAU4Xvq0Mh/GLtNeNaE0zmcca3AK+3yysZ5ZoV1YBb71xPNOHeiOsdi5nulzeYYnA3X/z/PuyxO5JfvkQAwyBumz2kYtACQh7CWsBEx28NvocHLxM+vo7ayaZWfniiE+lIgPSBR7m5bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077265; c=relaxed/simple;
	bh=/ryYG5lazy/FnTpqsjI+Cn7OKcdA69vMuSjalV5Eh2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfxaJPv01NfDrNNpMR+cG/qgAcIb61yC9CEgiepE1GmTXYT6IE/HBiliNGiTab/A1+W1czRr9F1J+QKZ0UzaHx/dOi0E1fFxrX1L2/losVnmVxAtzqrL5PXjwRHbXWJmNCMZXAHp/FRdlnI0rYa1Mw8BJ0UJxDn+qTkBWP3lCXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=teZVmxNF; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="teZVmxNF"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5306abbdccbso7997191cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790077255; cv=none;
        d=google.com; s=arc-20260327;
        b=krUSDMxQyrGqu7oatjsaifBBHEG1mDOURPOzXXHN5hficIFg0rjg3wNCm3AYAtI3ur
         3XAg8FSBiPBvR7QytiIX28D+qnKrXWV9QRjG/46WV9c2BnIrfn1GqBo55Ta+DQc4ck/Q
         5PG9CvTnWqsweSe5igANOw2HHSOSnzzeGjoHw7w3w5vYVAmAkLrnNDAafuSR3QWQG545
         1v2LPtz/0029ouCnr5R3nIeigVqnvbbhQgBYjOCRFX+f1Ppk8ADptH8hYnosEBc2VrMa
         esgS8YBeDkFnEMqHdCOgu5CWFF8xjD0g0C579kMJkZFk1UGLX245ASveDIutjZysWhcB
         nsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rBi34CnPYrfUUL8/tcijf8OZXx9Oll6imJZpaeVqRH8=;
        fh=Sl1HNWKfg7GZIOmfAoZYIyXznEq3DIxVq5ERy0Blz44=;
        b=sBQWxfGyvmSrEQO+yYdqisAK4MdWJJAJR8nPYRRYo4BanextleXqmOOn4n9nXb235S
         zqUuCxOrfXglzXrKa/5isKU6ct1dKJsx/CduiurrDjOvKKcia0AcIHvndSEhGi6oBgoo
         RzshKgMh26v4YtM0QputrNOPD53DL/sPq/TrPJmwooWAB+XUQZREagAJu79xr7GclHU7
         JuGp3q0RGFRE9JYL6E5p5HCgKcgO4uKmaRnDO3FV835PjmfSE82Be2RILinc/XZjhSFT
         W+R5ekZOV+Ko25MTxbI6bn9XXDR6kLOdNx+ncsLBSWVynqZcNOGQma3mKT1mOb3VLrLf
         wN4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790077255; x=1790682055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBi34CnPYrfUUL8/tcijf8OZXx9Oll6imJZpaeVqRH8=;
        b=teZVmxNF8keJCBU552TKfiwGgfe7OrpESHl63tNEWV35ydVNlKhIo3HJmTmOneKCnb
         g3Wxh+JgxmNqrnjpmFln1WfS+WQlA2mK76pXBV2S29KtT7vXsYh1JfzUFcHZTE6TGAPp
         kI3SDSVmTnEBei8HIA9t+bnXu6ZcroxPOS655AoTkjvzMoMYB1lyO0fOFI3jjUH5a7h+
         dQLHUnuY0+Alb6ZQDzTLMmNglCGgITQsRetW78M/Jh9K0Atx4DbaU9LUpfA8nbwLyIFH
         /N25lJgMgzO+ZoVtESXP1l/RJnXiCPZglyr1bi2tweYtnO+VRa/rgfHSpZv9LFlblsIw
         tc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077255; x=1790682055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBi34CnPYrfUUL8/tcijf8OZXx9Oll6imJZpaeVqRH8=;
        b=FUxyVpswhVfCZzMApmhEwnTSqWgW7BaeDudG1F6gOwVXxHo4SO+X9bvm9XmmNR8hFx
         h8Sq7iZyPpjJjJ7doNs2Eiwc4NgKwWgv+R65Tuvi4pF+4X9LL0HxLtGvQVYMH9KwPUVW
         OE/YERQ1C8casdotgHOqCBvaJkXMUeSKG8JyIYvZGNq5KUDDWVEvNzdrBf72wu3bsJUc
         fGmsPUIqXL+dkqTjPer48QG7442vT8CnTukGeto0dBsU9GrzHrs6WrJSipjlilm8B9q4
         s6YE+/yzwM8bqV7M+yP4HwivjzNHqUkfGxE4oiWSG4gOunuf1MChY52Dc5Uz9NMxAyDh
         VkcA==
X-Gm-Message-State: AFuF++nFTe6FcnsTJLUszPR33jXCGfBzUGEsyrSxz7G5uSgaJYv2Hs5Q
	340Ihs553XrdcdZzmsujFYLtFTPhDOWT/l1qk49TMvEDwDc4Yo3eZbiW3v1xJSWAz9pzpaHLF9U
	8X2YnarqQnY8ZBXVhBw+bj3glM2zrmIuEn4kJBe5w
X-Gm-Gg: AYBFou11+vqXn9i1zEzeHUG3ID3kIkpqwdkRbXqniNwmVlEA0VbjS2QYMTPtLoeDOj5
	xtbn6H86foN7lovtRTqDm12Qq/lVuKjpw5CGTBNgPnsa9ba8PUipF6Np/hPaam12iv+nL9DUnuc
	GFh7z1iYTVIqmlUq8QSkJ8TDH1beUJV/yLPHu/bld0Y1OGgM7SfqGaoDcD45QcJm3Doobb6LLtA
	8NBlo7V2C69zZT1XkmBzh3teNaDe4zv9DJv/O5F4c1LmBJ12A33PiZu2KxcD0krUdpPwAeYKeXD
	KLluA74V0Mll4IDUNZ0lPbQQQa9NnbxoxR04vQqoTnWOFZfoRk0AkUzjmYX+C6yhUzaGnpehvmQ
	NILQRGJiuk5EMHL9Tn+ozje99EMYI2V5GiHu/mwI3lme9XIBAzK9L1G8nhLIrd8lScHs0Jt5eZa
	TSqI1j
X-Received: by 2002:a05:622a:181f:b0:531:1dcc:1a59 with SMTP id
 d75a77b69052e-532db759fa1mr40791891cf.4.1790077253895; Tue, 22 Sep 2026
 04:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789987105.git.petalzu987@gmail.com> <5002123a7fd47989926bcefe4d5bdeb824f40b63.1789987105.git.petalzu987@gmail.com>
In-Reply-To: <5002123a7fd47989926bcefe4d5bdeb824f40b63.1789987105.git.petalzu987@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 13:40:41 +0200
X-Gm-Features: AcwNN1V-MUQ7g0-caVSmHi9B0vEFZV1hYtP-m2HdXe8t6RUtJliBZ9qo5ZorvsA
Message-ID: <CANn89iLw11+wsqgqexWeUbC6xuCArORwT-msmPBhxZ62F5taKg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] llc: reserve device headroom for allocated frames
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, tim.bird@sony.com, opurdila@ixiacom.com, 
	vega@nebusec.ai, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:42=E2=80=AFAM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Zixuan Chai <petalzu987@gmail.com>
>
> llc_alloc_frame() reserves link-layer headroom using the device type.
> This is insufficient for stacked Ethernet devices such as VLAN devices,
> where vlan_dev_hard_header() pushes a VLAN header before the lower
> device's Ethernet header. An LLC response on such a device can
> therefore underflow skb headroom in eth_header().
>
> Use LL_RESERVED_SPACE() to account for the device's actual required
> headroom while preserving the existing reservation for the LLC header.
>
> Fixes: bf9ae5386bca ("llc: use dev_hard_header")
> Cc: stable@vger.kernel.org
> Reported-by: VEGA <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  net/llc/llc_sap.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
> index 1bd446a21092..4b203ffb1e83 100644
> --- a/net/llc/llc_sap.c
> +++ b/net/llc/llc_sap.c
> @@ -19,16 +19,6 @@
>  #include <linux/llc.h>
>  #include <linux/slab.h>
>
> -static int llc_mac_header_len(unsigned short devtype)
> -{
> -       switch (devtype) {
> -       case ARPHRD_ETHER:
> -       case ARPHRD_LOOPBACK:
> -               return sizeof(struct ethhdr);
> -       }
> -       return 0;
> -}
> -
>  /**
>   *     llc_alloc_frame - allocates sk_buff for frame
>   *     @sk:  socket to allocate frame to
> @@ -45,7 +35,7 @@ struct sk_buff *llc_alloc_frame(struct sock *sk, struct=
 net_device *dev,
>         int hlen =3D type =3D=3D LLC_PDU_TYPE_U ? 3 : 4;
>         struct sk_buff *skb;
>
> -       hlen +=3D llc_mac_header_len(dev->type);
> +       hlen +=3D LL_RESERVED_SPACE(dev);
>         skb =3D alloc_skb(hlen + data_size, GFP_ATOMIC);

Reviewed-by: Eric Dumazet <edumazet@google.com>

Ok, please note:

1. LLC only supports ARPHRD_ETHER and ARPHRD_LOOPBACK (see llc_mac_hdr_init=
(),
   llc_ui_bind(), llc_rcv(), etc.), so there is no reason to pretend LLC
   handles arbitrary device types. Replacing ETH_HLEN with
   LL_RESERVED_SPACE(dev) while keeping the ARPHRD_ETHER / ARPHRD_LOOPBACK
   check is fine.

2. Reserving LL_RESERVED_SPACE(dev) at allocation time in llc_alloc_frame()
   is still not sufficient to prevent skb_under_panic():
   - Other callers of llc_mac_hdr_init(), such as br_send_bpdu() in
     net/bridge/br_stp_bpdu.c, do not use llc_alloc_frame() and only reserv=
e
     LLC_RESERVE.
   - More importantly, device headroom requirements can change dynamically
     between skb allocation and dev_hard_header() (for instance when toggli=
ng
     VLAN_FLAG_REORDER_HDR, or when bonding/team devices switch slaves/devi=
ce
     types on the fly while frames are queued or in flight).

I am sending a patch against vlan_dev_hard_header() in a separate patch

https://lore.kernel.org/netdev/20260922113924.3165190-1-edumazet@google.com=
/
