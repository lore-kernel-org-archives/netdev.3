Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2C33985;
	Thu,  5 Mar 2026 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671557; cv=none; b=KuKkKbHGhzCJUMX0gGYNUv22LO2BLe/XM7TxmPQQixNZ9u5ByUHIpQ6vltq9i3v3+reyIJ6CC4ZTR1hISlyuE9MdDNp9sg9Yqo3SeeF76H7PbzDrPRZ3RrZ6Y8qnUtYAUl5Zc9cd2cyJOSdZJSVBUxtD3aTvKzCJT9DGa4SUXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671557; c=relaxed/simple;
	bh=Vs4wXaEJ5isRbpaM5gDufAuQu/lZt97ZRSo2jtArV1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIIYiktBCp5ObE8rDqyuL3MMO5M3KE8ROcb6lIxIyRQjvZGGzcuDik8+btf0DnZ5rlWKT7d2N2LWOl7dQDGexdtvJtEzSvfuqvRP7mDO8NGRrobZVyn5Lz25Y5/eXEqzGoxP1g9KaeZnHYOUyEf7er78/58cVG/Q0lHVmaAUaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLDy2DaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLDy2DaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7853DC4CEF7;
	Thu,  5 Mar 2026 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772671557;
	bh=Vs4wXaEJ5isRbpaM5gDufAuQu/lZt97ZRSo2jtArV1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bLDy2DaYJwZwbTmr2Sp/4KaHhVREX2EgSi6WF3hGOSC0sdySKkSV129oxRWv7uV7a
	 bSxL0uxcwNGi0qHOqQttNVsYWEgC4flNGhQjEHEmVYLUgl9Zz6zKra3Jl1r/v3qmyO
	 KlZyItHf0ekiZEcpzvgbUwA0DndrwnEb+mT/3XLqtic8eun03uIXfKnBPwBEc9KA3e
	 6Rl+TQ+fJh4E7RyqGxJDxpXCGlA3VRXBLgQWVi0XYdVDfYvvzrRBA+bxyNOtgYtpz2
	 7zaTNySO4o7ltE9HPqocHO0dhJW88zuwPedAiUh2CIIuvuToSEqcXMH94s3H4OipIS
	 LXruFzJN9Sptg==
Date: Wed, 4 Mar 2026 16:45:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jian Zhang" <zhangjian.3032@bytedance.com>
Cc: "Samuel Mendoza-Jonas" <sam@mendozajonas.com>, "Paul Fertser"
 <fercerpav@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ncsi: fix skb leak in error paths
Message-ID: <20260304164555.6253faf3@kernel.org>
In-Reply-To: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
References: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Mar 2026 13:46:29 +0800 Jian Zhang wrote:
> +bail:

please give meaningful names to the labels, eg:

err_free_skb:

> +	consume_skb(skb);

since this is a drop condition kfree_skb() seems more appropriate.

> +	return ret;
-- 
pw-bot: cr
