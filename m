Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55212364028;
	Sun, 12 Apr 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025073; cv=none; b=eimkVsiVGEV98ryefWMNDE5Y3D7qe/2TGDX7K3oaJOjpXioZxRn67M/AFplCbtFEcHrJ4Lo4s/Sh/ixLW/ER9jbqb9erRal4wEF9tFii+q4fhdTRz9aJJfaWETNuY/UOw7NBeZE256+21ffzfkUZQkDorPXq2LPsx1xDfUQwqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025073; c=relaxed/simple;
	bh=+GQ2w14XZKFOtmHTRbBaPgP6q1+SXe9xjwyp5/qjVzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5w5aQ7NB6FFm5Ll7aKFTuWUQ8Z9dUFVJefc+lbGGID3aDVuye8ygnZa84WL3MLHdqwo0tXBdAu6FmzyMiqYPZSR9n7idoIqvn/O0vaH7ShyFXeDHdWs9ep2jIJh4x37UYvfmon6/KO6yWbPCatuif5HHLhH2Glab9NREwL4HME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooUifqCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooUifqCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AAAC19424;
	Sun, 12 Apr 2026 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025073;
	bh=+GQ2w14XZKFOtmHTRbBaPgP6q1+SXe9xjwyp5/qjVzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooUifqCPoVPQ4RAl4uE1Go3evrVTnRZ+OrSXMGEvOdabVYx7YKdbkuwrVE7b/CrWv
	 /4d+fbV3g53P0UqcW8EIgWbDSoVssmgGaoFtec42HGEk7Ih17mr48a3cPH1UVtbe7L
	 GX9LbDZcP86dzHnBrE2Ttm6S/zKhjF8FXfvENlL3lHgtN0X1lE5iDMLFR/C+bgCNKZ
	 HtzCNbp5AjXhVuo9G+gAA0HM6UZcvysb7MCGgmChscyEqdiv0//HDBi5Q65l9pzTHm
	 mxyvVNyKOhVK5/UpAfzP2lINlmoAAGGgp/u6Ao1RdrqNF5nn+8ytMMF+P1iVxo8gDv
	 KROYlGRHOA9VA==
Date: Sun, 12 Apr 2026 13:17:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jreuter@yaina.de,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
Message-ID: <20260412131751.0e90a053@kernel.org>
In-Reply-To: <20260409025026.24575-1-mashiro.chen@mailbox.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Apr 2026 10:50:26 +0800 Mashiro Chen wrote:
> Fix mirrors the identical bug fixed in NET/ROM (nr_in.c): check for
> overflow before adding skb->len to fraglen, and abort fragment
> reassembly cleanly if the limit would be exceeded.

Same problem as reported by Simon on the netrom patch applies here.

nit: I don't think you need to cast ax25->fraglen to unsigned int
in the comparison. since it's added with skb->len it should get
auto-prompted to unsigned int.
-- 
pw-bot: cr
