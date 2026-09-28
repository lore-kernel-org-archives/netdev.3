Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175E17557E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560883; cv=none; b=jJakKmQZBis0y5TqYHcMewWyWdmDJDYfrRKAfe6kE6R3cN2bG1fvdH1nKiow785QV+EfhsnA6YeJjDndRzepyK46ExSBEYfKk0i+yUpkJOTtumvYY7PG6WlBoiBshq7QfDaD7EBvVNGmB81dPFkkkaP9QXd/74MYtTYD2aFv8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560883; c=relaxed/simple;
	bh=27Bkwwg1zh62S1iMd+UrvEP3a/Ioa7lc6kP3mY6xMMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU1Eret88/5MPlYisOtYYM+OfBTNNeBne7nCHNGSUXJKz5M/HdE3V8rLK9l8GA9p9UZ4a2ehJGEb5KXXqrJWxi6NqzOsaWtA+ewKphDb7fGjj/HMkXjjg2SFQapIOhjm/28rNjCKvafvxD0+5zRxyDJeHZ8RtPQDjq+vNTOFVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W27vsFc6; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W27vsFc6"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=27Bkwwg1zh62S1iMd+UrvEP3a/Ioa7lc6kP3mY6xMMQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790560879; v=1; x=1791165679;
 b=W27vsFc6dZZz0BcQfbPAWoPTV8xGG+ZWj/n+rKrjnbx67iItYNTRdl1eIR4Y+5h2o3RpM8x2
 E86DoWvF9CQngXI7e6Vda3W8yGwFE1yfdmJju9hZ5X3JO9LN+/XjfrpsQrBoo9E9emp+ladoUWD
 f4yVm7HFVOKj3vWJdQLnIovQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 000c2c80a70fc180;
	Mon, 28 Sep 2026 02:01:19 +0000
X-Mizu-Trace-ID: 000c2c80a70fc180
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 10:01:09 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next v2 4/9] netlink: specs: devlink: fix
 resource-scope type
Message-ID: <arnKZWLvLzHwPBOy@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-5-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:07PM +0000, Asbjørn Sloth Tønnesen wrote:
> The correct type for resource-scope is flags, not enum:
> 
> - DEVLINK_RESOURCE_SCOPE_DEV is _BITUL(0) aka. 1, not 0.
> - DEVLINK_RESOURCE_SCOPE_PORT is _BITUL(1) aka. 2, not 1.
> 
> This patch also removes "enum-as-flags", as it is now redundant,
> these changes does not change the generated policy.
> 
> Before this patch, this generated devlink-user.c function call:
> devlink_resource_scope_str(DEVLINK_RESOURCE_SCOPE_DEV) returned "port",
> not "dev", as it didn't use ffs() to convert the value.
> 
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/devlink.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 1de0daa0f921..4706de628392 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -158,7 +158,7 @@ definitions:
>        -
>          name: entry
>    -
> -    type: enum
> +    type: flags
>      name: resource-scope
>      entries:
>        -
> @@ -903,7 +903,6 @@ attribute-sets:
>          name: resource-scope-mask
>          type: u32
>          enum: resource-scope
> -        enum-as-flags: true
>          doc: |
>            Bitmask selecting which resource classes to include in a
>            resource-dump response. Bit 0 (dev) selects device-level
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
