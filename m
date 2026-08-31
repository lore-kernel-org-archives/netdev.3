Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2540B118;
	Mon, 31 Aug 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180878; cv=none; b=EycPzVAAz/vH0qr/3S4LSyicGyCQwc2287KINHB08dPQdveJqajKT3GY4Mdjk2Z3OtZwaGIrSCs/pwHHgXfeSuPf6nn7xknukCYVKIq8/NCmt2rC+pGCVlUXZzVTufOdHEEOQTsN2YN9U0YhGSxGiyuoWJ+WFpyXzwEEZSbTD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180878; c=relaxed/simple;
	bh=0aQ0F01/0zir5XuRaJaV5CRHRBXwGgnlOSZEeGULo2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTq/JG29ry5ZkWrzo3X5LxQxz3+WrhhXerulweEeD60BnMzUU3aOcqlrANKQhLncf6KRuM1xoLMhpPzvYJ0fl+kQV3Rww+mHYn1IL0OL/A4B09wLOmlCILEJv54QnOiRN9vGIXFUSlHyus4TK8bQNymuryEcaJisHQZ4VAK+y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C94D9C2B10;
	Mon, 31 Aug 2026 14:54:26 +0200 (CEST)
Date: Mon, 31 Aug 2026 14:54:25 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Felix Maurer <fmaurer@redhat.com>, Danielle Ratson <danieller@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Patrick Rohr <prohr@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] netlink: specs: rt-link: add
 force-forwarding
Message-ID: <apV5QD3EefKLmrZZ@luna.proxmox.com>
Mail-Followup-To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Felix Maurer <fmaurer@redhat.com>, Danielle Ratson <danieller@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Patrick Rohr <prohr@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260831093458.472180-1-ast@fiberby.net>
 <20260831093458.472180-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831093458.472180-4-ast@fiberby.net>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1788180852307

On 31.08.2026 09:34, Asbjørn Sloth Tønnesen wrote:
> Add missing enum member force-forwarding to ipv6-devconf.
> 
> In commit f24987ef6959 ("ipv6: add `force_forwarding` sysctl to
> enable per-interface forwarding"), the DEVCONF_* enum was extended
> with DEVCONF_FORCE_FORWARDING, however Gabriel forgot to add it
> to the spec.
> 
> This pre-existing issue was detected by Sashiko, when reviewing the
> first patch in this series.
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824103816.40040-1-ast%40fiberby.net
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---

Ahh, missed this. Thanks for fixing this!

Consider:
Reviewed-by: Gabriel Goller <g.goller@proxmox.com>

>  Documentation/netlink/specs/rt-link.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index ab677801cde8..61ebb9a2bad5 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -496,6 +496,8 @@ definitions:
>          name: accept-untracked-na
>        -
>          name: accept-ra-min-lft
> +      -
> +        name: force-forwarding
>    -
>      name: ifla-icmp6-stats
>      enum-name:
> -- 
> 2.55.0

