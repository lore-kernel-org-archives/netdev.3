Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608504A3870
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892013; cv=none; b=i8ZkC+kq32hhxTPMHZEcqlNbCL+hssnktqDu3wR5QKOmokoqxspJD8EAsAnI8Lvwew5UIRXjWS+OY1j82zMMnj5Kuc9A509x94HtdyHW1xHjuYztBniakGaWnQZuUUZhmf5yz2829OZm8RsIIx9JVKJk9NMFK3jeRyyP3eBA94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892013; c=relaxed/simple;
	bh=WE4QCOY2RtZDi0t5qSgWBVj/If1SKxFJgodnV5cgkqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUw2ImFqS9dkXY6KO5ESChaVkO8k2agl6y2EZK/TIrhACenULGV6U3TK5yuR3jN7Fzuqfog4UAksGSCnOL86n6dM8P13IHEh73G221jctC56fHnTMSw6znTgmP+s9K+SnI/PUnt2CrEkRs2pvhHT51r3/Tw1WVjmR0etH9tr8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCIKCs9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCIKCs9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9856C1F00898
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790892007;
	bh=WE4QCOY2RtZDi0t5qSgWBVj/If1SKxFJgodnV5cgkqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cCIKCs9+lzejlsicwPXalm0TPoeGRXc2UPdgSOUFKMW9F6v40AQWMYtLAsaS3nJTm
	 r70zwKixZu5gkyun3GJ7NhbPOSfSJa0NJgizFPhNKgPWWikcUmCaVLn9xyiF+8OoTt
	 4MqHg92NFspKy+HwEzXFOAZoEf7HC5gkTZJluvYKBa5WeUDmnX0ke4A9/47gtvJUTw
	 F62iRHkvClHoKCPztCfJKwOJQwJxs+mcEwt6bCSBIIcNIP2Kjpd25f7PJKgqUWDnul
	 OuGyFreOAEBVR9bXCkaixZ64NaxxppvFxnwKkHhGR9ybhY/iRzw5Ds4mZqhP/OsNNn
	 NyXqZWZn4fwmg==
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so4784999a34.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 15:00:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByc0iaPFcp6QgDxoLflyE5Nsx6BcmPmQpwdFN7UpG8KLRke+vNmF7XIn85BKKgc0UEjRGpIb7s=@vger.kernel.org
X-Gm-Message-State: AFuF++kszIQEvV/Ol+I45I5RaVszU71FmULZnKPPZI409w9dBOjh3ihP
	jh37NwOyF6wm7h71dRAC3TFdeCdXXsoJLeRYIvDouM4oXqOXCPNyQnsVwFVmgoKNFopNvd/izZM
	Zaj5r0cWpn7fPpuIojvt+9CSCN/yLiDQ=
X-Received: by 2002:a05:6820:1693:b0:6d9:d42b:d71c with SMTP id
 006d021491bc7-6df35355ac4mr682133eaf.69.1790892006822; Thu, 01 Oct 2026
 15:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929214351.856940-1-edumazet@kernel.org> <179089115410.434549.2945064150397901501@kernel.org>
In-Reply-To: <179089115410.434549.2945064150397901501@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 23:59:55 +0200
X-Gmail-Original-Message-ID: <CAL4WiiroQ8XyDzUnmuy5FmJ4SWfZ5SCct04=C_uFggC925xgeA@mail.gmail.com>
X-Gm-Features: AclHuK8-GCN3sMHVLUGMP5mRi1WX5O0Y2ip9qzX9NdSu2incJNYyqOWvrM5sQLs
Message-ID: <CAL4WiiroQ8XyDzUnmuy5FmJ4SWfZ5SCct04=C_uFggC925xgeA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: free inet_opt after an RCU grace period
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org, 
	idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org, 
	xinyang@anthropic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:45=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is incomplete.

Good catch, tcp_v4_reqsk_destructor() needs the same treatment
after a request migration. I will send a v2.

Not sure about the 'High' classification, as the race would involve 3 cpus.

pw-bot: cr
