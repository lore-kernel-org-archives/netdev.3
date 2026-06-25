Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13813E7174
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400681; cv=none; b=ifWERI9rHqhrO/5/BnSRTFeYRauhFK7KyfOeOylzbGpskFuZKO7w+r76oNR13mXJTJtKaqRER+nR3DgB3XiOQ9CFw/s055+6/yAmppIvbXUmFEwtp+CRkPqfci5CkVyBdFUrFlTRS/QYBnQdfv+n4oRToSKf6GPdHOMAQ87jyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400681; c=relaxed/simple;
	bh=ib2sAGwaIJ2oUyvwZbDZNmcPW9jcdvyizA8xO5OvAGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+IPmLqBXChzOpaVra6OvN+mvC/UAPgqtDdfVP8FWAx+TKONZlwqM6Z2LQhOerj8KklYXaWXDbQFqg1JG6D4hZRWc3GJBgWkgnrayoB4SKTSAK+s23YwQNbtQUWTh4yahlqbsaHVDXu1IXP27/XuSMfbVZ57F+Va4+yt5caMbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK/rCS4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK/rCS4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5581F00A3A;
	Thu, 25 Jun 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782400680;
	bh=aZ0X4cgr9qLFZNQU5wx2hp/E8VvIilJvk7Gw2xJY+Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QK/rCS4E3jd3cpiNamBLRl9+ots8QcfDl32c6YcDzlnDFjqs7LVPxaaDIZ28PC9pJ
	 mVdjiFWV9Hka46cS1YTojk4o1sRIAfJtDQGoKZEFYdDGhxhfKu+Qn82Cnh6OgiwbSr
	 i9zwtm4YiTCcYXA+PozfIC5gmzFG2Cgk2oGPuP32Y44LbO3MI+To+7050hVsbp5QeY
	 hinmy84z19B19DLltYHIAiOxLUHDDYErw4G77jXstQJ00K2fJcus1/Jqgk3J/di9ua
	 CPoniPJRBpi3inMe+P+WqT7sUzqL5wHB6/28QxcbAAbDfCWIU79dmdaJlDOkaGrD+0
	 67S4bGmFeR0Tg==
Date: Thu, 25 Jun 2026 08:17:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jv@jvosburgh.net, sdf@fomichev.me, dongchenchen2@huawei.com,
 idosch@nvidia.com, n05ec@lzu.edu.cn, yuantan098@gmail.com, nb@tipi-net.de,
 aleksandr.loktionov@intel.com, dtatulea@nvidia.com
Subject: Re: [PATCH net 1/4] net: turn the rx_mode work into a generic
 netdev_work facility
Message-ID: <20260625081759.10330b7e@kernel.org>
In-Reply-To: <CAAVpQUCbT1Q9BPTLrVCjpt2vcJiWsYKa0onJ_vwnq86L73m8mw@mail.gmail.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
	<20260624182018.2445732-2-kuba@kernel.org>
	<CAAVpQUCbT1Q9BPTLrVCjpt2vcJiWsYKa0onJ_vwnq86L73m8mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 22:55:06 -0700 Kuniyuki Iwashima wrote:
> Oh very nice !
> 
> I was drafting almost the same change for dev_set_rx_mode()
> in mcast path and some ipvlan changes.

Glad to hear! I wasn't 100% convinced by the added complexity
in the core :S
