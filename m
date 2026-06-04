Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E302305687;
	Thu,  4 Jun 2026 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604867; cv=none; b=lcRnIglIy29F0Fb07rZIVfz9BbhdHfZhnlgAT+8aQCaQPSoCirq6DZBQDdttlr5ev4cssEE4AXgCOHGEJa6MF73Ax9aerkPkbgNBq6s19/mrUl14dXPqjK/3KHqooSKeab2FycGi+GhHnuareU6kmYK9iJbK9HZJLKJ40UR20mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604867; c=relaxed/simple;
	bh=ejZO0+YHvSC6cN1LsWOGJBdvJceZZp5oXWQLJx3JaI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZwcWMSpIV3MqS5YrovbC8x643vVVXBhO+c1D1lsZTZTnJnGCnazRleUo9qnmEx9zrdgygiAs0WDtTMECNH6tOJYiKB57WZiNnRxU/LcgyjxNVFBvxRJ0hhLN8fjUbN8jG9wiNNmOZxpg7xm+/2sRt0UiV8dT0UVcMWZn3BfTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFVdvQVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFVdvQVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7B1F00893;
	Thu,  4 Jun 2026 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604866;
	bh=qlbBo0BasZ82nFDL8mjICrf2XEvRYJ6dG1w7R6FaHQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WFVdvQVgMEwFersfhvSiAG7LFn7pfTaJsJ+LyT30LRy+IVIlR1tRZOWWrOX1SfmFs
	 2bCd0JzbmIC7k4gKXCaz/nK3t/58JA5CIJpm0Z4Xf0BPbjxStiahPyiPcHuTlCV/ZZ
	 ZxIxI1I7LOYLQA3/wZ+qowj6hS8TJhJ1kF+n/QDPwHaRVarCvVug08fLx2ZWW+9U5d
	 QW0MQryyQz60uB7iMUuf+hNS8pYoyh6kgEvSgHXuAzumsBMDxLP1eSLmWYH/w3K/YO
	 0cDpS3IqvKQHSRJNlMQ5l3CekJ6PkfOhQtY3Lc6elTnPd+o9ssD6g/YLUkK78EnLEf
	 m2Lp9PiDH90eQ==
Date: Thu, 4 Jun 2026 13:27:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20260604132745.7b24401d@kernel.org>
In-Reply-To: <aiGJDaHV4UlCexIQ@sirena.org.uk>
References: <aiGJDaHV4UlCexIQ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 15:17:49 +0100 Mark Brown wrote:
> Caused by commit
> 
>    cb9959ab5f996 (wifi: cfg80211: enforce HE/EHT cap/oper consistency)

Hi, stupid nit but FWIW the quoting format seems to be off in this
notification type - missing quotation marks around the subject.
