Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7813A244;
	Thu, 30 Jul 2026 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376004; cv=none; b=l554WcLkaeFm8nNpitkfuozwoQSUyW4e/8FRDy3u3FF0oHts7cu4JLMJPDlCeE96PIDElKNtpRV/ZYqpHh4Oax1Vf3J86wWhGBEuFjRT96WdGPP4lQKDmq5YX28ZNTAYwf/arV/Nn1YrBV2o2wKTu7ZA2QuPMoeS0OWK1bbnxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376004; c=relaxed/simple;
	bh=QmJ6FHshCuiFkJNS4g/mMQ3J2KCkAci8bjgwHQkrz60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUl7H8j563UwKpN/KN6KmycrTXMhgi2pA7jLZ14gzrMv3UbOp+SUsbV65JxtVLFjmvBls9IRADVT/iu/o7bmnYVjr/f4a6xUSomSbt38RKLyHbYuuAd3qQCMUl9s3jEea6wtHAbNox71BSGidUPNCNqBNdSpTRVJdfj1GIUQkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCewqeOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCewqeOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9FB1F000E9;
	Thu, 30 Jul 2026 01:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785376003;
	bh=QmJ6FHshCuiFkJNS4g/mMQ3J2KCkAci8bjgwHQkrz60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QCewqeOLkrFrekSj0IR0XUINZqwJnx9vp+Uyl/oqBb0VR/ybKAht9DPeSrgjMhbRo
	 eMgzM5SDTt7+B31vu0KXv35Ba4NuozAiNBBpncy/q9zs1DhE59NiptdNfw0v7ecG6Y
	 KdVdz7Kx2Pw0tVS0IB1chauKVudxb4ZdHu5VLmRDB3U40Zq8cWja+zCZO9uFbfv6Aa
	 ohWUm5eef3dThQgfcy/HhgL0cLPtxWSEV4obWd9WS18s8W/1XruhATnVP6DSO5jqkc
	 jgi3CL79C4uSz9os5ZOMLD9ranMC3tqFGlrXst/cGf/dUhU4zZY77TkSEJhnqrur6g
	 zvNjwQ3HvlSbg==
Date: Wed, 29 Jul 2026 18:46:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronan Marchal <ronanmarchal29@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: niu: fix potential buffer overflow/truncation in
 irq names
Message-ID: <20260729184642.7881568e@kernel.org>
In-Reply-To: <20260725141132.408317-1-ronanmarchal29@gmail.com>
References: <20260725141132.408317-1-ronanmarchal29@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 16:11:32 +0200 Ronan Marchal wrote:
> Building with W=1 reports a -Wformat-truncation warning on
> niu_set_irq_name(): the "%s:SYSERR" format could be truncated
> because irq_name[] was one byte too small for the worst case
> interface name length (IFNAMSIZ-1) plus the ":SYSERR" suffix.

Please explain how you tested this in the commit message.
If you haven't please leave this old obsolete driver alone.
