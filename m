Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43783BBFC1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615355; cv=none; b=ld0NDnL/LuUFYKgOdRYY9Jf/Ys39xAxfU4SIqkW5x3DjN06679yT1i8ed4ZFEexgU4pXhWxN+vsR/aXHYZ/+QWFntK3KQRDOL84s5pU/Wj25mMqr0I1XC67EUORMrkBdbNeQ5SFneonY115NSzjCx7YhPDjhEaScuqnIX0hAz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615355; c=relaxed/simple;
	bh=ZeBj54ggXsLdjqCMa1yT5KFc7o1ExZa5IiPgFr9KRUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLb4owGhzrGwcPjU/SHs5AwxjDnSnt+HcbRkJ592ZF0blYc0JLH3lQcePodgcwdQszHxwlMSdwoGf1oFk9LTxqERPZaU/hQs0Vehp2Ehoz/2+7HgFoze10orx6vdzcAly66vdahaR/R/KeykA7RLvz1+nJGI7f3YBbewuMuqMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNZ+T1+X; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNZ+T1+X"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84232e83ca9so601892b3a.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615354; x=1781220154; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZeBj54ggXsLdjqCMa1yT5KFc7o1ExZa5IiPgFr9KRUc=;
        b=sNZ+T1+XAfeTyo/8oPQ5ryCSLhR82nTHPZaG0A5CzWy5PThDWB02JU3JrKlyi4j+oD
         6/VjInUXfaiwSJnX+2QuFgefgM+RRSalWzTP8FCCA7Yn0wGfeA/7Sfe+v1ksGF2r3ReP
         4dAyXyz2HPq+qwCXjibZuZbU6cH6mGt7DZmb1+a6jdy1Ebxp7KJMLfjvBt5X4Hfh1uEi
         s/8bwroTkvDEz3cvcH3Uy16SsMPWcD6d9I5Q/gwFuZtzj5L762IPVJVHavOVvL9KgX+y
         6KdjDEoqAmtRQ1qVNjf+omAY+R4C3EJSkjxn3s3C3KOpyxr9ykvZzK7x52g6ENbCRtIG
         +tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615354; x=1781220154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeBj54ggXsLdjqCMa1yT5KFc7o1ExZa5IiPgFr9KRUc=;
        b=ovKo03sDqtOhS9ZzPrwNyROKJ4AtGp+wjsMJgMpfiwGJFgewTKhi29IhIp5BuhBmhO
         ftny875sfGngwZPRUZ2O86kN4cHuHv2D8n3Ru67U2XLFqobiSd9bt2X8rgh9yt6CRluP
         ESBH4ckElJbl3pVuBPxvCn5hQNL8/E5VKqONK0DEnYtz9wTCOPOzmWt62yM9PtstfBuk
         eU9hd2AI4Jd+3XBEzECIBzsduerM75hQLZsTN9vpFTFvQh/hLFQeRO6QTdZ/uDHlIb3Y
         v2iXYsyIk/WGVaYIi0zQZYX6kzuWhzbFsVXBwlTZxGVuN6MsHP9u8BA2f/NIDze+A5ip
         di5A==
X-Gm-Message-State: AOJu0YxHflqXzV1XvO71L1SDgqYfhTXGCFIDYxOY9maFhOkonydXjUhh
	e4M8oYzAtMSm6kW8kCwxKd0dORbyBMxWGIvwT2KyTW9khH1sYbuPE7rh
X-Gm-Gg: Acq92OEViccLKrWHx/FPg/jKP+tbjDIdmeHrmInqB5nhOqes+jg1o+gb6M6pAKaVkV+
	Hv0aU7hD8fPrz8662s37ymboUNfrbgkmRkwhryFpMMa2yoxBMjhYaAmdYiORLJ+ARS4T92rLe1F
	1Q/yA8XK1mxzjgUAgSkg5xVZAgO+f+w/8ezUbkoeBDQNvwFYbwE1DUYyhOqX/Y1ya8MSbVU8khP
	P3aQbAYKz1nBSER1op6nGxk1FHpx0czKGS0TKj265sgJ+XCIbf8lq+EYgB6M2cNKdYePI2NIVLu
	fdfSgMK1jbal16Yvbbi5PVk95/434VBFupPod60AqktU39AFji4P90/HOk+b83jhGiTMWvlQz7/
	2H/R20S0t+3PdQQIU02IHnvgbsu4mlraYN8i0GNferR3OkTUx1/ss1aTJS3GoweVATcmh6qN/jE
	LC99ZfkNkgRKw8seUSzosweFsEsXGEI2UZXwFMGSflEVTW4bt6WoaP+a67H2yT/Q==
X-Received: by 2002:a05:6a00:9088:b0:835:7c0e:b529 with SMTP id d2e1a72fcca58-842b0f6f467mr667964b3a.12.1780615353973;
        Thu, 04 Jun 2026 16:22:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm8693864b3a.44.2026.06.04.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:22:33 -0700 (PDT)
Message-ID: <782e8b4738a5d8cf0d636149eb2bd87d9f21c425.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Use bpf_dynptr_slice()
 to read file dynptr in leak test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Thu, 04 Jun 2026 16:22:30 -0700
In-Reply-To: <20260604220904.1032145-4-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
	 <20260604220904.1032145-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 15:09 -0700, Amery Hung wrote:
> use_file_dynptr_slice_after_put_file() reads the dynptr via
> bpf_dynptr_data(), which always returns NULL for a read-only file
> dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
> correct read API for file dynptrs, and read (rather than write) the slice
> since it is read-only. The test still fails as expected.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
