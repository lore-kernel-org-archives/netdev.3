Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25C762F7
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603388; cv=none; b=XxgEe5/QNTjJIv2lt6cFEkHSvw1YbebfzQl6RGbloaKvKNsXYnK2aahW/Vf0cL6vrvsj/VUPiBNYtKr8+OO/lpnjUqY2mbKfpLvBc5S2wxCGQBOzePt69gZZejQfAGDtGAoRocWT2pZpxQrhupIRpUFoTmitnyHexRvT0V7oAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603388; c=relaxed/simple;
	bh=XydS6HR/A2YH/N08vLLjOuSnbPbDIeU2KBbCOscZNCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJTAgbhhmvln2iRLftl/QLRECE52VEDQtozxYtuSXU4J5m1Jpka3/JWcM7FbPSEy/18pECX0CducZuLLKxhZ4PUIxobZoVkrgbdPeGcUId6fpk+9KJlVM2RBUh/0ew4QVHeImzGCe5tI/nscaiu0XPLjt912lcxsUvyfHjQ9VPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drhjcGD/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drhjcGD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3D6C4CED2;
	Thu, 23 Jan 2025 03:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737603388;
	bh=XydS6HR/A2YH/N08vLLjOuSnbPbDIeU2KBbCOscZNCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drhjcGD/+B1mBTU9zcZPsbvUoBRnJFN1XdtyYxs+BPdiwhAEa6YNV5aaYY8AOZjyB
	 RAgwEaPBWoFK9sxDIA4bS6dXOE5SljaL84gVLF9lQk8FVr4fIBQBSiN0+3wiMG+l+3
	 Mk+rJwfKhbh8JI/nmjzpBvohZjB46sVLvITNjqTZr2XCYtMzPJtE9OcedaB1NfBLnR
	 u5hNCGGMT1J2ddIpfZHV3XGJEUiaP9s8cDRMLCbHejCfnm2GTdIAf4yGNKtq9q2dB3
	 1yJo44DwJji3KfVh3lKDivKoEAANJR2Da7ME3RXKgE0oUZoF8wtd5jau5W1mqLcjWk
	 YSOSxg7OIqw3Q==
Date: Wed, 22 Jan 2025 19:36:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, petrm@mellanox.com,
 security@kernel.org, g1042620637@gmail.com
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
Message-ID: <20250122193627.7086b079@kernel.org>
In-Reply-To: <CAM0EoMkPHKW8WPG4t2V-6wpCcnnuV5y1fs0OmVAaBYcPnbMmkQ@mail.gmail.com>
References: <20250111145740.74755-1-jhs@mojatatu.com>
	<Z4RWFNIvS31kVhvA@pop-os.localdomain>
	<87zfjvqa6w.fsf@nvidia.com>
	<CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>
	<Z4iM3qHZ6R9Ae1uk@pop-os.localdomain>
	<66ba9652-5f9e-4a15-9eec-58ad78cbd745@redhat.com>
	<CAM0EoMkReTgA+OnjXp3rm=DYdYE96DUYwGNjLoCyUK+yP9hehQ@mail.gmail.com>
	<CAM0EoMkPHKW8WPG4t2V-6wpCcnnuV5y1fs0OmVAaBYcPnbMmkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 13:40:15 -0500 Jamal Hadi Salim wrote:
> > Agreed.
> > The pattern is followed by all qdiscs, not just ets. So if we are
> > fixing patterns it should be a separate patch.
> 
> Can we please apply this?

Sorry!
