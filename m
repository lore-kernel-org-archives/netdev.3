Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529745;
	b=WLS7TFXt619Mu/B/S34kyTHaifwURKZFs5celJib2nmsPyVsJ2UUns4woCSGaiHWDu64
	 EASCdiZG6qVDMnrX6xmHdU2H/hB37QAll9LpJo4kDGALqEJDRl/GKiQg8CZsYzVQZ+Q+W
	 IQEVUBENfAmVxI6c84sgI0kYPMMnMLpDvx3Z9JO48wh1utZfOSndH3d70sXHuenGRnNW2
	 /1m2o3j0TN/YGOdIh/ElIDgKjmAvJ8tAAxp1EblM/NSrLPa8Hxp+3IuzbBrY0xBzDRERa
	 yIzYOgTbyd1xCrJQ52siMRhAvvuQsMx9KGkq/0iCZo3s6sVsh+rM7fj7w/3DVoTA+EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529745;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M1mqdzT9t0ObQ2WW+nnA9+TcUoqeXJABSq60W+bpP+k=;
	b=OZlKY0e0YMv5ALHvYv8+wb7ySd0VTl7f5jm21h8+91vfRsgj8wOFNLTkjTWk/rAHwWSi
	 9Lo5yZqRoi+Z/cLJsjSFQOC2RAhUa74etiTG8WJV9LsJtKDTrLxJ6VLkMFAyXRagPvbkU
	 O/Nm0d+dXKiBqlb7vujzjg5yTugeXRfLrrxBAZwT2To24KufGvJKklUhAb1zU9IufboY6
	 ljKJBYnHXvc1PGosVXpPAtv8/v8MMG2eAHvJ4WrBiyXicDsi0zUtia6sBxY1tFVrWasn3
	 6f9B5u1FPT9HIUqWwUjtXv7xB0y7M2HW+8DBEzYFHaGFvPL3qXX+jRp4nCn6MyKHysA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thdb1MJd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD224606A319;
	Tue, 20 Oct 2026 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thdb1MJd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA01F000C9;
	Tue, 20 Oct 2026 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529744;
	bh=M1mqdzT9t0ObQ2WW+nnA9+TcUoqeXJABSq60W+bpP+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Thdb1MJdWEFF8y0tFIZxmYXypnJbmjkgWZxhKPMt2PqtOVseEaFVCxVQnTF90LgL4
	 lHCQZ+qSE0Pgi2s5GqHJqFWCFhjas/6IMsTlTLfWQmU1z9hOcMhbDX3NrsTzVqIW4T
	 fho4ykIl/M1neRYscDvzfri1gT9lgYkQ+dLz0v+UK1fi0zIfNzAzTI5xAbUwQ9v6e7
	 QFV92ndRYpFnJB7321Ef45CZyqduLvkRU+yb14jWjKW9/+fEmwSbKj1+uHqed8fyhL
	 cvl91LldXL/1sqMSd+5Hen/vrK9+YcKNhVHogXoITH/q82WPyR0pAnY0ZdGoHvUqIb
	 L19Rz05cukXlg==
Date: Tue, 20 Oct 2026 13:55:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Binbin Deng <18983559317@163.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: sit: unlink PRL list before RCU free
Message-ID: <20261020135543.4e44549f@kernel.org>
In-Reply-To: <20261014060803.286885-1-18983559317@163.com>
References: <20261014060803.286885-1-18983559317@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 14:08:03 +0800 Binbin Deng wrote:
> Deleting all PRL entries queues the old list for RCU freeing before
> t->prl is cleared. A reader that enters an RCU critical section after
> call_rcu() but before the pointer is cleared can still fetch the old
> list, and that critical section is not guaranteed to be covered by the
> grace period associated with the callback. RTNL does not prevent this
> race: RCU readers do not acquire it and the writer remains preemptible.
> It can lead to use-after-free.

Eric already fixed this
