Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAB5012BD;
	Fri, 18 Sep 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744562; cv=none; b=HOxY4m3KrRVxVwCMU0ZqR1K/+/UCHJ1RN6eExgT1b/8nSEFjLgD9qMm0xvatYe3G2U0Egn7Z15XiRRmsF55HqzNza//vXho3/0yx8+RnEpwtDsdKS0M93veR9Ws1B8vnIG6wKl1zeqvC2ZLN/Yq4UJCcp/UXaKOpcP6ykn1djLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744562; c=relaxed/simple;
	bh=joZY4Up6a26RE7aKPDySANBWpP7OSk0AEhi+9eQ8eeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsKOmJCWbpq2Waso3W2Yb2luE/TC6G+tdV+7ENJb+a0VjFVUo472OC6E5deSzqa/r/shqgC7OzcUdUMHJCfbvoV5cj3XU1P6iHJmyFiEpMG7tUI1BWir1JjU+zobExCwbWHYyHpFG4SQiRmANxqDmgLVZGhQCENCsENkOWfGqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyw66CJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyw66CJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2941F00899;
	Fri, 18 Sep 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744560;
	bh=N+JWiSDFunzUFCTH/f0pJTTjhja0GHkiOsC71uOEz5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyw66CJ8ZRiaQwVH9hSq1T1fLvxLDgaaS/vRGwRLCzKyJdfQ2BLDCLDplJ+T7VG34
	 vooBozBGyQtkaiFHqpMLseeiI9oCwJ1C0o9UXRtYZHsiUbzANFtSvcExxHJMuAh0OQ
	 30sKNuMlU5e4mou9L2VSdVZzYh2pk+dhvZz5AMN8lvYV+58vOTAGFoGY7fdra/BuJY
	 JDovFy0mLDLg8AGbGAzXYrAqx+E3qv9P5hvpcaX+ad3uRWxY4C59kBk75BSBDkoxx7
	 2ZXd9htbTkgcWKdhsxpM14VD0BpixJoHFZPOkRei7g21qjo11MgVFDBG3MRco3rfgx
	 IjC7xQQ11FXaA==
Date: Fri, 18 Sep 2026 16:15:56 +0100
From: Simon Horman <horms@kernel.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org,
	syzbot+6cc37aba98dac721c415@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/sched: act_ct: don't WARN on benign
 flow_offload_alloc() failure
Message-ID: <20260918151556.GP51261@horms.kernel.org>
References: <20260915150816.36487-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915150816.36487-1-ngocthang2710.1999@gmail.com>

On Tue, Sep 15, 2026 at 10:08:16PM +0700, Nguyen Ngoc Thang wrote:
> flow_offload_alloc() returns NULL when the conntrack entry is dying
> (e.g. raced with a conntrack flush) or when the GFP_ATOMIC allocation
> fails; both are expected under load and neither is a kernel bug. This
> path runs from softirq on every committed packet, so with
> panic_on_warn=1 an unprivileged user can panic the box just by racing
> a conntrack flush against a `tc ... action ct commit` classifier.
> 
> Reproduced with a custom repro under QEMU: a small, fixed set of UDP
> flows through `tc filter ... action ct commit` on lo, raced against
> threads flooding bare ctnetlink CT_DELETE (flush) requests. Hits
> WARNING: net/sched/act_ct.c:437 (tcf_ct_flow_table_add(), inlined
> into tcf_ct_act() in this build) within ~15s on the unpatched kernel;
> same setup is clean on the patched kernel. The fix itself is
> behavior-preserving: both branches already did `goto err_alloc`
> before and after, only the WARN is removed.
> 
> Fixes: 64ff70b80fd4 ("net/sched: act_ct: Offload established connections to flow table")
> Reported-by: syzbot+6cc37aba98dac721c415@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6cc37aba98dac721c415
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

