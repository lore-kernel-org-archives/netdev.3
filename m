Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4273425CEE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704973; cv=none; b=g4vAnW8xst4YBL7IBoI5L6DIQ5Cx2Lg0JaZKGu1TlgG3g5NgE3DUw9kixkz482L3xKW1B2YWG4ixkFNftH6lNEMgfqcverdzinrNy0pN0NtJxFXIHIY75bTAMUSfUITw9eSixkJwFyKsBUkJAvMd2+i0+HW5sQFZ6C53pzVboSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704973; c=relaxed/simple;
	bh=+6XwXCxcdL4XG8HBGHkESHoVKQwE3MJ6bTGvlkv/L24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c24ObzBIg930dlHujvifTZLmxXvpxb8j/XOH/5WpWJLs5QOzqxLEcIEQBXmxWnK5Xo4nFrub9kzwrMcfIK67EUJRKK1fIQl1goS83NpTyamhcrMGY6WYIRHjwzG+yYqPK8VEEy7bOHCizaaK89KzV1ex0afiBC2XFl8isYzxuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3RVYOQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3RVYOQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BE61F000E9;
	Wed, 17 Jun 2026 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704972;
	bh=kPNqD+T3iRSriXn9LX09fTW2rqHtaNypWCtMdCA+UMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3RVYOQZ77bCrremqYoGfcAgBeoI/CL2rojN0F30fLnJXaAJ0Tlva8cI1+iui4z8+
	 P576Cx63mIJZrw7OPy57StQuNksZ4H+mljUuYfA9Jrnq7jjiNVxWv+Xmxye39sni+v
	 z86mat1O/M3VrY2nyyJA7nly3UuEQ27ZKuYwo3quRQROPxFDAELMhf4BYpunB4tQQs
	 LPTYR1XKvyd/aV+SMWG+VPM9AMqyOqOOpiftPmEpXd6OhXD6SurlDL6rGXhhpPf9pw
	 LPaeZ5d+RBo7EG8bTnP8MLqQfBbGBwrVfMCY95rbAxVk++nzpfLh3XmOhzJ8YVlaBV
	 qAndyiCmy6iww==
Date: Wed, 17 Jun 2026 15:02:48 +0100
From: Simon Horman <horms@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net 0/2] devlink: Fix a couple parent ref leaks
Message-ID: <20260617140248.GE827683@horms.kernel.org>
References: <20260616110633.1449432-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616110633.1449432-1-cratiu@nvidia.com>

On Tue, Jun 16, 2026 at 02:06:31PM +0300, Cosmin Ratiu wrote:
> These two patches fix parent ref leaks on errors.
> 
> Cosmin Ratiu (2):
>   devlink: Fix parent ref leak in devl_rate_node_create()
>   devlink: Fix parent ref leak on tc-bw failure

Thanks Cosmin,

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

