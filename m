Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090C2745C;
	Sat,  7 Feb 2026 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431678; cv=none; b=ZNyCJ+E97GlknYBUm74kqXyLBmK3YxOmOuxVw4ajvIeGw72oCsP2dny9HFbk9pn9G/dLkpxuvdwCXx7oFFFh19D7tNQOWtHxm+vtfAxBnvQOeiY0x+NBR3lmmYE2ctxs0BBAe/RR+zWt13KRJ7yeqZgTGcV6uQP72r/AzQgIBjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431678; c=relaxed/simple;
	bh=EgtPV/kyUetTXN4izoQxcSu+SLV26kRPPbjQ58oYLaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA05I6SEHAdisXByF3se56QRROD26ExJiQmbhTOe3AUWd8R+VKyE308lwxfRcnHryj5h4V4cjpZoapO5vdQa1DnoYuIwQTVX+8mGsSi00RRtcxsuh0yxp/+75vMO7Oz4ixfLx0t/wNYA1b0IX+RRXk6O5heXmb+h0yRDBPIPkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r082eW7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r082eW7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E6CC19422;
	Sat,  7 Feb 2026 02:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431677;
	bh=EgtPV/kyUetTXN4izoQxcSu+SLV26kRPPbjQ58oYLaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r082eW7Cn/xahB+xezQNiqzNYi6FmH6CqDgQAimoo5JB1acXMoYnKAkSQ8s2LKNPZ
	 WgTQrUOOaRS8WPTTcuzZKK8Sxv7DX1hsleqmlzVQ3Ew9SY8j8PiKaQ1Z3gt4QPnlq2
	 Bdc4E7pJkRmgW4r0eZuvD9Z+W2Pbk4RPmGyZ/kg5NfwhQUYvXY2fiiQ90rJpM0gbca
	 JWTXF5B7d3ifXkQd9ilV+Xh72ZvGVYXUTie7G2wdjxevvrtpSYd9PBamQ9dPnP4QeB
	 DEOHyoM/G24fUl7b7+4wlwbff/VR/4dD8BJGobSZXqVqSKaUOMoGS70Dt3rlZOrBn+
	 znGiVBN9hNgNw==
Date: Fri, 6 Feb 2026 18:34:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>, Manivannan
 Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bjorn.andersson@oss.qualcomm.com>, <chris.lew@oss.qualcomm.com>, Deepak
 Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
Message-ID: <20260206183436.3291c742@kernel.org>
In-Reply-To: <7f32eb7f-3402-461c-a932-66ba36399fc8@huawei.com>
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
	<7f32eb7f-3402-461c-a932-66ba36399fc8@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 11:59:44 +0800 Jijie Shao wrote:
> Sorry, I noticed that this patch has several check failures.
> You may want to pay attention to this:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com/
> 
> 1.Single patches do not need cover letters; Target tree name not specified in the subject
> 2.WARNING: line length of 83 exceeds 80 columns
> 3.AI review found issues

This is not public CI, the maintainers will point out the issues
in the code if the failing checks are relevant.

If you'd like to help with code reviews please focus on that, 
reviewing the code. We do not need help with trivial process matters.
