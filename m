Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0561FE47B;
	Sat,  7 Feb 2026 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431819; cv=none; b=ro5JrvTcHcV7Gt7k22vhIYMac5pmWYrKUm1J+V+CeOW+M9qYQfj4WJKUbaUCCiEIRZgBID0MycOAtR+rpnLIOQOhkPDZpEgMVHfa40vofpQvKiQ/LiUVlWXKssQ5ezpPfsQqUvTrk7T2hkzSknwio0nKeNVwhS1tcWD33rQ5nDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431819; c=relaxed/simple;
	bh=UYDV/lmqevgx+snE8Jibe2CB1SyjiFB1b1qnGiL1y5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCwMTbZE3xXdaO8yKUVKYikCFZgOj7SNLqwYbZ0tQYjy4xCnwvbcRoIsI3bzCmiiYeLfK8XMyRXZzPCHHT4FNiKUYmXBdD7v/ykatt43byKRs6opD80syUTZdHZ3pYqsnGYijesoQNX4Yj8IxkCw7poGeSWQXUOzajTeJLEubKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM0WcXZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM0WcXZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD984C116C6;
	Sat,  7 Feb 2026 02:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431819;
	bh=UYDV/lmqevgx+snE8Jibe2CB1SyjiFB1b1qnGiL1y5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BM0WcXZH9FXpTxI9wThUBxr9iSoEXWI+f/7GOT1Cb8v3EklArf3YM5jtCezrEP37+
	 MIV5FsPqWyaohH9dNUaGo8Y0/GD0PHtKbxG4oksp/sIsGqntg5mlUsIqTK6SokWo4G
	 mR6JANweI1T8q8KUmQS0bc0AYiR29CUOOgboOMvwIW+/NlSAyrFyGNhnzsfH4tdswh
	 RnTxsbr8qT/c/900azcS69iDOZB7PAHAdvtELIO1pFFxXiZAwzIt0px9P8++21YHBE
	 d7Brd5yrB9nQcLzFfd4A3+V32OrCZnfM9zGKE+wf/iBhCVI3W+36bjmf8vEGMjmyq6
	 jednXGRK73L6w==
Date: Fri, 6 Feb 2026 18:36:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
 chris.lew@oss.qualcomm.com, Deepak Kumar Singh
 <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
Message-ID: <20260206183657.0477e50a@kernel.org>
In-Reply-To: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Feb 2026 13:51:31 +0530 Vishnu Santhosh wrote:
> When qrtr is loaded as module, qrtr-ns runs from SELinux kmod_t
> domain. On targets using upstream SELinux policies, this domain
> does not receive CAP_NET_ADMIN, which prevents it from binding
> control port even though qrtr-ns is a trusted system component.
> 
> Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
> but not desirable, as kmod_t is not expected to perform networking
> operations and widening its capability set is discouraged.
> 
> To address this in a contained way within qrtr, extend the control
> port permission check to allow binding when either:
> 
>   - the process has CAP_NET_ADMIN, or
>   - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)
> 
> This permits qrtr-ns to successfully bind its control port in
> kmod_t restricted environments without broadening SELinux capability
> assignments.

This really feels like a one-off hack, but it's far from my area
of expertise.. Could you get an ack or review tag from some kernel
maintainer working on security, capabilities or permissions?
-- 
pw-bot: defer
