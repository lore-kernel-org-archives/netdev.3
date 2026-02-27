Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43066B665;
	Fri, 27 Feb 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154843; cv=none; b=exXXMX4MgBMHRbL3osPGkJd9VwWboe5EUyBHR0iWfOlS8i4OnMQ3HQIcVxCWJqpBOeFKtb6spaoqkh0mLCFNdLUqmCiVJiWnEtcGO75yUcu+5CBx5oraQMjhKNQ75JK3Hzv274oW3ULLT9YLciRKzQWmmT2GH13NTAfQ8gY2y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154843; c=relaxed/simple;
	bh=V6e/eZIykA1TVtKFCPhcaT40rDzXPW1GfzxO37XFH6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mwz0Zk2tDN2A4OvZ310y4NHjE7NhBMGieyZgUcagR+DdOWEklljy8JSjQ9Gzag0pqWfwNDolkBPKJDkwABrv0OBAy0ch5ZkGU0EEVZjTPGyFVHXQIKK9qm9dkI8O4+/JJwXFY6r5pYHaH87gu6hg+NvB8nleaiRwSGt4abRh/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6MmsRlg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6MmsRlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A35C116C6;
	Fri, 27 Feb 2026 01:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772154842;
	bh=V6e/eZIykA1TVtKFCPhcaT40rDzXPW1GfzxO37XFH6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O6MmsRlgZK2091EGKFaK30O1Q03sRaCY/GBjIC6MH87y7KXPeIHfyNbxm7dcXrcuC
	 ydOFig/TD8fDCevqtCm5jMwGiZaggsiNlriUv9PkfdB3dzXBxBoEV36X3Gj13YsJpz
	 ORA+VjM3q7FbO7QONGhOM/eSy1cmi9Tf+RHce2h0+HeNwmKwm+r/qOyzKRoFHQDLJu
	 HuNdifOvff8ZrrgyPyAO1s7Cb2JrgNd3gehUOIlJrWOjo9qC2BfO6Pn5Tg3qTNMe7V
	 HMvKqF+p2MN3b1507tsr0xsmPbHKryw6sV2EDg48oR0Uzq2OBohOvtoTo5rre9hz1C
	 I/DJ2zc/mmIWg==
Date: Thu, 26 Feb 2026 17:14:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yung Chih Su <yuuchihsu@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net: ipv6: fix ARM64 alignment fault in
 fib_multipath_hash_from_keys()
Message-ID: <20260226171401.7461b9da@kernel.org>
In-Reply-To: <20260226111721.25454-1-yuuchihsu@gmail.com>
References: <20260226111721.25454-1-yuuchihsu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 19:17:21 +0800 Yung Chih Su wrote:
> Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a sysctl to set multipath hash seed")

Please use the traditional abbreviated format of the Fixes tag
