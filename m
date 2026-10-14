Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6068415F15
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998949; cv=none; b=d46t2D3BaT62QBgjpxNK2YZOp+2PEO3Ox1Y0Tc8XCv1xvneG9AXY0gffYogtrarRHlGAh4U7cNWBd6mL3b+i7SQzujhzfyOcJGIQc5cziZWfPgaFHmaKd4fj36vlgb9qUweCnBYcTOwJURCaBlhIRcQJYBlxvRQoYSACaLxgvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998949; c=relaxed/simple;
	bh=YpLes+oaPrusJdCipeiNw52CsTX6UCk1Hacl0pMDJF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi+HXxu36x0auMo86G6qk/PHTnxIhz6koGtflfNB3DwysWV0BRU9qu6XYJMU8yn8/cdsSEZuW6rHBQjf5YyYgxZpUflEEmzg4lEvBNyHkt0ReqKUOY/QEK6DRhdNWnWIRNCkoh9vmLL+H9F6ZkdRwTQtrdAHBSbnNrjvis9Kv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E+w2A54T; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E+w2A54T"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so851339a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791998941; x=1792603741;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LkHkF/hHlkR+ytTfAEPiKMDaQUY8nRK+soOnCaRZPyk=;
        b=vS2Cm3AHI4Dbsyvcfedawig78PvFsp+s8gmD2b7XEMP+omV6lnikARWWEYv3QVNhfn
         4GaqWKsOzT9j7QEJ82RKnFyrJEsekaNVpt1fKoLK3AtW8aqrIaEhH8mqoKPKapqiCBp+
         5+99wd3TglPbPhdcEFJgAVWshNtezM4RdpXpoqPqZiatiRolUX1uvSjIsMD/Blatg5QT
         LUz1q5kg95d4eZjFHq9sUXYnuldlQS3DNcoMPZUQLgBfQbz39i4+vTER/UXU4HjaIXAD
         I3fzXiCoQ0SMZibpuyThFVo/s9z/R2sJk8Olu6V1JulKb70CFr0lZ71/gXcxdvJ55Ynq
         YVig==
X-Forwarded-Encrypted: i=1; AKwUvBwOPKhRhSbZ+cVIYh0kOwObWatdVEPOTPtQ3BO9vIQbxK27TBomKdbRqOl+73qWdCiF/4Zxkkw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKP9uUMgKi9uKljBCstpb5YDLur9Gj3UOYmJFIKyVfE+gXuZvsQ
	gpjzpx57v8sSDIWnnF6GVeyFnXBsibd8ZxNEvNfIdQYxYUqMmkr0cvfL29xVd4l+ar6gYMkc2Pu
	k7dtD/ElPlBIrlJjVuy3PSGgqmh+2N5JzvGhrpc7ypia1vB/YR2pB715PPQxhCGoqmC8yZsdgNw
	fplqM4UmwAlG0RmhcTzqvFAl4+znvsuaS8EIkLdbUX5R4/dBSF3X1Z2Wg8GoAj/J49r2f2OdVkf
	LTq16x6Sdo=
X-Gm-Gg: AYBFou2GumeSwAjiXWpong2drhgdbAH/Ukuqd/ETckOjXHK9w/rCagJ1jR4UzTj9gWE
	HHmfejNtybwSimAI2pSVqnqPYi88UlUGaegakx/GL9F0ceksJd0AS0CeNJ7sGUdJj/i2SSAyEjC
	lMSgn/5r7F7e0FHlBz39+fvYYYvyLX9Yg8WaBkMB2AstbkFt8w081f/QNgzySOOHRPKyU0H/f9t
	U7DdV4bLofb87W0gDMGWejnStQpCxI0uPCYZdUXJl9SOoOFcJz78ZqSk076h8g8LOnh6nDTiRQi
	P2iM5PYMQnL+BORDfbKy3YCgBhG2JXQEoYJXjC8cDgyQJSScsvTziNzM4dHX43R8+vZMAUT60xb
	8YC5CMZtw3/JYmC+x1BSeIFE5+DQcNW5F2ahdVAocRLe5KnI0+uodbrQxJ0RnCfRbb9C8WCH9/p
	Uux+/EaAZDrpiPkdXWngPVNlVd9GrHHN3duC3Djg==
X-Received: by 2002:a17:90b:510a:b0:3a8:e2c:af52 with SMTP id 98e67ed59e1d1-3ab3a93eae8mr13180565a91.24.1791998941389;
        Wed, 14 Oct 2026 10:29:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac931ee2f2sm81480a91.1.2026.10.14.10.29.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 10:29:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2942fa0995so458159466b.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791998939; x=1792603739; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkHkF/hHlkR+ytTfAEPiKMDaQUY8nRK+soOnCaRZPyk=;
        b=E+w2A54TtdzLSOGtTUaSV4h21iJOzaCJyOKdUcj2hKDdhZkczZUF8OfGCk09lsD5wn
         j6kuDkTlxI0wUnUfTnJvx/0n89zCkN2+T5NUcamPbxfeO+AyHHG5LJK1UbPjzT1KfCSK
         XXFAgqx50BOUXkz5L863bkBdPE6IZJODJkvN4=
X-Forwarded-Encrypted: i=1; AKwUvBw4aQ51puOMLnIZNGFigb/spdjzxIeCXBg5YC0sHpfEg06sxcZNfxsMUKsjQFNRj4r8II1IJZ4=@vger.kernel.org
X-Received: by 2002:a17:906:630c:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c31a9d0ab5amr1600290166b.9.1791998939428;
        Wed, 14 Oct 2026 10:28:59 -0700 (PDT)
X-Received: by 2002:a17:906:630c:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c31a9d0ab5amr1600288366b.9.1791998939056; Wed, 14 Oct 2026
 10:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012220827.340998-1-michael.chan@broadcom.com>
 <20261012220827.340998-8-michael.chan@broadcom.com> <as6mq_WLUJ-SiXI7@gourry-fedora-PF4VCD3F>
In-Reply-To: <as6mq_WLUJ-SiXI7@gourry-fedora-PF4VCD3F>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 14 Oct 2026 10:28:45 -0700
X-Gm-Features: AclHuK9GFH-FEv5KB0Rx62TenFC-luDSvXAG5WNK5gJsy8shuEwhVxHsXlKU8Dg
Message-ID: <CACKFLikF=Pwp-yCcmk2oSiuropFQ-U3ta=HXPMHsFGzzKXL6vA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: Fix ring accounting and
 validation when rings are constrained
To: Gregory Price <gourry@gourry.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003c9e4b065dd044f7"

--0000000000003c9e4b065dd044f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:50=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:

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
>
> should this be:
>
>        } else if (irq_re_init && BNXT_NEW_RM(bp) && bp->irq_tbl && !rc) {
>
> Note from the LLM was:
>
>   Unlike irq_change, this no longer implies bp->irq_tbl !=3D NULL.  After=
 a
>   FW/AER reset irq_tbl is gone but total_irqs is stale, so if the rings
>   shrink we call bnxt_change_msix() with no table and fail with -ENOSPC.
>
>   Should this also check bp->irq_tbl?
>

This is similar to the High issue that Sashiko found.  My plan is to
fix it more holistically in patch #1 in the series.

Thanks.

--0000000000003c9e4b065dd044f7
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDmryE6
yejRSq58zw+ITKhXRrvF746y5KYO5W6oWFVuRjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMTQxNzI4NTlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBw7+tzfuBuSfAxs9ZBuE+YsZdtElrCbgc24S22n5Fl
DqwZMnloGpC25FIyeXPbvmbQEHONftY+0GIwVnYjBA0VDTlTm6xQVnR1uLJDbqtJCVW+pIrbUDGD
H8LDQdxKOaGsvu9AaQA0LYflBUqucvf286KjBgU4JDZLwtm3lztUWvrnFS3GwvIzs4Vn4VPdPgNr
tVa5ng04S6BtTOTpnKG1pOmMCf1lvLl9EN57S+KiDnaYvi4+fkK5pxIXsgCmbWSIhtighmmWjlWv
AxehQhiNF/zATFQDu4ggbmnFM9uyXQ1MGFQOg+SBlIlaVH2CiQxzKwPIe30411kfpKYntKzw
--0000000000003c9e4b065dd044f7--
