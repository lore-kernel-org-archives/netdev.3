Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794489676;
	b=sMJP4YgMuaby0V4MbZbXDQe7MC7QaoBGACRWw8GtXcPaalrVsuMtcFYB354sh77sHDoT
	 8DgSFfBjWl5OWu8YXU/89HiWxRr3bpqblYxmI8/zFt0kHk7mpKJidXKrFxFk8870LPWWs
	 VELZkCJTrOYCV7arrIWu3NTtVNwjNcF/a2TOvsQcYCGdzRaR66LpYQMyK0Ilcw1SGwM7L
	 x4LfM7VzlP91b9k1o+Isum7Fv9rY68+Et//1JYu0I8TdkL4TrJIf+FWwjma4h6fK5w4UW
	 5ejWhNeIbriJE0dcgSvqz8baO9Bj+6agg6unCrPbJdhUQN+ISMchjM4cf+hrmvZE7bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8xpDDYtNnR4aoubqNFgyzZP7ndEXc4ZbJtRWR/okbkc=;
	b=HHFFHg83VkkBqbhvrKRag8/HOkw3FYobtqeDFZIMgvGdKurkldvCEAfTSDQeB4GpqnvY
	 754gSni2PRd0In2VYvaRUru5gfBKVTohTJ1iXGd5SoQA6gyxRBQy7MRU9b2LyhzKiuls0
	 0He511f9uFV1qAnEArqsXgmWpwV/eRcJvhAc/5wCytd+L0KEM+KqYwtscuxia4qH3O6Qd
	 4wCpibvUc4tCfZnP1Vhj3XeNIPy8gchd0d+ilpPlpDSlm8Xm9HT6LoqyedCvl3rS7EQQu
	 NZt0TJe4oaFkcVRc9KNc8WaxdLFnSqRU6evcN8U2ttsu2gqT8nbwVx3kcs+JtheH33g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWkY05Zm;
	arc=fail smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1B606A880
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC1B606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWkY05Zm
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso4292839a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489675; cv=none;
        d=google.com; s=arc-20260327;
        b=cUY0v6JxpZ4aRBWzdCzjNmh2Ytp8TpHPrEnHjq+a1ZJTTalqsZvZ7QSWjUiUcse2Jm
         WOvBYyRWFMy4GffzVFnUYe3YMDV+G66WwU4xni6hP8FC9lRjnv7KuhFTZ3xdy0h6nhVu
         jIW9VTHB84EY7X6Bz0c8z4bE0qB2Nn8yd3zb3TEtM9j93hyGGNABDW/8Nch/MB7L0iT1
         UVWKxsz/6j8Lc5LGyE5eXRzNooCkbNQEMFIwFUJKhIoCzFYEWj2aq+6K8BdIuYONqhKQ
         k3VFwZ3+ZeQIB5YSZBPjy4Qj4yehZpXekCOCBjdIN4iM2/ne0nHWBbMbXf6+Juq8ajV8
         UUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8xpDDYtNnR4aoubqNFgyzZP7ndEXc4ZbJtRWR/okbkc=;
        fh=8emk6p0nKhs9OUe+So38DQarg/dTEtGVD+kJN/rYugo=;
        b=jWIzVS5fgX5Kh/SOr12JYR+25eo+JKqX/cdKTOCUGJ8fNedwbsI9PXb7KsxBtkEqCj
         pMkEb+RzA0588y8fTllYsJCciuIYFIPg7DhdOJa3QW3/KFK4+Xpon+C4wAc3vq0glCRT
         DOoAjYKuseOCd+hIFJx/VOOs7aNXwdlKIP1LoXxLYQoRnznctq6vq3faUoN2IDH5Tyf5
         cSpzNIEX+SehtRPURgSfGxTAZ4xJAlan/Zd6eL4gbo8XyqSwHp1t+ZJT9Qq+Nfj0GuvG
         qjgXg/644Oc4UIIrox7d1r8JNcnWVp4u48aQsalXiAlFmxvQ9At9Jr71jdq1INrD1QWN
         i1WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489675; x=1795094475; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xpDDYtNnR4aoubqNFgyzZP7ndEXc4ZbJtRWR/okbkc=;
        b=bWkY05Zm+4Ji3lpgLQHZzBS1LhxOm6Edqx5AQNdzdhkUYGakxIoCc9C6XZtdt8P+qe
         fl44R1s9HzqS9vhtDtJa16X3X4g3tTNtDFh+4soV+5NG0ebKZRx22iG5h8IaPbJLXgu8
         ANESjQZPMd2jGgxbRSnp6ciDQagEEYX1fMeeQu6lKHY8LcUbykBCVP7D8XjdQGm1S1JU
         LwZovkG8gNRmvBqOoxh/tWcFLFAFdIub3p+i/19TyiqX4OBhvg+c7QYp3F131+21pLV6
         p+lch4/T7JbNJG++Qth1BGNYS3JViS31mITKXq2KIsXmO7Ouk2i39BrsvgWNErZLfYCt
         ZNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489675; x=1795094475;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8xpDDYtNnR4aoubqNFgyzZP7ndEXc4ZbJtRWR/okbkc=;
        b=Cqz85ddOdBibj+1R3jzlrVhGvTKD9eUPj1nAM2TemYhHR3iaC5SYeeUvmJFgo+odRB
         Tq3abI742HKPntmy87xHPwALYPuoMyu8RxUcEASj7THY5SWf64xpg6qs54Iw2+Fq/ox9
         K2zLRx1IfRLCKbPdIrHqarjziFfvfp20q8CHdgVyaO+cqFMb0NbOUN8rPYdV6yj2TANO
         CQ9bzXDCCTTPr5n/xp5lBZ873xSz95pC6pegkBQsD3vgoUrfSKu1r/6V6ozA+SsYJeiv
         P2t/ex876w+FfaY0PKlOX93TnXqddjL6S5QxfED5MQT4xx07p3AutfmGKuQwdGK5qUZL
         no4g==
X-Forwarded-Encrypted: i=1; AL+hErFtKU6CkH8+zhSDClN+vgWaP39O0F7Dw+1hNIp3ZzS/Z3rNLFkG15+PFh5Lj76WNtLxBQh9Y64=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EL8DTxuQs6Hvw4sCpf2V7mmfBuP3+qOzoecglwS9AjnMxGjs1
	5W1RbjSZbD8fIi96aQorFkwy0xbChaBOSU05606YED6LBwNF+fHCG/5JegfiaUYIORy2gWWYaVP
	fNnN9F8/nrJz+m7/0Z49KCUi2uwQgTDg=
X-Gm-Gg: AYBFou1VpS5jSSBKJ+mgE0mL3Gag/Q8wi5D6WFgPL58HMeldz62+XORBHyIuIQRmXVW
	lL86tIfXc2W82MpMIbYUy5/N7+VzBN3s1xRytZyObBfrSmtux+mn1c23GoGK6vi/xi59+j/4QnT
	pP2Y0za8uTAi4wFFN30/8B75l5A5oFK7N1sCaeizkRay/ETU80W7u08pnSHflmnXKf23jawCGqf
	D3fH4DmrcJwYAdMf+IwE9C51Z8JeVvtmGuo1D7fNNOL65h2fnSllY/vgWiwPXGPcOgzd0tCM0Jo
	UR7S7JMY0i6E5H4dvA/mK7ZfU3vDtogf5Q/ddSt/2kMmq4bmhQPJWhfa8Kb6QH7W5im6SNvTcwG
	E0EitOR3y+QX28HqSPMBpBSSrXm/4j7ebzV7qKzizERmYUL1DrCY9qOXw
X-Received: by 2002:a17:907:ea8b:b0:c46:8b9a:39ae with SMTP id
 a640c23a62f3a-c5066b65a98mr447696766b.28.1794489674657; Thu, 12 Nov 2026
 05:21:14 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112130833.233208-1-skalpesh942@gmail.com> <179448901611.2168702.17174519811846942598@kernel.org>
In-Reply-To: <179448901611.2168702.17174519811846942598@kernel.org>
From: KALPESH SOLANKI <skalpesh942@gmail.com>
Date: Thu, 12 Nov 2026 18:50:34 +0530
X-Gm-Features: AclHuK-JD7-Wus2aaeNne7wraP3NOnDb65_7q1Yzj-qAflfIEGLjp_bdk0dIcgM
Message-ID: <CADYuhkoPNzrbQOo67=4qk+5MpnogwCi7CFpSSArP20Jy4ffPbg@mail.gmail.com>
Subject: Re: [PATCH] bonding: reject IEEE 802.15.4 and 6LoWPAN devices in bond_enslave
To: netdev-bot+sinfo@kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Jiale Yao <yaojiale02@163.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

To provide the requested context for reviewers:

1. Discovery:
The issue was identified via manual code inspection of bond_enslave()
following up on commit 9043be310c6a ("team: reject CAN, IEEE 802.15.4
and 6LoWPAN devices in team_port_add"). Commit 9043be310c6a noted that
bonding had only blocked CAN devices (commit 8ba68464e478), leaving
bonding exposed to the exact same IEEE 802.15.4 and 6LoWPAN type
inconsistencies.

2. Triggering / Symptoms:
The bug is triggerable at runtime by creating an IEEE 802.15.4 device
(e.g., via mac802154_hwsim or fakelb) or 6LoWPAN device, enslaving it
while down to a bonding master, and:
- For IEEE 802.15.4: issuing a netlink dump (e.g., IEEE802154_LLSEC_LIST_KEY),
  where ieee802154_llsec_dump_table() unconditionally dereferences
  dev->ieee802154_ptr / ieee802154_mlme_ops(dev) on the bond device,
  causing a NULL pointer dereference (as dev->ml_priv is NULL).
- For 6LoWPAN: on NETDEV_DOWN, lowpan_event() casts netdev_priv(dev) to
  struct lowpan_dev and writes to ctx.table, corrupting struct bonding.

Thanks,
Kalpesh
