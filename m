Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CE3B7B9D
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394933; cv=none; b=JzNIhBwS/2hJWP5V8ymJ4mSKtwd7sct6K5T2+7TlwDABWW1DWS0gF9/wyQZ/xhRje9RYHlbgHNQVW1kX7wjrScc9kgm8sTGPxx2yUsetZlfN94PKeX/+K0yoC2MSoFgiIkSb7U1kMuGJhEadLUCP5EXmvPgt5h+kqyNbWt+tOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394933; c=relaxed/simple;
	bh=O5sq+tu0o2B5VNgW6ST1mGlsEow4DvN/rDcyWVg6Yqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t20GqWKJh5el9MBRJmDzXqwrSo8mxBCLMxAqmGpl86lSkJx5AxEQam9MEHhF3GGa0AQkwaDkgWrDz2jwBkZfv/NTwgzxVMiKR7a04iBHlRBAQjFrPKYh7TRAPx9AQHbJ5fkmShGX5WY/gtaSpAkWK71uhgI5stXPn1yoIdXBsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R6LEXbwm; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R6LEXbwm"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cbb85186d43so899985a12.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394929; x=1785999729;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a8W0KLaBoukJ00eiMuX1f8RJZWOKVeaB+AUv9LQYM7w=;
        b=Juz3miVlCsny9a6Lxqa6o0xJhaai0ZFbzG2H9yznPNp2DzrzJXYr4puRWTr7lpOkpP
         jWhH0iVvvs8ubdxVRccXFwTUEgpyyi50VvItNe96fyfBDYEBP2ttoXPe0NyWkQAnM2bE
         e+EPySNmsYfr3N7Jfx9qT2/zuvFT5j8MCrMWPriOhfuCBSIsMWxykCpzl7kNP9A5EB5Y
         i1dijDxYXcK8qdfw3q4zHXBGO8uU6SS02zXXhTbVm6Zi3w6052Eg8uZaR+PxcAz+t04E
         sv5P3gBJQYISwobfVNO5o+/3orefyUoEt/h5iP6onU9/t2n6pdB46ITLPje1Kc6N0+3O
         0Ufg==
X-Gm-Message-State: AOJu0Yx9bnJI9kDViCPlWRo61GxlI+V6mi/Keb8/COsHJXzi2R+aojkF
	U/pTKf4eJ+9yNZE8pu0w8E+BmY4Kvjud2yixXcjHar8QjRrz8L21HnSY/IfCASLFRGtkJXrW5it
	a8u/xkWhHNlXkoGwHeUAn168Jk5T3sGKiqdLKXZm7ECZ56Jd3ZacsNI4LEf5alC4/NNeOwAbI2V
	pgbTrcjwBPrx7pUCyCLuQrSMBOSYzCqis8wusrHVbZA+CGUNvmg7yatGk54jv4D5zwQk9AOsDCK
	WkeVpsHUik=
X-Gm-Gg: AR+sD119l41C5u1CKSQJH/rQ488baJUnhVj21SjyZoxIjbZnfvzwZVaCrkyzrOTCkcY
	NRk6AS5CO3DrWTyotlWNsbuMpyEON/K7zmjsbIOVk1aKNxLUqMfA+wO8p4xtMDOzq70E1yXgtQr
	Ku1dAogjvo/rgRFe/Kf2/AWe08jIpHGDQuOnKhzeHstSvEkDv88eFrHgqQZsDoLk9a1HgZw/Ib8
	AxRVm4WukeNuJvVaTxvxNKRbOuy8JW3vJ4E17bjtc9jBHcSXatOuv/sH4OTN7PnBklM39aKxaLM
	iNY0/UHJ0wpS2ouJPuvr/4reoFZLay4MbT7taWwbDkHZ8pBLHgO1iK2chdYogja0tGhZtAUu8YT
	wkn3etQgk4xAM59dlYGRdixhO7j+F7g5OGi2c8R0Ajh9a6IbcZ2Ky2V01CfJBYhizCZi/MLmM1Y
	oJCuh8M3qfsBernu7PbGkTTVAF8bkqiVKVtXE=
X-Received: by 2002:a05:6a20:d612:b0:3c8:d3a4:7b40 with SMTP id adf61e73a8af0-3c9006712e1mr1357257637.2.1785394928817;
        Thu, 30 Jul 2026 00:02:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-31504d16cb1sm335237eec.20.2026.07.30.00.02.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2026 00:02:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15ceb17a28so147309966b.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785394926; x=1785999726; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8W0KLaBoukJ00eiMuX1f8RJZWOKVeaB+AUv9LQYM7w=;
        b=R6LEXbwmznhCczW+FX3ECt1tVNDG2Wtj6HsAWhagl944iXwVRAvSJY31mou3IJMV8q
         c1syUeLCdyrNr+SRH8rKIVg+PdCbJa3MrH7cW6oa5tmvTu3GsZgxLuJF6Y6F5qP78d50
         KPlnxWdJ70zgiWWyYHtXtmLkzO5HprvF7PjzQ=
X-Received: by 2002:a17:907:b051:20b0:c16:592b:ec4c with SMTP id a640c23a62f3a-c1fa5510096mr41998466b.1.1785394924897;
        Thu, 30 Jul 2026 00:02:04 -0700 (PDT)
X-Received: by 2002:a17:907:b051:20b0:c16:592b:ec4c with SMTP id
 a640c23a62f3a-c1fa5510096mr41997366b.1.1785394924430; Thu, 30 Jul 2026
 00:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710042400.3996847-1-michael.chan@broadcom.com> <20260710042400.3996847-10-michael.chan@broadcom.com>
In-Reply-To: <20260710042400.3996847-10-michael.chan@broadcom.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 30 Jul 2026 00:01:51 -0700
X-Gm-Features: AUfX_mx8-HoUXGr8cCy44p9ke2lSzW2CGywzIba5YVWtFrCyOanPyv0pdf_HMc0
Message-ID: <CACKFLikbzDjmk4+wsAmubKAuh3sb=EE6-5EhHdFC_CHeVa6oUg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/15] bnxt_en: Add infrastructure for crypto
 key context IDs
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000065b0050657cea699"

--00000000000065b0050657cea699
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Responding to Sashiko comments:
https://sashiko.dev/#/patchset/20260710042400.3996847-1-michael.chan%40broa=
dcom.com

On Thu, Jul 9, 2026 at 9:24=E2=80=AFPM Michael Chan <michael.chan@broadcom.=
com> wrote:

> + * The ID is matched by its hardware id only (epoch stripped), so the ca=
ller
> + * must ensure it is valid for the current epoch.
> + */
> +void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id)
> +{
> +       struct bnxt_kid_info *kid;
> +
> +       id =3D BNXT_KID_HW(id);
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(kid, &kctx->list, list) {
> +               if (id >=3D kid->start_id && id < kid->start_id + kid->co=
unt) {
> +                       set_bit(id - kid->start_id, kid->ids);

Sashiko:
Could separating the epoch validation from the free operation introduce a
time-of-check to time-of-use race?
The API design forces callers to check the epoch via bnxt_kid_valid() prior
to calling bnxt_free_one_kctx():

bnxt_kid_valid()
  epoch =3D BNXT_KID_EPOCH(id);
  if (epoch !=3D kctx->epoch)
    return false;

If a firmware reset happens between the caller's epoch check and the execut=
ion
of bnxt_free_one_kctx(), bnxt_clear_crypto() can advance the epoch and
replace the old lists.
Since bnxt_free_one_kctx() unconditionally strips the epoch from the provid=
ed
ID before traversing the list, is it possible for it to inadvertently set
the free bit on a stale hardware ID that has already been reassigned to a
completely different connection in the new epoch?

Response:
No, there is no TOCTOU race.  The epoch check and bnxt_clear_crypto()
cannot run concurrently when this code is put to use in patch 12.  The
epoch check is always under the critical section ktls->pending.  In
the shutdown path, the BNXT_STATE_OPEN flag is cleared and we wait for
ktls->pending to go to zero before we call bnxt_clear_crypto().

--00000000000065b0050657cea699
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCApU48i
yqoj+RZ3/OivgpV43CGhW5KVh0Ql2aZiheGmPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MzAwNzAyMDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBkaQFTvVvMzwRHohBxbosQ+p3FeXFJ49Ulfor6hQv6
EjeYvJF0CbgkAJMkeLXnD1iakFMqICYWkWeb2wx/9gGVkUdgn9RY6ebub/Ov5T+dqBFOLUTkhzfs
z5SgVchQFTpLRit5HyTj/H2iaY7RQqKSgotqdqKZiyXuLRiv+9DKrVJISOFaGkpIStSoq7y9trai
9tGDgywPSCXBZ0dsYzp72UxR9LVIDbs9/ljcTorl3e4CdevAg4WQRL+CZm447DeWimQOCnD8TC/T
z1Kybq4zYQGYAiRZ04mRgHjMd+JLgfER/yQfdo/UEM1ixk2XYqOgDg6R66Ft2Tr0Bya9nkPD
--00000000000065b0050657cea699--
