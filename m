Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1544418CB;
	Mon, 17 Aug 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981636; cv=none; b=di+2fBHPcZp2DKi/BY/HrsJna5Mw0F07fc4ubIWl7VYcK2aL1Y3aaHgE1f1R16Os/P34O8pM61U5tyHWjHY7T0DvKhBlb5GRELZ/mBdNkJsn1GXyukv6xcCE/UbWQvZE0nJG/8wJafi6qZBWK0z/2+xs1RPI9J5NwA9C5k+AC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981636; c=relaxed/simple;
	bh=zKc7I2tAQpVjsdrRjSWjQJtM7rQhIdugDbnOTfkCVAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwbsVnIOxPjVIyBWYYLs4R2IzgIBsXJQr4lSgLl5S6/UUFoWK70t2JBvQA+ulJtQxP8LQu9U1ItC12+L3kkmdA2ohJ25FXrXoR667I/6nI6cjGEcYfVrbguyzgaMIEdIfHXMXUZqmXIJllOPj+eao0y5saeV7gti0VpfkZ2o4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEpzfGkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEpzfGkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AEC1F000E9;
	Mon, 17 Aug 2026 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981634;
	bh=CZIiF2oydjY02NIXOc/ImO8iJXZOfmkt+NCPH9NCaok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AEpzfGkIGT8VxtteapnHItaNe3EmFoevWFBQ2q253zVM8+Jv5mj9CA36dAwT+3ph1
	 5UcJVqYX238vOkVHQyhHM7FQaMZVsWTWcNdBq3tufXA/Mt89DF/MhjZepW2iPakIyo
	 v0wbRCvvL3g0kmUK5/0JH63GRr1QrFM/3AuXDcacbRmcXTaIhXorvgRiGdzHSab/An
	 FGGL0yObxdVGdq8qDp2X4WA0FYsgZuXo5IJQeCA2GtH9Eivm3sZNzYw9hVwr1WDJSO
	 OQ99y2cHhknnSU3T30m7CvcVh3uFZGe+f1E+RSrbh9FD31EYqprOl3dyb6zxPX1nOH
	 0BWvcCKWATk0Q==
Date: Mon, 17 Aug 2026 08:47:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, netdev@vger.kernel.org (open list:NETWORKING
 [GENERAL]), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v3] wifi: nl80211: document sta-info nested
 attribute
Message-ID: <20260817084713.7a7694d6@kernel.org>
In-Reply-To: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
References: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 17:12:15 +0700 Hilal Rahmatullah wrote:
> Add NL80211_ATTR_STA_INFO nested attributes definition, from
> the previous binary type.
> 
> Signed-off-by: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
> ---
> changes in v2:
> - Fix nested attribute name
> - Add double quote for numeric enum member
> changes in v3:
> - add missing he-gi attribute on rate-info-attrs
> - fix sta-info attributes order
> 
> ---
>  Documentation/netlink/specs/nl80211.yaml | 351 ++++++++++++++++++++++-

Hi Johannes! Should we add this file to wireless in MAINTAINERS?
Or do you prefer for us to handle the YAML stuff directly?
