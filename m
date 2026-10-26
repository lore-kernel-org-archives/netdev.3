Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026217;
	b=bEYIzk03dadpobC1BL/dnYao1NeMqN9IMDGTseg7wvPg+wsM8wapITrdhc5SMj6rQDkq
	 u0gEmAhWI8qCTjRn5oWVKNOPNEieFpNyIuyKNyFH8zCSuj+4Jm0BeivnTwzEy5ulxJ47P
	 ikWiHVkBxa6Ea6Z9ymKzgbU7NEZj7Pg68II1f5HFAFOSx+W/964K98389zRorlPVTaA5S
	 /+OiK3SVoWwQQ5vJ0k61+AlciM39q6wgD072PHPMKwG+tlFODqgsLahIkObZtWaWXqY3K
	 eZzmhJQS0h41SrIrhaaPJlKHz3yj80JKOPIWW6z1IQNrNsGFuW5Vxs6qci5KS6usvcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026217;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=p2Y0ewCR7R8xG92WWc1IJLfHg4RXwgJ2QKJmcFiaHq8=;
	b=w4Rv6+jVZoxSNE8lBpr9vkEx1xKzV0/tjnRVZm5rgnJYwZ/qHOcn2VnulQemVVp8DR0u
	 uVjnVX2ydZA8l0wTTDkDiGDoA8K/R3+dGzyf4scInMBztsybb/L8MBRq9nOI3U12gYZa4
	 KT1aDbIjVBvpf6NOk09QQMPqozZKqiAMDduk0oKE0PtHhTuFZusr8AjJpSVAJpqBXyjio
	 +jUIZw5TYXWm0N17ZXSZL5lhkJCXrh4I5B84GualLHLA5wSl8BIwQ3SdFHbZUsf0G0xGF
	 w6mKk549YLjC57V4ksLnV6una4ZG1P+Rxt3EYxJdtVuDQazC/JMFNIcVgq8LKZQHmCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADfa2vmw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A50606A31A;
	Mon, 26 Oct 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADfa2vmw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217BB1F01828;
	Mon, 26 Oct 2026 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026217;
	bh=p2Y0ewCR7R8xG92WWc1IJLfHg4RXwgJ2QKJmcFiaHq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ADfa2vmwrHaq6Cw87D7xoZlsX2o0pkNyxKUrI+5+vFM62gAyKxTly3E8ktnrWA+WU
	 NYTqhhfautYQKtvR7P88HhQy9YLndnsoXlLotl0O5mQcYzgddrn6wKpE8jfWW6HInS
	 VE8WGv6JW3tn5X4XRxemxhuCBg8ib4mIbu94Xq9V3SGSNv7hRsHAfICkAeehBVTail
	 5EDq9DGuYGqS/wivKYYztdku7NIySprHmMJQKDYRMNHNI4Tev4/YdQzMFE49oGJEgJ
	 1AHoaxq6qGCjkGYnM9IvIQC0zAtsDyuH98eV59fhKGytU+hY4DKSoWVvXmqgtJZRGe
	 ryb3znwlyQTrA==
Date: Mon, 26 Oct 2026 20:20:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>, Chris Lew <christopher.lew@oss.qualcomm.com>, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: qrtr: don't lose name server packets behind the
 HELLO gate
Message-ID: <at9n5CR6de3echo_@debian>
References: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>

Hi Igor,

On Mon, Oct 19, 2026 at 01:12:00PM +0200, Igor Opaniuk wrote:
> Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
> register") the core refuses every non-HELLO packet to a node until the
> HELLO to it has been sent, and retries a HELLO that cannot be sent yet
> 100 ms later. A freshly booted remoteproc has no glink rx intents, so
> the first HELLO fails, and the name server's announcements in that
> window (the replies to the remote's HELLO and the NEW_SERVER broadcasts
> of local servers) are dropped for good. The name server then also skips
> the lookup notifications for a server whose broadcast failed.
> 
> On QCM2290 (Arduino UNO Q) this stalls the modem in about one boot in
> five: it waits for the RMTFS service, which rmtfs registers in the same
> instant the modem starts, until its watchdog fires 40 s later; WiFi,
> whose firmware runs on the modem, comes up a minute late.
> 
> Patch 1 makes the name server carry on after a failed send (announce
> the remaining servers, notify the pending lookups). Patch 2 holds
> control packets for a node behind its HELLO and sends them right after
> it, instead of dropping them; data packets are still refused before the
> HELLO, so flow control is unchanged.
> 
> Initially tested on the Arduino UNO Q (QRB2210) with v7.3-rc6 plus the board
> support it needs: 10 fresh boots and 10 modem stop/start cycles, no
> "failed to announce new service", no modem watchdog, WLAN firmware up
> 6.4-8.2 s after boot every time; unpatched, 2/10 boots and 1/18 restarts
> stalled. Built with W=1 on net/main; applies to next-20261016.
> 
> I'm not deeply familiar with QRTR; an alternative would be to have the
> core trigger announce_servers() for the node once its HELLO is sent.
> Happy to rework it that way if preferred.
> 

Thanks for the series. There is already a patch floating [1] to fix the issue
you are trying to fix and it looks simple compared to this series.

But still, this series is useful, atleast patch 1. So you can resend this series
on top of v3 of [1] after fixing Sashiko's comments.

- Mani

[1] https://lore.kernel.org/netdev/20261022163116.1042-1-26rote@gmail.com

-- 
மணிவண்ணன் சதாசிவம்
