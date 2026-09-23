Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54E36494F;
	Wed, 23 Sep 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129345; cv=none; b=eDrOkmed7yBL1O7paYaAh1dPkjf5CxOW+N5Her/X6/iCuHz8RJyfwDxeUQ+IKobj6uEnh9zvmbwpvlPGLsF14Uj4VnmqWD5OJ7HDC+YmG3BGjqOgythLKB6B8IqqxXuUSuYQbKe9VoeO5n/8wf7UZCfiibYRVKUhtFiZNGxfjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129345; c=relaxed/simple;
	bh=GZiUxFupbuyEo0FjKSmPTDQkjThuwo3ha4HInzxKB/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SabV2DmjmhcHL4xg0HfvOvVK0h7y6gUSKYrGpRvYR4gYA+BXpdUeJZhEXZF2crRqwIwOUXpRmfcasX0/alTcNDfsJPFWZBbUfFkj/9gG7sgHvEnCE8JpZls2Tz4STWzoGlUQ5pkDNyHn3KiVr+tPy0Ox7JUz/TfQcscd7Bpg2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLf8ijAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLf8ijAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864A81F000FF;
	Wed, 23 Sep 2026 02:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129343;
	bh=ycumX+CH/+RPPTODlC1GsiI59VcEmP8dxst+sGpgO8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YLf8ijAzOZWjJPwm4nm6X/uDlYp7/JgbjfSOro5nTUsP7F5faD7ZHRE3ma5sKw5pI
	 5YNY1YfDSUeqSBTX6GwkaPe9+PXXSk/YGw+S6n/WElyqvvl6pZn/Gkyo5iEme04fyi
	 eQHlLBhbikGh91zCMjTKDSXc0GUi5Df0zeHf7XTwYDGGZxv7u4MO8vz9xwTN7bdycp
	 JWU6AQc+rqoQupjM9RHCHGv/L2wG3zBy0ZYM4jf03k4vkw3ViS5XX3MoacwvAmFYaC
	 qp8K2x+atIC2Jx89dYbbH65b0xOODBuseYQBcHEHaAfQRq1rUE1Q35Yq64ZRQxh6Kf
	 MyghOfHHx6t4Q==
Date: Tue, 22 Sep 2026 19:09:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Kimi Security
 Team" <bug-report@moonshot.ai>, "Weiming Shi" <shiweiming@moonshot.ai>
Subject: Re: [PATCH] tcp: fix use-after-free of retransmit_skb_hint in
 tcp_send_synack()
Message-ID: <20260922190902.0094ee4f@kernel.org>
In-Reply-To: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
References: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 14:34:19 +0800 Yilin Zhang wrote:
> +			if (skb == tp->retransmit_skb_hint)
> +				tp->retransmit_skb_hint = nskb;
>  			tcp_highest_sack_replace(sk, skb, nskb);
>  			tcp_rtx_queue_unlink_and_free(skb, sk);
> -- 

this patch has been mangled, please repost if it's relevant
-- 
pw-bot: cr
