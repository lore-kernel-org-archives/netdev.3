Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931073AB273
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476504; cv=none; b=EQdqjDLh7t/athfAQkTkmLSDfI5cKGofBYMfwWSph5Wwo3NJfIhXjaT3oTJQJWF+r1Vk0qVuouRb9tXjDXb89KEI4nJmbnR4s8gCrZDhVUmXha/vsjWZqCFHQYZUW1PmnotrtAwbE564+N4Z5tG5N4M1zuqI0LYtcvdVFb7kVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476504; c=relaxed/simple;
	bh=zqfDJSQF4o9Z3Dg1RgDEAtJ4MqHyIaHNYpzkXWzqmm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/IoqAYyQsD9T3dwMLByjWD+z1AmJNsNtmGiDlJBnH2ExtcWpo1x4ibOtbCbUNEneckPvAbIQht4Wrz7BQGDf0xuH4JgSpFDhVQ2NUsW3XOWrl52tyqMno08TyUAeHPMHq8Cf4Y0d05vb0PwotSn7EavNX2ooTnA6hGXADH6OhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fSZPVTbh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fSZPVTbh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JPtdV2jE/10k61k3l5TSAVhq/lNp0vTQIpUgzYbM8C0=; b=fS
	ZPVTbhQvCBNS3ZJ542fC+6yCYwAchsiV7JVwL1joL2mbtAEWb0ibQkSLmN3DgNur/QpMI8Qvt/WOq
	xuUZtguZ0Gn61i1R1m1HhO3gI0FzNiYZbcAgC4LK4xZrq+wrYuJ13Sr2MeUZZk9brNgzHDP6ecIDE
	mTuZKqHZP8rs6ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlTqs-00D6Xs-Oa; Sun, 19 Jul 2026 17:54:50 +0200
Date: Sun, 19 Jul 2026 17:54:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: danieller@nvidia.com, mkubecek@suse.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jbe@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v3 1/3] sfpid: print all implemented options
Message-ID: <419c2df7-6a46-47da-b4eb-e1a2f34a43cd@lunn.ch>
References: <20260719090458.659332-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260719090458.659332-1-olek2@wp.pl>

On Sun, Jul 19, 2026 at 11:00:35AM +0200, Aleksander Jan Bajkowski wrote:
> SFP modules implement multiple options. Before the “json” option was
> introduced, all options were listed.

Hi Aleksander

This is a common theme here, the json option. Are the three patches
for things you noticed for devices you have, or have you analysed
those json patches and think you have found all the places it broke?

Thanks
	Andrew
