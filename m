Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDA503BE9;
	Fri, 25 Sep 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379304; cv=none; b=E1dCQq1Kt7U74pYFrXzFV0TrjOE77JMWrGQhLMuetoU2qSLJ4sE4ZOhP8vp1IvVvfBHtab3hs1bjHOWZGdJEgqBv51pMgV6v7Svk5PiFOUOL4wjX17ab58vrtRT2+orzUK9xf4NvbIzthNGTa6wa0vxr+0AQCzYmGqyNv+9KToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379304; c=relaxed/simple;
	bh=5UXaEySXQcTsbhiYIw0iUlAwZ3atvAEbvNDrglAetrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vx6U/gwf5Sfb8kpCqS3WRLuyJ+nN1ZmK9v/m4oG4qTy5pj19NADEe7GtxSy0ATfXl9yeePGr973o9bS+8M/g1peg3NAlzHeTwjeeWID6uNd+S8XRpVrcpZVXWBP+3e+wQIMQagwEDVpwZlvRA5SMtCoLsDFzq2aP+rjx4RjcZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlwLCdup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlwLCdup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E21A1F000FF;
	Fri, 25 Sep 2026 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379302;
	bh=WhbYUgghyjfVx+COyKrdenujI2XkkzFQG+GWstWPtuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HlwLCdupOO+7w7kf8CtjTBSq45imL9xSRjW+YXXYtzikvbzSWuYBZGyq4XYnqMaQn
	 0FeCYBONqnvl+sAYv0cQs5emQFld/I4boEE/xHPpRKlX0Zv1TPnJ4+dRy6m/LcbyOz
	 OYTFmOHh4KeRyxADJU8jNGB/m7fK7aRyYL1HofLBOX4Iez7U1nGTNyHeVoxGpNa+N/
	 cZV5O4bJrGIGhkkssTs+aPmDttoBljxVvk28gyn4I8XggnIYQLYoR6HOh7b4hdgRrq
	 kzXqXNHjkjiac64b9T/AWmkMZFVVxirJPo5KKpY/TjT7NF/0t3417VvdVGWyqeFTfy
	 yX4F8enySGrMg==
Date: Fri, 25 Sep 2026 16:35:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Binbin Deng" <18983559317@163.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Binbin Deng"
 <dengbinbin21@nudt.edu.cn>
Subject: Re: [PATCH net v2] net/mctp: publish the mctp_dev only after it is
 initialised
Message-ID: <20260925163501.18db5195@kernel.org>
In-Reply-To: <729830b8.130.1a0c945579d.Coremail.18983559317@163.com>
References: <729830b8.130.1a0c945579d.Coremail.18983559317@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 21:19:19 +0800 (CST) Binbin Deng wrote:
> +	/*
> +	 * Associate to net_device.  Publish only once the object is fully
> +	 * initialised: __mctp_dev_get() runs under rcu_read_lock() only and
> +	 * hands this object to readers as soon as mctp_ptr is assigned, so
> +	 * they must never observe mdev->dev == NULL.
> +	 */

Too obvious to include, I'll trim when applying
