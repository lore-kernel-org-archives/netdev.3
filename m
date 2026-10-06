Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3830EF91
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269420; cv=pass; b=MhCdlXmH9Gx4Jc1fJ4vo3r8ssRw5zNycq/LRfmLS5vZ07UpUSThQJkyc2c3qYD9Re+Y/LQw7PzcLdO7E6nqKvoJ6FdtVjxx913RBXX70x3ZqNZ7Pzdl7nj2y7+g3fcyQaadtSRBPbnxRo5K/YIpXQ/5ZJ7k5hb5o7RZ+o3IuIRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269420; c=relaxed/simple;
	bh=XJC8mnwuYM0KLaAKHJuhy0GpuAFopbEkJ/aam2wcfBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JndzP0A7JsrtpwETYoXCr7Hh7HeyWcrO2s6wj2xbnPdeiGWLTiVBo90Y3iEosoCndmS+8qnOpaoF0mTj55p+IcEuhQYf7lhb9iNoRhL/5lvNM0jKVoGxNU+5iLfbIe/dkkOlAF1JGXkYxRMXKS012R6lEmkMqVQTCoekBBDaqkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaeMH66A; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaeMH66A"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e4df2e26fso24176966b.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 23:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791269417; cv=none;
        d=google.com; s=arc-20260327;
        b=P6DPbSFmfxLKP1unq63Yrwph0KsYR7QqiRwgOrwFdXt1AkGdXXla1IKhY4i4Gyf7Eu
         h0tv/3N+5vXTTOZcOSDVMwwgdtw5QAc0fgYHfHgIGxTC8t64ErgYNwpZ6pqD3r+LVR/v
         V1333T/OrlMIJ4BpTBcymJ4jTsW2w45a4QiDjvWFpNZLacyr3vGhMZn9fOz4M9V3mtK6
         niHWq1vjZiIWrAXNR5HnzP42hey7abPFfl3T/EkqI0xzDEhJIoJwIQB8TkqbJzLVqxsS
         9sv36tKnKxKudnOCykqghhumAcHhtTCbDlxcgN4nGP/jO36j2jLQDY39Zeprh4NYMM+i
         MKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tqsYm2RdTA8FFgoOM+5IDbbKZf3ev28pnZIlHkY/9I4=;
        fh=StHIXKpg4nmzq7XxFVKyO7pBU8aKZRNQ6qRGjRnQX2g=;
        b=SVsRpf26cbZRb0Y1/Rx4tXxEvhtVXZwixHyD7YZ/6yoC0df6HuBdCTT+eqyv02Zvgz
         UngVhX2kLpWs1n9avkqQI8OmQYNILekGAL0bqOCc6xTQQv9OMT4Vl86PSgUkUnHhXucV
         uG/H32g++a4JECdFfDARc0A8j0c3ityvFuzuvFii5Oa4KYWevDtBEZz6UbVUfU8ynhrV
         HrF8BWZYcvdu69Kvp84rUFo8tj9zM3ElVmNXFWC1AVagN5DZZKA0jMrfO1fw8tNeInmr
         l3S7WJ2f3IhQi6ObnMr8etlYoRYhbzWoUTu+R8dMlL0a8Ttw1gmM1Kias+sqBxOITuuJ
         7yNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269417; x=1791874217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqsYm2RdTA8FFgoOM+5IDbbKZf3ev28pnZIlHkY/9I4=;
        b=KaeMH66AKwELWekBwEaCGSlQ2kIB2ySGAKVHaKUlw8wq319DLYUhxnVd7bKMEndGcu
         KYD2h1CxkmlO/YBkK72LkGFxWlt6hhzd+DXpHnjl6SpkuaGeuVgxa1SPU0A9RbTmwFBO
         nIxsGRANI+5cYbptMSI5DuCiNmd8hEWSZcRD9OzcP083O/Mkn4kvWBPMFhX3NeHQNs1I
         ekxkbH/s0x0cCsW55QvS6cH2ugsApTZo4eSI2DieRA2dP8hU65D9XiKUNKDLlCtbsHSb
         doSu4xVmOB3nTmONrhzmKMN1xpspH8/CQ5eJbDEtoPsKLZki6OPIfBZDs83JdS/6ZJu+
         2rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269417; x=1791874217;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tqsYm2RdTA8FFgoOM+5IDbbKZf3ev28pnZIlHkY/9I4=;
        b=nDhCjRHrCzxuY8ZG/OgLQu9A/hsQWqKavbX1wJTySeX9KRXs0VFaAFkaQ7AL14H2s3
         KXFEl2Kz/feomgpUyauA+pnWSXHU9BMgzypibgFI7S1HnLMtCoLrI1WnBUWKqdBo5iC6
         uSmBBIJtO8I1fJkR1u/F83H3rJMfTGRmjb4/a3kHaUTxUcALkIc0bnDfY7lwiwXNYwYs
         qQr7HUMaAC/q7mK1xuhE78Tud2mhz6sdZJ+5v7SoGSIEEU9ztrfwBoMhEVns5KIUHoLw
         sCl8TVUodbsRTZK7pQovpD71VB5yrVNiEBZJZCXEm4lSgIalzDDXXs802QM71P2MG3RF
         0FKw==
X-Forwarded-Encrypted: i=1; AKwUvByP8SCtftguYXuu3VofYDhpNpsiacy5C8fvo9u7mkFDC+qfIpp6xBUOFsXw4wfMcV9XsYK1nFc=@vger.kernel.org
X-Gm-Message-State: AFuF++lUVfdII7++PR6LorU/Hc87vHSJuwBx5M6zP5qG/kXpjOPpDwPX
	YLbhHP4+CKIFAMUBSv1f3yUlWNTu7Cx881OCRXMZdb1YTG0kB8KLUGh6v25ZPBXhOCoQN7VAJHu
	g1Bn8jcEXgryC2ut9Z4Ep6kmxrGhMsUI=
X-Gm-Gg: AYBFou2Nm9SWBevJNeSm9pmemRurIppHhBd1UyWe3WTTEMnuxAQGxWCC/QfXavPEYjt
	rEwazNzpbJ8oifYJhoekQBcF1iCuppHIfijQduwp9J5zx1ycTaLY4R9AoNmoRjc46oYxMch5JbJ
	AemxC0B8mBkIkeTclJKnJt0hlBMJImXXOcyN/kAu4IVEodtEpS0tQVO+m613pACzPDzwoVWY9EK
	L6NqmV+ShHjC0vNc6/voDUXbWmLcNsmNyj6R2TutbDbjMz/R9v7veRgYfWzQoM8rTOXNPVW89m4
	IzVBocIE3AwY5sb/Yk2jjnv24BUdZC9S5OfcCY3Bq8v4UraC7aRvbzgk
X-Received: by 2002:a17:907:868b:b0:c2d:ca8d:435a with SMTP id
 a640c23a62f3a-c316a03a07cmr48107466b.38.1791269417167; Mon, 05 Oct 2026
 23:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subham Pal <subhampal789@gmail.com>
Date: Tue, 6 Oct 2026 12:20:05 +0530
X-Gm-Features: AclHuK80foSKJUG9aXGi4lMnHGQEDESfSk-FDQU10Eg1rsE8o1J9c3o2lczDRbc
Message-ID: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
Subject: [PATCH nf-next v2 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Subham Pal <subhampal789@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This series resolves two separate issues in the Netfilter H.323 helper:

1. Overly restrictive tuple comparisons across expectation helpers
   (expect_h245, expect_rtp_rtcp, expect_t120, expect_callforwarding)
   that bypass NAT payload mangling under DNAT, hairpin routing, and
   reverse/reply traffic directions.
2. An ASN.1 PER decoding bug in decode_seq() where absent extension fields
   are processed before verifying their presence in the extension bitmap,
   leading to packet bitstream desynchronization or premature aborts.

v1 -> v2:
  - Retargeted series from net/nf to nf-next per maintainer feedback.
  - No functional changes to the code.

Subham Pal (2):
  netfilter: nf_conntrack_h323: do not bypass NAT helpers when tuple
    source matches reply destination
  netfilter: nf_conntrack_h323: check extension bitmap before decoding
    components

 net/netfilter/nf_conntrack_h323_asn1.c |  6 +++---
 net/netfilter/nf_conntrack_h323_main.c | 24 ++++++------------------
 2 files changed, 9 insertions(+), 21 deletions(-)
