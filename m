Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B658248B;
	Wed, 25 Feb 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013641; cv=none; b=H/eZ0LLJe4NSEN8vYARZOESgIMbViFiSLBW4aPxwWBmCZsNB+2HonzlNtbNyQX9HFTM17h5M17PyWKGxsVhiQf49hx8qNPCdZ+r/yd1P/0JyAPrAyBsG8hmC3pcTyGASmrriHcyaOWoT+QBIka3uHexqBfB+1bvRB9FXJSdyqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013641; c=relaxed/simple;
	bh=gF+gbsOsP2a+bkyHv/+PM/bZd+0ScG9VpFXCOvIQefY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS7lEZ6XlechQ5bQtESW5sOJARq3IX/+tfr6CI3u4/mNZuUwfqd82ky1ES09cnoNexj7gvoQZvo61suZVmpwEqtOnJqLnODvW02+YNU86qZfi9JN9EHABxk3Ud2AWCJtCl49fAsqGz8cwPiPv8PD8PUHJVKyD35AsFYszvFdhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DAA164845F;
	Wed, 25 Feb 2026 11:00:37 +0100 (CET)
Date: Wed, 25 Feb 2026 11:00:36 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: net: document neigh gc_stale_time
 sysctl
Message-ID: <2calfxucxhzeofdsuk64se7eiylnzq4l4on44kqdy7nfi6zqqg@3fwehpspkvyt>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260223101257.47563-1-g.goller@proxmox.com>
 <20260224171811.642708aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224171811.642708aa@kernel.org>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772013620422

On 24.02.2026 17:18, Jakub Kicinski wrote:
> On Mon, 23 Feb 2026 11:12:54 +0100 Gabriel Goller wrote:
> >  * removed documentation for gc_interval, as that sysctl is not used
> >    anymore and doesn't do anything.
> 
> Thanks! FWIW we can probably also document gc_interval, since it exists
> (in a separate patch). Just make sure the doc says it's unused /
> deprecated and since when if it was ever used?

Sounds good!
 
Patch available here:
https://lore.kernel.org/netdev/20260225095822.44050-1-g.goller@proxmox.com/

