Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF2135A53
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787019209; cv=pass; b=ihuExxvb8GRNoQ5VdAaWCvlrroSYHmygCJLD3crG7bT3WD6yoVCJ7HGpxxt8KTQojPyNoiAStSwIMXrfqzfV8zK/2RICRDf0qQKvUaonSDNQWQeB6mhCGif89JNWk0T3J/msalq6A89LTzmd0OEUplvx2/YXlk0IrvAVi+X07mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787019209; c=relaxed/simple;
	bh=CXpwEctFwZUR8MIjbnqaszW+8vDl/TyJOX3U78L8XtI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TAyyJR1y3Vw5N+IRmzRzAdMeGt1P737GwOv1PkuM3BP4j7Sn3ROSV6OqOQ5vrXodApVQhAowrul3K2WwcPDGjFVAy81p/rEoUFtUWcrrQNpWqpjrYaHtTPk0+Gxc84APh0/Eh8NalXVIUMFsaMypyDWU5yP+4M5t6EMHcunwvmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rivianvw.tech; spf=pass smtp.mailfrom=rivianvw.tech; dkim=pass (2048-bit key) header.d=rivianvw.tech header.i=@rivianvw.tech header.b=XIGV6cWF; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rivianvw.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivianvw.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivianvw.tech header.i=@rivianvw.tech header.b="XIGV6cWF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so45185265e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787019206; cv=none;
        d=google.com; s=arc-20260327;
        b=YitSGzLZJP1TA4tCbLw4HWw3du4NkuDRvShqpGy/H/9m0R/SmlIbHE92hW+q6rlGrb
         tVGAnjtpVb7wLqkOjDXHxEwscFLYPl0GS5cHehvUniPn3sRZY/D+/yDBtvWpMQVgXKzD
         /cay4ISzyOBGJAK+WgXHZ22nXpMJcsj/2GwWThlfUvbYkg2MuwBmmqpPrKoVwAXFnNSr
         Nrcd76IOpb3QCU1JODtb3Bh2I1ohshxWfNkC39+FblPwnIPTlE6LybzGQhxQ3U9zcYtc
         ZXpJLD8dwYicQ2WhaXZQ3pCTFsykyWKkXXoixINyKDxAnMx+Wbud+2whn3ijiRKEfR3b
         t8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=CXpwEctFwZUR8MIjbnqaszW+8vDl/TyJOX3U78L8XtI=;
        fh=2yJRdLrJWrM4/1phKXX8VQw1w7aTLhdckFAFvslFlpI=;
        b=pWv9Y6ugMrJOVeiGwBzWMaqsWanMawX9mhZGPNweCPTHb4sf7OCT4hGwYAYCQpjK06
         sHfWSwx3AR0b9gJdHUtPOibGBU2Ah9GLbxlgCr10tcThOVerverGob8z0oTACUth/5B0
         T1TJwq+Mk9RxwGXFVVnSo63+SoJYWsUJQ0DjCB2/IZida5x3LrasYlJNZwcWvyE4O01N
         bSFUTsIOmUGqFvNjDEV/D/ruAl/OjzIkZWH2D1bDcmxg0/qaY5BEBb2JP9amwj3umzmH
         Gm361BExOv0QScsW3VzWsDEf4VYihdlx4c2eutU8JVVeSEigfjG0lTfynpePv4rGO+rJ
         h46Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivianvw.tech; s=google; t=1787019206; x=1787624006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXpwEctFwZUR8MIjbnqaszW+8vDl/TyJOX3U78L8XtI=;
        b=XIGV6cWF/PAT1RZQBbWgOXiJ6ZUlFWNuI9MzNYsnQWXwFf7YAi6C8DWUL83F0qA92y
         vUBm005W73+RcurbmxUJyMUcstSNQl7xR5u7lF0J71hoJtgOVhI3rIGpjgFPBVoZc/N9
         RjSc9jk71jeF55v+/GOWLbtjE2NjKFr+mC5UXNqxAXuj5KUreUpOaXce2fISM06htFly
         BQFMkDYMgW3kjhIoafP1KBF+K9+uYwq6OyL8ng+B2zqQbtfL8LGE0zKpP4Fyr3B83n2e
         ekaSsrudm2nOETXekXcNbzKi+ZlaBdRWIEWj6pv4FqOyJ5/6usxqcF31GsFVEssgoSc1
         Gaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787019206; x=1787624006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CXpwEctFwZUR8MIjbnqaszW+8vDl/TyJOX3U78L8XtI=;
        b=OCHTSntBTF0xqJO8rx+MuM2jLejctAs0+OD35vydA2efkQYauJzS/k5ZY52l/g4CCx
         ZCTR0dfOZE263xKzssQ2FjxDjqUh49vDjqYHxQyO8PE+Xco3GN2MTthqF8rhOiHjPEnu
         vnJPdSfwS2fDb4wLzRzgO5zylaCjriZlDDTPg2pY+REZjehDlibIqzFO9QsS1R13D/S2
         q0fQmfllyeMbmgyWBarhfM5tJV0M5R3Xohrt4fcmL4dMFGXzmYJ82UX/KZve420WhOCe
         TzNX1jUZdEQLTi/+RTq3yT5+9T4MYndQKAl3XwV5x2tWaqfRNAMgAvnH2fKA7196O+8T
         iRdg==
X-Gm-Message-State: AOJu0Ywl8oNWh60ME96GyPFGnLeWHOZB9E90QT6HP0DwnVH/LPGB2IVo
	+rfR9Gf8ZWQiY8Kq6dxD7z8dtjAmsyn3xS42cXSMzVhTJAOpzsaXgCzg2wFlJwPPSvG4eZGiDvd
	hkH7w3H1J4nSqdfEWVzl1elBhZO41Zv9dV9H/dduW7hIa2xWlHM6RSJKhx5n0oZ5RYvuI1DVTq2
	E2T/K8ZgyV7nBE7YIia5uC5P7IczqHMgZRf7KcMRnl11Q=
X-Gm-Gg: AR+sD12e6SwM8qoj+lid6kVIJphwMIzKKCWyuAvCQzUN0edTkbwmzSo5++8AWaslW0Z
	4Xv/cq8o4nRCxVNQcmqtRe0OLZPEByaAKjBHrNONbarY1lpoQsakz16n4S6Zkm3nFoqIYVdLbPK
	VF25+XIRibeXf1+Y9jM/z3JYmEolZgzn2VYOq6El06do1xM9Nv7+MYSr3N5ea4Q+r3qvIu6wwux
	wH1Z/AU78VdQdnb934pYL9PPVbO+/lKHESwhenM4Zdnmlk5qwrYt+Hq4mB+nkrGBwOVe7A7Vrzj
	SAwDtHdmDTxcSy+3EgmXSD6NYoFsvJj3k7bkz/OS/L3qkwlvbroOFZgkvw==
X-Received: by 2002:a05:600c:6289:b0:499:84fe:ca8c with SMTP id
 5b1f17b1804b1-499879332e1mr402516485e9.5.1787019205834; Mon, 17 Aug 2026
 19:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pedro de Oliveira Amarante <pedrod@rivianvw.tech>
Date: Mon, 17 Aug 2026 19:13:14 -0700
X-Gm-Features: AcwNN1VH57gma1xqO0KHeadd3LEtSJ96Q6NluGPIYg0mhi7fo2nt_1Iu9LWgJB8
Message-ID: <CAOWL=BDr96rcThv7zPY5PhOsgNXDJmLPQL5LWjJXgdwQGX8kkg@mail.gmail.com>
Subject: aRFS support for stmmac , any existing work or interest?
To: netdev@vger.kernel.org
Cc: joabreu@synopsys.com, alexandre.torgue@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any existing work or interest in adding accelerated RFS to
the stmmac driver?

Today stmmac only reaches the Flexible Receive Parser (FRP) through
tc-flower/tc-u32, and that path is accept/drop only.

The hardware seems to supports it, as I've confirmed on a dwmac-4.20a
part (frpsel=3D1) that setting the FRP entry's dma_ch_no steers a
matched flow to the chosen channel; the driver just leaves it at 0.

- Is anyone already working on this, or has it been attempted before?
(I couldn't find prior postings , apologies if I missed a thread.)
- Would this be of interest / have a realistic path to merging upstream?

Happy to do the work and send an RFC if there's interest.

Thanks,
Pedro

--=20
CONFIDENTIALITY NOTE: This electronic message (including any attachments)=
=20
may contain information that is privileged, confidential, and proprietary.=
=20
If you are not the intended recipient, you are hereby notified that any=20
disclosure, copying, distribution, or use of the information contained=20
herein (including any reliance thereon) is strictly prohibited. If you=20
received this electronic message in error, please immediately reply to the=
=20
sender that you have received this communication and destroy the material=
=20
in its entirety, whether in electronic or hard copy format. Although=C2=A0R=
ivian=20
and VW Group Technology, LLC has taken reasonable precautions to ensure no=
=20
viruses are present in this email,=C2=A0Rivian and VW Group Technology, LLC=
=C2=A0
accepts no responsibility for any loss or damage arising from the use of=20
this email or attachments.
