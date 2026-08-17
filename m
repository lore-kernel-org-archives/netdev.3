Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DB3EE1FC;
	Mon, 17 Aug 2026 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009892; cv=none; b=chR5PKzQASCw7R2K+v/vfRThmN0Upv5nyUYpzxZc81sGbH3dNKL5o3chZBzRMt+TR7pYwhf+alT6p238TvQZLNTIc6pdx2FAAGojznThha/5pA67FacdS3Lia6MjLyN8GqwmL9hTgaF1hS+gCz9GzinfJUEc550jkMvM5eWDJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009892; c=relaxed/simple;
	bh=TYI+QhsqXzCVzgm0W7XS/LOMEn1OL3FT8ZDNYBsSn8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9SPj+KqrpTl4T2osQ4PcpCEKJqZ441/rxPVX/Ggr1vbqLPHzBHENHOe1rRhDO2AEfpotL8jzmdKQHHUQgnKvlncI9+OyBlaEbcpnencdrZl7wFnzVo//sqF0TsWcq2VfbxxZyiNGxGynT0hRk3NE/WYPToLK5ngsQEB8A5lNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flY3pvTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flY3pvTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C619C1F000E9;
	Mon, 17 Aug 2026 23:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009891;
	bh=hA7ALyvo2dYb61lg820tMW3fFX9nOvU90bam+sz8ZOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=flY3pvTvBT0acvwnHT6jYTNJE107GgvZW9xZ5LKOqhpiO4qWEtPYUiR3Sb6PJ04sm
	 MqsTwDi5P+Nw/hVRuISXIy81uae8cyl66kZ1MsYAjd1n90zHw3cWTXUuzWcnMz9jjN
	 xFlc318sCKWYtApV/BPB60NxoVq5IrAmt2dAsS9/VkjLzuGK0rkg7zXEQq5opPuAB2
	 M7YLm2jNgxloThnrtRAGDdULWvsCRftLxH9On5lAeLIyXF1detL/ojLVzLwhCZGpIk
	 i+a+PniK5+dNhmoN8D0o/yvURUWSC3e29OAE8z7dW/kVID8kd4c43U5RDJ1lVzWiyd
	 QqOamK6OHYwbw==
Date: Mon, 17 Aug 2026 16:38:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 00/11] add features to bnge
Message-ID: <20260817163810.7ac020a6@kernel.org>
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 06:44:24 +0530 Vikas Gupta wrote:
> This series adds ntuple filter, RSS context, and flow steering
> support to bnge driver.
> Patch 2 is a pure refactor (no functional change) that relocates the
> filter and VNIC related code into the appropriate files. Patch 7 drops
> the refcount usage from L2 filters, also with no functional change.
> The subsequent patches then add the ethtool commands for configuring 
> ntuple flows and RSS contexts.

please note that net-next is closed until 31st
