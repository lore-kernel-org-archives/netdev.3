Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C7468C28;
	Thu, 24 Sep 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267453; cv=none; b=fb1ayPgxULJUl5AozT8hvr7MRe8a1YguEn3+NcQoezTh79y5WDLB+lrq3oECjKOjcvKkR/2JaYIE9nYGM/HkxMyW5iftxWov9JyAHBS3fCGg2eIo99hb9l8UzviswAYWupPoCyXjqNaMbrAsWmOow1jeyPnCp/U6CNJvkP1k7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267453; c=relaxed/simple;
	bh=VRNBHSIWdwtv4h7puBfeFolZ0hxEXRrTi9PpmBCxHIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek8zX6rvmJtDY3x04kpzAht1vvf1i5UjO6iG4P8C8hEPYXnd9yoznRmJ8J003n33iZ05Dbg3qngIibCcKwU5qvV5UGBvGnza1Vrm5YHdQDjClHies2Sn+WnWiAnEopuu4xCpu3EBR2VjIOlFNyWRJdAjBXQNRXICZ1TYdJZk2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luNjR/p6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luNjR/p6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977C31F000FF;
	Thu, 24 Sep 2026 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267452;
	bh=4X2jrfez8+9jMVqiE2XvaHZSBVJggR4QyEv+6Cs3MIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=luNjR/p6QZfdYSMeTKfOfEjkWtfZEIXLTqEOLk1LLNcwP1EHgCq/YTlfYu8vSS1lN
	 OTN1Ayc/C7l/cCLNKUnVHDl2na81EvFGKg2yDoVUEsCaqoPJ9f04ufXCX/sHqODs1V
	 ARlk2pXlgYJ1ZjJj6+L6gXwwSHuMBIAmzOYfHjw9dfSEeNzfDlD8UVpm4gfXO53oGP
	 4yQZzHtrjCAaI0ySWLsGsWic6YiaK26cnkf9bElT0RoLsK3HsXzjdOP86yVySVUirF
	 9D8auDCzcKImbfKH/dpFTwL9YaJj39oJDesIBtUJYPw+nU4N+PIaaat6V/jK+RHlnu
	 gYvcK/2LdVpJw==
Date: Thu, 24 Sep 2026 09:30:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: maxime.chevallier@bootlin.com, recv.jo@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, jun.ann.lai@intel.com, yi.fang.gan@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Message-ID: <20260924093051.71e9cf52@kernel.org>
In-Reply-To: <20260920153516.103461-1-ovidiu.panait.rb@renesas.com>
References: <20260920153516.103461-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 15:35:11 +0000 Ovidiu Panait wrote:
> Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
> hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
> than using the actual protocol from the packet. Because of this, packets
> that contain an 802.1ad outer tag are incorrectly passed up the stack as
> having an 802.1Q tag.

Failed to apply patch:
Applying: net: stmmac: Remove VLAN perfect matching dead code
Applying: net: stmmac: Stop toggling the EDVLP bit
Applying: net: stmmac: Rename double VLAN references to svlan
error: sha1 information is lacking or useless (drivers/net/ethernet/stmicro/stmmac/hwif.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0003 net: stmmac: Rename double VLAN references to svlan
-- 
pw-bot: cr
