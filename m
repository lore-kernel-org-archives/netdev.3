Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF143A451C
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359606; cv=none; b=d3Zko0RdfNbsNMBY2gNQUkiYfLmHM5Qz7OkSgrDgn8IBqUsF/gT8vKY7Pi/VhN0hipI4+Oqes0S5LMl9Me+42dTxVMrtQWaU1tugoV8PXuRmi2wHOY+ICAOlGcOGOhELcpzjPnJCfnEUJhHEs1IfNMEhPauQMK7HAX+jjMuqzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359606; c=relaxed/simple;
	bh=Lw/xSbS2BEfl7ElzVwa7JtpmBxr/94My5+KXHxZr7A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJNgYVUwthW+G8qhBnpk6Sp1iarmjOY/FjpWlcDgiCINgajbXs+eejetreYeTl0vQQO3MROTIGO7ga3drXUUAXtFzV8SW8BbwLbegKCvlO47yazBRtbfVi3qJOfxN9WKTGVazFYjLPD1AliJQytV++IE6DQJ4et3X19KZwcuRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYoh/9+o; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYoh/9+o"
Message-ID: <cd952f45-e56f-4ba4-98fb-997a288d94ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779359600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0d3x/M+nUd9pMERJfA3CArWRnnzASO9+qnQwHmS3LZo=;
	b=KYoh/9+opz34nliXAzsrmOaYIvVvcHMV2J1xjxROm4LAiaeaxeXRo981I5UBxM2AGOfDij
	bMVJv0RSluUvC0GVKtC/RheYLyL7E3CTjIfNsp31KAD9LwqSGInflWJot+qP+GUP9zBYju
	MOZl686f/HkkgxYQ4rl+5FXNjN3SknQ=
Date: Thu, 21 May 2026 18:33:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] net: team: fix NULL pointer dereference in
 team_xmit during mode change
To: Weiming Shi <bestswngs@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260521081159.1491563-3-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521081159.1491563-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/21/26 4:12 PM, Weiming Shi wrote:
> __team_change_mode() clears team->ops with memset() before restoring
> safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
> running under RCU on another CPU can read team->ops.transmit during
> this window and call a NULL function pointer, crashing the kernel.
>
> The race requires a mode change (CAP_NET_ADMIN) concurrent with
> transmit on the team device.
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   Oops: 0010 [#1] SMP KASAN NOPTI
>   RIP: 0010:0x0
>   Call Trace:
>    team_xmit (drivers/net/team/team_core.c:1853)
>    dev_hard_start_xmit (net/core/dev.c:3904)
>    __dev_queue_xmit (net/core/dev.c:4871)
>    packet_sendmsg (net/packet/af_packet.c:3109)
>    __sys_sendto (net/socket.c:2265)
>
> The original code assumed that no ports means no traffic, so mode
> changes could freely memset()/memcpy() the ops.  AF_PACKET with
> forced carrier breaks that assumption.
>
> Prevent the race instead of making it safe: replace memset()/memcpy()
> with per-field updates that never touch transmit or receive.  Those
> two handlers are managed solely by team_adjust_ops(), which already
> installs dummies when tx_en_port_count == 0 (always true during mode
> change since no ports are present).  WRITE_ONCE/READ_ONCE prevent
> store/load tearing on the handler pointers.
>
> synchronize_net() before exit_op() drains in-flight readers that may
> still reference old mode state from before port removal switched the
> handlers to dummies.
>
> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


