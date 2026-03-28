Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188030DEB8
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671213; cv=none; b=cUpHwl+o1nF0sGeFLZdBgO02W8C7GHjT0cON20ghAPVGXCJVtq8ytMs1h43vEYoHzRPTEgzZsJEuSthl9aYEIqU+oEz+Vztv/ZKVFZLR9aWdBJrXB/nHiJByt7bxJeQLrQbSES9FY/SdgnAU4XLMurp8nTUfxlPAp2SI8GZb05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671213; c=relaxed/simple;
	bh=pASpr36xBnndYYZMMk+POvFnRYw8W4kYc14KYeQ+0zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9SlIhQe9Eq1SKjdnrpVcuvMQnnzvMUezDLHhvPqCHB7d5Yz5gLqK+uhgJGxSBMmt/UVmXzX+wX17HzGbl0FWnHQm4FbLzl4vFYmb265KjcVwY/9LI1FlSGm2XbVjmoU8wrw66wr0jIHQOccE82ZsNlh4xqeak5Q8O6ZeElHDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTBDYNmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTBDYNmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FF7C4CEF7;
	Sat, 28 Mar 2026 04:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774671212;
	bh=pASpr36xBnndYYZMMk+POvFnRYw8W4kYc14KYeQ+0zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DTBDYNmxeuNx9slvWYCFA+WGQZCrrpa8z8kaIq5FMrQBeSi5yFPbvOWbTOXCusT6z
	 6uLd5I8wOt6Gienhy9VV3q9sZTHg3QeYBhAoQvjwrUOzlANwuS3VRZji3C3DtBSMOr
	 68bwj0IkB47UW8CtotGRkwyaQbHzRkB/AhxRq61s5QsFK7KhngSecmsNKgHkT2v28J
	 b/0ldZ4m5/ej+AV9Wn8FhPLHW/Mc6FCWnzUE8cxLXERJW+KVxkpd70uSrjkikFYmfw
	 mgWCFZEpzs5vY4PU155EAy4asnLjQxrrskX7f/Fho/+6MnJjPOFSF4gny8JKU6FvHw
	 GM6cUsHZfGDtg==
Date: Fri, 27 Mar 2026 21:13:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com, nb@tipi-net.de
Subject: Re: [PATCH net 2/2] net: bcmgenet: fix racing timeout handler
Message-ID: <20260327211331.78476a99@kernel.org>
In-Reply-To: <20260326184529.1393438-3-justin.chen@brodcom.com>
References: <20260326184529.1393438-1-justin.chen@brodcom.com>
	<20260326184529.1393438-3-justin.chen@brodcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 11:45:29 -0700 justin.chen@broadcom.com wrote:
> The bcmgenet_timeout handler tries to take down all tx queues when
> a single queue times out. This is over zealous and causes many race
> conditions with queues that are still chugging along. Instead lets
> only restart the timed out queue.

FWIW AI seems to suggest we should also stop NAPI and the DMA in this
case, just to make sure that the queue in question doesn't suddenly
wake up either. Which seems fair but probably as a follow up and only
if not too hard in itself..
