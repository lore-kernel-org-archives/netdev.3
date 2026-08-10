Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43E3AAF54;
	Mon, 10 Aug 2026 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404154; cv=none; b=MTvJS4pK7oNL7D6Euw6qsvhDQ7zPG7JOuN3p07QipJHm0tEW72z7wo6AugG8dYGAX1xUTAS4sVRS+Rir5blfZj9CbyTMnUJjsohhhBWxNCyUgfEQHpwGBetyDWRcX6egHjxD/EqeI+zN0w7ROUmUTe3Z4OA7/u9iQhPsSZXiXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404154; c=relaxed/simple;
	bh=MyebLXbTL4jhVxzDwEwymjyjyMiQZqhB1uhU+e8hXgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBWjAjAbVJhDwtMJ0t7ah0JrdcMHq/fvu6+INNYQ6BedLAlDpor0b+xXE9WKOLgWoaNuPGDmsCJ+nI0d3Yvsn3/0xvG6V8ruORFH4mpZRfoD/xrXZKWRwiDyrIuXi2kFDVTbYWh8A2E6iDN5VsnP9t5R1y1iBQ9jSJSrnkHbimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcxWzP7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcxWzP7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF7B1F000E9;
	Mon, 10 Aug 2026 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404153;
	bh=bH2j2IxQ1rOyJYq0i5SJeRV+4hLvMlLz40vDbxV19g0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KcxWzP7qxCftr81LT8jJSWYQ4kMhJjcQxs2BD40nrEEJFe2aWCD7/+4g0NCiGSKgJ
	 lYk8Zb2Qkmml1zmVmUK0l8xnNlu6/FPp4rX4CMcytNnanrt/CJi3FUHHmXInzaTefL
	 edBY2JCXyXWpaSyzB3nJnbAXPxOqzYI7NxIPXs2wl4fVqWg7GZNA3S0AOIC75fgCvx
	 L1yzHYib3DTsq/hej1tOlBhtES2G3K8ggJoXuCqtkRBf07QPXqEgIEQ4Cn0TUWCsEV
	 jirzXzCMw/nj8LOh3c9+vx+xNc947SjqsxOBTVJI1FxUroXlq72dRiT5i4z86189a0
	 o7tJjf7nhjkzg==
Date: Mon, 10 Aug 2026 16:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] keys, dns: Drop unused NUL terminator from
 upayload->data
Message-ID: <20260810162232.3eb7e73a@kernel.org>
In-Reply-To: <20260806200454.245444-3-thorsten.blum@linux.dev>
References: <20260806200454.245444-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 22:04:54 +0200 Thorsten Blum wrote:
> upayload->data includes an extra NUL terminator even though it is never
> used as a C string. In-tree users access only the first
> upayload->datalen bytes.
> 
> Remove the redundant NUL terminator and allocate one byte less for
> upayload->data in dns_resolver_preparse().

Okay. You know how I feel about this change already. I'll apply but
please adjust your filter for changes which are worth maintainer's time
