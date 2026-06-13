Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4E1917FB
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394805; cv=none; b=ckM9H4mA1BMtpyU2yl75/E/lqjGTl6l4CmHfUN+/ppzVnXn5JKxszWLJKEr0vnajJ59W5zvbF1yWXrS+kjam5o8JORkKq4PLpxzj6F3sm+GdY0hXMhRrzAhRIZP0v9Wvws1XPLThze1xAQUnDP5ZTUFJApzL8DH5Bd7PrAIOn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394805; c=relaxed/simple;
	bh=Gh/jgUs+VSs3ksPkSIYzMYQdtzDG9rr/+VyGVEGOXcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWtkkH34T8WBgzOfILFD2z//SnM7EM7Te92eEbidrtfFfMiHEKYcLFA5xv9xOoF/ztyNsXRVwlW4T/jhb9qeEWad9QdrYov7Qyiv9aZnu/5G+CP5l4zop1Flt+on86Gs727kjJzqNsIBvgcSsAkaBjG175/EHcDktEoMrVWMntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB3TbE/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB3TbE/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D194E1F000E9;
	Sat, 13 Jun 2026 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781394804;
	bh=w2ko9AYxQoG17RUdqQXRwY0WOC069bpCBJrTG6aiGn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HB3TbE/3Uu4s7h70MrJE5pm0nYJS/yY9C9sAJRPSF7bZUNsL0m4sfLSscNihSFMg1
	 m8qkjLDEaZXv375mkKM0vJTEAh75HFtaayxTbJV4JnVfVZWQ0qDw4s+R+AHU6UM52n
	 O028U26JgMfG1ED81y36ppHQkpOSQA4yPa/tiot2Iy2s1KLxg4QLMWciWq2NYGn4Gg
	 GFMGaP5brk1/cEK9HZzOwWhw75rbmAjfJwtKoZBibypnxxMHEKIOUukqft3L5VPlIP
	 KfvAMRjFtG1H9aHKRoH0wULhnsci3HMXsVNeJKD2CQbedmZiO68zGwhxnH3i8qLIwR
	 qEQ4DFaLfU9Ag==
Date: Sat, 13 Jun 2026 16:53:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v4 0/5] ionic: Expose more port stats to
 ethtool
Message-ID: <20260613165323.4df246d9@kernel.org>
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 23:18:25 -0700 Eric Joyner wrote:
> - The link_down_count from firmware mentioned in v2 was moved back to an
>   entry in the general ethtool statistics; the existing driver-calculated
>   value for the ethtool ext link is more appropriate due to the firmware
>   value being a small size and not resetting between driver loads.

There's a uAPI stat defined for something but you don't use it because
you can't be bothered to handle overflow and reset? What am I missing :/
