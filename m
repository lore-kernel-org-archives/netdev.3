Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910731;
	b=3UQCOeCIAxjtAEwsxRkaVk/tT70J/SPoj4ZUTao/rkncZTrRZJDc2gE/2dYkzzgYbcOc
	 DeAWS7Y4ZWBsoEdoZNaPLyIaGwryQUvovKVO4sWbnXZlTqDC/wrMrWVGgrDG5IfjrQpdL
	 mR3Cw7Z/tEmOlPZ5HP6cD36I/FpbcFLDtus2HHlJGKr7Mcs4+7jOPCzGQJWnDnyZBUfrL
	 j3Fif6WuyWNnmMGWZj/t3asYFtBFxZbYwk7dFDIPi/J3ximXVP6lPOcrAYtljoqf6rS8f
	 6ofCDiAesNmv+0dRlSwAsGm94PI7F8W8UKxNpnbBEj1f5ZuMqSKYqMoGx/2d1w6avBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910731;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6Vzh73SLqxZvlTkR4dulyp2iJbaYGPw6dH6c2VD/AkE=;
	b=KwSR8hklvS8YephLSeWLJN9Q/R9CpcHU40jr2okIgI3V3r7GDoMPVImulAp/R7DtfYDz
	 PLZiZ89/N4Bqzn5l/9gtkP8o3Xalp3Oqmbja6FFXMNZVLrDHB9vrfKe0Os66u1KfgEyU3
	 NPfUV0iQD8h90okxi78xvjB7kdB5jZp0vA2Fe9GD17QO34quLhSBIIDF3Yic6LokHB5Wx
	 WC6iMO1PgZjRBWMLWMBXhcKZiFuYRiFjug2KrjaKTjP4iRB9QJBsXsbAERvvoEyTeXfQI
	 BLqhoLVpUJa5PKYVejttgS1dmiFKD1EPS5+jFevNXhEnBSZz4sXQjEkwns0tWQQrPxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMZU6err;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A7606A330;
	Thu,  5 Nov 2026 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMZU6err
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D261F0089F;
	Thu,  5 Nov 2026 20:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910731;
	bh=6Vzh73SLqxZvlTkR4dulyp2iJbaYGPw6dH6c2VD/AkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SMZU6err2G7VD0AOAjwMkvfcqJ5um3WuLuNhTkcOyrWN0smVVCUIY/3bKYEQdujY2
	 mKMH0JWNqqc2g1o7bLXjXtdR3d3c1aa6BOcb0U+WMjIG1btJ/uk+ygOezlSSjdQ4+1
	 +i+DGqxYjrkgjzxAkNciaJDBKIatwVcZmQWaNeWraQKlXe1qSFMqcwaEZZq5d13IYP
	 8PRYWa/s9hFq9kMXeExDVmStAa5ZUgQ+Gzss20g2uZbG3gSv8VuC7Nnd9vFYNCWPai
	 9/mIWtqFjs4IBKcPbl2GwO6LyWyw1IATkbEtRt8xxJxxK41oB2jLVYjEQjzw3GHJW1
	 Ybb1jcP/JFEog==
Date: Thu, 5 Nov 2026 20:32:06 +0000
From: Simon Horman <horms@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v5 3/6] net: ti: icssg-prueth: Move long delayed
 work on system_dfl_long_wq
Message-ID: <20261105203206.GZ865646@horms.kernel.org>
References: <20261102105703.111844-1-marco.crivellari@suse.com>
 <20261102105703.111844-4-marco.crivellari@suse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102105703.111844-4-marco.crivellari@suse.com>

On Mon, Nov 02, 2026 at 11:56:53AM +0100, Marco Crivellari wrote:
> Currently emac_ndo_open() starts the stats work for the first time with
> queue_work(), using system_long_wq. This workqueue should be used when
> long works are expected and it is a per-cpu workqueue.
> 
> queue_work() on a per-cpu workqueue enqueues the work on the local CPU,
> so the first execution of the work is bound to the CPU that opened the
> interface.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> The stats work handler, icssg_stats_work_handler(), already re-queues
> itself on system_dfl_long_wq. Since the work doesn't rely on per-cpu
> variables, there is no obvious reason that justify the use of a per-cpu
> workqueue for the initial queueing either. So change system_long_wq with
> system_dfl_long_wq in emac_ndo_open(), in both icssg_prueth.c and
> icssg_prueth_sr1.c, so that the work may benefit from scheduler task
> placement.
> 
> Cc: MD Danish Anwar <danishanwar@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Simon Horman <horms@kernel.org>

