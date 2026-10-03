Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1861165F16
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036502; cv=none; b=oVgxVZ35wmmhk2zITyJFmb87oXpekFXhWCwuvKY80fa/EFlhz2KH/uN0WwUL89z+ogxmcg8PkLssRBhiCDMFqiIop9aAcCmJDfkPIzrbd3T8MIBoDt6HbR1AEfmNkH1akwR9oT8y7fXGnBhynmxQOXFostTWx6vfFQMlUgC+Um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036502; c=relaxed/simple;
	bh=sjca9CSFzd8kNo9c17Tzg58UXK7jxZGPNjpCmFu/kNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tnpj1gA62GVkht873iqplyJbSl1dcWX6gfL/YHBpgU2NZbxrCbR3DKjl2Ax6yVeiotVKaQnXJFLvfWQQkBm3ZYlhT9gxq2/q7OkmmblFC4YKa9UB6wGG5N7uTX/SDi4GN4Pj9AygQT8cKcLuyn/1SkBT6cmk/GZ6/Y2Mnka/HYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GopjzKCv; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GopjzKCv"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a0bb4967easo13262a91.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036500; x=1791641300;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jW51PV+9bMOAzKrFuy83zgTqTf77TZjsefse0YNj0Ao=;
        b=XFrkBbSVJC3rDn15VsgpcDpTCvzd0GR839l6ekQZWRSuKY2RYxpr+5PZKTmR1X6AEg
         Ak8X6kbCstXSDpwRWdSx0RdRfyjIskKauMnRpg5NM1YuuDyJHnDriwGT33J/YLf+H7w/
         5MLtB+T5LnT6KqVWz901xjCxfYqRZy1WapFXc6/onyVgKrsnATdIEuHytI3lvSagPh99
         2sj/T1YAy5+RvhH7c8UfcWpIn6u5H9QxTag7t392bSMaarBQ4b+XMgs0DdpskK85N61V
         9+KtvLzFI7LMNqdjg6oR3OEgXrHgbxdS93ayTkMEudqtpDs8opgrAimU5b2g9iOjzLCd
         OStg==
X-Forwarded-Encrypted: i=1; AKwUvBw6Xhp6NMEMM4VpGHXR97QkvUUSBB0dZt3LvWUHaM1wIAq7m/54+9olmapZ2/QT9MFnNU4ec0s=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/gWBM/pSPyvSnrT1l8H1yD+pNxBuI7Jfgoyp0mbfOChZD9FeC
	MY/eY3n7CBWsc/FZ6/jHZBA0QCRlpjCaiauJaV+vhxrYzS08o44ishybknKk0oyja5+m6EJDwGm
	TxQmqVI4ASsZ5yPS9Q/alxFjScUVfr7W9W8xLyZ7KO5jsUWJhZs675Dacb3eBQyfjcELU6FSTXw
	NoyH6k8aOu07NOIk0jwXDAZN9h+2DHLWM8gFiruPG7wScMHPQwKMKmmuz8f/laNLxBcADnPFW4r
	xxnfzGWWpB8iQ==
X-Gm-Gg: AYBFou0zt06NSPFxyTgGX6kjp8ipFJbah5NF+637T+tIeYTLasrefJslnLBcgcaSllp
	VLdEbgkIFE2hfsMFgIuD69P9XJdPETFMtpXxoIN7rKSzxejBIznQAJ8vKe4UqXf1ZYhl+rxnr0c
	mswvK7vxz4/bcnEfNiWBxYwoLUano+tE5Z8xC+cFmWFvQjMOQil9+RxEjb9NCi2e7RXHdrjj2rq
	ZGjO9nOJty91+//ExKTBY3i/r59hcVvOn9wlsknofqqh2zbvGONvStDYyPzbwA4sZfpSlVANmzP
	JhGfAWr+jv87LkF8sSx8EhdH2Dk7BODN+e6f6xJAZ1jQ0n96wAgkzvQtkC3Wg/PgJOhIvxTUO6S
	pkTl19Rrxg4pJGANDeOsM7ePbNtlCmUQ9sy/zz2gHs2JCAFP1//T6hFlz43kLiaRDbZrmqjSL9o
	Ttm4lSyH27mcw9KvjHn+jbfZowebbeNkmycmY=
X-Received: by 2002:a17:90b:3c48:b0:3a5:352:c21a with SMTP id 98e67ed59e1d1-3a70f075150mr2103347a91.43.1791036499967;
        Sat, 03 Oct 2026 07:08:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a70160adeesm589233a91.2.2026.10.03.07.08.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2026 07:08:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88c76888646so265933b3a.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791036498; x=1791641298; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW51PV+9bMOAzKrFuy83zgTqTf77TZjsefse0YNj0Ao=;
        b=GopjzKCvODtRYW/WtWdOMKEH7fMd3ZWMqkOWZG4e5fXyB0mZJo2aeDUBACpPcovw4/
         jsz5yr8hOyjxp5kw5PhON+ETCcz09l5jjN+SARUnY4evqhHgpb1omzj9aZaBt5l3h20j
         cImAspGVx8VHqptRFNPsxxC73RcQAxm7MacN8=
X-Forwarded-Encrypted: i=1; AKwUvBxxKx4FPvkWMslOJlk9rKqKeii5o5sEz/5vcc3DOuDWsCe5SLe71dCrAARKlPPDGFPBmTGws8w=@vger.kernel.org
X-Received: by 2002:a05:6a00:4004:b0:880:ea3d:d70a with SMTP id d2e1a72fcca58-88af5f9379amr5752184b3a.38.1791036497968;
        Sat, 03 Oct 2026 07:08:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:4004:b0:880:ea3d:d70a with SMTP id
 d2e1a72fcca58-88af5f9379amr5752153b3a.38.1791036497538; Sat, 03 Oct 2026
 07:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
 <179056950861.31693.11019543022435274443@kernel.org> <CACKFLimaQ93kqXsKn=VhaByUfsi51HEqjVmteNyPA0z4uj-4Og@mail.gmail.com>
 <20261002102402.37c89967@kernel.org>
In-Reply-To: <20261002102402.37c89967@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 3 Oct 2026 19:38:05 +0530
X-Gm-Features: AclHuK_Hym8gtO67HD9mpje1hHKYTEEkloj6rBmP47eGzSMk0BTZUO-NcmHxQM4
Message-ID: <CALs4sv0dRxxkZobU1er3skAuN_91B__W6Z3nEqfffe3FEzEzag@mail.gmail.com>
Subject: Re: [PATCH net v2 0/9] bnxt_en: Bug fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev-bot+sinfo@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com, 
	joe@dama.to
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004422da065cf02e9f"

--0000000000004422da065cf02e9f
Content-Type: text/plain; charset="UTF-8"

> Hopefully Pavan can adjust the net patches according to the AI review
> while at it, at least the suggestion to explicitly remember state on
> patch 9 looks trivial, on a quick read?

Yes it does but only until I tried the options and each had side effects like:
Recording the abort and returning DISCONNECT from slot_reset() fails
the whole reset domain.
Returning NONE avoids that, but the early return also skipped the
restore, resume()/netif_device_attach(), ULP restart and IN_FW_RESET
cleanup.
Serializing with bnxt_fw_reset_task() via netdev_lock can't cover the
window before slot_reset() takes the lock, and risks stalling the
shared bnxt_pf_wq.
Stopping the worker (ABORT_ERR + cancel_delayed_work_sync()) is the
only option that may close the race, but since it changes how the
firmware reset state machine is stopped (lock ordering, and the close
path running twice), it needs proper hardware testing.

So all these just started to grow the fix further and well beyond its
scope..  so I replied to Sashiko that I better exclude it since the
issues exist already

--0000000000004422da065cf02e9f
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
AwIBAgIMClwVCDIzIfrgd31IMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTM1MloXDTI3MDYyMTEzNTM1MlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGQ2hlYmJpMQ4wDAYDVQQqEwVQYXZhbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANGpTISzTrmZguibdFYqGCCUbwwdtM+YnwrLTw7HCfW+biD/WfxA5JKBJm81QJINtFKEiB/AKz2a
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCayMzz
KwlAuQUtqXx4RvxDWYjnYbU0tL0CnsTUqmidCDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDMxNDA4MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBqBKSM3zbrZA8XQFUY5Vgr+sCZr7fyjsIMns6W32NX
MlGcgnOGQ7JZWPwvepAisjI5f9Bbp/5urMDznGgIavXii+x7wHXgkJOkuyJthvrmGpdexcgMHjat
7wf0kgKPI6Sx/oA/e+W2O8MAXWJ3enSw2o+9C4FjoWmexhVonSmvZCYtttu8wOTGCZ6lltb0XEZL
kOJ0gTGKCj3QWozhsu43KF7oh5pRFTlbE42xtbbZtVvPt8DDk8LWhRD1BiJRG1jSSbfWfka64wk+
GN0X7Hu+lJcNlSlN6WXk8cOSH6079R7FYzu9c/E+v+H6aMEtHR5mamRyquM7sVDVl0k5Bber
--0000000000004422da065cf02e9f--
