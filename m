Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84740B6DB
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052746; cv=none; b=QF2A4Nuqhz6cgSL42nLAxNixvSqWivsS+flUaSKzaRCTt77jK2ZFCiqfK2KIQ+9vx3psIe1EmXZvEdqwlMEMrmWX95KdfcBj6CrQD2L8NQ1iGI0PV1s9vHZ1BnvM2s9YAieb/YXy9RhVRqE1sOuzhKjZFsZLV/3xAUneFQv152o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052746; c=relaxed/simple;
	bh=u7y2KMW8O2BVH5WTXNsp2eBYQ58Awz6TWOuNBVskIKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGwtivPcirHZESIIzFfJSrSa+KIYEzSxWrIbXky538mr77CEyzEYGoCH9Fh1c4uv3nd1qaCGhR4dsDLB53S1kPkiJ8pZzV2TZ72gllDjRH5UYcP3sAsCCn3F9yKfXV6z7vYGjtMWMD8ShvxrMCoJBuM1Z4fYGYnucMfCEszRPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqsSh9wo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqsSh9wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E68C116C6;
	Thu, 22 Jan 2026 03:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052746;
	bh=u7y2KMW8O2BVH5WTXNsp2eBYQ58Awz6TWOuNBVskIKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KqsSh9wos/1xrjz+kqhtq5bBMDWImdzwtjpQHyjoQZcBRbBYLS1QQ1J4ef/Y9v6WG
	 I++wUKCHxWMwYae1zdD0dgCawIyjHDTam62o85TjwNAXthx/JENdj/LieDe8UfYBVa
	 W1ZpPNC6cUtkOBmy9IcrjVqVOhRQle7D1VqqTyb9dedrZaZF2YmdPyMDVLqPurAQbd
	 i3jv7wiZKic783aAh81I7KWdQ9CeJfqI+2zNsO6NyX8ia0JtOpTrfupsBN6w+RdXaC
	 XxSO1rtD7tZgdnqQhXvwO4HpP6vAmkkSO8GHy7l8ryhBFVpKIy5MJ9+HMtegZG/I4h
	 sxzq3xeDavFSA==
Date: Wed, 21 Jan 2026 19:32:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 2/2] net: bcmasp: streamline early exit and
 fix leak
Message-ID: <20260121193224.3bbd497e@kernel.org>
In-Reply-To: <20260120194154.2047656-3-justin.chen@broadcom.com>
References: <20260120194154.2047656-1-justin.chen@broadcom.com>
	<20260120194154.2047656-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 11:41:54 -0800 Justin Chen wrote:
> Fix an early exit cleanup leak by unregistering of_phy_fixed_link()

Fix should be extracted from other changes and submitted to net..
-- 
pw-bot: cr
