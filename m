Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0203845BD
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330967; cv=none; b=UHtMatlK0Z/IFzwkr39E+hXBoq61TID3bBX8rfknqZteTr0lsaarF/+jT1/Fxu+ag0x3O8UALDHXwbfWyJ8oUh8tbB11rHnmUT9pkHzJpLVilAJ27a15DOCkDvUkHm3dwnUbRVYxIObntBu7R3B5021uOZFpxogfnVGDI/Qpljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330967; c=relaxed/simple;
	bh=Txchng0uY3okUD5Nq3Y0b9qGMUL4NLtNd6uafhQ9MSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnQW115nUxYRQSYJHQr9Yb/hBIuJTuKe2IQxi0LiAblMPJjM/yLKnvCsgtZlMC3x4wlpO+jZ6UkrG2HrK7A7XixU3wp2nmKfXGqlHFmkJzhL4n97hEvdUwgcFUe9srPW7VNFApcv404R6TRo+fQa8J0ek6irINP1dGoUofTv/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp2LGnCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp2LGnCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E73C19425;
	Mon, 27 Apr 2026 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330966;
	bh=Txchng0uY3okUD5Nq3Y0b9qGMUL4NLtNd6uafhQ9MSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lp2LGnCQDJh41XQhwo3B0sDT0yMiNB9FVM6ri9Fe7VMG/iU9mWlQm0svsKIH40yAu
	 y+0xw9XaoU28455y0xnjW+22PZES3A07FP7DCRrhTWMbfJmUPvou+U2wIxnVL2MH1A
	 lxYtGUxbFWl1bAKLE7Muxrs7hnlTatJdeDyaxDycWGasvMxCfZDaqSMG2cDGplSwzY
	 +ctld+xi/m/N9QYQ3DaaKbxO2aAnM2T5Qqo2Ur8pqLNw+1hwDDQlE9hN1X5481HfSk
	 VesJsMbjRm1UWIy6WLmi8/vrfRLb5qrhQbWnNVjKwHnPE7p+dUyRSuRiV6QFqtFtPp
	 BOCOY/LDufFjw==
Date: Mon, 27 Apr 2026 16:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/4] net/sched: tc_dump_qdisc() optimizations
Message-ID: <20260427160245.11dea0a5@kernel.org>
In-Reply-To: <20260427132555.1791636-1-edumazet@google.com>
References: <20260427132555.1791636-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 13:25:51 +0000 Eric Dumazet wrote:
> Before converting tc_dump_qdisc() to RCU, we make the following changes:
> 
> - Use for_each_netdev_dump() instead of for_each_netdev()
> 
> - Only dump qdiscs of a single device at user space request.

Hah, what are the chances, I've been sitting on something like patch 4
since Apr 15th..
