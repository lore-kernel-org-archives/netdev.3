Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1784CA785
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564124; cv=none; b=DrScRkXfaGQ2Oz0D9qCpWiEcjAppTVQxtmrC7N9BAeVXilqzjKnoYMm6eG3sq4SjIXNPB5CKom2gzlmiKMbemFMQJxgv8pMCJeg/ZLl9Xm39JPZp2HvlYTXeLa8znaIIi4uJlXF/zDVo7qaw1ChBujYfBo/TVP6+Cnvxf2fVSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564124; c=relaxed/simple;
	bh=byYBv472s/KuOPWfNI0IZ9ypqutZDueKdBdrNxbzoNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIpfi0EyJe5020sdH/Kjo8jYjBJOU5oza13mApmZAfeFVjQhNEqMuN8+PXdMM9wtHo6eESHeQxs6XI8pjZciVYDsD7hoEvuFSdfiHMj6CEthZGaLi4fjZmKfvPyEK7qNwUVJydjrDN8d73NjDmd/Hl9nwKXsfq8ss8q5a+5eMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt7xt5ll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt7xt5ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1DB1F00898;
	Wed, 16 Sep 2026 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564122;
	bh=+Y5kA1pp9Xo5m9OKvmsrUgATLxAg0vALJGk4G9J2V9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bt7xt5lllxaiKv/9PCjO9LXNOjaNMM86V27JA+z3A54F9tX+1Rm+/ksMxCxXxtTL0
	 t5ojtB4yQvh/hHAGb5wO4zotggZBzulriIflhdifOX+HrraqDJ4Ch0M4jiEJOQDbbX
	 jfiFK1KCkoWJtlbfoN6CT4s6D2hjq7wKEB09tw6waqeEIhTXLuauPRvZg6GRSCTUI9
	 0xT6AtX+hc0n7t/mlA7QKcboYp1szbBzKKJdz1eatAaG7Ts/PLL4RPLGwZkPPdWKZ+
	 JmPHmo5xqSnRnra+cfYaV66LwcVB3aE8s8p4taZ1DI5pNU/pjtdjEIzhHt+E+BJV4A
	 HADfeyGVG0ABw==
Date: Wed, 16 Sep 2026 14:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix FDB deletion
Message-ID: <20260916130838.GI51261@horms.kernel.org>
References: <20260915125519.3975583-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915125519.3975583-1-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:19PM +0200, Aleksandr Loktionov wrote:
> From: Jakub Staniszewski <jakub.staniszewski@intel.com>
> 
> Correct the logic in ndo_fdb_del() to align with other drivers in
> upstream. The condition was inverted — it was rejecting permanent
> (NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
> deleted, which is the opposite of the intended behavior.
> 
> The correct logic is to reject deletion of non-permanent entries,
> mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
> ("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").
> 
> Also add is_link_local_ether_addr() to the unicast branch of
> ice_fdb_del() to mirror ice_fdb_add(), which already handles link-local
> addresses as unicast via dev_uc_add_excl(). Without this, a link-local
> address added via ice_fdb_add() would fall through to dev_mc_del() on
> deletion and fail to be removed.
> 
> Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

