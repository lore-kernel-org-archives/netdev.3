Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DD547067;
	Fri, 18 Sep 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772496; cv=none; b=hrWMtZq6uTT5dn5/mMUnXGiP9q6ZHhtyv31wzfTcerUOs+b7P+V2++q1NiuVJXCxobewQdSP8Eh4kQBsntHq5bEkl1fiPWA1K+VeM1Of5/NvCE0KRaLkoYe8hG9rSX5a7D1L4/SzSFkN9I03w9apjhNJ/IJD83L9h+Kt9SXi6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772496; c=relaxed/simple;
	bh=1JuTJe1i5GSzwNn1qFvpzDplKuEHKy7MCcVj+FbkMzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYWku04GpbYvAejAMOp6m/N3ebaNziYrHqimmK9ReQyyU3nwIqD+TfIPLgRWf/ZN/C1Pbke7Wxp0Oh2ovzAqcURJfRsbqjvJnYyzUG7d7lLcdOI0EqxYFmQbrezQ9BEZsZz7HutBh2WFUAzJ0F9ckXsX0z4gTfTS1VKY2Pbihjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebhZMu+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebhZMu+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A60A1F000FF;
	Fri, 18 Sep 2026 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789772494;
	bh=M0kVljirnYbQOsD/zF21Z2skWwTKIiDNuYm5iyhPMD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ebhZMu+QKW2Y1XXcd0HuStS3L2YKhk/MQROhZVztlNzZh+d+BFD7ytMuPA6aLDgMH
	 WTsgmbcZS7lL/tXhbikH7r/FLwlSS22qelSGmvF5akosTdDUT8FkKLdKCT8GfaXq8O
	 5Cx6IlPl9EWae5JPziUd3hXZE0L55MN02Jr4sbXd3gvmwKZWMlOE7L+m9B+bSbJjdu
	 TbUxIJ6pDKfTc3GDkbeyBw0kHhteKOJNDg0Ui5xkZEbcOC48qyJ8ftN4a8o1hFlx8S
	 6UVxYzDconY2Phmhm+nc02mHt9MWyfAGmS9x/HoxFQbynjuvcHxfowdufTDj97Xr6P
	 OjMfKWfg1G9YA==
Date: Fri, 18 Sep 2026 16:01:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, u.kleine-koenig@baylibre.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v12 1/5] net: rnpgbe: Add interrupt handling
Message-ID: <20260918160133.28a59fa5@kernel.org>
In-Reply-To: <37173FE7EA2160B1+20260914013201.2262568-1-dong100@mucse.com>
References: <64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com>
	<37173FE7EA2160B1+20260914013201.2262568-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 09:32:01 +0800 Dong Yibo wrote:
> +enum mucse_state_t {
> +	__MUCSE_DOWN,
> +};

Please avoid adding such bits, as AI points out it is racy.
You should be able to order the code correctly and disable
NAPI, no need for racy checks.
