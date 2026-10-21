Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792579486;
	b=gFEGjvswK5ExGbmlZ9WegER83qE4nLUHe3Gh+yBHoizs4tyExjqzg3aaxDD4fkFMLHBy
	 UJQSNqxHSxa92izEhyB+LZhvaXOzhOzOPyf4CjMWY1dEa/MiVXKM4c+GC7bVNFXmXrExg
	 1eCi9qBvtnMFEABih44XfVlsV49ypTgePRkXdP1UPXFyLZdAAs4dQ+Z4I65XIFrkNc3wP
	 TmgZcmaVX96+LC58U5lKK6Mpsoi6MpFDukBUmBJrE+0m0BgoeqAvfAQe5ZpS2HKsCFGJM
	 fU9FvWk7FVO2texGgGn30ydvmwBOW7y50o5qFXpoUPHyaeBkTNKRh4TwC0oj+IkJyjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3+Zu9D+KgKA9DXJq7rrfhDe7h3krW5LnH7aKJrVEA3Y=;
	b=tY1aovi+Wc9m94dOkMPFAsC5fwIhvIJEszIEW5x9CPzVMPEIaRMmZ+IbFLXWUsrebxfF
	 Cyh5ejZOOULrpCLvuxyDz1nckzYaPn9sZKpcqlmaXpPI0vJ0jarPA7bYLmIw9JkrQ54Br
	 Y1heVNsIyONhuCvpwWSHV9vMWc3iNeHoYTBdMYmEdvAI+A4/3deiGZuQtHGzQh4cxPr8l
	 V0Q1k5PnUdMZ1tAOcZtjG6wqsvF/ctwwxJU0D1d/WSf4d/Dvygb+8AmYs0CFD4qYEHqWq
	 O/HUa96QW7dV6x6T55vhMQiNXrAP56BZJEz3PXXpCIPt7YIzPHZCjkwCPH+x5pL1VFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EMJ2b1Mf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431D606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8431D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EMJ2b1Mf
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso361810e87.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792579484; cv=none;
        d=google.com; s=arc-20260327;
        b=cAl0eQUJKlHR+xH2oLtZ50isdGodblSqGl58C/qT/w+bTT/xkwG/L48aMWlBg1WIoX
         QC09kDOZxp8TaWTejPH1LYFDpzxdFi5qImqbjzh7HOFg4H+HBMftFgGcq/kMzlCeWdAd
         xIZMIaOOqrDrxYX/gmAZbv5xv+pTVRnK1SALRzl5lonWF7IxjD9hYzfmu1QvKu7BH8xv
         hRJR2PNIFabVpn+WpajFatIujIuTayDDZTWox/xS393cnHdMzQh/S7vuFWt6Hgk3HV6q
         UbhzhbMGW0FdmiuSW/oxtT+mQwb9hucFrrjJkbYF3wfOb3pTM++y0c4mMkHElXAtuzws
         p6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3+Zu9D+KgKA9DXJq7rrfhDe7h3krW5LnH7aKJrVEA3Y=;
        fh=FJoTGDS2Yq0n84y5msCAA7YuWoYcJdhq1lGpp+ckXmc=;
        b=r6MZfc6+noLFz29xQ9HqPOqM2L+1lwp4ZvqjGmdeTYUIjYz/Umac9LTLjp/Sq5Odut
         KueLIaJvmn17zh4FudlrMQ97JyZyNRK1r13tXF58BQmAW/qZyZasb5EksGI9TXCN4lBS
         gU7DukDMSrQppO4ARiG31Y+ZfCbQ96Crf/37SAfpqiX7Vn3Tver9hTYZXEdqiZ4yhklW
         iSiKRaHA+A8Pq89PLm+T523Dk3957eJsncLb0xr8JNcpV21Me1CC4FzZ+kqUss/vRxru
         5nIOL6DrdHJeST9gM+cBNWCs/HjyCnwyUlhAATx+dACA6XwU3adsNqxFvffHCScXVNry
         NifA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579484; x=1793184284; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+Zu9D+KgKA9DXJq7rrfhDe7h3krW5LnH7aKJrVEA3Y=;
        b=EMJ2b1Mfsr3z531uo4PbTQcnTiI1V6QP2j5RPccaDPxAHktd9HynIpimNpp3Seb44d
         dsnZSu24RsiD1Ks8D84LeNAS6pJL8bWtjZerKwun5BXvUwNGyxGGXot1ISBjBaelgNWb
         +LsiBG3i+1rd2dbFbheMbr8XhypCxbMgaV6YqM7xJmr0A6EhAAIIaRAWbMN/NPY/BODc
         BCFbyAj3A1UEcGi6L+CouAWi/U+85lD9TRk45mfBdIk4o2Hk6O3GAD0V/DT6h5+fMwhB
         HDu/WXCbJOx9fw8q3qCmbhmO4OLj0UJdhHDMNfw0tSpNpbOvILJCArJ7ODv+AMQ9ddWI
         UNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579484; x=1793184284;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3+Zu9D+KgKA9DXJq7rrfhDe7h3krW5LnH7aKJrVEA3Y=;
        b=KajPlU9MCcYVoveZHM8MJfoCN0xJTP76zurfeBMcZZT6zpBIAbIuD752VsvRbSQsTG
         a5wk6UpA8X0ql9HowdfDSNuNg9ziCMz/0aS06r39gz/1h/otd+LF5+Ll5scL+KNlnCw2
         cHQorZBHfnTTIh0Jt2PfoSihAuYAE+HctJEN0ee509LLATo182zqSmsogBwszQJzbV56
         xhGQdd8dfqJs/xe9ZXE9nganAXMxakLUPgvSfrTM/Fjm4rQXeXNGHS5Or2kvQXCvCpIG
         X0j1s1VWFd0CtFreo6brM2wsNFZAQ/Gi8utyYPTAWgcaA5mOJyXn5dCCgWyA0OpFSYJf
         b1NA==
X-Forwarded-Encrypted: i=1; AKwUvByQLC4ANxam5Y50E5qry1WYmhOioD5ux4pm1SnJGFv8koE3RSfg51cq15B87oZ60dwJLtdMkzE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7tmKLo+aPsi8tKTCpNEc6fUYCzLOH4Hw7z5+2NEXIbdjN+yO9
	XsWIyU4W7d2Mlhgv9FIZoicOUbeaxl2z6D8IBvWTvCvnSf0l2lD+XVkt21XlC1rEy/npzhto3Ii
	t6XEAEuFNgIstzCpN5Pwxu8CT5AySw8U=
X-Gm-Gg: AYBFou0iJsYwSpLYnaVkcgq0mJolEpdEcK87EQ+RVVqPISqqrGiL4LRUvsm9SGvRLZ2
	tsDFoP618407uV+7NgdRcUB9UtfK/0M9qmR8q8VdKmrlsm9ga/O0/4++RVCemcJlBU354ZGAzAL
	BCgzQfsJOkXg3ZmrrTxcCf9FGCgYqsoR091UQX88q1LHeKkevDPLtSqq7lavbBRpmBVwDOp9xp5
	NTup1KNNsEBAdszMQHNPyCGGTKU9tpwjI7fMQkWYCoLckuV2/U8EqNUKjX2e44mRCqhcCegaJnl
	iGewno28P9WaE+GMVmWTP2jsd25LspAOIehEXAlVz5RIdeNyHV8f3GQ/JOzgixB1bcRkjO5fg/n
	0hHezJ+IGNXQ+F4eSlmvzhSeQ9VgaeVFpvRIxBYFTEu3Ix5Ytcw2PCqjX9diO6g3usfw4
X-Received: by 2002:a05:6512:158b:b0:5be:50d6:af8a with SMTP id
 2adb3069b0e04-5bfa1ceb37cmr564734e87.33.1792579483402; Wed, 21 Oct 2026
 03:44:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012011707.3378-4-sigefriedhyy@gmail.com> <179185709988.434549.15422498299449004512@kernel.org>
 <CA+7S2v+LHUWXQMD-cYPEzT5-f3Qhw_vz+LEssQH_A_oqDKtnnA@mail.gmail.com>
 <8dcd9564-e9a3-4b00-93b8-3cb023d68047@redhat.com> <CA+7S2v+rWYvz9xKPEeM6=3HPz3o7TbX2uRfRKk95f9Y60HnEiA@mail.gmail.com>
 <976d815d-a9ec-4fa0-9b16-8e55695706c2@redhat.com> <CA+7S2vLWvQd7GrnwB+B+DiqAgST8EjfWwBKzJXtjGRBPVgmOBg@mail.gmail.com>
 <d3a1b219-84da-4ed8-9d87-5619e74bd1f5@redhat.com>
In-Reply-To: <d3a1b219-84da-4ed8-9d87-5619e74bd1f5@redhat.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 21 Oct 2026 19:44:35 +0900
X-Gm-Features: AclHuK-rJH5v9EVEYVeh2aYcnbIBH6iiXDeQCmZP7VNDudjBotFAAvZQy4bP1zQ
Message-ID: <CA+7S2vKt_n5MyyiG0wf01wyzTW-SUzyyRSw+eui3CL5rx0Zavw@mail.gmail.com>
Subject: Re: [PATCH net-next v11 3/6] net: add a generation counter for
 dev->mc changes
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, ajay.kathat@microchip.com, 
	aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, 
	claudiu.beznea@tuxon.dev, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, johannes@sipsolutions.net, 
	kees@kernel.org, kory.maincent@bootlin.com, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, sd@queasysnail.net, 
	shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	vadim.fedorenko@linux.dev, willemb@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> TL;DR: please include the relevant information in later revisions, at
> least as a reference link.

Understood, thanks for mentioning the background, next time I will
make sure to include all relevant information in the cover-letter.

Thanks,
Yuyang
