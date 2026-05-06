Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCF175A60
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029049; cv=none; b=vGlUp9SXBm/tf+6q5hV4Fo98cJb1qtH0hQZ3YZ5651xBoX5tjKo7GZHxvGevdl5037MA4WVweIb/RjzGLgjZkE6pPXMn1WQLR5VMDxXs/ZB3w0Iomsd83PwNS/BliThzisyVUN7kj86uHWWTQG7bVMqml3h0hazv1OcZ8Q8hbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029049; c=relaxed/simple;
	bh=70Z5kUEk//V7YOS3AiCB41vLCXf/xXrGw+6TBYaTx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSGtJSPYJqcZIJg0TBhSmLz9Nh1PHq+z4TioJOhBEkPH2YhWi6vWkkBS23AlAI+u6reBEmJA/Kmx4N0+fy4QNXC5/9NjvMjUzaV9P54cL+KMjQ4+aZDyJ67ua0Dl034btNaEgtA6GqFMBjWYQkQYP/2NfoRJPBIS1FbkAew91LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfZSZ6ZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfZSZ6ZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78AEC2BCB4;
	Wed,  6 May 2026 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029049;
	bh=70Z5kUEk//V7YOS3AiCB41vLCXf/xXrGw+6TBYaTx+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OfZSZ6ZGvpiyaa5HESV08okekpkBoea4N8jtpw+DJ+zRVN9uSOhKe0eDlHwv7oI/C
	 9qQIpm4/LaOy3hxZ0QkzaZ2gxgbwVmeERDO32N1MdNvlJ8A2vfrv+crojqR0cr4vv/
	 Apz+EJQhwS0yKeZQkafEjC4zj2zQyC7sXkGyV3a08Srl/wQ32punn+gZ9DKrby09HI
	 szWecVAckwSXdywzOa2TCsvwW0x75D2oCvkP/X9Ij9ymrdRsKEfsl7sDTqJGlvhOIu
	 Cdpe1PjqvlqWclIn55FhcT48+px2aDLZv3QWC0SmQ8iR/uxTn+7mn1KqmDAZbI9KPS
	 emXC/XrL2lyBA==
Date: Tue, 5 May 2026 17:57:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 10/15] bnxt_en: Add MPC transmit and completion
 functions
Message-ID: <20260505175728.001f2122@kernel.org>
In-Reply-To: <20260504235836.3019499-11-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
	<20260504235836.3019499-11-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 16:58:31 -0700 Michael Chan wrote:
> Add transmit, ring selection, and completion functions for midpath rings.
> These will be used to send control data to the crypto engines.

drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c:488:16: warning: variable 'handle' set but not used [-Wunused-but-set-variable]
  488 |         unsigned long handle = 0;
      |                       ^
-- 
pw-bot: cr
