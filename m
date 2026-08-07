Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFD37AA94
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097506; cv=pass; b=SR10PerkIBEhqer/LYaePnLVWe5vkKIXqX0xlAshFYMjHx8aUQ62RC+XlV/V7FB04o0AIWJsknpXs4uhAU3zEry4VHqgrucvaROoGN3GarfwjyIZfglKvUE6QTJUozRmEganDXXHu9+QRjN6GaG3SLGf7NMin8nEiv6QpuukfLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097506; c=relaxed/simple;
	bh=zdxgfaDL7vWIO0bJwbL8U29BOQdGbtp0IGf3LADiyZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sot/O6Tqlp+o/MNK9qBvbQ5yXhjb7qs8220KRK+uhRE5NC+zXkByHN+30KXzexZKInuMm0oinArxMZ1EbvZ2IfD4XqorCfJ180E5BEeAXC4rf1NeS3g7F/kQAIEB+kJJZ1YgzlxRxAgDpafnS4bD3315uHmVwiu3G8XnPruqdQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1xH8h3P; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1xH8h3P"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b01146b205so2207066e87.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 03:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786097502; cv=none;
        d=google.com; s=arc-20260327;
        b=kyV+EfgcmYD9xKSNfVZEtZTNDbwtpe8+nuvnw4vG0RHtRrCfZnOczT5BDpgXx6vD+k
         MjUJaSKiO2zA17tem9Tq1ZQdB5HZNqd7o9DSFfeQ4O38OV2WeDUhq3kfORHqd349/tOv
         oOd5MkBZ5lbAGa7s/YWGaRapXGJI3iKK3lU/EGwHQzY4fj/E8ikaubNguVGHFhsNiO7l
         LxgcYi10ZGkdU5YrJED4j78oFMtW3q0ZPP+8x5Y59ysreTk+cVi4Kfg3yIgZoCp2wcTk
         CsKcDE6LuwAMstMJY576agkX6Dg3LRxDkSysPcsFGd0M9Fzy80OXCb8bRN1Qm4TS586S
         KJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zdxgfaDL7vWIO0bJwbL8U29BOQdGbtp0IGf3LADiyZE=;
        fh=dZlPtKxKeotgjqbClC3114vsg/djByv9m/CF7Sn/zVI=;
        b=bcuJjfkKBA8Q5wRGduc0DGW7uKvwHfg8RqmiVxhrVHhD01tANe25Zl8IYmQ5Eq0vCA
         xpesHx5saqHbVm4HGG6H8vDjFwicbWlMQU1+v4/BJyng/p/pqu+qgBwlt+0mdZrPtfFB
         SI1tcPriqsrYOzNKhBHa3rIQOZp0sI7l70x+TkN4QDUVU0+l+aSmqc8P9G9LC2C7UjkQ
         is9FI9kc5gbFgJtEmuD9ttdUcSwdg5C4MyqNSMM2ArDGD8KtqEh+lXWa0AHYkSEmWcXs
         1wg5tWq0UWByVKGYoevmlreu/76Y6HIPmerzrTXt+sC0qS21cxtADkpamF1cgg4TEN2o
         JBrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097502; x=1786702302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdxgfaDL7vWIO0bJwbL8U29BOQdGbtp0IGf3LADiyZE=;
        b=o1xH8h3PoPK7IypM0GqH70jZ3+OosLSF+7OFQOvZ1Mg+n4OZ1lnxIwoJSR87ElfQng
         cBUDEz9NxoKshr5bb4aPpVWH4cJbrNT8IspV5Km+jAaQ4wRkkh4neqmSkSf6t1rFfcpy
         QC2aCvcQpJ8IGwKGyU7lCCD2x+GfWZ++hIs254CnhNwTx6M3sAwxzAqMd6GlImNuGcOT
         6ozznhNzcgblueqFH4q5vdIzdTfxos9xu7zeRmXcHyuTyfk6SVfzy5xKeMtz9PMYZELI
         0rIJJZObFs3hJLhqI1v8hb9ipB0sf1YlW/w6BQ5ESOKYQiWRFXnNlz9mRn8uMrsNB7rd
         pNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097502; x=1786702302;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zdxgfaDL7vWIO0bJwbL8U29BOQdGbtp0IGf3LADiyZE=;
        b=hwq9T4/l1Cp8Lh5jpf/ivdLDt198x+DFDZiqx3CWDHcnCZ5NupGCR/E2AkFyb1y24r
         Ym8V9rAC35UZRDhYvvbKsEonn8SulgSyGN/kBBVN5FQbY00MQqbivNxTgSPLYog6gfwZ
         u3SyphzZU9BFRhUVsLkS0GGyKTWgujjQS8XccUJGHEsoaN8ZztxLaWEIz4MXQazjFRPP
         k4mcE5v6pZkOGn0oASCPq9qq321fUoZLmuQmsIBZcxtatb7bDzAjWWJ3PJRh2/0ROdKi
         /AUaZCB1/ym+h+7u5kboXLSWrH9AXPt+CGvIsp9ow0KIGnEcgvtzvfQSr7cN1U0WuzgA
         Mv8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq99zsBh5gZGDKD6QNzW14/qTmLgbUKmjZRA6ElTE4+wxx0VMh3MQmXxyikWVGJuFe0jrYBCGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD78LDlnBYp99HRdnr7TPdHiwE6JwubDQQSanTdnhawE9qTzJx
	M9FtovM9F/1MIDxX6VesBK9nV20HUBf82giN30TeeTP6NLLZmQYM6j7X94pwIhwFf+qBY5EoyDL
	iSnc9HF6ynUkYuRvP4bZAFEvKcyt/apE=
X-Gm-Gg: AR+sD13+B7vteQqUrazMPBSRGxb1yIq2uJpdkXZMxfNG4MVSPqg0cttu0PhzE7/DPY+
	P6Re/swMi8h26v4OIminyZzV/Z3RUBi9ghRRBV9xaoUdCQ6dzu8kTPiPAUj5/y33xoWATqUyiOr
	E8JK/oL6KYeHazEDaN4EhzdvjA6GeZw7ENIqAmvwrKoizazRfX6xh5mN1dfATViefv46588hcQw
	toFtgQAIEIMO563mgNOPaor5RV0LZGk1iyy0gA0a6uqBW6rGPWQSuBOyj2aze5nSgBMiCXvO4IS
	C893orZ8Aeerc7YLrYFNAJJPl6gvJuuHYhjFVyp5SZIhUyYlkZWcLu9goSNNu15rNcyJK5Fym/9
	3RFZsQmsnAPrbFLanx76+QYnHnTOajkYkg8mcH4Yg7QiKgA==
X-Received: by 2002:a05:6512:304d:b0:5b2:c5d5:6151 with SMTP id
 2adb3069b0e04-5b2f4cdc528mr3181669e87.48.1786097502040; Fri, 07 Aug 2026
 03:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804014714.4362-1-sigefriedhyy@gmail.com> <CA+7S2vKRASitG1pK_RPG1L-hDsJyev1q-+ViRhCppBg9aFuZvQ@mail.gmail.com>
In-Reply-To: <CA+7S2vKRASitG1pK_RPG1L-hDsJyev1q-+ViRhCppBg9aFuZvQ@mail.gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 7 Aug 2026 19:11:29 +0900
X-Gm-Features: AUfX_mz5tZNDcI8fdqNR9f_r1Yx0gpuNJ8HlfuHmCbVxvf05NeUXUhbQZ5sIHZE
Message-ID: <CA+7S2v+upifiRtBmGjHqBbOLFWn_m1dj+mezi7rFZGYLb-DChQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] ipv6: report why a route was deleted in RTM_DELROUTE
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Chris J Arges <carges@cloudflare.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Nimrod Oren <noren@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reply to comment in the other sashiko run:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804014714.4362-1-sigefriedhyy%40gmail.com

> Should the netlink socket returned here be closed by the callers?
> [...] Would a defer(rtnl.close) [...] make teardown explicit?

> Same question for this raw ICMPv6 socket [...] Would a
> defer(sock.close) here be preferable?

> is the stated reason for the retry loop accurate? [...]
> addrconf_dad_begin() takes the early branch and never sends a DAD
> probe at all [...] Could the docstring describe that tentative
> window instead?

The comments above look valid, but I do not think they affect the
correctness of the test code, so it does not seem worth sending a v6
just to fix them. If a v6 is needed for other reasons, I will fix
them there.

> Should the #else branch also get a stub for ip6_del_rt_reason()?

The ip6_del_rt() stub exists only because __remove_nexthop_fib() in
net/ipv4/nexthop.c is obj-y and calls it with CONFIG_IPV6=n. The new
helper has no caller outside net/ipv6/, so a stub for it would be
dead code. I would rather add one when a caller needs it.

Thanks,

Yuyang
