Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763197;
	b=dQIG/GMFB5VFoXnzyxF/yFBQNrRzkkddz+8Twf/T0c3HjP39lBH8hNE7s6IyZduMZYca
	 6YjjniToO+e7+cGLA6f45AeBQH/hcIeg4QpbqBaWwbt0CHwsO0CeFQWnWJohRNrVrFfDw
	 sLRD0QNlgNYWcin2u0b03R8Xv+KkE+1MURYGBArGrsw3gYVLl3AiCXRvGEplOTtjcvX7n
	 dpBku701gI+L+AkE5UQPY/DqGU0RVZc8YKx45IPmZOHeAtpY6QIOo1pndS5yiP3/I99ah
	 FoaT7/lRcydz9qB/2w0s94O+dBwCiO1TB+XbV7NAY9CFBXHoClmPI0nuMEGrIges6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=k5Ew64qnx/tMnhYzneWa+POmTuQfuSnN4DyxhQToT8GtcixWOs0BcTpLdN5xJ6jC+OMp
	 d1BwThMvB65Dc1iOHenhniCQ4Qeqc+jsGZ8vSDlRwV07BeRd4FNdYC/CIuX97d8V4Q7Kv
	 VZALBBPLzS4sp20J2atS90rPZoMPPlvGUG14++BD2gAjwBSsvpxFwKgO8eigs4EKPUvPb
	 4+1vXh6ZqX4CRy4VX732K98mlRycPKUsaLZxy5SjuUHhvk8VaemnloyoiVny+IapSVyOr
	 vjWucKQ1Y9NvliJ0F79IFB9HwDxANVey56dI8k08bOlhIIVb6DRwMbtuS0vjgEIzA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJYMPb4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A71606A31D;
	Fri, 23 Oct 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJYMPb4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302281F01825;
	Fri, 23 Oct 2026 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792763196;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJYMPb4O9RR4nN5Z6k7oyB/+pHoMAsfRAQ4sf8+N77qJeSAi40CDRZIQXnkVk/W9x
	 +xGkdyVdQyN5vvhvzgXJq/bumlWRIZP1D0pcc7Xcs2SrP8RAz1fu55UIMmHadYcfsx
	 mv0ygw/iAd8tGw1a7lsD0r4C4FXZkeXw46PTnEOBU8VTkgGgvRHtfS9SCAikdN4dOp
	 6PG+Y4CwDdIHUBcNg80GRkuqBYs86sIhivL69XmF8KzcEKURi2Wn5D6fUi3WQ9C+o/
	 REyIh00anmMXrGjPEkJV0pllQtKww3dQfCLS4p21OjrnG83Qqj45s2rfpvaaDKwlqF
	 at/MFli0xnqlQ==
From: netdev-bot+sinfo@kernel.org
To: Sicong Huang <congei42@163.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
Date: Fri, 23 Oct 2026 13:46:35 +0000
Message-ID: <179276319567.3327.5663989857967667834@kernel.org>
In-Reply-To: <20261023134214.322796-1-congei42@163.com>
References: <20261023134214.322796-1-congei42@163.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
