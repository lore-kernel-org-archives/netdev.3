Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121C214812;
	Sat, 17 Oct 2026 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201865; cv=none; b=pGOcawyRboq+XMLYpOsCSA7TKYLPGaPOiCZ4LV2Ig+ZjKI/1NCpvWpC4I5NZJTH03N7TQe7kq/6ed9yZr3LE3anZ9PQFO3ivyeOrt1BNtg1roXFJt8PfOt+EhEL1hKkl4EVFuss+U70LWJX7EkSJUiTzMD1H5nWLFu4bvedYf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201865; c=relaxed/simple;
	bh=dA6gTKuQ1/wWxJRqQGnVHDEfV/8nqLYMWS0U1Q4iOYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZDXgkmft3TQ+fDW2reiop8mg69hw29Q+7d2/aeZasduOIkx40Qv+DeeC9ksTwuNHKs22hCpBfttyw9Tudbl4HRmSsujLbfuIkWm1r1+lzqF4LvmTi8rrIUL3iTg2HfdkwFRI5hmcYPM5aTiXIytdTsOOoZAY5D6fqkNwyZw6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4jFWflo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4jFWflo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843FA1F000C4;
	Sat, 17 Oct 2026 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201863;
	bh=WWRBQABFKcDmc/eAAwLApN+mQtNvSIkoJcO5mcLL00A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G4jFWflobVKog83/jaE64oRhH0rxNhLp8rI5kvCMzQxJ7TiQj9quu8Cw4dVAQE/x8
	 PF/afENbk61twbKvqdwWTM/i4xhUf26m5j7K2yFK69vbIwKetO0esHOPE2r5t9YzBx
	 hmIfB7wsdnv6FspUW3E9NRsx0Kmur+Xu50CN/44a5nI1b7tCQrJbPn1qgCoy7e29m/
	 ORHnEUSho7O8+2OeN7DkkbD/czrA4ruTUVMlm1CnKcADuzGzY42Hgo+Heu+6TZo4lx
	 iXG2fgjIPHvr5SC6Mk9U5WF0ECc3cpCqNfK0sN7P2LFBRF5LCc6nHZ/iD0JFfjp7DI
	 KsMXm4KSc05mA==
Date: Fri, 16 Oct 2026 18:51:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] netconsole: fix target enable race and
 configfs read locking
Message-ID: <20261016185102.19cf818b@kernel.org>
In-Reply-To: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
References: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 17:41:56 +0100 Gustavo Luiz Duarte wrote:
> While looking into the sashiko report about local_ip_show() and
> remote_ip_show() missing proper locking [1], I noticed a couple other
> places that need locking: patch 1/2 fixes a null-ptr-deref when enabling
> a target races against a NETDEV_UNREGISTER event, and patch 2/2 fixes a
> use-after-free when the local_mac_show() callback races against a
> NETDEV_UNREGISTER event.

Clashiko reports one more pre-existing race, we should probably 
address in the same series:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
-- 
pw-bot: cr
