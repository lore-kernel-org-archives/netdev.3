Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35030261B9E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102309; cv=none; b=LWv+I79YvvcCj5OMoiKLKVVkF9MftSDjac0AvE0K9VmlMywtrvRpe9ik2KF8Ro0Lf9jatfmrV2eY8e411iX2rzmEECqW9GL1QXjdt6hHclBe2i8CfKLPAZ+r77oGgsyjKYFpdcD/V4dBXdV6J+ht90GzvGeFA2Od9u4Pkv9nfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102309; c=relaxed/simple;
	bh=C/wLZ1q08BiXINnQNP7FSZEFYVdJ4akk2q8Y50+0rf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/07pKhH7ePSiEOzMIBJpoTJP5ldA8u2nN2f7MWnTLPGKGpF746YQKt4YDIpUiDuQoWmfgpYuGBrauEQuE0xPxzYLbRqO/5dOmAmKFXW4tHuuNxnF/Nk3opI7CPiOpHxh8I6Trft7/kAw1ts5SrT5PTK3RM8ivSfQnraJ5CyJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bLtkFEmO; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bLtkFEmO"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3163721a91.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 04:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102307; x=1786707107;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nrUbz19XZeH00X4/8ygyAfE39JXGL1cq+2l7l8iMx4s=;
        b=i1eRytMCfLhAnv69dokOfdBNHemCzyqgIoCVs5kTrckXEnOGFuZVY4dobRRLS/qRlD
         tR54GOvo0J6ScsR/tfBSAHLKnEJOanNBptfMyliqJYFGb5sgW3pqfETWdXRdLAjUakEQ
         B+VPmn6iVa/kf4sdWhzdNpJj/Y++D79i+65mENa/8bYYJuu5cwgftLTN2BLv+slVU0YN
         FPn5IW8eiyhoWh6kDiB0tFLgUweDEcy2H8bqooJbK3VBLeiyka0/3pPd4Plce4g7Pb2K
         a6Cq1tNqNAZzWFVzzS8jieKM1jGPq63LK+7UcmpJAxuU/UuZwsWpNJ61cb59guIvDmma
         yCuw==
X-Forwarded-Encrypted: i=1; AHgh+RpxVBGynR80jwwnIhh+sV9VPmGLT08GwySYIgASqn+V6Er3JAhsU0V5mm/6JCW5lBaTfmDUn4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YygV3Om82UA9XskATSPxJBEaUInFIIHlGb5BMcee0k6q1UohmkO
	Z998fRHwpU2Qmed4Ox04MxOk7TI3hH49ZpE2UHVhcODdTeJ8qD3tGd9qiVt+qfTOYW5pzH2xRln
	QJJ2GnIE/ysT5l4Be59RNAXx1V82SfxNm6RmtEpjqNcachkWlKfAmUCtBOhfm6dAM6wi4Pq5djE
	l//UrelYPb/x9qM5SxCo8MNxIqiAoxVf4EZC/BFw6R5fSxvbRYEi81mk1EPdTDp/JbH1Flcp9Oo
	SheUDJIs5VlWoTFjC0=
X-Gm-Gg: AR+sD104JGVApJXlj8NWtx1wzuJEcNxqe5KoeSxJ3+gkh79sVA3kD8cs6rUoA4/VcwN
	5yMCOcmUTXyMVpMbZbBFVsErWbYf4yRYDTR5gZIb9d74LKxUu3ncXNKoxRkcUyWMgw25X2u+TVo
	3kAcKFXmHdEuNoAjAp4V+vEh/F0PqWkJyANlOJlhPYFJH1vz4AqwQcYwbRsOUZL1ljCFV5HpmGU
	FZv3LBiJhWUj9BU8c+RdfR3YQGTa1s/VqGBwWf79eFtlL+x86NBw7+HDDH8FmWsSkeMm0elpx+t
	L7TceEnFqraRLFgzZkkgV/dXyMNeHm/ieBZ61U9G96v8zDKx2ln3kWCoxJnZ/sQG9S9VVKgZt8Q
	aU/C0X3CglKIeyObROh+9dmpCSyfpZ3rzZZhD/6G2YXsH8TPb9m/ATM/vniipv5Xq5XxZPLm5yK
	yKY2q2FKBXSBulSUuEbdy9VncmzgXaTWOEQLzAixJDC/8=
X-Received: by 2002:a05:6a20:c79a:b0:3c3:af85:85e7 with SMTP id adf61e73a8af0-3cb860767d6mr27695056637.34.1786102307188;
        Fri, 07 Aug 2026 04:31:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe8f34ec5fsm183431a12.6.2026.08.07.04.31.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 04:31:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92efd2ca21aso568178585a.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786102306; x=1786707106; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrUbz19XZeH00X4/8ygyAfE39JXGL1cq+2l7l8iMx4s=;
        b=bLtkFEmOFp9F+EkRvEjnN3hi45vuifGrsLMw3PbzwNHcUl+rx+6VLlRH1NT07tonjb
         uuJ6DhrArkuTPdJj7eJ6AnqFtnG+x2gzh/Vt+yhczk+ny2RURX5BXnXMpixS/2Y9DQWa
         Oq6lXvZklFumYqmvhoKXWLaz/+syL29JXA15U=
X-Forwarded-Encrypted: i=1; AHgh+RqwcVuSvdPCaRhF1phgmQWn9G8xTFFh2noVeSW4Q50irQECCLSlwk1gAHnOJIuOAPHffajB2zw=@vger.kernel.org
X-Received: by 2002:a05:620a:6189:b0:92e:8310:7369 with SMTP id af79cd13be357-936491e1f72mr2383137185a.37.1786102305815;
        Fri, 07 Aug 2026 04:31:45 -0700 (PDT)
X-Received: by 2002:a05:620a:6189:b0:92e:8310:7369 with SMTP id
 af79cd13be357-936491e1f72mr2383131985a.37.1786102305372; Fri, 07 Aug 2026
 04:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803193135.2030368-1-kuba@kernel.org> <20260803193135.2030368-5-kuba@kernel.org>
 <CACKFLin+Gi8t=5spT6dPrByN2NqS8XFUp+kU_+YZ89t0Qu3Qtg@mail.gmail.com>
In-Reply-To: <CACKFLin+Gi8t=5spT6dPrByN2NqS8XFUp+kU_+YZ89t0Qu3Qtg@mail.gmail.com>
From: Vishvambar Panth S <vishvambar.panth-s@broadcom.com>
Date: Fri, 7 Aug 2026 17:01:34 +0530
X-Gm-Features: AUfX_mzPMcpi3AvNoQLIfeVZbsy-Jtow75yEtFBwb2RmNacFc1_CfDR1Hd2jezI
Message-ID: <CAFnwgOsBJEC5iNCcWuM7u9aPPRwpvCuTtRiMaN6Rz45G4w-OOA@mail.gmail.com>
Subject: Re: [PATCH net 4/4] eth: bnxt: avoid deadlock when canceling IRQ
 affinity notifier
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, manoj.panicker2@amd.com, 
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com, 
	wei.huang2@amd.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007c5db906587359a3"

--0000000000007c5db906587359a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Test summary: on an AMD EPYC 9335 CPU.
- Instrumented driver to see relevant debug logs - init/notify/update/teard=
own
- smp_affinity_list of irqs modified under active iperf3 traffic
(irqbalance also active)
- Affinity modify with concurrent 'ip link down' (~20 iterations): no
hang/deadlock
- aRFS/TPH coexistence: verified packets are correctly steered to the
relevant queues.

Tested-by: Vishvambar Panth S <vishvambar.panth-s@broadcom.com>

On Wed, Aug 5, 2026 at 11:32=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Mon, Aug 3, 2026 at 12:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Unregistering IRQ affinity notifiers waits for the callback synchronous=
ly.
> > bnxt takes the netdev instance lock in the notifier (to restart the que=
ue)
> > and cancels the work under the same lock. This may obviously deadlock.
> >
> > Move the restart to the async service task. The queue restart isn't
> > super time sensitive. Store the new TPH tag, schedule the task.
> > Safely canceling the service task is already ironed out.
> >
> > In bnxt_request_irq() the order of registering notifier, affinity and
> > initial TPH programming has to be inverted. I think it was racy
> > previously since user may trigger an update as soon as notifier
> > is installed.
> >
> > There's a small known gap - if pcie_tph_get_cpu_st() fails at init
> > and the target tag is 0 we may miss programming the entry.
> > This does not seem worth fixing, the code has skip-on-failure
> > all over the place, anyway.
> >
> > Fixes: c214410c47d6 ("bnxt_en: Add TPH support in BNXT driver")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Thanks for the patches.  We'll get the patches tested in our lab.

--0000000000007c5db906587359a3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVcQYJKoZIhvcNAQcCoIIVYjCCFV4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLeMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMalZbmZD6FXfcQy+JMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI2MDEyMTEzNDI1MloXDTI4MDEyMjEzNDI1MlowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEQMA4GA1UEBBMHUGFudGggUzETMBEGA1UEKhMKVmlzaHZhbWJhcjEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfdmlzaHZhbWJhci5wYW50aC1zQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfdmlzaHZhbWJhci5wYW50aC1zQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBANpu3GCZCkPicX8s+4lspfAvfcGho9A4om13cu/IBWjxjRIsja9W
TI7PAjb79QJxni3rTseOc3O+VTt0BOuoGj3BSGU9zeEWjWIpYbsG1AGrb+gv7bVWfsqU7B2OtpxD
2CKcy43knX1J0Pc7V6x9IMRGppBkpCFXYxpO/Y4TM/EN/RxLe2/7uTQXeIZ0Sv4u/WfTMlcB1FeZ
4S+HRUFipq8CF5xsBIVZKOwbioKJpnb8Gn3g/ms3fewwFyR0P+e+cnCdk5eKKPbzIbNwCshXCczL
/1l1dpIxcZkAEgkZ9bbQjTzEUOJJln3T7kZSyCQYEiYclnyPa5/U4kUsmELBgGECAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfdmlzaHZhbWJhci5wYW50aC1zQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQUIYX40BeXfns3hhTp61Fr7mJkorowDQYJKoZIhvcNAQELBQADggIBAB8elFxP+/s/U6W2
6vrZA3TW3eJthxRLgi/EcOcPOp6lkTXDVHutUWcP2yvgjLKw3sLCBTqimQhVkRQVQkSZkwemSDmF
4iAUaiDKXNGtMUAV+iENISNQwag5hBZ0kaSBb4fx2E9uo9ofbySrKxspMnqkzJKOJ0ADlijf0/EB
gy4VRU2YurRDEk5hcNK2mihGQjoOgEZltZXjkb2SziVF/v9AiZLS5kfddI7AkAVleHsf01uSq0Hy
g2S1GXtM4OuelrT6SICqNXorkqBLG29jjm5UeV1bYQRZHQcqVUJ+wBu722Q8KjQ+Tq4S+Yu1kFJD
7Qtj8svRQ5YTZK7u4KhJ7HzsTUwQxPMwqpOqcimGP0kMk2V1x0obXfaKuMVmutDl0r5oLtIoBCM2
HwR20P/XhDEbDFLyT2T7QzdIkI31wEUerWYftMiS834JK9CxvrjN7TF6olSS8sCaGrvy6lfMHbiV
5irdLs/QVpEOj1Kb+xAtgulfnD1LCQpnCCypBFshSC/IZjJlGU6u1CwhUlz0c2n1Etpd73pkqWhv
ejLNOUM8KHJhqT8n2hZ93ixxZhC/9LDIqj47KHC+GyayLLsxX+rwxu7Mk5edjqs2Ytzazji20NmD
+jMr/z4r6uPPOt0IKgxJfefnth4RydIr0qzpIxGoZodOPblVReYnZTUwOu82MYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMalZbmZD6FXfcQy+JMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCBr1gge74eoDyJBpXscCrIR+zGtOtj4Rlu3adDd7iQA+DAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MDcxMTMxNDZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAB4/Mf8+08
EssEcLYIrrYiQ0z8zDvlBR3QjoO+XwK3xrKCg9tJ1+XZrLzsNebs6nQfof601Au2UP9erjST14K3
tIJVdVwDQLO4biMWMcqdO2ZQ9hT20K/bspPJyBBqW9oIpNczjTXPgfKqxvZYVOzQ+96e9a0rD0nK
yOrtwBPPtiyeNMMGY9XppQDKZow4WYeRWcdRf+kf3VO/i4zK91sQ7p4bZ3PwmFDjSw60Sw4wNZjh
ulL6xqewoN03rMtWgnMfrUYnh1B90YfAQhJLugqkq+YvzYK0WKTVeu9Y0keuWELcd5Gtx2FYGnqE
hA+u06saPSxGCsg2fg7cojDQsJz9
--0000000000007c5db906587359a3--
