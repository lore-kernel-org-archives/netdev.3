Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3B4E3ECF
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166920; cv=none; b=e5r+oiipC+7Cg3N85S2qKcJlIHj0OYB68aOTs1WO9Y7z5iovdaEOJmcgjV1Utcq3HIPbLq5rsY/tgxrYl7AO0iyB8EAbliHEq7WPgsXhbGhq7YXyvMNPOL272KH3LyvMtaBLVrV31pu7bOYm2tHG79r0xeAvT+bRPhTzObdunfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166920; c=relaxed/simple;
	bh=kXhP1OwYjv8R26m2rEknmw6BEFPz4ktTEFaQcRoV4Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdcpG3U/dfyMP40/jzTH9j+QC1vliYuz0CtaLEOr5+TaX+cY4BkfRy9yjvj4LorHB7c4Mzm2cIbOYZQDv1O5hIm/p9eGup1wSLlBDAa/6GgJnmjROAZHXJta/fqnd+pYcfmMnzhXhgntfh+ub/0YZwnoeaFJ0YrYxWeWopLvUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN6plTRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN6plTRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A081F000C9
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166919;
	bh=kXhP1OwYjv8R26m2rEknmw6BEFPz4ktTEFaQcRoV4Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VN6plTRxybrjuXOoHCsNU7srtGyxVg8ixtdDuuN4WvVGL8J9U1QycdaFncVJD74AC
	 2tiQIhJ0S1jm3dcYvDRbW3b5zX7UQze5gQsmkmSswRzfYs95c+wAnsl/rLN6C9YhM6
	 cnjj9ZK0AVzWbfmJwXwT2+LUq9RAt25wyGs+EWLPgI2ZaYSUQ++1OEp5x/bOAWMCE7
	 QW+9xMHMjnjl7oDfqwCjbkaVIUGTx5RWHh5eoBsE7+XNE/OJGQyU8YJRucjhKXFdx8
	 NwRgqpOcmIzVg6hAJj5O54uDSDATYAiACeC57/LJuGFkOCxlvkAe0NluQuu94KrQt0
	 ZiSUxoYqdxEMg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6df7f544919so70358eaf.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:08:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzV8PJU2pG1KOanrNjBPwXdmBrvttFY8pdgpGTgB6xGQykACY9pa7Z/Hu0M0ehQMyrKYxtp83U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLM85VRjdnPidwb5SBWFVTmWME76oOWM1wNkP0sMzMzeaCY1Syn
	Q6OIjsNfCZEIBFCCrwVpO5fKhfx8Rz1vWDq/dHo/E318gcjBgDF3LvpRtMWpQ4YS+CMxYbFrVNV
	TOHISZucSMDcYMuf8XFOwT6Wu1a6wskY=
X-Received: by 2002:a05:6820:150b:b0:6e0:fd89:f011 with SMTP id
 006d021491bc7-6ef0fda9de3mr17758771eaf.65.1792166918426; Fri, 16 Oct 2026
 09:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016084802.2725187-1-edumazet@kernel.org> <CADVnQynq30ROV3jndQevAWWpk-1iWn+dizW6zwTaO1gdpOZMyw@mail.gmail.com>
In-Reply-To: <CADVnQynq30ROV3jndQevAWWpk-1iWn+dizW6zwTaO1gdpOZMyw@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 18:08:27 +0200
X-Gmail-Original-Message-ID: <CAL4WiiprJUw5AW-bMMz96=SMrAz1h+rGJjw5aG=2KFQhx3RT_g@mail.gmail.com>
X-Gm-Features: AclHuK_az6SKAb1DEXpGoQsgRsuEFeCYJ2qT5Qli9D_xYl-NBAC2aDQW2KxZysk
Message-ID: <CAL4WiiprJUw5AW-bMMz96=SMrAz1h+rGJjw5aG=2KFQhx3RT_g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_metrics: use the socket netns, not the dst
 device netns
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 17:56, Neal Cardwell <ncardwell@google.com> a =
=C3=A9crit :

> Reviewed-by: Neal Cardwell <ncardwell@google.com>
> Tested-by: Neal Cardwell <ncardwell@google.com>
>
> Thanks, Eric!
>
> I got an LLM to write and run a repro that verifies the bug and
> validates the fix. The script and its outputs are attached. In the
> control case, both kernels put the entry in netns A. In the three
> trigger cases, the base kernel puts the entry in init_net and the
> patched kernel puts it in netns A.

Nice, thanks a lot Neal.

>
>
> neal
