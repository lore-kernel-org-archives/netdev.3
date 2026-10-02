Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD512CDBE;
	Fri,  2 Oct 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905097; cv=none; b=CvAe98NCUCeEbyyHfT7r904OZSIqRJE7NOonWC9wiem5Pw7P1kWw9alz02i6hSb2u+wH6VWQH3UIpgDj2ElHrqrOJRovymVEwR7Lsyl2w05KEy+oE+LnIPGz9Q90UkyJOzlewC2UxAfqY3JQA0PJ4Crav/BzbjB6Pkm77ry10jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905097; c=relaxed/simple;
	bh=v6GHEpiGLF8N69+xs/UUWcpXT+bjvE+LtzjIohRLicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UajGrlZWuCIZCyGpo1UGsfMX5+/5O/RgH9r/mKtAva7n5y3nvFLIcOa2iUgeOLLbsfMialN9KJe7kqhghHARB0qFu2INvyLJqLnCFB2ndR0t197Yw2izcyiEaH8ZKSxnXYq+6GoXWopi4p1IKAsN2fdiMi+vLz1Py56XPmoUTvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE+sN2TA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE+sN2TA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F89F1F000FF;
	Fri,  2 Oct 2026 01:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905095;
	bh=AXwN6JZC/WUQTMfBHr3Bd3LnHkUTM43nLhov5HUpSdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DE+sN2TAacbTJs2xtAspJ10UZCCgqos8nV2XVEF9omhMF/RjqmZ9vQZEuG1lS2+Z4
	 xxqQP+CzvQcIi87eHsMwsE/RPGzhftCF0LK241GOYoWgb4RO0JgiiVne+CpVqatrXG
	 xlROJAFQ2n1btiU4ixnzxy6q9S5TQpoJKNfm138TMxGJPAfLGiUXSc3gB9QoS6saVZ
	 3gddjaFum3v4I13xuXefCJNKfKIpvDCNl6z2rIkNlin0F6xveIA/Avtv8r2KUaGgKn
	 mg1uA6aR83lb5lutb+MRNa6kSAJtqW/ooePFA3Lfryq7O2GW3CHYrPzorQUFyGaCCT
	 g/oRds0mdPcvw==
Date: Thu, 1 Oct 2026 18:38:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, radhey.shyam.pandey@amd.com,
 michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, robert.hancock@calian.com, sean.anderson@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: axienet: cap the TX poll return value at
 the NAPI budget
Message-ID: <20261001183814.4e9e88e6@kernel.org>
In-Reply-To: <20260930071536.627964-1-maimon.sagi@gmail.com>
References: <20260930071536.627964-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 10:15:36 +0300 Sagi Maimon wrote:
> @@ -1027,7 +1027,12 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>  		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
>  		spin_unlock_irq(&lp->tx_cr_lock);
>  	}
> -	return packets;
> +
> +	/* The whole ring was reclaimed above, which may be more than the
> +	 * budget, but a poll must not report more work than it was given.
> +	 * netpoll polls with a budget of 0 and expects no work reported.
> +	 */
> +	return min(packets, budget);

Please take a look at commit a58cdf56b6e, that's the correct approach
(incl. feeding 0 to napi_complete_done).
-- 
pw-bot: cr
