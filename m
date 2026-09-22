Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A353424D47
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099688; cv=none; b=Lk/LpCD66iDhlUCYrKsqPAe4BC1hVs/KLBBFg5hxHdsFpQ170Ciry8rtDtV4sLFowqpqJIxzQEUPwylXZna6BMTUW34YvulrN2XDGbxCuxvQDormMhdAAPpRkyJGa3+snxRzyy+Uw5YZFrhpjrG8dT7ODOAIy61hOrSasr3uAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099688; c=relaxed/simple;
	bh=K1MOeZdwQaNY1OQCMZZsTbdMYOP0S/DRljrRbUJDXL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oypD5yzm9nR4ZR5F1PGwZCcPaaq33nC6wcZcdPfKF+3OW33Fti9/EyXuRs4axyzdyWGpCbg99cDGI498j4lCbQjjslotdanAYSCPoJT64TTTdoYP+QDELZL1IX3OfaE1ZcN3RxVWDP/qfmYuYfdq69P/NYVcwwsgWaDzKkwqruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S3jsheX7; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S3jsheX7"
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-4cbaed7776aso5414b6e.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790099685; x=1790704485;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhBquOKO/9HRk/ACfAt6LL/8IlAX/xuUQGAEwq4Fiik=;
        b=vV493vXoc1xhQZMLAgzgreIjev7gBnA04ifmY5zTmYxnp3/nyfqz3ykTVbvFh1agro
         RXX+C+a+5NuXJa2igEwg+JepneQjV4m9bZP5pa96W4Cr+Shap5xSQ4BYCcXaYU/ayvrZ
         MzzrQd2PxkECb6cydFPvXRzKQC3j3hgKsJYuYSSPMwHvnCFpSbRBYd62a0Jd5pti+FX+
         4W4VWBfeSktVVJcldt8LR1nqb6iPHQV3FtF541utyDm3wE2qj5Eb8Wxz1tgHWtoHVNkP
         v53BImvxmElcfGW31QlOqXOVvmw7uyAOXhBQKP7ZmhOJJksOMv/nRyjKfHKfPN2RUtbI
         ZFIw==
X-Forwarded-Encrypted: i=1; AKwUvBxlUNTRXNSnE4GSoJya31MvpOI5mt+bOx7TICDmD0frAQ860aSnafX3CLY3vZPChGEsVI0BZ9M=@vger.kernel.org
X-Gm-Message-State: AFuF++miwLa4G9xDOZn55FpGALceTDMlq+reTMWRxb/I0/YBEzxbtE64
	XAbtnt4f+kCmdUNy3yszZv2cdipn+2osonqzMMjAo4wsMi8dFycpvIxjtRpkh9v5XJcsNNDdbCQ
	2QKQL1SUUByRf6fuNAUxh3hW2BO/b2E9I3g6DU9uKmiTz/7EKjpZYNQrxm/xbI7UAOFDVDrYpMK
	gEaLh9YriXqXbGBqNYMXWxkoohlBr0oX/u8VvI2n7CBoxcNcjQMVkaGOsg8ZeMBK/eYBDZQ35Kx
	J6/KWZS
X-Gm-Gg: AYBFou2uM9OybzavcLGk0nKaCX9Q1D5bYEPoM+Z7SR2GNxjLG3OAKdDVZ/XySKh8lla
	cSL90u4J9rcDw5ddI0J2daqxOJoKTrhoE0cs2ptmxB/1dXgaO8LGHMVxoybdAaJ4Ev6PKGg9LO8
	IOSA2ggH+w/M0FI1upjmwOM9oghEHc3tzKko+1AFGBByPcBvcGRI3bv476WVHSiMn4GCsQoyiVi
	KrVJ+wLmu4rxT0tmNjY6VsnfiPB/kyb8VANJBErwaWE1sbjTZd0uCnHKLpJ8QTvRWMxeuhjBg97
	R1VLmmkYZelN3wk1nvU72y9WMwPuteoQs9w0COaWpsrQM7wYO4K28/IjEmBfzKwzt/BOU68IeYD
	q5ad9XriMYFrexMyTS/gv22ObLGczfXBTUNPvXw1acvrfgfjfNiif2DewhoYSZ0KNElgfHnexu4
	gVm+HGCIZ1skEMsnFcCZLrmkSSyW4G4kDBXeA=
X-Received: by 2002:a05:6808:3081:b0:4c3:6abc:db7a with SMTP id 5614622812f47-4d5b72f6ccbmr197349b6e.10.1790099685192;
        Tue, 22 Sep 2026 10:54:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-815fe98df97sm62608a34.0.2026.09.22.10.54.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:54:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c252686999cso4918866b.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790099683; x=1790704483; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KhBquOKO/9HRk/ACfAt6LL/8IlAX/xuUQGAEwq4Fiik=;
        b=S3jsheX7ghIQN/XOGRBJkC8R5bzB97YItKEJ4nqGkrMVKSDxJpgHitInTDa4JgWh6R
         MMzqvZLIriJRza6xgg7RDHSuAaZxWI6zbY6oJjpEWbqdGBSamXmyLIkEabznVOFQnPbR
         7opikTOmQ51uUI1F531UY3TgEm0b5bDbyKG6c=
X-Forwarded-Encrypted: i=1; AKwUvBzablK0PrDrDshTGjWXVxeZH5i+ol8f+92ssJOTrV4i/SjYAz8KcZp15OE7l7DNyv3PMz1dWiQ=@vger.kernel.org
X-Received: by 2002:a17:906:6a0e:b0:c28:f9e4:836c with SMTP id a640c23a62f3a-c2a157c36c4mr1359936966b.28.1790099683291;
        Tue, 22 Sep 2026 10:54:43 -0700 (PDT)
X-Received: by 2002:a17:906:6a0e:b0:c28:f9e4:836c with SMTP id
 a640c23a62f3a-c2a157c36c4mr1359934866b.28.1790099682926; Tue, 22 Sep 2026
 10:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl> <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
In-Reply-To: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Tue, 22 Sep 2026 10:54:30 -0700
X-Gm-Features: AcwNN1VxZOQcFFCm7caZKqYMY5PSHL2XX9LEeKhSmLyKVEfu0HCiGbBZkwyQ0Bg
Message-ID: <CAF+opq12yFHNZXUoWn24GnBozm7Zvfwh3FiCZRsDypLw7WY-pA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the datagram
 receive path
To: =?UTF-8?Q?Bart=C5=82omiej_Dmitruk?= <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c03b1d065c160f3f"

--000000000000c03b1d065c160f3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:32=E2=80=AFAM Bart=C5=82omiej Dmitruk
<bartlomiej.dmitruk@isec.pl> wrote:
>
> The send hook vmci_transport_dgram_allow() refuses datagrams when the soc=
ket's
> netns is not in global mode (vsock_net_mode_global()), but the receive pa=
th
> (vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not,=
 so a
> socket bound in a non-global (local) netns received datagrams from peers =
it
> could never send to, defeating namespace isolation.
>
> Add the check at the start of the receive decision, before the
> VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
> (matching the send side).
>
> This was found by code inspection; I do not have VMCI hardware to test on
> (compile-tested only).
>
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Signed-off-by: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>
> Assisted-by: Claude (Anthropic)

Reviewed-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

> ---
> v2: perform the netns check first (before the hypervisor early return) so
>     hypervisor datagrams are also gated in local mode -- the Sashiko AI r=
eview
>     noted v1 left that path partially bypassed.
> v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmit=
ruk@isec.pl/
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -532,6 +532,14 @@
>  static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 pee=
r_cid)
>  {
>         u64 access;
> +
> +       /* Enforce the per-netns mode first, symmetrically with the send =
hook
> +        * vmci_transport_dgram_allow(): a socket in a non-global (local)=
 netns
> +        * must not receive datagrams it could never send (this also cove=
rs the
> +        * hypervisor CID).
> +        */
> +       if (!vsock_net_mode_global(vsock))
> +               return false;
>
>         if (VMADDR_CID_HYPERVISOR =3D=3D peer_cid)
>                 return true;

--000000000000c03b1d065c160f3f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVJQYJKoZIhvcNAQcCoIIVFjCCFRICAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKSMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWzCCBEOg
AwIBAgIMHGPVyo1dPk0L1YjpMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTQzOFoXDTI2MTEyOTA2NTQzOFowgacxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEUMBIGA1UEAxMLVmlzaG51IERhc2ExJzAlBgkq
hkiG9w0BCQEWGHZpc2hudS5kYXNhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAPEY89b11ClzTI1CBq2y3LCkw5NEYbHct4yPyyo/b1eCT7N3NUXN6lzWJBSIAaJi
Uihtp3klVTSW2Sku+Gk+eqm4dYIrTQ8GdAPidPDpJm0hK2/KaDn5Fm0m3aAtln31QF8xIwQtk/i1
R/NZ5tTafc0SyuWmEVyFR825FbSoi1HwMkY1/lsU/2Ny0PK1+9WamuvV11QKd2dN0bYDXrT9uWC/
Cw+IDnr+5S21lWL9xM3S7htf+QjbSezM58DicE0QLGoXIYZ98zGOum91sMMgq2YfQKCVeOcD/7SL
0tftIn9SftUtPTeRab5qssPI8Aqo18uk3WxLqQRQv57jHWDis/0CAwEAAaOCAdkwggHVMA4GA1Ud
DwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGG
LWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBc
MAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNVHR8EOjA4
MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmww
IwYDVR0RBBwwGoEYdmlzaG51LmRhc2FAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSDkmQlbsGdC/WLbyB/
f4VlMvD+ozANBgkqhkiG9w0BAQsFAAOCAgEAYv4/sGMrazXrWECSGMFJ6YIDir3jLsYCcD/xTMfS
bXSiWFQ/ZiFLbxfVV9JJKkkKR29ow0Eo1fBaZMCDhnax7746XJn6qJ0Iz5MyLKFB2DKt3UO2q1PB
+wh73XKXTx6FDnbFRDjtyam6uKjknIMrZcFVTyFwUiY9zKz5pK40OPx4ZzdWxOCKMnCblGOiqvS+
gHpKXHRfCd9Ul1teGR1+muz+L7fJfrx9WUBNDFFIhwZEevLSVo7wIoyT2PG0fIk2yjKCFOT3CVVy
E5LT/kzQHjq7Y36GeUxozu21FbrNYm4Ivlh1OV9suNl/3iN1j9kFAdgg/8QXh9USKmg2zaS/S9lc
1YYUOS+Epg0WBwhAwWtVym636KWqu4Esgz2XWX1260rHG0sIxkdxzvBwsUYpf3e1axBlOHHr1Jz+
vDtQVeBUS7fBAVDWnBJrKNn+jseGnpcqBDQSSNq1kB44XhKZFApne6lKSCqYkE3qXnr7Dp0CXm+G
pPoyxqxotis4l4Dl4A3btCkYLp/dzOS00M71f185BKufW7S/16rj/jVUzgz2AjGvM/OC0SWvGoB2
tDdyBMmW1/0xK5rKGnmfM07/k8agfS2J6eI1iWB35m1Ni2SoCoLGoLlvUA4OhexyRqMTTjyllKtA
0Z9TF7kzBYUx8Qa7zfaTaIsVorChiSjphpgxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgwcY9XKjV0+TQvViOkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IBH5FrfexFJpoUypchQyJdKqPeYwm/tqaEEeiTGt+JXWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDkyMjE3NTQ0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALqfqsiC6fm6mwjwUoFvh3tMT6f6XRPuYOBv
fwpB5HTT2RbZU56ciRKn3vZyOLXL313AktH3XYnbQvBhwPAlRJ8RmYkWJm26yq+oBF+Le13RjfNE
nYfgzWvvATG0KA861ig77tfTcnwfN/5r3V6LwDVhhfzkUR79iowdHkT0UD20SH7aJ55eq5USmpHz
j32UWU85xKCy2sz3gqI9PCQ/15RSKmvrOcJjRcL34lVYXpCzyTaOnwqiGFmSKxZZpqWIHX9Eb7nO
8kWBWquj2d6fFi8TQOMBfEPNz8rCRVt+qXdybP6FTXKdVCKQaFiFgbhYQyZtHQ42SUI+blZpkEHc
TnU=
--000000000000c03b1d065c160f3f--
