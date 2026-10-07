Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58844605B
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363490; cv=pass; b=ElRgSSOr2Q5hhNNnrzhOcJmP4TsYG2JC+W4R2RZ9+3LyprhUdd0r+s2z51FIWksaWXztl1qmaNCflduzzISTdOwi58APOFPgVVzrWItJhpIS3w+8cvZmagBy/g3OMTm6Hyo2/qEseBE/82q7ri75ruZzGJDUVznqGAM/8QMVrCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363490; c=relaxed/simple;
	bh=qXAScyJBP8Ix8YqSyidlmIUJCqlWPS9oijDB+zo+cxE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qyew1d9ginloWt/2vLEAbsBDRFhc27PzWs3yCwFD6SkLTqmfOzOMWJ5X3R4IG7LR/wPoIAt+1U1bJihoUDPxNWHIWiWmEsTErScxr3U5qS120sfmsPfRF+V164udYM4EEdBzYk+cPgOYPQTp9b/S3zscr8H2le6KMzqR8U/f5u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0PJr2QG; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0PJr2QG"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-81c5aac8478so896728a34.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791363487; cv=none;
        d=google.com; s=arc-20260327;
        b=RyrcQxq6Ymp52VjS4MUpm92tY0ughBe18EWtj0YvJF+MwtJ+JdJiw+ZBoew2boeRX9
         BXwJF2Z8nAevtbDTcS+qt2D3eo2m/JuK9WwPbs+GPYb+tv1LCsJMij7ZvBPooPaAaASl
         M2a6hfespApAB48iWCt/FsfrTCxzAXW5drv4oWQkHqgyPjp7qHkCqhGJTZ7unkmU/Pwo
         lu9NtgkpwamIJ2Hmq1Pmb2pOGFzdPBxkXOr0QongO2k8aMtbXU9jLQZzTUS8FKC0sNlV
         9A2MxTnrT/RfdebZ6XacJ8VFWAwFH7xLXY7gRMGYzTs8/EzNqAQmZssUyptwtlJgN82n
         SGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dFFzVUvDGPx4cWOuhCtO/dkoffZgG29srLq5Q2rN2Gs=;
        fh=XGUcXgpEnzL4njl8/ONPxy8kK8tveTBZTsNf5mEZ8Ow=;
        b=o25GJwi8iCLaQ9dY01rpX7t+9TtTyVDURAPo+Tx5ITb5Uh2t/uCa4gcUJq9bVwGdhJ
         7JA0xXqeurXQ4n8hLEhXEDuIBijWraVbPVaXr2br7oLg4Xk6bttQuu004TgkdSRXGOy0
         LUWNLILirZ7nQba1C1ap+RD7T23ccBH6F44jD8zkcgtCbGcLn+1LVIqLpsdcuAWVresx
         wkutv1j4vnivJH78h/vZi3hgvs5Ok5VZuRUqBIppuhMI4lGWsXtEp4rpORi5xnVwlqlC
         /wCv7H0yi9QIOtbF2IhIIzmaUnstGs8QeGdUiNARAOvE5hQF6v97B2inC/0wHJosqB8/
         CLuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791363487; x=1791968287; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFFzVUvDGPx4cWOuhCtO/dkoffZgG29srLq5Q2rN2Gs=;
        b=D0PJr2QGyFgC5Dir5MFVXYejsk4tgaBNR5ldvRwJwMfF/Nlt2k6SsMbyieOuK/Knp9
         +SGbGzzrqLS7wpEya2YnrxaO79rX/UhgEPeyPgQdgneWZGOB8w61E1rYbC8n2BGeFzWM
         NrqbnBwlgZSnLEHTb3FSxVC9731hntp6C0m9s9X3EHLZm2CZ0PqQENWTjwD2uNUwzvkq
         0DP0tECFFZYNjbDCQQQrfIed9SWGx9DWCOxVI4AFfQmJujG5peJV6ooX8Sc4QqWkIdKX
         00+oCmamwY9ogJ/ZPyQWs65wV9eaTgbw7AksPuo+jHP9LqjQZ5cotdfwQvJHiw7ihVlu
         VlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363487; x=1791968287;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dFFzVUvDGPx4cWOuhCtO/dkoffZgG29srLq5Q2rN2Gs=;
        b=Vs4htpKVv//SL6nmSQfrdlPrkvoPPr96W9aV0GicDcr0U2w+hedtclt5wDFvSGkZJ5
         f2bIisoDlColMA3DVgabqAIMNs9eRZ2612L+9zGrgtJiWkltzDAtxxsA2XNobinAK4a/
         9q24RGJIEDNyRC5gCgWP2Um3t/Zxx97qGZuAIw3sdHlWBIHkbBw2vRNTSHhJ+Mg16bGW
         8cJYwKABgqqnBeweb2MRYbMuv91J2g8D8OhGJMvKloA1DXp0MBE7FiyHtFvAanbWG7hE
         4o97OWOn1esnKy0kvsogDud+7wOkS4+kiQl1BtJZMtpjvX+tUw1PE45zYlAHWK6fFkxR
         O0Og==
X-Forwarded-Encrypted: i=1; AKwUvByPWUANaJeiQCeL1bAJ+6yK7xFr0iCzHMDmC6h3SDHx06IgunSY8IPkH/nu4R8N8GNrZYkMERo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZhVFu5WgeziyfA8GswSx2S+1SB3htJo14AGxbhgv5gpHgSfm1
	SE3WSFCLbnZFOXmkwOOedHh0Q38PpR7rTvrlrdN5VLi/1dO1XwdZg6Au7Sf+WcSheldQV6ebA99
	WtwxlODB/gnTFjW2S11CauGGiGeJEymA=
X-Gm-Gg: AYBFou1zfqui6ZCe/EAFUfk9eSyEQKfYxxRTyLo3tleoMmJ49kwQs0yoxBjf30kQS6Z
	EkwfRSGnsSpVFPaibW4h3g0HqcT94pCX7E9tD8IKYadq0SjLd7mW9GUGb9P1Gh8IUq9bVnkbEDG
	5MIztZj/53UKbp7jUSIDI2Gks39gmD6ZcXUrL5hzE2yBmL6rMNT4CeLDS807laq3RfZCZkucWRX
	gJ7J5QmTKsgF8SS9yxPrfTgt73x59r6QrWBGtGCdCXm5SrIsRBtsWJ0aOrZDBNX34hmholmQIs8
	oTFp2JFxrnKNRrV++ZV5GTZEye4uSoD7QlGWeZ/9Mihg9IXrks2Wxw==
X-Received: by 2002:a05:6830:6f81:b0:7fa:ab72:9e01 with SMTP id
 46e09a7af769-82ad05bcd08mr2728833a34.25.1791363487510; Wed, 07 Oct 2026
 01:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gilberto Conde <gilbertorconde@gmail.com>
Date: Wed, 7 Oct 2026 09:57:56 +0100
X-Gm-Features: AclHuK8I4SeveVc2elYJfUoDWNdJq0rtjbxrwk8dv_F5eQHMvB4OdBSsT-5rChg
Message-ID: <CA+rCdHiuoYZbg9F15+_9AzvY8go0zfHJMfwdTgV_MhHKfCvQ-g@mail.gmail.com>
Subject: Request to backport "net: usb: qmi_wwan: add Quectel EG120K-EA" to
 7.2.y, 6.18.y, 6.12.y and 6.6.y
To: stable@vger.kernel.org
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

please consider backporting the following mainline commit to the 7.2.y,
6.18.y, 6.12.y and 6.6.y stable trees:

  0f2fd31f63c6 ("net: usb: qmi_wwan: add Quectel EG120K-EA")

It only adds a USB device ID (2c7c:030b) for the QMI interface of the
Quectel EG120K-EA LTE module. Without it, the module's data interface is
left unbound and LTE does not work on devices using it, such as the
GL.iNet GL-X2000 router. OpenWrt currently carries the change as a
backport on these kernels and would like to drop it in favour of the
stable trees.

Thanks,
Gilberto Conde
