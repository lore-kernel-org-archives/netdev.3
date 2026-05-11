Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23612313527
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513248; cv=none; b=LtBAxVl2jEweHE8fIaNthwY4DxljvQ4D/whnobe7Bsrpnpa9Ja7nU0wEtjzHmY+8fdJnL3sesDvYT0S7CYcBCSe7/N8tjUcYjBRh9XrmU8GTI9yJBYW2uLDIOiEItzQO+tC7cpLAM85Cp+7O3pWPm5aIG42GunwPofyje3pZ1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513248; c=relaxed/simple;
	bh=lPTcpIsJwfOPf9wIvYhMTgk0EC/36bqpraey/F/PXmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Julv+fBpRhWwOTsZm62Aqg2KBMYVFP3EbuniBiH7iKjtJ3kim3q/mMq2Pb70DIbWVIvOFe7o2FjrvCM29t7Ywdj1V2PPP00lNCYvJ72mIWs4SdXZm4B5ZEDMY7mLJVGuVxYAVuoRUUM7l/PN4bWEH9GjuivoHsc3ZxXvjyYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boEklgmp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boEklgmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925AFC2BCB0;
	Mon, 11 May 2026 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778513247;
	bh=lPTcpIsJwfOPf9wIvYhMTgk0EC/36bqpraey/F/PXmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boEklgmpUgjm3ZGvguW45hRvg6UioP/0VSQjV4B3/HCdc7YkGjfIOBXywZ7AhK3lS
	 oDs/ruDkNRgfXKfuZGHL8eumdvEZHd1Dl3G+uYVTfDrZXf+FlQZ4NtJhEPTDxfCu0B
	 8QLNPTPQoyfrNndjshQBoUj1Eu8uiEG1K8lVNQd+D3qZT/6V5OjqUIjlygMxbkHjro
	 QoPUBsG25piHiTrRel07rlRAMrYqnLC6nMm89woYz5JSzWAKZCTnOh5CaRjU48qMDS
	 zcZt8QxNmhVC2EO7vaGvfZHMhkFoitO/95Qm5wYC34wqVW17RTehPLr8PqV807TwKX
	 GTLBC5VUaymkw==
Date: Mon, 11 May 2026 16:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 1/8] ixgbe: rename numa_node to node in struct
 ixgbe_q_vector
Message-ID: <20260511152724.GA27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-2-aleksandr.loktionov@intel.com>

On Fri, May 08, 2026 at 05:12:19AM +0200, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The 'numa_node' field in struct ixgbe_q_vector shadows the 'numa_node'
> accessor for struct device, which triggers a sparse warning about
> shadowing a built-in object.  The stored value here is a plain NUMA
> node number, not a device attribute, so rename it to 'node' to avoid
> the shadow and keep the naming consistent with other Intel drivers.
> 
> Update all three usage sites in ixgbe_lib.c and ixgbe_main.c.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

