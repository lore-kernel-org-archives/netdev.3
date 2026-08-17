Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EB41DE1C
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971283; cv=none; b=kaMIQUzAgDHDwcZCUj0/OuTzBMEuU6oDIvwsIxo91+Ho7y2yJtVT60xYN6yUoBpQNN2u5LJ9b5NbG5lG7W2Zj9wHLhj8Mt614q1Yr/TvWMVYybDwzbVTPEmccKfWdsOfBi+usUPPGvHtBHJSCpsBZduW2m4E4Jvs1anlwaigYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971283; c=relaxed/simple;
	bh=3kUL3GRLFOF5j8SmCqlLsVcA28KrMp2QWXYKbNCOzH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nVhzSj6un2QWBs2foac7wVlewFyldU6c8ZAZ+QQP0HQyNeuTwgdgmRLIW5x/MBgg0HM8dXBTzy8XOgcOyAdftyXHQwyUo+7qpof9mJJS31vM4N5krb4iW2H4p9WDtMo4W0xTQhlcRmLJZwUDKNHgTb/zfIPJlaR37divbTwfAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh0aVVf/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hs1aS+OB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh0aVVf/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hs1aS+OB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786971281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h4+/jt8gnpjJc1S8Mg57sMd8//zCDIso1d/IQvBBrMg=;
	b=fh0aVVf/8PVsCwCFl0WgeHyk/aZj+oqUivvKRXKQOKGouyYAvbfx/zLF7Oin8keXrFArVt
	/qD49COUpRCOy3wyW7NrCEYW4Ejzwn7QD+N6WyPfGf3bM/zyh7jTDrtLzEHBrPkc55C8xP
	GpArXPO1Ka2u9ETbz3Gt7QHMxIyJCCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-jzOsJOj9MPe7II7smI1HhA-1; Mon, 17 Aug 2026 08:54:35 -0400
X-MC-Unique: jzOsJOj9MPe7II7smI1HhA-1
X-Mimecast-MFC-AGG-ID: jzOsJOj9MPe7II7smI1HhA_1786971274
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso27189695e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786971274; x=1787576074; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h4+/jt8gnpjJc1S8Mg57sMd8//zCDIso1d/IQvBBrMg=;
        b=Hs1aS+OBMum6+EpP+xuSzXezTirytOATgfRDOwLMDJfvEdK6ehICvq3u+odZti8qEG
         oa2EtFJJOTW6fIca97/QusF2NuDPEQWqWM6fKFoQxJx2jkSr8FbH+YZnkw6puF3tj7Zy
         MzUkMOD5Hf+QvELlS88T5XnpWc6oHzVlso4100NZSgBahboO3hCm/I+B0IzA0I2h1cJO
         uPAagWEkrno+t/OT+lgdBn9LACynVc/ryH1Cgjeb7bpve7emloPNR4aR1qzEOvAlTT+q
         RDG8Fdbr8AmBc/bImqdR4f9DlOdg+WeTmhAZlv9PIu3HqQvSC6wPwRBBNaKaW/s/l2PZ
         t6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971274; x=1787576074;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h4+/jt8gnpjJc1S8Mg57sMd8//zCDIso1d/IQvBBrMg=;
        b=IkPEF63Dimz5Mh0wJAkqIwLN816dGgTieA7+5oN2rK/Y73EDRbtkVdX0HftcI5Ek2X
         m0MXKmxhgQ9qp4WNN64f9WsHwkmKIN20umTZbJoqomCe3UrXvYuszjLMZl5qgzQ9vt1y
         b6cz3+CYHNEYN8CE25VTUk+SlSSRn6shqsMInrIHCoG7pYHlULvKM6e80NIpWfjnKv6q
         0cQJ0mr30pA+yPXLfX55Za+IylNDDYpIR9uSjC3E86bB9sdocXPaxn4N7hrzKddXzR1m
         PXlDUJbsM3maPURIYseqc0w26efOOkZKR5qjCjYQni9j0Qe8CXJzklFwtmGxyELDJEvm
         xzlw==
X-Forwarded-Encrypted: i=1; AHgh+RrdbvHHUI5qLjL3k3JKeHp7UyCDkI5nyhZN+jzU1QLlSPwa1ebG6yTgc11ePNbgAfykQACw3sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5GRvxy6lC0gfXbHuuVWd4mhF45GHPwOk2p7OX71lMsiJHxIe
	PY/VVT1G1WhiRZd6KPyjcTmVhme4+14qkmXhnnQsDvm2zsOlzqDzGj06XZwXIwOzWd36pEtEe7P
	syPEDhe6ysk2su6PkUE3F5ppN67tbP0N6T0DSVi8J7pm560Kr7hO5+FvD5w==
X-Gm-Gg: AR+sD11/jDa5orcSyz/0uIZiJ4M44AfkOP6PehdyPgOLoiiyo7MbC+m/t3INBM6iU7A
	qdewEqhJbeFzushr1x572mqAZohZxaDR9qqZL5pf36A4Qv5ptbt5dzfafEgK/SWS1LoYyoHo//y
	X0bMlUks2uhkIpTdZJaqUdWlDByr7SQdeLLmp3DKYb/xyUZ0oi1qaDYm9YuVh8ocuQRjHVDwEee
	oaE3uZKpS41JplMOzjeGWD0X6G/OVWA/I0XpN2d+rJurVQ7/0rteOTyk8CPrNbi90Bjvyj2YxNx
	efExpTftJcm8DazhRPgPDDqaLtoq/TFi2R4BQxOL/uyXHwuRs4CShRqtaiZavrSaF6VVlJ95EVL
	exb5gmKmInZlfbenivW2l11Nkn/wxRs6a0zXj9X43JJ0R9OUx9eZYr1HSP6xqgu7ykQKW7XILiw
	2DuHwKNV1Ntnb/XSEUaqIXJFPm4QgTidVpzXdBWo1TW3k0
X-Received: by 2002:a05:600c:6089:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49987941e38mr437817045e9.4.1786971273897;
        Mon, 17 Aug 2026 05:54:33 -0700 (PDT)
X-Received: by 2002:a05:600c:6089:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49987941e38mr437816475e9.4.1786971273572;
        Mon, 17 Aug 2026 05:54:33 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb (host-95-247-118-130.retail.telecomitalia.it. [95.247.118.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961767f5sm126998835e9.9.2026.08.17.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:54:33 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH iproute2 v2 0/2] ss: fix vsock port filtering
Date: Mon, 17 Aug 2026 14:54:19 +0200
Message-Id: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL7nVD2MLpKRJiutQQpWhKEd0/6H
 GaYFwJ6wgBj8YLHSIHsmYGXBahdnhsy0pmBV7yvhlowQ88Sg1UHM2JtRKs7JbWG3DuPWf6vCch
 5e1/IYU7pAzQ9HuZlAAAA
X-Change-ID: 20260817-fix_vsock-f7b374d5cadd
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
X-Mailer: b4 0.14.3

Vsock port filtering is broken for ports in [1, 2^31−1] (i.e. any port
whose u32 representation has bit 31 clear, which includes all ordinarily
assigned vsock ports).

To reproduce:

    ncat -l --vsock -p 27354
    ss --vsock -l src :27354   # shows nothing

    # Without the filter the socket is visible:
    ss --vsock -l

Ports in [2^31, UINT_MAX−1] are not affected by accident.

aafilter.port was extended to 8 bytes to support unix socket inode
numbers larger than INT_MAX (see 012cb515). The vsock parsing path
initialises a.port to -1L and then calls get_u32() via a cast to write
the user-supplied port into it. get_u32() only writes 4 bytes, leaving
the upper 32 bits as 0xFFFFFFFF. For ports < 2^31 this produces a
mismatch with sockstat.lport.
For ports >= 2^31 the int-to-long sign extension also fills
the upper 32 bits with 0xFFFFFFFF, accidentally matching the corrupted
a.port and hiding the bug.

Commit 1 switches from int to long for sockstat.lport/rport
Commit 2 fixes a bug in the parsing of the filter port, that didn't
clear the upper bits.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Expanded lport and rport in sockstat from int to long [Stefano]
- Applied suggestion from Stephen for port filtering.
- Link to v1: https://lore.kernel.org/all/20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com

---
Luigi Leonardi (2):
      ss: move lport and rport in struct sockstat from int to long
      ss: fix vsock port filter

 misc/ss.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)
---
base-commit: da2ccdf862cb1eab45de082cc71fcb4e5d712e78
change-id: 20260817-fix_vsock-f7b374d5cadd

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

