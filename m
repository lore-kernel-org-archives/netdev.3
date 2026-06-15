Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184B3D565D;
	Mon, 15 Jun 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514885; cv=none; b=Gl3wua+HPA4rdmNEudXIDqbiaqntUAORlPS5+jzNx4oiu3eVlowfDODwz1j6hYX/3cDKd84euxYwILxz18jTFc//mjd8LasDwgZnb2zG5dArjRy35DY7J7C8e0iJnn6Whc04LprfmElJR+wk/+E9VH4Jh6H5NCY5SssOYPbrCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514885; c=relaxed/simple;
	bh=wkz4FFL7OPRkyrk0cKyMyUmdElorOFsbk1NV7paqqso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoIK0NaPHMmPovhE1xag/pajnYgQkFIct5/j5yNfTqRt/7DMqydw3v/wPoY1Zbr7UCSEexrU9zPXgobk9Y2qJxIVS8mI0XwZzFeJHtnTzB9p1wYrzWKHVLZSVXkibwaFIWceaAl+XVaSqozlUH+/pCaQHNQgcThjf178Cnq8c0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLRz3NYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLRz3NYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CB61F000E9;
	Mon, 15 Jun 2026 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514881;
	bh=Wxw8XbVi8IuQOABGxqKZaz3Z/SsxgEmI1ANtbVdermI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GLRz3NYWz5FHnn0OngMeUVpZB0iikR9WoOAQmth85ufnNEtXVoZ0itlNVrRWn7FVM
	 gWsR2lPbgIEJOi/ojsJc2hxSFGqQxQNeBxKxZTomtoCB4XftRs209TU8AR2s2dREoV
	 0Ogxz/C8g7tLJzgINwU1nfiUbL0cEdR6zS5JhjgOyPKpmDVKQo8C1UyNQYqSVlgESc
	 DP357enlJSZEf4KT0LljAhoQ0NHayMzS+zuc26mhkYePEhXMUbmswOx9+twYQpurtM
	 q2w0ToVX1NilOk1kSHcLAkZW1VPdU/GwRAEBCdK/JD/LTpJDJ+CqPGI4U1hgKiMUIE
	 JU64YZ9BT5rLw==
Date: Mon, 15 Jun 2026 12:14:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	johannes@sipsolutions.net, corbet@lwn.net,
	skhan@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
Message-ID: <20260615091436.GP327369@unreal>
References: <20260603162943.2406080-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603162943.2406080-1-kuba@kernel.org>

On Wed, Jun 03, 2026 at 09:29:43AM -0700, Jakub Kicinski wrote:
> Initial wave of AI-generated fixes was mostly for core and protocols
> we care about. But the number of irrelevant driver fixes is slowly
> increasing. Add a section of explicit exclusions to our maintainer
> profile.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 28 +++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index ec7b9aa2877f..cc4b5fa3b5c1 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -272,6 +272,34 @@ the case today. Please follow the standard stable rules in
>  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`,
>  and make sure you include appropriate Fixes tags!
>  
> +Bug fixes
> +~~~~~~~~~
> +
> +Unless explicitly excluded all bug fixes should be targeting the ``net``
> +tree and contain an appropriate Fixes tag.
> +
> +Obvious exclusions:
> +
> + - fixes for bugs which only exist in ``net-next`` should target ``net-next``
> +   (please still include the Fixes tag in the commit message)
> + - bugs which cannot be reached, e.g. in code paths not executed given
> +   current in-tree callers
> + - fixes for compiler warnings and typos

If you decide to resubmit this patch, could you please remove "fixes for
compiler warnings" from the exclusion list?

It is quite frustrating to receive a compiler warning originating from a
different subsystem after the merge window, knowing it will not be
addressed until the next merge window (around eight weeks later).

Thanks.
