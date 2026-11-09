Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199308;
	b=N0mByEnLRiNLZGJG6T1bC/5CusZZTuEkHxZX/XLRqkz1pvpoXPGWqM1Of3lXTSCD+/rW
	 pQMtdm6CrUcrv183R8nZt7Z565jaqXgxR1t8y42KV7/11oWJN3O+KEtJOhLpvXYlFuNfa
	 1Ztvfwv57ax3kFQLjcgNamZr371IV4tRCMoBuwWaMSydKZgMGhHsUnwarUiMLQdOAdJ70
	 0wkrksJojr6dl1hD0bj19WiWwIWnyAa+0E3LQgwC1o7bw32z60MBeHAakgeN0SJxWTxoQ
	 ELgBxvAYG0siGR/En5Wl1W3o3Hey5knOVvdlErVdnslSGocNKZdYorUbhbCy/fPhC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199308;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mrLMe/G/LdjTbr8iEkfGFK9QD4NyMpRXAKvb2Ug6hN0=;
	b=Q3yhK620gFUTL7IxsjqwU2H+3MriL5Ki/o6UNLo7ZeyPtWB+TJPgzM8WR3iFiwpBecEe
	 8BrDaqQFFr/GvlrXL6vXr05CMPFQHHD0Dax7xfkGea0mDLf/OckY/CaP3RZKDkfexK2Ta
	 ZRxcYgLrSdAodytoaaupjvcFAZBYZwCHnGGG9Ql33odNFV8Kb4muGKjyLLf8aeV+D/nXE
	 WOu4fHKcZrvrezbjpjGQc0FA9n6xSqWX8lCWUMlOEy/Od3R7kyzA7mdCg87MLl4vmfK1S
	 tIMsVCzyRNejmiN1NLu/vZn+1y3rJru1cLLzRLwBBGd8GhxCaWMa6HG03y7G+XMt8Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=aBTmdyBu;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D80606A31C;
	Mon,  9 Nov 2026 04:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=aBTmdyBu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794199298; bh=mrLMe/G/LdjTbr8iEkfGFK9QD4NyMpRXAKvb2Ug6hN0=;
	h=From:Message-ID:From;
	b=aBTmdyBuv2yw1IoSREkt3NsNU95NiF9/6WhQaeMyobooowb+zooQEa8Wl3PWwC9o+
	 Y9lKVZNrfblWmUQtN3NXtvUEBuiUe1Stw62DoB7n7e96La3vaSosZ+05g1xO7gCVAo
	 2O9/RBd87cheaJCOlcvhOFgWKRNKVMc32UVQIVxc=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 0E739C0954;
	Mon, 09 Nov 2026 05:41:38 +0100 (CET)
Date: Mon, 9 Nov 2026 05:41:37 +0100
From: Willy Tarreau <w@1wt.eu>
To: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH] wifi: mac80211: use frame link_id when adjusting
 link_sta on reorder release
Message-ID: <avFPAfirXzsNWOc_@1wt.eu>
References: <dYfRhWjvPLvnRlGAXf1svcifESfUexTeJbDV20GUaTUimkPONN3lwAZPHogH48gXZluH9txGQ4eJaswHEsWGshWlJxYvRlUPh0172G3W64Q=@proton.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dYfRhWjvPLvnRlGAXf1svcifESfUexTeJbDV20GUaTUimkPONN3lwAZPHogH48gXZluH9txGQ4eJaswHEsWGshWlJxYvRlUPh0172G3W64Q=@proton.me>

Hello,

On Sun, Nov 08, 2026 at 09:35:44PM +0000, Noah Weinberger wrote:
> Hello,
> 
> In ieee80211_rx_handlers(), when frames are released from the BA reorder
> buffer on timeout, rx->link_sta is re-fetched using the *previous*
> rx->link_id instead of the frame's own status->link_id. For a legacy
> (non-MLO) client on an MLO access point,
> ieee80211_release_reorder_timeout() passes link_id = -1 and
> ieee80211_rx_data_set_sta() never updates rx->link_id, so the adjust
> block evaluates rcu_dereference(rx->sta->link[-1]).
(...)

Note, in the future please do not Cc security@ once public lists are
already in Cc, as there is no need for private coordination anymore.

thanks,
Willy
