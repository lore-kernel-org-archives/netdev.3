Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4D1F4260
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259312; cv=none; b=frs0C54s6hdDohulRWd/jkO3G01rYdfrrPJy43nenTE/jX4v9tD+EH5WUm3YdcH2HpxplGCqi7M2Arpp692/LFf8S3dvJY5SwwYDCa+oqmSDD3XdEyf2kRAbstXXupZsKSleUgM4EP1I42jgCYFEEyyjfT8cszaKa8XWbZ8XcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259312; c=relaxed/simple;
	bh=XqQrHBqI9k7qMbwkErxCdXCDm9yLEoECt4WBngBym5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWZooyc+rli2jbDdYmcRHM10f/IlP1xci0wRb4TUFr22AUTPEskmORsW+knEq657UoHTB4SpVzeEV0EQF9plIg9S9smNeDfTzgLEsQGTDbuh5p3yTX7sXl1Ju1fNalelb1coLu8HiFcdODTjXrfVRHhpz2x+M1fBtBuF2FErUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmYnwNOL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmYnwNOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E672C4CEDD;
	Tue,  7 Jan 2025 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736259311;
	bh=XqQrHBqI9k7qMbwkErxCdXCDm9yLEoECt4WBngBym5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmYnwNOLjAv/VVl70FhMz+s7C9kVrdnFm3qxA3NV38Ffmx7yZX4UkJhlkBr1yAlca
	 i4cMLFpwv66t+Bn1dhJjeOZcRZPyzVpcjOyGP0hj9nnZW52JAZVOZB1SjEC4M0AdbW
	 HRG1tDCYzhcy6rxaTWm1tUPz4cVAr2Pnn/QcYK8bpmIal9H34GfTCEQnPNvICl6oYa
	 QGwX58ZoFTuCjx8lCd2RmSyRKLOScvsTo/pyh0jY2353uUMo60WZJ21TO0NI6JYLMu
	 XC7p6O0uGK70O7nVJ48ILFFgLnY+WMx0bnb4+J95KgzLAJNiDINm1oG9YYrZCBguco
	 85pEao/9GWjRA==
Date: Tue, 7 Jan 2025 06:15:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and
 homa_peer.c
Message-ID: <20250107061510.0adcf6c6@kernel.org>
In-Reply-To: <20250106181219.1075-7-ouster@cs.stanford.edu>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
	<20250106181219.1075-7-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 10:12:12 -0800 John Ousterhout wrote:
> +void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer *peer,
> +		      struct homa_sock *hsk)
> +{
> +	struct dst_entry *dst;
> +
> +	spin_lock_bh(&peertab->write_lock);
> +	dst = homa_peer_get_dst(peer, &hsk->inet);
> +	if (!IS_ERR(dst)) {
> +		struct homa_dead_dst *dead = (struct homa_dead_dst *)
> +				kmalloc(sizeof(*dead), GFP_KERNEL);

coccicheck says:

net/homa/homa_peer.c:227:32-52: WARNING: casting value returned by memory allocation function to (struct homa_dead_dst *) is useless.
-- 
pw-bot: cr
