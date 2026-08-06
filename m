Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA44570E9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014525; cv=pass; b=P7i4LWnzCkfHxYBnZPgKUAxbQDDRjGGseJHUUacoC+q7L00DbsHoC7OGy+6XsDUox26Uj+M9AELKKNYm0DiMt6Hj9wJYwDOpYDfK/AKjSnnWiSUx+5msOfEBQ9MT3w9RVgInNTJoANvbYi3Ufn7r26AU+KnNIs20tjzJ2iJ6MKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014525; c=relaxed/simple;
	bh=EM6BLCosGfeBJFtDqD/VbwR7sPOLdKkz2C4ocg1BS5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf/QoZ/uftWyYAPq3goI1dTcw1Rk6QNilsURTpknaZfc+amnQz/ZND4DptzsRYgLItFoARtlZBlRzJhCrpQF8b8lSu7lR/BrJI8J1cVoVU1J0j6ulywg+Tz91h4gYgl7ofPveXQkRUlzyh+H3aphM/z3dP3QUSee2++FHK0CICs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxzPcUfU; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxzPcUfU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1924732a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786014516; cv=none;
        d=google.com; s=arc-20260327;
        b=RcdKBupvSxElgSRSSV0VQ0aHjVqGNobP0lRBWcCiXkgrSCvxOgw4dw5k/hp8LeTqBX
         fSRAGCypvjlDULhDbVut2OQka7yBL4KVbg6SCG8cUTllwLpQ2OopctSh2V4B+wMSRKz+
         umGqhxvzg6FICZhCgEuSXmtk4KK8yiugsufkP930aZQcsvAKDKewb3xsodEmPKi7KDXL
         fMsos2ZsqWkmIWdr/DsNiFgo0DtB5tBMm38ftee8FczOWvCQC8DxH8gQjhcermVmSD7y
         ud4C+MBEv+oRl0TkEODxmV5B4M4OtQbYSWL8gZdKcKXxe+uU4YmM1puS6IcMTP/ORiYl
         7tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SeSH9QjY9/ICddSESWHil8j/Hw54y37cNPTdCzIm+tE=;
        fh=gWWolyprO+U/gNrW1X0/J7LQ3Bcc5ExNXDfKxh6CjVQ=;
        b=APtTrO0b8/q6LNvCsv5g/cIv0FvKa4nX0gm+eAlWPdFOTXsFcfohRfSIlfQjbls/K0
         p3MUc1QWqX24A+8saZXDq0OOMOg2uEoKo3nmJ0hVzYuQb8qBfI3rx4sOcFIcrUUzLrei
         XhCovobfVECTgNdhPJ7pE13OBb7Vgb0h/wh64+c8l2ARaUVoTX2thocNegxlD6scIb7L
         77acbZIESMncPWyWd+gHimnFuGuTU1CZ4w/OslMDCKVbQLElv0KgcTdLQ8eBzmuGq+/R
         V6KHtx4iIX1AqnXz2CoqxpCtCifmcjeXM1Md3j6pOzQ1i0fNuHbtuBoRwLzRlkPJgPRI
         +eJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014516; x=1786619316; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeSH9QjY9/ICddSESWHil8j/Hw54y37cNPTdCzIm+tE=;
        b=FxzPcUfU+SP2//7WIRHNvw0tIiO2gmkKrs0iJBdifrZ+KJE40nQDE4HjjF3QXsus8V
         HsuQ6c+3RByy7kfTJffQIvUMflLaLx+6i4BERnlPdy8Y+9vq6FAF1rtbl386Fmau1Omb
         ZelH6u0mavCTdGa2i3/7i0UQWv7vrZhr81B+81ptGl9P1/w8hMLweqGaC2fVqXqVQtWa
         jLdxRrSZJvCdLR+FqsKrqJPC5pgxR7fAoh71dk1vq+9yu2/VYXGkDD5RnFbQuE2PKic1
         qAMKUGlsReTMBRVwQ+kBq0aUHdyLhiePVoyd+aDy7UkaJqun3ktKT9FXod37WLThySyh
         geNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014516; x=1786619316;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SeSH9QjY9/ICddSESWHil8j/Hw54y37cNPTdCzIm+tE=;
        b=OAx3EsW17iWT0gquD3fzvUqypUPKE3R27Z6yOAGjzfXo5s2vOhcuRB58HQn6ZMVLIJ
         VeRaFBT7vCS5Q7GKZ+bAPUUs+/GWChWAImwCELfdvsMyn5apN7AlmRTBvKU4mSSSfo6L
         VeBZ1nihnKa+zkmo1888U6WtuaIDWawCHXnKX/iPahj9G471QLOIjkHv0mkYMy7q3CyI
         4Tm+7L0/G8R/Gu+SYFojwBRCtyL22eBuA7hNRj++Pnst/MLfVrYkcKenq4KsXAN+UcYi
         v1smV1oUfRkHdY7n2ibdd9nfaoG+yjYxKdKzXlg39fTqG1HNrqLIyuikJvlswKd5QqJd
         2HEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnNAV2COGgQOjSt1kD7Dt05qQ4qKWF8uHgBeoFit6mLKFJ257Rj17fGaBHE55SD/aGcOPTqX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1CdFz1ANINZVcygdeS1/h5Ph7G7RbPoVvVUW9eotKjwYXb6vi
	Sr8zgEvKasQFaCMeXvuUeHbAl9f/R5TnoHKgBeD9APf6VC5MM0dhlHxdgrFRFiEzrym/ZkATcY7
	q42xkN+v9+XWM4Ly/n6obaNnvaRx47Fs=
X-Gm-Gg: AR+sD12mHVScPgba/Akg7oeSx0Kq+WKFFrWC9jp04q4OMmP+QoFUn9vGjEGwuNbOrGc
	TGWKO5IBhJy25H5TrDRQw5c/TVNtvkMXKE213kaNEocrgizin5EgRtkswLkPM7iIEbs6i3ube2J
	Ywme2OLQagYZZGBV1GwXVToulQblMnrvJB/89vwmyqiAwh20Z1bi2UFEqXK38u/ZobNqT+7tCcv
	nneD8II8kuJqEJY08ssE1a1sJyCBJj7iUvqsKcR6OP1jhT2x3GuTWrz0SQA8tlmwTO7OzCqEVx4
	23yLk41mUfUJpU5Ia5P9WpP/hl0x5djJfe580O87WSr6Ow==
X-Received: by 2002:a17:90a:ec8e:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-3903c53827bmr15298551a91.2.1786014515603; Thu, 06 Aug 2026
 04:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260806102327.wrig23oltjzogyi7@skbuf>
In-Reply-To: <20260806102327.wrig23oltjzogyi7@skbuf>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 6 Aug 2026 14:08:24 +0300
X-Gm-Features: AUfX_mzEtHMUlnja0f1MxuB-IZVQhRJjhl7uNMwk-SKwEI-ep1jbrKu6_3Qu-lc
Message-ID: <CAAsRjR=_7afhCfmE3=+Rueoo0L7ZTqAbRjxAWO3Vd01zcYGvug@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> Is this a hardware limitation, or is it because global state
> (dev->vlan_enabled) blinds b53_arl_rw_op()'s attempts to look at FDB
> entries of the other type?

I tested that separation on the RT-N18U (BCM53011 rev 5) during the
measurements for the new series. Two builds kept ARLTBL_IVL_SVL_SELECT
at IVL while disabling the table, so the ARL read/write ops were never
switched to SVL:

  - table off, select held at IVL, VC0 learning-mode bits cleared: a
    static entry with VID 100, present in the hardware dump before the
    toggle, is gone from the dump after it
  - table off, select held at IVL, VC0 "individual VLAN learning mode"
    bits (bits 6:5) kept set as well: same result
  - positive control, table on, identical toggle: the entry survives
    and the dump shows it

The observable is the fdb search path (bridge fdb show dev ... self),
which does not go through b53_arl_rw_op() at all: b53_fdb_dump() only
touches the ARL search registers. The same dump shows the entry before
the toggle and shows survival in the table-on control, so it can tell
the difference. With every mode input the driver has held at IVL, and
with the reads happening through a path b53_arl_rw_op() cannot blind,
the entry still does not survive disabling the table. On this chip
that makes it a property of the table being off rather than an
artifact of the select flip. Jonas also noted in the new thread that
ARLTBL_IVL_SVL_SELECT is not implemented on 5301x at all, which fits:
the bit visibly did nothing in these tests.

I cannot rule out that the entries still sit in silicon and are merely
unreachable in every mode the driver can program, but for the driver
and for forwarding they behave as lost either way.

The measurements are summarized in the new series' cover letter:

https://lore.kernel.org/all/20260806073119.387-1-strst.gs@gmail.com/

Best regards,
Semih
