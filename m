Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784314;
	b=dJvNG4+VVCzV6gPfrKU6YM13Hq7h7LbLI/+b1odnoan0D4M1Zs/67hlXHVs2+aUeEqsr
	 /Cvz3VcQuaacgGO9IicfH8g5r2cc4O52tdKBu8kyV6ay4Q2kXWHC6fScRGmc9+p9j/Y6Y
	 Ut5K/13s0mcFX4U+NIyoCyF2p5x4j0YxmjTifvRrdUwF2pFTMrZCI0bk3Rrr1KUavllAI
	 CFJfbG7VMw6bgyXJqYf6jr+zKTALvUtcNkZLfOD915D2xaQldWUDYFa0dX1Svi6GRkDev
	 kzZDSK71fXQV6bQTYxomzvamYfh3pMqL0+SC3A/NZk1oT4EAMfEq1lyRGXR9g0vyjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784314;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cx7qmSkhV/UaCQ88PBaIvcJ8zQfIU4lsFxoG7lrd30Y=;
	b=v7m7XlrK61QhiZP9vevPxhj8pMp02CvvgqZfSb4FZb+/1oKKV9TtyZC1CLVWoUXvaRtJ
	 lnWVk/8qrA2RLOoBxU0baWh0+eiQJQAa7ncitz+zp8UXBt/BwK414oCxBTnVg1HKAhGdo
	 ZfM5yiNoO5FLuOoSiAz3VSR51HpS9+Yg55nYQuLPo2nYS1dDhuemRY5o6EcuL/br4Iq7X
	 V2YgfgRsFJFEYn8Evfm62GxzaEernrrXXZ93ls8E+ltJfZifH1S8PJYPz4oAlYDM8s11b
	 0WHscMChAHnN0P9V7goMhsYKaSYvLuGTsw6DM61Qm2xC6oa5ZQxSg1niiIZ3rn+apfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuzRSTMm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B0606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuzRSTMm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B473B1F031E1;
	Fri, 23 Oct 2026 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784313;
	bh=Cx7qmSkhV/UaCQ88PBaIvcJ8zQfIU4lsFxoG7lrd30Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WuzRSTMmbIP80hAYK4VgqnShwVDZoDEDv95N08kBha58+b8gbw2Bg92eStCeWK+D7
	 0LwqAQkG8SRJnK4A/rfLREsj4N4EIqd6ryHslN/FwSgdvT5IyzxpW+NL7LLXFGXfL4
	 l9sNzSeNVSePYaFX56SWqdr7YwWCip2AMLmZAj7p+VXELP3B7qL+TCMFUmaCbIQltK
	 YT9IageXtGvF9BvDo2LZx+1Q5hNJYREsufokNUquoUnOutQIxkgnJoBMxlHbxmGQ9S
	 ngmwtCYliTPTcRmXS5HlmD9m9NxDoWpeWAg2nAcHfYJivGTmV7PtZ/NHCqjMuTlgaz
	 pHPN3AzTDNsjw==
Date: Fri, 23 Oct 2026 12:38:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Smith, Cameron T" <cameron.smith@pnnl.gov>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: MAC Privacy Protection Protocol Driver Announcement
Message-ID: <20261023123833.406b1d4f@kernel.org>
In-Reply-To: <B6D98237-9AD5-479C-AC69-4D3F51C8D0A2@pnnl.gov>
References: <B6D98237-9AD5-479C-AC69-4D3F51C8D0A2@pnnl.gov>
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

On Thu, 22 Oct 2026 21:11:33 +0000 Smith, Cameron T wrote:
> I'm working on a Rust network driver for MAC Privacy Protection
> protocol (IEEE 802.1AEdk). There are a number of Rust abstractions
> within the `net` subsystem which need to be added to make this
> possible. These abstractions will need to be in place before my
> driver can be upstreamed, but will also be helpful for anyone else
> implementing network drivers in Rust.

I'm assuming you're writing it using an LLM, so I'd strongly prefer
if you just wrote it in C instead of adding a huge additional work
for maintainers of thinking thru Rust abstractions for datapath
drivers while we are overloaded with all the LLM fixes.
