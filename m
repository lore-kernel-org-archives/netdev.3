Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374571C3F31
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561090; cv=none; b=QOODS3uKIZjxNOKseIQtdZgbCK584h838IS1mSosDhkwOnwDVoxhjT9fQ63PoVpSqP6G2Wpar/meTAqaaY7wyb1anuADkUDGU2iU34Be+Mm6hH0630m3NPHULBdIVSvTToU/fw+bKRDDUMchCgbKoJbZVmly/qN8I4k45vD6+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561090; c=relaxed/simple;
	bh=AKkd3ppFc84ObBdwBC0HhQtk41jJEhFN8N8H316ksdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emWkvpvyxp5kqTYMTLO8o1mXsuwxSgum4BYL4bzLE7QaonTJrSMhgSn6kM+GwfGtuN3/d1yztAcO7NZ33/CGxCpyjKFo2tx8bUhrpTU3RYZohx0qcQ5Y2XOVwvYF9JbcAYEPPZkbQadGzYqFpo6beyy+k0qRWZKvn7XwXvZ2Ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxUuXfQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxUuXfQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F649C116C6;
	Thu, 26 Mar 2026 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774561089;
	bh=AKkd3ppFc84ObBdwBC0HhQtk41jJEhFN8N8H316ksdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxUuXfQ76qYfBkJJ9Y9lfUH3N5eSzipqbgOJ7ENaF5deO8NoA2r68B/lPWt3deX21
	 O7ioay7Qs6A5Yk63Rhzx/y2BOJd6NcmTyPP4jzENgsu9cl7eqGfQP2X8kvee7fui2l
	 EMZrXlQXqPKhY8/sDRe1sFfpW03SNrPj39lMQkNlqxevn6REFYh4ihHLQwoB8mGrIU
	 X7RLR60SPriBcXfdU6QZCYoG8lBlN3rGYECTRqnlqlJJZBarq0iLe7fbI4gB2h/SUU
	 m+68KmCwcmeZ7bfhG40d1qcS1OrqG5zynoLRubvHTpyYv6ILSa+nASkZV63Wt275ZA
	 nxZznDuKHL5Pg==
Date: Thu, 26 Mar 2026 14:38:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net, Michal Schmidt
 <mschmidt@redhat.com>
Subject: Re: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
Message-ID: <20260326143808.1fd69825@kernel.org>
In-Reply-To: <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
	<20260325063143.261806-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 07:26:52 +0100 Przemek Kitszel wrote:
> Current API makes it possible to access shared devlink instance's priv
> data:
> 
> 	void *devlink_shd_get_priv(struct devlink *devlink);
> 
> but it is easy to forget (especially during rebase from "before shared
> devlinks" era) and call:
> 
> 	void *devlink_priv(struct devlink *devlink);
> 
> which even has the same signature, so it's hard to catch the error.

The implicit conversion may make things hard to reason about.
Are you sure you actually mean that it's "easy to forget" or
it's easier for OOT transition?

If we are worried about misuse we should instead add an accessor
for "individual" (better name welcome) instance and WARN_ON()
when devlink_priv() is used in the shared setup.

Or add a third argument to devlink_priv() which will pass the size 
of the LHS ptr, and warn on attempts to access priv of the wrong
size?
