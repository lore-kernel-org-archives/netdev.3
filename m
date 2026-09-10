Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179122F9D85;
	Thu, 10 Sep 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003338; cv=none; b=suzxmOa1GWnq8xINbIXopvcPg+EvKB6WjMXlwqWOOZNmOcU/Drc7OknzRUHAZcO4+ovRqfKb+hfgNjUT3D//T2aVm8/XPpTL6YUKrD+/GCftkc1UgGiT55S11WYyOhtNqhj+pn6huteAziyBX2kRPEDhlzTufnKMBTdaHETPkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003338; c=relaxed/simple;
	bh=o866puzNqKXX80v2Y5Be0rESlsAGz650XfnH8euEPF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol/X8ImGKiOZFu/rUF9HVE4I6Elg2qPkIFw5E4IuDONba5S2nrCBBlJ8/03psE+ARS2UsLvATvmmVOqNdWwIWzoLyRCET6lFZuI5zZrbhJeav0zyt2qih0ElDv/Vot+5xrtOu3XaZm6y7XmTczEVeo3tHyZkuzSVoP3gfhFYC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7fn/cUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7fn/cUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022251F000FF;
	Thu, 10 Sep 2026 01:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003336;
	bh=vzT+u1w/0aAO79X1wMzrhz8chbV1WMmQcdPpLeItyuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e7fn/cUFrL3LfJFqQSD62zEPY8rTJR8H8k2zfCaxc16Vw3/WX4/8pqNkRmZ0dQu22
	 o4TqU4YGBwlHA+rLtfs8XrpB+7mbUJKvDK6cEjnH7K/g4TxfqnTZMIUd2qIuVklNWL
	 rKK7wI/US7aAxE1LPUeXltLDoc5weJPkii1WvxtIJheEl0aQ+MXkpjeFX/pAjbtM8X
	 W4g+SIeyFKQ7AA8NfGnhfbtgUrn5zt2eSe25AZZqiHAfAHS9CzGw5J3C7fYEKiZjHG
	 yo0/jp/lPKNVVsWjaxY1D5YMyzWMTTZAAAn8ijEGO+ofRhK5r4s2fIgDMbHpRF1I7i
	 Bn4gmI/0KIktA==
Date: Wed, 9 Sep 2026 18:22:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, sdf@fomichev.me, kuniyu@google.com,
 linux-doc@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next] net: run netdev work under the ops-compat lock
Message-ID: <20260909182215.14b5d94d@kernel.org>
In-Reply-To: <3e210ef7-f807-4de7-935d-09441710acbd@redhat.com>
References: <20260904180058.3803849-1-kuba@kernel.org>
	<3e210ef7-f807-4de7-935d-09441710acbd@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops, looks like this has been sitting in my outbox for some reason

On Tue, 8 Sep 2026 13:26:52 +0200 Paolo Abeni wrote:
> On 9/4/26 8:00 PM, Jakub Kicinski wrote:
> > netdev_work_proc() took rtnl_lock() for the whole batch, forcing
> > even ops-locked drivers onto rtnl just to run their rx_mode / ndo_work
> > callbacks. Take the per-device ops-compat lock instead: the instance
> > lock for ops-locked drivers, rtnl_lock for the rest. That's what the
> > callbacks already assert (e.g. netif_rx_mode_run() asserts
> > netdev_assert_locked_ops_compat()), and non-ops-locked work
> > such as vlan ndo_work keeps rtnl, since its compat lock resolves
> > to rtnl anyway.
> > 
> > Without this adding more uses of ndo_work, for cases which don't
> > need rtnl_lock feels like a step back.
> > 
> > We can drop the comment about the extra ref now, with the relocking
> > it's a necessity.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> Dump question: can the `netdev_work_list` work list grow significantly
> under non pathological conditions? netdev_work_proc is now going to
> acquire and release the rtnl lock n-times for non ops-enabled drivers.
> 
> Would it be overkill trying to acquire the rtnl lock at most once (i.e.
> keeping the netdev_need_ops_lock() and legacy drivers on separate list
> and process them accordingly?)

I haven't seen any evidence of such relocking causing issues so I didn't
want to complicate the code. We have a similar situation in a number of
netdev genetlink dump handlers.
