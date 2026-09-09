Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CB286881
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917756; cv=none; b=s0mSWeOuZSqbZmu6ETu/S77Ci4PfnN7eMUG0PGTBj1+Sd0fSXJapAPL+o0PntH6hQJ1qoECz82EuYhbtTbijunJbQZWRAHXMtXCwCBekuEUnKNtd0u7whlcqWEW16RTO1MOMbVauXF4dGXOeJdTdsucJ+GxWkdh8sRA1FB2ecWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917756; c=relaxed/simple;
	bh=CccU9QzYwaaDL7ofceXGpgLIqtr3ykUiJUd00SbpWWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcV6NmWSKHfq6hGx8a5aZT2NEdxON4w/7YzNClXUaadzV9WMPg3qJTymgCHE1gGvy6VcofYzJBHC569AVWHXSopMz+Bope5x1Zv8UkJlmMw9hASneBBfUVb+fa4BFFNNRo0qBZiNtFmlrLP5df9qF1rVxhAe4e+g6plZT9S8E88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nitcr9Ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nitcr9Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67E1F00A3D;
	Wed,  9 Sep 2026 01:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917755;
	bh=s9uYx/37ho+cFtcOGygmvTcxEv9p065hqpHDOll9q+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nitcr9Ce2oKpPvjWbKlDUICtbcxBPgWi+AN9UTkIpb0+HD99EVpHzbT8wByXcgh5J
	 i+SGY/THaXtCHTjFsU8XssU/CCVt1/xYABBoE0f9OYTmLu0UPRclX7U84HBYvd+AuE
	 G08Ut5NaBnY6i7alzzERADzerBJv6gxlaiAJWEarV+DPHwr69kr+30Dtcrvyq0HI0O
	 AOayYzuSur7IiBU7mTTJLtuwtY9i+94tyJ2VKcOG38rsJpdCtjWAFpE8AlOXDdJEnN
	 JW9hBev2c1W4t/JUlr7jcy+7Z0zvVIVUJTbmC0iYc3eg5ZfnwML0+Y8irfFnd0HwSX
	 TWwOJSfXQWYIQ==
Date: Tue, 8 Sep 2026 18:35:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev-bot+sashiko@kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 0x1207@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: preserve real_num_tx_queues on mqprio
 setup failure
Message-ID: <20260908183553.7a204e81@kernel.org>
In-Reply-To: <ap_fm9S7zSAbGSKq@lore-desk>
References: <178885859069.219967.17905742130775758644@kernel.org>
	<ap_fm9S7zSAbGSKq@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 12:12:43 +0200 Lorenzo Bianconi wrote:
> > So dev->num_tc goes back to 0 immediately after the driver restored it, and
> > skb_tx_hash() ignores tc_to_txq and prio_tc_map when num_tc is 0.  On a
> > failing "tc qdisc replace" over an already offloaded mqprio, does the still
> > grafted old qdisc lose its priority classification anyway?  
> 
> I think in a error condition, the driver is supposed to restore the previous
> overwritten values, then it is up to qdisc layer to manage the error condition.

I'd translate all the AI complaints to a basic confusion about what
exactly is the problem you're fixing and how it can be triggered.
A better commit message may be sufficient. An example of sequence of
tc commands which used to lead to loss of config / broken device and
now does not would go a long way.

> > For taprio, the new error also takes the disable label, which clears
> > priv->est->enable and reprograms EST, so the schedule that was just
> > installed is torn down.  Is that intended for configurations that used to be
> > accepted, for example:
> > 
> >   tc qdisc replace dev eth0 root taprio ... queues 2@0 2@2 ... fp E P
> > 
> > Also, the two remaining users that still ignore the now meaningful return
> > value, the taprio disable path and stmmac_reset_tc_mqprio(), were not
> > updated.  Should they be?

This sounds relevant as well.
