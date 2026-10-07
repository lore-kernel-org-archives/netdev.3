Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28FD3B38A1
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384534; cv=none; b=B5L9H7n3KnJ4o8JOi79TDRUP2vZRkuD6KpW6xfAbLlrmFp+dPBKTKiF8jJgs55DgZlyFVChbMwMrsKfBw6ztZ0XHDjVyokgn1iOFOHMpePDS/s9BC4Rt0TYpqOleGlCzz6thkL9touqtQ07wVfcNkOGTWnpovLOfaLSXdY7qtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384534; c=relaxed/simple;
	bh=7Y2j2y6ajaG/zDk1wERigWBnYImYN4e7RWhBT0nBLk0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JmMbz80nAGwW9/3fvK6JkhsLgBkN0qJp21XY7DmnHPlOlfPjujoeB+VeUnowMbirNZWD3uxXvprGDYAfXOySs/4qUDTP6xGvD3MrBoIi05XcFsKO/Dz+JQnXckGGRNF7+zE6wkU7pRHgdKOlV7m8K/BL5ZwTgjPrA0XhEtP6m5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBh1OzzV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBh1OzzV"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab3d3c5761so19914847b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384529; x=1791989329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dfiB9VnO/q2CSY+pSu0B7BRn9rM8krRdw97n0xu/4ys=;
        b=iBh1OzzVt5rLZycOZGB+FE/Dx7KJ94fIf5Tln25acSfTQME3YfWMkMU62E6sKlVtg2
         GFzOTKFOECNZit0yflIkuVmPXI0twmZ3QVT78uj1L1UKiZrUiAO615JR42NZOVOCtOTi
         OmUMw4ddDMT3i/yomQAGbVrn9SyIUZaTSzjtOVzbAC7hanKHhf3fS0WmivGKRK+2y7Vb
         Xz9O3G62LOmHc+XTte+l0S5FXF/PzxW2O/OvE/Cwlt8xlwEyFBzBRNbowoF6IZwS+w51
         4U94T3pFA1sDXagXwi8coKdE2omF3Oyl4ak8VmA0G7pe65K98ARH/VCUv0TW7i8GCRLx
         plDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384529; x=1791989329;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfiB9VnO/q2CSY+pSu0B7BRn9rM8krRdw97n0xu/4ys=;
        b=HimoQmsRDD7fwu+zDkukFd9T1XGgWtMzRN4Tp5przw8H59VjH3jNmQHGvBzazbXyp0
         xvV7HuMCavSYZ2MrsTSi/PLFZDK/U52q6flX4elDLkDiSDgPc6UaGctsTdvB1Vzm+IVc
         guMOw/1gVnNmOGvuXDfhbOs48JUb39ybD7GcyrjMFkyXyip0cWrXqnZp2cooB4xRKcxV
         HDPy6WbSWkFu/i8J4YR03rmnYmK2OPn1iGK8wQneTw/SjaV5MfNx0FRKjwAta55MBkHd
         ysbeAK6qX2uByp/kX6y/pCmscyI1MQH/vDrTAebe73Yu+WsvF9LUWVRW573IAxX1MeUe
         1kXQ==
X-Gm-Message-State: AFq9FYJ+ZoDiIT7ZZWZya9xccCUal01M+Qgprl2O0vAUnE9jh+eQhOTc
	8rRcAH31cdjJS2+s/oyiTe7q4IaL/6E7bYKUqWzbD7kkiAh82KUzOb7o
X-Gm-Gg: AYBFou1tw1Gz4VsMf+1h9v8ZBjz0U/azEoTlQekg0y9KOYhFztjwdBjdu4jj641UtYY
	JCsGXdAVvKOXqyJg/o/ksnGHqO7khvtp4Z8Ji3QlcS8St4s2ohCS97SSrInMLxk5/K6P/Y4mBn6
	KbfGHnyz6bfp1NlVBerWKuGmXUsFFOYKProrASocjzE0VGsi1bgx3Baj6aNRbfcoi8vMXik0w89
	aDZID85PM5twfjny6evm5is8cspMiRLE/8eE3YFSuBRFIZVPusf7FNlWCuxRL1F1xgLWY8ccoL5
	+3Fmo4QGQ0Ccijt3WIN2pjVCO4iW7Htnxe5E8E3YDW5mHoYxKantm2UDP1zwmC9wN3rLfPTiRNi
	wFXh0NO3U1o8YRiHI3C0ELBnMo5UfFEs5JDKTqpR6nraOiAlnhFqbU3Fd4OsJmmpbfxuyaKLunG
	iqcrM5kIPtPW/T8y6O3NdaLEHcGIrSXSlTB1eCh40Hqe+hSxIwSN+buPjmN8W2yEC74rjtNghAs
	9DDaZZzOLEdh9EPgYQgUZXF3lDBpCuFrwmKgVC9lcdOoYn+4PTc2sssXlikxIblheuoCblvUzAz
	Th7fGuGNudyJy12bBQT5sjNAEdrxJjg6e5oRKQ==
X-Received: by 2002:a05:690c:ec6:b0:861:a2ae:8c6b with SMTP id 00721157ae682-8b05ac458e3mr23348817b3.2.1791384528499;
        Wed, 07 Oct 2026 07:48:48 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05abda9ffsm9529857b3.39.2026.10.07.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:48:47 -0700 (PDT)
Date: Wed, 07 Oct 2026 10:48:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
Subject: Re: [PATCH net-next 0/9] net: skbuff: convert most BUG_ON()s to
 WARN_ON_ONCE() and an error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> I'm going through and reducing BUG_ON() usage in areas that have created
> the most problems for us.  89 commits in the tree quote "kernel BUG at
> net/core/skbuff.c", 31 of them since 2024, and some of those could be
> triggered from inside a user namespace.
> 
> The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
> in a buffer headed for the wire when it hits unreadable frags.  The
> BUG_ON() conversion of the same function needs the same handling, so
> it's here rather than sent separately.
> 
> The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
> Each one becomes
> 
> 	if (WARN_ON_ONCE(cond))
> 		<error path>;

Good idea. I was thinking of doing exactly this sweep after addressing
one case recently in commit ee1972def665 ("net: downgrade BUG_ON
EIOCBQUEUED in sock_sendmsg_nosec")

Instead of WARN_ON_ONCE, which still triggers a panic on systems with
panic_on_warn, DEBUG_NET_WARN_ON_ONCE?
