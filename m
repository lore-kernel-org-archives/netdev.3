Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F03DCDBC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933841; cv=pass; b=sHbHzzUxP9Zi6pvhfrX8RNpyMNgwukg0ckZyGlfESUchsw3nD303dIrsl2lXcgivBZ2+w7/OdK31W4xBzqx6htm38REkxtt56Si6r4LIsJx6uAOgcDJMUYJRA9KcAmaMXe25oadD0RPLXKOdzOOJFO2Chh0R5nwWVTL1GEZtwW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933841; c=relaxed/simple;
	bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7waZhSe2IpSBmzQ+wsptwTg+MQmL/Yynt+rDGfQ6368pIcU9qyFQ5uJVNksgxgALkSCwBqePwJq08E2box8GKEXyKwdKXt9ottRRoruedMowglU2D+gugq3KX5Czpqn6ErpSs+3iPXW9GIBFO1XKmkKv7W25YN73mjysL94eI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9L5Dpy8; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9L5Dpy8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so77315e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 12:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782933839; cv=none;
        d=google.com; s=arc-20260327;
        b=H8Ym19hOE6aNOlm6u5+rWIZu9x2YOYn2/SJcwi86RKsCczIi4kAQxCZzh2e2FGS2PW
         81hZkMutbtPK1vDEQ205btm51GMLdqW2IaV11FkKt61ZHpk1JRibJ2VoCkbdJVTOVh0o
         fHzC3gCGwGWbcJipD954JYUvyGYY7jtrb8TWOCbhzXoMj76qSq/fq6yU40yGyl27MSS8
         TWw5rIcgH36xY5Rl/E0z0c0Eo/zaa759ZIrR+A1FPBQ3nBvlQ7auhLfUM/VNKDxfjKII
         kd1VwT5G+/1eDwrnm2jHQg58UTU/o+kmhgP2ub4MdBS02YhIC8G+D36cAuWdj/fzHCR5
         793A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
        fh=mXCOQCoEgmyYNWLcWmz9Vxoy94+QBz1t7F2ubSMr7KM=;
        b=FSlfnAmVqsJOyHUwmiAjog6HHWhWAiyL7r5mVNMRNzccxyJUTA8fymzmuCcXuO0dzX
         i8PrxRsv0Rjtiei66sJk64y99mdKg+gqyLCJsfTh4t5C/HuGEpzyJqRaKtQwBB0MG17o
         o2LdhGFkhP7RcRrki6T3VhajZCsMn4dEjT+unVkbBRiBcSZqs7lv71KeinMZm+HFqDh4
         CCkZYiKyoMpZ1kFBaZGN9KKxmIPSk9YLJGh7tMZ9FBXjCLnYwzz6cDwv7g7fkdHkrCAJ
         B7Dm7xkeLYMQbxnifc5O8cOmGDUUGSPr0LVOKKL5nJsncpBTvZ8zlTjEDXP5vq00w2vy
         WbNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782933839; x=1783538639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
        b=Y9L5Dpy8z/KuMsCmndEzdcnpi/Mrwh0CFBg1M0fnL1iWlsS4aPOnfH4bNx1PqNjsQA
         pQePWlFcyEutcYwiX7JyQx/G8uWeFKkvEIVjLn+Kdk5xoEEXlnu9eGefuvVqTBH8RxDL
         Y4L9yGAlaB5zBcfRW6QlfIA2WMmv45zEN62CdMkdRm9ml7esAVntkWNVxNvXXlaY1vO8
         qKl1ubOdRLOQu7wH9O6cJ0ONfpdOx4AZXMHbFTqcgZw5rEsvKcr5f0pn5/PcmENO90mX
         WXq4EUtBPB09QMvHl6X28/t7IzjWRd66e6Z4N4SoLGQim2pyRMLo41v5j9S9AFtdz5O5
         VVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933839; x=1783538639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
        b=p8wR4TnGP/dDLN+af9FUJFWYOcYiGN0WyulT9k0NFRTHaiHZRC9znF4jUBvYSqWZ2p
         SlM0M425S9uQcTFsalPgJ+LsQR4v73dvxWyWAhXDIJkOQmDN+UHHSFIZwID+/A/Ec9yd
         82DdH4T/MQnNqBEUPJM6V4ZWOkjy8zJ+AUNO0jPTi3cY3nex2QPAzoksHwfhbXPiLomR
         wru/uTxRe0zfNsib/c0IDAycJ5j7tCvrEKUXvfGCXladXF/oA6lSqTSE8+yQfDvs8sV8
         Imv1ub1ql30pbiZUEQ7/yBN6Q6zNhY6CGx2ufPzhzFFvtSbfrTINCe+ocB8W+yOJKSEC
         8Hxg==
X-Forwarded-Encrypted: i=1; AFNElJ+zXmeAIiXyKHvC5DILUFGYx65SfQw1kaZC9tPH9AM7inMLYcEx6UU15mERIuEEQps/t08b1po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+VbtZ+ex7iLwen/TbLLVarAHGsjydBT1RQlwlJSLJZCNiJ6O
	Klw7QhDKOoOU9wK2lD8pibKrKMTXOEQ1QhX7nmrIEc+3nX9thWlm5FfHYGbtl7/RKGjxbIbapLX
	XaDuf18b5U9yRllElWwBjYkKJJv6idjeq1tvodTwtryfc6GUjO1WSkqmMG6U=
X-Gm-Gg: AfdE7ck/D2OR2RlTQBW9fEPmKOOCygonfmhnkbbpS1eihrlsmQlae/fwojPvD53705O
	FhTNYtTX5LlfZul2C6VdYrg4w8HI1xZCAaF2gpNy+1/8kQj7lIIL+NZy8H4ekWVDxZul0bQu0Wu
	CPoMWqJ2WOj5D4/GNcLk61MF9vLN9aGSJbGrBPKV9R4KyO4yNzyyWhB4/lFiYFU4NOLX+e4kFBB
	yz06OyHqaMTv9UZPuNv3S+JE73yVQ+IoN2t1PHH8Ds9nDYYvSW6oCk3sGdYEB996SNeK77UxMpJ
	JlKpQSXrZhrCg89pwqIhkQHhbczlFA==
X-Received: by 2002:a05:600c:4254:b0:493:aca0:32e2 with SMTP id
 5b1f17b1804b1-493c0b8dc60mr1101445e9.4.1782933838708; Wed, 01 Jul 2026
 12:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625181557.1086105-1-tjmercier@google.com>
 <20260626180941.45158025@kernel.org> <CABdmKX2oG9m316hiJpSXbujrT3vgE5hUpzH_WHfjNxBJ1_+BdA@mail.gmail.com>
 <20260701115708.01213909@kernel.org>
In-Reply-To: <20260701115708.01213909@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 1 Jul 2026 12:23:45 -0700
X-Gm-Features: AVVi8Cc9XyUG3uGiXCOCq9h4RePCwClPydes5CEX-eBZWcC0PMTerb9YxE0VoYs
Message-ID: <CABdmKX0bkWgMM4LNLFj_=egSCNSL4a2cqxARu0f5_wgSpjvd3w@mail.gmail.com>
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 1 Jul 2026 11:53:15 -0700 T.J. Mercier wrote:
> > On Fri, Jun 26, 2026 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote:
> > > > Write permissions on the /dev/udmabuf device file are not required =
to
> > > > issue ioctls and allocate udmabufs. Applications should be opening =
this
> > > > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [=
1]
> > > >
> > > > Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> > > > drivers/net/hw/ncdevmem.c selftests.
> > >
> > > You need to explain "why", too. Why change it if it clearly
> > > worked for everyone running this test until now.
> > > --
> > > pw-bot: cr
> >
> > Principle of least privilege. Folks use or point to these selftests as
> > examples, and then wonder why O_RDWR doesn't work on systems where
> > write permissions are not available on /dev/udmabuf.
>
> Alright, pop that into the commit msg and repost please.

Done, thanks.
v2 here: https://lore.kernel.org/all/20260701192210.2997769-1-tjmercier@goo=
gle.com/
