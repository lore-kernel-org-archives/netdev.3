Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28239478F
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392465; cv=none; b=Vlbh9BJtDeGgc5h2NEYkF0lgmvkwcl4nMGQtv2JouRLgCSQmd9evTu5y4bt1tE+7t2laWRLoj+w9Mk3qtoNA7rpajpukz4FnvP7ooB0ox+PHB2+OwiPYMVWvHK7vRMQk+2/DAWQj9Bwb50V99GwHVb8XOcnXH1Kg+bIwft9KPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392465; c=relaxed/simple;
	bh=Ojte/xnDOrYcqjA0NPiNcJM6mXKzHDk8LRd+ad66K4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSjaUS4/bV3KjzaRNprWK1zTF7XPF/YNKr+tdDQNL0UREEJ9tRn0qAVgNvCeceobKMV/mggocgxlOK3zZBE0ZxHoY186vuZFXXQKTwm7x+balkBPAJM/eyZom/o2i1ZwXE2b5AsIyyN2y/4tJP+Kk1BrIWY8ecQXm1EFixksoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MLu+1WSh; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MLu+1WSh"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-7377dde7bc6so314922137.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392456; x=1785997256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GkVFjICpP5NiP8s/68ou3Uwae1GckQWm3+ASUr9KGQ=;
        b=lRiNo9nUxvHh2kYzRYBtxqlNd+u9ORX4/P0nWWvEuB6qvHpeb1q1uIaVdv9OSgydbK
         nK9j0kD2gGxljwRanaxG+ChpuRQf+d7PRgJkNkN4+WR2G8RX6ol3BfnSH8XpONKQfaEe
         5fSKlVMwKZo16fQP8BDW+rE6I2d8vOCLP8+pgSHq0FOnmaI8xQy1Wm0fkaKaYwlfJi0R
         79SV2GoY+k2GqoZ4valGVpDhrwWH92XwA1ohIZ1m3kWbDodn/cvieUHkNBkHZUcPVbOx
         pW3TMycqAYpSlnlZ58Z7ZugYqq4HzbAFo1BG0wneMQi5cZvNbQry7JbV04MyP5fnImB1
         qL4g==
X-Gm-Message-State: AOJu0YwCuqC5F9L0K2Xn+lrAnlGgefTcbGtGeJqBvwvpMX9545q9IFnW
	WqI3ANmt+NYpuZMmkmVX+MQrhfAVyWODWbZzcgXXaV4ZPfy8eS4RyxeGT1ZeuEoOXVBs/4XXEYk
	Ag1nLbrcml2p5HnwAnRlzpZFXuoeZO8Sm7pwsDdgb+ba5hRuK6hLHkaVbKABn4d1MFuPq+LOEFH
	VqvFMjysQHNRN86ruNPPqBssrAeCI1HLJ5nyJ/EOhcDKmPKmpfMGSwalUkM/HLgJMxv2PL9rsBp
	aIwKnLSInk=
X-Gm-Gg: AR+sD10zTT64gAEudao/AAqiowVjJyGu5l0CazEMrYGsGEDj54C2elUK+zflYEuVuZi
	yM1Nw9ZhnLslt0mX3vfGex5IO5XYT3KIH2zJUJTGw4dGQMxlLCaar+5G8bAn1gFuSNktuV2lqxb
	Hxbwo0xwW7juKds52GNZwDeYXgCp4kl5VkkiEp1OMCNy3wqWM+ewQDEDx2J9ZvVYVP4zojN4MCV
	2LHzU5/f0bTC+1KECrtAZOWiKip3547hxxe3MDqn4fCrAnZi4BHiVM7Z9Ti5/KTkDxPKgFMF/Lf
	wt/JYOigTkbw9L1WnBysVfl0Y5RUHh3FD3SSgHOuocja0p5dZ9PcdXNOxYpkmVFD94zoSF4VSjk
	rUb6DMbRLuUmUOzaH2nGLL04daxjjdlI9hjB3elsVtKM+8C7KmGXWEPGTdWzowGCHvFsCSVX/Tj
	ifyhM8L8futQd1a6UDQ0hp0ptSiRx+DyDQhqk=
X-Received: by 2002:a05:6102:2920:b0:632:5db8:f672 with SMTP id ada2fe7eead31-757715418cdmr303772137.6.1785392455955;
        Wed, 29 Jul 2026 23:20:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7575bf9c9dcsm84393137.28.2026.07.29.23.20.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:20:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698af52daa4so1864787a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785392454; x=1785997254; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GkVFjICpP5NiP8s/68ou3Uwae1GckQWm3+ASUr9KGQ=;
        b=MLu+1WSh+2/cW2tZeY2+MUrEw88b2dNZJy9KsFfV02tJwBb3FX9Q9wNVfug7uD/9Kt
         2Kux8Vsa9/TNyohlcMmOZw4zI9gGYWBrKqpwxfsTGQBABqMwpFPzIH4QTP/9/X8FFzIZ
         4WVySIhFBGGxkSMCVo9EUpCgW16KPh7xCob1A=
X-Received: by 2002:a17:907:1b12:b0:c15:d0b6:495c with SMTP id a640c23a62f3a-c1fa57399fcmr55486466b.29.1785392454461;
        Wed, 29 Jul 2026 23:20:54 -0700 (PDT)
X-Received: by 2002:a17:907:1b12:b0:c15:d0b6:495c with SMTP id
 a640c23a62f3a-c1fa57399fcmr55485066b.29.1785392454068; Wed, 29 Jul 2026
 23:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710042400.3996847-1-michael.chan@broadcom.com> <20260710042400.3996847-2-michael.chan@broadcom.com>
In-Reply-To: <20260710042400.3996847-2-michael.chan@broadcom.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 29 Jul 2026 23:20:40 -0700
X-Gm-Features: AUfX_mwce7EHACE9RZ5yb85OTGjuwEZgpNuuLRMPx9BaL4NcFUYqlWXH_CKyFJY
Message-ID: <CACKFLikxe4C7b5QcaV71dBTfd=Tw-Y_nPBUFaMjP8NrzxhTGjA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/15] bnxt_en: Add Midpath channel information
To: David Miller <davem@davemloft.net>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000c9e2d0657ce133d"

--0000000000000c9e2d0657ce133d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Responding to Sashiko comments:
https://sashiko.dev/#/patchset/20260710042400.3996847-1-michael.chan%40broa=
dcom.com

On Thu, Jul 9, 2026 at 9:24=E2=80=AFPM Michael Chan <michael.chan@broadcom.=
com> wrote:

> +#define BNXT_MPC_CRYPTO_CAPABLE(bp)                                    \
> +       ((bp)->mpc_info ?                                               \
> +        ((bp)->mpc_info->mpc_chnls_cap & BNXT_MPC_CRYPTO_CAP) =3D=3D    =
   \
> +         BNXT_MPC_CRYPTO_CAP : false)
> +

Sashiko:
Is this macro safe from a race if accessed by the datapath?
It appears bp->mpc_info is evaluated twice. If a concurrent SR-IOV
configuration change happens while the interface is running, it could invok=
e
__bnxt_hwrm_func_qcaps(). If firmware returns mpc_chnls_cap =3D=3D 0, that =
path
calls bnxt_free_mpc_info(), which frees the memory and sets the pointer to
NULL:
__bnxt_hwrm_func_qcaps()
bnxt_free_mpc_info(bp)
kfree(bp->mpc_info);
bp->mpc_info =3D NULL;
...

Response:
This theoretical problem is only an issue if the FW suddenly drops the
MPC capability during run-time without going through a reset.  I can
prevent this by only updating bp->mpc_info during reset when
everything has quiesced.

--0000000000000c9e2d0657ce133d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMZh03KTi4m/vsqWZxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDk1NloXDTI3MDYyMTEzNDk1NlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzENMAsGA1UEBBMEQ2hhbjEQMA4GA1UEKhMHTWljaGFlbDEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AKkz4mIH6ZNbrDUlrqM0H0NE6zHUgmbgNWPEYa5BWtS4f4fvWkb+cmAlD+3OIpq0NlrhapVR2ENf
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDFmCK5
Bh27x+B3C3EPp5QfOAzd5DwFtx57Wn1jXRm3IDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MzAwNjIwNTRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBosPg1fsI3TSUBpUEgVXwcxUXw2ChHzmNxzbym6WhX
T+aiW3BGqgtgC5qf6KPa+SfbsAknU3ygnp2MGzChRHZ9kAGiP/nYZC/6vTu2G8xNjxBBJckKLUuA
yzsYF9YD9ymSz7K7/+F7CKeejOuZ7N2UY6ZqklSFrstimfRTqfWqnP0oPLCqhLx3ovDi11kZ0JSa
opCgGEGnNCXV+2q6C2EUUqp8iRvpyn7eqfvsaj9uqCqXNcGIY6/Hpq16Hp0L5xpOK4YoDWJBa+Pg
XCnCrn5Eq+yHO0mpR5rDMMztOyCpcZttNfqnG1uejTG9L6WTXL+fm0VEoz6nlOVypoi3wQS9
--0000000000000c9e2d0657ce133d--
