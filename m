Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B47252B
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039927; cv=none; b=cq2aySpjs8e9ZER5nwjzWZmYW1DR9RQF7SfGz4cfAJsiC4fxkAI6G3rDvCSZ0NJF6zO0Fs5FWQQqTV/2ape36QPl3+gFTial9CYgmOMpQwLjjfDhSMf1ZdV52u2L4LcRxtRuAYZ/50jCTskm8+yDfBriGYlHCBjzFAR+GBB78pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039927; c=relaxed/simple;
	bh=lJZi95WZB7yzdlKPvBofx8mF9bEAbVe5sXoFviCtnMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=ow4M+HoiOxdNfFcaT7A0OCXOlnFGrOEHit1jio/3qm992v8sw68sYSfSh17u3s7AIau29tpy5g4VKR1ptDEzuf4aSmhCcCNWoyU84nGagc7a6f1digEX+4WAxEZaK4SAhYE90T5VC5y5t7MEsmUsJdabsZvEiEpYQOixScyhFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSCSCPQ9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSCSCPQ9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-86908cbc011so1403797b3a.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039923; x=1789644723; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPKZJQlP21ww4LrqqKoCC3eq7Co68DwS+hHs4a+8eYc=;
        b=WSCSCPQ99WEhgSMG29hwUfvzAE3NRCZmk95Rkda+PLeIQkZanHPraZ0QjEZkVPgXPS
         vOnKwJ4Q/B8B9BSmuLSqIS+ASAkKLS4gTOH8hPU9RJkJEZ0SDhIU5fJnADChtiECHTSK
         +liJjWjepGcOfeYCe/BRUGnpGKCrPSuX2RYafwjSd3ZM7cAoS0psbumsut1OMxAveEvQ
         wzt0lUAfB51nUDw2UblJGPTHScLleSZIkQOux2U+XpR73R2FrFrZZuS2Z3tyE7YJ8QtY
         bPxNoWRGuKmYyxhzD44rBb39oWacp2TKBpbQow2nDSiIxfggRcsZh0MJFutUCXsSlL+4
         h0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039923; x=1789644723;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPKZJQlP21ww4LrqqKoCC3eq7Co68DwS+hHs4a+8eYc=;
        b=l76SA6SWKrdipNmpm6u5ZmCNzleRmeYOeBzBFiLFa7VWEwzesYtOHIamwq6BpuxObn
         aawht/UXpwD6MgftwPOSuy58l0faVXvXvedDUV5uXzzzm2EVcIf3Oda7WEdZ6ebetbge
         wZj1RcXjFIyf0RRdzizbOvEa5YW3Y10zT8zD74cmlTHRMMvj40mGiXOTEfPf2R68rCEA
         fsSMMw6CIEmL49dVZRsBsAMkYffotk0XGBZvKVs6nU8SCYiGQP0l1z7lHZQhlBhlTpbr
         4gbf8tOpmsMkMG4NxwMLOW38shcroksDOVptkvA4AgfK3/1tZCtmOleX8P+6nDTVuLt8
         /Anw==
X-Forwarded-Encrypted: i=1; AKwUvBwybw1WRrI0AFfOoY9fxjSfjWKUvpG1oIATxa96dBCk37zqRnZEPAQh+D18qKvNcIfkT58HbMk=@vger.kernel.org
X-Gm-Message-State: AFuF++k96tnTlQ734TZXqrwzV1x17PSzNUHtlRY3OmeFc85hF3S9uzz4
	gSNA9YhxES7dHoOyNSQrRnwz5OAUNH4FyABrdur6eDiYjlDVPVL81Seh
X-Gm-Gg: AYBFou33LR8hh0fqM8uO46TPdY0Lw1vds9QtPzpAnB04UNgBO5qFnpr0vDgnL3e3QaR
	GJpC1rUReq5p9l+ssIV9XRwpC6qCkyaKFzyymXq8D5Y0TtinFVEyRcYLjQuutOrOdjMFT07p/vU
	u1noy4odWPJ7ZPseYSastfHhGRpbvOYJcqjnpLXXcL03D2oFW725E1gLo2TGkgpRMZdO1wsU+yP
	9Zc0EcN86wD+lOjJ1DdQzd7gkKF5TLuM1l6Zlb1Mz5q18U8oaYHnKVo8LTcUlT8w+cp/h0Lt5Js
	agvY/35LvIiOJ81adR4jSJoTZw7SbNg3LlhfnDiLgdMR3TnDuVIo8RfeAZej0STMa7u6eCiDgta
	iiGC+pAo631ZCFEVbJ3SYBYLkvaUd1YOAS2rk2HzFiLvB9UFU43G06LvG7yqqGW67KHvuZy+9uf
	0/mUqWGXXxkJs2nm24e8LeCVOJ0dTy0xIpDdMxrZbCeseF1CGHqZpdX6I6b47s/jOOYoSkA8gKr
	qauB5YcEDMa4Bzfq8OSt6Gb5kn/2h2Hk/B5hloMnt6+C5aA1/ro9uBYCj46QBThdw27eDMSNWEV
	dpl1FpBPSKtfGJVgm/WIZvS0ur8gw4TPdaKukHB0GgIIXHIY5B+my3guRjyxIlFi1KQUx/3n1Y1
	O+N3/Vbs4VlXKW6UwdoZC
X-Received: by 2002:a05:6a00:13a0:b0:86a:59ca:6cb6 with SMTP id d2e1a72fcca58-86a59ca7130mr2870537b3a.20.1789039922659;
        Thu, 10 Sep 2026 04:32:02 -0700 (PDT)
Received: from [127.0.1.1] ([43.227.225.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-869a5b727f6sm818032b3a.28.2026.09.10.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:32:02 -0700 (PDT)
From: Nikhil Ludder <nikhilljatt@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Emil Tsalapatis <linux-lists@etsalapatis.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org,
 razor@blackwall.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
In-Reply-To: <7f3e237e-ac5c-46af-ae21-8b437a099fe3@linux.dev>
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
 <178898653497.1776876.10402414041023036972@gmail.com>
 <7f3e237e-ac5c-46af-ae21-8b437a099fe3@linux.dev>
Date: Thu, 10 Sep 2026 17:01:52 +0530
Message-ID: <178903991209.1916825.3991149870565892141@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 9/10/26 12:59 PM, Jiayuan Chen wrote:
> Yes, no deadlock.

Thanks for confirming.

> BTW, if an IPoIB device can show up here, dmac is already truncated
> today and the packet can't be forwarded anyway.
> Shouldn't we just reject addr_len != ETH_ALEN instead of open-coding
> the copy? Then you can use the native function instead.

You are right, and it is worse than just dmac: the line immediately
below copies dev->dev_addr into params->smac with a fixed ETH_ALEN and
no addr_len check either, so both addresses are already truncated for
such a device.  struct bpf_fib_lookup declares smac[6] and dmac[6], so
the helper is ethernet-only by contract and a non-ethernet nexthop is
already outside it.

I would rather not fold that into this patch though.  This one is a
race fix with Cc: stable and no behaviour change, whereas rejecting a
device that today returns a (garbage) success is uapi visible and does
not belong in a stable backport.  Would you be happy with the seqlock
fix as it stands, and a follow-up for bpf-next that rejects
addr_len != ETH_ALEN and covers smac as well?  I am happy to write it.

If so, which return code would you want for that?  None of the existing
BPF_FIB_LKUP_RET_* really fits: NO_NEIGH is untrue since the neighbour
is there, NOT_FWDED is vague, and adding a new BPF_FIB_LKUP_RET_* is
uapi, which is another reason to keep it out of this patch.

Thanks,
Nikhil
