Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7761A683E;
	Wed, 22 Apr 2026 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821959; cv=none; b=fd6fm5lLRqTLwIaIFfJJGMKrkNVFKy575EG9Fk7FMAKklV85eO1ANSti3/ODuOwz/GuO4P/NavNO3xCOb6RDjByJpSsbbWoq54l33OQtOzwpDXsyLnSSf7pc0bclCcpo/DHgTbLr7pPA20UBDOUnN2GVmNyUL2wz5Vz7F+sJpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821959; c=relaxed/simple;
	bh=kXDdz6fh1tHiWWOVkx/MOqXVrqSnDJZ0bxKziJBaOyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STUy8eCMoVY9gauG1hYXHiBd86c0QR3EGsIC9U3IXx3WJr9k0a1/W82UTge/Mp7ies0Q9BacYD8h2oPdAtOhdck6KcDxMrW3DCwHlaYJKPkrGPvN5IebmooFf1L7WqfdC5wwDUXb7qoqZhH/aLSnFxEjXVMRVBdQ+HELuR6We2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaJAPuDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaJAPuDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0CCC2BCB0;
	Wed, 22 Apr 2026 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776821958;
	bh=kXDdz6fh1tHiWWOVkx/MOqXVrqSnDJZ0bxKziJBaOyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JaJAPuDvw0JuXVFO9/L1rWLgI1PpSEKd+0nGXW1+43e2VVxkSOfOU80a66n2GQbwW
	 KvyIvjWrVT1IKDJu6oM8VXZyhbC5vUpcnT58TE/Tn9jm2sALkpQRo4ApJ7TuTRAC67
	 mOSAUBX6nFzq+UtkRDipeJbIvdUtXoRNA+K/crhFrqEdTTmq8zPb1zJaHk15KSgwFi
	 9txjI7lLxzfAOUL51/Kp9I4WBcce9DwhECeSojMTuK6MZ414gCaDwK5nGd5gbgB0TY
	 5Cki5he9gFpwWQImTTFLmPF5egpHagzNKPG4ZJhHO1TZjUhNaB2XgPUuQEh7TEgsZ7
	 QyonEZkth7kbA==
Date: Tue, 21 Apr 2026 18:39:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <20260421183917.0dc30ff8@kernel.org>
In-Reply-To: <87441489-afea-44c4-afd9-8f1693b32ce6@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
	<87441489-afea-44c4-afd9-8f1693b32ce6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 21:53:38 +0200 Andrew Lunn wrote:
> There should be 18 patches in this series, but it seems like b4 send
> and exim are not working together too tell and have truncated it to 10
> :-(

Looks like they ended up coming thru and got nom-nomed by the AIs,
which flagged some omissions (in docs mostly). So I'll keep the series
as "changes requested".

Please feel free to ignore the 24h limit for this. We need the
deletions shipped to Linus by Thu.
