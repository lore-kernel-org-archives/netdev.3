Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C72C21DD
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649958; cv=none; b=gc+7vDoy2ipGFI+si7Cp3BWSscSZ5iahVHezBD6GOEnUTo2pKxnBdFT/rWc3+IpZMV8E1kOREfyHkSS3X4xrirOetAnFQrQ0GCKZuFBdLVQfqJEwBVCZHEv7BPA5vDdIfmI1E9pvO2NzgTUgqGKwOouJtqFGjlfFkOlPReU48H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649958; c=relaxed/simple;
	bh=lVWPYmLjcVZ+N1Uqx9EaGV1qwPO3VUnJ+w7knfQuzqo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FhDyb/QYT5Rv/DuY2ZcLsq2ZvvevcI17t2Vd6RXSgvU1Hp28GG+dYOquSn2ClDY9WgwzDg4mL8Z4w8KmAYZth5Ey8bWIj5ytA6kmoSf0WQ+gQROszfpmGimT3nAQPlFB48Eh3KivlDGPq6K2eA0ua0ALTB9rY1ynE4hc5INQa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTl2ORyy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTl2ORyy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caed617615so127452385ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649956; x=1785254756; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FOZrzyc4HgbtB+EiMzOKXo+huTClzA+QcrlwMZqKuDQ=;
        b=WTl2ORyySLIsst5I5RUb6nW47h4OcUmbKIrZpz4cAy2F0hlIYEI/2mNtm0ZIzSqoK8
         bqDymWz0lvKtiyvNHaxM1wNaf+82jquw9+WbiwpQtMJIpZekGdGrrXDfaJveN4+Rdrrl
         qOMh/sFNmDKtf5vXu9BdepMQPTlkaE9Zq4t3zaHLXTKk7EVtSNdJl7hggECvoVg2ToMy
         fI25f3D+o0BhBYyHQq+1QpQ8kup2njPiZGBjYsDT1+uxQPRsCoT9v+hMGfmi0WW8rCAG
         X2lTENNal8TYZcHV8kMOXdc/FOKieVlPXc+dXac2B/mAy6i/XRZOdw3RW3G2cOVEPtCT
         D7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649956; x=1785254756;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOZrzyc4HgbtB+EiMzOKXo+huTClzA+QcrlwMZqKuDQ=;
        b=bDraLVWBZt1KsUjCspoqO1obyKxYExtt+mChgO4fO4WM+tCJNv4/UCJItWBAi7FTK/
         xTHNbS+aaxY2EhCw78V9ndxf3EuKD05DHK+Ag5a47OLc4sCQIe0Gw520GlQ8BaYEoJ8R
         aI9vwaUIJzmrEElrnBb/Ek5xutu8/CN5u94tArplUcdWdQa2ZuQkmVm23yGHl0ke+HLD
         /bAQWGXZDwfZAXzKMSGUrTHpiMQw/tBq3dV2fCFpay9iCY9NlViOfRZKoMPgmWj7K4BG
         ejaU0+lAx+tC52tE6EuW+9qBeOXvBPbZtPSGYlpSK/LDpvhMGvaHYFVoUfQhKzPywBXN
         qB7w==
X-Forwarded-Encrypted: i=1; AHgh+Rom0XC8TJbbXZVCJoeoNQ4v0RNKLNZGgwQI/YAZcdIPDRk8iHeoPNqJUtFdtlfXh2zf/W9xVk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgDQXWnHC14Yc1wOh1s89SEGy20C9qbEKgZ/ruWGSIbp3skRp
	oh1AYS4flbJ+NNW9Th7H91WsbwQueHX5+HKKVxyoNhb82/VW1+3ixBYW
X-Gm-Gg: AR+sD10gDKpD6EgZ2pcnUPmWfLt9ztaYSA1TxKZHulTTnHTNf9t21Cd10rXrhhWVdeA
	OEPtktSUlgAgDCO/TZmdy2w9fRQP3StPTEQddUohU7ej9CTC1uHcvwGzYgJeVEDGF8Us4RFUwc4
	TR91fYMToa2kSadBdqW9WJC3MpGeLkzYQKs0L1pswdGzec2Dnb7EPXLEiI//fByGuKMNOOkMSql
	RihEyShWqnTgdVT4bN4YzOMB7cPJGOYz3Oh9fTRHtXMINKbC5hKCSerJBsNVk2fZsi7UJ193pUw
	wniJ5zIbtzzQTL3ymb+PJk67Q3QPBr9KwzMj2vxjGWwHGV63d4NOA/UGqim6t8UZoKpFZhL7G3s
	VvcE6QWouGwiFX/WPeuHU1n+Y8/BDCsD2KGZKXxGKD1BFcrF6qomWpPLG66cuVa2bvXMNj2eeCE
	veVx4W1pYOez4xvh16GZIj
X-Received: by 2002:a17:90b:2416:b0:38e:712a:be66 with SMTP id 98e67ed59e1d1-38e712ac411mr7215046a91.33.1784649956152;
        Tue, 21 Jul 2026 09:05:56 -0700 (PDT)
Received: from smtpclient.apple ([202.8.105.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9237cd97sm1966446a91.15.2026.07.21.09.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:05:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3897.100.8.1.1\))
Subject: Re: [RESEND PATCH] net/core: consolidate RPS dispatch into
 netif_rps() helpers
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <20260720162518.38414fa0@kernel.org>
Date: Wed, 22 Jul 2026 00:05:40 +0800
Cc: Jemmy Wong <jemmywong512@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 horms@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B2B4D81-1571-4323-ADC6-A1CDE22E7376@gmail.com>
References: <20260702152830.39065-1-jemmywong512@gmail.com>
 <20260707154855.12134-1-jemmywong512@gmail.com>
 <20260720162518.38414fa0@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com
X-Mailer: Apple Mail (2.3897.100.8.1.1)


> On Jul 21, 2026, at 7:25=E2=80=AFAM, Jakub Kicinski <kuba@kernel.org> =
wrote:
>=20
> On Tue,  7 Jul 2026 23:48:55 +0800 Jemmy Wong wrote:
>> The RPS steering logic in netif_rx_internal(), =
netif_receive_skb_internal()
>> and netif_receive_skb_list_internal() was open-coded three times, =
each with
>> its own #ifdef CONFIG_RPS block and manual rcu_read_lock()/unlock() =
pairs.
>>=20
>> Factor it into two helpers, netif_rps() for the single-skb path and
>> netif_rps_list() for the list path, and switch the callers to
>> guard(rcu)/scoped_guard(rcu). A new internal NET_RX_UNHANDLED =
sentinel lets
>> a helper report "RPS did not take this skb" so the caller falls back =
to the
>> local enqueue / __netif_receive_skb() path; it never escapes to =
callers.
>>=20
>> netif_rps_list() keeps the early static_branch_unlikely(&rps_needed) =
bail
>> out so the list is not needlessly walked and re-spliced when RPS is
>> compiled in but disabled.
>>=20
>> No functional change intended.
>=20
> You haven't read Paolo's reply, please go away.

Hi Jakub,

Apologies for the confusion =E2=80=94 I am new to the netdev subsystem =
and
may have handled the process incorrectly.

I did read Paolo's reply and sent v2 [1] the following day to address
his two concerns:

 1. Dropped guard()/scoped_guard() in favour of explicit
    rcu_read_lock()/rcu_read_unlock() per the cleanup.h guidance [2].

 2. Moved the RCU section inside the static_branch_unlikely() check so
    the hot path (!rps_needed) acquires no lock. Verified with objdump
    and bloat-o-meter that the fast path is instruction-identical to =
base.

I should have replied here first before posting v2 =E2=80=94 apologies =
for
that process mistake.

After re-reading the maintainer-netdev.rst guide I also noticed:

 - v2 subject is missing the target tree prefix (should be
   "[PATCH net-next v2]").

 - The patch is a standalone refactoring with no functional change,
   which the guide discourages [3]. If it does not carry enough value
   on its own, I am happy to drop it or fold it into a future
   functional change.

[1] =
https://lore.kernel.org/all/20260711121009.76842-1-jemmywong512@gmail.com/=

[2] =
https://elixir.bootlin.com/linux/v7.1.2/source/Documentation/process/maint=
ainer-netdev.rst#L400
[3] =
https://elixir.bootlin.com/linux/v7.1.2/source/Documentation/process/maint=
ainer-netdev.rst#L416

Thanks,
Jemmy Wong

