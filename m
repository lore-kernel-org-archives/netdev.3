Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979D1A6831;
	Thu,  4 Jun 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601980; cv=none; b=C4YBJb5ukmGbn79Xnk3L1KLpO5EwWUSxDXrzYeHCT1VT1WqmxtTL8jehHqgHOPeJcgTjK50G3NCLzLL5b8uY3SsTdcBOI13P91uzmi+EDsxGuqtkzCPg5Rexzf7NzFd7u6L8emcNl2LyPygVk2q0QiIUOjjrGPxV/OUv9hzDGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601980; c=relaxed/simple;
	bh=SgnaSwpfBIjjH4vQoz0VwPwIvkSJTMOSRXTx7l08r58=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ghB8IIKq6yLOqUpcAgJf/86mAz0cZng5ptAC7YVRcxIUG9MKQoBQHg5gHrgO7HJNIBzVQmbTM3ZZp+AH68tiLQIKXMbDSE0Ax+n5WWrQXrC/4jBD7Jf0hm1lILSCWt5V6a0JnW4lpho7uCmO0blItueArOUgYyimhUEHRJ0OOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hGq+2h5d; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hGq+2h5d"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12467A03DB;
	Thu,  4 Jun 2026 21:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780601967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ufGEIrrwjnWBCIxsmHUZezk4P+J4iUPqzcuaIUudHJA=;
	b=hGq+2h5d6Hrx2ZITpsu4SuD9waLx5X7iivZ+jRPJOEvSIbhDJUW+3VBHgO3Henbt3Oa5/C
	qE46C+4pZ336LOZOrqWdCEUdFg4Y9Ig0UVW3yKFA87UBim9xKhxfSFQP4uAQjLV2c7/WGm
	mvqSFIPhCsbU44qml/1iT5lMzOty7VzYZR9upZeahgxhetKPavYVSrKE3I6V/CS2BuUQFy
	8ApvrG1y+DAcQd6E8rt07aeMrHr2qFbbuvIem2j18eHt3d5qBp3M1y65qbuNRsIVZvkYz+
	pRc4G98am5jqpy4Gqooa1NWOPODgX2OkP73HSit1gF7sj5GBUCGvQyAJfwuNnA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 21:39:23 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
 fmancera@suse.de, markus@blochl.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
In-Reply-To: <20260604173205.3989025-3-horms@kernel.org>
References: <20260602094248.4130712-1-nb@tipi-net.de>
 <20260604173205.3989025-3-horms@kernel.org>
Message-ID: <2373b19cef00246c737f687685f0ead7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Simon

On 4.6.2026 19:32, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Thanks, I will have a look and respond individually per addressed 
feedback.

Out of interest, how does this sashiko instance differs from 
sashiko.dev?
The later doesn't flag anything in its review [1], so I'm just curious 
what
I might can add to my local pre checks.

[1] 
https://sashiko.dev/#/patchset/20260602094248.4130712-1-nb%40tipi-net.de

> [...]

Regards,
Nicolai
