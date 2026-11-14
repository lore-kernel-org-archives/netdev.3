Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626042;
	b=wUj7qASbPo4BXkLyLVe07GErbsonEjTivKVWeYDr77+oK62k31wsvH2cFSgJ+Vu7h/iG
	 igu7g8ekukkaCtd3znLy93O+SJXrAEYuzucXy2VfDbS/poVlHwU2BGgtlYd+eV4QdNI3I
	 N4EMYFoprUieDQorr6Zr7yA8QQxZMtRf7R6gqgyUhCYFk7ooJzOsdzAtxWJ2VnNqbUYHL
	 OrYmBhSLgD8rvlVfBisAhmZjhFn6j/ByES4h/0bEmHjDrqI2uss+K4MSTnPn/PJzvcsph
	 GiNO5qYTnhMT43iFwAuHxPcMmVjcavV70torYVv19MjKeLFi92k8F6V02qkfh0HuJGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626042;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FKtAAVfNMBtdDOun0q+aZRlZBry8DYf1T2KDGjW+TD0=;
	b=ZWd3Ar+ndzZNc+czhwl+1eWV05djtvpMkfeD3aKb5ReBQs12zqmf9iIPMy59usnuZWfu
	 7ruz6ykt7nFboA4sjCVCwEPQB9pBuVZIM9SAF/h/Y+PAfA9+bC1xEm3MIZ4FpBqnzlupW
	 TBDEGot/9i0bAfzg3CZXHBQWfz8TNNeGJHED8PN76Ode+AUJqn/ZSpD4jwG4iJ2URlX/R
	 9/PMngAQFDDydsFzm3hClkeBLpAUegNNp8w4DvtLOnyPUbdnAETjibf437UK2f19fwyJI
	 u1DXkQXfQJyBYUI9z74BdGoZ5qJifvOn0aMnq2FOKaLsHtkk4pGowUcuf8Yi6jlXlYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeIucKOM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C5606A327;
	Sat, 14 Nov 2026 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeIucKOM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7592F1F000C4;
	Sat, 14 Nov 2026 03:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626041;
	bh=FKtAAVfNMBtdDOun0q+aZRlZBry8DYf1T2KDGjW+TD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TeIucKOMzI8X5GBiYa3bjYfTKSS7ohSu1mx5zfLshvLzb0yyDpMZIkoi+O5NhHljf
	 A0Aw/wvC9anU1NR58RfJEBuv8bobmliOGhVQoENBSQYcaWLzRFvcUV+376M8nlQQE1
	 4WkK9H8lfZ2xcB6ophmWCz5KgvT8kyBfek5QEjpJvIiTyMBNJGwiRq+PtT79PNNb2W
	 WqjxGxug7ngh/xlTaBwsBxv8RAHA+NzohbmZULJ743/RP9K0iChedSolkZwR5idgrE
	 h0wlOXQ/V/uOy6zBD1PiYqrla9FiU+9+qlD22QIpSIFXqayYfFYpHos4YO48vVfZb3
	 yRvDz2GkTvDAA==
Date: Fri, 13 Nov 2026 19:14:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
 <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <robert.marko@sartura.hr>,
 <horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v2 2/9] net: sparx5/lan969x: free the FDMA
 buffers on init errors and deinit
Message-ID: <20261113191400.2451b854@kernel.org>
In-Reply-To: <20261113075946.fptcvcesbmjlahpc@DEN-DL-M70577.microsemi.net>
References: <20261111-sparx5-mtu-change-v2-2-59c91357e8f6@microchip.com>
	<179450479633.2199510.4808333993834819818@kernel.org>
	<20261113075946.fptcvcesbmjlahpc@DEN-DL-M70577.microsemi.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 08:59:46 +0100 Daniel Machon wrote:
> > Would it work to set rx->page[fdma->dcb_index][fdma->db_index] = NULL
> > after page_pool_recycle_direct()? The poll loop would also need to
> > consume or refill that DB, or reuse the page in place, instead of
> > recycling the page while the DB still references it.  
> 
> I believe this issue is being addressed on net by Zhang Hewei [1]. I asked for
> changes on v3, but no response so far, so I see three options:
> 
>   1) Wait for Zhang to eventually post a v4.
>   2) Send a follow-up fix for this, in case Zhang does not.
>   3) Incorporate the fix in v3 of this series.
> 
> Either of these works for me, but as I dont know if a v4 is ever sent and how
> many respins that fix will require, it'll probably be fastest for me with 2) or
> 3)
> 
> BTW. The high severity issues on patch #6 and #9 have the same root cause as
> this. So my response to those are the same as this.
> 
> [1] https://lore.kernel.org/netdev/tencent_6BAC076E552C6F338052FC02794D9B28ED0A@qq.com/
> [2] https://lore.kernel.org/netdev/20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577/

Looks like the author respun twice since your response.
Let's wait for the fixes to make it to net-next, v5 conflicts with 
the changes you are making. Don't hesitate to post your own version
of the fixes if you prefer. I'd bet it's an LLM jokey blindly feeding
sashiko pre-existing issue reports into an LLM.
-- 
pw-bot: defer
