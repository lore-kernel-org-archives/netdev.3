Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB72475CE
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986123; cv=none; b=VJ63L+56v4no9Ui+KsN3S2u1CIymc9/y54yWZySYDwjYqJawVfi4fkV7ZH0XytouATGwxYaXEoBZkTRtN5lRK34dbd0B2UfoNC9Svpxs293bfYmgCxxCHcyWI9KIUlVDDfZ8Usw8b416q1psJBNVJt3PUz6CUs1wvg6BI9RZhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986123; c=relaxed/simple;
	bh=2bjVbs40WRyxq2uW9RG6O2iK8r2jpgm9XvuKSw3n8m4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxWpdNOMOJYq6RXmign2RMebVSoDrBxt8gDoDmy5raAweMh0eEi2SdSkK8zFEzl417gsJGbIobeyeJez0T0zAd6DyjNDwfEolrDOfgrvnbFkoYZZqCKtKgH7hbrnA/Ecb5/5cCBrfWWaF/JnIRhImoSvsji21LqrpVDxi3tAc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAvhpBr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAvhpBr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3EDC116D0;
	Wed, 25 Feb 2026 02:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986123;
	bh=2bjVbs40WRyxq2uW9RG6O2iK8r2jpgm9XvuKSw3n8m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAvhpBr4R0yal4NAaP2PBQriAxv7M8hCsIJSzrcltyMFvUS4nPGb3DeGiltWBNSvN
	 SqgAwPITyXIcq7aksxHKIeIx3PMx5usMLdnUBKzjLYTsQvg7PUEVGxiGVMwnpj6Lbp
	 02Gcm7tdfZ2bpBSKEn4fSuqwRe9zGBlqOYjRHO9QWlXaUMw+shPEKnNofn2+VXnANb
	 hGSg3bXyKpwCfvkVk6EZ1R5MWGPL6+2KTmlFCCCXBaoQMODbY7wHVeBAsdBItCMH1V
	 KmkUIVAstwOaqP8E+p7L9gbA4zr9Wf3zRXgIXXprgxM3DEEEa/JrbSO+DuRUbfaxvG
	 RtYKY02nTjMAw==
Date: Tue, 24 Feb 2026 18:22:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, skhan@linuxfoundation.org, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 przemyslaw.kitszel@intel.com, mschmidt@redhat.com, andrew+netdev@lunn.ch,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 daniel.zahka@gmail.com, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 05/10] devlink: support index-based lookup via
 bus_name/dev_name handle
Message-ID: <20260224182201.690c9894@kernel.org>
In-Reply-To: <20260223145557.248679-6-jiri@resnulli.us>
References: <20260223145557.248679-1-jiri@resnulli.us>
	<20260223145557.248679-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 15:55:52 +0100 Jiri Pirko wrote:
> Devlink instances without a backing device use bus_name
> "devlink_index" and dev_name set to the decimal index string.
> When user space sends this handle, detect the pattern and perform
> a direct xarray lookup by index instead of iterating all instances.

Transient build breakage here. I'll also send out what the AI found for
your consideration. I haven't looked if the complaints are valid but
hopefully that'll let us avoid a repost.

../net/devlink/netlink.c:203:23: error: use of undeclared identifier 'DEVLINK_INDEX_BUS_NAME'; did you mean 'DEVLINK_ATTR_BUS_NAME'?
  203 |         if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
      |                              ^~~~~~~~~~~~~~~~~~~~~~
      |                              DEVLINK_ATTR_BUS_NAME
../include/uapi/linux/devlink.h:414:2: note: 'DEVLINK_ATTR_BUS_NAME' declared here
  414 |         DEVLINK_ATTR_BUS_NAME,                  /* string */
      |         ^
../net/devlink/netlink.c:203:23: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'const char *' [-Wint-conversion]
  203 |         if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
      |                              ^~~~~~~~~~~~~~~~~~~~~~
../include/linux/string.h:161:44: note: passing argument to parameter here
  161 | extern int strcmp(const char *,const char *);
      |                                            ^
-- 
pw-bot: cr
