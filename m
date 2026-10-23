Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726818;
	b=1D9ywrvCKoJKeqn10AYNyiMbBqDhcg+Kpv1+zfjpYAeOU1aqwcSazDZc+0Hdypu7U073
	 gVQ6KyiU19Xcq1ukviHsB7XvcjCtw/Gta+jf440eKGaAypoyzjMwalRQQc6bV4JGm/yQH
	 3Qhko40qFd8Tg6aDjGS+7S5Za3WD9LdaMhURqUo2iaKHPbKfIxE1JTjUac+g4H4qUlRoG
	 A8TVd3dzDLIZWLCp4niZx5ltDaLELENX3d1bqOwac6nPP8pRKCr6ZGCVz+d0pWQy8jHRX
	 Fa2aDUd6nCSckmK3a+0nQMRGc9Pz/0+8BfW0UuACAytF9AgnYXIcWQbgY3G/5XE07gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726818;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=SUuQjjEnkGoVEtoUyDKUm7oVfQnbBEiFTnslqRHzxA8=;
	b=E0Oj/jQIRYVRTod/FaHR8Lij7OE6aqSd2hzTEgCf1zzcuzOPdn+WvMTBvM+6sXjqciXK
	 vQpWTk/xxEAAdj/18LCOCQgpt63s4OQIwPYppkxVnA+9xVgPqw1cvuBjDissY1tVXNQV8
	 /HLBZS1HBqvN6yqfCq1ZGWTG58+tbTAC1QC5IwtzpwmBJV3NBaLeCnK2UrExXCLQAvwaG
	 /wpFmZ8jjaFDKyPy/6AiSoFHmHsdoWOoM7CjIDc5e1NlVTzRYfkaWev0v+uBusaCjLMd5
	 6lm2fbf+hrmPaVqVZ6hCz7xkIveDDt9IUoe5DY8ES5db8/5qsGJak8yyU87VQcXRAkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KKfcsdic;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED4606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65ED4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KKfcsdic
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so125447a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792726818; x=1793331618;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUuQjjEnkGoVEtoUyDKUm7oVfQnbBEiFTnslqRHzxA8=;
        b=MlVFCTBgJfjz54fU+qVHZYpmQCGX/TBOHCoKHHLz/HNN/MsM0UVws05YNXbqZZGapr
         yF56jRIMyecwVCIOK1ygw0rEkihLn0G90dO/v5Fvmdetpvz1uIN77NbnyoIgxxo70/Cf
         91qp6Y8hQdh/dr+NzeF7tCV63V3ZnZWZLHkysOPRRJ8HiaGHRpwhIcqCRDZHZg+WYPa0
         8B0czfhcNoz/ajKgyU/+abugIcLI986ZUQUeVe4HN4hnn5VhD0cIO9DMHc2RLyaSG16E
         1VNf1zB65AqowTmniHnURF9s4qb+GwKeR7mV6MPtYAcJnhtSOuR6al1w4+YJ9dIrAHLI
         SzlA==
X-Forwarded-Encrypted: i=1; AKwUvBw9d3q44OYFwuypRtlURx4DEIpwfCEzP+mcTeWi6QAGb6GvkMZvZ8fv79hbzRIm+IKd7gMaSs4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8MKxQQPCUtGqpxpTNuXRMifMmRW5+f6tVjM4MYYTRvuzxgEpG
	k4IzA+V2rSxs2WWMiHKAzfFfy9GloXpLYTmQmXCVuUMXKtrBQFVu7eh/o+8o/ecUbX4ZbH5cjVv
	1WyhZPUhtJUe2mXtP0EJdHW2yNqfCh2gwk2ZD3cDVfl0VLy4Jr1jCXeA5rjh61QgGZ+eMnKtwG6
	Rpe7ooHbOxYfwCrc47T60ykfcqvZQJKDa1RA9v8cZnfJKEeHdb9mcWo2Qzw+C3vptXEl09ifuQl
	lp60twoQ/Qyug==
X-Gm-Gg: AYBFou1leO8apA0BUYdugwczKppmvq9DzRlUHD2frVUwp7OJRVb7arvXJ3uRNt2HTFg
	Yr56xCtlwnrMU/kWh2ZM5QrJsQ9wXjc3Db+m8kr2YzorWMEbpVBXjYvlys8tzfh68420d1mTC0y
	A1ZZpqAU1laHcvp6oPDMT2CXunX+u0Vp+iCpn/RKnh0Ht8MAnQ8AMs7k+B6slH37kfQka296b2j
	VgAVEAuijU+G6To1EAR7T16e5BHtveIZ+2Gw7cUgEu+zIbr4Sn9KkiJVm/yQ4RJSmyXYzJQiJod
	dDOuI5+mYgQrT/5Jm/KramjHnRJTHzpEk1FjPv3EDxAzkY4C/3tyHiNcxfJXxk2kYBKtIWVezqr
	Z5jHIEqbHBgEIcUaVJKN1FNBuKcD74YjjOYl/wyK0crGkiTCmPTpK/S2nlGwP9iLSdLhEMiPdKf
	W1FmuMqJKd6esAJtYlG5ogcsqcHqiz5vuh/QGLlg==
X-Received: by 2002:a17:90b:1dc7:b0:3ac:adce:60a9 with SMTP id 98e67ed59e1d1-3adcdc95144mr784823a91.9.1792726817638;
        Thu, 22 Oct 2026 20:40:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3add2637877sm158984a91.1.2026.10.22.20.40.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 20:40:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab27eb38d6so486706a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792726816; x=1793331616; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUuQjjEnkGoVEtoUyDKUm7oVfQnbBEiFTnslqRHzxA8=;
        b=KKfcsdicB/Io+5YDRXQCQTo3ODZyp1TIT1A/aa+Oykvi2MMjmyBzjuPh0jRPyeLr9N
         5kOplEvmB0w7KCCzBZPPAvKzaWsToduYqoTnCzSPI8adAVbGXtmLxkZj4JihMcV1grgk
         5QcPhmgNLNu19ebbcx+F/rgF4EqZNBACBuwyI=
X-Forwarded-Encrypted: i=1; AKwUvBxnJdIZuF3pHBom1s2WnKiyGxrQbDz3nzFfKTcl9GeVyk/+xBMiubwshY302+Af0vGqa9ffxV4=@vger.kernel.org
X-Received: by 2002:a17:90b:520f:b0:3ab:1b19:78f0 with SMTP id 98e67ed59e1d1-3adce0831c4mr778573a91.41.1792726815704;
        Thu, 22 Oct 2026 20:40:15 -0700 (PDT)
X-Received: by 2002:a17:90b:520f:b0:3ab:1b19:78f0 with SMTP id
 98e67ed59e1d1-3adce0831c4mr778552a91.41.1792726815166; Thu, 22 Oct 2026
 20:40:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com>
 <20251224165301.2794-1-noam.d.eliyahu@gmail.com> <CALs4sv0BdhVHawBkkxN2v2o_jqGyFRAe1RVJjGu9d08HM2Jwug@mail.gmail.com>
 <DFE8DLTGB5Q0.1184HJSQ0DHK2@pve>
In-Reply-To: <DFE8DLTGB5Q0.1184HJSQ0DHK2@pve>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 23 Oct 2026 09:10:03 +0530
X-Gm-Features: AclHuK_CHltfFjjE-0xYUjNdp1Q5c50TeO29ge-KUwEY1OaeALHJIueZGBV2jZk
Message-ID: <CALs4sv2Fua=QqutN01raaUojNxJr+jrUshQ+riLZAMPKKhCv9A@mail.gmail.com>
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
To: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, 
	George Shuklin <george.shuklin@gmail.com>, Lenny Szubowicz <lszubowi@redhat.com>, 
	Michael Chan <michael.chan@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000e20b5065e79bd2a"

--0000000000000e20b5065e79bd2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 9:53=E2=80=AFPM Noam D. Eliyahu <noam.d.eliyahu@gmai=
l.com> wrote:
>
> On Wed Dec 31, 2025 at 5:10 PM IST, Pavan Chebbi wrote:
> > OK I now understand. You make a lucid argument. 9fc3bc764334 does
> > indicate that the problem it is trying to fix is very much limited to
> > R650xs.
> Indeed AER suppression is needed only because of the conditional
> tg3_power_down.
>
> So both the conditional tg3_power_down and the AER suppression should
> be scoped only to the platforms that originally required them.
> This preserves the intent of the original commits while avoiding
> whitelist maintenance and reflecting the relationship between the two bug=
s.
>
> > Hence while I am almost sure that your proposal (about adding
> > conditional tg3_power_down for R650xs alone) won't break anything for
> > cc: George, we need an ack from cc: Lenny, to see if he is OK with an
> > unconditional power down, and that he had no other motive to disable
> > AER in tg3 config space. In all possible logic, it should just be fine
> > because e0efe83ed3252 is fixing 9fc3bc764334.
> Sounds great!
> I'll wait for an ACK from Lenny confirming that this approach -
> limiting both conditional tg3_power_down and AER suppression to the
> affected platforms - works for his setups and doesn't need broader
> application.

Hello Noam, bumping up this old discussion... do you want to submit a
patch for this?
We haven't heard back from Lenny but I think this solution should work.

--0000000000000e20b5065e79bd2a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCbdXPQ
jDsM+hsosg52+gE1KvCX1QWFafpQxW66B1jqNzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjMwMzQwMTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBFro9VxkxB1bcmvH5HkwBo2E/py0jTpxa7ClKK8XN+
ODKa5XxYD1d34mH0N0fSfnpzo8USFeUm58WDk8kcOcteN/+R5xedyrgp10bXBfGbS9Ceg07UWxV6
irVnTQ6h9EicqhG+zFk/94JHKCKQVGQwM/+JUUG5R93wvHCzW0d/hrEMty3h3URz4P/u4TjjQ+MT
Qu/cybeOm5q8BExgb6OftxlHp4zpsDKlQALMD0qLN4P/BD4u4J0gSlHOte6lC+NgxXCvp9hTTIJ4
bnUnkSf8tq+ON/GNPWa85EAh5DFPJWWgAf0HFUIqxeSeS5EePw1nHOCI+sbm93hVqUFKfaUn
--0000000000000e20b5065e79bd2a--
