Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46C27FD4F;
	Fri,  2 Oct 2026 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902715; cv=none; b=B3eRw4eN7knPVuXq0LEUFKzibICPcTiRX/dT7qtDJEgiCBoLzlje5905zLUltKQMDYPHhtSCajQXCzICZ3YhIWnHUpshxiBzgvWwEsJZDnhC/4MnRUM4Z1+NyJjesLPLE+G1Zc01MhXew8QPpI2fDwQHtFwR9fzfyqanpCI7f94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902715; c=relaxed/simple;
	bh=4i5sM/LIV5GQfvuhfXAXw9ChnCMwEf9ZIylk2H2xQzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l398dMujZ/W3RRcYpqUeSId5WEi135u7Lo5Wzo+ixzSlwe4F6gzWJkAdjWKujT0IQYiDcih6+ZfVHbjfI6M1TH6ctem22PAYERA2xc/t6i0n6ceP6E6euw1H4wp/vwuIgPT3lE1mBBQvSYDNuimryD5dpWQdWrgNa40Tlr8S6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvMYaJB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvMYaJB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C19C1F000FF;
	Fri,  2 Oct 2026 00:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790902713;
	bh=vPS1ZZIgcHXElBXTZ8DXmjGGKcXkNpbTng8uQ1YbAP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WvMYaJB2MGbitrr1rRpgRPwDdcunfdC20Dvrsx2W3spvpQqfL8+8EXnPuDlbtTxBt
	 i/X2mDhgWLtpHecphrpB901Gu2C31hOJ4hmItgvBhsoeoTc1wMm6KINJF5YHnaCdly
	 Qq9lTdNFhx2F0ayCzMrq7XZ8/K0189ZP5WsuyK8jG7n4PiApmWkUivzztImtvhtsuo
	 NaKUYZ2DQVs5wyy+G/froHvHHdBlDVXdo7moR2Yi822rktdOjyzT9PmO0KbfM/bQZR
	 yVP9VrHW7Kgyd+eXrvIxBq9FsSVan2DXO1dpCDu5KdGpCXob7cxERXhtWH+P2MDRqC
	 5jl9nOANF9IKg==
Date: Thu, 1 Oct 2026 17:58:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: kris.pan@intel.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, atomasov@redhat.com,
 oliver.sang@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: iterate online nodes in
 skb_defer_free_flush()
Message-ID: <20261001175833.47968268@kernel.org>
In-Reply-To: <179081936536.434549.10388925622845161029@kernel.org>
References: <20260928014708.3903028-1-kris.pan@intel.com>
	<179081936536.434549.10388925622845161029@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Oct 2026 01:49:25 +0000 netdev-bot+sashiko@kernel.org wrote:
> skb_attempt_defer_free() chooses the list without checking whether the
> node is online:
> 
> net/core/skbuff.c:skb_attempt_defer_free() {
>     ...
> 	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);

not sure why it says that. There's a check earlier in that function
AFAICT
