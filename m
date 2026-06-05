Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866052F39AB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678685; cv=none; b=XLDJR5RAsCBJbCpeEF9kockRicZcAwz11YpzyzfWjo06nctlMWmgdHAMr2TbWhchKYBGQMJ0+dK+C/+2HqiFnMN6DWAOVxxLz5KNL35XwkUneWnNULdauxUlzZkPa4i4D0TSZxYMH2ZgfrIF86UefwTNugzUtayOmkxqsvVMjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678685; c=relaxed/simple;
	bh=nYixU2Eu8BJG/PIvFtgvpYlk8GieudmkEaQ438f3xmQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZZc70jB85BokIaCYujOcG+eAk/nfxF1M9PicpvWNtB1IT+0DWI9JmWsFMiy9VLxRPvWh8rXDPAI+/HbI8kuSdHIjc7T5zon0sRwwDZwyWdTFnzkno/D4W+h8Zovn1RxVSRpmzpZS1o6CwhGBDucid1bYhglmFY73YUM/0G4TezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbxBuI88; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbxBuI88"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dee6b76a73so20610187b3.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780678683; x=1781283483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bObuOwAPWS8ZZLQEFU6Zc0AzhgVkiWJAcqS4XwRfyhI=;
        b=cbxBuI88Mj1d9I6lyBWwWb5GURMwdY5S6a3OJpVXGzkRYaiKJ9bHhoj6MSYvU6kfS3
         HX+a4rXjWGBQRv9eRNhYEWVCMCFyXkOEA3CVtU6V7PnchpeAV+smCk/DOe815As6+xGo
         eaXmhGyjTErVFSMV6j0ltxEgcomz+Oczc0bWhLIztUabr339L0Lp0yUt/0BIiFRsizKg
         Fbm3N2E5vZyypJIKLNtNpmkAbORbaERlxV1Bm6OafISUFb+pQOq26Rr/1a8ZAVpXEbyn
         6mritCeijlsNf8UjQ0+GHY6962iTPNdE4RrET1fGR83XtK1y+zJ3KzJiM3m57yEaF3u2
         grEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678683; x=1781283483;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bObuOwAPWS8ZZLQEFU6Zc0AzhgVkiWJAcqS4XwRfyhI=;
        b=p9oQfbJO1kuSJp4JOQ9n2SIv7DrYp5CCJ/q2LLtRwfDJsjgSml3IKoaT1PcYrgnG6m
         d6tvBPZWS3zHSgbUgUWsWsvyRlM6n9K2vQ+98/e+Hu2XhaBg3XRKCX9EjcjGf8Y5fqJ7
         WNHeAlcQENSKDXS+894NxWKVY+hUiQ33OaLGDtjw0X6SE5ZtughWdkZn4cccYHW7nU0E
         Wbc8zDLZimU7q0HDYL8cUjyFoF2ycfks7ZB8/VlPfjAwWXeqHwPPOseGnykCbukvi1Ya
         FXPHnq3q3abvukWUxrsdUL4SLZVKZoa1rlOpfn8U8h7C+jaW9VEMy3qO+5abxT77/+Qx
         N4Yg==
X-Forwarded-Encrypted: i=1; AFNElJ/8NS4XzNomyChQVFSIBW+70LSd0zuKUwQ7pVo1nCRfolvX5kqpYgTwaKNh0dEaWUOY275m+x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVS16W9kjF1l4CRO+EBCz7kbIQeI3DxS1wyujvkmTAf07WtoCb
	Y8vsSw4Uv6uTS1zAtxcPpU0bzCRv0unFTS93TgAZsTF6XU7bHVWye/9F
X-Gm-Gg: Acq92OFtxjyF06oZLr3shn+XJZ4FWxQWa6DSkuQHumBL8sFwWMhxfdlSv6YPqcYxQcg
	vpC2TAaQslWajRV8yHt2x1c20c5Cz1vl5oTqpEa4JomX7GiOhH4jTGHJKAk0oF9rQuL2/R9Xz/Y
	lIg63RWnE492X2qCXEO5KQ7Q7t/LiWw9QokBNr1dOc2tnfKNH09r2W2giHOSRdXwiC5tAqwB1z+
	9HCoAaFHFaxfQcymkxL4isEZqEN1HT/heQMx9ZZjIlJDDTRrIzlhcpSHvNXOmthlKrqwI3P3Ddl
	wP+lhni2vkeNcLLMRV23U+zxPuDS0VTLmhWDboZmWmLk8YiZv4F0orsQMfYsd/zqYqUXN5gUQTf
	1k9Dd7GgHSS1WImI44KEDSdEdTWec07KOpKiEH9r23gI2+I3pnBfm1Ulzo8/RyvffmN/mnYfCZk
	n4xk+BRtC9kQQRRcAockXs1fbCwTiGUKGY+BTG7vv6sur4LKGlhvJVvA9GZc4ZJRnokwBnJQbvu
	X+s5lQGKjAtgYg4rA==
X-Received: by 2002:a05:690c:3348:b0:7bd:8cd8:de2e with SMTP id 00721157ae682-7ed0db9ac68mr46404277b3.46.1780678683527;
        Fri, 05 Jun 2026 09:58:03 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23492a24sm52566627b3.27.2026.06.05.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:58:03 -0700 (PDT)
Date: Fri, 05 Jun 2026 12:58:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Tamir Shahar <tamirthesis@gmail.com>, 
 Amit Klein <aksecurity@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Message-ID: <willemdebruijn.kernel.21f5d98ff2ab3@gmail.com>
In-Reply-To: <f0c3f9e5-349c-4b1c-8a1d-9fbad7b935d1@iogearbox.net>
References: <20260605112134.3642413-1-edumazet@google.com>
 <f0c3f9e5-349c-4b1c-8a1d-9fbad7b935d1@iogearbox.net>
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_FILTER to priv users
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> On 6/5/26 1:21 PM, Eric Dumazet wrote:
> > This patch restricts the use of SO_ATTACH_FILTER (cBPF) on TCP sockets
> > to users with CAP_NET_ADMIN capability.
> > 
> > This blocks potential side-channel attack where an unprivileged application
> > attaches a filter to leak TCP sequence/acknowledgment numbers.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: Tamir Shahar <tamirthesis@gmail.com>
> > Reported-by: Amit Klein <aksecurity@gmail.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Willem de Bruijn <willemb@google.com>

