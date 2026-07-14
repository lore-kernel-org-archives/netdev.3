Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C036404B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033013; cv=none; b=o+PaZolk9faSoat3VpUzPO0FjWDruqqoLYhU5W3GmI8yGf92pqh8HE/Uvw3DN0fFH77Q2iJKzLVcBCpIpcON5blI7DP3CfGtgOjuNo2T9uY2pfwW51KC+bX5t8YXGjpxalvhkfT2pfCQYFQ3mHwY5ntBcuQ3JQB6onbqSQJQwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033013; c=relaxed/simple;
	bh=DoBlsJBMV+ydLQIRle1rjneEXEPQd9FDvvSvjECBnjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK35tXkm781mNsWJLnIK82XnCJnGL/ppF6FyhEW8fGXo5ggTAfzYNRjmjHkktoymrDp3lX8WjU+vCRJzHQgSeeZstkAaPT0/s7KX0gMbEwr72s8lDluEgzRVQeGkdi5A+q3gfgip9ZM9S1u98wlBVXuIyWimwo2tMSSG66f8ImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3z4fMr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3z4fMr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916281F000E9;
	Tue, 14 Jul 2026 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033011;
	bh=uDuJzr30NAJlJiPFtUSwPwG1ACdjUZ2KotIIPHp9q54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3z4fMr6YW8/gKFJNOklBhP/5QHWLH+5FioqyN7UMdD8PVpGIoyCJpuAKuH97dhMD
	 35+7s2wV31ELe175wsrIJNMpRthd/JbxDbCQvFWco4FSaKSUfJd83h7X1j/E7xDcdm
	 6vSSkaYeZodBN7h/DZ60TCIfPy6EZBILeCh4ooSI4wpBe2/8k8MhbZJpPBc6riAmNX
	 3erVnpBel8lVTy/egpqG07XnVFzo5nmv0RdaFesxM7UIWl4rGMGx4ok4bqGfF36LX5
	 2h+uPjYHJFBBNNv7eqNYZqQmQ1J11TC84ENI3pJ2QbJsuujt7h3yVgzNm7SK4sYfrv
	 rzDTJgFzAbdtQ==
Date: Tue, 14 Jul 2026 13:43:27 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au,
	Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next v3 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
Message-ID: <20260714124327.GJ1364329@horms.kernel.org>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-6-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706193603.8039-6-mmc@linux.ibm.com>

On Mon, Jul 06, 2026 at 12:35:53PM -0700, Mingming Cao wrote:
> Queue 0 and subordinate RX queues use different interrupt control
> interfaces in PHYP:
> 
>   - queue 0: h_vio_signal() after h_register_logical_lan()
>   - queue N: H_VIOCTL against the queue handle/hwirq mapping
> 
> The current code is single-queue oriented and cannot safely scale to
> multiple RX queues in poll completion and open/close IRQ setup.
> 
> Introduce queue-indexed interrupt helpers:
> 
>   ibmveth_enable_irq(adapter, queue_index)
>   ibmveth_disable_irq(adapter, queue_index)
>   ibmveth_setup_rx_interrupts()
>   ibmveth_cleanup_rx_interrupts()
> 
> These helpers centralize queue0-vs-subordinate dispatch and make IRQ
> lifecycle symmetric across open/close and future resize paths.
> 
> request_irq() is wired with &adapter->napi[i] as dev_id per queue, so
> interrupt ownership follows the NAPI instance that services that RX
> queue.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

Although it is added later in this patch set, I believe linux/irqdomain.h
needs to be included in this patch so that irq_dispose_mapping is defined.

Also, I think it would be best to add these helpers in the same patch(es)
that they are first used.  As this will avoid temporal compiler warnings
about declared but otherwise unused functions. Similarly for patch 13/15.

Overall, please make sure that when each patch of the series is applied
no new warnings or errors are introduced for allmodconfig W=1 builds.

FWIIW, I exercised this using gcc 16.1 from
https://www.kernel.org/pub/tools/crosstool/

...

-- 
pw-bot: changes-requested
