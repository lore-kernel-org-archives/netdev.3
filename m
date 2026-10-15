Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E44E325D;
	Thu, 15 Oct 2026 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059206; cv=none; b=CdD6icpxugmIAe1XQiooN8gq/a9NSe9RyraEgfhfxJE1pLNtjg45dheiHFYHd1tHNzSUfpXqL0GbmzPhlN2akaGRPm8doCAsvQxn3NlgqGNqezD/qCDyAcKaWdZ3JN55CA750I7164CH2M0/cp1XXBCVFQUFi7O82NfMbMzixMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059206; c=relaxed/simple;
	bh=b4+7BckYp/TslExRpb889Ix14EnhYPDMnBCNXxtB9JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYaxYRu5HTE+vEwh40tgQ4gq9cH53/o+LbMfMvRFJyEjd9Ivg2k3fyUYhXT0L9vhLIIeL0oVgXfErOlvMsaaK151a3dfSO+sHa3fAIfe8WdCHSeg0Q52JXwS7hadd4UJIBixMlpsmdin/gzupuanK5IwTtqWPFkOkK73M6YgbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Q8DfvsDY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Q8DfvsDY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WAbtlqKuP69hiwARgiPCIxV+lrBvAR1z924vTs5YTXo=; b=Q8DfvsDYll5Eyone1xL5dVJQBo
	Px63lopMx5uEVx6qTv8MIL32+9o24q7hWPvSHaNqVrAFgS99t7ZBnjMgKQXkLE5pocWUyvafejgGQ
	ArDAPGml6vnbiExm2zQVh4DJRD5ogJ+rkfhZWX4zRZQamwm0JwK4r0bjYdDE3fe6ZA0Mp8vlTH80S
	EByV1LaJZf/YrGnnoGes3rfqK4mnjSM15F9CyFC/fFVT6FV7JxJ1T0qOG3/eW52MQzagaAXOIyMwM
	+yfWUVe4AwsmFFxG567OM2EGE4WHVPzu732FtCgnDghX8oaA7zibMpVf/earPL9GoilmbYSdNrufN
	HoZBDGTA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHISd-0057Nd-2D;
	Thu, 15 Oct 2026 10:13:19 +0000
Date: Thu, 15 Oct 2026 03:13:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] netconsole: remove unnecessary target
 refcounting from the netdev notifier
Message-ID: <atCkMJcghkV7DD4S@gmail.com>
References: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
 <20261012-netcons-fixes-next-v2-2-ac8ec4c62edb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-netcons-fixes-next-v2-2-ac8ec4c62edb@gmail.com>
X-Debian-User: leitao

On Mon, Oct 12, 2026 at 06:03:44PM +0100, Gustavo Luiz Duarte wrote:
> Since netconsole_netdev_event() holds target_list_lock, there is no need
> to also protect each target with netconsole_target_get/put()
> refcounting. There is no way a target reachable from the target_list
> would go away while we hold target_list_lock.

Nice. I have never thought about it, but you are correct.  The
notifier's get/put never protected nt at all.

> This is similar to commit a6d403ac9689 ("netconsole: remove
> unnecessary netconsole_target_get/out() from write_msg()").
> 
> Since this is the only remaining user of netconsole_target_get/put(),
> remove those helpers as well.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com> ---

Reviewed-by: Breno Leitao <leitao@debian.org>
