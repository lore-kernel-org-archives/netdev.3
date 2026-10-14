Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BC4EBAFE;
	Wed, 14 Oct 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983150; cv=none; b=EJ26vm0f9gXpdCcbHXRPUeAT+yG7tOq5jw+pTyta49D3dZXKtzZfYNFqhmErUy4IodMsM3s4JJuqQLd2kScNqIdBtcLyEJ/KZ3wyauucJLaxSJF/a/WLo6AeBrvmNbjdniqLqiDMuGZsZKb9LYkZBAw9NEDF8OKqdJgcZm6nsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983150; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JckSWuw4agALMEJm8OdYzC44PEs+M4J0jU9XkPg4aiJmKaH0qE9rqouTYPvySBK8TqwhcKbpbqJEfAc2NY+ygq18v0miZzjKR/SfAF2JjyYzVa/mVRzBP4Q8g102zVJSQ8+y3783YdQ5qxYEBGq3WnpPQuMV3k5sb1HN+gLsCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRkzIA7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRkzIA7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8621F000FF;
	Wed, 14 Oct 2026 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983148;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRkzIA7P6kReMHys5hr8tjkJt9YXh81X7TVdLyTPgQakkRldWUIwzGnk0++peqf3m
	 dRtWMvOXhL9HkAhbZ9AqxXzz6sHtVo0jSdqtnrn/0RtjlKRrd4glSLOBAmjmzoEU0z
	 LKkqU7RcGYqalB9jpmbksVif/W0yfwnK7Js6hbVP22PzizygLIPDtVBfIlB8z4+h6C
	 p42UhHWtZnoQRhgGNOZoG1AlXHfiuMh996lysDT33eayNX0XuVFPNbJurA8HNUKW3b
	 E2b0yg1tTvpK1Yz7Oj5zZdhI1Vyv82tGMrz5wfULAS6nITI+vWCkuIR4EwXoDFuYzU
	 SaPXEEX8/jv1g==
From: netdev-bot+sinfo@kernel.org
To: Rishi Kumar <r-kumar12@ti.com>
Cc: netdev@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Meghana Malladi <m-malladi@ti.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 j-rameshbabu@ti.com, aaron.richard@ti.com, l-chinnannavar@ti.com,
 m-santhoshkadavan@ti.com, k-tiwari1@ti.com, a-dev@ti.com, pratheesh@ti.com
Subject: 
 Re: [PATCH net 0/2] net: ti: icssg-prueth: fix port config and rx_mode drops
Date: Wed, 14 Oct 2026 13:05:47 +0000
Message-ID: <179198314724.320699.12261216986083339257@kernel.org>
In-Reply-To: <20261014125948.230571-1-r-kumar12@ti.com>
References: <20261014125948.230571-1-r-kumar12@ti.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
