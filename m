Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E97346A1D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774655240; cv=none; b=RlktPZfwWb8DedNrwYoWeGAtSpuMGE3tkPjXr0CccnUN+iTfLL3h+XhizcuBQMeIPQ6HeDtF0PfMvhYqoIiwbmtpxcTNi8FAeh7SQdrCw/AxV6BMbTOveYvUA07x0TWPgEawfiG/J4WnDNHxLbz1zu1WP4bOhHFZX9LsmNEXr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774655240; c=relaxed/simple;
	bh=LJC6boXcVhCOgdtGYeqxWCvOrumqAszQh6+n3gXpp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2CopvTfesA/wxjdXByOrV6yHoZYowiPqXdsZX96klWKDVlR33xx/1fUiCTeD5giUv2b5AS2tlCdZTq6iNa+C4YJXoC0AnSYkbDlYTMSp7HjVV9ZjiZA6/dXhQfWoDaVYkRiV9wKwwJbFSkVlijDa77800VILcUqSjNGabRZrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km2qaZOB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km2qaZOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5A4C19423;
	Fri, 27 Mar 2026 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774655240;
	bh=LJC6boXcVhCOgdtGYeqxWCvOrumqAszQh6+n3gXpp+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=km2qaZOBKVgNrSzyi1afKAHfByPv2flHHCdCWRdIpAQYPxYvE2C+GMSKp5spf+21s
	 6NVoLUMYoVLr9HU9okRXyJoZW1qzcWnQGKy0CcV/YsyjRKtFAdzGEC3K7Qnn/HEiI9
	 wfhf20Rr5klNZmdq8/X5BwVXTayxGCVeWGF0oyjk9lW3QkfVb0tVHDSMgzhNLwoqQ3
	 WWRNU9yNyiLRVZA63p+1ChWhOyvWmturIlJJxB3iMdfuOMv/ZBydBg5Dk1SodZQEFv
	 RDdIYZ93jtZq8qHj9tzybuzIkVr++WgjrPpOAo15epn1mA4fbtJ7tFSf/A6BNauO0F
	 h31Z3ot0FVk1Q==
Date: Fri, 27 Mar 2026 16:47:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 <edumazet@google.com>, <horms@kernel.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>, "Michal Schmidt" <mschmidt@redhat.com>
Subject: Re: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
Message-ID: <20260327164718.72bf4b65@kernel.org>
In-Reply-To: <f930e404-412c-46c0-9e3c-feee4d3c70fb@intel.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
	<20260325063143.261806-2-przemyslaw.kitszel@intel.com>
	<20260326143808.1fd69825@kernel.org>
	<f930e404-412c-46c0-9e3c-feee4d3c70fb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 08:42:47 +0100 Przemek Kitszel wrote:
> > If we are worried about misuse we should instead add an accessor
> > for "individual" (better name welcome) instance and WARN_ON()
> > when devlink_priv() is used in the shared setup.  
> 
> that would require the same amount of code as this patch (curr ver)
> has, only with WARN_ON() instead proper value (IOW: we detect what
> developer wanted, and give them big warning instead)

I guess I don't understand why you're so certain that you know what
the developer wanted. I'm of the opinion that the "individual" devlink
instances should not exist at all. Y'all want them, and claim to have
use cases for them. And yet, it is somehow not valid to get their priv.

