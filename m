Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FC3B18A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485112; cv=none; b=TA2AoirI6b7lRgTCrCdLdq9SktchuGRAPo1f5QQtzLE7y4W6S++UgLGHuGKA+F36Qn2M6zNd0eR4NXrc1b+fu0FNreVcrfj76mPjyD5qJMO5tIpAXWt2lbVkFWzoUKF5ORbYsq3qtrtBU8WyclPFOj9kYxtix9rPlvn44lv7Cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485112; c=relaxed/simple;
	bh=8vPjg3CoqBcs/o54H5Vf1aTxSdxt4W4RWVAUCH4I6aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI12tHfdPVNXS5nR09tuq5pfJaP/vvOGG4ANofyx3yUENG6wubvRNg1GmBwAhtVIyKsA8NwlQDiEv66IyPHfMFOY6mVTQ6VL+1ulQz5TCBzVa9cA4qbV/+UEqreyklW9QGxzLwGtcuUftIj3ZaPsrgCaEGFYvzdsetIfYUgEQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1781485090tf91fe7e8
X-QQ-Originating-IP: xLI41NFzWkRT2aRHFAC33FpxRMLgIi+OcZRrqlM1O8o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 08:58:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3144052327750393400
EX-QQ-RecipientCnt: 12
Date: Mon, 15 Jun 2026 08:58:08 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	vadim.fedorenko@linux.dev, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v7 0/4] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <09A74B70DB12CF18+20260615005808.GA81014@nic-Precision-5820-Tower>
References: <20260611100036.36370-1-dong100@mucse.com>
 <20260612184436.GL671640@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612184436.GL671640@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Nl/za/qVmWHIX5Uuwlu1xnaNgV6FCqM+S8qXsDFjOBZegPDlDJce2Bl4
	JvdPxEQ+vrm12jA/qa6sn8MtZdnnbXVi1lpCIu3eDPC5tERWUV1UP39cXgH8s1kyw3pwq4o
	mNHSUnJz+G78FmTY17u+/aar+z4besDhA6d3fiT+FwczPYa730FXC1oEib3KEpNhvijVmxb
	nYHD4wYvpL6yOdrG2n5e6sFZCcMVFpnqXzU5aeWm45aw2Ub7tCwcsxtMUREiS4SYBgG+gBK
	LFYhtTC8tfNrr4B/gsPzgDQorjf17ESJsQPFKRppnffQiw+dtVraC4IfdXw2/uG0boXOnSm
	i+mIpYJQeyiNjMMRanNcx2t4892AxlH0YLblaTa0D4FKgfu5uYvZ4/dFifoe2JFUHQrmweO
	ovnsdTKPEqr6YTrQE3K9APCI2Td+/Otaui8u1EkwJ+jYfDlG1emejOiBsmEqA4ve2sM6HsV
	5/USQWpvDX735Ga4vS7sJkxyPvPxC4VGrS+U+jXquaNFHoA+xjanrR5X+uEV8/slfQ9e5oh
	G1hxXeO+rzUtGqU7saI1PWKjG12ViVwIwkDg6LtpdSqS1x6+ut6Cw/azImo/IhMHYDz/QZH
	rwNEALmz5h3db8pAUT35EgBOpFUoVilnWAeHmgvUvTJDrEyXYl2g1FUmLlUtSa7AOfL5DPa
	cqCHto3bTy2FUj/85ioj6GoQo+HVGaxETpU+bwFXJkft8dVThpMrxogFOuNuWnDFFJeE54G
	I2hjiKmaVjsdDayWZA55SF8sevFpxUrZ2lYCxRSyd4N5HLzgBi+EB8iJVTkZI0i5laz25bj
	BNsAMU1CjzBnhPHro4717WGcq6i4rpesIiSSqpDgJSBZO9bnTRZqI2YoS03NFAkfE5L5M5W
	ULD3QR6i2cNDfLVZWqmvAgW5Pwbtdd3XYKcDioMLkhaTWLPEd9Jrtix12ovx4G/FtWUew/V
	OVPfhuFsJ+TiMmEW2UeXvs8emDFrfsJxeY5bIn8A1WZQdnjn3I0uP4F9zib4DOBaA6DSkhN
	C9sYbb46JBfomWH/eD80alIWv9C5R2c/MW0llkSZfJD9Z0hDrjkBHLVeY62JQcD2hPa9fsD
	r2cVbiiWZtCG6BY+ZxhMaQ=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Fri, Jun 12, 2026 at 07:44:36PM +0100, Simon Horman wrote:
> On Thu, Jun 11, 2026 at 06:00:32PM +0800, Dong Yibo wrote:
> > Hi maintainers,
> > 
> > This patch series adds the packet transmission, reception, and link status
> > management features to the RNPGBE driver, building upon the previously
> > introduced mailbox communication and basic driver infrastructure.
> > 
> > The series introduces:
> > - Msix/msi interrupt handling with NAPI support
> > - TX path with scatter-gather DMA and completion handling
> > - RX path with page pool buffer management
> > - Link status monitoring and carrier management
> > 
> > These changes enable the RNPGBE driver to support basic tx/rx
> > network operations.
> > 
> > Changelog:
> > v6 -> v7:
> > [patch 2/4]:
> > 1. Fix 'frag_idx' error in rnpgbe_tx_map. (Sashiko-gemini)
> > [patch 3/4]:
> > 1. Fix skb leak in invalid size path in rnpgbe_clean_rx_irq.
> >    (Sashiko-gemini)
> > 2. Fix invalid size range check for rxdesc. (Sashiko-gemini)
> > [patch 4/4]:
> > 1. Fix 'data race on the reply payload'. (Sashiko-gemini)
> > 2. Fix 'asymmetric behaviour' when report up/down. (andrew)
> > 
> > links:
> > ---
> > v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
> > v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
> > v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
> > v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
> > v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
> > v6: https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
> > 
> > Additional Notes:
> 
> Thanks for the update and the notes.
> 
> There is another round of AI-generated review of this patch-set available
> on both https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> 
> I would appreciate it if you could look over that too. With a view to
> addressing any issues that directly affect this patch.
> 

Ok, I Will take a look at the AI review results on both sites and fix all
relevant issues pointed out for this patch.

> ...
> 
Thanks for your feedback.
