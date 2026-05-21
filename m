Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F23C37AA
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363883; cv=none; b=vCoVcCoXAp/4dCp35Q8+l7UjiEEUY//78LwceYFiIIDcyEVGyZBSwKFRYi5qSUfxhoIwDSvlH66/p3OxbsaiJGcRY/oYJiP+N2W9GCgr/zY3/ij7XnPbvpQPWx+NBzWCEkyzaAojtudA06E5fmowGxw9BevUJTA7lQyZgbIuqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363883; c=relaxed/simple;
	bh=SSqTKybdilJla6LSsbey+ec5pEya8aICrXNtQEI5akE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjP8wOLnPU2Atj0o3MXvG3sYh+FUdyw+aq959U0D1D6AnDMO9Y5qwffhZQvEHo5IvYgUWmhpYf7fYufoUmh1SWHpqfu1sLUko9MFyFJVJjURn0BMt+t4yM6eo4bD/1WL/9YQl/v2pPTOVt8108hBmLvGOJGAm92oMp/X6zTTIVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB87bd3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB87bd3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E61F000E9;
	Thu, 21 May 2026 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363882;
	bh=iNnbfmHcW0NGw442nS2PoBdygOAsR81qw2FLANfMcw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oB87bd3FrVyGHG1FvoPIaplTVUD0KiT7JNCyKbXKCLK2vTlz/ihHKzxOM9mbbYTfm
	 0WLP/u1QMEFP10NPXnKWdnxeK5f+rlfTQt30rp24wnKJFKY/374651ypMQkXwPYEkl
	 SEn+lB/CnsiIvctF8CIrzoz6Sy+z6hMckJTQBla3gdzpZVS8GczProzYBMPCuOC38c
	 v+QXnA5N/fs0dnC8cWJkoioAWmWFn9PstLu1KFobKmhsqxk++uc41z4YLbCZS0XJfe
	 hEF4N0YGzzPbNuDNxzr/o91WnzCvBYgJpEx29eJSGV4GNtyJbgvRe7s4PukWddTfBJ
	 JlAO6J/A3uOVg==
Date: Thu, 21 May 2026 12:44:38 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1] ixgbe: LinkSec deprecated macros cleanup
Message-ID: <20260521114438.GD1506108@horms.kernel.org>
References: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>

On Mon, May 18, 2026 at 02:36:11PM +0200, Jedrzej Jagielski wrote:
> There are some unused LinkSec macros. Get rid of them.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

