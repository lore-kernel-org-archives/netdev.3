Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C43C062A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440815; cv=pass; b=BhdY28ALaaz61jmSJ5EBH+JlaerndCris6dTB8SIT6t7zipTC2WAW9mntVs9sdoWnHpAHttYft4EyqcTb6KOGYrgdw6vtuN5B6x9Tq5QbbWviqJ53mT1Ij9gQ2gAPGKx6+ZmG8DBeff5eXmwJk0rjePGzKJs44njuj2TWtzJNTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440815; c=relaxed/simple;
	bh=8vVAdJqYOL+ADapkFtSl2CCafn56786jZvzqU7pet3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3Whl79MniU0iAp6Uil176uiwuW2FGjbVqZrUvJlekuY+r9v5iWENHWiKzsB6V/H5cunVJLdvAipRQ2I2YCmeKTYgp/Dw4MEtUuZOG6DQoRcNo6yxb3l1wzN1W4v7QgtYb3hhuLMDeCDOE1kw5WtGNMr49gkTK8IEijtTFq0gpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCsH55qG; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCsH55qG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so5993711eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 23:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791440813; cv=none;
        d=google.com; s=arc-20260327;
        b=mtV0avJDERPeg3QYbz2+eBpsLgMvZHFNVGuWnj+8tC8Rm/iRzt07khWlHxgpoMTXxZ
         gBNqJ6yF9DSHQ1A/FttMg3mJ8f0ppO4Q0jZbJYwInOce3e028IhlRXvqDTbWEyrIvesg
         0Ibwbjt8L/Zfk8cUkX2toYo7RAd1K8Jz53YWhMOe4i52DMeJi1r6FlOW2MlUZzRXMbdQ
         6sVtOKOnXs/7xrwsOBebz0IqBsjpsogTyZfw/dGHWB/grXufucpXzZ98czv90pwVPc0s
         guXcg50DXXVZ60T4HF07CVCiEb/HU8IcEv7+kaHeVAN+3T9eXq2yU2Wiz07S07FT9QsW
         YUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vVAdJqYOL+ADapkFtSl2CCafn56786jZvzqU7pet3w=;
        fh=J8LDRph6KCLQO9zEEJuxHlX68aO+TjBjV13bHkEjZcU=;
        b=e8PnNLUUqq5H11OHHKuXz2uk/vo+bZ/cyhMcnCTnXx4hMxRm6bsPSRDWfKEtAIY/oZ
         uLLiR5ASve8PJyn0ZVpJIgf5LxsuBvbz1F8+95QzoUZr86sgSmnYNNjl1fNeUUiEK96q
         U4z+39L1nntCneVQn0YA/cvw/Sc8NlskAzHj6k/7BlPquN7V6WxCa73XhzuwuEQQlwkw
         8hdww2DXEIcupyZQpgg4Ba5cF5je6VaJvg1fkddTqOex8huSm4gF7CDQcCRgQ1jnL4Bw
         68DlJLa80VJ43O+651c3Wa6OKvbi8mnocRO7pJq33OwxHekWsiIrRZjUAU1HPLduiIRT
         Wx6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791440813; x=1792045613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8vVAdJqYOL+ADapkFtSl2CCafn56786jZvzqU7pet3w=;
        b=YCsH55qG+7e6u3aqcScSLsz6pbqmJnUckEVNfedK6TgfU8Z9f7KUJ0NIQTa8Kpztzb
         nDedMeOSpp6HTXQLIsa/l+IgllCY4xIYv8La1s+bS1tbBnJ3F6NsiWE7DCACX6pnL0jA
         4fu1e/+9gsLRlmK3k+f+KjxvsHgtU37M5o/Yw1XlNoLfaUXMMhGEogOb8Ee2l3rpSIAg
         avzXKSnXLd7yLnKfXFmVLQDX1c7SCBdb246RkqgCZ013IMUtMLkBbRNvUTTCE673nn/8
         c3UIgeAA7qbmgybdsH267DETJ6vT05H1CFODipWU62BdJHwEbMI9DsVZfuhe4ysHXfsF
         +0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791440813; x=1792045613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vVAdJqYOL+ADapkFtSl2CCafn56786jZvzqU7pet3w=;
        b=SGCMQ9crALlsfaCfX2jm/KtDq1UgqI8d08WXfwjnId34c8teF6rNom81aqlxdtxW38
         FvmpsmdxrpX/wlXgbbJjedZXNM7FVoo0lUZw8ge8HkMjwBZW2MLllIIUCkGFm/mGrvbl
         fkCYXuWPo8xuc9CQ/9t8Fs3UuasCd8U1MYgLcKYaIZu0t4WV23WuxjZ7UnYAradjIIOP
         WKM+6yW1XworI/LpihGGRFtwEvCeW4ubcDAMmcg1yFf89x1FQf6pZxLsRxen5brOkUCk
         /1O393HVp9qU4XyKLr4VYS+BN5cP55yO+aIQ6Rwce1toMAPPSiNcm214Haz8n6wDBTRp
         ktvA==
X-Gm-Message-State: AFuF++npxvXBjSB8aCaus72d8VXqykE49HjgpnSxQufOoboIFgqMjhiV
	v7FU7ktj6/gEmU3t8roxwAIeEcr8Nmkeyua5m/nYSV9fhK/rKxcgavkU6c2eSK1nYpi6wlHKKat
	qG9AP+dKPrtRxavcMvnQfAEPUaJg6Z8K5KUihZHIt
X-Gm-Gg: AYBFou16ABNvymGqIfbey4uIeoN2C4xufFRh4HZFwIaAOOpp09r3gT3qiVqP5Zza78d
	gg+DwJp5lbLhDYYbTuHv2+MhL5rjaNcYm5/cQqUt0kwSqSvaqh3uUPsfHrzgPNTCQohzogGmygF
	keHve1Z2W8FwJREcstAvI2f7FYX9BuYthlKtgiJETbwVO6RUTU6mBLGeM6VD31FCuwqXza//PEx
	9qRkhTvC86T6cWuOXnNhCpemYVFIy3gFDp068jpCzWiMsQ/YwtTAaMoiyvPwLULj2xkwQugOYPs
	+fN1J+vtdf8PCmbiN7SepAjxd3mFf3qDTWVhzcixksGSwp1aVOaqX9+aZ6+2sPUyGudriC22Mjo
	fOTqxWR6Zk1w9Thpuy5gvjNW5Eoima52UISJFKRak9ZdQrRtnyDePBP/048lg45c7jUQSDgAB9s
	YNAIC9A6WpISC5FPgGGrCp19+O
X-Received: by 2002:a05:701b:241a:b0:14b:2ef:9821 with SMTP id
 a92af1059eb24-161fdbee28amr5081076c88.3.1791440812346; Wed, 07 Oct 2026
 23:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008055233.3413445-1-sahaj123.sc@gmail.com>
In-Reply-To: <20261008055233.3413445-1-sahaj123.sc@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 23:26:39 -0700
X-Gm-Features: AclHuK_6KN2ZkAkZI5-CoJRDyPSkt1Y9b6vXV5rGVVGfwb6qixN0dbXfsSvTFvw
Message-ID: <CAAVpQUAFcwCefyELhccLvKutz3ZhNYv8fyh7ezyQRoVDZzWTRA@mail.gmail.com>
Subject: Re: [RFC net-next] selftests: af_unix: test zero-length MSG_PEEK with
 OOB data
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:51=E2=80=AFPM Sahaj Chaudhari <sahaj123.sc@gmail.=
com> wrote:
>
> A zero-length MSG_PEEK on an AF_UNIX stream socket can busy-loop when
> an OOB skb is queued. Add a regression test that sends MSG_OOB and
> checks that recv(..., 0, MSG_PEEK) returns promptly in a child process.

This is covered in msg_oob.c.

---
pw-bot: rejected
