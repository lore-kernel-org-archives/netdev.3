Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB03CF056
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261198; cv=none; b=GLliivGzTdNiKiTy9PbxosIHvfWu14mm1emrG8732yw0Ui4NZyFuqBX0awWwrQOvibVtve5kuXcZzs3twwuCHknJOPp1ck6MiGVEcHNBdcjIzU0lxZa8NLkg6VpxsAtCQGmkgwtlonCa0e9sa9RHXcJlxBcPn2pmDN5pDeKQEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261198; c=relaxed/simple;
	bh=RCRSadFhOAVPdCR4RHEUrMdSFUtCXm2C/VxKppUJ1dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji+g89144rKNl8jM7G6MtuHnnBVGaZyAKvXmn0i1rth3ULBrbyBWdwzpvvY0vSq06DovoVVUI/KhWthIHC9DpEJ0e0lPd468TBskFlTtrS72nzvh6DztH4jheih3ry5ApaWt7ja510zBKv8ToiYON19cEK19Pme9g7bRAeuhtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR6N8cDO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR6N8cDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771BCC19424;
	Wed, 15 Apr 2026 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776261198;
	bh=RCRSadFhOAVPdCR4RHEUrMdSFUtCXm2C/VxKppUJ1dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR6N8cDOLY8BNji8pLn5aJnDiu0FUqYZcSoBwLclSgUQIKBUeCqG4+l8b9AVwSfxu
	 VyF39jGBl3fkwI4E+zZ2dm1XLv3wU6+esDspW4Hbh7AmndYCWB7CmRVRbGGFzJ7Qs/
	 OwBoPtaCLvAZDe3fcQLyX6KmXGyFNJtSDNSaAgwFmC6/QWCfLZmuHnk/LT4q3WFa8+
	 9RXWt0CdYuUv45esrtyb4GQtqSZD2+dYW77PrWXrgIkBs6O6WaJZMOH9yXbl0164O+
	 RhBy0NxeCzR/HoXCmCv9M+MFOJc2qc92Oc7Gu3G8LSc9m9dIMuqqpspk7OLLLMG8+p
	 Apm0VmFgQMQvA==
Date: Wed, 15 Apr 2026 14:53:15 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH iwl-net 5/5] iavf: return 0 when TC flower filter not
 found after qdisc teardown
Message-ID: <20260415135315.GK772670@horms.kernel.org>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413073035.4082204-6-aleksandr.loktionov@intel.com>

On Mon, Apr 13, 2026 at 09:30:35AM +0200, Aleksandr Loktionov wrote:
> From: Kiran Patil <kiran.patil@intel.com>
> 
> When an egress qdisc is destroyed, the driver proactively deletes all
> associated cloud filters to prevent stale hardware state, decrementing
> num_cloud_filters to zero in the process.
> 
> The kernel netdev layer is unaware of this implicit cleanup and may
> still try to delete the same filters individually. If the filter is
> not found in the driver's list and num_cloud_filters is already zero,
> return 0 instead of -EINVAL to avoid confusing upper layers that
> believe the filter is still offloaded in hardware.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has some comments on this function - which do not
seem related to the logic this patch touches.

I'd encourage you to take a look at some point as a follow-up activity.

...
