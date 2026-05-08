Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8339B4BF;
	Fri,  8 May 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278704; cv=none; b=fUVFILNCPePYfZDDG3yReoJ21gnw/ZO+XQPxxYGf6BUXPR8+kouvJrfGa7P/zcLEYJKEVFide9OM7CDXbVHnWq5SY86y6ZIH9pAZIjAJ6MKK/y4AThGLs7TScZnCLTBBXXFz25bUNsoN6T92Yi11abHNbvzTGAW01w6tg2io2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278704; c=relaxed/simple;
	bh=qucLFUu3sWxzxiaWUDUCyCmzOTccuJ2EzkksFsYKwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pxqd2EKnI/wB/l084ECHjuhE0mILvrjnihpI5AE6TLiYAEbDXRbjBdzRrUqbUjAfbJThTgdhSfjor6UK5QblnqSYMf2M/AzxhtRZgtY+pJgrY66q+TCueeSsgjPSs8GRnU5bHapesrd/84DNb1vUER0xH+f8OvfkazDxHOApiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVgz9X8W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVgz9X8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D7EC2BCB0;
	Fri,  8 May 2026 22:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278704;
	bh=qucLFUu3sWxzxiaWUDUCyCmzOTccuJ2EzkksFsYKwWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NVgz9X8WDMPUPPoakyXJiYQlLdbJn8QEdEwcsJ6DEvBwJQ62DJAzpUPq275p8aH07
	 wGuLe2MvWHhDLvAXHGS5nGnCng1pIzNvY1PC9Tg3YBMl2KhcQrDN53TI7I0MaWA8Ve
	 XBL5T+eW4CdtqHykMG24K9FQynI8TJcCvkoa2mqgF7b3On/kVCMuDHkau0m3hHPrxV
	 N82Mrys9VvGTKlcCsNl+5NP+E8MkJk76QE2uNF1U/e4pivP3mE2kJC72aR6K5m3sv7
	 wG6IvU5Wad7P1m/YUHy60o+UlQ7uIjj/YGMuF6pvAys6xKqAFoHbEIqxkLxPnCq1FK
	 Z9zeDP5hasuvw==
Date: Fri, 8 May 2026 15:18:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: faicker.mo@gmail.com
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: net_failover: Fix the deadlock in slave
 register
Message-ID: <20260508151823.0a45feb3@kernel.org>
In-Reply-To: <20260507074332.2543229-1-faicker.mo@gmail.com>
References: <20260507074332.2543229-1-faicker.mo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  7 May 2026 15:43:32 +0800 faicker.mo@gmail.com wrote:
> There is netdev_lock_ops() before the NETDEV_REGISTER notifier
> in register_netdevice(), so use the non-locking functions
> in net_failover_slave_register().


net/core/failover.c:227:25: error: implicit declaration of function =E2=80=
=98netdev_unlock_ops=E2=80=99; did you mean =E2=80=98netdev_unlock=E2=80=99=
? [-Wimplicit-function-declaration]
  227 |                         netdev_unlock_ops(dev);
      |                         ^~~~~~~~~~~~~~~~~
--=20
pw-bot: cr
