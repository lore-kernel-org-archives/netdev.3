Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793904827;
	b=1WSzljBFTBXjAHFoMIl9QdOhGOd3gJ/GoBCo3q+jkMXPhXsXwL4mF6NNBj9TW8nJykmM
	 JRC7GMWzdFpJOQv+G9+MiRsQ99nZP4suL8m86mfX9vnaRj/K0L7HKC66a7WKacy2xzTyJ
	 iHRI0KLS2VR27ngG1eZlA/yZ/fljqrIYtF8SM1bv7c3azl3gaKatRRwOTuZkbNh9hCDhf
	 u/0S4uLZDYCZ0cwuXnrA5ma/ALsw2hIWkUmnHUJq0ZYs207Ugd8EslpkUoIgta6TdsrgO
	 eGtMJcce4fHggrjaKUGmkBEfSFIUnAlJ/W1PMn9AGIM9/YzLShdWQiDWzkkP5r5LJvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zr+jPL093kMtPtVWReLyfcIydpRhCbpXeanMC9JcuXs=;
	b=nXAHqEpzY+2To6KiL1WpYSzDh8u8xvhVGM+HZAg+o64P/6fQZbjcihTx7cq+4ls06zhO
	 K6Sk6qBSgnFo0Xj9YKBFddVvbU+wgkB8cG1Bsg4Xbxdho4gtj36NE5/Ol6B50eMKGO/3k
	 D+hWuGwjU8rFABBON6W2lejGqIXFOy+ScFQr+PNeXA6f5dzTYQ+ZUFnXJI8gHphLn1gcq
	 zQn3Zx2tRS+ILVPLSvm0SKBPAbP6e4kWdbGWENPYm5suRPj5fDYiCrNrlxIeQ34IwpxVR
	 lCrXmnDLrxjvlwNNNzQLEna7A37Gf66jOGwZYMCuzGr60gUpY23u2LBLCRZDfAGUPCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=brMsclxQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FE606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 18:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E4FE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=brMsclxQ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so14352295e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:53:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793904825; cv=none;
        d=google.com; s=arc-20260327;
        b=WzoeniIqL05uzFbqFx+09UrKcN+JbinW2JB+/7TGq0eXhnAzSSZG1kpZBRCXNvRu3y
         u71rmaI7iuZPJbeZf01Y56Ry0qvNT786WMvXP1uUrpyoaS8qQiITkmuZQaf8/20hC71z
         c2BNEuXzSDGbvfHyREFmq5W1okq0DOifJrQrq2hoGREfu660DTNBjtiyvTo68h1glh3M
         gkapR6kFFIcOoir1hPcl6f5WkQdl/s1n5vYPRzkzBC53OVOj8E00/ZGEVv7oiGijN0L9
         5w3bQa8esmHLMHZ4QJ8hWF8pmWW0sUrPd3eOEhM5FQ74qXqD+DtgXR3PkZbd4ImdaIK8
         mutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zr+jPL093kMtPtVWReLyfcIydpRhCbpXeanMC9JcuXs=;
        fh=dku5/iWinspiBmoyGtayKxRr9gENo8EIZr2w9v0tmps=;
        b=leqdIe+TtSOSjkjp0OQ9NocUdTu8zIKyS1r4DU86h0wpPINFLbzpaFRU3YbqFxx/h1
         6EImwjtkPQqW0b+paewJFVoXYWaTMVv2O19FHokMwZf4UdqxeKnFrArQnS8BVp878Ai7
         q2k0qAEtzcSHQ/C/eddJ4sn2ACMYzwrFT7vq0TMQRw5h1A3yEHs2uzxMNvDMi1bdBE4u
         hDBjK9A8hH2oFVotnJWYS/40zSuu+rOSbBlW0DAPplEMBDEqYsalxbS7ys9KC4uvj1Wk
         2Fjj+qc7EZ1lJUuVg3q39cJ1IttXaGuE3Ibthr1F3n4zOzE8N7ce2OIKocy1Q0bAeYeX
         J/iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904825; x=1794509625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zr+jPL093kMtPtVWReLyfcIydpRhCbpXeanMC9JcuXs=;
        b=brMsclxQlXABke9NWXnW7MfsiXT7zjc/bspNwv034x5SzL7P+VG8Sp/AT9UL+gokTQ
         OzHCFKUbP6b7aIpJegYOoOr3lBuLygK2xD10wNuA2fOwOcgcxmJRSzd6eYWhDUgMh2nQ
         BTaUtaqAVkzNKs2wWUNB2nwA6dfV5mpP91hzWxhVJOmdsDR6xRN1fIoB3XxDUgKMez0b
         WA1vm/q+5PncLtLVKPR70SaI1df55rBTEGjbe1xw6C3WYhagbKhr1SnbiVkBGbqHL0bL
         KtPSvgp7+h2xMd4uG+vDCDbHWOTP/hkNZessrSw4j/fyy3XVM800d/Afnb5RPKteWGSz
         uEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904825; x=1794509625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zr+jPL093kMtPtVWReLyfcIydpRhCbpXeanMC9JcuXs=;
        b=qDA8hAMQK3NF96/JWCm1uLl/uBlZGC/35zpGObG77g6w9aiyo1UJ9dmxnI6vmYZYQv
         B7eD3AC+Bon5uVXwLA3GGdbd4abHMiE9tXRe0y9VtlgLrBqUTtSVuBhFjO2Q7I3FyZdz
         tPDiqJWPJDEIs5bQ/i7d3/EbplKge4nBpe7x8bKS4Asm3hMToCRchKg4af3V/B2eIgCA
         0QL1Ug6GDTLdfwKNwXCjKMESKNAa55qhykCz//9qH5ITPdnbKK+gsPItYlRt0XtITmbh
         +lT/k7/PuLJodgpqaNirQKcK6Al5I2KGM8sBhq//r4FnPu15CbetpUyHg7XieGXH81bl
         Gn1g==
X-Forwarded-Encrypted: i=1; AKwUvBzY+VqJzx62uhFuAwleDwy+H9ExJtGv5Bwmmp8zZHevEWCUZ9/AdbzQ+CuaItcqBnwbHv2dvh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bvzBcqhnTcco7dONOF8UswA1gF0rxWdquWyQ/xxa0BI/4abFt
	oXuYgbQ1SOi8dsqAyPys+xa1qecARCCRaIyJh1L4qRW+8XmdOgFp1MUblTy6/TGPseovv58WNhS
	af5aLR0SzhHzKs9hz7EItt/oO4QeJaBY=
X-Gm-Gg: AYBFou0tF2WEqRiEvrn5dwzRgyL+U0tu6frFEvaw9mJ6os06Gu31U0u3Xj4ff1TERWT
	d4GHrnC0sumKrc9YsCMLnV9eAZ+UDit/NbT7ScwbSANWHgftCMDm+WeZwtHn24oJR72b9WKVHrG
	0IDLhNARASXAZJ4Ah0Gaubd31TsFzEedfPsLeYgO+1+lI3Tdl8dLssvAaDIe+0QgGs9A5uIamUL
	49D6/6ZZsUrTEQi8PfZgvtHpUUwC1m6we3MhgZ1tfQZRZE2CcLHS6B12guZI7ITKEwwenxvKRZ9
	d0bwAj7TfSHKFe8UBMNYFjSgrxTSVKU0Bw+Jhx4rcmBye5KP9bCVf114Rj7tNI1D7O3FzlU6mQF
	xOWI9aoWJYI6Lh0L0m3pMatY1oHcElhK6+AyjNnwdW173caYNUU3NrRBt7qved9gccIC7+vSnE2
	II9Fl3OOzgouTPRaxc7eez5yhVd7EBiRKLfBCyVH00kEMJ4uHhLvGRvA==
X-Received: by 2002:a05:600c:4fc9:b0:4a1:fcfa:2a07 with SMTP id
 5b1f17b1804b1-4b6e007beefmr79625e9.30.1793904825112; Thu, 05 Nov 2026
 10:53:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com> <c8be6713-2378-4dc5-9959-fc7eddd800e1@linux.dev>
In-Reply-To: <c8be6713-2378-4dc5-9959-fc7eddd800e1@linux.dev>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 5 Nov 2026 10:53:08 -0800
X-Gm-Features: AclHuK9CGtHlpEzyvf56PaHvDk9YYrC0X1uB83qunWer31KQBoOIypGlR3DOD_c
Message-ID: <CAKgT0Uf_yYxp+tUJt4xYAnwqtK6LZY0KQYt0h4kt78=oQZxd3g@mail.gmail.com>
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:33=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.d=
ev> wrote:
>
> Hi,
>
> On 10/20/2026 11:08 PM, Eric Dumazet wrote:
> > Le mar. 20 oct. 2026 =C3=A0 16:30, Qingfang Deng <qingfang.deng@linux.d=
ev> a =C3=A9crit :
> >>
> >> Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO pac=
ket
> >> forwarded by a bridge can retain hardware GSO features and reach the
> >> driver without software segmentation, if the egress Ethernet interface
> >> advertises TSO.
> >>
> >> To force software segmentation, clear the GSO feature mask for
> >> ETH_P_PPP_SES in harmonize_features().
> >>
> >> Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> >> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> >> ---
> >>   net/core/dev.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index a6951ea08961..27483a2ad747 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(str=
uct sk_buff *skb,
> >>          type =3D skb_network_protocol(skb, NULL);
> >>          features =3D net_mpls_features(skb, features, type);
> >>
> >> +       /* Ordinary TSO does not update the PPPoE payload length. */
> >> +       if (IS_ENABLED(CONFIG_PPPOE) && type =3D=3D htons(ETH_P_PPP_SE=
S))
> >> +               features &=3D ~NETIF_F_GSO_MASK;
> >> +
> >>          if (skb->ip_summed !=3D CHECKSUM_NONE &&
> >>              !can_checksum_protocol(features, type)) {
> >>                  features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK)=
;
> >> --
> >> 2.34.1
> >>
> >
> > Ouch.
> >
> > harmonize_features() is called for every packet, GSO or not.
> >
> > This is a GSO-only problem, please do not add more protocol-specific
> > tests in this path. gso_features_check() is only called for GSO
> > packets, and the cost there is amortized over all segments.
> >
> > Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
> > because of the can_checksum_protocol() check in harmonize_features(),
> > and fraglist GRO packets (the main use case for PPPoE GRO) are
> > segmented in software anyway.
> >
> > This leaves bridged, non fraglist GRO PPPoE packets sent to a
> > NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?
>
> +Cc: Alexander Duyck
>
> I ran the real hardware test on Intel igc.
>
> igc_tso() requires skb_network_header() to point to the IP header, which
> is not the case for PPPoE packets, so it won't work on an unmodified
> driver. I therefore used a kernel module to inject PPPoE GSO skbs
> directly to the driver's TX path, deliberately pointing
> skb_network_header() to IP.
>
> Test results show that the hardware can still perform TCP segmentation,
> but it cannot update the length field in the PPPoE header. So
> theoretically, we might be able to make GSO_PARTIAL work in PPPoE.
>
> Kind regards,
> Qingfang

Is PPPoE being stacked similar to a VLAN or being ran as an L3? To be
able to make it work for the GSO_PARTIAL on most these parts it would
need to be inserted as part of the MAC/VLAN headers instead of as an
L3/network header. The main problem is that the drivers normally need
access to the L3 header in order to set the payload length and things
like the IPv4 ID field.

Really if you are going to support doing GSO with a PPPoE protocol in
there you probably need to look at adding a new gso feature flag bit
as any driver that will support it will need to know how to move the
header out of the way.
