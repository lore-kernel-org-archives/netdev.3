Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793060373;
	b=nhXkMvxvnQ/XUxcjwd+fGYFlLFOCTa3mTGXHNMMmrG2QAS6TzStgoq3KXgEqdGMRs1si
	 MZBvdtBOimjefJgB09KdnEdxw28gA3Fx5eY5mP7E3u2egh/woirouZIh3Xw+J6JJ4linb
	 MY4B4s45+yDlcuOn6CeP7wU1VZM6vaTSy96Nio7PZqd3y6rHuhEVUl8FUkh9Lw98ats6E
	 AIwRcULxbHWXNk9UkIRvgvsHnegfCvjP6KZPzizqhfEmzNwmUqAszapDUw/O2wxIMnpum
	 X8kVdwmBzv4WUAyBWZE3dIsO2nx+oEsPfcXlMl6Wxin0S4+VX9sWRjvveE4dsGguAoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7onaDyRIEdone8dgI/TgW+lAQIw53gU7EaOfJoc42Ns=;
	b=DCz6Lopn9qbwGC7EphGbzVbob5HbBXLQydjKdzYPIduVfgy0sW5cYOIPNkdiNQYPhePM
	 3UUHbPm4cHZVYjG0a+ZZUgansxnsr/7ozMAmS6DGYuDaEtlJhhXhgNCSwtexd41Cjjavu
	 2UDEyKXp11bJVdWjHUcGG/QcWiG0/8ACwRfsuXRSibzI4NvJEjRyq9X+gi5CqXm/x+5l2
	 IcygDt+vAskLy/xW6IprhpIPuACJn2Jmxdf1ItLffdKZcdFT86d9CWWXlXLUlT1AcI0Es
	 cP2F1CFsU7uGFf+k8M+Gg3TaGLhJMPi1PBWgV/jzIKl8RP4gs1I9UfRMJkpkwGxn+cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=gS4ddi3l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BE606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA2BE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=gS4ddi3l
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc91ddf447so1002584137.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060371; cv=none;
        d=google.com; s=arc-20260327;
        b=YrRPo0SIvhFhuxO9TGwKOWDykHSgOm7mrzjk6495WO/P78YrDH9OY1euMpEg/cRCLm
         sF1pNk+/m/83FpkpHze0R5dLppG1D+M2qOD3DbQC4ieYQWA8eaUrJ0vysAxwI72dpMIb
         mKWpLecb0mUvfJXGU+Rp6fmtLWrbfBBQQx99wfcJL9g57ArPVGiTllX5EfvIS6h2hphF
         2199FzzkWT3aLvBUsYvHvcH7YT5rPsJZhqDx3FbsMyAAKK0s+OPOI5pw15YL/z1R/aF6
         4r2MLJfSggGhs65FrKgmCFOdhKhbVJQRIjsEFJDP3f5JfK4xiYgrT4jbwW7FmA2bmUAL
         LtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7onaDyRIEdone8dgI/TgW+lAQIw53gU7EaOfJoc42Ns=;
        fh=LuQG5DIA4HuBX6/qdUCFTN6D1Zt2nvYN1EfoYP1iJzA=;
        b=U0W8pFTMfOiLpZce6l5rcSMVtQpCBSwfVNAUBhCAyR1FLNXdUSc5qA287/nALIECKv
         u8ybzyHU69btSif0k4U358MzIaTT9BEYkYac8cnpQHnkI2oRSO/fdMxmEw07jZkU2qAW
         Mhelmpvauvft6g34vZuyTIqmenwRWbofdVGXJ53xdSUnEPh9Ds9mCOFwcqzROP4W+9BM
         w/y4jYJvtcIMfHEQz18t5q6BNYGkuat5wyVsCyLv27BHZvNIlTNIYFz7Jcn2PAankE2O
         zarQ4pVJxIWQlHf8DmiSD3uE5VMRX5nVGUVqE21duSRzblbqFQ81x6MBZmgsM2mlYYc7
         ayog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793060371; x=1793665171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7onaDyRIEdone8dgI/TgW+lAQIw53gU7EaOfJoc42Ns=;
        b=gS4ddi3lp21+LFNVFEYLmMOSrWZGzb76h8loU6joqEov6D+XdpA1mqm3KjO1LgUB7d
         6kSLorvYwMm3KsTBG29y+b7Fg/zdFmQRoe3nBEpXwrDwGWdcvRZ0+Zy5jbxlz7vIWWNw
         0LhHvy1zyZuySHuubHv0o2aUeT/0EOMTXJDtjnvw8svQjeGk/huecsK57YFNR39IZXiD
         T2dJOlllDZhcdLDomr9kK3dNmiMlEAs35JtwRYGtErk4tChrPoQHbP02yZ7HF+Fltgn+
         TVKoqo/+u6VEDGDDEJwmnEzawp/O8sU9WP40T90WBzCTG9YoH1FjDouh9He+s3EFhEwv
         mkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060371; x=1793665171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7onaDyRIEdone8dgI/TgW+lAQIw53gU7EaOfJoc42Ns=;
        b=Jg+AJgLG6DJ5IJehzgNXIP8RPKMA7t5eWYhWoC0nfKlLnxQVecPBRmpIVpx1euWlm0
         /cN3jfUt54Q47JS3ZVoE8WqfnBGJUC8ee6gBQ3YejjjAdK0nZE2Q55VtTF6Dn15IvVcL
         GCNWct/ZaFDUDaFs5NTBO5uwDmXRGHqnEU+hagauOFQ/eY7naqf0EeKRck/XkWXb8MkF
         AO39bnxB6192yRDjiqDTKYz0PfviYhGUsjjA8Gw9q2FdhX/1gytbnN08gO75xYGa/Tvk
         qJMd2alep2KI554zS74TlQy/wma4PS6vZFFXV+KdxToJCmYZ5CwXsERhP7GSKPs0oIxT
         iQNA==
X-Forwarded-Encrypted: i=1; AKwUvBxrhFVYh8oTw+mAx8M119l/iDwql5UIUziprObeVJ3AgcngtGHAzb3R9kTAp4NLVTiJMLplRu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ43Lk8zzlQgqHWZDU4fEG1wkCouxQP4z71FaxwN7BIrgS8gieO
	Q86QiaS+ocfdMe66VBPBXYITq8cVjwBhQyh/Q7IFf29datGOxPaKfMHQPHL8ywFpYF68k7bwkdo
	Sc5n9elLcWFKq7hNt2bcv1b8wAC7almkouUnUO1dWWA==
X-Gm-Gg: AYBFou0ndNBrJLjljl3/v1lw5tqEoLGF5jPWmmBAbyOtw6Lcb56XVAQlKH0l2VqjkhC
	pUskEyKjP+p1tPrIaz2swPGLk0ly79KH274V1d1ImZkOM6NDSDn3GB/O4PYLgAwwRw+bKNp7AAB
	x9eyVY1zf2bprxwDiUORV4+QEetIvS5T9L1uaDwh5WAHLPJnHA60hz4CGiBdUnE5TEvFkHHgjVU
	ATRvwV+GKPpYyD296RouBvvNFT8f1U0C6oF/HKfWgwfD/2sHeHt7SUVGlhmqLmN1GhXVw9MPb7P
	yvFR1SfvLcxWVJa1BbRsE8RhrXVF1/Y4i0O31QAHB3WNx454QLXapcMymvYSYoe7wYNKsHqH08P
	sDwDRDz28oZD784z7FfIhYbTV3aGaPaHcQiQuN8ZBNZxucLnaMKbgrjv4PvenRRVk08FaGego1O
	+YNbtTmMrO6I+SUs5nH6uHhkt09zS4HBZXOySxSqb6NHE3uyHYC+LXAC97KPsX7pCS1iC5fOMUe
	kC0X7G/MbxhZhs2rN0UYL2Q
X-Received: by 2002:a05:6102:4a54:b0:7ce:a69d:b020 with SMTP id
 ada2fe7eead31-7cea69df2d9mr161442137.5.1793060370560; Mon, 26 Oct 2026
 17:19:30 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016183435.23382-1-rjethwani@purestorage.com>
In-Reply-To: <20261016183435.23382-1-rjethwani@purestorage.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 26 Oct 2026 17:19:19 -0700
X-Gm-Features: AclHuK_y5cI9kqPwLofQy6nhEkSFknXjI3m-lBC6PfAT9pp12p24wai3mFPwMQQ
Message-ID: <CAKaoeS02NM8a6urFTykM-7eyu=31DricV2E8Q-x2_nLg22_gCA@mail.gmail.com>
Subject: Re: [PATCH net] tls: restrict device-down TX fallback to hardware TX sockets
To: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:34=E2=80=AFAM Rishikesh Jethwani
<rjethwani@purestorage.com> wrote:
>
> tls_device_down() visits sockets with hardware offload in either directio=
n,
> but installs tls_validate_xmit_skb_sw() even when TX is not offloaded. Th=
at
> validator calls tls_sw_fallback(), which expects priv_ctx_tx to point to =
a
> hardware TX context.
>
> An RX-only TLS socket can still send plain TCP data after the device goes
> down, and the validator stays installed after the device comes back up.
> Its priv_ctx_tx is NULL, so the fallback crashes when fill_sg_in() tries
> to take ctx->lock:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor write access in kernel mode
>   RIP: 0010:_raw_spin_lock_irqsave+0x31/0x60
>   Call Trace:
>    <IRQ>
>    tls_sw_fallback+0x11b/0x450
>    validate_xmit_skb.isra.0+0x14f/0x420
>    validate_xmit_skb_list+0x41/0x60
>    sch_direct_xmit+0x11d/0x2d0
>    __dev_queue_xmit+0x5e8/0xf30
>    __neigh_update+0x354/0xcf0
>    arp_process+0x252/0x800
>
> A socket using software TLS for TX also lacks the hardware TX context
> required by this validator; there, priv_ctx_tx points to a
> tls_sw_context_tx instead.
>
> Only install the TX fallback when tx_conf is TLS_HW. Leave the validator
> unchanged for RX-only and software-TX sockets; tls_set_device_offload_rx(=
)
> never installs one, so they keep sending plain TCP data as before.
>
> The NULL dereference above was reproduced on an RX-only socket.
> With the fix, RX-only TLS sockets on two hosts survived an interface
> down/up cycle and continued receiving TLS records and sending plain
> TCP replies. The software-TX case was identified by code inspection only.
>
> Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device go=
es down and up")
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  net/tls/tls_device.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f11d0528fc43..15ef6c3c0648 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -1319,8 +1319,13 @@ static int tls_device_down(struct net_device *netd=
ev)
>         list_for_each_entry_safe(ctx, tmp, &list, list) {
>                 /* Stop offloaded TX and switch to the fallback.
>                  * tls_is_skb_tx_device_offloaded will return false.
> +                * Only sockets with offloaded TX have the
> +                * tls_offload_context_tx the fallback needs; leave RX-on=
ly
> +                * and SW-TX sockets alone.
>                  */
> -               WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xm=
it_skb_sw);
> +               if (ctx->tx_conf =3D=3D TLS_HW)
> +                       WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> +                                  tls_validate_xmit_skb_sw);
>
>                 /* Stop the RX and TX resync.
>                  * tls_dev_resync must not be called after tls_dev_del.
> --
> 2.50.1
>
> [Severity: High]
> This is also a pre-existing issue, but with this patch RX-only sockets no=
w
> survive a device down/up cycle. That makes the following sequence easier
> to reach.
> [...]
> Should tls_set_device_offload() refuse to add TX offload for a ctx that h=
as
> already gone through tls_device_down()?

Yes. The reverse order has the same hole: HW TX, then NETDEV_DOWN, then
setsockopt(TLS_RX) adds an RX context that close never deletes. This
is fixed separately by "tls: keep TX and RX hardware offload on the
same device", already posted:

https://lore.kernel.org/netdev/20261013202647.2206263-1-rjethwani@purestora=
ge.com/

It makes both tls_set_device_offload() and tls_set_device_offload_rx()
refuse, under device_offload_lock, a second direction whose netdev
differs from ctx->netdev, which includes the NULL netdev left by
tls_device_down(). Setup then falls back to software. The two patches
are independent and apply in either order.

pw-bot: cr
