Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA73AA9D1;
	Fri, 18 Sep 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769341; cv=none; b=Vx8MnX2es935Gbevh9MLsv10mYv7cNE3H/V6xs/qCdo64wiqpva+wj///APH4EMzsHRw1nKfeUTY5KKPpjZTd0oFDeU5y9u6de2wKiNcSskUlM7mtLmOjrzDKaTgeWlJ+8FN3irGgwqH9caC7on7h+6zJT8L5xgUrsrG4rSAdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769341; c=relaxed/simple;
	bh=opC7gHel2bPerJub3L3SGdRWmwPASYDgWs36vr/HDM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjByfMsMcbvK8OBixyIVYLZgzNw52VHCKGp2D2twwhKDVqKvX/Wt8yaY+7/WowyQuGGYqfr7pRjnC37LQmT5fY1xTE0c2/LvooBL+1Ljbsf0czXSbIfgD9NbTx8UM2Q0Ya/lQfECO/ZuB1AIOltNJWg0gfzs9RYUfx98Ty4mxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ1l24hu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ1l24hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAA31F000FF;
	Fri, 18 Sep 2026 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789769339;
	bh=3h3Drri56c/2UgO4cqSAuPj7U2BhzhrEacHDDLzx1FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZ1l24hu/e2+1X0MmT78Kj0kSdQwxy6toQpNIUVmYdf2EGrU9u5Wdh7RpVh1aq+A9
	 CS2wTgnAyXz3C9CWaWCRsN8Tpx43lhBP1EFJhDC4LJIAv5jBz7qnrxgSbK0zH0Ki64
	 MT2+N1eNH5MCMRG/LJfmmBWDfYyE1SecT71ox1aYd9ZL7uvR7u2JjhZgUsZOUf6VvJ
	 jMnntUYGBFcGvOTRoBAnZDKo606EqE6FCkc5Tsg+FruY3HVoaVVfSHMBZ4dNc3DRsa
	 Fj2uudhU4RUSdZG3/Ken7ngV43dMEDstczMv4JnwfWdKvLI+rzwIFqUqAC7IrLHIuh
	 ij8XOVt4oFfGw==
Date: Fri, 18 Sep 2026 15:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Yuchao Zhang <ndaugoing@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] net: netdev-genl: add missing uns-admin-perm flag
 to BIND_TX
Message-ID: <20260918150858.3c98728d@kernel.org>
In-Reply-To: <aq1Q6095yX0UmKKP@devvm7509.cco0.facebook.com>
References: <20260918114329.3659849-1-ndaugoing@gmail.com>
	<aq1Q6095yX0UmKKP@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 07:56:19 -0700 Stanislav Fomichev wrote:
> On 09/18, Yuchao Zhang wrote:
> > Hi Jakub, Donald, and netdev maintainers,
> > 
> > During static inspection of the netdev generic netlink family and devmem
> > TCP operations, we noticed an inconsistency in permission checks between
> > the BIND_RX and BIND_TX operations.  
> 
> This is by design. Similar patch has been posted many times, please
> search the list..

Time to add a comment, please ?
