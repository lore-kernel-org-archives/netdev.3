Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475D1FE47B;
	Sat, 14 Mar 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499803; cv=none; b=mryKjmVqYTrXMrESAfVEfuiRU13xmX+ftBaig/1sOVfFoEeCphC/x+mY7sGVfkuuamv7DBxc/WGswEFRnC5HAathqoj0yKo5pflYIYLIEZwokqwQj4i0JbnUjb12q7SteLaHHi7PUkSsCCaO3/UB77W5qvLXQ2yZwDbqL6MlPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499803; c=relaxed/simple;
	bh=Y9SJbFKMpbzs7B6VOWhaTri+Xq3nFt1bJvXiz8PE5MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+sSyL/x2kPCpJMMUY00LkzMRVA4iOQcByOC/2yRpBl8jOSw267kR9pqJs/eUb69WUdW5PZVpL2VMsspgzBq2nLvNXayzgQmlnrdqtILg0tH+1rssClEX4bsIHmds8MGPimIdtZgXELKSumY7mSyoAfWWfidBI/hYRidazfQ2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKml0RGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKml0RGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D90C19424;
	Sat, 14 Mar 2026 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773499803;
	bh=Y9SJbFKMpbzs7B6VOWhaTri+Xq3nFt1bJvXiz8PE5MY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKml0RGTR9tCldMZmdbury57WLv0v52M7T0Ixx6L3NAfflTpVcKNL/Q8MiwxLDqYS
	 GREyJZGoldU8c/KT1xu5M22yNp4cN9NhV+4cIkflJLDU6l21myeLFKJuaBVjxH81t/
	 +Me6yQyvqClusDHyznyqdj8742o8fK8NbFGWuXpKvq9AEUi5qQ3x3KSgFLYHXCbgg4
	 XTdXHaYhfVCGg3WHZiV+kHRK28m9KsxzECkwZz/n0z62FlVB5DNbTPqbcsobX/lsJx
	 5sk+YHrWvsMa7FHnvQLRkgu3nKW1pIad+kgHDYF+IgG5yAVpH66ZNj+hpxy4iSBshd
	 TYfy/bD/x1wgw==
Date: Sat, 14 Mar 2026 07:50:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Meghana
 Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add HSR multicast
 FDB port membership management
Message-ID: <20260314075001.2bdb31d6@kernel.org>
In-Reply-To: <20260313133115.GY461701@kernel.org>
References: <20260311082923.2962937-1-danishanwar@ti.com>
	<20260313133115.GY461701@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Mar 2026 13:31:15 +0000 Simon Horman wrote:
> It is unclear to me why this is marked as Not Applicable in patchwork.

=F0=9F=A4=B7=EF=B8=8F. Revived.
