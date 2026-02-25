Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48278273D8D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985893; cv=none; b=V6nuhcLQaw1c/hVQrHxkuLET3x8CnIT9JUx4SLF8KD2+iCYtJeFrFaBwF1VPQ3h0wXHNhmwQxoumn4Edr/h3Xtk+tNdkljiqv8Os6kpTQ5xLK79oajK+gLBfyzkRYtZFPnJgKU0W5wfVdzP444d/ym6rOIzIWmsv31pBlgjmqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985893; c=relaxed/simple;
	bh=koEn24MdSI/LDateH21gj05ZN5t8MXb/Q7bk0NhGEDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLrloV6vFyrbv9N+5KRQ74VtTmrFB77lVvC4dPx8Pb+Sx/I+mxbcpsE7gK8Ryo63mNgCumxWO5J/h+kw4abmY5BDD16jhtRMeplrt3NfcK9Zj0gbbrIIaIc8OK6SsqfSQP4/dn99+eEU282EzmZ11nvKHW+FACSGzuhxxBPPVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R12LEGpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R12LEGpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78074C116D0;
	Wed, 25 Feb 2026 02:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771985892;
	bh=koEn24MdSI/LDateH21gj05ZN5t8MXb/Q7bk0NhGEDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R12LEGpoVZ4usUFdsXQlyBva25EGZb+B98lQOXagtsziw9WaEm/SF9gtZ4t6l/VFk
	 pxU3eSEckS97ptJ0k/biQMe/oMlB38EDRj9QS3HLF8hHOC+Onjt3Ssg4CmEQuzMQNC
	 tsA5E65lQ8lX4DXRZmLdCOgMM6EM7NsKGbfyXlEMG07Xl/xr9QhfwjTJOeCaqnrGtq
	 XPv7zRohxtMXM18spQuApMBRE6jy6xtI+gICqr5d0pxGvmu2pmIVE6NWopWFihQo2+
	 meVNcj8pppXjTctgqPHksh4TVTGOXIeG2v8C7l5ynHLNpjqdNfwAVgOnoTIc0WPWxw
	 JdirW4HxpE8Dw==
Date: Tue, 24 Feb 2026 18:18:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jose
 Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: ptp: limit n_per_out
Message-ID: <20260224181811.611e16cd@kernel.org>
In-Reply-To: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
References: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 12:20:47 +0000 Russell King (Oracle) wrote:
> +	if (pps_out_num > STMMAC_PPS_MAX)
> +		pps_out_num = STMMAC_PPS_MAX;

How would you feel about tossing a dev_info() / dev_warn() in here?
If nothing else if will prevent script kiddies from sending a patch
converting this if to

	pps_out_num = min(pps_out_num, STMMAC_PPS_MAX);

which presumably you don't prefer.
