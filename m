Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C21485518
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873785; cv=none; b=Rkb5h3IV5480aWAYjsneY6BSKegfLcv9x0QIew+BaYi3BZlgZSFFB+P1HFzy2vfCif9AxPycDVPUu0ATvZCY9UZf3ZUMpHS6JMRMKGLPaLfPJye1aNjfIHY8okPzfpzxmxYCc3txz6L64uK6WTKdQli6WNBw0civMhfb8RcakAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873785; c=relaxed/simple;
	bh=U1yAKJqVlr0pb+Oa4xHiO8t+1/DjPgjNDLaPJCfExCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6nest1FCX6twkSw7FZwr/6L0URW+6izV4oUDg2ce+6upLEwvcL5nCdNEiB68AkhtzFKwo1jrBI0oBIhg0JlQXRW+4Q1Ui4hFMyAysljv8Na+1hxgCoKcs7xRFWRofXMYOwgghkQJyXIXHzeIPL1HqGlTOVR6Uuz3QjwedflspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pp8kdM0P; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pp8kdM0P"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-677cc343120so2417307d50.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873783; x=1792478583;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+MkdSWVVi4+xk4c1t8+22G0BS1OKgjv0d40xkzF3Pc=;
        b=wAfb3mZGp88OTMrvg0NgMmLjLqoLYQf7RKqyKUtXjDOJQPSByPzD5aEr7+ccYzWbk0
         JEFhM95tjq+v4IDRmiME4t4JnA5MjSBiWJ8VtYmJ2ZvPcVB84lH8pzkiJ0sfbxxRzN5H
         uqeEfRmGhDg5RKX9MPFmZhwX1uF+Hs5ZVfpIRok2k0rHI1zmpPOT6j+p3yzhs7GE4cxY
         QpZXGEDhi+KUN+UK+bZQtmlSNzg3WN+y3XRb/QUw3kOudnZms9Up7xDjsx2t/Aj6K9TY
         ZeqICqHg/q6aorMmfK1y993/sBbbHvO5SvZmsnZb5EiW/bvz8DpKL012XcNiUqT8/8Z0
         6o7Q==
X-Forwarded-Encrypted: i=1; AKwUvBynGq4ULDJ+tdEEeEjVSsW/Eaov0IsA0QndRXVTEGUXfStS3pLRWPZ6LgoQyVk6dgNW+8AP2gw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRXPP1xcKHwUF9bhKjQFy0hr0IU+bpmp6RSeBYH170lPwYNyMO
	z9NzF7vRY4LtgTucfWou04vNRgB83k0Da69/03YjtCD3RXkff4Vfv6cSQG1eeXWiAeUcg/bxqBW
	6LoYKW9cFtKl676xZWGyqg+tsz6n71n5jIQQjIQ8JT6K4k8Ly2bOWv0V0aN6Q1fQW+9HJxiTPmX
	UJXXgmtNuh/qYcrA/9bOz19QecE/F8usU6kG/poL/fLMCs8IUtqzKOM1FUCdeMaTFdcTFFbIqKq
	eVbay6Djg==
X-Gm-Gg: AYBFou2dxAfcfKtKPaZjfaGq7qTvAi/bjld/dozfaNWW5PwKLjo6QOrctUD9Ulhmfej
	ISPHQpJmjDmETRR9DTID4BYNXHG2Dijgz/D2v03mZBYqF13L8YcqGyGDV+xu0MeD+KbYexbpjja
	NaZsW1bgQ5M0dpcBzYzRSXMpRrTSaxjuZXCdxW3M3TYwENmoqLiWoi4yFvX/M5OILb5F/+0oNVj
	gPLiobgIk88YoJCRg94kD9yZgnqF7zemoN7vnOfd4uqv2peuWfOY1Nl9vYO6Dp4WROjO0tvalPw
	ZH2oGxiuHxfbH3JZF+x9aIstx7MyQVKtHsiT0F2+FF+bGTIKSmw8Jnt8El/LHY1NmK3hnHJZElY
	RY0wFH1zeogq42Ac/f7R6nO1KNxlgj4WQuhYy4TO+ZwKQfBr/ZuE+xUH/ZRDwkZWL9c6CoQn1Vg
	/BW46t6XQBbW+afXzh2MQ4RA0IYAR3QUvWH76e
X-Received: by 2002:a53:b179:0:b0:677:c8f9:73d3 with SMTP id 956f58d0204a3-679362ef552mr2911278d50.75.1791873782700;
        Mon, 12 Oct 2026 23:43:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-679356d7fa7sm434249d50.39.2026.10.12.23.43.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 23:43:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf651b26c7so515340137.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791873782; x=1792478582; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+MkdSWVVi4+xk4c1t8+22G0BS1OKgjv0d40xkzF3Pc=;
        b=Pp8kdM0Pzv1JTu0NqsDlSyPGQz1BxB1sOX/e0CeJENBl+bM5KOSlwcdp0gWSZF9wre
         O4BqPGw2zi/bIn1HJLVmD44O/J21ubAsjZXJy9twgwqrQy2sneurzGf5TI4aCbAE4neS
         /bQBlLskpidYr8lN05THniIEiE0IgP2jBcQbI=
X-Forwarded-Encrypted: i=1; AKwUvBxWGvXICwMWVDo5C6J+eZ+TnP7zso7biG7oYXcHJzzzlMZKftcC8Z6BaACCEFIy/UNeWbwa1ak=@vger.kernel.org
X-Received: by 2002:a05:6102:418c:b0:7bd:b263:14c8 with SMTP id ada2fe7eead31-7cb37506fb1mr2596074137.30.1791873782039;
        Mon, 12 Oct 2026 23:43:02 -0700 (PDT)
X-Received: by 2002:a05:6102:418c:b0:7bd:b263:14c8 with SMTP id
 ada2fe7eead31-7cb37506fb1mr2596068137.30.1791873781485; Mon, 12 Oct 2026
 23:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012054325.1782819-2-vikas.gupta@broadcom.com> <179187029600.434549.15294077033511744217@kernel.org>
In-Reply-To: <179187029600.434549.15294077033511744217@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 13 Oct 2026 12:12:48 +0530
X-Gm-Features: AclHuK-zZOPhxETEOXdk9k-2_FDRzU2fSAIRGlxrihJhn-QSViMHWD2ybvC97Ds
Message-ID: <CAHLZf_ujPYqE0X5UeX3GhRML+Vit92RbBv-y3-r6f-UBS8ngrw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bnge: fix RSS table sizing for large RX ring counts
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com, 
	dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000484185065db32021"

--000000000000484185065db32021
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
  I'll send a v2 of this series with the patch order swapped.

Thanks,
Vikas

On Tue, Oct 13, 2026 at 11:14=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This commit opens a heap and DMA out-of-bounds write window for
>   513-576 RX rings.
> - [Medium] The commit message is wrong about the completion ring.
>
> --
>
> bnge: fix RSS table sizing for large RX ring counts
>
> This changes bnge_adjust_pow_two() to always add one block before roundin=
g
> up to a power of two. RX ring counts whose quotient is already a power of
> two now get an RSS indirection table that covers all rings. The same
> helper also sizes the RX, TX, agg and completion ring pages.
>
> > Always add one block before rounding up. The same helper sizes the ring
> > pages; their count only changes when the number of entries divided by
> > the entries per page is a power of two of 2 or more, which does not
> > happen with the default ring sizes.
>
> [Severity: Medium]
> Is this accurate for the completion ring? It holds for the RX, TX and agg
> rings at the default depth of 511. The completion ring, though, is sized
> from more than the default depths:
>
> bnge_netdev.c:bnge_set_ring_params() {
>     ...
>         max_rx_cmpl =3D bn->rx_ring_size;
>
>         if (bn->priv_flags & BNGE_NET_EN_TPA)
>                 max_rx_cmpl +=3D bd->max_tpa_v2;
>         ring_size =3D max_rx_cmpl * 2 + agg_ring_size + bn->tx_ring_size;
>         bn->cp_ring_size =3D ring_size;
>
>         bn->cp_nr_pages =3D bnge_adjust_pow_two(ring_size, CP_DESC_CNT);
>     ...
> }
>
> Take BNGE_PAGE_SIZE of 8192 (for example arm64 with 16K pages), TPA off
> and default 511/511 rings. Then ring_size is 2 * 511 + 511 =3D 1533 and
> CP_DESC_CNT is 512, so the quotient is 2. The old code returned 2 pages,
> which gives a cp_bit of 1024 (fewer slots than cp_ring_size). The new cod=
e
> returns 4.
>
> With 4K pages and TPA on, agg_ring_size is 2044 and ring_size is
> 3577 + 2 * max_tpa_v2. max_tpa_v2 comes from firmware max_aggs_supported.
> For values of 260..387, the quotient over a CP_DESC_CNT of 256 is 16, and
> the page count goes from 16 to 32.
>
> Could the commit message mention this change to completion ring sizing?
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/n=
et/ethernet/broadcom/bnge/bnge_resc.h
> > index b62a634669f62..c0b6992d7f828 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> > @@ -81,13 +81,10 @@ bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
> >  {
> >       u32 blks =3D total_ent / ent_per_blk;
> >
> > -     if (blks =3D=3D 0 || blks =3D=3D 1)
> > -             return ++blks;
> > +     if (!blks)
> > +             return 1;
> >
> > -     if (!is_power_of_2(blks))
> > -             blks =3D roundup_pow_of_two(blks);
> > -
> > -     return blks;
> > +     return roundup_pow_of_two(blks + 1);
>
> [Severity: High]
> For 513..576 RX rings, bnge_cal_nr_rss_ctxs() calls
> bnge_adjust_pow_two(rx_rings - 1, 64), which gives a quotient of 8. The
> old code returned 8, but this now returns 16. Nothing clamps the result
> to BNGE_RSS_TABLE_MAX_TBL (8):
>
> bnge_resc.c:bnge_cal_nr_rss_ctxs() {
>         ...
>         return bnge_adjust_pow_two(rx_rings - 1,
>                                    BNGE_RSS_TABLE_ENTRIES);
> }
>
> Can this overflow bd->rss_indir_tbl[]? bnge_alloc_rss_indir_tbl()
> allocates BNGE_MAX_RSS_TABLE_ENTRIES (512) entries. On the first
> reservation, bnge_reserve_rings()->bnge_set_dflt_rss_indir_tbl() gets a
> max_entries of 16 * 64 =3D 1024:
>
> bnge_resc.c:bnge_set_dflt_rss_indir_tbl() {
>         ...
>         for (i =3D 0; i < max_entries; i++)
>                 rss_indir_tbl[i] =3D ethtool_rxfh_indir_default(i,
>                                                               bd->rx_nr_r=
ings);
>
>         pad =3D bd->rss_indir_tbl_entries - max_entries;
>         if (pad)
>                 memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl)=
);
> }
>
> The loop writes 512 entries past the end. Then the u16 pad wraps to
> 512 - 1024 =3D 65024, so the memset() clears about 254 KB beyond that.
>
> The other RSS consumers also look sized for at most 8 contexts:
>
> - bnge_setup_vnic() calls bnge_hwrm_vnic_ctx_alloc(bd, vnic, i) for
>   i < 16. That stores into vnic->fw_rss_cos_lb_ctx[], which has only
>   BNGE_MAX_CTX_PER_VNIC (8) entries.
>
> - bnge_fill_hw_rss_tbl() uses a tbl_size of 1024. It reads
>   rss_indir_tbl[] past 512 entries and writes 4096 bytes into
>   vnic->rss_table. bnge_alloc_vnic_attributes() sizes that buffer from
>   BNGE_MAX_RSS_TABLE_SIZE (2048 bytes plus the hash key).
>
> - bnge_hwrm_vnic_set_rss() reads fw_rss_cos_lb_ctx[8..15]. It also moves
>   ring_grp_tbl_addr past the end of the coherent allocation, so firmware
>   would DMA read outside the buffer.
>
> Configurations with 577 or more RX rings already overflowed before this
> patch, but this patch lowers the threshold to 513. Hitting it needs at
> least 513 default RSS queues from bnge_net_init_dflt_rings() and firmware
> that grants that many rings.
>
> The next patch in the series, "bnge: cap RSS contexts and RX rings to the
> RSS table size", closes this. It adds a min_t() against
> BNGE_RSS_TABLE_MAX_TBL in bnge_cal_nr_rss_ctxs() and caps *max_rx at
> BNGE_MAX_RSS_TABLE_ENTRIES in _bnge_get_max_rings().
>
> Could that cap be folded into this patch, or moved ahead of it, so this
> commit can be bisected or backported safely on its own?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012054325.1782819-1-vikas.gupta%40broadcom.com

--000000000000484185065db32021
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBixV5mrnQdt
neFfN7AIQQ69VV6p+BzCypQuLhafRVM2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MTAxMzA2NDMwMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJIds9qIuk/S1gb4Sr4PuFFhjdJh9bjk2s3yLMoQ7whSVAxp
eKsOcdN9wCxEIRmW0See2ps3OmlHJjSO4nHQrulDL9UZVsnML3kvmxc3LeXKg7qwU3SNuwpAyaJx
mBrk3sunpGiWkqybtJPPwAfWPNXS827+a5D9keQ92Xvi/enVXPfCQzAmHFdzntJdJ1iu/ahifozg
6J0Q4VViMaejXo1+NJ5Vy/FCwsBpDSOAGM6IC8p6o4BKM1AKwlVcOcYiV+Kgzuzoxoa8+P2vYZ8p
fQMMs61Xc5RH1GiBEOsB3Z44E+cksX/oEFGd4uuBCR5TCPaLn2vm3zzjnFUeOuGrAUc=
--000000000000484185065db32021--
