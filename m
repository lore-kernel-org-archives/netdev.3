Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E376551982
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088580; cv=pass; b=Hy+tvWkduN4OedBC46SFXw+QezGw2/Vax3YvI6xgazK8ecNiij4y+VXwUfPO8VGTn3rxMSj7B85EZmO1KJ7ZEJWfcJBAm70DaAt/QTpgjWajUsvnOqUmMq7PA2jn9dFH2KvpZXZG4ahCsGkPelf6Af/jrSPiqNL0hcSBri9fl2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088580; c=relaxed/simple;
	bh=lnM6cflH5qTNJpyQohcX240ZcGNVfa0xrvRKgwtXMwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FERRIC0x5YnnJHGVkkv2ptxdRuu9G2CmQrJ67bFPpG0NOB2SShpTaVN4SWcxNEQtpU+e0BriTogGGSsz1ulknbVHEzMwErWhMYVjQvTzojwZqixAIsrpzprV1iyHwEuhuLqYPnOXlTdELZTZ7O/NVHAxnm7HStVRyw28s2i8pRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oux6iLug; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oux6iLug"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8961cca9193so110647b3.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790088577; cv=none;
        d=google.com; s=arc-20260327;
        b=bj9h4C3FUoL41uIuiPkhdAHR6de0hyekLrxYhiD+y81qrGnp7yCl+8+687utVc8t0v
         3l+vpvKlBKWb8T7pL8N+vQ4DoTceAmUYULRG+wUJ/NgleDchUycXTfje/FgBxn5Ptnuq
         FsS3i3G2UtZ6KqcXbB4V4KB2ysrCdGwd5UYBXnG5kmcO3xvQBZQvIHXhbK8MI1I9ijJn
         8/U/q76KXN44dZN01WDyeuPPLTstrzrlc/xglaXN3tGXDtSgXeaGNZx9X3D3GOHzCM8N
         vE+jEUR7NJoQcwTLgzQkRLY+NVExP3ZeVbnsQQq35//hKF/bOtDwc/C8sR0q15Hz+X6z
         yLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8MvaWMCazWtxCnTR9jUdmR6JJDJY0FfT6motlrbuSc=;
        fh=jqGFtuNLlJ654mq1gBy/Co6PauDaIqev9/QfNVPnRy8=;
        b=LdKASJIULBjWoCxz8ekoqC6PTAToqdnuqVeimSgGOCrCZ0A8P5X4WWsc4Dcp/9uFu3
         t4be20nGwerY7OoBEmNf8yYWWKtlKM/v3GV5pWU3YXAXhuydZwb1MWCy3gbCXgvwuWZW
         vC0TjjZEybhnFMFcJCrl+RwtbvY2eia52Asv8Rnf47k+LzCRy0xoKrP9qzFymP4eTlrV
         Pnib8TL6CFRwEDv/ib579VUtj7zdjTWE6rN6aNOJ3g3BVDezD6HBTGo/cfHGlCPXGU3z
         R/aI3k0YAzCJmZ+ZHnCKNmdQiADXPxMhT3teccXIoRZ0crIPRgCz3ZHGyjT6m0RJSu/n
         81Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790088577; x=1790693377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G8MvaWMCazWtxCnTR9jUdmR6JJDJY0FfT6motlrbuSc=;
        b=Oux6iLug6883rYdSsMzynwe4+J9HaxKHksNDRVAt6l+LXDy85spqVl+PNdoAEAtELh
         FD5KMhgWVo5aZZp/FzqidAXhMeSpZNDJjby5FPcz7WutkNuzxjkooHEqPu7BptTn+sgL
         dM2BSC7ahL7JewW1Wq/UYNXWHDqlzNN+0WN2wA9F1WNZ0Ro0uxQgL7cBQjd6qtu4k+Co
         21dUNaSNNc6imGxUpKglzimw+istHj3GJ/eAutAwIUiAWrsQvQ589OBIifMUYGme7KOH
         iaycY3633pGKEC1vvxE/JnawpwQ8T2LPod8ILuHXT1e5tf93XBidVvcgjg2wFUvGV3uo
         gfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088577; x=1790693377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8MvaWMCazWtxCnTR9jUdmR6JJDJY0FfT6motlrbuSc=;
        b=Vhh2HQb6bFvAU9g46smlVTA218eD6RCy2/gd6Nxm4fxw65Zqiw54bkvX+jET06J0vQ
         b8HegK5rSo4Dl6eOmQ0jTGip6B5DSkDNEYxth6A40Zc0Yfwtj1i1UYN/UWrNtIE86Vos
         M3sm+YXQ46pTxscuYQRO8dLVPREG0Hh57Q9YhJTbg56zUnwCfNsR3N6OEugmKm6fHwpi
         jfLGWK63qrO+kULajZIa6z4766t8b5BIqaJoO4ICS1/ie42AklWDbzdHjsAV2wWIDLDn
         I/VsmYgoCLegwr2NBLLnTUHojwo8HRWmM6grRAlsg2qocS9eionCiElqvVWlUqzySnUz
         3P7A==
X-Forwarded-Encrypted: i=1; AKwUvBxiFdyvL9kL+K6zCxsvyvQy2li3fYfBVVmbC1SkNLTZSU87bebvBYEA/osptrDeYtOwEnAAWss=@vger.kernel.org
X-Gm-Message-State: AFuF++mtSjTg1tDOjGvHOA1feYykJcYeLwfX6LiArTLyXY50i1vnO0g3
	W5oRNZr+GQMapO56VLLunHfJIw/n6sdMovl5xVZPxvNCa6UAk1WLEfIMQ6Cd68AMx3EkW4fEX7Y
	rjwqEb1aeUweJy3XdNhzaSwRVhLEFOCu+z8uL87LR
X-Gm-Gg: AYBFou3+55nO9NUQ1E3wVoIGj/Rs5e52V3xuy6xFCoY2YsDHoV2wwAsNSLZIn4mzwO6
	WWyTegJGFaOkuqJ189Nq97iJA6TW+unYhGnqutHyLKq7lCpfpLM0gVKQ9vZqFijw76IOXA9qlgY
	ltTye89GJ++y1qNkWqzBU5q4EuH0Z3+DB8+97fVoFEzMKwiBdeJrWrn3mIqq6npitv0PtZjF7c8
	CdlrmPS24Zz4BFAv1S/tpiw2IHA00O7QswnXUujJbNZ4g0NGFLsvzRqwoPye2eiD87GsJYN8EtM
	IwbKYkrhDvtMkXRU0xDg9qkdXRLdHxyOb239G2S++alaOBB3HvwvNoQgNGI1N9fo6ekaWFJvoQN
	dP+msYanZxO8UtapYSix0WibqDLd11i6IZDv2RKtsZAlkZT9ooNH4wCSCZ+RG2izgjk9hnhlvws
	yKTF61
X-Received: by 2002:a05:690c:9990:b0:89b:689d:3a70 with SMTP id
 00721157ae682-89b689d3c55mr42712967b3.39.1790088576671; Tue, 22 Sep 2026
 07:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com> <arJlHYp_IfNJG7jg@luna.proxmox.com>
In-Reply-To: <arJlHYp_IfNJG7jg@luna.proxmox.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 16:49:25 +0200
X-Gm-Features: AcwNN1WnmuGvT820ZPeH5DHeqTMnmj18VJ3_JXIm3EFgvsnQBAL37Y3cuAy-_x4
Message-ID: <CANn89i+cnnb2mM90JZ24qWUgs-Y9gcsgFSYdaVrNjWHjn+b-TQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ipv6: keep room for the mac header in dst_dev_overhead()
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, Andrea Mayer <andrea.mayer@uniroma2.it>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:24=E2=80=AFPM Gabriel Goller <g.goller@proxmox.co=
m> wrote:
>
> On 22.09.2026 05:49, Yuya Kusakabe wrote:
> > The seg6, ioam6 and rpl lwtunnels size their skb_cow_head() request as
> > the length they are about to push plus dst_dev_overhead(), then push th=
e
> > new headers and rebuild the mac header below them with
> > skb_mac_header_rebuild().  That rebuild needs skb->mac_len of headroom,
> > but dst_dev_overhead() leaves LL_RESERVED_SPACE() of the egress device,
> > 16 bytes for plain Ethernet.
> >
> > Where the mac header is longer than that, as it is on ingress through a
> > VLAN device with reorder_hdr off, the rebuild runs out of room:
> > skb_set_mac_header(skb, -skb->mac_len) computes a negative offset,
> > stores it unchecked in the u16 skb->mac_header, and the memmove that
> > follows writes skb->mac_len bytes about 64 KB past skb->head.
> > Forwarding plain ping6 traffic through such a device reproduces it on
> > all five seg6 encapsulation modes and on the rpl and ioam6 inline paths=
;
> > skb->mac_header comes back as 65534 on a 704-byte head.
> >
> > Return the larger of the two.  The helper already returns skb->mac_len
> > when it has no dst, so this only makes the other branch agree, and it
> > covers every caller rather than each call site in turn.
> >
> > Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issu=
e")
> > Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc iss=
ue")
> > Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue=
")
> > Suggested-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> > Assisted-by: LLM
> > Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
