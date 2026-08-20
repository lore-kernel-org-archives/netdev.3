Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432523DAABA;
	Thu, 20 Aug 2026 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259563; cv=none; b=P4fJP1T38hhK1xZ1pgA07cOW7lBwA0we0NHVmLA/jBBEkDe7y4/UR3Vxxl+bOEki1R7lw1Vawnj31NtGZ+/PDS55vpdDkV0AL2LY/Bp2jXadnQ084VNdpGQX7Yv6hmUqf8T+4o5RLBPTdg31fevtRNp7Irv71yvcqmyqGxl6kqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259563; c=relaxed/simple;
	bh=zLQXnlgWL67vKRme9ee5o/Nur/KpoPe1+Zh1SINe+9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqmW+w3CvgaGTX2NznHbWDISnFQIncyDWWpsomxoE08i8uFuNd9TheEAg4MYKOcHSK59aM3YPEyEkSWxu4TB1L2LYhGR/XTflAEeFxeJ/GYdmzoiJ2RQu9Mmc4H9PWHc0gYWix9nfujDh58Fjohx0A0K87dlxM24QSdIphvoHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkSdilam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkSdilam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8D41F00A3A;
	Thu, 20 Aug 2026 20:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787259561;
	bh=BVUoP/wJnPkpwCyRB+Rf+gHbx6X5pGwzIc7l0U38FD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZkSdilamJ9+Zoy3nqISv1AUDikXC2uegQC4O8HjTr6GjKVu+FW7KCNWIm90wZqulV
	 KnCWOVnAIZOly+OUkwj5bv7yncnxGCDapSMx476/rC9ALibPyItotOip8ElBe04+G6
	 v+Rkb/nCB4bZa6yCg4MvnUOUdlUqmhHPH1T9PtVJY7ppnjzZTgK9MX81uap1LGN7UI
	 UQlnS+R5P6T9pRLJ1d0owcwfC6JmLnhuZXYuQe65SotipZqbph1HcOP3gRK1jNjhTk
	 EycrzqRPQPjLcMvKSlIGr+mp5r8Xz/Ua9PWN35g+uAxAOIJzKF7c8sbVN0Fq2qaq8D
	 5NIaSg/9iyeUA==
Date: Thu, 20 Aug 2026 13:59:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Khromov <haa@amicon.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <rrv@amicon.ru>
Subject: Re: [PATCH net] slip: fix use-after-free in sl_sync()
Message-ID: <20260820135920.7a99fd4c@kernel.org>
In-Reply-To: <20260817070952.1155579-1-haa@amicon.ru>
References: <20260817070952.1155579-1-haa@amicon.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:09:52 +0300 Aleksandr Khromov wrote:
> slip_devs[] stores bare net_device pointers and takes no reference on
> them.  sl_sync() and sl_alloc() walk that table from slip_open() under
> rtnl_lock(), while an entry is dropped by sl_free_netdev(), which
> sl_setup() installs as dev->priv_destructor.

Would it not be a much simpler fix to move the deinit to ndo_uninit
if we need rtnl_lock?
-- 
pw-bot: cr
