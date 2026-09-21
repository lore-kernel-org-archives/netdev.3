Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDE4F85D2
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015016; cv=none; b=m3rpN8rxxOfKq6vkd7JITiplkmqEhElyfjOfu0gGE7p28yYRVpBwD8jDJ91UwQ2bo5CpaghX6R5Rd1kXWg3XeM1FJ8uGJ70jc8iqKxqmm+cHuxzBNXln+8rvTYbMu+az7E4WZjYwmC30l6w0/dOQUNkxcpDWnROk23KWg3ebTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015016; c=relaxed/simple;
	bh=EhGNjzinEoe0rb9XQGllpzIYz23bT+vZYztS0WlJQq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvQexVVOKmCYKzUgShEJODIunrmn071nSIaPxy7hGQz2RmA6DpXgQ6o2wXo6La9EBx4hQ7RqPIdtx5pQlQSc1ER3VgVn8KyKAiuNi5sd0q54BUOSZY7Tw1mgSs1dXNK+YJqj9kssMnO1xoy+b3ofbC5NlVwaTAcIFXtxwuel6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=YyczaQN9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="YyczaQN9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2573096a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790015014; x=1790619814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1UJU8vWnpLqo2FzVlfzcu2nhsHdLYdrBMVsYnHBFjhU=;
        b=YyczaQN9GH56lCO9mKIB0oiGbifdmZw0PMRdVA2DT0cJnIRI29R+DQXB/90VI+1IgH
         7pXmvIDaqkCeTp8a6AwvrSDXX+iGhQIGZWobOLvhYq6+mMGNE4ltMbjdAqjvsv3kxD/R
         Sw2KDdZUjMZGvFuiHsO/4uDB0vgu25tzidT8aY6KrlfOuvFDpCFXxixsQydfA4bJ8hqH
         W6Tf83YwYCQ4iynk4mOh60N+aJnACx2a2KcHP/zPHz/zzWXqRxXg9GViHPtER/Z49tgv
         K5cyN4teGQ/za7JbNmUEklAi3l3lwAd7jfEYrsE8qgddNJzJqJO8+4phcxuTm7vAb+3x
         3yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015014; x=1790619814;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UJU8vWnpLqo2FzVlfzcu2nhsHdLYdrBMVsYnHBFjhU=;
        b=LAqUtIY6Ir06PoiiDRLEZCQo1gN1HYfMR4v/cC3KvDd2H5JwJNorJDpTS+4nYBWs48
         b0ZrSFJzXK64QqWJONdXazMbqO3ARvQIM9uHIepwDwINf/Rfm4M2McaYrkHGPkRTzEuW
         yQLlLoBUvE7SYZsubsOhrx61BMgGop5SkD5Aol9+kPCxiOtYNcuLUPEf2B4OnzL4OxVB
         N9Sb58YQEgC7TWvjuemIs68OT1gp5N0iG2W7FGmVfPNG0Ddpl/sq2bX8Iat+UwifxNUi
         roGfG5uj9uKHjaTVvf+WdHV6SSpCq8OX1PjWNoi0GGbapouCJmJ6YqlNlCCOm94ptnkH
         LmAQ==
X-Gm-Message-State: AFuF++nKlNbfDyDVBRgWe0j+4N285JctaSjy403pr0sFFigCIDWWiyP7
	IJMi1AUdarrLuapBMQp1dmBczDpZqABU3IYtGkTJ/QR5Q7rE5FEBvavwHQmnsQ98G88=
X-Gm-Gg: AYBFou11FeRNHqW+8m6pZh9gImuI0Mg5eG/k0USiMu0WFrHAY7iYDX9D9I+Y76GoUKG
	vgoXpA0VuqSVtFWjWduFjoMEbYxo7J0+A45N5OIYe1p9+N1BwvJdVh5UNDBK0zHbee5B6ZFx0ad
	3KxatGfS89sGX8x5fSVkD3K2Fi8eBnWPLfbisYR4EJr0Up88PTNrfSbXyTYr4WlyFkkz/VuPJBx
	QnSVNHfkbhen45Nm7aX+M2YZn6ZpoJRiN7lt88YP7Dh/0Yaped3FIC6fa8NmSZEZbnKeiFXtYcM
	xVlYpphoazBTAWtEDB77OyJCUrqE1cGWX4dxS3DIQoQxgdy/BJlxGzFVpSm9WPdsNXXw29A9HdX
	ziSef9BnhAIbh8cgpzhixjY6/YeeDo+Ry/Ve1Jd/Z9UkIaINoSItCQmCJJfJtGMVp79H5ac4OcP
	WhgBt4Vk9qD+lcH2ROU3GO7KAL7owiguzxdYv8wwrAj/iKz8LC+DSgoR3SqTP+SwVE7eEPKzVf0
	YOeSvFwTuRAUwt5KRoYUhrDUvpzT2HbCYpZT+X4QQ==
X-Received: by 2002:a17:90a:d40b:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0574f5cf6mr2852052a91.39.1790015014139;
        Mon, 21 Sep 2026 11:23:34 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069a0c7aesm39051a91.16.2026.09.21.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:23:33 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:22:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, Petr Machata <me@pmachata.org>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH iproute2 v3 2/2] ip: ipstats: Do not hide HW statistics
 when hw_stats_info is missing
Message-ID: <20260921112201.28213661@phoenix.local>
In-Reply-To: <20260910092057.3980-3-green@qrator.net>
References: <20260910092057.3980-1-green@qrator.net>
	<20260910092057.3980-3-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 11:20:57 +0200
Alexander Zubkov <green@qrator.net> wrote:

> ipstats_show_hw_stats() returns as soon as IFLA_OFFLOAD_XSTATS_HW_S_INFO
> is absent, dropping the counters that the message does carry.
> __ipstats_show_hw_stats() already copes with a NULL info attribute, so
> let it, and skip the record only when neither attribute is present.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alexander Zubkov <green@qrator.net>
> ---

Ok to check for bugs, but this is not that much of a problem.

After patch 1 this is unreachable with a sane kernel.
rtnl_offload_xstats_fill() emits HW_S_INFO unconditionally whenever
its filter bit is set, and ipstats packs that bit together with
L3_STATS. The only way to get L3_STATS without HW_S_INFO is the
resumed message with prividx at L3_STATS, which patch 1 now merges.
GET is not NLM_F_MULTI so it cannot split, the monitor notification
carries HW_S_INFO only, and both attributes landed in the same kernel
series, so there is no version skew either.

The commit message still describes the v1 symptom. It is not dropping
any counters once patch 1 is in. If you want to keep it, reword it as
a consistency cleanup: __ipstats_show_hw_stats() already tolerates a
NULL at_hwsi, the wrapper does not. Otherwise drop it. Not going to
add a validator higher up for a message the kernel never sends.
