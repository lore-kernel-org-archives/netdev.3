Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA139A05A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566095; cv=pass; b=ZSCyKBzPTmO1ZMYQr0AITs2z799Ss+doXutoqg4Rlzr++weY2aliJhEMoJD+r4uRSqsx9h6QURPce23B5yY2HX1K5J9lss3Ec8ZFHoxVoRpLb6WQrlL+LzchpDsUzgGl7sFVaLRAC0BTpGYrzO0AgbRHzOHsiVaSAIgwr+WN3dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566095; c=relaxed/simple;
	bh=OJWbazha46ug8hN55IrSBbZwd/jVhUCm0IDIJgtN/m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/YUrTdnSqE1BEdR3HSkssLoCwQ2thkZ30PfYcfeCn4zQvMQEM4zeNVycXALAetC0thXyeeaskLnS/2tfFQcmwC2HCOp6LCo6DZjxmbKGXDbEJX/A9nIdNu79obl+A7Ykw9XQGbOJKYaOgHMCQN03WuLB8Pbeav15TNYLcs58As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFewOWxn; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFewOWxn"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efcef23d21so102534396d6.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784566093; cv=none;
        d=google.com; s=arc-20260327;
        b=CscXxbK3hR0ikw0iNCJIz200SlWq9lgr5CAsXCk9eL/ht/1ReJwtgsCMgH+bNsXSSe
         HNMNJ7u62nPd6n9xFeR+0JipSlpgl048SHXJ/PfW3NeLWKQiQq/jPEEr5ohSfg5eHKn8
         9rlgEanz9e1OlpFy9HtIXhbP8aBQ10FznHdGf4cK4GC+V68hCmchAn838EpiEcsHQvqF
         jYgRW8DYFEjSKSml53Y/PSwNKfOQOmhLcBXkgwYisjdfDerssUl0JWeNgXXV1B6dGEPN
         Bp/Y12wY5gJHojspO2Vhnw/Vx8Fmg0fKU9SA+i/kjGxUbGNgDCPPrNMgzLLZQ5opnxAn
         QDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E990VIapzj8tuzMD1s5tgC9LyH+wMa65Oul4PHbwGUM=;
        fh=hZ92S901x7d5Xj49T2vDGZz5rKGNfXRJc1DqSszAqTM=;
        b=WaE1dyCy9YC5/Zpa3eC3w3YyCzJUugsDcvtyuoLTsGittG6b0xQmpM+UnPgGBW+/KG
         DndzLuN9XEpR2TM/pY/P45+z5Uu/Z6rUH1/PJRNq3aKS8zDdu0g/Sn8myjkpFd4S4A1b
         vxxa7gjw6B7faoVwX9gEcnpHPs7kPbhwV3ayhxQXZ2XqDTtuYrk7zpVzbHiuFQ4XCkaN
         gMATA487iN1b1RrBVMlNuTV2xn4pZkJCdbnWO1H5FsnpQTY2ZLmZfpls6/INQS8eqZtQ
         EadUVP7+sz5p+wtyGc9nquynmPMrPRtYyT2a5N7HMF8CH1FHjxguS5W3DQxwD4+oJDdu
         GCYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784566093; x=1785170893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E990VIapzj8tuzMD1s5tgC9LyH+wMa65Oul4PHbwGUM=;
        b=LFewOWxntZVlAMSmgUrbU4ROKlDQLZqTy7QKBdrPdkKJTQSAEX/ZJU/Ad9Rfk+KQxp
         mBSmmHksjAAnKgRnONcHhma0TigfhAtICSuzDGqP1EUTKFO90LKdqyCbZk7qb7dk6OrH
         a1o1OFRDBT18mX7AvxRhQ7725kDV0f+tbYQ1j77D0rv4DkVjtlwHwdgzVovKQPMudeOQ
         IvyuyED4EZn9ejLjLKJcDXaRuOsrsC2WcMpaWazjHRA/nuYbxmocPl0aHJ2jFqTlZL4i
         jWwXd0OY9XxcgUXp/Yhd80X5yyNuTJ+gYzhqwsUyZCpvRFD6If1ri8b+O3qvKqPVgka/
         TXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566093; x=1785170893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E990VIapzj8tuzMD1s5tgC9LyH+wMa65Oul4PHbwGUM=;
        b=oyoHBWUJZnGYUAAg/h8I6SXg/qFimAFyiW/zSDtRXzN0D0YdD34/v0YIqEK0SjRw4f
         Dw3crlU+TPesK+UDGU1eoDH2wWsA40UKJx3vEw5UgahqDiFvQ5dNofdH9xz82q6mx8KZ
         D5EpPiCYj/jG7NpjYNx5hhSkV4WqAHHfMlmQVI76qh9y+XRX2MgzfWaRKUsTXCkL0Vv4
         yKPQwwKT/aQcUQRIBU6ZwRU5KW1lE4biQTlXRrUNCGYDZ4pgl56LXy7F5qxJ65Crc91A
         fKz0T43T7x2w5+TtPbJfEoGVBg6JQXaiuN+cCOBl8piuSspyGOMmTfTbyEA6x/sZXul5
         RDdw==
X-Gm-Message-State: AOJu0YxgSkLZ7NPTdoUbGCtWr09T9y1N3xUvOv9B+zt6IB8x9BPZUHVQ
	ptrqJ8xvvq2hwkZOScNNiwDa9iXUnlO6RN4ROnJzsOjQ5RRciWwEDnuXUlAl2IGLohVoBTYOGnm
	HPAflYv3fzw/jfZkKWwaM2IcN7a70ig2fGeJh2Nmc
X-Gm-Gg: AfdE7cm4cYBPOJXdeTCagaovkb7JUeV+VNw0edKnPJhCFQUy9jPzV9v1ogyZJfYY2gb
	exbmXHvc++NKpPEuZt5ypuDmbg+ol9pMtNfaXEFFxJ3gB9hs4Hf352ZXUoPHZIwR1q+ol78ZB68
	xYu5/ZDSyoP9l+aHm7lY3EICDrdr8UkGDbHPO1Jfh1A7fRZwBEOxE71H8eFKR9XEuslS9V/s6BP
	sE9oEc1679WxbxV1M4jKOgtAnz+9KIJqjyqCiRCiGzX12q1Hi4UAhHBsr31zlejVQJ9m4oIc/+g
	XZWP6BUjTsKmytARvvLhzRs47e2rF9l0aL3rhl9udheZvERPkEJHss20HMI9sGkDXDvDlHz9xQ=
	=
X-Received: by 2002:a05:620a:454d:b0:92e:f0a5:ac3e with SMTP id
 af79cd13be357-930b3eb093fmr1435090885a.28.1784566092473; Mon, 20 Jul 2026
 09:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717081443.809393-1-yangyx22@mails.tsinghua.edu.cn> <20260717081443.809393-3-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260717081443.809393-3-yangyx22@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jul 2026 18:48:01 +0200
X-Gm-Features: AUfX_mxP8PIp4yxhDb4hA3zkZgwpfcpK1so7ZTbdUqmesM2nikxx9tDMVtlcTyc
Message-ID: <CANn89iLQLQNgNRxaRn9_PLPsBb-4nguM6qw=jFv0xjU41WUUgw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: packetdrill: cover RST validation
 in SYN-RECEIVED
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:15=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> Add packetdrill coverage for the RFC 9293 reset checks on request
> sockets in SYN-RECEIVED.  Verify that an exact RST removes the request,
> a non-exact in-window RST sends a challenge ACK without removing it,
> and an out-of-window RST is silently discarded.
>
> Also cover an RST|ACK with an unacceptable ACK number to ensure RST
> sequence validation runs before ACK-field validation.
>
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
