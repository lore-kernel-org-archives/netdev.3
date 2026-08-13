Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787023909F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629235; cv=none; b=PZj3lIClPlGisWPRixGs4Ipg4glchkzirMh51tHaLj5emD+O9J3Fh5wcWLY4ixTuK02u2obINEoBqQUMi5MH/IhmWIiezqQdRv4aanqU4sLFzA0GC6IFTBEa24gMh9kxwsRv8awZGWrjtULxTg5kYexcT9l2tfsxAgG1SEkrmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629235; c=relaxed/simple;
	bh=gJJsf80b5r0P91TTkz0scfa1m5T+ajJ2hDAzqDw9JZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPn1JC8x6F+qvxM49C6h608I15FiknDUNydciiOBQGM0IpvyoJaTL/uohrZ5RV1QjLFmRuCPeZZMtDQCE6YNyY83++9sqak2S5pieMLnxJ+CLYiSXDbTm1LaXC/33A9fXPumB1VIr9LM6MACJQsE9hQrb3CQz90XAcJ66nUXRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUQSuWNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUQSuWNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144581F000E9;
	Thu, 13 Aug 2026 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629233;
	bh=cH1XTCPOtw9XNYAoPRk4zsliIGXXRYDZxk71AsRzPsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUQSuWNIXp5opdJqWjNZNOqNq4cVAskCbYeFYcRqUi2jLSporVgjJ4SiMMVoOh/Vu
	 RqVkSpeHhh00WrAYB/ubPG7+jyge3fSIrjzMUfnBotl8G1+H14raC9auoXnUWEQYgb
	 g8Zayf/H4tz85srd10vuw57h1gn7qplaA7roFwMUVn5v1JW0pU2m1MAFv99M85hiWG
	 UukyYX01Gx+D69r5g29Dbz3/D8d7Yk5GvTMEScDCIj2A5ul3Lgi7DCYlJiM1ypw4ns
	 7ZvD5b3C2vy6fEmSxZF9L1eibcbdd1zc7ZyrRmxnbFDtmybpaQwY8tWqsNrPFHi2E9
	 iRmwtmttRyWrQ==
Date: Thu, 13 Aug 2026 14:53:50 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prabu Thayalan <prabu.ponrajthayalan@amd.com>,
	"Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: Re: [PATCH net 0/2] ionic: fix completion descriptor access
Message-ID: <20260813135350.GD265046@horms.kernel.org>
References: <20260811195039.1315045-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811195039.1315045-1-eric.joyner@amd.com>

On Tue, Aug 11, 2026 at 12:50:37PM -0700, Eric Joyner wrote:
> The first patch adds the missing dma_rmb() between the completion
> publish checks and the reads of the descriptor payloads, suggested by
> the Sashiko review from [1] for the second patch.
> 
> The second locates the completion within its slot from cq->desc_size
> rather than a fixed stride, which is necessary when IONIC_Q_F_2X_CQ_DESC
> (double-sized completion descriptors) is used (e.g. for hardware
> timestamps).
> 
> [1] https://lore.kernel.org/netdev/20260507155928.2537928-1-kuba@kernel.org/
> 
> Eric Joyner (1):
>   ionic: add missing dma_rmb() after the completion publish check
> 
> Prabu Thayalan (1):
>   ionic: fix completion descriptor access with 2x desc size

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

