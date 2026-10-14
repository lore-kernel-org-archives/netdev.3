Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18664566C5E
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998447; cv=none; b=P+1uVnwIrChOGIYdXL7Nf64DtyEUZye0da1w1e/HLcpuYArT4WylSI7M8cgqpey3c1qI8VMfg5+vYtQrxTAUE01EQSxDdhDFox5E09ce4mxXSGbAA4dArJ3ley6j7c13WinQk7654Jz2PAqittfN/q/UZi5mjK6foClYhikU0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998447; c=relaxed/simple;
	bh=ENmPjCHSjnfC2ywVx/yjBM7+0+6pZ5XVO3bXFTcbKC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnhmMb1P1KqODBo7QX53HfR1tUbop7QAKwEP47vtMvXWnmkiZgMS8Nk6+8qa+zCvrWEr1HYXUjHEVVv4fS96egbTPxOPYm7d4j6i/W+oZuj2q/gM19jZbbsz71OZra9jEUdA9GGiieRSjFLk8VWvWRh4N2jcj50tlwg8Vuq65dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QJsOKEqI; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QJsOKEqI"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-398a5aad413so526885a91.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791998438; x=1792603238;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iNyooQTaPuV8ACfvJidIjGDF7VY7ELFPkObHYlf3Lkk=;
        b=egCD/5DqtaInoNJ4qLZqES9FSIHr5OHApbGFxCDuUG/ibhbFy+2ROIF1FggKtbzcb2
         0hIM+v1J5zLJbod9fsrTAfeB14YOWbPEKxVmvLjrgLIWOh2YWFIoDaBzEbC2ewDnjvdB
         kdre0MNpbLpLJZwqUyFoUfCwYbw1WYw5Uw5U7KYlnLg/B0i1BOobP7XewiI340y5CM4I
         VzPih2K/Djq+DrTSAxlDPZ8CBoLjjL060E9oVm3uciDtm7wT0Jh4GptpSKv+nf6TXRsJ
         q9EES+RHe7GtQ3VpDqAZj1yDQm9qajL80B0T00yxpVzGl67Qlk9u8JSBvlUFlF5pcGOz
         fRWg==
X-Forwarded-Encrypted: i=1; AKwUvByj43cr/dVRqFTSt4/qC/mfljrv3eaAF+Q7Md5xEf7blrDGkGm2zOwA8qYYK9fBGjHPOmShZbI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUzAgrmb6xbURJuq46yS6WlMDmyVIkYQqPd1c4RxIl45dNZx9R
	Bu/6R5V863zmvzqBnMCx/z+LJvv/7pAbySydH+fuA1nS2F7gYLShvs4+RqcgTedR3Ba8SxQEtZI
	zdpyWweZW94nBRquKpXH9b0Nd7pypqtwljTZfXtSso/ZBDUarvfvvZhwFnqd5jn/zf/i6rTiIQi
	MAJfxY/l2DGzWvB/fBSsn6XUO8Fp0/zByD7V0KpDNL34kYZSG5KAA4w/TtzWQpKQAFyQYnnAdQi
	qiXOXwUggE=
X-Gm-Gg: AYBFou0QNlfrGBE8N4N3zoatb40T1DWZWlHGftG2KktUjIR2rDd79VKn3xYYlYV1hon
	v0gVz5HZDaNDcvE7J22r60fAfe/5JH9EaSintjrMHauDRK+ZisNq2Lxf8PIykHOGm21Ix/9pFPn
	G922lLBb3B2C00bPVkRQixVDD7uc8d/ulrs5oAvYx+Uo106Qx0CYG5azOuBdnbWC65KDtkMT5gt
	pkGGHt0OA0PvlG3evpwfQM7o/hvSlB72ma9nnVoKOq6LlsmoE8N/916vDO+fo35RzLA8Q2OI+wO
	6iCa9LMvHQhEi+bDRtdagvIvJXHyctoyr4sTXv63z8XAksDD7zNaSFUxJ37NS8ciJFJOpUiSyxl
	F2W9blyy4ArK8meAZ5XNqIC/GKzFFyA1RnLthyAcVux/MoxrqBpRSs8tLcx6S7thTAKowJQnTgX
	rXgjVlNUbnR+RBIrOdccGSVMLYl417KgGOnNZAwg==
X-Received: by 2002:a17:90b:28ce:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3ab3a79df67mr14409667a91.29.1791998437814;
        Wed, 14 Oct 2026 10:20:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac947badeasm118652a91.8.2026.10.14.10.20.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 10:20:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e4d39c795so400814166b.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791998436; x=1792603236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNyooQTaPuV8ACfvJidIjGDF7VY7ELFPkObHYlf3Lkk=;
        b=QJsOKEqIGp8v3O0CewKWtrcrFoSDHQU3+85c7+WYb9xK3HdMHbdOMGUVFI4g6uzJId
         OxTZ5BuP7Fpcalr2zA2Qh4IX1qMnDNYRL6IPLB9H7oPWza9CMooXieXOfYNGJocaC8HD
         6fFXTTjvffJMmEs9VBAHJotPS1Y+F7KaVGrDI=
X-Forwarded-Encrypted: i=1; AKwUvBxRhiFzcqku81/fwr8cVRiY/H123n+VoG6hhKu7l+2xQSuXX3INviUiOvhpxdJW+49QLXpTKBY=@vger.kernel.org
X-Received: by 2002:a17:907:7fa0:b0:c29:4490:50d6 with SMTP id a640c23a62f3a-c31aa022de1mr1485693266b.47.1791998435802;
        Wed, 14 Oct 2026 10:20:35 -0700 (PDT)
X-Received: by 2002:a17:907:7fa0:b0:c29:4490:50d6 with SMTP id
 a640c23a62f3a-c31aa022de1mr1485690466b.47.1791998435301; Wed, 14 Oct 2026
 10:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012220827.340998-8-michael.chan@broadcom.com> <179193249717.434549.8103445657077169884@kernel.org>
In-Reply-To: <179193249717.434549.8103445657077169884@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 14 Oct 2026 10:20:21 -0700
X-Gm-Features: AclHuK-dM2PuHe06QxzJdeIPLc-2NsaEB95I8BI0CWaSBaUCNZBgc4N4ULLzCew
Message-ID: <CACKFLikz-e9_BB=fp3sTGGMGSCJvbzurf8rfZQVuqAdXBh3WWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: Fix ring accounting and
 validation when rings are constrained
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000039c821065dd026db"

--00000000000039c821065dd026db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:01=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:

> > -     tx_cp =3D bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
> > -     bp->cp_nr_rings =3D (min =3D=3D 1) ?
> > -                       max_t(int, tx_cp, bp->rx_nr_rings) :
> > -                       tx_cp + bp->rx_nr_rings;
> > +     min_tx =3D bp->tx_nr_rings_xdp ? tcs + 1 : tcs;
> > +     if (bp->tx_nr_rings < min_tx) {
> > +             netdev_err(bp->dev, "Not enough MSI-X to satisfy min. TX =
rings\n");
> > +             rc =3D -ENOMEM;
> > +             goto msix_setup_exit_restore;
> > +     }
> > +
> > +     bnxt_adj_rings(bp);
>
> [Severity: Medium]
> Can the TX count returned by bnxt_trim_rings() be negative or too small
> here when XDP and mqprio TCs are both in use?
>
> bnxt_trim_rings() still runs before bnxt_adj_rings().
...

This is a pre-existing problem in bnxt_trim_rings().  But since it is
directly related to the issue fixed in this patch, I'll add a new
patch to fix bnxt_trim_rings().

> > @@ -11602,25 +11673,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool =
irq_re_init)
> >               if (!rc)
> >                       rc =3D bnxt_init_int_mode(bp);
> >               bnxt_ulp_irq_restart(bp, rc);
> > -     } else if (irq_change && !rc) {
> > -             if (bnxt_change_msix(bp, irqs_required) !=3D irqs_require=
d)
> > -                     rc =3D -ENOSPC;
> > +     } else if (irq_re_init && BNXT_NEW_RM(bp) && !rc) {
> > +             /* __bnxt_reserve_rings() may have shrunk the rings */
> > +             irqs_required =3D bnxt_irqs_required(bp);
> > +             if (irqs_required !=3D bp->total_irqs) {
> > +                     /* Don't bother reducing static IRQs to avoid dis=
rupting
> > +                      * RoCE.
> > +                      */
> > +                     if (pci_msix_can_alloc_dyn(bp->pdev) &&
> > +                         bnxt_change_msix(bp, irqs_required) !=3D
> > +                         irqs_required)
> > +                             rc =3D -ENOSPC;
>
> [Severity: High]
> Can this new branch be reached while bp->irq_tbl is NULL?
>
> bnxt_clear_int_mode() frees the vectors and irq_tbl but does not reset
> bp->total_irqs:

I can add this to the first patch in the series to clear
bp->total_irqs more completely.

pw-bot: cr

> > @@ -13118,13 +13187,29 @@ static void bnxt_set_xdp_tx_rings(struct bnxt=
 *bp)
> >       bp->tx_nr_rings +=3D bp->tx_nr_rings_xdp;
> >  }
> >
> > -static void bnxt_adj_tx_rings(struct bnxt *bp)
> > +static void bnxt_adj_rings(struct bnxt *bp)
> >  {
> > -     /* Make adjustments if reserved TX rings are less than requested =
*/
> > -     bp->tx_nr_rings -=3D bp->tx_nr_rings_xdp;
> > -     bp->tx_nr_rings_per_tc =3D bnxt_tx_nr_rings_per_tc(bp);
> > -     if (bp->tx_nr_rings_xdp)
> > -             bnxt_set_xdp_tx_rings(bp);
> > +     int tcs =3D bp->num_tc ? bp->num_tc : 1;
> > +     int rx =3D bp->rx_nr_rings;
> > +
> > +     /* Make adjustments to rings based on TC/XDP/shared rings policie=
s */
> > +     if (bp->tx_nr_rings_xdp) {
> > +             tcs++;
> > +             bp->tx_nr_rings_per_tc =3D bp->tx_nr_rings / tcs;
> > +             bp->tx_nr_rings_xdp =3D bp->tx_nr_rings_per_tc;
> > +     } else {
> > +             bp->tx_nr_rings_per_tc =3D bnxt_tx_nr_rings_per_tc(bp);
> > +     }
> > +
> > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> > +             bp->tx_nr_rings_per_tc =3D min(bp->tx_nr_rings_per_tc, rx=
);
> > +             bp->rx_nr_rings =3D bp->tx_nr_rings_per_tc;
>
> [Severity: High]
> This is a pre-existing issue, but this clamp is a new way for the RX
> rings to shrink, and it leads to an existing out-of-bounds access through
> non-default RSS contexts.

It's already mentioned in the cover letter and the commit message that
this will be deferred and addressed in a future patchset.

--00000000000039c821065dd026db
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBa6lBX
3k7ZepuzMobLs2tWpp+Ytw5x4a/eF8rJ6Cy8LTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMTQxNzIwMzZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCNxXU11vTEA1xWjWX6xO3069HyfboEX/Pd6KeSOruc
yGf71Q1U0otSLzBnhs9UiNRDWNKmqQ9T7yjeEUWZ5kVvhlOGRQtYv+QtZMDgiuI8gwBu1Gi3omM+
Z5bB/00aOyqTp+SJ2l/u6cqVk38gIUazUVlVEBkJfjR5f7yco10VO9uQnzxK1v1RpRKBTjU44Sux
ClvbJhmghheNXPHRy9JgTcps3bXGcFKanWCPYxn79+8I1ZxzahI6BRPUY0Hk0XGE4WgifkaZdCbW
JNTiAaT3GwtAgWSJNywNDU+uurQ5hkrvJJSVPTdDOGZLVbodCn6tFjR0/3TVHgFotjRmmr+u
--00000000000039c821065dd026db--
