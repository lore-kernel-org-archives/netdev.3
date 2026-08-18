Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B647ACF7;
	Tue, 18 Aug 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071226; cv=none; b=S90qa/2Q/VcDjFjvdwf5TldAqZeyYRj5zSSvnG08YqRBPuDQOJhyD6qWBw61HIa5s1hxN8/+e9MHPWQpYzKn48e6yWtGWYEy9A3NPqRmaQT3kKBBL7mOXYJT252kdQaJ4sMCVADz/f+vzmn0KRHVY4FNK3+lMXid//HrgtCbOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071226; c=relaxed/simple;
	bh=4egrYE/JzUda7YElS31wcCcWZiodXy1vUd3jS+KOWoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHZHHYMEur5AFOZJkik30g6kVsXFW0mPsC4epPLnaYmh4LOAxDEsP7PeGZCNCaSacLesTb44eKX9eT+C7n5ao2W9sEwbOJ33ZObcqyfB5FKjUdMX59GH8fV628tY2ryx8YVZNduK9gc5Ky+EwOmPIVJf8pwEN/gF04dqduzjACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svc5GFNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svc5GFNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041771F000E9;
	Tue, 18 Aug 2026 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071224;
	bh=sdsd5p9uF18XnLr9zR6vn4nsLPppvVl4/+IZBzf66gI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Svc5GFNvfbKvNHskoVDV7p8qtHPtXNOVXn7X7t6HMGn2i5wHJyZJXPKqVHvOss0Py
	 BxPs3AOXJT2+f831CjtgFhbJP2AHNdSgchgGVR04P1pwVL99muuX1wjzB3o1SIlgop
	 whuIBI/OJDS14HocYyvz1W5hepC8rVjG6GIMX8ib4ZUc6TbeRZD/OFPKgfZN+8PVql
	 YQ2rD8dD2aKlF9+jgyc6cysBwu0QBDobru1uKgiekL+6kJU7pyJZZwD9HlrCv148ea
	 XLNs/1FXvPVDlKxD5yzZMY+OIVUG07hmzpLyg8WLbHwajx9ZG2XQr724YK2CnaY7UP
	 Bz9gd7JSvusMg==
Date: Tue, 18 Aug 2026 09:40:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik
 <jeff@garzik.org>, Divy Le Ray <divy@chelsio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: cxgb3: Ignore link changes on PHY read errors
Message-ID: <20260818094023.0ec57824@kernel.org>
In-Reply-To: <20260814133959.1386234-1-ruoyuw560@gmail.com>
References: <20260814133959.1386234-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 21:39:59 +0800 Ruoyu Wang wrote:
> PHY link-status callbacks can fail before initializing all their output
> parameters. For example, an MI1 timeout in get_link_status_r() leaves
> link_ok unset, but t3_link_changed() then uses it to update MAC and
> carrier state.

Leave this ancient HW alone, please.
-- 
pw-bot: reject
