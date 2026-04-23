Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783D3AE18F;
	Thu, 23 Apr 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970534; cv=none; b=BFPePSKwm0Dr5gLxjK3oImPs/3Fgyda0dfzrxJ5mEQ/Q/AhtC5lfP3Sb6vmB96EPok4zEzSU63TmsTFog/S95hiNxKbAhYPiPf5VUaZkHuMB3Jsc56o+0jSAsnrthyAlRgE5I72aglWTcSufbFpR1KR4nSciBb30r6+E09qyndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970534; c=relaxed/simple;
	bh=4yoTlqQgbbVE28AVWHdC5lL1x5os8T5h1viP5QpkKlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVQdfrqF0XX/4lYcVPhKkqcN5u7xYBS4uxTUasYcljcfVtYs8YgO2boTaPI1yZvBVVVi7sn85g7OiE0UNmuwOiVf9L2T8j5S4gmxlKkRoWdjH+My6wpI6fdQQXAW02EKhpqPOtn0hlJeUCK+qekrv8qcykNHHTgYwXNri8IutMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ9yjLNh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ9yjLNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36726C2BCAF;
	Thu, 23 Apr 2026 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970534;
	bh=4yoTlqQgbbVE28AVWHdC5lL1x5os8T5h1viP5QpkKlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ9yjLNhzeNgz5LnKP7c5B4CVVdkDK1FCMsDtp50OIQeKLf5otwlCPfWdgWSPycw/
	 XTvQQiA9S+ZybzC9eqC7oQzsM81L7y6MNR7n4RHDo2QaO/5k9PX7EV1EEAok+xCXA+
	 f3xysYpsbXmlJ00lhGseIfBYTZq0JzKgi7HG5BkJ5ydr9JUbYQPm6Gid/Hg6hSDHz5
	 liAN2JVUnjU+EY4FBqBhoJoIltNPHvSjLCUCMvKUosbMN6Kk79SCWlApAasPYFpayE
	 JUE8mai8Fd4DutEfbulAEx6LvAf6+32ED2XpeKNOTrex27dKq87SQDqapgCZUOuE1Y
	 Qv/sCT2faOyhQ==
Date: Thu, 23 Apr 2026 19:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] iavf: iavf_virtchnl_completion: drop duplicate
 ether_addr_equal() test
Message-ID: <20260423185530.GI900403@horms.kernel.org>
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260421111236.875379-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421111236.875379-1-vinschen@redhat.com>

On Tue, Apr 21, 2026 at 01:12:36PM +0200, Corinna Vinschen wrote:
> This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> waiting for response from PF in set mac") introduced a duplicate
> ether_addr_equal() check, so the current code tests the new MAC twice
> against the former MAC.
> 
> Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
> ("iavf: fix MAC address setting for VFs when filter is rejected")
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Added CC: stable@vger.kernel.org

Hi,

This feels more like a cleanup for net-next (without a Fixes tag)
than a fix for net. I'm missing where the bug is here.
