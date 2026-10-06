Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6543DA50;
	Tue,  6 Oct 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298757; cv=none; b=ZyXTNg7jW7nzVRp5F4h/MC/uyxH+XV+bERVFZS+AScI+YQoDqTcUUTf2ecIKbaJFMf1txb3o+32LLx87EqWzwIOb6c5brBRt/khOf+6Wku8A/xTqcgOjD228y4bOtfFpyxhvJ7jU7RjqLWe6NGD1UzL8yNd68odj8sdrsHGN6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298757; c=relaxed/simple;
	bh=3TtOgpdNfcERWhvuxkolej/qvi3HiJEgWhC2U8q3FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHqT9ZlzewTEhJ5uHV6a1Aija9yFdNSc+jQbowvNXZbwdOIlV7SUgMe8vp/xFi93yex514CMfP56m3XO69kgS6o6FOdhOGejdG6pQf1kfPbUXEtooYcCvzQczLIxJtzGyMvF+AfODPy1uBNQicOkAm5XicyPfo/Ape696uW6+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/0HoMZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/0HoMZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E251F0089B;
	Tue,  6 Oct 2026 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298756;
	bh=sE9n+Px+EvlVqRxDAGYiyarZl/w2LzivOBIjE9KubGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H/0HoMZ6DqEoU69Pvd5Lq5IzxP1D+5Ti9YNCk7F2ybAvv/GXuH1+90w4ZGXt+qSPx
	 tPf4sOY+30fRtmc2sJqXC1riw8j2ExanYW6sAIyQ0djkdeq0ky8lHGm/9DJ92G2uP5
	 deAREonQ9KU5NbRAJYYIBSTCmFxGOX5T5ZwFC3I8+/93JVUcc4CMZ+yDZyipXLbnSN
	 71CXpbLhYeFU6VjJwQqt0RdZskhVnhuUu6mGSijDt62EwO3v6jTFg58mevpTFC6g8h
	 igXDHYWV279j4lBTmDSj/7yr5KDZWhVLlcSVyFZ3TuTe1I3Ui4Y+2DQGG7vRu4f7Lq
	 Z3kYKjwPC6npQ==
Date: Tue, 6 Oct 2026 15:59:12 +0100
From: Simon Horman <horms@kernel.org>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] devlink: fix devlink_rel reference leak when notify
 work is pending
Message-ID: <20261006145912.GI83879@horms.kernel.org>
References: <20261001042232.222987-1-yanhaishuang@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001042232.222987-1-yanhaishuang@cmss.chinamobile.com>

On Thu, Oct 01, 2026 at 12:22:32PM +0800, Haishuang Yan wrote:
> devlink_rel_nested_in_notify_work_schedule() takes a reference on the
> devlink_rel for the notify work and then queues the work, ignoring the
> return value of schedule_delayed_work(). If the work is already pending,
> nothing new is queued, the work runs only once and drops only one
> reference, so the extra one is leaked together with the devlink_rel and
> its index in devlink_rels.
> 
> This is easy to hit. devl_register() of a nested instance queues the
> work, and if the instance is unregistered before the work has run,
> devlink_rel_put() queues it again while it is still pending. The work
> also keeps rescheduling itself for as long as the parent devlink lock
> cannot be taken, which widens the window. Registering and unregistering
> a nested devlink instance 100 times while holding the parent lock leaks
> all 100 devlink_rel objects.
> 
> The reschedule path in devlink_rel_nested_in_notify_work() has the same
> problem: if the work was queued again while it was running, the
> reference it holds is never dropped.
> 
> Drop the reference in both places when the work was already pending.
> The pending work holds its own reference, so this can not be the last
> one.
> 
> Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
> Assisted-by: LLM
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Reviewed-by: Simon Horman <horms@kernel.org>
