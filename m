Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141229;
	b=H04rrX2ilPHU5bXkFrhf7MlI1dUPAeNJkUSNZitJ1lW/7+/TqEK4L6jQt1jhdKEBmFig
	 vKzNTdK4OXoxjLm3WIKZ5mwxN/QsbjuRJuEXnmfbbpM1q+lGEmlquAXkxTa9VuR34JRwc
	 3rV8XLexHlvtxpuRCeUwQzE3y1F36cM5snG7biuXfAAcjtU3DoU/lO+K9K8QfmwFYHebt
	 MXgeQ13p+thTK5MYxNy9xhN5i7ueGzGWtaNeUlaWiGvo5FxnuMV//cSD4Vq+opaa67xea
	 6vRqc53rLGCbGhtE8AjJDD56yN9Jyt0POQuU+/YzM6V96FpcDhvOYi/fXRnw8ZvvzvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BRhWps6yiPo6vqGKqMu5wMjShEbWK2OtLM+mwipcvo0=;
	b=E93zvxaJjM+gR+WMFAdYyFuUCqn3TAYc9ZxLK8t+0mRK7NvnAvDOqakFcsREdlVCVqic
	 FdnmtD9HXqYXhkocEXgTWpOGm1uINojvCqQLy8HXyiaqDhrSsAbBt+Eto3XqdBtpKkVhD
	 2mVWAi2KFSce4qcueJycWwpCj7V699hHd4GFyTf38PqFzacL4Suqxx+RG1ZKX5OHzLrER
	 /p8OTN5rClui/enUZ8/1xRo3B6KpX48zH7JEnI0NJQUOnhblnemwSRcJ90kjUlMRoyOm3
	 K1q+Kwdu7H8RjWuKzJdCtuQzBb1yOTd+ONuf3KnUjMMedbQhLuFGrNgmvhvlF+UFYhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inJSfAYG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44377606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inJSfAYG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE781F01825;
	Tue, 27 Oct 2026 22:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141229;
	bh=BRhWps6yiPo6vqGKqMu5wMjShEbWK2OtLM+mwipcvo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=inJSfAYGOqiY43LEC4aYEatk1t9+uTRH7U4HgtLYiHqLP+Xo+UikC6cuh29ezbIcK
	 FumuJ9m40PiE3bQKvcRUjG/AhyCpNzic/E3yBmqa8Uaso3iX5Pkhw9YBLZJUJl+rKt
	 xAY+/7UJhGASOj61W06VC5NUmkmFZzFCxalIYvdzh1GvDM4ExRotILphtBQMjkZ/+e
	 5yG9CdzUK3GPktL81eRuzCq7IYP0cZlCVwsu0jx74E2YQB9LHrwlIIcCIsUiLBJAAK
	 Vf1RC8RiyIa1Ot0rksAD486g55mAEcekJhBZ0TBN9F06z9vmWEw5CvA9J58f8CIRVK
	 UcBGAG80aW0Tg==
Date: Tue, 27 Oct 2026 15:47:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 jiri@resnulli.us, Guikun Yang <yangguikun19@qq.com>
Subject: Re: [PATCH net] devlink: region: fix snapshot id leak on
 kernel-allocated ids
Message-ID: <20261027154708.5138e1af@kernel.org>
In-Reply-To: <20261026174403.512-1-fmancera@suse.de>
References: <20261026174403.512-1-fmancera@suse.de>
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

On Mon, 26 Oct 2026 18:44:03 +0100 Fernando Fernandez Mancera wrote:
> When DEVLINK_CMD_REGION_NEW is issued without a snapshot id, the kernel
> allocates one with __devlink_region_snapshot_id_get(). That helper counts
> the caller as a user of the id, and the caller must release this hold
> once it is done.
> 
> devlink_nl_region_new_doit() never drops it. The refcount of the id goes
> 1 (allocation) -> 2 (snapshot created) and stays at 2. When the snapshot
> is deleted the count only drops to 1, so the id is never erased from
> the snapshot_ids xarray. The id then stays in use for the lifetime of
> the devlink instance: requesting a snapshot with that explicit id fails
> with -EEXIST, and there is no snapshot left to delete to clean it up.
> 
> Reproducer steps:
>   # devlink region new pci/0000:13:00.0/device-caps
>   pci/0000:13:00.0/device-caps: snapshot 0
>   # devlink region del pci/0000:13:00.0/device-caps snapshot 0
>   # devlink region new pci/0000:13:00.0/device-caps snapshot 0
>   kernel answers: File exists
> 
> Drop the caller's reference right after the snapshot has been created,
> as the snapshot then holds its own.

bit of an odd reference counting flow in this code but okay..
