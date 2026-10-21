Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552841;
	b=mm8nBE1aaRw2g+nvsMzdZR11EqoKxWAHRPmkDPNtF3wPsNb0Ykz15z6IqWJtKMNkrQEP
	 W4HbR5ARrxIyjJ67TLoNv7CBOuV4MhsWouwiMzaKuzwaKkfeKyumUTB+7RVZRHxZNLGY4
	 dV7aierJPoyxCmwYv2nqsTE4PVlKn06UhECkvFFZnd9/PRO0pprH0OOemAi685yPACDF1
	 vqkUWQls/T6AzL9nqtcmeGRDsk2hQXx6kVIStUKYl+G9OFeUnbLRxeKtM8hUbBVxtzH9m
	 /U+242baQP7cYQGlHJWQR6/PY+6Rmya3OOJvEfdKHuO4el6QdTENk39nz+FupQrANiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552841;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O5Vr4wuam+LW2uNpAXpyIKoz/k5KJAmL65vRSOyP1Fk=;
	b=yq+buVe6wkpQzHLrXt+a23gmkGVAc5w2BPsFfBA3sAKolpNFv/SlqaJ/pAbdHiD3+4+S
	 EgMIosDH0/zXfHW2//W7P80DMkwu97/I9qIJegOexUqgLCnhCvfZOQ8eXThjQ7ueHjkba
	 +5ztbQ4BV9Jv2OUM3vyrs0NtqTGiI1XNNWjSNWXL+nZ0q5xJp8fcw8FH49OJZPJBpwwCM
	 Oed9ZnmlB/jJdDX1w3Zg3Ny7DZDgK6jFlo49/dW4lbnTF9Om3a1gu7WHGb8kYv1x7je2X
	 hYFlnJGwJpOzVOFuu6xfOOf/BiLsz7ZfKo/Qg7qcdaXo41TmskkAKSjwBG+sbytK9tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtMPE1hF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC0606A321
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtMPE1hF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE11F000C9;
	Wed, 21 Oct 2026 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792552840;
	bh=O5Vr4wuam+LW2uNpAXpyIKoz/k5KJAmL65vRSOyP1Fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EtMPE1hFZNyBYHA/ApO1fkMuvaK/ICPXQw6P9h5dJ+KWUqEOKmmh1kgVBvZy/Lxdd
	 chuot+U6/wyuxJogr8w+tFEPbMrrztGDj4l/SG0UX+Ae0BuMHkYOFQDAE/BN88fBTa
	 wF1KPnWaHUaj5XO8NTdyOn6wyHfEXxA9UjmIk6Ikfcl/IVrommQq+RXo0QARh3SVpq
	 +lqeMophTA+Fgz76HfdEm5H5Tn6OHyyxiUCX9GQpPTKRXW4raWXHgqZs1svgpMWe3w
	 pNNwAmxOzKU9V3NwenFOl6gKyJ1feF2LJyJziK5nhJXL2Blzc9W3o7SNo0k32DoKpf
	 4YAoLKmkBrdzA==
Date: Tue, 20 Oct 2026 20:20:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, edumazet@kernel.org, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
 rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com
Subject: Re: [PATCH net-next v3 12/15] devlink: give user option to allocate
 resources
Message-ID: <20261020202039.7f4b8abb@kernel.org>
In-Reply-To: <20261015185454.6332-13-przemyslaw.kitszel@intel.com>
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
	<20261015185454.6332-13-przemyslaw.kitszel@intel.com>
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

On Thu, 15 Oct 2026 20:51:23 +0200 Przemek Kitszel wrote:
> +	if (resource->occ_get &&
> +	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
> +			       resource->occ_get(resource->occ_priv)))
> +		goto err;
> +
> +	return 0;
> +err:
> +	return -EMSGSIZE;

Why the goto? It's pretty idiomatic to return EMSGSIZE in place
for put failures
