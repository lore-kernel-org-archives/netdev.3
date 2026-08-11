Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09212353A91
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434069; cv=none; b=HvORizWyBdmPXTC+8qx3dwftiHl48RfCz1CdG6Rr0cjYIgO/jdRlC+rq+4nIAuY7lzO/gdYyD5ACKZ+L8eNPQ58ZNAVvLOA8rqsjWj2npvkHtE75wrK6PKUvmP6CeeZOyB1+YlGTNRXJns8ErbQF084bOLhm2GF1ypcgcMPtNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434069; c=relaxed/simple;
	bh=OPjcoD+031kkG58HvNc6xKxazZLIHvqlbaz3CslhwTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGMrKYQTbij+pSSSXPtBwGopmdfU5ojFt4B0rnUy7N3u5dhKxMiCtoeUwVIZO/BiZRSuviIyUcmVV3IpWKd+YDsLAwYjKtQTyZVs4RpivgJ87xpa+X9pfuHmnfUrop/YHSRMawxFTN8l4YdllczsoE9G+7oKOpjYfKhzQIi6Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd+WnjSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd+WnjSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC6E1F000E9;
	Tue, 11 Aug 2026 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434067;
	bh=4On+8DEDnrJjsYrAwr1d7daNOJYY9/sJeosTMDZ0olQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cd+WnjSoKpXAkoLGSDvrdY18N4JypSh1VAU/psfZIazxWr8PvQqf4ZKZGLEPD80Ri
	 hv1qBkr5wIlk1zPkn6CllbDgpT7dlf6JNIsjkZFd4qvjEhlh2usTLss35TeVeqY6ac
	 vPirM3t/IHq1gUIyqiCK1JXfs7YbcNyxi7dWp708qwnv1VskMM/ye7L7sCEgI57nWs
	 NOHvtf+tJvY+YGzo6lV3olTQLPdHYPhukxwGHM0+r4QNkiD8sEIeQVpI1l7a/oZ6Sy
	 0ke3Xxg1Vy95+vZRh0NQTmJlSyEkHivjK1GBK/8DayEC4jmcDaYeAQe7m1IBAfpd3I
	 k++/3F2aL4fMg==
Date: Tue, 11 Aug 2026 08:41:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, 'Mengyuan Lou' <mengyuanlou@net-swift.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>,
	'Aleksandr Loktionov' <aleksandr.loktionov@intel.com>,
	'Rongguang Wei' <weirongguang@kylinos.cn>,
	'Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	'Larysa Zaremba' <larysa.zaremba@intel.com>,
	'Breno Leitao' <leitao@debian.org>
Subject: Re: [PATCH net v3] net: ngbe: fix NULL pointer dereference in
 non-MSI-X interrupt enabling
Message-ID: <20260811074102.GV51943@horms.kernel.org>
References: <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com>
 <20260810153900.GT51943@horms.kernel.org>
 <086b01dd2937$d65cf7e0$8316e7a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086b01dd2937$d65cf7e0$8316e7a0$@trustnetic.com>

On Tue, Aug 11, 2026 at 10:19:28AM +0800, Jiawen Wu wrote:
> On Mon, Aug 10, 2026 11:39 PM, Simon Horman wrote:
> > On Fri, Aug 07, 2026 at 02:22:14PM +0800, Jiawen Wu wrote:
> > > In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> > > not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> > > wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> > >
> > > This issue was introduced by fixing the IRQ vector when the number of
> > > VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
> > > determine the correct vector index.
> > >
> > > Additionally, as a side fix, set the interrupt mask to BIT(0) for the
> > > non-MSI-X fallback. In MSI/INTx mode, the MISC and queue interrupts
> > > share vector 0, and the WX_PX_MISC_IVAR register is only valid in the
> > > MSI-X case. Thus, BIT(0) is the correct mask for the miscellaneous cause
> > > when MSI-X is disabled.
> > >
> > > Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > Reviewed-by: Breno Leitao <leitao@debian.org>
> > 
> > Hi Jiawen,
> > 
> > I know the topic of BIT(0) came up in v2 - the AI-generated review
> > forwarded by Jakub. And I appreciate you clarifying things in the commit
> > message. But the AI generated review on netdev-qi [1] raises concerns which
> > I'd appreciate you looking over.
> > 
> > [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B2693E9A8BFAD110%2B20260807062214.410838-1-jiawenwu%40trustnetic.com
> > 
> > Although the review rehashes the concerns raised for v2, which you have
> > addressed.  There are three related areas of concern which I can't resolve in
> > my mind.
> > 
> >   1) The question of unmasking IRQ 0,
> >      and the implication of possible interrupt storms.
> > 
> >   2) Compatibility of the BIT(0) change in this patch with the implementation
> >      of wx_configure_vectors()
> > 
> >   3) Is there a need for any similar changes to txgbe.
> 
> 1) The hardware truth regarding WX_PX_MISC_IVAR and BIT(0):
> Sashiko assumes that in non-MSI-X mode, the MISC interrupt cause is mapped to
> BIT(1) because wx_configure_vectors() unconditionally writes to the
> WX_PX_MISC_IVAR register. 
> 
> In reality, on Wangxun hardware, the WX_PX_MISC_IVAR register is *completely
> ignored by the hardware* when MSI-X is not enabled. In legacy INTx or single
> MSI mode, the hardware forcibly merges all interrupt causes (both Queue and
> MISC) into a single bit: BIT(0) of the interrupt cause register. The
> configuration in wx_configure_vectors() for non-MSI-X mode is essentially dead
> code that has no hardware effect. Therefore, BIT(0) is the only correct mask to
> clear.
> 
> 2) Why it won't cause an interrupt storm:
> wx_intr_enable() clears the mask register to *allow* the next interrupt to be
> asserted, it does not force-trigger an interrupt.
> 
> Since Queue and MISC are physically bound to BIT(0) in this mode, if we do not
> unmask BIT(0) here, or mistakenly unmask BIT(1) (which the hardware never uses
> in this mode), the MISC interrupt will remain masked indefinitely. This would
> lead to lost MISC interrupts. The NAPI polling will still correctly handle the
> Rx/Tx cleanups without looping endlessly.
> 
> 3) Regarding txgbe consistency:
> txgbe suffers from the exact same conceptual bug in its non-MSI-X fallback path.
> I will be submitting a separate patch to fix txgbe as well.

Hi Jiawen,

Thanks for your detailed response. I agree that all is in order here.

Reviewed-by: Simon Horman <horms@kernel.org>

