Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20045284B2F;
	Sat,  7 Mar 2026 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845453; cv=none; b=AwB/yFBPrGf8NvPQFBIPgaPsd9iz524aLxkGAvRl/3GCnPfkDsCM8BX7AW0pTvK5EyCsL6BnHgVFRltcluxbu+Hm+RqlXtZGeFQnBZAb/O1HUbu4n5Hb55cL4KUS7tCEoJWDPXJgQ4bn8nZp0lZdTMSiCBc9CgbrC7d99s0/1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845453; c=relaxed/simple;
	bh=QcYejuNXCN3pAPbk2hDmY8EAb24Vn+iam/tjxfo247o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHt6/4qvOqYEQqUiXxFASUyKq7KUWLadRT30tgXa/1K7ySeLYkg03JBp9Aob9eu0NFlLkLxDloXZBaGKotUngr9f2mBGQvzLoEXvNkvq7relQnDUOtri42OWDG0UYAUfyadqj+SatPE5CptTZ5BcDvIvqU8/E9HORkQs0N8lveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg+bQZXT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg+bQZXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27705C2BC9E;
	Sat,  7 Mar 2026 01:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845452;
	bh=QcYejuNXCN3pAPbk2hDmY8EAb24Vn+iam/tjxfo247o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jg+bQZXTCBrIVFPaV9pjLsrYQtBPtQcMzIWsEbtmbhj+500mWoCypoUuRJD/ufmo+
	 OXx/KSLsIKeX+IlSudBOqBUe3lTsPonSyJvqkAFr+hkodxVIgiRxGek5aCJi5Ufdfw
	 V4Qo9qhBxGBLl+PcR4QviIR2kQvVg3nzkqsI8fYDCL0tU6aHEvruOF8JB9J1hD9bTh
	 OK5ExrfNgrHluIXHYdvEp/gQlu466olkRH1j8zOZbWaRmQ6sQwTtekgCCzCy6DWrBi
	 OYgcPLwyk08PwKne0knvZljg+aWILeOgobUSaZx2QfPkpmBcIoKLpH5AhuDZ78huxf
	 zaN1YBPFEvrCQ==
Date: Fri, 6 Mar 2026 17:04:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-ppp@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
Message-ID: <20260306170411.49912ae1@kernel.org>
In-Reply-To: <20260305013852.3769-1-dqfext@gmail.com>
References: <20260305013852.3769-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Mar 2026 09:38:52 +0800 Qingfang Deng wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> Only handles packets where the pppoe header length field matches the exact
> packet length. Significantly improves rx throughput.
> 
> When running NAT traffic through a MediaTek MT7621 devices from a host
> behind PPPoE to a host directly connected via ethernet, the TCP throughput
> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
> using fraglist GRO.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Please add some selftests.
-- 
pw-bot: cr
