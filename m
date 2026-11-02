Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647241;
	b=rmp88VBjpPMAH7Z7ZxTAMvDGtCCmfH43I1dNpR8XqleC3KRU2YEXp7WsVkfkXfpCWtK2
	 sf/Foj4aHpA8UrsKJ78ym73/ZvFFJ19OTqxMvFfvy68hu9QUoONUIcx+kJdySOcKZCPwQ
	 JPxbXZF8tWB41oy9wL1ykcFT7VBDVvYLk3a715c6cWFlpPdA27Oh7hSP9OHMFJmufAO4x
	 DEmM4tUkshlnxGptSTIdKbL/sakNQZKD26AcTB6qTeGawJ5EQYDIZVD03AGu9kFJ8Wltx
	 ZhlwTdCuJW8eAV+bivsZagT2WIYIAKLmPADyDbvdS83Lsk6YVd302ngkNj+g5Ohjrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647241;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=C9gbJ2AaIgek78gnbLxRAhG7EHJai4xuoh3WXAP2Lyg=;
	b=1yUnCwIPL7Tf3LY8NHRqGC/GkFJShb2gZe5TVbhR0OE8lHCRbT5vtQIppAElw3cmGD54
	 PLva0+4TwCj2+ALY1YsQfDDyYHwNdpvyoYxEEaQpwaJXsyMuQS9MzZpuqe+uacRKtQcJ/
	 gcXzvVFi/PbdHwRT6PblsrsYdaIyYpOhmJxFR297BPBX6IZ5h6aJOY481exwUhDkHeZZN
	 PL4oMXTVdqRxVWTIN3ycWDOkQ2dQGE7nYGf+2zL02Mc2QZQdeyWd25n7qTQtJUDvJu7FN
	 nwWP7dj3bmKdypTl9ziFeG/zMovs1OFA35FM+L71b5eoklF8M/PqImfCJgR3TMkwkvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JwMNuMzg;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0399606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0399606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JwMNuMzg
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e9995ce866so28825775ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647240; x=1794252040;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9gbJ2AaIgek78gnbLxRAhG7EHJai4xuoh3WXAP2Lyg=;
        b=nA7JMTgvJfdm+EdflfZ9G8up8ymbWc+rL8UAepsX0Lz5ACSNE3WLbxTPlawi0ghKZK
         mCE9LtePr8iqc+tJEAX5JQ7HqkkYy0ECdycszjcU28CbnIGAFXG4E82jhMvC7nfWmeZX
         XXRxZpPQptVeEsOa7auT9DgCLp1Po5WHNdHme09T+MPPjx+zKkPTqN3kdlUU/KfiTmt8
         lwGzrWr2UsiOYoWfDyd80qOhocb+fUm//GnlMH5e9kuxq5iLB2dGg5b+x7Rc12YBcYhL
         Qws7yxr+EGnlhdwhp/b0qL0um7Rrom1lqERbOxtPXkj1XWwV9JkWUv7dC+3edTYiROWP
         4/zw==
X-Forwarded-Encrypted: i=1; AKwUvBymOJ6lhs4FK58LlN2LwNgNs1KmXkDv5zVGrj5oS9sUCC4I+CKPJJcJlsnVnbtK42qPj9gHhvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F4LFk4PoVHG6GmGFB9s6uSvjz14bNFgluVjUymCtW+4GTheSk
	ylJsb5wBwFkerGa7VX9WuSj7SI1Beqm8bkILJWU6mV54dr7JWgTabMIP9ogwWqH8GY6EOWPOLQe
	Z7E2PK+9Z9nqRJklNDqclnoTQjNajLH3Y3IjFF5AyGrkQOwdzJn5qtiAC0vnbM/DKpr+T0kBQDt
	8nSfhroFXfut7HYDUolVqvMMyS7K8NuiRNXxWfkUfe0/jgwGOOKBoIXBvhw2ECnESn1DuI5mqW+
	85ssYJ7Kjk=
X-Gm-Gg: AYBFou3E58hYZ2HJEJPIUKzApUGljB8y/g2qEEc4a2B4Vu14oWpiL7PfvOWg5xKOAHs
	EHWwnWEuImSdA3L+PZqxEoWYZnOnaupD3JLu+naoEurfmVthBDbTWgHem/6dp/xyU1XdPvt1ryI
	2OhtCegIAwrX5sppNWKhb97UxsCqeRIp2tG88vINhW/HXcuLxmY1ynp5hp4zUP3ufSPtfZ3mpqq
	9WQ2XCkGLvdeecGYm3Dvj/NrfZoPBitGDZNdTpk2QwoNw9gTmMRTDZlHEGGd8loHfXt9X0095vb
	Y0OHHXVDknwdTPXEZg1oQKnxOq0czmax/yFBAzE9cAHZq7ENdmFZndGxLY9eNg+YdacZrgzjr3v
	RZ53IrLiO8+49/KoWDZgbuiHXNwVBjlb4ZeOuyPZ8htlb1V5UxNEtorki/gYGRYEVgiWjwHVEs1
	X+skeeJbJxh3o9FpCmsj3/kJXkPniVK40v0Jw=
X-Received: by 2002:a17:90b:1a82:b0:3ac:53e0:4ed5 with SMTP id 98e67ed59e1d1-3ae89797489mr9272786a91.39.1793647239978;
        Mon, 02 Nov 2026 11:20:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c8297absm214818a91.4.2026.11.02.11.20.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 11:20:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c414c206673so241610466b.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793647238; x=1794252038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9gbJ2AaIgek78gnbLxRAhG7EHJai4xuoh3WXAP2Lyg=;
        b=JwMNuMzgDeu9ryCwEps+KdzvnJQE8CTIlWd5P4+o/koPvaUxGPmO903GMttnwjIMgS
         HilveBeEsIIlyQm0j0b14zXFVwr52Fhs5ypaJNSaSwUNvZNscJKxKriihta8CFlwkCOn
         943Fu2d550UGeunlgUphrmq/jcsb6enZ/ROfA=
X-Forwarded-Encrypted: i=1; AKwUvBxfjck6pawR5zaCm+PcRqA+Z2R4BD2+qtUpSD583fk6lOYiAVxM1NIogeh+ADrUTw79nMo+Lgc=@vger.kernel.org
X-Received: by 2002:a17:907:969e:b0:c41:8e21:4d5a with SMTP id a640c23a62f3a-c4ca793c08emr880252066b.5.1793647238079;
        Mon, 02 Nov 2026 11:20:38 -0800 (PST)
X-Received: by 2002:a17:907:969e:b0:c41:8e21:4d5a with SMTP id
 a640c23a62f3a-c4ca793c08emr880250466b.5.1793647237724; Mon, 02 Nov 2026
 11:20:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029032832.1511180-1-bcochrane@google.com> <CACKFLimgKYe9Ow6UKivoyXaFU5UGEKB7Tb2VEUQ83=5Dghyw7w@mail.gmail.com>
In-Reply-To: <CACKFLimgKYe9Ow6UKivoyXaFU5UGEKB7Tb2VEUQ83=5Dghyw7w@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 2 Nov 2026 11:20:26 -0800
X-Gm-Features: AclHuK8EO6z5qqqZMv9IXsN9W1_-JzKAVx0EtVnZVi_zqy4EeM1iiqQFl2bYuRU
Message-ID: <CACKFLinnoPdJs=TLv_OOxXcWez-zfMX9Q+L+s8ponqvjG3Yshg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Take RTNL before netif_close() when aborting
 FW reset
To: Bryan Cochrane <bcochrane@google.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f2bfa065f500af0"

--0000000000007f2bfa065f500af0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:59=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Wed, Oct 28, 2026 at 8:28=E2=80=AFPM Bryan Cochrane <bcochrane@google.=
com> wrote:
>
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 0682060b048c..0f37639b70ba 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -14798,7 +14798,7 @@ static int bnxt_get_registered_vfs(struct bnxt =
*bp)
> >  void bnxt_fw_reset(struct bnxt *bp)
> >  {
> >         bnxt_ulp_stop(bp);
> > -       bnxt_lock_sp(bp);
> > +       bnxt_rtnl_lock_sp(bp);
>
> Thanks for the patch.  This isignificantly increases the scope of the
> rtnl_lock to cover the whole FW reset sequence.  I'm concerned that
> with a large number of VFs running in the same kernel, the rtnl_lock
> contention will cause some of the VFs to fail recovery.
>

Looking more closely, I think the case that requires the rtnl_lock is
very narrow.  Only a PF with active VFs will need it in case
bnxt_get_registered_vfs() fails.  For example, all the VFs now will
take the rtnl_lock for no reason and will cause unnecessary
contention.  I suggest fixing this bnxt_get_registered_vfs() failure
more locally without increasing the scope of the rtnl_lock.  Thanks.

--0000000000007f2bfa065f500af0
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBvZkXz
PgehN29Jx7JoPvvf6W+RZ9/dspwvECHZaRgTyzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDIxOTIwMzhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBh9xWDr4S6VHI9DM6fk7/Qe8TSPkyNI599NPPMt0Ud
p3nZgvv3aK6B7v4ZxeUf+AeAU6iAyp8nZP1T0yFMBh9Rea0Y0q3g7ant0YyQro0lpRm2ZqFX9zVU
HwOh8hAvrL9IE8RFYFo66Yn/JeM/oO4hkdHUXc/QOkFPF+fdpONErOTAmvYdEsxLhbDdwdUaDPp1
8tVdx6lhmEC+0/h2EWOre+ImrjD1Z968PEWlHxx2rBK0oadThzugEYI3kbZDlpLaSPYY/KzW0ZlS
2WuFScQqljIc4YwH3zUFsZ3NNtTC6AyRlEO7BGq9QBCkRaOP5VA3fV5FMfmIql13wqwD3QV7
--0000000000007f2bfa065f500af0--
