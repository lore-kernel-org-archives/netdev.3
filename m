Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792817499;
	b=Iz7aQYn9UNrMZRrMnB+n0l59QiJudKXQYg/j6EiDPxX5TEXH++lNG+93hA6ghHwLZ1/Z
	 +uDrlAB5tW1mBQbzSfA5zVkeUuX0wJnukAR+fIwp3vTrVfmtFARNWCN1ppFcFIye5ImvC
	 NCdMv/q1ZF9VhblL9GC+HhCJezdCda5NjlSbAqvyroxEDiYpmYEcT/cYSghu7v5UAcZHq
	 4zZRAdUUqzWasW1vw9VU6mSjMiFLhasAKr1EySu4QNp05vaMfujv9UFsBVyRkze/TnFHd
	 Swsa2ka2LTk6ngHBk4z6WRJz7HS11EMtN941XQ3Ovwvgnkfz7UhMR7tYRQur916+x+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792817499;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Clchgk6S2D+3/uvyWX9csqYYfWAriwdRrIqm/0yR/Zc=;
	b=yL3pA3+j/+kpBookEZoadnMjT/5r5j4iucjZtMg77kT0zgSFE+xP80kMDqqen9LFDWC+
	 X10yEjGOajfiR1ugvrpKUp56OEjqRkLo/6ybNoMlhdc3OPj+rmup2Mr0o+ulo3XXIaWIz
	 vDiWMD3ZuG8mwwegTo7YBBryZEz/dxKDJvEENuTNU3wcxXvKELgD/qNIl0UEi9LScoPY4
	 ZyAArL6Fo52KEw/ROfwtScVccNzK7RJPUopfgH2RXPz66JTtTSsOPyT6j5F7e1i+OxCKQ
	 zFEm2uALWM1u6U3mY15NVeV2EMN4AvwPlf38QphNXzC8AAer5s+gXvEeMcePvcLco0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BtWE0Dd8;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D754606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 04:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D754606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BtWE0Dd8
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc147d86bebso703593a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 21:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792817498; x=1793422298;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Clchgk6S2D+3/uvyWX9csqYYfWAriwdRrIqm/0yR/Zc=;
        b=D2JRIxUJ7blAAX27LgutZgIfnIvhKgRBOU3Z982CSs0Ykq9KayscSr0nrBClQIuQXN
         pDR8Y04iv9Jx62ivozXJiWnBYh/J3Yn4DX0v2vBqPN8YrwmtMAjuNJEOfFGofEhNSDi2
         xMLezrjOhXTh4eWi6PUYku1v68ibk7v6PAFGAObEztrddlufzNpNmXCLe1zA7/OjGs9H
         FvDp+0tRKScMIM7HAaQ3TWEpiF6jdtbPhJJLJAWYckHC2rxaFS8Tzve7DskJ8GEdRGLr
         THW6yYRXkqOSImIV8NVmtudCwZ/C+2140JmAXW3GvKrlD4p+AcDkfibiGk/2ott3SoqN
         sXQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzY2JdX8MbEZjo0meZ53jtSnM+oNUGZPN+VuHEEW3Eo9qZefw5+gzp3PDIfFkprh7zzVsDuNkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZthbVjQhodmzB3N4TEDhB7PqQGDPKMm6UJ2cY6POPi/jyHCv8
	hJoWHNqjfY8sxJz0XRTYOdlcxKiH/rwml0FgGG/v3l+em2mT9tkZm9jcKzC2L80kSI2SVGzn6xh
	9GsObwLeMH+c3apPqWqValMwMPyRfaRhTjLlPt8XG1/icZMNOASaAX4IWzrC5fq7i9AOy1RVmXm
	5I2UROgLy1UyXfMv/OlgfcSRxNG1Jn4eRq9pH5VYcTk4MNmorcQ1AtbmLk0G+cmv178GQZ6I0cR
	sxPh+iuB3k=
X-Gm-Gg: AYBFou0AZQaPNOcgcb+alNRMtmI7RMw4iPjrnGBNQmnPxg3PA0dOYLT8KiioFq6BMGr
	eDsf0BV9B4VkgccTNwd7guoBVvl6D6iz6ZJi9d+9oQ9m5JvkItihGZ0YBQUcDj0Vda2pqKz3nnH
	mXdB4wwxCu9OyyFNZVW35nSbCBsdGiEXEBXSPp9KJkLXBxxwKU67tOiTug4mMf1i/ZWvi4oKonX
	htUfbWlxjMJDAHNvUWFNjgQ8bPu5J/8ENGQ2oypVGvrW6tr9KCKWMAcpQF8bxSNK0R5tNa9ArSd
	syaREZVrCQu9TUQ3qIY2QiVHruXlUekmPaDiwbagohAQKWKGfzRSUNegCE6dRj2ZJELa/1TWLu9
	LwOA8xgnk5tL4A+5l/9vmCdfNmi0vi4Mm008+hWolZvV1HpyHjjBUfquGZmdAY6sjjkH2TLmw/a
	eShVGiFcKHzFdoNv/oU6PIiyE+NMsSD9ZEpy0=
X-Received: by 2002:a05:6a20:5288:b0:3e2:8d05:9d6c with SMTP id adf61e73a8af0-3e8b5e3e361mr144862637.12.1792817498234;
        Fri, 23 Oct 2026 21:51:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cd8ccc4f975sm11876a12.4.2026.10.23.21.51.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 21:51:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a08903566dso1792984b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 21:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792817496; x=1793422296; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Clchgk6S2D+3/uvyWX9csqYYfWAriwdRrIqm/0yR/Zc=;
        b=BtWE0Dd8DTGHf+LRWVdvqCWGB0Bx6yt1epr6DzXh84eNiSteeEvZKXWlZ4Yk/eR3+d
         ooHr9qAJN79n9ZXSdS4jFRWUazY1o8oho1uzCGwmFk0Lg6KanziSalzrnYLmtbI95Np8
         QBkj3nK41AcYngMnE3qwhDgQdEFrjC3XzbBi8=
X-Forwarded-Encrypted: i=1; AKwUvBzwJQCBluuFmU6Q1ac5qm9AF/8c43xAkxvulGv5Gesd/PDTed27cB1wjkqPY6U9hKO+Id3ShZ4=@vger.kernel.org
X-Received: by 2002:a05:6a21:3f91:b0:3e1:5fc0:bc1b with SMTP id adf61e73a8af0-3e7e84ba02amr535685637.32.1792817496361;
        Fri, 23 Oct 2026 21:51:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:3f91:b0:3e1:5fc0:bc1b with SMTP id
 adf61e73a8af0-3e7e84ba02amr535682637.32.1792817495948; Fri, 23 Oct 2026
 21:51:35 -0700 (PDT)
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
 <DFE8DLTGB5Q0.1184HJSQ0DHK2@pve> <CALs4sv2Fua=QqutN01raaUojNxJr+jrUshQ+riLZAMPKKhCv9A@mail.gmail.com>
 <DMCBZ8FR2UYP.2G9NV2OYGYYOD@pve>
In-Reply-To: <DMCBZ8FR2UYP.2G9NV2OYGYYOD@pve>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 24 Oct 2026 10:21:23 +0530
X-Gm-Features: AclHuK8N1UfTmVgYRopw9pcDFyeg1l67j49CURUOHX1uqNUOKMUkhq06xI4-iZQ
Message-ID: <CALs4sv0+HZtV1itqSt=r225gM1J0dParWTO3ZbHwYih1Jz6r7A@mail.gmail.com>
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
To: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, 
	George Shuklin <george.shuklin@gmail.com>, Lenny Szubowicz <lszubowi@redhat.com>, 
	Michael Chan <michael.chan@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000009efb8065e8eda62"

--00000000000009efb8065e8eda62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:13=E2=80=AFPM Noam D. Eliyahu
<noam.d.eliyahu@gmail.com> wrote:
>
> Hi Pavan,
>
> Thanks for circling back on this!
>
> On Fri Oct 23, 2026 at 6:40 AM IDT, Pavan Chebbi wrote:
> > We haven't heard back from Lenny but I think this solution should work.
>
> While waiting to hear back, I worked around this locally across my enviro=
nments with a custom kernel. I also shared the solution in a few Reddit thr=
eads and received positive feedback from others hitting the exact same beha=
vior. After getting things working locally, pushing it upstream slipped off=
 my radar.
>
> > Hello Noam, bumping up this old discussion... do you want to submit a
> > patch for this?
>
> I would be happy to submit the patch.
> Locally, I had taken the quick path and stripped out the code in question=
, but for the upstream patch I will implement the proper approach we discus=
sed: keeping the DMI table to guard the conditional tg3_power_down (restric=
ted only to models where the original issue was observed, e.g., R650xs) and=
 dropping the AER handling entirely.
>
> I'll adapt my patch to this logic and test it across different firmware v=
ersions over the weekend to make sure everything behaves as expected due to=
 the date gap between then and now.
>
> As this is my first kernel submission, could you point me to any recommen=
ded guides or things to know before submitting the patch?
>
> I know about:
> - https://docs.kernel.org/process/submitting-patches.html
> - https://docs.kernel.org/process/maintainer-netdev.html

Yes these should be good enough to start with. And there is always
getting better as you go.. so I wish you the best for your first
submission!

>
> Thanks again,
> Noam

--00000000000009efb8065e8eda62
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCACTRr9
CNcUuAAbVyhqNTbqaWJcY3R1cKUMR9cynRoevTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjQwNDUxMzZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA7Kah5JNyus8Vn+kyH1YAOzeJbr8Cj3rISACb4MG9z
bADFB3N4GOVALrTZYYkV0tMtCCzbCYVIvIW+nX9zjXj/jUUofgiMqIRR5kG/sta/+t7v+pIUrxd4
UrbIaPaTUCK++w943ne4hsMxnLzGefhn4XwftgU7PFm40nJ81DEvNdg8C+TKefoM1Gj3Ohie01lP
NMq8c6sNx5LbIzkAZVB4dOZtoEQ0T+YBscb15DC13vam7hWy6hQIur9nIhVm1cRvBmBsgv/oVZHo
b4UDNaQ73CrBvXTAPFDre09fe4KXndvZCKSITrnpJzKdFiURgViQnepxZd5N657uGSI1HgNl
--00000000000009efb8065e8eda62--
