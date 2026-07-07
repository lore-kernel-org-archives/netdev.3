Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606343F44DE
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430073; cv=none; b=vGLe2aXaP39iUKG30ZDWHNHdkHWC90AOe5YLBMhfsmrN6Xp4XS7Rne+U7G0iFmA6KakgaeFxRmfYs07qgUGwo5MdVdgAeizDQFqM6Q0MxdCGZM2kGMNAyi36gqb597Toye+qaaXDGCTYzSz4xkl883nXizqRo940LO4YWPfjjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430073; c=relaxed/simple;
	bh=AJ1PH1Xl+0nzIKpP87Fk4UVnIeFYKA9xfQ6Aog5PeTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrVeYedsMeqIu9vhtnGMul7Ecx4ElPJ96mT49rX9J5SSgyiwWYSe5fGnVyTTxxScVxZiIijCS96en1r6G3aaJPWeu1r4MRbpjmR3B9Z4j6pkkhdTEcY6FGAXUFNqGzqG0P0KQPWMrjIocTDvXVjpDN1dGvSanizNLoyoUSTMJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCDpl3dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCDpl3dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474F1F000E9;
	Tue,  7 Jul 2026 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430071;
	bh=gy5f1rBuEP4haLiJZu59Q3d5AY2Hnz80qE4DOJ24g3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GCDpl3dn5MdgX4OeFnhOET9KfX0HgmUZta/LwGXG7Q4e9TmgBILIN8ZvO/XvtPIJ5
	 gcJR9BzsErQE0+3BxV28NNkoEOkc7Z27GkArLqoigSQ7wTRYlsHrhxsgpo7CWLVEGt
	 7ccVTQfYZnyYy8Bn8PMoTxmhoH1kdrpJfqAazpJjb/wb0CzvSxW1TJ6cr+jqWsPL5r
	 4jSkXNB2KGLuPWAswfVs0fpdihWEqRUEcw2Y+h+6azXv0lIrATmqlExBRA91+uvnWT
	 GqMuc89rvBUNG3upyiyvTNUiD5GVcFZqHZiS0Rm704k/1E6m98hCb3W4WQwxl7JFEn
	 0aeV25Nnoo5+Q==
Date: Tue, 7 Jul 2026 14:14:27 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] ice: use global queue index in TC to-queue
 offload
Message-ID: <20260707131427.GE1364329@horms.kernel.org>
References: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>

On Mon, Jun 29, 2026 at 11:12:03AM +0200, Michal Swiatkowski wrote:
> Previously index within PF was used, which caused rules to fail on any PF
> other than PF0.
> 
> Switch to global queue index by adding first RX queue id from caps.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Fixes: 143b86f346c7 ("ice: Enable RX queue selection using skbedit action")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

