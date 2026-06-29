Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB603B42CD;
	Mon, 29 Jun 2026 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774397; cv=none; b=HOxTXiX9Pv2U/1LumUb6a24NzSEPZk3s5DvIBXnYJEF9h2lilYX758vixpuNH6qxSSJbxdezuMQcq/z+KPgv/4dtezzYNkFl5nE+seZj1dHFMcBrnY5gGwU/aGRnkPQFHL8JbXb3eXueGT4i6VAkSRStjS5R/QpOR3MzU7Nxohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774397; c=relaxed/simple;
	bh=sqXgBZQxFN0darbob5faZx91nyTlw3pO6r5sSDYkc4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1b8wMfZKZEb0FlTAngVuWe0AhbQbBD+lcpcC43s5tbjlCCYAyo5fmsVEANVHEZRTIEhusZ8JGbJVhl/SWUkOjv+Jz4ar7D3lzJDfLlBInA3lPlAO2Wf3BCzmTuyXxDYx0BmK+73oiXqhhF2H6bGq+i+I05IErNIKH8Nq1+7qwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP+n24ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP+n24ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE151F000E9;
	Mon, 29 Jun 2026 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774396;
	bh=RWlWSJaDxC29Sdj1WQq6vCX/yzQeSlt4YQP4YKUk740=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hP+n24neaYZprSLT3zscu/3UL5aC3qRPyoKVyQ3W3HW0sxQeNWvIuOZG1OAyipwNW
	 CxwTkZd6D329g1xe/3gNhiZY6q3pOJhQNl5SVkvDSfUgKU7iiTiUX9nQ5u7n+3fFTU
	 B5w2e4taUIvmFkr/j0oIKvbyOCIvD3+zpUnmE/5CdVcmM7ATQDmrFPxZA2PACqULg2
	 9x04CkLhqrf50Be/weijoHbB912KYjmg6bCZMeSBS6swfbJfy1YRBmzgF47HVAg9aq
	 OvZDyjz+ncj3EHWm+xYUxDpgi3x5tUlwxT1NyJ5LV0sDbjWbGaiHVZuNBy5AKPBodi
	 JCKwdfeLDVwlg==
Date: Mon, 29 Jun 2026 16:06:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v3 0/2] net: pse-pd: add Realtek/Broadcom PSE
 MCU support
Message-ID: <20260629160635.489e6779@kernel.org>
In-Reply-To: <20260628222705.4052815-1-jelonek.jonas@gmail.com>
References: <20260628222705.4052815-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 22:27:02 +0000 Jonas Jelonek wrote:
> This series adds a PSE-PD driver for the microcontroller (MCU) that
> fronts the PSE silicon on a range of managed switches, together with its
> DT binding.

Sorry, but net-next was still closed when you posted.
It'd be unfair towards those who follow the announcements to consider
this posting, you'll have to resend.
-- 
pw-bot: defer
