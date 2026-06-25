Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBD3D7D80;
	Thu, 25 Jun 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397897; cv=none; b=bXxpZ/XFEMqqvX8HCy44K484oIM/I4YUlHP9YjN63LJXbrsBC/StFua5r4f9WrFxQZpidOEamLYrUzuEhAVZzVSwkjvOsAfxeknBI+BhUS7Lcd2BS9+b+VnCkcU8OKndAUrioWxY5zCxL8sC10b1DqOcIsxmZcUSm/1c2oowskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397897; c=relaxed/simple;
	bh=A7AAopTdZ1zjiBVPYRadKJ4o7W5LhAApgzPnsUQ+SR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGkamRb6mQYc1A2E8qPNsnx48TUbiBSdi8uOg8qJHPlfhvofcpb5SQwUtymzREIuUB4gunJMgI5wV1gKC53O3dMvzKy+9sWTKVrEkLrktj1Q6GGjdLgDuT6cUaBem+cvGy8ms5MXAml1KEq2hTqNJKO0v5KNJUNO43u1fJ75HSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxUdsmc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxUdsmc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8E81F00A3A;
	Thu, 25 Jun 2026 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397895;
	bh=7X/N03sA9KL8qNG1OlYTxxGU9GE5MW8iUHxa9ApFvJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZxUdsmc7j0OTbVbUM/8Zc79Qb3Ly+LEwwDzru9tHppjO0Bhac8aM8XIYN2FFolIme
	 Sa54HcjRLfnSPv4skiQMAeUR1NkyKcXKKpwUesS/wFOUUySWuHvaLRh+3jzygiM9tY
	 imTIbs8qaivTOXKThhlmq/2kFfg8LedYNl0+yjnEVfbWv+nPt9k8eN2fukH0HT2WTO
	 LkX6itz55jJT/gwhglrYoJ8TRdla0jFHzPZUsK9kk2ZXurjBUN6kvE7ck7VhJmpGWm
	 TzYaXYd79pZV3JUsktkwldjnkT5tUJr9F8NJ6HpLWm4j5mIuXvj60Xpc0+g+mHGJ5w
	 ocgAqzQ5+0SRA==
Date: Thu, 25 Jun 2026 07:31:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: avoid unaligned 16-bit
 access in api_wrap
Message-ID: <20260625073134.11c11e18@kernel.org>
In-Reply-To: <20260625084459.7393409f@pumpkin>
References: <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
	<20260619100154.794168e5@pumpkin>
	<20260624175239.1b97aaa6@kernel.org>
	<20260625084459.7393409f@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 08:44:59 +0100 David Laight wrote:
> > struct mxl862xx_mac_table_clear {
> > 	u8 type;
> > 	u8 port_id;
> > } __packed;  
> 
> Does that one need an aligned(2) ?

Right, I meant that if we need to remember to do that instead of
depending on natural alignment - chances are someone will forget
while adding a new register, and the bug will be back.

> > So I guess the "just don't pack" will have some corner cases, too.  
