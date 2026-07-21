Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43C3E008A;
	Tue, 21 Jul 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653637; cv=none; b=MGnZfdHamaX6lbChn3enIP1kb4HwMx7JzccTzMwVY55EdqFo8JiX0EQi8JB+YILWx+0Ui9ymD4BkXsElp2+m2W29a7ms6xvlchX7cicLj6UCVqrTKGDVUckV+MQmrYC9cKAicOC2zwCbl26ezEfJ/qeLKWcBWg7blXhzNlZR8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653637; c=relaxed/simple;
	bh=4rZPySlm1kJx2jgOID9EdUExj2LM9FU2gvnkJtA8SN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+/WL8ewqva5mw2LNaCl1EDxmbRn5V0kxX6xwoP9X4YQnUEbMiky18+OPzNwnUZMzEpAy7L1leKywbG18+u/PuPrSWxdd1ptY1fjBE0nGYAVXrc4manmDDM1MYmiLDHeT+SW7Hg4xif04KxcxiYhA67tF0wfdVomMYXvzXr/K7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWRj5Vad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWRj5Vad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5371F000E9;
	Tue, 21 Jul 2026 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653636;
	bh=No86Rgbsfe8g6CBup7wiU+il6SjDU6UqnELCDaKqTuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oWRj5VadivhKeCptOTEc5fBXR2+XHQra9EBMUrkjH0MyiXOqHUnabiWlcW8BkulnW
	 OpAUtPRQZ+o/fXj+mJy+qBfmcPGAC+e0CbldIGD7Tub64UofhtKQ5P+6bvGdO7wof0
	 yUM5oA2ulQWdoc1rI1AwWa86C3q5t0IKdPbAb2usbvOa8hPH9fqwEBVpgPKOTMBpzl
	 cfLeQxH5zJn80gaCz/1cSfn4WdF9QwzSg8y15bNrvx1uuHwgPLPZPgdQY/Mm1RD8wo
	 mR5fcRruLYTC1Vn3IV8VKefJwAFPB7OTWuzqAMPezyplhXLAnRamQ9vIGbxfZLNKOU
	 fiPK/EiT5OcKA==
Date: Tue, 21 Jul 2026 10:07:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tim Gebauer <tim.gebauer@tu-dortmund.de>, Brett
 Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260721100715.5b43412d@kernel.org>
In-Reply-To: <20260721105853-mutt-send-email-mst@kernel.org>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
	<20260714092506-mutt-send-email-mst@kernel.org>
	<5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
	<5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
	<20260721105853-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 10:59:52 -0400 Michael S. Tsirkin wrote:
> > > I prefer applying it, but you maintainers must decide that.
> > 
> > Hi,
> > just a gentle ping.
> > Has there been any decision on this patch?
> 
> Hi netdev maintainers. Given there's a perf regression otherwise,
> we should either take this or revert the original and reapply
> in next.

Revert, please. We were AFK and are now working thru a backlog
of 1k patches. The new IFF_* flag needs scrutiny we can't afford
at present.
