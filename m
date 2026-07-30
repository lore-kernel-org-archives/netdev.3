Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886531D367
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436091; cv=pass; b=mZIWt/E4TAmgk6wpprD9+E01T7pIP5L8QI94unRQbhNJxBpzrPNSnYNY9DBOuIUeqVMrJFInWqO6WfdZj5pispcb9EdQvSdo4G+nS/5LnqgZmxMnNAZr2gdTZUF2MHNa7iScw6QmYk6OvhHL3cfu3diWpulWlPUVCEBzfSD8TtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436091; c=relaxed/simple;
	bh=JPbfYqZ4QGxJpVE3P4um8mvE7xf3kPfP7sPwLZuhxuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+IW6+I/J8pvn1chfqASpWguHVHpxP7KkKxCz04gJXyNVsxLKQ89OCoBSubMuh0KJG51JpEMLIlUfhD+MX96WmysxTuC92k6sUQ0+LZFV9+F5Mt5xU08zKXfb9/qBs+opPR0dx/ibmY1hflf95GT+pYgK5DJ0qnyJwk73gUq/Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tyg/8pKZ; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tyg/8pKZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso179806a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785436090; cv=none;
        d=google.com; s=arc-20260327;
        b=IHOvHLibhCkU6ejVj0y6Ajr2Ss69mNwYyTEhl4R2QvHsimupZ2NDGk+OpRhNA4+PRV
         SWtJrl6zC1tGMPgAEyWGm7m2ihtHZtAITbvizXaSUqyJAJsgt/mEY+i+aQ1rO73q3W+P
         Z7Ie20AdQ0b2qxtpxhk2JXaGhULyV3iZCzIc357jqbamfOsafa0nabPM3Zpwq7ffs9sR
         gM6ril59JHxLdWSgtkpiDQH5P1+D/k17OOVPZYYwOHsxEcQZgbcUtZwbjoBUtEXiVtN9
         FhSBuZbBe5iY3p4i7qhUGp7uTQGMCeK/axEA/s5n3cRpk+fnmxkujzhBZgOiBGTm6tfl
         U0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPS0CmuTJ2HqpKxy0zCGVr+gG3iSDxGGRZ0iGF8CO7Q=;
        fh=7DGnaOOvrbO7eg9VuHXZfgrZ+qVIHKWxkJbDSVSe7l8=;
        b=GoIrVSA3Ovq30i5coXuAKHyiY09rgecLAXUcCYYPTPJTPXAJQ0GYsCEWKTsHWLZiGZ
         zs/veBgXnf1/hAu/3ytL8Cb4bTp8xP5VVvPV77FWZAUhfcAc9dATzpvI1pCf9uDKlZCu
         JCTfNWWy0f+O/7bCKv6rciCWBEm/7rc3JnZi4kKEfyGz7vegfiNfpDVEXB5IZkTEa7jm
         t7kCEao5p2n+cshc444OJOCPDKcqYSSXgXfuoGyt28N95Ay0APboEihvAoBflyJ4l+Hl
         eH4YDBwsXq+2wj2nFxWW4rGx0u6xkpaagiHzy0UrIFsuYnE68lY9JgKB2a0mhg7piMtw
         QPOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785436090; x=1786040890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPS0CmuTJ2HqpKxy0zCGVr+gG3iSDxGGRZ0iGF8CO7Q=;
        b=Tyg/8pKZ79TpvPU8QLyyffMjIdMDD7lBDJTfOUQEZW+6qeaGIspdmG7OoXjUNjjHk0
         0nZTdMFEy0psIXhtNqTQsKGPcroRDkknnX5KPsrSCRoRMrWSM2PxjSzew+Mc8pomZ5VD
         4MV/6JJdR1OAOJkS6lui9CTQZ83W5743A5F7yZmwRXtGVNZiA4AaUKiYCdZDUC5dt//W
         BPJnr57McE53/9PloT91QviKdDnHeB64ieBU2+5B2eMOUwHTmaGHskWxwX2rYnuYbTEy
         JpQcG3jbPkC6s297jzvyCgw7/DsQhKjDzxQDjveLrhmvuFHyDDpxtbXWp6r0k8RfFC1R
         +TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436090; x=1786040890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPS0CmuTJ2HqpKxy0zCGVr+gG3iSDxGGRZ0iGF8CO7Q=;
        b=RVmEBvtluUsnwGNHmMqhaOEjK6tCXIMIlFrYHK0wsJOMbYyjsCUtAMfar+qM+GjCVb
         C4ueJjVTG54znYJHqK47D2tHxJNy9nVqey0IF36ZoMT92knrsrpV2FhQgOChxCeBvtRE
         X/oHjPBYTDCAd4+Gx5HBgzlVSab5IbxHm3hAXaGAtwCF1ANFcTDiFmRhsZ3PgMp7a4vo
         3uAFWyjuRCvLJ1eZmY+N4ayHU0+wRHsxe2VtFJtEzTBTMPBOCpgSVH0iRGR/lUsskQ3k
         hhDD+GjIDGG8j/DISpz1M0zK9yYFxCj996Ja7Wku/LD3HKkEHDZQJIdlnAocTPtAM/td
         VjfA==
X-Gm-Message-State: AOJu0Yxt6ICfrH2WmYBGRHLoOQzhosgWmGecirztKjyI4XlADIk4V2St
	oiPQIkFqL8Ftn96sEzAGf09PUsvsbF05b6Nho53cdeX5yiLeHaYtv25fjpKO1g0U+etGGlgLlaN
	Qk7jVrBXbkTFhC9KXMufN/vzf2sbC7uZXhvBzO0zlO2/x/nxEetCHePO+PdSiA13G
X-Gm-Gg: AR+sD11wjEkL4nPhBcM9hyc7v2/gIKdgBz3nz0JGDUkLdpnBNmEXhM7/L4aDexBidqg
	eoR6rqfcH/scyFgtG42ds/SVuDv/toeD+THffADEhwagXKRWwUdewjBrTic8nwIf1A8A+TLHBpD
	yKT2tlrKmkxi11H2MxoIz5WuojrixsetAKwVp2hpDkADmzP/FsU4C4OIWvN6LTSF+G7NRp3aT3U
	3RzBWkDwIl9CGY6PHoxTlZljFcpklVu05J5lT+1MUipRuEKPX+uN9LRzE2gUNbtRCkoAPDhqWIi
	UFH2ae4KOhnZf06ETmwdnsi6XVnIaImXSdJ6zRXNRNjjEQjD7tl0lUT2yWelcfvIln6zHqAAcCX
	5QZE86BhfrvvjdH7ZM80rojgcnOcgbN+44fHKU6zH0zZzRoWGiw2nRlXuJFswtkaO0HeH
X-Received: by 2002:a17:90b:55cc:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-38f9bde6a3amr3242176a91.10.1785436089446; Thu, 30 Jul 2026
 11:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730144652.5715-1-sebastian.chlad@suse.com>
In-Reply-To: <20260730144652.5715-1-sebastian.chlad@suse.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 20:27:54 +0200
X-Gm-Features: AUfX_mw4oD85eQb0Y_pUAUD5vecY7ESwauFV7I3GKVvFZJdMjIhV1Kt762B6nY4
Message-ID: <CAAVpQUCkKUa55gJTqObD_6RNLDVdXqaak7Wst8o20X4RDnSmQw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ is unsupported
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: netdev@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:46=E2=80=AFPM Sebastian Chlad
<sebastianchlad@gmail.com> wrote:
>
> SO_INQ was added in df30285b3670 ("af_unix: Introduce SO_INQ."). On
> older kernels this returns -ENOPROTOOPT for SOCK_STREAM too, which
> scm_inq.basic/partial_read currently treat as a failure.
>
> Enabling SO_INQ here is only a precondition for the actual test: the
> SCM_INQ/ioctl(SIOCINQ) consistency checks that follow. SKIP when the
> precondition itself isn't met, rather than asserting it succeeds.
>
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  tools/testing/selftests/net/af_unix/scm_inq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testin=
g/selftests/net/af_unix/scm_inq.c
> index 6268b5bf50be..2868cce61a9a 100644
> --- a/tools/testing/selftests/net/af_unix/scm_inq.c
> +++ b/tools/testing/selftests/net/af_unix/scm_inq.c
> @@ -111,6 +111,9 @@ TEST_F(scm_inq, basic)
>                 return;
>         }
>
> +       if (err && errno =3D=3D ENOPROTOOPT)
> +               SKIP(return, "SO_INQ is not supported");
> +

It seems you missed this in the few lines above.

        if (variant->type !=3D SOCK_STREAM) {
                ASSERT_EQ(-ENOPROTOOPT, -errno);
                return;
        }

---
pw-bot: cr
