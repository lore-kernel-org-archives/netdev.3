Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC7472551
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629302; cv=none; b=GhHC4K1zeS+ITar6tvmrYMCZ686m6nvMTcloyW4Xn/xvdP9WpmN3EuC+vu1LAjUUSlvOqaPtcdq7dOlmy5IgPHDCWOrdveoZx7oxYWnd7i4kGkCSJJ+zw3rdwEgIVMDRjqyPzvppCXS0X4puIzj7H88zBesm0/zx3CAW1ci1zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629302; c=relaxed/simple;
	bh=g7luEjfNpNeMSl1ebKUsv8uRQa3kwwaxaaqZyMw111U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IstyFDkI206J2mu9mJtAaFdlliqRG5SdcXwm+xYSZ7w3wKakjIpa9UHse9ZTE2lHh6t5XSGCxplrRPabzdEBHioJ5eivjQvE/dlV1S+cmqOKhVWnPR9P79c1VuEY8tAOULsTByrf1C0EZVOQiWCo9t5/DQz8nCHMc6aqs8ifqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QdwNqL+4; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QdwNqL+4"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6b35cc0a8c3so1011711eaf.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629299; x=1791234099;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cy7RPqK7UwFVQbvlNiVxMODJcKe3nAwgrQlgZ5FM7jM=;
        b=b7Wid8simvenkidxC6cqNTOVYu3d+ddOtmNRYDHHxICZc7JgxX8P/Z9s98ozjtaHEp
         3rfxkEpctGP3kAmuIYh/h0lBtBQEg0VoHkrD886e9SSDFi6XdaBR+EGsdaC6hpJjoFKo
         xz+Nkl6j1M7N7bPor2cDLcn3DZPTGRyMn1t1Y85le57EAWMIBCmsAgZCvTfuHZrYh0jc
         u5MRUsvX+d3z9Gz6wNMOjeLJqo7b3a6O9w6xWb74w+ufHLdt/II1eJbKRLJIWsWTzh6Z
         JoCv/GtfRilDTIiJt3W6+Zh3AjUjY65TpeP2arhHc+i1iTHB8m5WZqP3cTRxPG+a+jkY
         8Zeg==
X-Forwarded-Encrypted: i=1; AKwUvByr00cTNWnr1qMgV1U7GlLHMU5VhrA2FgmRUVW3i+aGwaZQVS0PXLngyiunOVNA41VhUBKVi1M=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ4aPS82xQq1tiz+JtJpPcGcmpvZpbZG8NfZSnZDo1PkPFe+vC
	OAZhmKsAu5Zd1WC6MtZu7QjgagmaN0guMvxk+R65NNkb6V7900QaFImejxJV+XVKCKuLyQLdg4j
	2UGekSjfZMx6Fv8lBUnRVEN+vUYI71LZOumPWKnSyZxn3KCX4uYYzkHr0bQIM/gUrVhRcrD5Lta
	CfrydcV63pnLC0rHTT6lgvOSgLDt3h+ZGY1u3gIUAPERrz2nFSnxyrbNy5fi4g6iYRT6uTObgXq
	8c/DGSdpGo=
X-Gm-Gg: AYBFou2LEbCLa29Ci9TZ8pI//OfNHCsZo6eqED9ADJQE4XtMuNEffvgdNIDWo6Z1mJz
	NqbKK50UAGHucHbAW2xdYLFZYAQsGfq004p0eEMESoJdXwmpAiJcR/Gz/Hl4JmFLA5mU7dR/HLP
	AX9a3udHoSBOIjmWv25vO7demKK8Ax3WYSsGEU8PAXYPq4L29PSsz+8nLbG1JTifNobzYR6bS9h
	C6wpdd9wdezZD+w+AUYX+PGaErzjNY2DlZkHUKEuTwXfKtjmNeZpNSkpum4awnTSmjrQ2xi1xY3
	Ka7IuK42Gehb58HZr5fw596hmNPQ26ZBiWXg4tUTk4VPGRoeImmNciUuBmt16Sq1rsyeKacANlo
	rBf/wLE0puMom1f9GwW+GyT6dTb4lK6puJklRN+/wmGok23K/RqmDEcZW9vdbNhQ9c/vTZxN2eL
	5Iav5UIf3IqsetGhLRDMfiJNkjqYs/nUteS/izBQ==
X-Received: by 2002:a05:6820:180c:b0:6cd:3ffc:acf6 with SMTP id 006d021491bc7-6d44189f49fmr12652543eaf.70.1790629299525;
        Mon, 28 Sep 2026 14:01:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-81d5316ec4esm765590a34.0.2026.09.28.14.01.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 14:01:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2939083cefso375816366b.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790629297; x=1791234097; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cy7RPqK7UwFVQbvlNiVxMODJcKe3nAwgrQlgZ5FM7jM=;
        b=QdwNqL+4JTAndHj9dNaUST6QMKyIwU+gJ3I/kdGu6Q7BIp1lYArj4PX5b2hoP92lnx
         7F2mmphhpLq2UeKRuzna0QRhlWl84g1XkPv2I93Bw4RKcL/oMuLNC2RW/KTIGWXdtOnb
         noQ4oYTU3IuCptXCJU+mXeR77KjbfZi41ZZQw=
X-Forwarded-Encrypted: i=1; AKwUvBzXv18wsV47inQounU2fKx/ZoWOEced+l0vmPMudRR4JrFtoRdBc/Uz0WCBSICMp0PgP4BbYOw=@vger.kernel.org
X-Received: by 2002:a17:907:c614:20b0:c2d:d9f4:2c85 with SMTP id a640c23a62f3a-c2dd9f42eaamr223977266b.41.1790629296836;
        Mon, 28 Sep 2026 14:01:36 -0700 (PDT)
X-Received: by 2002:a17:907:c614:20b0:c2d:d9f4:2c85 with SMTP id
 a640c23a62f3a-c2dd9f42eaamr223974666b.41.1790629296414; Mon, 28 Sep 2026
 14:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928131458.1012180-1-vnagare@redhat.com>
In-Reply-To: <20260928131458.1012180-1-vnagare@redhat.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 28 Sep 2026 14:01:24 -0700
X-Gm-Features: AclHuK-LLZxY-7zBIpHr84SeFAGdZgSZVV4ExNQKznc8Jir7zMPJ2Pq3fUuX6Jw
Message-ID: <CACKFLikzTgx_2cDdxFeKLJpdDt9iVxL8FG5NMXQgYQbeBk8FPA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: don't leave an XDP program installed when
 the open fails
To: Vaibhav Nagare <nagarevaibhav@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vaibhav Nagare <vnagare@redhat.com>, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002ec54f065c915fbc"

--0000000000002ec54f065c915fbc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:15=E2=80=AFAM Vaibhav Nagare <nagarevaibhav@gmail=
.com> wrote:

> Restore the previous program when the open fails and release it only
> once the change has been committed.  The ring and feature configuration
> is left as computed for the rejected program; the device stays down on
> this path, and reconciling it is left for a separate change.
>
> Fixes: c6d30e8391b8 ("bnxt_en: Add basic XDP support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>

> @@ -435,8 +433,16 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_=
prog *prog)
>         bnxt_set_tpa_flags(bp);
>         bnxt_set_ring_params(bp);
>
> -       if (netif_running(dev))
> -               return bnxt_open_nic(bp, true, false);
> +       if (netif_running(dev)) {
> +               rc =3D bnxt_open_nic(bp, true, false);
> +               if (rc) {
> +                       WRITE_ONCE(bp->xdp_prog, old);
> +                       return rc;
> +               }
> +       }
> +
> +       if (old)
> +               bpf_prog_put(old);

As mentioned in your commit message, the driver's internal ring state
and the XDP program state may be out-of-sync at this point.  I think
bad things can happen if the next open succeeds.  Ideally, we want to
get everything back in sync.

--0000000000002ec54f065c915fbc
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB6ZWOT
B5LJ0iTpCQvWHCR96b7oxm6S74i1j7LPhg1V1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA5MjgyMTAxMzdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBB/UuaImP/4LsVBryy8JLyrdLgJrQpsh62J7G+SARy
z+OWI3wtnchWDVqLp2aaDPPcoPvz3/KaLbiX2taJ/rGsDgkgFILrLndBI9CKOOn+8xJaV9DVv97/
ihhl8cdBBEiEQM33mlMfZaeC46jhq0mHatLJV/pbYPD6ZxX8f540ytpBoOIbju+iU2hUkksVuYsP
C55sF2+6VNDOTvjmhtNNmSH+DErAQGL5KXdnKaxwWbwEtrxUKUF7W8MQFxFSzyYSONFYb+ejY4Fj
Dyj/r2oait0Js1d0vdW8KFS0WYLOwWeDwIt35Wg7EBRh0NSNUZHkqXyEGzRfZdSwztjBw3yX
--0000000000002ec54f065c915fbc--
