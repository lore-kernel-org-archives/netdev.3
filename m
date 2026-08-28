Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AA30677E
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887185; cv=pass; b=AAIg5edH0f9YKWQIYsDCe1xvhi3EQ1jzVEKk/Z3NlI5dmTgZUkQep+nGY1hEshDVqlpvp2iFMfkoC7giSvGV6rJWqahrPdRIFOxy9G+SaX9s1t30VOVkCUeUBghYt/iUpUhdNL8DHjDB7tABrhgAFIXV5msO1S/t5biUcDMMN7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887185; c=relaxed/simple;
	bh=6v1DNkxiBkWhN44uvEDqQ9d6fXfPP/V48jplGSY5fko=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=QUVuKZ2c0k17nQywifxG4Jw2t7XFxfO9pboEvtaGQwXH5tJkc8l+Ew9KKNxAoLOwkmB28MuDUhRYu6dSmnEpiSQalhSwzvIcVdjlFe2tH7EXeFthyltEBvRdo7WTIZZKrgqE29RUtvuaN1r9jKfqq9JXaNk2LcnTQ3TR1swpGBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=KFfnmYzz; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="KFfnmYzz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso953650a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787887178; cv=none;
        d=google.com; s=arc-20260327;
        b=EddbOuRoPZV0Rq8yUbyI+YMphz5dEigBvU/amxBakTYY10Ru2mCIusMMLC0ieMyZwN
         rOf7PVdbiaZyhg4DrZKbRgT3fBhs/nNVFlW0rd1X4MTohAc8OW0VZAoo09SkPY4b0/5j
         wUmpcRl6o5QfRQHwEcyuXwmTaZSbPcKI/hhZnVAUDCaQMECgYH8Dv24wQoMRxQVSnkhV
         WliLMQWsyefpSVDYIo1HxAMRUyARo2g+Ihg6/iZUP+BdVlKfcbPCaSoFtHLM2W13jONc
         GQBy2GT7KKUkdl1M4FAnQr2yP8Fu1ZYj3FSo/9OnAwHWS2f6mnw3xQLHLjI52wLNGzEx
         Zz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=EWxUj5wO5aZ/OtfFRw5HR5XoEpR7VsjOUdZML27dcVk=;
        fh=9BgHk5+OE9eFiChxsjk4hwbaeW/fxLu6OyspMoPPwN4=;
        b=pNoI/gM4azsYXd6KRXvOKKcDrzHF8j1SkIpM1z8Bhy9jutYKWx3TEVd6W7ntZTaoe2
         qQkP1z2poe6o62jvFaPTFaoCWKuKxrKpbvxULZWpzXqrlKJvLUN+TD45mo8JA8Rn4VLu
         CviG6JOXoeIi9M33ofsebwyoeJdYbqD2Fv51rGvBGyWkBI5CUsZsk2Au2O+10Qdin9Lc
         ZldlTLtmKI+DPcqBSZCP+GAtnVomAZtJZs6prdR7Dk82BlqxTNj0i5Fe720qB9x9JH4x
         PHyKtoUNbYxFV0q84EQKoBqzJKlg2mQlT2GwbHII/KrkHgmWscACIMjk1oqaAyNDJXFl
         TKXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787887178; x=1788491978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWxUj5wO5aZ/OtfFRw5HR5XoEpR7VsjOUdZML27dcVk=;
        b=KFfnmYzzSMMfGiU9a+k2k0zZhrfIno/l3UJlAFkTPfKm0XQj1FcoviWHtQL2wAy1uT
         GyMeM+QjpcRpA1mgWhmJweH47Q+50H18cDw2clyM/3Rd3kq66EA57zUY0YB4hw0QALK1
         utF+gb4B7JZ2YZL79YwH7AryubJjBUVbUza0IL7iycCzJBzMlAWyOU/DNfvLmcP+z66a
         teaYGsS0b89CSEmddh/uIr6yHkKP5fUfPCQmYZI1EQH5OwpwVnUw0PIkf62MOmtHTHlW
         Sm+heGB+26Nt077lFv9U8nypAwDSOOziFKj0aarNTlWAiETeml542O/N8unfGphvRJC9
         Rxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887178; x=1788491978;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EWxUj5wO5aZ/OtfFRw5HR5XoEpR7VsjOUdZML27dcVk=;
        b=hdGNFAXdaKVsAcUV4ssU507vBSEPMP+DF8o/iU5AZGNp6BV52OIGrGOI1eSgQmQUQM
         +TKdzeqgY7ugFaN/sexJ/YV8hTsbm2CEdRs/tPLB8rHzPp9mlIM7W+oSbDfiFcpwG9+2
         NIGsz2JnLj4bIdnlsSxmGUyfZ7JKfvAjThDIWVQwv/gvsxXzJxTMWOFTES1/7iHbS3y+
         JHeajeqNsb2cSZFb1QSC87sp/xy2Lpa10FvysYRq/2IrhuVduDEXgUiaFxvjLjgwP8+e
         3KUQBkz6OoAfow34B51UoSMn1RDZPwqDVuS7N2tmyHHzyDjZeYTztUqr95nnz5VnFWdZ
         h9Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rpmb/k9qhuyUYFqgP46Sl0jaN1fxs3dZQGytKI3zEwVOm3WL5C9SyuXKRVBhC77tMMWIwTgD04=@vger.kernel.org
X-Gm-Message-State: AFuF++nb7SjWZIGNASiVU1DMMPsojoTNEInypA1xnuV9qxEd8gE0Hq1z
	WC/l1Ryrv6KCZbkLYqqfseJMlK+h5NhkM63GdrGzgNbnTUcsKhvSEJZF8yKD7rhi01jpSWf2D8R
	sxhxzdO1S18Jdh8mElNZQGaHjphQbAc1g2jZbrJnf
X-Gm-Gg: AR+sD120cTcD0wShH0kK2RCJ1MLAkQGOM53v2Zzo4s9FmZVReFm8tNgtJ6eQSmlyYqU
	wTXCL+H1XFtEzmEd/xu7KmflKIctYan/yWOBMKD5wgGOm/I3srECtcZVV8J5pOIrzAGTCTb7hA3
	2EoGZ+aarwODJ8Ic3V6YNU365SrZObFeJMYQ1naq3hzHgFLuHZdTAbu1u8RPzJsws8pEP55NF+F
	7pYbqe4rceRqmaDgdgmmbV8cbQrji5Tr3jmdH4xsbrT1+r+fd6tO3x2maXtA9QWLiDFiHqDc8XE
	8+AFAxXbH6ftYOE+wE5/pMBCPkY1ZZPPkVfazY5sII6Rz5y7ybWUcSEPr1vuVHnuFhafTkzNzuq
	5CJjs+KISEJck2MH7JFfBbzl1Cbp0zU2fRuVOTfRcGFI=
X-Received: by 2002:a17:90b:54c6:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-396d0e24bdamr8142429a91.1.1787887177515; Thu, 27 Aug 2026
 20:19:37 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:19:35 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:19:35 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 20:19:35 -0700
X-Gm-Features: AcwNN1UD1KOGm6bAvHsZgWaK3d2CH3iFRF8lKNJLK6Psn94h5DYc8vweZSSZ9cQ
Message-ID: <CA+0ovCgforg-XzdODxh9axazFP8M+hFj1wk=XE05oSGz9B2Zzw@mail.gmail.com>
Subject: [BUG] gve_adminq_release -- unbounded reset-wait loop, WARNs then
 spins forever
To: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/129-gve-adminq-release-unbounded-reset-wait/

  Unrecoverable platform error!
  WARNING: drivers/net/ethernet/google/gve/gve_adminq.c:378 at
gve_adminq_release+0xff/0x260
drivers/net/ethernet/google/gve/gve_adminq.c:378, CPU#1:
syz.0.63/11869
  Call Trace:
   gve_adminq_release+0xff/0x260
drivers/net/ethernet/google/gve/gve_adminq.c:378
   gve_adminq_free+0x78/0x140 drivers/net/ethernet/google/gve/gve_adminq.c:392
   gve_init_priv+0x2a8a/0x3450 drivers/net/ethernet/google/gve/gve_main.c:2509
   gve_probe+0x61f/0x970 drivers/net/ethernet/google/gve/gve_main.c:2892
   pci_device_probe+0x461/0xa50 drivers/pci/pci-driver.c:489
   really_probe+0x267/0xaf0 drivers/base/dd.c:709
   device_driver_attach+0xdc/0x1d0 drivers/base/dd.c:1206
   bind_store+0x1d0/0x220 drivers/base/bus.c:267
   kernfs_fop_write_iter+0x2fa/0x480 fs/kernfs/file.c:352

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
