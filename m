Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44834530DF8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904101; cv=none; b=jazx4wpVhMz0vkI/subRLw+4lqwCBMU2lFUBODc6xLwS6T44RO6B3CGL4CrtXqbGUDGuaDxCgKmr29LY5xJxGe4LB461RNFkGIjS26lTOXNGo/GogF4H/abkzt5CUHgpltZDc6zWbY8z0OXWk7FIfWy1UNGLqOTYpi2n0zBK6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904101; c=relaxed/simple;
	bh=VVpdyqkViBP2JD+DjR5sCsYQ8pHYay0ZPhjhfyNtQLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRpQCp1oYoabAIrhnfRRomVqJ3sv23yn+rVVtQ+MoXIbgkNVhTd7qhj1UDsvKh8XaqfipG7Vkv30U4pdKHk/ZBieTygsi5oCc2FF2c+U9DHe7dRYd/fHtfjZm0lo1wP9FpyqjePClUlMmzPhawlWx4UDZLLrzXD/OZM/ScZ0jxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZhpShxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZhpShxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC2B1F00A3D;
	Tue,  8 Sep 2026 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904100;
	bh=8pKp+anWrtl0kfyiHD7DZKSasgBoZYOdvU6eGBsmhEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PZhpShxe3HBnQaNMMKxJHJ4c2M2RgyYE6dzvlPwDRv6jKWmpCu5hRHEawOYkKj+1o
	 qMkwo0GdRCkk2ZK+cK7mEETVfsQTEnEhPzei/N/7K8E4uRiUX3HrSA3mRjGTSyyN9Z
	 XpxQXVIkAFB1QD5ZQd0U26Z5/wKgWHsb11e0+7BdutqaJdmzY/UM5xQYkV5HCt2VV5
	 N6xTfJxS3ufuAw3HJS7Hls/wJds+yjvTO9Xa5frqFkLyYehO5OT+SChS9rQcySgTQx
	 3BcJNzKI3ECSCYTe6mj8wCEvzpXezMP8UP2gIkIsYePbH402vaGsAlTQQh77bJBgVA
	 8VAvueJ8wG6Hw==
Date: Tue, 8 Sep 2026 14:48:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Message-ID: <20260908144819.16313dd9@kernel.org>
In-Reply-To: <CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
	<20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
	<20260904160106.08acccb5@kernel.org>
	<willemdebruijn.kernel.173115664f973@gmail.com>
	<20260907161258.2b0b421d@kernel.org>
	<willemdebruijn.kernel.19b10eb6885cf@gmail.com>
	<CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 16:48:03 -0400 Willem de Bruijn wrote:
> > > From the name I suspect you mean a feature / ethtool (-k/-K) ?
> > > That would do, but presumably not as a real low bit within
> > > dev->features ? I guess it is a datapath feature but somehow
> > > those bits feel too precious.  
> >
> > Makes sense.
> >
> > An ethtool -K that does not use dev->features seems like a hack.

It's just a way of avoiding netdev_features_t becoming larger than 64b.
At the uAPI level we have a bitmap so we can express any number of bits.
But in the kernel dev->features is u64 / ull so if we run out of bits
the refactor will be rather painful.

Is it really that much worse to add the support for "high feature bits"
which don't go thru netdev_features_t to ethtool, than sprinkling extra
one off booleans into already bloated RTM_SETLINK? Not sure.

> > Keep the existing ip link attribute and make that settable only to
> > zero or max_pacing_offload_horizon?  
> 
> I've updated to a simple boolean pacing_offload in ip link.
> Let me know if you had something else specific in mind.
> 
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -1089,6 +1089,10 @@ attribute-sets:
> +      -
> +        name: pacing-offload
> +        type: u8

Netlink pads very value to 4B so just make it a u32

> +        doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).

> > > Not sure if we should be clearing user config or rejecting
> > > the feature change if currently in use.  
> >
> > We cannot reject the feature change

Feature change means user requesting the feature to be disabled.

> > if it's a device reset and on re-negotiation the device capability
> > changed. E.g., from a firmware rollout.  
> 
> I added a separate patch that adds a netdevice notifier to FQ.
> To reset offload_horizon on device feature change if needed.
> Or any qdisc feature that depends on device state in principle.

I hate both notifiers everywhere and the idea that we have to be able
to quietly revoke device features "on firmware rollout". It leads to
unmaintainable code which almost never runs so it's buggy half of the
time. Whatever.
