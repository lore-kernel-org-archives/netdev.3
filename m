Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B37308F1D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330622; cv=none; b=CRSBtlpTsul1fIDQdCT8rRYrCsHD7oiyWtbmVTIQXByummvUFpTIzb/YWEjNi+fZCmP1EnHsX4hatCd4+6f9G0x3UqH5svN4q0BMRFVGztvwGVWxqpfaYSQ9uKgSKlj1JuquBrlQGIZA0ZkYloTCgnhYAvtrilj4j6iDoRkqVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330622; c=relaxed/simple;
	bh=mJlFckTn3CEfwCBeg1MgUufdZ+fSAoKpR5pi4tvRdSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdhktuRxrZQCJ0x7bBa+BRJq4yDzqnLurv0X3E2EG1IdrgYdeGRbFvURvLZ2QFyEMbtaS71DW6grsTK4jxs7WE2lOHJee3LKWIvIzIiVuYfIEO4AtEZemYo3DISYhPGz7Nccp8KTJIS9cnbw59YO7wcDQJbm8c9m9L8a2vRfuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8gJm4GS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8gJm4GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD41C19425;
	Mon, 27 Apr 2026 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330622;
	bh=mJlFckTn3CEfwCBeg1MgUufdZ+fSAoKpR5pi4tvRdSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8gJm4GSmzyu5vRTgGMDCTYugCQyh62FPDhNhLbeey3qYahx1Ueo/KHSjr6vT1xb7
	 MLtM3b79YORjcCFqHBGuFv2TQ8lojYKuNuxBG0CutUdVSKFgsZzBVmd0lPDX3FL0KV
	 okxpxzeTRFeTheY5aRrqitoSlZGO0Ei/w3V4Mdj9uYX2gcw4ZJz5Kk/rXa99kW/5H1
	 GRJqDA9yh0SW+0ASycQ4VvwB2q38Q06j/CEIyYgv58JLqZxZPNWwp8VYtcu1Yn4yil
	 Cq7IubFX/Xmfhey6gtA8iD7iI4+R2qx7qiriYftzh3Dhc6zQhZ7m0vn//rz0Ucgf3j
	 7ZJxKWyVKRimw==
Date: Mon, 27 Apr 2026 15:57:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v4 net-next 0/3] Implement PTP support in netdevsim
Message-ID: <20260427155701.6b535f7e@kernel.org>
In-Reply-To: <20260427164727.15418-1-maciek@machnikowski.net>
References: <20260427164727.15418-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 18:47:24 +0200 Maciek Machnikowski wrote:
> This patchset adds support to the PTP HW timestamping emulation in the
> netdevsim. It uses existing binding between netdevsim and ptp_mock
> driver to generate transmit and receive timestamps.
> 
> It also adds the selftest to verify the hw timestamping functionality
> running over netdevsim.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.

BTW the patches don't seem to apply.
-- 
pw-bot: defer
